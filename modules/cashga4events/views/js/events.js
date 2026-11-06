/* Cash Alimentaire - événements GA4 de prospection (module cashga4events). */
(function () {
  'use strict';

  var KEY = 'cashga4_pending';

  function send(name, params) {
    // gtag n'existe qu'après consentement « Mesure d'audience » : sans consentement, rien n'est envoyé.
    if (typeof window.gtag !== 'function') { return; }
    params = params || {};
    params.page_path = window.location.pathname;
    window.gtag('event', name, params);
  }

  function store(name) {
    try { window.sessionStorage.setItem(KEY, name); } catch (e) { /* stockage indisponible */ }
  }

  function take() {
    try {
      var v = window.sessionStorage.getItem(KEY);
      window.sessionStorage.removeItem(KEY);
      return v;
    } catch (e) { return null; }
  }

  function hasErrors(scope) {
    return !!(scope || document).querySelector(
      '.alert-danger, .help-block li, .form-control-feedback, .has-error, .is-invalid, .invalid-feedback'
    );
  }

  // 1. Formulaires : on mémorise l'envoi, et on confirme au chargement suivant s'il n'y a pas d'erreur.
  document.addEventListener('submit', function (e) {
    var form = e.target;
    if (!form || form.tagName !== 'FORM') { return; }
    var action = (form.getAttribute('action') || '').toLowerCase();
    if (form.querySelector('[name="b2b_add_data"]') || action.indexOf('b2b-customer-create') !== -1) {
      store('demande_compte_pro');
    } else if (form.querySelector('[name="submitMessage"]') || action.indexOf('nous-contacter') !== -1) {
      store('contact_formulaire');
    }
  }, true);

  function confirmPending() {
    var pending = take();
    if (!pending) { return; }
    if (pending === 'contact_formulaire') {
      // Le module contact affiche un message de succès sur la page.
      if (document.querySelector('.contact-form .alert-success, #content .alert-success, .alert-success')) {
        send('contact_formulaire', { lead_type: 'contact' });
        send('generate_lead', { lead_type: 'contact' });
      }
      return;
    }
    if (pending === 'demande_compte_pro') {
      var form = document.querySelector('form#customer-form, form[action*="b2b-customer-create"]');
      // Formulaire réaffiché avec des erreurs : pas d'événement.
      if (form && hasErrors(form)) { return; }
      send('demande_compte_pro', { lead_type: 'compte_pro' });
      send('generate_lead', { lead_type: 'compte_pro' });
    }
  }

  // 2. Clics : téléphone, e-mail, espace commande, itinéraire.
  document.addEventListener('click', function (e) {
    var a = e.target && e.target.closest ? e.target.closest('a[href]') : null;
    if (!a) { return; }
    var href = a.getAttribute('href') || '';
    var label = (a.textContent || '').replace(/\s+/g, ' ').trim().slice(0, 80);
    if (href.indexOf('tel:') === 0) {
      send('clic_telephone', { link_url: href, link_text: label });
    } else if (href.indexOf('mailto:') === 0) {
      send('clic_email', { link_url: href.split('?')[0], link_text: label });
    } else if (/cmdcase\.fr/i.test(href)) {
      send('clic_espace_commande', { link_url: href, link_text: label });
    } else if (/google\.[a-z.]+\/maps|maps\.google|goo\.gl\/maps|maps\.app\.goo\.gl/i.test(href)) {
      send('clic_itineraire', { link_url: href, link_text: label });
    }
  }, true);

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', confirmPending);
  } else {
    confirmPending();
  }
}());
