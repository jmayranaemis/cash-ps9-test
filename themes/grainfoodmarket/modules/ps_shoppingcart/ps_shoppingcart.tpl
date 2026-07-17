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
<div id="_desktop_cart" class="">
  <div class="blockcart cart-preview js-sidebar-cart-trigger {if $cart.products_count > 0}active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
    <div class="header">
        <a class="blockcart-link" rel="nofollow" href="{$cart_url}">
          <svg class="hidden-sm-down" width="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19 19"><path class="cls-1" d="M18.87,5.72H1.13a.66.66,0,0,0-.63.7L3.21,18.8a.67.67,0,0,0,.63.7H16.16a.67.67,0,0,0,.63-.7L19.5,6.42A.66.66,0,0,0,18.87,5.72ZM15.53,18.09H4.47l-2.71-11H18.24Z" transform="translate(-0.5 -0.5)"/><path class="cls-1" d="M7.17,5.08C7.59,3.59,8.7,1.91,10,1.91s2.41,1.68,2.83,3.17h1.31C13.66,2.86,12,.5,10,.5S6.34,2.86,5.86,5.08Z" transform="translate(-0.5 -0.5)"/></svg>
          {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')
            or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
            or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
            or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
          <span class="cart-text hidden-sm-down">
            {l s='Shopping Cart' d='Shop.Theme.Checkout'}
            </span>
          {/if}
          {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')
          or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
          or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
          or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
          <span class="cart-products-count hidden-sm-down">({$cart.products_count})</span>
          {/if}
          {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
            <span class="cart-products-count hidden-sm-down">{$cart.products_count}</span>
          {/if}
          <svg class="hidden-md-up" width="25" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 19 19"><path class="cls-1" d="M18.87,5.72H1.13a.66.66,0,0,0-.63.7L3.21,18.8a.67.67,0,0,0,.63.7H16.16a.67.67,0,0,0,.63-.7L19.5,6.42A.66.66,0,0,0,18.87,5.72ZM15.53,18.09H4.47l-2.71-11H18.24Z" transform="translate(-0.5 -0.5)"/><path class="cls-1" d="M7.17,5.08C7.59,3.59,8.7,1.91,10,1.91s2.41,1.68,2.83,3.17h1.31C13.66,2.86,12,.5,10,.5S6.34,2.86,5.86,5.08Z" transform="translate(-0.5 -0.5)"/></svg>
          <span class="hidden-md-up mobile-cart-item-count">{$cart.products_count}</span>
        </a>
    </div>
    <div class="cart-dropdown js-cart-source hidden-xs-up">
      <div class="cart-dropdown-wrapper">
        <div class="cart-title">
          <p class="h4 text-center">{l s='Shopping Cart' d='Shop.Theme.Checkout'}</p>
        </div>
        {if $cart.products}
          <ul class="cart-items">
            {foreach from=$cart.products item=product}
              <li class="cart-product-line">{include 'module:ps_shoppingcart/ps_shoppingcart-product-line.tpl' product=$product}</li>
            {/foreach}
          </ul>
          <div class="cart-bottom">
            <div class="cart-subtotals">
              {foreach from=$cart.subtotals item="subtotal"}
                {if $subtotal}
                <div class="total-line {$subtotal.type}">
                  <span class="label">{$subtotal.label}</span>
                  <span class="value price">{$subtotal.value}</span>
                </div>
                {/if}
              {/foreach}
            </div>
            <hr>
            <div class="cart-total total-line">
              <span class="label">{$cart.totals.total.label}</span>
              <span class="value price price-total">{$cart.totals.total.value}</span>
            </div>
            <div class="cart-action">
              <div class="text-center">
                <a href="{if Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('shoppingCart_cartAction') == 'checkout'}{$urls.pages.order}{else}{$cart_url}{/if}" class="btn btn-primary">{l s='Proceed to checkout' d='Shop.Theme.Actions'}<i class="caret-right"></i></a>
              </div>
            </div>
          </div>
        {else}
          <div class="no-items">
            {l s='There are no more items in your cart' d='Shop.Theme.Checkout'}
          </div>
        {/if}
      </div>
    </div>

  </div>
</div>
