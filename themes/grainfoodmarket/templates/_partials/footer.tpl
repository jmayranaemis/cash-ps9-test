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
    {block name='hook_footer_before'}
      {hook h='displayFooterBefore'}
    {/block}
<div class="footer-container">
  <div class="container">
    <div class="row">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
      {hook h='displayFooterANLiveEditor'}
    </div>
    <div class="row">
      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>
  </div>
</div>
<div class="copyright-container">
  <div class="container">
    <div class="row">
      <div class="col-md-12 cash-footer-bottom-right">
        <nav class="cash-footer-socials" aria-label="Réseaux sociaux">
          <span>Suivez-nous</span>
          {assign var='cash_social_instagram' value=Configuration::get('BLOCKSOCIAL_INSTAGRAM')}
          {assign var='cash_social_facebook' value=Configuration::get('BLOCKSOCIAL_FACEBOOK')}
          {assign var='cash_social_linkedin' value=Configuration::get('BLOCKSOCIAL_LINKEDIN')}

          {if $cash_social_instagram}
            <a href="{$cash_social_instagram|escape:'htmlall':'UTF-8'}" target="_blank" rel="noopener noreferrer" aria-label="Cash Alimentaire sur Instagram">
          {else}
            <span class="cash-footer-socials__placeholder" role="img" aria-label="Instagram — lien à renseigner" title="Lien Instagram à renseigner dans le module Réseaux sociaux">
          {/if}
            <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false">
              <rect x="3" y="3" width="18" height="18" rx="5" fill="none" stroke="currentColor" stroke-width="2"/>
              <circle cx="12" cy="12" r="4" fill="none" stroke="currentColor" stroke-width="2"/>
              <circle cx="17.4" cy="6.7" r="1.1" fill="currentColor"/>
            </svg>
          {if $cash_social_instagram}</a>{else}</span>{/if}

          {if $cash_social_facebook}
            <a href="{$cash_social_facebook|escape:'htmlall':'UTF-8'}" target="_blank" rel="noopener noreferrer" aria-label="Cash Alimentaire sur Facebook">
          {else}
            <span class="cash-footer-socials__placeholder" role="img" aria-label="Facebook — lien à renseigner" title="Lien Facebook à renseigner dans le module Réseaux sociaux">
          {/if}
            <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false">
              <path fill="currentColor" d="M13.8 22v-8h2.7l.4-3.1h-3.1V8.8c0-.9.3-1.6 1.6-1.6H17V4.4c-.5-.1-1.4-.2-2.4-.2-2.4 0-4.1 1.5-4.1 4.3v2.4H7.8V14h2.7v8h3.3Z"/>
            </svg>
          {if $cash_social_facebook}</a>{else}</span>{/if}

          <a href="{if $cash_social_linkedin}{$cash_social_linkedin|escape:'htmlall':'UTF-8'}{else}https://www.linkedin.com/company/cash-alimentaire-du-sud-est/{/if}" target="_blank" rel="noopener noreferrer" aria-label="Cash Alimentaire sur LinkedIn">
            <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false">
              <path fill="currentColor" d="M5.2 7.7H1.6V22h3.6V7.7ZM3.4 1.5A2.1 2.1 0 1 0 3.4 5.7a2.1 2.1 0 0 0 0-4.2ZM22.4 13.8c0-4.3-2.3-6.3-5.4-6.3a4.7 4.7 0 0 0-4.3 2.4V7.7H9.1V22h3.6v-7.1c0-1.9.4-3.7 2.7-3.7 2.3 0 2.3 2.1 2.3 3.8v7h3.6l.1-8.2Z"/>
            </svg>
          </a>
        </nav>
      </div>
    </div>
  </div>
</div>
