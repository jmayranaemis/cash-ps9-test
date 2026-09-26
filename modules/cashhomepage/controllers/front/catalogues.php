<?php

class CashHomepageCataloguesModuleFrontController extends ModuleFrontController
{
    public $auth = false;

    public $guestAllowed = true;

    public $ssl = true;

    public function initContent()
    {
        parent::initContent();

        $this->display_column_left = false;
        $this->display_column_right = false;

        $catalogueContactId = (int) Configuration::get('CASH_CATALOGUE_CONTACT_ID');
        $this->context->smarty->assign([
            'cash_catalogues' => $this->module->getActiveCatalogues(),
            'cash_catalogue_flipbook_text' => (string) (Configuration::get('CASH_HOME_CATALOGUE_FLIPBOOK_TEXT') ?: 'Feuilletez ce catalogue en ligne et retrouvez rapidement les références utiles à votre activité.'),
            'cash_catalogue_contact_url' => $this->context->link->getPageLink(
                'contact',
                true,
                (int) $this->context->language->id,
                $catalogueContactId ? ['id_contact' => $catalogueContactId] : null
            ),
        ]);

        $this->setTemplate('module:cashhomepage/views/templates/front/catalogues.tpl');
    }

    public function getTemplateVarPage()
    {
        $page = parent::getTemplateVarPage();
        $page['meta']['title'] = 'Catalogues professionnels | Cash Alimentaire';
        $page['meta']['description'] = 'Feuilletez et téléchargez les catalogues professionnels Cash Alimentaire.';
        $page['canonical'] = $this->module->getCataloguesUrl();

        return $page;
    }
}
