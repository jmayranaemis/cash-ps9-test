<?php
/**
 * Cash Alimentaire - Événements GA4 de prospection.
 *
 * Ajoute un script léger qui envoie à GA4 (via le gtag déjà chargé par ps_googleanalytics,
 * donc uniquement après consentement « Mesure d'audience ») les actions de prospection :
 *   demande_compte_pro   formulaire de demande de compte professionnel envoyé sans erreur
 *   contact_formulaire   formulaire de contact envoyé avec succès
 *   clic_telephone       clic sur un numéro de téléphone
 *   clic_email           clic sur une adresse e-mail
 *   clic_espace_commande clic vers l'espace de commande en ligne (cmdcase.fr)
 *   clic_itineraire      clic vers un itinéraire Google Maps (page magasins)
 * Aucun cookie ni donnée personnelle supplémentaire.
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

class CashGa4Events extends Module
{
    public function __construct()
    {
        $this->name = 'cashga4events';
        $this->tab = 'analytics_stats';
        $this->version = '1.0.0';
        $this->author = 'M2J Expertise';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = ['min' => '8.0.0', 'max' => '9.99.99'];
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Cash - Événements GA4 de prospection');
        $this->description = $this->l('Envoie à GA4 les demandes de compte pro, contacts, clics téléphone, e-mail, espace commande et itinéraire.');
    }

    public function install()
    {
        return parent::install() && $this->registerHook('actionFrontControllerSetMedia');
    }

    public function hookActionFrontControllerSetMedia()
    {
        $this->context->controller->registerJavascript(
            'module-cashga4events',
            'modules/' . $this->name . '/views/js/events.js',
            ['position' => 'bottom', 'priority' => 250]
        );
    }
}
