<?php

class CashHomepageProductsModuleFrontController extends ModuleFrontController
{
    public $auth = false;
    public $guestAllowed = true;
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
        $this->display_column_left = false;
        $this->display_column_right = false;
        $this->context->smarty->assign([
            'cash_families' => $this->module->getProductFamilies(),
            'cash_contact_url' => $this->context->link->getPageLink('contact', true),
        ]);
        $this->setTemplate('module:cashhomepage/views/templates/front/products.tpl');
    }

    public function getTemplateVarPage()
    {
        $page = parent::getTemplateVarPage();
        $page['meta']['title'] = 'Nos produits | Cash Alimentaire';
        $page['meta']['description'] = 'Explorez les familles de produits distribuées par Cash Alimentaire aux professionnels de la restauration.';
        $page['canonical'] = $this->module->getProductsUrl();

        return $page;
    }
}
