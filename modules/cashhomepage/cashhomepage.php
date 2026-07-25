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
        $this->version = '1.0.1';
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
            && $this->registerHook('displayTop')
            && $this->configureCashExperience();
    }

    private function configureCashExperience()
    {
        $this->removeDemoHooks();
        $this->configureB2BRegistration();

        return true;
    }

    public function upgradeTo101()
    {
        $this->removeDemoHooks();
        $this->configureB2BRegistration();

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
}
