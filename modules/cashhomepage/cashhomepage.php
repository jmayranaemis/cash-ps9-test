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
        $this->version = '1.1.0';
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
            && $this->configureCashExperience();
    }

    private function configureCashExperience()
    {
        $this->removeDemoHooks();
        $this->configureB2BRegistration();
        $this->configureProfessionalHeader();

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

    private function removeDemoHooks()
    {
        $hooksByModule = [
            'an_homeslider' => ['displaySliderFullWidth'],
            'an_homecategories' => ['displayHomeBefore'],
            'an_homeproducts' => ['displayHome'],
            'anblog' => ['displayHome'],
            'an_banners' => ['displayHome', 'displayHomeBefore', 'displayHomeAfter'],
            'an_brandslider' => ['displayHomeAfter', 'displayFooter'],
            'an_advantages' => ['displayHomeAfter'],
            'an_simplefreeshippingline' => ['displayBanner'],
            'anmegamenu' => ['displayTop'],
            'b2bregistration' => ['displayBanner', 'displayNav2', 'displayTop'],
            'pm_advancedsearch' => ['displayHome', 'displayTop'],
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
        $this->configureMegaMenu();
        $this->configureAnnouncementLine();
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
        $baseUrl = rtrim($this->context->shop->getBaseURL(true), '/') . '/';
        $menuConfiguration = [
            2 => [
                'title' => 'Nos produits',
                'link_type' => 'CATEGORY',
                'id_category' => (int) Configuration::get('PS_HOME_CATEGORY'),
                'link' => '',
                'custom_class' => 'cash-mega-products',
            ],
            3 => [
                'title' => 'Catalogues',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $baseUrl . '#catalogues',
                'custom_class' => '',
            ],
            4 => [
                'title' => 'Services',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $baseUrl . '#services',
                'custom_class' => '',
            ],
            5 => [
                'title' => 'Conseils & recettes',
                'link_type' => 'CATEGORY',
                'id_category' => 616,
                'link' => '',
                'custom_class' => '',
            ],
            6 => [
                'title' => 'Devenir client',
                'link_type' => 'CUSTOM',
                'id_category' => 0,
                'link' => $this->context->link->getModuleLink('b2bregistration', 'business'),
                'custom_class' => 'cash-mega-client',
            ],
        ];

        foreach ($menuConfiguration as $menuId => $menu) {
            $db->update('ets_mm_menu', [
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

        Configuration::updateValue('ETS_MM_INCLUDE_SUB_CATEGORIES', 0);
        $this->ensureMegaMenuCategoryColumns(2);

        if (method_exists($megaMenu, 'clearAllCache')) {
            $megaMenu->clearAllCache();
        }
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

    private function ensureFaqPage()
    {
        $db = Db::getInstance();
        $faqId = (int) $db->getValue(
            'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
             WHERE link_rewrite = "faq-professionnels" LIMIT 1'
        );
        if ($faqId) {
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
            $faq->content[$languageId] = '
                <h2>Questions fréquentes</h2>
                <h3>Qui peut devenir client professionnel ?</h3>
                <p>Les restaurants, commerces de bouche, collectivités et professionnels disposant d’un SIRET valide.</p>
                <h3>Comment demander l’ouverture d’un compte ?</h3>
                <p>Remplissez le formulaire « Devenir client » avec votre SIRET et votre extrait Kbis. Notre équipe contrôle ensuite votre demande.</p>
                <h3>Proposez-vous la livraison ?</h3>
                <p>Oui, selon votre zone et les conditions convenues avec notre équipe commerciale.</p>
                <h3>Comment obtenir un catalogue ?</h3>
                <p>Utilisez le formulaire de contact ou appelez le 04 89 03 23 23 afin de recevoir la sélection adaptée à votre activité.</p>
                <h3>Quand puis-je joindre l’équipe ?</h3>
                <p>Du lundi au vendredi de 9h à 17h et le samedi de 8h30 à 12h.</p>';
        }
        $faq->add();

        return (int) $faq->id;
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
        if ('index' !== $this->context->controller->php_self) {
            return;
        }

        $this->context->controller->registerStylesheet(
            'module-cashhomepage',
            'modules/' . $this->name . '/views/css/home.css',
            ['media' => 'all', 'priority' => 200]
        );
        $this->context->controller->registerJavascript(
            'module-cashhomepage-carousel',
            'modules/' . $this->name . '/views/js/home.js',
            ['position' => 'bottom', 'priority' => 200]
        );
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
            'cash_nav_products_url' => $this->context->link->getCategoryLink(
                (int) Configuration::get('PS_HOME_CATEGORY')
            ),
        ]);

        return $this->fetch('module:' . $this->name . '/views/templates/hook/navigation.tpl');
    }

    public function hookDisplayHome()
    {
        $languageId = (int) $this->context->language->id;
        $shopId = (int) $this->context->shop->id;
        $homeCategory = new Category((int) Configuration::get('PS_HOME_CATEGORY'), $languageId, $shopId);

        $manufacturers = array_slice(
            Manufacturer::getManufacturers(false, $languageId, true, false, false, false, true),
            0,
            12
        );
        foreach ($manufacturers as &$manufacturer) {
            $manufacturer['url'] = $this->context->link->getManufacturerLink(
                (int) $manufacturer['id_manufacturer'],
                $manufacturer['link_rewrite'],
                $languageId
            );
            $manufacturer['image'] = $this->context->link->getMediaLink(
                _THEME_MANU_DIR_ . (int) $manufacturer['id_manufacturer'] . '.jpg'
            );
        }
        unset($manufacturer);

        $this->context->smarty->assign([
            'cash_families' => $this->getProductFamilies(8),
            'cash_manufacturers' => $manufacturers,
            'cash_become_client_url' => $this->context->link->getModuleLink('b2bregistration', 'business'),
            'cash_contact_url' => $this->context->link->getPageLink('contact', true),
            'cash_stores_url' => $this->context->link->getPageLink('stores', true),
            'cash_products_url' => $this->context->link->getCategoryLink($homeCategory->id),
        ]);

        return $this->fetch('module:' . $this->name . '/views/templates/hook/home.tpl');
    }

    private function getProductFamilies($limit)
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
                'image' => $this->context->link->getCatImageLink(
                    $category['link_rewrite'],
                    (int) $category['id_category'],
                    'category_default'
                ),
            ];
        }

        return $families;
    }

    private function getFaqUrl()
    {
        $faqId = (int) Db::getInstance()->getValue(
            'SELECT id_cms FROM `' . _DB_PREFIX_ . 'cms_lang`
             WHERE link_rewrite = "faq-professionnels" LIMIT 1'
        );

        return $faqId
            ? $this->context->link->getCMSLink($faqId)
            : $this->context->link->getPageLink('contact', true);
    }
}
