{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
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
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  Mon espace professionnel
{/block}

{block name='page_content'}
  <section class="cash-pro-account">
    <div class="cash-pro-account__intro">
      <p class="cash-pro-account__eyebrow">Espace catalogue</p>
      <h2>Bonjour {$customer.firstname|escape:'htmlall':'UTF-8'},</h2>
      <p>Retrouvez ici vos produits favoris et les informations liées à votre compte professionnel. Les commandes en ligne ne sont pas encore disponibles.</p>
    </div>

    <div class="cash-pro-account__links">
      <a class="cash-pro-account__card" id="wishlist-link" href="{$link->getModuleLink('an_wishlist', 'list', array(), true)|escape:'htmlall':'UTF-8'}">
        <i class="material-icons" aria-hidden="true">favorite</i>
        <span><strong>Mes favoris</strong><small>Conserver et retrouver ma sélection de produits</small></span>
      </a>

      <a class="cash-pro-account__card" id="b2b-information-link" href="{$link->getModuleLink('b2bregistration', 'b2b', array(), true)|escape:'htmlall':'UTF-8'}">
        <i class="material-icons" aria-hidden="true">business_center</i>
        <span><strong>Mes informations professionnelles</strong><small>Consulter les informations de mon établissement</small></span>
      </a>

      <a class="cash-pro-account__card" id="identity-link" href="{$urls.pages.identity}">
        <i class="material-icons" aria-hidden="true">manage_accounts</i>
        <span><strong>Mes accès</strong><small>Modifier mes informations personnelles ou mon mot de passe</small></span>
      </a>

      <a class="cash-pro-account__card" id="contact-link" href="{$urls.pages.contact}">
        <i class="material-icons" aria-hidden="true">support_agent</i>
        <span><strong>Contacter Cash Alimentaire</strong><small>Poser une question ou demander un catalogue</small></span>
      </a>
    </div>
  </section>
{/block}


{block name='page_footer'}
  {block name='my_account_links'}
    <div class="text-sm-center">
      <a href="{$urls.actions.logout}" >
        {l s='Sign out' d='Shop.Theme.Actions'}
      </a>
    </div>
  {/block}
{/block}
