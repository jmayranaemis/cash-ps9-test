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
   <span class="product-image">
      {if !empty($product.default_image)}
        <picture>
          {if !empty($product.default_image.bySize.cart_default.sources.avif)}<source srcset="{$product.default_image.bySize.cart_default.sources.avif}" type="image/avif">{/if}
          {if !empty($product.default_image.bySize.cart_default.sources.webp)}<source srcset="{$product.default_image.bySize.cart_default.sources.webp}" type="image/webp">{/if}
          <img src="{$product.default_image.bySize.cart_default.url}" alt="{$product.name|escape:'quotes'}" class="img-fluid" />
        </picture>
      {else}
        <picture>
          {if !empty($urls.no_picture_image.bySize.cart_default_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.cart_default_default.sources.avif}" type="image/avif">{/if}
          {if !empty($urls.no_picture_image.bySize.cart_default_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.cart_default_default.sources.webp}" type="image/webp">{/if}
          <img src="{$urls.no_picture_image.bySize.cart_default_default.url}" alt="{$product.name|escape:'quotes'}" class="img-fluid" />
        </picture>
      {/if}
  </span>
  <div class="product-infos">
      <a class="product-name" href="{$product.url}">{$product.name}</a>
      {foreach from=$product.attributes key="attribute" item="value"}
      <div class="product-line-info">
        <span class="label">{$attribute}:</span>
        <span class="value">{$value}</span>
    </div>
    {/foreach}
    <div class="product-qty">
        <div class="product-qty-container">
            <div class="quantity-button quantity-down">–</div>
          <input
            class="product-qty-input js-cart-line-product-quantity"
            data-down-url="{$product.down_quantity_url}{if isset($product.an_group_id)}&an_group_id={$product.an_group_id|intval}{/if}"
            data-up-url="{$product.up_quantity_url}{if isset($product.an_group_id)}&an_group_id={$product.an_group_id|intval}{/if}"
            data-update-url="{$product.update_quantity_url}{if isset($product.an_group_id)}&an_group_id={$product.an_group_id|intval}{/if}"
            data-product-id="{$product.id_product}"
            type="text"
            step="1"
            value="{$product.quantity}"
            name="product-qty-spin"
            min="{$product.minimal_quantity}"
          />
          <div class="quantity-button quantity-up">+</div>
        </div>
    </div>
    <span class="product-price">{$product.price}</span>
    <span class="product-quantity">x {$product.quantity}</span>
</div>
<div class="product-remove">
    <a
    class                       = "remove-from-cart"
    rel                         = "nofollow"
    href                        = "{$product.remove_from_cart_url}{if isset($product.an_group_id)}&an_group_id={$product.an_group_id|intval}{/if}"
    data-link-action            = "delete-from-cart"
    data-id-product             = "{$product.id_product}"
    data-id-product-attribute   = "{$product.id_product_attribute}"
    data-id-customization       = "{$product.id_customization}"
    >
    {if !isset($product.is_gift) || !$product.is_gift}
    <i class="material-icons">&#xE5CD;</i>
    {/if}
</a>
</div>
{if $product.customizations|count}{/if}
