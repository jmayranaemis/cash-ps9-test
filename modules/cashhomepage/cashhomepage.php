<?php
/**
 * Homepage catalogue for Cash Alimentaire.
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class CashHomepage extends Module
{
    public function __construct()
    {
        $this->name = 'cashhomepage';
        $this->tab = 'front_office_features';
        $this->version = '1.21.6';
        $this->author = 'Cash Alimentaire';
        $this->need_instance = 0;
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Accueil Cash Alimentaire');
        $this->description = $this->l('Accueil catalogue professionnel Cash Alimentaire.');
        $this->ps_versions_compliancy = ['min' => '8.0.0', 'max' => _PS_VERSION_];
    }

    public function install()
    {
        return parent::install()
            && $this->registerHook('displayHome')
            && $this->registerHook('displayHeader')
            && $this->registerHook('displayNav1')
            && $this->registerHook('displayNav2')
            && $this->registerHook('displayNav3')
            && $this->registerHook('moduleRoutes')
            && $this->registerHook('actionFrontControllerInitAfter')
            && $this->registerHook('actionEmailSendBefore')
            && $this->registerHook('displayBackOfficeHeader')
            && $this->installEditableContent()
            && $this->installBrandSelection()
            && $this->ensureSignatureCmsPages()
            && $this->migrateSignatureCmsContent()
            && $this->configureCashExperience();
    }

    private function configureCashExperience()
    {
        $this->removeDemoHooks();
        $this->configureB2BRegistration();
        $this->configureHomeProducts();
        $this->configureProfessionalHeader();
        $this->configureCataloguesIntegration();
        $this->configureStores();
        $this->configureBlogCategoryRoutes();

        return true;
    }

    public function upgradeTo101()
    {
        $this->removeDemoHooks();
        $this->configureB2BRegistration();

        return true;
    }

    public function upgradeTo110()
    {
        $this->removeDemoHooks();
        $this->configureProfessionalHeader();

        return true;
    }

    public function upgradeTo120()
    {
        $this->installEditableContent();
        $this->configureProfessionalHeader();
        $this->ensureCatalogueContact();

        return true;
    }

    public function upgradeTo130()
    {
        $this->configureNewsBlog();
        $this->ensureFaqPage(true);

        return true;
    }

    public function upgradeTo1202()
    {
        $this->ensureFaqPage(true);

        return true;
    }

    public function upgradeTo1203()
    {
        if (!$this->isRegisteredInHook('displayBackOfficeHeader')
            && !$this->registerHook('displayBackOfficeHeader')) {
            return false;
        }

        return true;
    }

    public function upgradeTo140()
    {
        $this->configureHomeProducts();

        return true;
    }

    public function upgradeTo150()
    {
        if (!$this->isRegisteredInHook('actionFrontControllerInitAfter')
            && !$this->registerHook('actionFrontControllerInitAfter')) {
            return false;
        }

        $this->configureB2BRegistration();

        return true;
    }

    public function upgradeTo151()
    {
        if (!$this->isRegisteredInHook('actionEmailSendBefore')
            && !$this->registerHook('actionEmailSendBefore')) {
            return false;
        }

        return true;
    }

    public function upgradeTo160()
    {
        if (!$this->isRegisteredInHook('moduleRoutes')
            && !$this->registerHook('moduleRoutes')) {
            return false;
        }

        $this->configureCataloguesIntegration();

        return true;
    }

    public function upgradeTo170()
    {
        return $this->installBrandSelection();
    }

    public function upgradeTo180()
    {
        return $this->configureStores();
    }

    public function upgradeTo1210()
    {
        $this->configureMegaMenu();

        return true;
    }

    public function upgradeTo1211()
    {
        $this->configureMegaMenu();

        return true;
    }

    public function upgradeTo1212()
    {
        return $this->configureProductsMegaMenu()
            && $this->migrateSignatureCmsContent();
    }

    public function upgradeTo1213()
    {
        return $this->configureProductsMegaMenu();
    }

    public function upgradeTo1214()
    {
        return $this->configureBlogCategoryRoutes();
    }

    public function upgradeTo1215()
    {
        return $this->configureBlogCategoryRoutes();
    }

    public function upgradeTo1216()
    {
        return $this->configureBlogCategoryRoutes();
    }

    private function configureBlogCategoryRoutes()
    {
        $rewrites = [];
        foreach (Language::getLanguages(false) as $language) {
            $rewrites[(int) $language['id_lang']] = 'categorie';
        }

        Configuration::deleteByName('ANBLOG_category_rewrite');
        Configuration::updateValue('an_bl_cat_post_end_prefix', 1);

        return Configuration::updateValue('an_bl_category_rewrite', $rewrites);
    }

    private function configureStores()
    {
        $countryId = (int) Country::getByIso('FR');
        $stores = [
            1 => [
                'name' => 'CASE — Zone piétonne',
                'address1' => '15 rue de France',
                'postcode' => '06000',
                'city' => 'Nice',
                'phone' => '04 83 66 01 26',
                'email' => 'france@cash-alimentaire.com',
                'latitude' => 43.6956,
                'longitude' => 7.2623,
                'note' => 'Une boutique de proximité au cœur de Nice pour retrouver les essentiels du quotidien, les produits frais, l’épicerie et une sélection de spécialités.',
                'hours' => [
                    ['08:00 - 13:00', '16:00 - 19:30'],
                    ['08:00 - 13:00', '16:00 - 19:30'],
                    ['08:00 - 13:00', '16:00 - 19:30'],
                    ['08:00 - 13:00', '16:00 - 19:30'],
                    ['08:00 - 13:00', '16:00 - 19:30'],
                    ['08:00 - 13:00', '16:00 - 19:30'],
                    ['09:30 - 13:00', '16:00 - 19:30 de mai à septembre'],
                ],
            ],
            2 => [
                'name' => 'CASE — Villermont',
                'address1' => '19 & 21 avenue Villermont',
                'postcode' => '06000',
                'city' => 'Nice',
                'phone' => '04 93 85 30 09',
                'email' => '',
                'latitude' => 43.7113,
                'longitude' => 7.2628,
                'note' => 'Notre point de vente historique près du marché de la Libération, avec une offre large destinée aux professionnels comme aux particuliers.',
                'hours' => [
                    ['08:00 - 13:00', '14:30 - 18:30'],
                    ['08:00 - 13:00', '14:30 - 18:30'],
                    ['08:00 - 13:00', '14:30 - 18:30'],
                    ['08:00 - 13:00', '14:30 - 18:30'],
                    ['08:00 - 13:00', '14:30 - 18:30'],
                    ['08:00 - 13:30'],
                    ['Fermé'],
                ],
            ],
            5 => [
                'name' => 'CASE — Centre logistique',
                'address1' => '38 boulevard de l’Oli',
                'postcode' => '06340',
                'city' => 'La Trinité',
                'phone' => '04 89 03 23 23',
                'email' => 'contact@cash-alimentaire.com',
                'latitude' => 43.7418,
                'longitude' => 7.3137,
                'note' => 'Le cœur logistique de Cash Alimentaire : réception, stockage, préparation des commandes et organisation des livraisons professionnelles.',
                'hours' => [
                    ['10:00 - 16:00'],
                    ['10:00 - 16:00'],
                    ['10:00 - 16:00'],
                    ['10:00 - 16:00'],
                    ['10:00 - 16:00'],
                    ['Fermé'],
                    ['Fermé'],
                ],
            ],
        ];

        $db = Db::getInstance();
        if (!$db->update('store', ['active' => 0], 'id_store IN (3, 4)')) {
            return false;
        }

        foreach ($stores as $storeId => $store) {
            if (!$db->update('store', [
                'id_country' => $countryId,
                'id_state' => 0,
                'city' => $store['city'],
                'postcode' => $store['postcode'],
                'latitude' => $store['latitude'],
                'longitude' => $store['longitude'],
                'phone' => $store['phone'],
                'fax' => '',
                'email' => $store['email'],
                'active' => 1,
                'date_upd' => date('Y-m-d H:i:s'),
            ], 'id_store = ' . (int) $storeId)) {
                return false;
            }

            foreach (Language::getLanguages(false) as $language) {
                if (!$db->update('store_lang', [
                    'name' => $store['name'],
                    'address1' => $store['address1'],
                    'address2' => '',
                    'hours' => json_encode($store['hours'], JSON_UNESCAPED_UNICODE),
                    'note' => $store['note'],
                ], 'id_store = ' . (int) $storeId . ' AND id_lang = ' . (int) $language['id_lang'])) {
                    return false;
                }
            }
        }

        return true;
    }

    private function removeDemoHooks()
    {
        $hooksByModule = [
            'an_homeslider' => ['displaySliderFullWidth'],
            'an_homecategories' => ['displayHomeBefore'],
            'an_homeproducts' => ['displayHome'],
            'an_banners' => ['displayHome', 'displayHomeBefore', 'displayHomeAfter'],
            'an_brandslider' => ['displayHomeAfter', 'displayFooter'],
            'an_advantages' => ['displayHomeAfter'],
            'an_simplefreeshippingline' => ['displayBanner'],
            'anmegamenu' => ['displayTop'],
            'blockreassurance' => ['displayNavFullWidth'],
            'b2bregistration' => ['displayBanner', 'displayNav2', 'displayTop'],
            'pm_advancedsearch' => ['displayHome', 'displayTop', 'displayNavFullWidth'],
            'ets_megamenu' => ['displayTop'],
            'ps_searchbar' => ['displayTop'],
            'ps_customersignin' => ['displayNav2'],
            'jwishlist' => ['displayNav2'],
        ];

        foreach ($hooksByModule as $moduleName => $hooks) {
            $module = Module::getInstanceByName($moduleName);
            if (!$module || !$module->id) {
                continue;
            }
            foreach ($hooks as $hook) {
                if ($module->isRegisteredInHook($hook)) {
                    $module->unregisterHook(Hook::getIdByName($hook));
                }
            }
        }
    }

    private function configureProfessionalHeader()
    {
        if ($this->isRegisteredInHook('displayTop')) {
            $this->unregisterHook(Hook::getIdByName('displayTop'));
        }

        $this->ensureFaqPage();
        $this->ensureCatalogueContact();
        $this->configureNewsBlog();
        $this->configureProductsMegaMenu();
        $this->configureAnnouncementLine();
    }

    private function configureCataloguesIntegration()
    {
        $flipbook = Module::getInstanceByName('lpsflipbook');
        if ($flipbook && $flipbook->id && $flipbook->isRegisteredInHook('displayFooterAfter')) {
            $flipbook->unregisterHook(Hook::getIdByName('displayFooterAfter'));
        }

        $cataloguesUrl = $this->getCataloguesUrl();
        $db = Db::getInstance();
        if ($db->getValue(
            'SELECT COUNT(*) FROM information_schema.tables
             WHERE table_schema = "' . pSQL(_DB_NAME_) . '"
             AND table_name = "' . pSQL(_DB_PREFIX_ . 'ets_mm_menu_lang') . '"'
        )) {
            $db->update(
                'ets_mm_menu_lang',
                ['link' => pSQL($cataloguesUrl)],
                'LOWER(title) LIKE "%catalogue%"'
            );
        }
    }

    private function configureHomeProducts()
    {
        $homeProducts = Module::getInstanceByName('an_homeproducts');
        if (!$homeProducts || !$homeProducts->id) {
            return;
        }

        /*
         * The widget is rendered inside the editorial homepage, immediately
         * after product families. Keep it off displayHome to avoid a duplicate
         * block below the complete Cash homepage.
         */
        if ($homeProducts->isRegisteredInHook('displayHome')) {
            $homeProducts->unregisterHook(Hook::getIdByName('displayHome'));
        }

        Configuration::updateValue('an_hp_view_type', 'blocks');
        Configuration::updateValue('an_hp_slider', 1);
        Configuration::updateValue('an_hp_slider_nav', 1);
        Configuration::updateValue('an_hp_slider_dots', 0);
        Configuration::updateValue('an_hp_slider_loop', 0);
        Configuration::updateValue('an_hp_show_load_more', 0);

        $db = Db::getInstance();
        $blockId = (int) $db->getValue(
            'SELECT id_block
             FROM `' . _DB_PREFIX_ . 'an_homeproducts_blocks`
             WHERE type = "new-products"
             ORDER BY active DESC, position ASC'
        );

        if (!$blockId) {
            return;
        }

        $db->update('an_homeproducts_blocks', ['active' => 0]);
        $db->update('an_homeproducts_blocks', [
            'active' => 1,
            'type' => 'products',
            'products_display' => 8,
            'position' => 0,
            'show_sort' => 0,
            'show_sub_cat' => 0,
            'randomize' => 0,
        ], 'id_block = ' . $blockId);

        /*
         * Start with a representative selection: one active, illustrated
         * product per family. The site manager can then curate this list from
         * Home Products > Blocks without changing the homepage template.
         */
        $selectedProducts = $db->executeS(
            'SELECT MAX(p.id_product) AS id_product
             FROM `' . _DB_PREFIX_ . 'product` p
             INNER JOIN `' . _DB_PREFIX_ . 'product_shop` ps
                ON ps.id_product = p.id_product
                AND ps.id_shop = ' . (int) $this->context->shop->id . '
             WHERE ps.active = 1
               AND p.id_category_default > 2
               AND EXISTS (
                   SELECT 1
                   FROM `' . _DB_PREFIX_ . 'image` i
                   WHERE i.id_product = p.id_product
               )
             GROUP BY p.id_category_default
             ORDER BY MAX(ps.date_upd) DESC, MAX(p.id_product) DESC
             LIMIT 8'
        );
        $db->delete('an_homeproducts_blocks_products', 'id_block = ' . $blockId);
        foreach ($selectedProducts as $position => $product) {
            $db->insert('an_homeproducts_blocks_products', [
                'id_block' => $blockId,
                'id_product' => (int) $product['id_product'],
                'position' => (int) $position,
            ]);
        }

        // The banners shipped with the theme are demonstration content.
        $db->update('an_homeproducts_banners', ['active' => 0]);

        foreach (Language::getLanguages(false) as $language) {
            $languageId = (int) $language['id_lang'];
            $data = [
                'title' => pSQL('Quelques produits de notre catalogue'),
                'text' => pSQL(
                    '<p>Un aperçu de nos références professionnelles. Consultez la fiche pour découvrir le produit.</p>',
                    true
                ),
            ];
            if ((int) $db->getValue(
                'SELECT COUNT(*) FROM `' . _DB_PREFIX_ . 'an_homeproducts_blocks_lang`
                 WHERE id_block = ' . $blockId . ' AND id_lang = ' . $languageId
            )) {
                $db->update(
                    'an_homeproducts_blocks_lang',
                    $data,
                    'id_block = ' . $blockId . ' AND id_lang = ' . $languageId
                );
            } else {
                $data['id_block'] = $blockId;
                $data['id_lang'] = $languageId;
                $data['link'] = '';
                $db->insert('an_homeproducts_blocks_lang', $data);
            }
        }

        if (!(int) $db->getValue(
            'SELECT COUNT(*) FROM `' . _DB_PREFIX_ . 'an_homeproducts_blocks_shop`
             WHERE id_block = ' . $blockId . ' AND id_shop = ' . (int) $this->context->shop->id
        )) {
            $db->insert('an_homeproducts_blocks_shop', [
                'id_block' => $blockId,
                'id_shop' => (int) $this->context->shop->id,
            ]);
        }

        $homeProducts->_clearCache('*');
    }

    private function configureNewsBlog()
    {
        $blog = Module::getInstanceByName('anblog');
        if (!$blog || !$blog->id) {
            return;
        }

        if (!$blog->isRegisteredInHook('displayHome')) {
            $blog->registerHook('displayHome');
        }

        foreach (Language::getLanguages(false) as $language) {
            Db::getInstance()->update(
                'anblog_blog_widgets_lang',
                ['title' => pSQL('Actualités')],
                'id_anblog_blog_widgets = 1 AND id_lang = ' . (int) $language['id_lang']
            );
        }

        $hookId = (int) Hook::getIdByName('displayHome');
        $cashPosition = (int) Db::getInstance()->getValue(
            'SELECT position FROM `' . _DB_PREFIX_ . 'hook_module`
             WHERE id_hook = ' . $hookId . ' AND id_module = ' . (int) $this->id
        );
        Db::getInstance()->update(
            'hook_module',
            ['position' => max(2, $cashPosition + 1)],
            'id_hook = ' . $hookId . ' AND id_module = ' . (int) $blog->id
        );
    }

    private function configureMegaMenu()
    {
        $megaMenu = Module::getInstanceByName('ets_megamenu');
        if (!$megaMenu || !$megaMenu->id) {
            return;
        }

        if (!$megaMenu->isRegisteredInHook('displayNavFullWidth')) {
            $megaMenu->registerHook('displayNavFullWidth');
        }

        $db = Db::getInstance();
        $baseUrl = rtrim($this->context->link->getPageLink('index', true), '/') . '/';
        $menuConfiguration = [
            2 => [
                'position' => 0,
                'title' => 'Nos produits',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $this->getProductsUrl(),
                'custom_class' => 'cash-mega-products',
            ],
            3 => [
                'position' => 1,
                'title' => 'Catalogues',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $this->context->link->getModuleLink($this->name, 'catalogues', [], true),
                'custom_class' => '',
            ],
            4 => [
                'position' => 2,
                'title' => 'Services',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $baseUrl . '#services',
                'custom_class' => '',
            ],
            5 => [
                'position' => 3,
                'title' => 'Conseils & recettes',
                'link_type' => 'CATEGORY',
                'id_category' => 616,
                'link' => '',
                'custom_class' => '',
            ],
            6 => [
                'position' => 4,
                'title' => 'Devenir client',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $this->context->link->getModuleLink('b2bregistration', 'business'),
                'custom_class' => 'cash-mega-client',
            ],
        ];

        foreach ($menuConfiguration as $menuId => $menu) {
            $db->update('ets_mm_menu', [
                'sort_order' => (int) $menu['position'],
                'enabled' => 1,
                'enabled_vertical' => 0,
                'link_type' => pSQL($menu['link_type']),
                'id_category' => (int) $menu['id_category'],
                'id_cms' => 0,
                'id_manufacturer' => 0,
                'id_supplier' => 0,
                'sub_menu_type' => 'FULL',
                'sub_menu_max_width' => '100%',
                'custom_class' => pSQL($menu['custom_class']),
                'menu_icon' => '',
            ], 'id_menu = ' . (int) $menuId);

            foreach (Language::getLanguages(false) as $language) {
                $db->update('ets_mm_menu_lang', [
                    'title' => pSQL($menu['title']),
                    'link' => pSQL($menu['link']),
                    'bubble_text' => '',
                ], 'id_menu = ' . (int) $menuId . ' AND id_lang = ' . (int) $language['id_lang']);
            }
        }

        // Les liens utilitaires restent dans la barre marron afin d'éviter les doublons.
        $db->update('ets_mm_menu', ['enabled' => 0], 'id_menu IN (6, 7)');

        Configuration::updateValue('ETS_MM_INCLUDE_SUB_CATEGORIES', 0);
        $this->ensureMegaMenuCategoryColumns(2);

        if (method_exists($megaMenu, 'clearAllCache')) {
            $megaMenu->clearAllCache();
        }
    }

    private function configureProductsMegaMenu()
    {
        $megaMenu = Module::getInstanceByName('ets_megamenu');
        if (!$megaMenu || !$megaMenu->id) {
            return false;
        }

        $db = Db::getInstance();
        $menuRows = $db->executeS(
            'SELECT m.id_menu, m.custom_class, ml.title
             FROM ' . _DB_PREFIX_ . 'ets_mm_menu m
             INNER JOIN ' . _DB_PREFIX_ . 'ets_mm_menu_lang ml ON ml.id_menu = m.id_menu'
        );
        $menuId = 0;
        $titleMenuId = 0;
        foreach ((array) $menuRows as $menuRow) {
            if ((string) $menuRow['custom_class'] === 'cash-mega-products') {
                $menuId = (int) $menuRow['id_menu'];
                break;
            }

            $menuTitle = strtolower(trim((string) $menuRow['title']));
            if (!$titleMenuId && in_array($menuTitle, ['produits', 'nos produits'], true)) {
                $titleMenuId = (int) $menuRow['id_menu'];
            }
        }
        if (!$menuId) {
            $menuId = $titleMenuId;
        }

        if (!$menuId) {
            return false;
        }

        if (!$db->update('ets_mm_menu', [
            'link_type' => 'CUSTOM',
            'id_category' => 0,
            'id_cms' => 0,
            'id_manufacturer' => 0,
            'id_supplier' => 0,
            'custom_class' => 'cash-mega-products',
        ], 'id_menu = ' . $menuId)) {
            return false;
        }

        foreach (Language::getLanguages(false) as $language) {
            if (!$db->update(
                'ets_mm_menu_lang',
                ['link' => pSQL($this->getProductsUrl())],
                'id_menu = ' . $menuId . ' AND id_lang = ' . (int) $language['id_lang']
            )) {
                return false;
            }
        }

        if (method_exists($megaMenu, 'clearAllCache')) {
            $megaMenu->clearAllCache();
        }

        return true;
    }

    private function ensureCatalogueContact()
    {
        $contactId = (int) Configuration::get('CASH_CATALOGUE_CONTACT_ID');
        if ($contactId && Validate::isLoadedObject(new Contact($contactId))) {
            return $contactId;
        }

        foreach (Contact::getContacts((int) $this->context->language->id) as $contactData) {
            if (strtolower(trim($contactData['name'])) === 'demande de catalogue') {
                Configuration::updateValue('CASH_CATALOGUE_CONTACT_ID', (int) $contactData['id_contact']);

                return (int) $contactData['id_contact'];
            }
        }

        $contact = new Contact();
        $contact->email = (string) Configuration::get('PS_SHOP_EMAIL');
        $contact->customer_service = 0;
        $contact->name = [];
        $contact->description = [];
        foreach (Language::getLanguages(false) as $language) {
            $languageId = (int) $language['id_lang'];
            $contact->name[$languageId] = 'Demande de catalogue';
            $contact->description[$languageId] = 'Recevoir ou consulter un catalogue professionnel Cash Alimentaire.';
        }
        if ($contact->add()) {
            Configuration::updateValue('CASH_CATALOGUE_CONTACT_ID', (int) $contact->id);

            return (int) $contact->id;
        }

        return 0;
    }

    private function getEditableContentDefinitions()
    {
        return [
            'CASH_HOME_HERO_EYEBROW' => ['hero_eyebrow', 'Sur-titre du hero', 'Grossiste alimentaire pour les professionnels', 'text'],
            'CASH_HOME_HERO_TITLE' => ['hero_title', 'Titre principal', 'Tout pour votre activité, avec un interlocuteur local', 'text'],
            'CASH_HOME_HERO_LEAD' => ['hero_lead', 'Introduction du hero', 'Une offre complète pour la restauration, la vente à emporter et les métiers de bouche, disponible dans nos magasins et en livraison.', 'textarea'],
            'CASH_HOME_HERO_IMAGE_URL' => ['hero_image_url', 'Image de fond du hero — URL', '/modules/cashhomepage/views/img/cash-hero-restauration.webp', 'text'],
            'CASH_HOME_PROOF_1_TITLE' => ['proof_1_title', 'Preuve 1 — titre', 'Depuis 1984', 'text'],
            'CASH_HOME_PROOF_1_TEXT' => ['proof_1_text', 'Preuve 1 — texte', 'Une expérience terrain', 'text'],
            'CASH_HOME_PROOF_2_TITLE' => ['proof_2_title', 'Preuve 2 — titre', 'Des milliers de références', 'text'],
            'CASH_HOME_PROOF_2_TEXT' => ['proof_2_text', 'Preuve 2 — texte', 'Pour tous les métiers', 'text'],
            'CASH_HOME_PROOF_3_TITLE' => ['proof_3_title', 'Preuve 3 — titre', 'Livraison professionnelle', 'text'],
            'CASH_HOME_PROOF_3_TEXT' => ['proof_3_text', 'Preuve 3 — texte', 'Selon votre zone', 'text'],
            'CASH_HOME_PROOF_4_TITLE' => ['proof_4_title', 'Preuve 4 — titre', 'Une équipe locale', 'text'],
            'CASH_HOME_PROOF_4_TEXT' => ['proof_4_text', 'Preuve 4 — texte', 'Disponible et réactive', 'text'],
            'CASH_HOME_FAMILIES_TITLE' => ['families_title', 'Titre des familles', 'Nos familles de produits', 'text'],
            'CASH_HOME_TRADES_TITLE' => ['trades_title', 'Titre des métiers', 'Vous êtes…', 'text'],
            'CASH_HOME_CATALOGUE_TITLE' => ['catalogue_title', 'Titre des catalogues', 'Les catalogues du moment', 'text'],
            'CASH_HOME_CATALOGUE_TEXT' => ['catalogue_text', 'Introduction des catalogues', 'Feuilletez nos sélections professionnelles et retrouvez rapidement les références adaptées à votre activité.', 'textarea'],
            'CASH_HOME_CATALOGUE_CARD_TITLE' => ['catalogue_card_title', 'Carte catalogue — titre', 'Nos sélections professionnelles', 'text'],
            'CASH_HOME_CATALOGUE_CARD_TEXT' => ['catalogue_card_text', 'Carte catalogue — texte', 'Consultez le catalogue interactif ci-dessous ou demandez à notre équipe la sélection adaptée à votre besoin.', 'textarea'],
            'CASH_HOME_SERVICES_TITLE' => ['services_title', 'Titre des services', 'Des services utiles au quotidien', 'text'],
            'CASH_HOME_CLIENT_TITLE' => ['client_title', 'Titre devenir client', 'Devenir client Cash Alimentaire', 'text'],
            'CASH_HOME_CLIENT_TEXT' => ['client_text', 'Texte devenir client', 'Déposez votre demande en moins de 2 minutes. Après vérification de vos informations, notre équipe vous recontacte pour finaliser l’ouverture.', 'textarea'],
            'CASH_HOME_CONTACT_TITLE' => ['contact_title', 'Titre du bloc contact', 'Contactez-nous', 'text'],
            'CASH_HOME_CONTACT_TEXT' => ['contact_text', 'Texte du bloc contact', 'Notre équipe vous oriente vers le bon produit, le bon service ou le magasin le plus proche.', 'textarea'],
        ];
    }

    private function installEditableContent()
    {
        foreach ($this->getEditableContentDefinitions() as $configurationKey => $definition) {
            if (Configuration::get($configurationKey) === false) {
                Configuration::updateValue($configurationKey, $definition[2]);
            }
        }

        return true;
    }

    private function installBrandSelection()
    {
        if (Configuration::get('CASH_HOME_MANUFACTURERS') !== false) {
            return true;
        }

        $manufacturers = Manufacturer::getManufacturers(
            false,
            (int) Configuration::get('PS_LANG_DEFAULT'),
            true,
            false,
            false,
            false,
            true
        );
        $manufacturerIds = [];
        foreach (array_slice($manufacturers, 0, 12) as $manufacturer) {
            $manufacturerIds[] = (int) $manufacturer['id_manufacturer'];
        }

        return Configuration::updateValue('CASH_HOME_MANUFACTURERS', implode(',', $manufacturerIds));
    }

    private function getSelectedManufacturerIds()
    {
        if (Configuration::get('CASH_HOME_MANUFACTURERS') === false) {
            $this->installBrandSelection();
        }

        $value = trim((string) Configuration::get('CASH_HOME_MANUFACTURERS'));
        if ($value === '') {
            return [];
        }

        return array_values(array_unique(array_filter(array_map('intval', explode(',', $value)))));
    }

    private function getSelectedManufacturers($languageId)
    {
        $selectedIds = $this->getSelectedManufacturerIds();
        if (!$selectedIds) {
            return [];
        }

        $manufacturersById = [];
        foreach (Manufacturer::getManufacturers(false, (int) $languageId, true, false, false, false, true) as $manufacturer) {
            $manufacturersById[(int) $manufacturer['id_manufacturer']] = $manufacturer;
        }

        $manufacturers = [];
        foreach ($selectedIds as $manufacturerId) {
            if (isset($manufacturersById[$manufacturerId])) {
                $manufacturers[] = $manufacturersById[$manufacturerId];
            }
        }

        return $manufacturers;
    }

    private function getEditableContent()
    {
        $content = [];
        foreach ($this->getEditableContentDefinitions() as $configurationKey => $definition) {
            $value = Configuration::get($configurationKey);
            $content[$definition[0]] = $value === false || $value === '' ? $definition[2] : $value;
        }

        return $content;
    }

    public function getContent()
    {
        $confirmation = '';
        if (Tools::isSubmit('submitCashHomepage')) {
            foreach ($this->getEditableContentDefinitions() as $configurationKey => $definition) {
                Configuration::updateValue($configurationKey, trim((string) Tools::getValue($configurationKey)));
            }
            $selectedManufacturerIds = Tools::getValue('CASH_HOME_MANUFACTURERS', []);
            if (!is_array($selectedManufacturerIds)) {
                $selectedManufacturerIds = [];
            }
            $selectedManufacturerIds = array_values(array_unique(array_filter(array_map('intval', $selectedManufacturerIds))));
            Configuration::updateValue('CASH_HOME_MANUFACTURERS', implode(',', $selectedManufacturerIds));
            $confirmation = $this->displayConfirmation($this->l('Les contenus et les marques de la page d’accueil ont été enregistrés.'));
        }

        $fields = [];
        foreach ($this->getEditableContentDefinitions() as $configurationKey => $definition) {
            $fields[] = [
                'type' => $definition[3],
                'label' => $definition[1],
                'name' => $configurationKey,
                'rows' => 3,
                'cols' => 60,
            ];
        }

        $manufacturerOptions = Manufacturer::getManufacturers(
            false,
            (int) $this->context->language->id,
            true,
            false,
            false,
            false,
            true
        );
        $fields[] = [
            'type' => 'select',
            'label' => $this->l('Marques mises en avant'),
            'name' => 'CASH_HOME_MANUFACTURERS',
            'multiple' => true,
            'class' => 'chosen',
            'desc' => $this->l('Sélectionnez les logos affichés dans le carrousel Marques de la page d’accueil.'),
            'options' => [
                'query' => $manufacturerOptions,
                'id' => 'id_manufacturer',
                'name' => 'name',
            ],
        ];

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = (int) Configuration::get('PS_LANG_DEFAULT');
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG');
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitCashHomepage';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
            . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->fields_value = [];
        foreach ($this->getEditableContentDefinitions() as $configurationKey => $definition) {
            $helper->fields_value[$configurationKey] = Configuration::get($configurationKey) ?: $definition[2];
        }
        $helper->fields_value['CASH_HOME_MANUFACTURERS'] = $this->getSelectedManufacturerIds();

        return $confirmation . $helper->generateForm([[
            'form' => [
                'legend' => [
                    'title' => $this->l('Textes de la page d’accueil'),
                    'icon' => 'icon-edit',
                ],
                'description' => $this->l('Ces champs pilotent les principaux textes éditoriaux affichés sur la page d’accueil.'),
                'input' => $fields,
                'submit' => [
                    'title' => $this->l('Enregistrer'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],
        ]]);
    }

    private function ensureMegaMenuCategoryColumns($menuId)
    {
        $db = Db::getInstance();
        if ((int) $db->getValue(
            'SELECT COUNT(*) FROM `' . _DB_PREFIX_ . 'ets_mm_column` WHERE id_menu = ' . (int) $menuId
        )) {
            return;
        }

        $columns = [
            ['title' => 'Frais & saison', 'categories' => '3,8'],
            ['title' => 'Surgelés & glaces', 'categories' => '5,11'],
            ['title' => 'Épicerie', 'categories' => '284,634'],
            ['title' => 'Boissons & équipement', 'categories' => '9,12,6'],
        ];

        foreach ($columns as $position => $column) {
            $db->insert('ets_mm_column', [
                'id_menu' => (int) $menuId,
                'id_tab' => 0,
                'is_breaker' => 0,
                'column_size' => '3',
                'sort_order' => $position + 1,
            ]);
            $columnId = (int) $db->Insert_ID();
            $db->insert('ets_mm_block', [
                'id_column' => $columnId,
                'block_type' => 'CATEGORY',
                'sort_order' => 1,
                'enabled' => 1,
                'id_categories' => pSQL($column['categories']),
                'order_by_category' => 'c.position ASC,c.id_category ASC',
                'display_mnu_img' => 0,
                'display_mnu_name' => 1,
                'display_title' => 1,
                'display_content_mobile' => 1,
                'customer_groups' => '',
            ]);
            $blockId = (int) $db->Insert_ID();
            foreach (Language::getLanguages(false) as $language) {
                $db->insert('ets_mm_block_lang', [
                    'id_block' => $blockId,
                    'id_lang' => (int) $language['id_lang'],
                    'title' => pSQL($column['title']),
                    'content' => '',
                    'title_link' => '',
                    'image_link' => '',
                    'image' => '',
                ]);
            }
        }
    }

    private function configureAnnouncementLine()
    {
        $announcement = Module::getInstanceByName('an_simplefreeshippingline');
        if (!$announcement || !$announcement->id) {
            return;
        }

        if (!$announcement->isRegisteredInHook('displayNavFullWidth')) {
            $announcement->registerHook('displayNavFullWidth');
        }

        $titles = [];
        $links = [];
        foreach (Language::getLanguages(false) as $language) {
            $languageId = (int) $language['id_lang'];
            $titles[$languageId] = 'Livraison en 24h* [span]•[/span] Plus de 2 000 références [span]•[/span] Une équipe à votre écoute';
            $links[$languageId] = $this->context->link->getPageLink('contact', true, $languageId);
        }
        Configuration::updateValue('an_sfsl_title', $titles);
        Configuration::updateValue('an_sfsl_link', $links);

        $hookId = (int) Hook::getIdByName('displayNavFullWidth');
        Db::getInstance()->update(
            'hook_module',
            ['position' => 1],
            'id_hook = ' . $hookId . ' AND id_module = ' . (int) Module::getModuleIdByName('ets_megamenu')
        );
        Db::getInstance()->update(
            'hook_module',
            ['position' => 2],
            'id_hook = ' . $hookId . ' AND id_module = ' . (int) $announcement->id
        );
    }

    public function ensureSignatureCmsPages()
    {
        return $this->ensureSignatureCmsPage(
            'recrutement',
            'Recrutement',
            'Rejoignez Cash Alimentaire du Sud-Est et découvrez nos métiers, nos valeurs et notre parcours de recrutement.'
        ) && $this->ensureSignatureCmsPage(
            'nos-engagements',
            'Nos engagements',
            'Découvrez les engagements humains, environnementaux, territoriaux et responsables de Cash Alimentaire du Sud-Est.'
        );
    }

    private function ensureSignatureCmsPage($slug, $title, $description)
    {
        $cmsId = (int) Db::getInstance()->getValue(
            'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
             WHERE link_rewrite = \'' . pSQL($slug) . '\' ORDER BY id_cms ASC'
        );
        if ($cmsId) {
            return true;
        }

        $cms = new CMS();
        $cms->id_cms_category = 1;
        $cms->active = 1;
        $cms->indexation = 1;
        $cms->meta_title = [];
        $cms->meta_description = [];
        $cms->meta_keywords = [];
        $cms->link_rewrite = [];
        $cms->content = [];

        foreach (Language::getLanguages(false) as $language) {
            $languageId = (int) $language['id_lang'];
            $cms->meta_title[$languageId] = $title;
            $cms->meta_description[$languageId] = $description;
            $cms->meta_keywords[$languageId] = '';
            $cms->link_rewrite[$languageId] = $slug;
            $cms->content[$languageId] = '<p>' . $description . '</p>';
        }

        return $cms->add();
    }

    /**
     * Move the signature pages' initial markup into PrestaShop CMS content.
     *
     * These pages used to be rendered from theme partials, so edits made in
     * Design > Pages were silently ignored. The partials are kept as the
     * one-time migration source to preserve the existing front-office design.
     */
    public function migrateSignatureCmsContent()
    {
        $pages = [
            'a-propos' => 'about-case.tpl',
            'recrutement' => 'recruitment-case.tpl',
            'nos-engagements' => 'commitments-case.tpl',
        ];
        foreach ($pages as $slug => $templateName) {
            $cmsId = (int) Db::getInstance()->getValue(
                'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
                 WHERE link_rewrite = \'' . pSQL($slug) . '\' ORDER BY id_cms ASC'
            );
            if (!$cmsId && $slug === 'a-propos') {
                $cmsId = 4;
            }

            if (!$cmsId) {
                return false;
            }

            foreach (Language::getLanguages(false) as $language) {
                $languageId = (int) $language['id_lang'];
                $content = $this->getSignatureCmsTemplateContent($templateName, $languageId);
                if ($content === false) {
                    return false;
                }

                if (!Db::getInstance()->update(
                    'cms_lang',
                    ['content' => pSQL($content, true)],
                    'id_cms = ' . $cmsId . ' AND id_lang = ' . $languageId
                )) {
                    return false;
                }
            }
        }

        return true;
    }

    /**
     * Replace semantic layout tags stripped by the back-office editor with
     * equivalent divs. The About page is restored from its template when a
     * previous save has already removed its section wrappers.
     */
    public function repairSignatureCmsMarkup()
    {
        $pages = [
            'a-propos' => 'about-case.tpl',
            'recrutement' => 'recruitment-case.tpl',
            'nos-engagements' => 'commitments-case.tpl',
        ];
        $db = Db::getInstance();

        foreach ($pages as $slug => $templateName) {
            $cmsId = (int) $db->getValue(
                'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
                 WHERE link_rewrite = \'' . pSQL($slug) . '\' ORDER BY id_cms ASC'
            );
            if (!$cmsId) {
                return false;
            }

            $rows = $db->executeS(
                'SELECT id_lang, id_shop, content FROM `' . _DB_PREFIX_ . 'cms_lang`
                 WHERE id_cms = ' . $cmsId
            );
            foreach ($rows as $row) {
                $languageId = (int) $row['id_lang'];
                $content = (string) $row['content'];

                if ($slug === 'a-propos' && strpos($content, 'cash-about__section') === false) {
                    $content = $this->getSignatureCmsTemplateContent($templateName, $languageId);
                    if ($content === false) {
                        return false;
                    }
                } else {
                    $content = str_ireplace(
                        ['<section', '</section>', '<figure', '</figure>', '<article', '</article>', '<aside', '</aside>'],
                        ['<div', '</div>', '<div', '</div>', '<div', '</div>', '<div', '</div>'],
                        $content
                    );
                }

                if (!$db->update(
                    'cms_lang',
                    ['content' => pSQL($content, true)],
                    'id_cms = ' . $cmsId
                    . ' AND id_lang = ' . $languageId
                    . ' AND id_shop = ' . (int) $row['id_shop']
                )) {
                    return false;
                }
            }
        }

        return true;
    }

    private function getSignatureCmsTemplateContent($templateName, $languageId)
    {
        $templatePath = _PS_ROOT_DIR_ . '/themes/grainfoodmarket/templates/cms/_partials/' . $templateName;
        if (!is_readable($templatePath)) {
            return false;
        }

        $templateContent = file_get_contents($templatePath);
        if ($templateContent === false) {
            return false;
        }

        return str_replace(
            ['{$urls.base_url}', '{$urls.pages.stores}', '{$urls.pages.contact}'],
            [
                Tools::getShopDomainSsl(true) . __PS_BASE_URI__,
                $this->context->link->getPageLink('stores', true, (int) $languageId),
                $this->context->link->getPageLink('contact', true, (int) $languageId),
            ],
            $templateContent
        );
    }

    private function ensureFaqPage($refreshContent = false)
    {
        $db = Db::getInstance();
        $faqRows = $db->executeS(
            'SELECT DISTINCT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
             WHERE link_rewrite = \'faq-professionnels\' ORDER BY id_cms ASC'
        );
        if ($faqRows) {
            $faqId = (int) $faqRows[0]['id_cms'];
            Configuration::updateValue('CASH_HOMEPAGE_FAQ_CMS_ID', $faqId);
            if ($refreshContent) {
                foreach ($faqRows as $faqRow) {
                    $faq = new CMS((int) $faqRow['id_cms']);
                    $faq->content = [];
                    foreach (Language::getLanguages(false) as $language) {
                        $faq->content[(int) $language['id_lang']] = $this->getFaqContent();
                    }
                    $faq->update();
                }
            }
            return $faqId;
        }

        $faq = new CMS();
        $faq->id_cms_category = 1;
        $faq->active = 1;
        $faq->indexation = 1;
        $faq->meta_title = [];
        $faq->meta_description = [];
        $faq->meta_keywords = [];
        $faq->link_rewrite = [];
        $faq->content = [];
        foreach (Language::getLanguages(false) as $language) {
            $languageId = (int) $language['id_lang'];
            $faq->meta_title[$languageId] = 'FAQ professionnels';
            $faq->meta_description[$languageId] = 'Les réponses aux questions fréquentes des clients professionnels Cash Alimentaire.';
            $faq->meta_keywords[$languageId] = 'faq, professionnels, cash alimentaire';
            $faq->link_rewrite[$languageId] = 'faq-professionnels';
            $faq->content[$languageId] = $this->getFaqContent();
        }
        $faq->add();
        Configuration::updateValue('CASH_HOMEPAGE_FAQ_CMS_ID', (int) $faq->id);

        return (int) $faq->id;
    }

    private function getFaqContent()
    {
        return <<<'HTML'
            <div class="cash-faq">
              <div class="cash-faq__intro">
                <p class="cash-faq__eyebrow">Aide aux professionnels</p>
                <h2>Questions fréquentes</h2>
                <p>Ouverture de compte, commandes, produits, magasins et recrutement&nbsp;: retrouvez rapidement les réponses utiles.</p>
              </div>
              <div class="cash-faq__list">
                <h3 class="cash-faq__section">Devenir client</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Qui peut devenir client&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Les restaurants, commerces de bouche, collectivités et professionnels disposant d’un SIRET valide peuvent déposer une demande d’ouverture de compte.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment demander l’ouverture d’un compte&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Remplissez le formulaire <a href="/b2b-customer-create">«&nbsp;Devenir client&nbsp;»</a> avec vos coordonnées, votre numéro SIRET et votre extrait Kbis. Notre équipe étudie votre dossier avant de vous recontacter.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>L’ouverture de compte est-elle gratuite&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, la demande d’ouverture de compte est gratuite. Elle est soumise à la validation de votre dossier.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Quels documents sont nécessaires pour ouvrir un compte&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Selon votre activité, un extrait Kbis, votre numéro SIRET et d’autres justificatifs peuvent être demandés.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Combien de temps faut-il pour ouvrir un compte&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Les demandes sont traitées dans les meilleurs délais après réception d’un dossier complet.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment créer un espace client&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Déposez d’abord votre demande depuis la page «&nbsp;Devenir client&nbsp;». Après validation du dossier, l’équipe Cash Alimentaire crée votre accès. Sur ce site catalogue, cet espace permet notamment de conserver vos produits favoris&nbsp;; les commandes restent organisées avec votre interlocuteur commercial.</p></div>
                </div>

                <h3 class="cash-faq__section">Commandes &amp; livraison</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment passer commande&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Une fois votre compte ouvert, votre commercial vous indiquera les modalités de commande adaptées à votre activité.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Proposez-vous la livraison&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, selon votre secteur géographique et les conditions convenues avec notre équipe commerciale.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Dans quelles zones livrez-vous&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Nous livrons principalement sur notre secteur d’activité entre Saint-Tropez et Monaco. Contactez-nous pour vérifier si votre établissement est desservi.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Existe-t-il un minimum de commande&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Les conditions peuvent varier selon le secteur et le mode de livraison. Notre équipe vous renseignera lors de l’ouverture de votre compte.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Puis-je venir retirer ma commande&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, selon les modalités définies avec le service client. Contactez-nous avant votre déplacement.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Que faire si un produit est indisponible&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Contactez votre interlocuteur commercial ou notre service client. Selon votre besoin et les stocks disponibles, une référence de remplacement pourra vous être proposée.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment connaître les promotions en cours&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Consultez les catalogues du moment et les actualités du site. Vous pouvez également vous inscrire à la newsletter ou interroger votre commercial.</p></div>
                </div>

                <h3 class="cash-faq__section">Produits</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Quels produits proposez-vous&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Nous proposons une large gamme de produits alimentaires et de boissons destinés aux professionnels de la restauration, des métiers de bouche et des collectivités.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Travaillez-vous avec des producteurs locaux&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, nous sélectionnons également des produits issus de producteurs locaux afin de valoriser les filières régionales.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Vos produits évoluent-ils au fil des saisons&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, certaines références sont saisonnières afin de garantir leur qualité et leur disponibilité.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment obtenir un catalogue&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Consultez nos catalogues interactifs sur le site ou faites-en la demande via notre formulaire de contact.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Vos catalogues sont-ils mis à jour régulièrement&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, ils sont actualisés en fonction des nouveautés, des promotions et de la saisonnalité.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment sont sélectionnés vos produits&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Nos références sont sélectionnées selon leur qualité, leur régularité, leur disponibilité et leur pertinence pour les usages des professionnels de la restauration et des métiers de bouche.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Proposez-vous des produits bio, locaux ou labellisés&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, selon les familles et les disponibilités, notre catalogue comprend des références bio, locales ou bénéficiant de labels. Contactez-nous pour identifier les produits adaptés à vos critères.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Vos emballages sont-ils recyclables&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>La composition et les consignes de tri varient selon les produits et leurs fabricants. Reportez-vous aux indications présentes sur l’emballage ou demandez-nous les informations de la référence concernée.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Où trouver les informations allergènes et les fiches techniques&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Les allergènes figurent sur l’étiquetage des produits. Pour obtenir une fiche technique ou une information complémentaire, transmettez-nous la référence concernée via votre commercial ou le formulaire de contact.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment devenir fournisseur&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Présentez votre entreprise, vos gammes et vos conditions via notre formulaire de contact. Votre proposition sera transmise au service concerné pour étude.</p></div>
                </div>

                <h3 class="cash-faq__section">Particuliers</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Je suis un particulier, puis-je acheter chez vous&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Notre activité est principalement réservée aux professionnels.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Je suis un particulier, où puis-je trouver vos produits&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Certains de nos produits sont disponibles auprès de nos deux magasins à Nice, situés au 21 avenue Villermont et aux 15 &amp; 17 rue de France. N’hésitez pas à nous contacter pour connaître les produits disponibles à la vente.</p></div>
                </div>

                <h3 class="cash-faq__section">Nos points de vente</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Quels sont vos points de vente&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Retrouvez l’ensemble de nos magasins et leurs coordonnées sur la page <a href="/magasins">«&nbsp;Nos magasins&nbsp;»</a>.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Puis-je me rendre dans n’importe quelle agence&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, sous réserve des services proposés par chaque site. Consultez la fiche de votre agence ou contactez-nous avant votre visite.</p></div>
                </div>

                <h3 class="cash-faq__section">Contact</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Quand puis-je joindre votre équipe&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Du lundi au vendredi de 9h à 17h et le samedi de 8h30 à 12h.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment vous contacter&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Vous pouvez nous joindre par téléphone, via notre formulaire de contact ou directement auprès du point de vente le plus proche.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>À qui s’adresser pour une question commerciale&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Notre équipe commerciale est à votre disposition pour vous accompagner dans vos besoins et vos commandes.</p></div>
                </div>

                <h3 class="cash-faq__section">Recrutement</h3>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Comment envoyer ma candidature&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Vous pouvez consulter nos offres d’emploi et déposer votre candidature directement depuis la page «&nbsp;Recrutement&nbsp;». Les candidatures spontanées sont également les bienvenues.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Acceptez-vous les candidatures spontanées&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, vous pouvez nous transmettre votre CV et votre lettre de motivation via notre formulaire de recrutement.</p></div>
                </div>
                <div class="cash-faq__item">
                  <div class="cash-faq__question"><span>Proposez-vous des stages&nbsp;?</span><b></b></div>
                  <div class="cash-faq__answer"><p>Oui, selon les besoins de nos différents services.</p></div>
                </div>
              </div>
              <div class="cash-faq__contact">
                <strong>Vous ne trouvez pas votre réponse&nbsp;?</strong>
                <a href="/nous-contacter">Contactez notre équipe</a>
              </div>
            </div>
HTML;
    }

    private function configureB2BRegistration()
    {
        if (!Module::isInstalled('b2bregistration')) {
            return;
        }

        $shopGroupId = (int) $this->context->shop->id_shop_group;
        $shopId = (int) $this->context->shop->id;
        $configuration = [
            'B2BREGISTRATION_AUTO_APPROVEL' => 0,
            'B2BREGISTRATION_ADMIN_EMAIL_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_ADMIN_EMAIL_ID' => Configuration::get('PS_SHOP_EMAIL'),
            'B2BREGISTRATION_CUSTOMER_EMAIL_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_ENABLE_CUSTOM_FIELDS' => 1,
            'B2BREGISTRATION_IDENTIFICATION_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_ADDRESS_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_COUNTRY_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_PHONE_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_POSTCODE_ENABLE_DISABLE' => 1,
            'B2BREGISTRATION_WEBSITE_ENABLE_DISABLE' => 0,
            'B2BREGISTRATION_GROUP_ENABLE_DISABLE' => 0,
            'B2BREGISTRATION_NAME_PREFIX_ENABLE_DISABLE' => 0,
        ];

        foreach ($configuration as $key => $value) {
            Configuration::updateValue($key, $value, false, $shopGroupId, $shopId);
        }

        $confirmation = [];
        foreach (Language::getLanguages(false) as $language) {
            $confirmation[(int) $language['id_lang']] = '
                <section class="cash-b2b-confirmation">
                    <span class="cash-b2b-confirmation__icon" aria-hidden="true">✓</span>
                    <p class="cash-b2b__eyebrow">Demande transmise</p>
                    <h1>Votre dossier est bien enregistré</h1>
                    <p>Merci. Votre demande d’ouverture de compte est maintenant en attente de validation par notre équipe.</p>
                    <div class="cash-b2b-confirmation__next">
                        <strong>La suite</strong>
                        <ol>
                            <li>Nous vérifions votre SIRET et votre extrait Kbis.</li>
                            <li>Nous vous contactons si une information doit être complétée.</li>
                            <li>Après validation, vous recevez un e-mail pour accéder à votre compte.</li>
                        </ol>
                    </div>
                    <p class="cash-b2b-confirmation__help">Une question ? Appelez-nous au
                        <a href="tel:+33489032323">04 89 03 23 23</a> ou
                        <a href="' . $this->context->link->getPageLink('contact', true) . '">contactez notre équipe</a>.
                    </p>
                    <a class="btn btn-primary cash-b2b__submit" href="' . $this->context->link->getPageLink('index', true) . '">
                        Revenir à l’accueil
                    </a>
                </section>';
        }
        Configuration::updateValue(
            'B2BREGISTRATION_CUSTOM_TEXT',
            $confirmation,
            true,
            $shopGroupId,
            $shopId
        );

        $this->ensureB2BField('Type d’établissement', 'select', 1, 1, '', 2, [
            'Restaurant traditionnel',
            'Restauration rapide / snacking',
            'Pizzeria / vente à emporter',
            'Boulangerie / pâtisserie',
            'Traiteur',
            'Autre professionnel',
        ]);
        $this->ensureB2BField('Besoin principal', 'textarea', 2, 1);
        $this->ensureB2BField('Extrait Kbis (PDF)', 'attachment', 3, 1, 'pdf', 5);

        Configuration::updateValue(
            'an_modal_cookie_text',
            '<p>Nous utilisons des cookies nécessaires au fonctionnement du site et à la mesure de son audience.</p>',
            false,
            $shopGroupId,
            $shopId
        );
        Configuration::updateValue('an_modal_cookie_accept', 'Accepter', false, $shopGroupId, $shopId);
        Configuration::updateValue(
            'an_modal_cookie_privacy',
            'Politique de confidentialité',
            false,
            $shopGroupId,
            $shopId
        );
        Configuration::updateValue(
            'an_modal_cookie_privacy_link',
            $this->context->link->getCMSLink(2),
            false,
            $shopGroupId,
            $shopId
        );
        Configuration::updateValue('an_modal_cookie_background', '#432a19');
        Configuration::updateValue('an_modal_cookie_links_color', '#fff8f1');
    }

    private function ensureB2BField(
        $name,
        $type,
        $position,
        $required,
        $extensions = '',
        $attachmentSize = 2,
        array $options = []
    ) {
        $db = Db::getInstance();
        $fieldId = (int) $db->getValue(
            'SELECT l.id_bb_registration_fields
             FROM `' . _DB_PREFIX_ . 'bb_registration_fields_lang` l
             WHERE l.field_name = "' . pSQL($name) . '"'
        );

        if (!$fieldId) {
            $now = date('Y-m-d H:i:s');
            $db->insert('bb_registration_fields', [
                'field_type' => pSQL($type),
                'field_validation' => '',
                'position' => (int) $position,
                'assoc_shops' => (string) (int) $this->context->shop->id,
                'value_required' => (int) $required,
                'editable' => 1,
                'extensions' => pSQL($extensions ?: 'jpg'),
                'attachment_size' => (float) $attachmentSize,
                'alert_type' => 'info',
                'active' => 1,
                'dependant' => 0,
                'dependant_field' => 0,
                'dependant_value' => 0,
                'limit' => 0,
                'id_b2b_profile' => 0,
                'created_time' => $now,
                'update_time' => $now,
            ]);
            $fieldId = (int) $db->Insert_ID();

            foreach (Language::getLanguages(false) as $language) {
                $db->insert('bb_registration_fields_lang', [
                    'id_bb_registration_fields' => $fieldId,
                    'id_lang' => (int) $language['id_lang'],
                    'field_name' => pSQL($name),
                    'default_value' => '',
                ]);
            }
            $db->insert('bb_registration_fields_shop', [
                'id_bb_registration_fields' => $fieldId,
                'id_shop' => (int) $this->context->shop->id,
            ]);
        }

        if ($options && !(int) $db->getValue(
            'SELECT COUNT(*) FROM `' . _DB_PREFIX_ . 'bb_registration_fields_values`
             WHERE id_bb_registration_fields = ' . $fieldId
        )) {
            foreach ($options as $option) {
                $db->insert('bb_registration_fields_values', [
                    'id_bb_registration_fields' => $fieldId,
                ]);
                $optionId = (int) $db->Insert_ID();
                foreach (Language::getLanguages(false) as $language) {
                    $db->insert('bb_registration_fields_values_lang', [
                        'field_value_id' => $optionId,
                        'id_lang' => (int) $language['id_lang'],
                        'field_value' => pSQL($option),
                    ]);
                }
            }
        }
    }

    public function hookDisplayHeader()
    {
        $this->context->controller->registerStylesheet(
            'module-cashhomepage-header-palette',
            'modules/' . $this->name . '/views/css/header-palette.css',
            ['media' => 'all', 'priority' => 250, 'version' => $this->version . '-footer-2']
        );

        $isHomepage = 'index' === $this->context->controller->php_self;
        $isCataloguesPage = 'cashhomepage' === Tools::getValue('module')
            && 'catalogues' === Tools::getValue('controller');
        $isProductsPage = 'cashhomepage' === Tools::getValue('module')
            && 'products' === Tools::getValue('controller');

        if (!$isHomepage && !$isCataloguesPage && !$isProductsPage) {
            return;
        }

        $this->context->controller->registerStylesheet(
            'module-cashhomepage',
            'modules/' . $this->name . '/views/css/home.css',
            ['media' => 'all', 'priority' => 200, 'version' => $this->version . '-2']
        );
        if ($isProductsPage) {
            return;
        }

        $this->context->controller->registerJavascript(
            'module-cashhomepage-pdfjs',
            'modules/lpsflipbook/lib/dflip/js/libs/pdf.min.js',
            ['position' => 'bottom', 'priority' => 190, 'version' => $this->version]
        );
        $this->context->controller->registerJavascript(
            'module-cashhomepage-carousel',
            'modules/' . $this->name . '/views/js/home.js',
            ['position' => 'bottom', 'priority' => 200, 'version' => $this->version . '-3']
        );
    }

    public function hookDisplayBackOfficeHeader()
    {
        $controllerName = Tools::strtolower((string) Tools::getValue('controller'));
        if ('adminanblogblogs' !== $controllerName) {
            return '';
        }

        $this->context->controller->addJS(
            $this->_path . 'views/js/admin-blog-cta.js?v=' . rawurlencode($this->version)
        );
        $this->context->controller->addCSS(
            $this->_path . 'views/css/admin-blog-cta.css?v=' . rawurlencode($this->version)
        );

        return '';
    }

    public function hookModuleRoutes()
    {
        return [
            'module-' . $this->name . '-products' => [
                'controller' => 'products',
                'rule' => 'produits.html',
                'keywords' => [],
                'params' => [
                    'fc' => 'module',
                    'module' => $this->name,
                ],
            ],
            'module-' . $this->name . '-catalogues' => [
                'controller' => 'catalogues',
                'rule' => 'catalogues-professionnels.html',
                'keywords' => [],
                'params' => [
                    'fc' => 'module',
                    'module' => $this->name,
                ],
            ],
        ];
    }

    public function hookActionFrontControllerInitAfter($params)
    {
        if ('registration' === Dispatcher::getInstance()->getController()
            && !$this->context->customer->isLogged()) {
            Tools::redirect(
                $this->context->link->getModuleLink(
                    'b2bregistration',
                    'business',
                    [],
                    true
                )
            );
        }

        if (!Tools::isSubmit('b2b_add_data')) {
            return;
        }

        $controller = isset($params['controller']) ? $params['controller'] : null;
        if (!$controller
            || !isset($controller->module)
            || 'b2bregistration' !== $controller->module->name
            || 'business' !== Dispatcher::getInstance()->getController()) {
            return;
        }

        $siret = preg_replace('/\D+/', '', (string) Tools::getValue('identification_number'));
        $_POST['identification_number'] = $siret;
        $_REQUEST['identification_number'] = $siret;

        // The streamlined form deliberately hides the country selector.
        // Always provide the shop default country server-side as well, so a
        // stale cached template can never submit an empty country.
        $countryId = (int) Tools::getValue('id_country');
        if (!$countryId) {
            $countryId = (int) Configuration::get('PS_COUNTRY_DEFAULT');
            $_POST['id_country'] = $countryId;
            $_REQUEST['id_country'] = $countryId;
        }

        if (!$this->isSiretChecksumValid($siret)) {
            $controller->errors[] = $this->l(
                'Le numéro SIRET doit comporter 14 chiffres et respecter la clé de contrôle officielle.'
            );
        }

        if (!(int) Tools::getValue('cash_privacy')) {
            $controller->errors[] = $this->l(
                'Vous devez accepter l’utilisation de vos informations pour transmettre votre demande.'
            );
        }
    }

    public function hookActionEmailSendBefore($params)
    {
        if (empty($params['template'])) {
            return;
        }

        $subjects = [
            'b2b_customer_pending' => 'Votre demande professionnelle est en attente de validation',
            'b2b_activated' => 'Votre compte professionnel Cash Alimentaire est activé',
            'customer_registration_admin_notify' => 'Nouvelle demande d’ouverture de compte professionnel',
        ];

        if (isset($subjects[$params['template']])) {
            $params['subject'] = $subjects[$params['template']];
        }

        if ('b2b_activated' === $params['template']) {
            $params['templateVars']['{password_url}'] = $this->context->link->getPageLink(
                'password',
                true
            );
            $email = is_array($params['to']) ? reset($params['to']) : $params['to'];
            if (!Validate::isEmail((string) $email)) {
                return;
            }

            $customer = new Customer();
            $customer->getByEmail((string) $email);

            if (Validate::isLoadedObject($customer) && $customer->active) {
                /*
                 * Do not call Customer::update() here: this email is sent from
                 * the B2B customer-update hook. Updating the object again would
                 * trigger a duplicate activation email.
                 */
                $customer->stampResetPasswordToken();
                $tokenSaved = Db::getInstance()->update(
                    'customer',
                    [
                        'reset_password_token' => pSQL($customer->reset_password_token),
                        'reset_password_validity' => pSQL($customer->reset_password_validity),
                    ],
                    'id_customer = ' . (int) $customer->id
                );

                if ($tokenSaved) {
                    $params['templateVars']['{password_url}'] = $this->context->link->getPageLink(
                        'password',
                        true,
                        null,
                        http_build_query([
                            'token' => $customer->secure_key,
                            'id_customer' => (int) $customer->id,
                            'reset_token' => $customer->reset_password_token,
                        ])
                    );
                }
            }
        }
    }

    private function isSiretChecksumValid($siret)
    {
        if (!preg_match('/^\d{14}$/', $siret)) {
            return false;
        }

        $sum = 0;
        for ($index = 0; $index < 14; ++$index) {
            $digit = (int) $siret[$index];
            if (0 === $index % 2) {
                $digit *= 2;
                if ($digit > 9) {
                    $digit -= 9;
                }
            }
            $sum += $digit;
        }

        return 0 === $sum % 10;
    }

    public function hookDisplayNav1()
    {
        return $this->fetch('module:' . $this->name . '/views/templates/hook/header-service.tpl');
    }

    public function hookDisplayNav2()
    {
        $this->context->smarty->assign([
            'cash_header_become_client_url' => $this->context->link->getModuleLink(
                'b2bregistration',
                'business'
            ),
        ]);

        return $this->fetch('module:' . $this->name . '/views/templates/hook/header-client.tpl');
    }

    public function hookDisplayNav3()
    {
        $this->context->smarty->assign([
            'cash_header_contact_url' => $this->context->link->getPageLink('contact', true),
            'cash_header_stores_url' => $this->context->link->getPageLink('stores', true),
            'cash_header_faq_url' => $this->getFaqUrl(),
        ]);

        return $this->fetch('module:' . $this->name . '/views/templates/hook/header-links.tpl');
    }

    public function hookDisplayTop()
    {
        $this->context->smarty->assign([
            'cash_nav_families' => $this->getProductFamilies(6),
            'cash_nav_become_client_url' => $this->context->link->getModuleLink('b2bregistration', 'business'),
            'cash_nav_contact_url' => $this->context->link->getPageLink('contact', true),
            'cash_nav_products_url' => $this->getProductsUrl(),
        ]);

        return $this->fetch('module:' . $this->name . '/views/templates/hook/navigation.tpl');
    }

    public function hookDisplayHome()
    {
        $languageId = (int) $this->context->language->id;
        $manufacturers = $this->getSelectedManufacturers($languageId);
        foreach ($manufacturers as &$manufacturer) {
            $manufacturerId = (int) $manufacturer['id_manufacturer'];
            $manufacturer['url'] = $this->context->link->getManufacturerLink(
                $manufacturerId,
                $manufacturer['link_rewrite'],
                $languageId
            );
            $manufacturer['image'] = file_exists(_PS_MANU_IMG_DIR_ . $manufacturerId . '.jpg')
                ? $this->context->link->getManufacturerImageLink(
                    $manufacturerId,
                    ImageType::getFormattedName('brand_small')
                )
                : '';
        }
        unset($manufacturer);
        $catalogueContactId = $this->ensureCatalogueContact();
        $catalogues = $this->getActiveCatalogues();

        $this->context->smarty->assign([
            'cash_families' => $this->getProductFamilies(8),
            'cash_manufacturers' => $manufacturers,
            'cash_manufacturers_url' => $this->context->link->getPageLink('manufacturer', true),
            'cash_content' => $this->getEditableContent(),
            'cash_become_client_url' => $this->context->link->getModuleLink('b2bregistration', 'business'),
            'cash_contact_url' => $this->context->link->getPageLink('contact', true),
            'cash_faq_url' => $this->getFaqUrl(),
            'cash_services_url' => $this->getServicesUrl(),
            'cash_catalogue_contact_url' => $this->context->link->getPageLink(
                'contact',
                true,
                $languageId,
                $catalogueContactId ? ['id_contact' => $catalogueContactId] : null
            ),
            'cash_catalogues' => $catalogues,
            'cash_catalogues_url' => $this->getCataloguesUrl(),
            'cash_promotions_url' => $this->context->link->getPageLink('prices-drop', true),
            'cash_stores_url' => $this->context->link->getPageLink('stores', true),
            'cash_products_url' => $this->getProductsUrl(),
        ]);

        return $this->fetch('module:' . $this->name . '/views/templates/hook/home.tpl');
    }

    public function getActiveCatalogues($limit = 0)
    {
        $flipbook = Module::getInstanceByName('lpsflipbook');
        if (!$flipbook || !$flipbook->id || !$flipbook->active) {
            return [];
        }

        $db = Db::getInstance();
        if (!(int) $db->getValue(
            'SELECT COUNT(*) FROM information_schema.tables
             WHERE table_schema = "' . pSQL(_DB_NAME_) . '"
             AND table_name = "' . pSQL(_DB_PREFIX_ . 'lpsflipbook') . '"'
        )) {
            return [];
        }

        $rows = $db->executeS(
            'SELECT f.*, fl.title
             FROM `' . _DB_PREFIX_ . 'lpsflipbook` f
             INNER JOIN `' . _DB_PREFIX_ . 'lpsflipbook_lang` fl
                ON fl.id_lpsflipbook = f.id_lpsflipbook
                AND fl.id_lang = ' . (int) $this->context->language->id . '
             WHERE f.id_shop = ' . (int) $this->context->shop->id . '
               AND f.pdf_name <> ""
             ORDER BY f.id_lpsflipbook DESC'
        );

        $catalogues = [];
        $baseUrl = rtrim(
            $this->context->link->getBaseLink((int) $this->context->shop->id, true),
            '/'
        );
        foreach ($rows as $row) {
            $pdfFile = _PS_MODULE_DIR_ . 'lpsflipbook/views/pdf/' . basename($row['pdf_name']);
            if (!is_file($pdfFile)) {
                continue;
            }

            $thumbName = basename((string) $row['thumb_name']);
            $thumbFile = _PS_MODULE_DIR_ . 'lpsflipbook/views/thumb/' . $thumbName;
            $catalogues[] = [
                'id' => (int) $row['id_lpsflipbook'],
                'title' => trim((string) $row['title']) ?: $this->l('Catalogue professionnel'),
                'viewer_url' => $this->getCataloguesUrl() . '?open_catalogue=' . (int) $row['id_lpsflipbook'],
                'pdf_url' => $baseUrl . '/modules/lpsflipbook/views/pdf/' . rawurlencode(
                    basename($row['pdf_name'])
                ),
                // En mode Normal, DeepFlip génère la couverture depuis la première page du PDF.
                // Une miniature n'est imposée que pour le mode Thumbnail du module.
                'thumb_url' => $row['type'] === 'Thumbnail' && is_file($thumbFile)
                    ? $baseUrl . '/modules/lpsflipbook/views/thumb/' . rawurlencode($thumbName)
                    : '',
                'sound' => (int) $row['sound'],
                'download' => (int) $row['download'],
                'background_color' => Validate::isColor($row['background_color'])
                    ? $row['background_color']
                    : '#fff8f1',
            ];

            if ($limit > 0 && count($catalogues) >= $limit) {
                break;
            }
        }

        return $catalogues;
    }

    public function getCataloguesUrl()
    {
        return rtrim(
            $this->context->link->getBaseLink((int) $this->context->shop->id, true),
            '/'
        ) . '/catalogues-professionnels.html';
    }

    public function getProductsUrl()
    {
        return rtrim(
            $this->context->link->getBaseLink((int) $this->context->shop->id, true),
            '/'
        ) . '/produits.html';
    }

    public function getProductFamilies($limit = 100)
    {
        $languageId = (int) $this->context->language->id;
        $shopId = (int) $this->context->shop->id;
        $homeCategoryId = (int) Configuration::get('PS_HOME_CATEGORY');
        $categories = Category::getChildren($homeCategoryId, $languageId, true, $shopId);
        $families = [];

        foreach ($categories as $category) {
            if (count($families) >= $limit || in_array((int) $category['id_category'], [4, 6, 7], true)) {
                continue;
            }

            $families[] = [
                'name' => $category['name'],
                'url' => $this->context->link->getCategoryLink(
                    (int) $category['id_category'],
                    $category['link_rewrite'],
                    $languageId
                ),
                'image' => $this->getCategoryImage($category),
                'initial' => mb_strtoupper(mb_substr(trim($category['name']), 0, 1)),
            ];
        }

        return $families;
    }

    private function getCategoryImage(array $category)
    {
        $categoryId = (int) $category['id_category'];
        $imageFile = '';

        foreach (['jpg', 'webp', 'png'] as $extension) {
            if (file_exists(_PS_CAT_IMG_DIR_ . $categoryId . '.' . $extension)) {
                $imageFile = $categoryId . '.' . $extension;
                break;
            }
            if (file_exists(_PS_CAT_IMG_DIR_ . $categoryId . '-category_default.' . $extension)) {
                $imageFile = $categoryId . '-category_default.' . $extension;
                break;
            }
        }

        if (!$imageFile) {
            $categoryObject = new Category(
                $categoryId,
                (int) $this->context->language->id,
                (int) $this->context->shop->id
            );
            foreach ($categoryObject->getAllChildren() as $child) {
                $childId = (int) $child->id;
                foreach (['jpg', 'webp', 'png'] as $extension) {
                    if (file_exists(_PS_CAT_IMG_DIR_ . $childId . '.' . $extension)) {
                        $imageFile = $childId . '.' . $extension;
                        break 2;
                    }
                    if (file_exists(_PS_CAT_IMG_DIR_ . $childId . '-category_default.' . $extension)) {
                        $imageFile = $childId . '-category_default.' . $extension;
                        break 2;
                    }
                }
            }
        }

        // URL directe : la règle Nginx de réécriture /c/... n'est pas active sur ce serveur.
        return $imageFile
            ? $this->context->link->getMediaLink(_PS_IMG_ . 'c/' . $imageFile)
            : '';
    }

    private function getFaqUrl()
    {
        $faqId = (int) Configuration::get('CASH_HOMEPAGE_FAQ_CMS_ID');
        if (!$faqId) {
            $faqId = (int) Db::getInstance()->getValue(
                'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
                 WHERE link_rewrite = \'faq-professionnels\' ORDER BY id_cms ASC LIMIT 1'
            );
        }

        return $faqId
            ? $this->context->link->getCMSLink($faqId)
            : $this->context->link->getPageLink('contact', true);
    }

    private function getServicesUrl()
    {
        $servicesId = (int) Db::getInstance()->getValue(
            'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
             WHERE link_rewrite = \'services-cash-alimentaire\' ORDER BY id_cms ASC LIMIT 1'
        );

        return $servicesId
            ? $this->context->link->getCMSLink($servicesId)
            : Tools::getShopDomainSsl(true) . __PS_BASE_URI__ . 'content/services-cash-alimentaire';
    }
}
