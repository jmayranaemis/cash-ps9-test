{*
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2017 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div class="block-contact col-md-3 links wrapper">
  <div class="hidden-sm-down cash-footer-brand">
    <a class="cash-footer-brand__logo" href="{$urls.base_url}" aria-label="Cash Alimentaire - accueil">
      {hook h='displayLogoFooter'}
    </a>
    <p>Grossiste alimentaire au service des professionnels de la restauration et des métiers de bouche depuis 1984.</p>
    <a class="cash-footer-brand__phone" href="tel:+33489032323">04 89 03 23 23</a>
    <span class="cash-footer-brand__hours">Lun–ven 9h–17h · Sam 8h30–12h</span>
    <div class="cash-footer-brand__actions">
      <a href="{$urls.pages.contact}">Nous contacter</a>
      <a href="{$urls.pages.stores}">Nos magasins</a>
    </div>
  </div>
  <div class="hidden-md-up">
    <div class="title">
      <a class="h3" href="{$urls.pages.stores}">{l s='Store information' d='Shop.Theme.Global'}</a>
    </div>
  </div>
</div>
