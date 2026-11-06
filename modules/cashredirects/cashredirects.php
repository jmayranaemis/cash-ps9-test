<?php
/**
 * Cash Alimentaire - Redirections 301 des anciennes URL (avant migration PrestaShop 9).
 *
 * Avant le 9 octobre 2026, le site utilisait les routes PrestaShop par défaut, avec ID :
 *   produit     /{categorie}/{id}-{rewrite}.html
 *   catégorie   /{id}-{rewrite}
 *   marque      /brand/{id}-{rewrite}
 *   fournisseur /supplier/{id}-{rewrite}
 * Les nouvelles routes n'ont plus d'ID. Ce module intercepte les anciennes URL avant le
 * routage et renvoie une 301 vers l'URL canonique actuelle :
 *   1. par ID quand l'objet existe toujours (cas majoritaire, les ID ont été conservés) ;
 *   2. sinon par correspondance du libellé (rewrite) avec le catalogue actuel ;
 *   3. sinon vers la catégorie (produits) ou la page liste (marques, fournisseurs) ;
 *   4. sinon la requête continue normalement (404).
 * Aucune URL actuelle n'est touchée : les motifs ci-dessus n'existent plus dans les routes en place.
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

class CashRedirects extends Module
{
    /** Score minimal de ressemblance (Jaccard sur les mots) pour accepter une correspondance par libellé. */
    const MATCH_THRESHOLD = 0.6;

    public function __construct()
    {
        $this->name = 'cashredirects';
        $this->tab = 'seo';
        $this->version = '1.0.0';
        $this->author = 'M2J Expertise';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = ['min' => '8.0.0', 'max' => '9.99.99'];
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Cash - Redirections anciennes URL');
        $this->description = $this->l('Redirige en 301 les URL de l\'ancien site (avec ID) vers les URL actuelles.');
    }

    public function install()
    {
        return parent::install() && $this->registerHook('actionDispatcherBefore');
    }

    public function hookActionDispatcherBefore($params)
    {
        if (!isset($params['controller_type']) || (int) $params['controller_type'] !== Dispatcher::FC_FRONT) {
            return;
        }
        $method = isset($_SERVER['REQUEST_METHOD']) ? $_SERVER['REQUEST_METHOD'] : 'GET';
        if ($method !== 'GET' && $method !== 'HEAD') {
            return;
        }

        try {
            $target = $this->resolve($this->getRequestPath());
        } catch (\Throwable $e) {
            return; // Ne jamais casser une page pour une redirection.
        }

        if ($target) {
            $this->redirect301($target);
        }
    }

    /**
     * Chemin demandé, sans base URI ni query string, décodé.
     */
    protected function getRequestPath()
    {
        $uri = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '/';
        $path = (string) parse_url($uri, PHP_URL_PATH);
        $path = rawurldecode($path);
        $base = rtrim(__PS_BASE_URI__, '/');
        if ($base !== '' && strpos($path, $base) === 0) {
            $path = substr($path, strlen($base));
        }

        return '/' . ltrim($path, '/');
    }

    /**
     * Calcule l'URL cible pour un ancien chemin, ou null s'il ne s'agit pas d'une ancienne URL.
     */
    public function resolve($path)
    {
        $idLang = (int) Context::getContext()->language->id;
        $link = Context::getContext()->link;
        $m = [];

        // Correspondances explicites (pages supprimées ou renommées), voir legacy_map.php
        $map = $this->legacyMap();
        if (isset($map['paths'][$path])) {
            return $this->absolute($map['paths'][$path]);
        }

        // Produit : /{categorie}[/...]/{id}-{rewrite}.html
        if (preg_match('#^/((?:[a-z0-9-]+/)*)(\d+)-([a-z0-9-]+)\.html$#i', $path, $m)) {
            $idProduct = (int) $m[2];
            $rewrite = strtolower($m[3]);
            $oldCategory = trim(strtolower($m[1]), '/');

            if ($this->isProductVisible($idProduct)) {
                return null; // PrestaShop redirige déjà ces URL (301 canonique) : on ne change rien.
            }
            $id = $this->matchByRewrite('product', $rewrite, $idLang);
            if ($id) {
                return $link->getProductLink($id, null, null, null, $idLang);
            }
            // Produit supprimé : catégorie du produit si elle existe encore, sinon ancienne catégorie de l'URL.
            $idCategory = $this->productDefaultCategory($idProduct);
            if (!$idCategory && $oldCategory !== '') {
                $segments = explode('/', $oldCategory);
                $idCategory = $this->legacyCategoryId(end($segments), $idLang);
            }
            if ($idCategory) {
                return $link->getCategoryLink($idCategory, null, $idLang);
            }

            return null;
        }

        // Catégorie : /{id}-{rewrite}
        if (preg_match('#^/(\d+)-([a-z0-9-]+)$#i', $path, $m)) {
            $full = strtolower($m[1] . '-' . $m[2]);
            if ($this->isCurrentRewrite($full, $idLang)) {
                return null; // URL actuelle qui commence par un nombre : ne pas toucher.
            }
            $idCategory = (int) $m[1];
            if (!$this->isCategoryVisible($idCategory)) {
                $idCategory = $this->matchByRewrite('category', strtolower($m[2]), $idLang);
            }
            if ($idCategory) {
                $url = $link->getCategoryLink($idCategory, null, $idLang);
                $page = (int) Tools::getValue('page');
                if ($page > 1) {
                    $url .= (strpos($url, '?') === false ? '?' : '&') . 'page=' . $page;
                }

                return $url;
            }

            return null;
        }

        // Marque : /brand/{id}-{rewrite}
        if (preg_match('#^/brand/(\d+)-([a-z0-9-]+)$#i', $path, $m)) {
            $id = (int) $m[1];
            if (!$this->isActive('manufacturer', $id)) {
                $id = $this->matchByName('manufacturer', strtolower($m[2]));
            }

            return $id ? $link->getManufacturerLink($id, null, $idLang) : $link->getPageLink('manufacturer', true, $idLang);
        }

        // Fournisseur : /supplier/{id}-{rewrite}
        if (preg_match('#^/supplier/(\d+)-([a-z0-9-]+)$#i', $path, $m)) {
            if ($this->matchByName('supplier', strtolower($m[1] . '-' . $m[2]))) {
                return null; // Fournisseur actuel dont le nom commence par un nombre.
            }
            $id = (int) $m[1];
            if (!$this->isActive('supplier', $id)) {
                $id = $this->matchByName('supplier', strtolower($m[2]));
            }
            if ($id && Configuration::get('PS_DISPLAY_SUPPLIERS')) {
                return $link->getSupplierLink($id, null, $idLang);
            }
            // Pages fournisseurs absentes du nouveau site : marque correspondante, sinon liste des marques.
            $idManufacturer = $this->matchManufacturerByTokens(strtolower($m[2]));

            return $idManufacturer ? $link->getManufacturerLink($idManufacturer, null, $idLang) : $link->getPageLink('manufacturer', true, $idLang);
        }

        // Page CMS : /content/{id}-{rewrite}
        if (preg_match('#^/content/(\d+)-([a-z0-9-]+)$#i', $path, $m)) {
            $id = (int) $m[1];
            if ($this->isActive('cms', $id)) {
                return $link->getCMSLink($id, null, null, $idLang);
            }

            return null;
        }

        // Catégorie CMS : /content/category/{id}-{rewrite}
        if (preg_match('#^/content/category/(\d+)-([a-z0-9-]+)$#i', $path, $m)) {
            $id = (int) $m[1];
            if ($id > 1 && $this->isActive('cms_category', $id)) {
                return $link->getCMSCategoryLink($id, null, $idLang);
            }

            return null;
        }

        // Ancienne liste des marques
        if ($path === '/brand' || $path === '/brand/') {
            return $link->getPageLink('manufacturer', true, $idLang);
        }

        return null;
    }

    protected function legacyMap()
    {
        static $map = null;
        if ($map === null) {
            $file = __DIR__ . '/legacy_map.php';
            $map = file_exists($file) ? (array) include $file : [];
            $map += ['paths' => [], 'categories' => []];
        }

        return $map;
    }

    protected function absolute($target)
    {
        if (preg_match('#^https?://#i', $target)) {
            return $target;
        }

        return rtrim(Context::getContext()->link->getBaseLink(), '/') . '/' . ltrim($target, '/');
    }

    /**
     * Marque active dont le nom partage le premier mot significatif du libellé fournisseur
     * (ex. "pasquier-patisserie" => marque "Pasquier"), avec un score suffisant.
     */
    protected function matchManufacturerByTokens($rewrite)
    {
        $tokens = $this->tokens($rewrite);
        if (!$tokens) {
            return 0;
        }
        $rows = Db::getInstance()->executeS(
            'SELECT id_manufacturer AS id, name FROM `' . _DB_PREFIX_ . 'manufacturer` WHERE active = 1'
        ) ?: [];
        $best = 0;
        $bestScore = 0.0;
        foreach ($rows as $row) {
            $mt = $this->tokens(Tools::str2url($row['name']));
            if (!$mt || $mt[0] !== $tokens[0]) {
                continue;
            }
            $score = $this->similarity($tokens, $mt);
            if ($score > $bestScore) {
                $bestScore = $score;
                $best = (int) $row['id'];
            }
        }

        return $bestScore >= 0.3 ? $best : 0;
    }

    protected function redirect301($url)
    {
        $current = $this->getRequestPath();
        $targetPath = rawurldecode((string) parse_url($url, PHP_URL_PATH));
        if ($targetPath === $current) {
            return; // Pas de boucle.
        }
        header('HTTP/1.1 301 Moved Permanently');
        header('Location: ' . $url);
        header('X-Redirect-By: cashredirects');
        exit;
    }

    protected function isProductVisible($idProduct)
    {
        if ($idProduct <= 0) {
            return false;
        }
        $row = Db::getInstance()->getRow(
            'SELECT ps.active, ps.visibility FROM `' . _DB_PREFIX_ . 'product_shop` ps
             WHERE ps.id_product = ' . (int) $idProduct . ' AND ps.id_shop = ' . (int) Context::getContext()->shop->id
        );

        return $row && (int) $row['active'] === 1 && $row['visibility'] !== 'none';
    }

    protected function productDefaultCategory($idProduct)
    {
        $id = (int) Db::getInstance()->getValue(
            'SELECT ps.id_category_default FROM `' . _DB_PREFIX_ . 'product_shop` ps
             WHERE ps.id_product = ' . (int) $idProduct . ' AND ps.id_shop = ' . (int) Context::getContext()->shop->id
        );

        return $this->isCategoryVisible($id) ? $id : 0;
    }

    protected function isCategoryVisible($idCategory)
    {
        if ($idCategory <= 2) {
            return false; // 1 = racine, 2 = accueil
        }

        return (bool) Db::getInstance()->getValue(
            'SELECT 1 FROM `' . _DB_PREFIX_ . 'category` c
             INNER JOIN `' . _DB_PREFIX_ . 'category_shop` cs ON cs.id_category = c.id_category AND cs.id_shop = ' . (int) Context::getContext()->shop->id . '
             WHERE c.id_category = ' . (int) $idCategory . ' AND c.active = 1'
        );
    }

    protected function isActive($entity, $id)
    {
        if ($id <= 0) {
            return false;
        }

        return (bool) Db::getInstance()->getValue(
            'SELECT 1 FROM `' . _DB_PREFIX_ . bqSQL($entity) . '` WHERE `id_' . bqSQL($entity) . '` = ' . (int) $id . ' AND active = 1'
        );
    }

    /**
     * La chaîne est-elle le rewrite d'une catégorie, d'une page CMS ou d'une page système actuelle ?
     */
    protected function isCurrentRewrite($rewrite, $idLang)
    {
        $db = Db::getInstance();
        $r = pSQL($rewrite);

        return (bool) $db->getValue('SELECT 1 FROM `' . _DB_PREFIX_ . 'category_lang` WHERE link_rewrite = \'' . $r . '\' AND id_lang = ' . (int) $idLang)
            || (bool) $db->getValue('SELECT 1 FROM `' . _DB_PREFIX_ . 'cms_lang` WHERE link_rewrite = \'' . $r . '\' AND id_lang = ' . (int) $idLang)
            || (bool) $db->getValue('SELECT 1 FROM `' . _DB_PREFIX_ . 'meta_lang` WHERE url_rewrite = \'' . $r . '\' AND id_lang = ' . (int) $idLang);
    }

    /**
     * Ancien libellé de catégorie présent dans l'URL produit ("frais", "surgele"...) vers ID de catégorie.
     * Table de correspondance ancien libellé => nouveau rewrite dans legacy_map.php.
     */
    protected function legacyCategoryId($oldRewrite, $idLang)
    {
        $map = $this->legacyMap();
        if (isset($map['categories'][$oldRewrite])) {
            $oldRewrite = (string) $map['categories'][$oldRewrite];
        }
        $id = (int) Db::getInstance()->getValue(
            'SELECT id_category FROM `' . _DB_PREFIX_ . 'category_lang`
             WHERE link_rewrite = \'' . pSQL($oldRewrite) . '\' AND id_lang = ' . (int) $idLang
        );

        return $this->isCategoryVisible($id) ? $id : $this->matchByRewrite('category', $oldRewrite, $idLang);
    }

    /**
     * Correspondance d'un ancien rewrite avec un produit ou une catégorie actuels, par ressemblance des mots.
     */
    protected function matchByRewrite($type, $rewrite, $idLang)
    {
        $tokens = $this->tokens($rewrite);
        if (!$tokens) {
            return 0;
        }
        $sorted = $tokens;
        usort($sorted, function ($a, $b) {
            return strlen($b) - strlen($a);
        });
        $likes = [];
        foreach (array_slice($sorted, 0, 2) as $t) {
            $likes[] = 'l.link_rewrite LIKE \'%' . pSQL($t) . '%\'';
        }
        $shop = (int) Context::getContext()->shop->id;

        if ($type === 'product') {
            $sql = 'SELECT l.id_product AS id, l.link_rewrite FROM `' . _DB_PREFIX_ . 'product_lang` l
                    INNER JOIN `' . _DB_PREFIX_ . 'product_shop` s ON s.id_product = l.id_product AND s.id_shop = ' . $shop . '
                    WHERE l.id_lang = ' . (int) $idLang . ' AND l.id_shop = ' . $shop . ' AND s.active = 1 AND s.visibility <> \'none\'
                    AND ' . implode(' AND ', $likes) . ' LIMIT 200';
        } else {
            $sql = 'SELECT l.id_category AS id, l.link_rewrite FROM `' . _DB_PREFIX_ . 'category_lang` l
                    INNER JOIN `' . _DB_PREFIX_ . 'category` c ON c.id_category = l.id_category AND c.active = 1
                    WHERE l.id_lang = ' . (int) $idLang . ' AND l.id_shop = ' . $shop . ' AND l.id_category > 2
                    AND ' . implode(' AND ', $likes) . ' LIMIT 200';
        }
        $rows = Db::getInstance()->executeS($sql) ?: [];

        $best = 0;
        $bestScore = 0.0;
        foreach ($rows as $row) {
            $score = $this->similarity($tokens, $this->tokens($row['link_rewrite']));
            if ($score > $bestScore) {
                $bestScore = $score;
                $best = (int) $row['id'];
            }
        }

        return $bestScore >= self::MATCH_THRESHOLD ? $best : 0;
    }

    /**
     * Marque ou fournisseur actif dont le nom normalisé correspond au rewrite.
     */
    protected function matchByName($entity, $rewrite)
    {
        $rows = Db::getInstance()->executeS(
            'SELECT `id_' . bqSQL($entity) . '` AS id, name FROM `' . _DB_PREFIX_ . bqSQL($entity) . '` WHERE active = 1'
        ) ?: [];
        foreach ($rows as $row) {
            if (Tools::str2url($row['name']) === $rewrite) {
                return (int) $row['id'];
            }
        }

        return 0;
    }

    protected function tokens($rewrite)
    {
        $parts = preg_split('/-+/', strtolower((string) $rewrite));

        return array_values(array_unique(array_filter($parts, function ($t) {
            return strlen($t) >= 3 && !ctype_digit($t);
        })));
    }

    protected function similarity(array $a, array $b)
    {
        if (!$a || !$b) {
            return 0.0;
        }
        $inter = count(array_intersect($a, $b));
        $union = count(array_unique(array_merge($a, $b)));

        return $union ? $inter / $union : 0.0;
    }
}
