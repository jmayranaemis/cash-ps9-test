{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
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
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

 <div class="cart-summary-products js-cart-summary-products">
  <p class="checkout-summary-items">{$cart.summary_string}</p>

  <p class="checkout-summary-dropdown">
    <a href="#" data-toggle="collapse" data-target="#cart-summary-product-list" class="show-details-cart js-show-details">
      {l s='show details' d='Shop.Theme.Actions'}
      <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="9px" height="5px">
      <path fill-rule="evenodd" fill="rgb(57, 181, 208)" d="M4.506,5.004 L0.012,0.007 L9.000,0.007 L4.506,5.004 Z"></path>
      </svg>
    </a>
  </p>

    {block name='cart_summary_product_list'}
      <div class="collapse" id="cart-summary-product-list">
        <ul class="media-list">
          {foreach from=$cart.products item=product}
            <li class="media">{include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}</li>
          {/foreach}
        </ul>
      </div>
    {/block}
</div>
