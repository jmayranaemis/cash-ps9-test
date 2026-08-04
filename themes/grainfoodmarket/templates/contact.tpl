{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file='page.tpl'}

{block name='page_header_container'}{/block}

{block name='left_column'}{/block}

{block name='page_content'}
  <div class="cash-contact-page">
    <section class="cash-contact-page__hero">
      <div>
        <p class="cash-contact-page__eyebrow">Un interlocuteur local</p>
        <h1>Parlons de votre besoin</h1>
        <p>Une référence, un catalogue, une livraison ou une ouverture de compte&nbsp;? Votre demande est orientée vers la bonne personne dès sa réception.</p>
      </div>
      <div class="cash-contact-page__promise">
        <strong>Une réponse claire, sans intermédiaire inutile.</strong>
        <span>Choisissez simplement le motif de votre demande dans le formulaire.</span>
      </div>
    </section>

    <section class="cash-contact-page__body">
      <aside class="cash-contact-page__details" aria-label="Coordonnées Cash Alimentaire">
        <p class="cash-contact-page__eyebrow">Nous joindre</p>
        <p class="cash-contact-page__note">Pour une ouverture de compte professionnel, utilisez directement le parcours <a href="{$link->getModuleLink('b2bregistration', 'business')}">Devenir client</a>.</p>
        <h2>Notre équipe est à votre écoute</h2>
        <a class="cash-contact-page__detail" href="tel:+33489032323">
          <span class="cash-contact-page__icon" aria-hidden="true"><svg viewBox="0 0 24 24"><path d="M7.2 3.2 9.6 7a1.5 1.5 0 0 1-.2 1.8l-1.5 1.5a15.4 15.4 0 0 0 5.8 5.8l1.5-1.5a1.5 1.5 0 0 1 1.8-.2l3.8 2.4a1.5 1.5 0 0 1 .7 1.5v2a1.5 1.5 0 0 1-1.5 1.5C10.2 21.8 2.2 13.8 2.2 4A1.5 1.5 0 0 1 3.7 2.5h2a1.5 1.5 0 0 1 1.5.7Z"/></svg></span>
          <span><small>Téléphone</small><strong>04 89 03 23 23</strong></span>
        </a>
        <div class="cash-contact-page__detail">
          <span class="cash-contact-page__icon" aria-hidden="true"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.5 2"/></svg></span>
          <span><small>Horaires</small><strong>Lun–ven 9h–17h</strong></span>
        </div>
        <a class="cash-contact-page__detail" href="{$urls.pages.stores}">
          <span class="cash-contact-page__icon" aria-hidden="true"><svg viewBox="0 0 24 24"><path d="M12 21s7-6.1 7-12A7 7 0 0 0 5 9c0 5.9 7 12 7 12Z"/><circle cx="12" cy="9" r="2.4"/></svg></span>
          <span><small>Proximité</small><strong>Voir nos magasins</strong></span>
        </a>
      </aside>
      <div class="cash-contact-page__form">
        <p class="cash-contact-page__eyebrow">Votre demande</p>
        <h2>Comment pouvons-nous vous aider&nbsp;?</h2>
        {widget name="contactform"}
      </div>
    </section>
  </div>
{/block}
