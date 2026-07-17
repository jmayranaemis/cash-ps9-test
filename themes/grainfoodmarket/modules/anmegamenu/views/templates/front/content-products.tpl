{*
* 2025 Anvanto
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
*
*  @author    Anvanto <anvantoco@gmail.com>
*  @copyright 2025 Anvanto
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

<div class="anmm-product-list">
    {foreach from=$content.products item=product}
        <div class="anmm-product anmm-product-vertical">
            <div class="product-miniature">
                <div class="thumbnail-container">
                    {if $product.cover}
                    <div class="anmm-product-img">
                        <a href="{$product.link|escape:'htmlall':'UTF-8'}" class="thumbnail product-thumbnail">
                            <picture>
                                {if !empty($product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.sources.avif)}<source srcset="{$product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.sources.avif}" type="image/avif">{/if}
                                {if !empty($product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.sources.webp)}<source srcset="{$product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.sources.webp}" type="image/webp">{/if}
                                <img
                                    src="{$product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.url|escape:'htmlall':'UTF-8'}"
                                    width="{$product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.width|intval}"
                                    height="{$product.cover.bySize.{$content.product_image_type|escape:'htmlall':'UTF-8'}.height|intval}"
                                    alt="{if !empty($product.cover.legend)}{$product.cover.legend|escape:'htmlall':'UTF-8'}{else}{$product.name|escape:'htmlall':'UTF-8'|truncate:30:'...'}{/if}"
                                />
                            </picture>
                        </a>
                    </div>
                    {/if}
                    <div class="product-description">
                        <div class="h3 product-title"><a href="{$product.link|escape:'htmlall':'UTF-8'}">{$product.name|escape:'htmlall':'UTF-8'}</a></div>
                        <div class="product-price-and-shipping">
                            <div class="product-price-wrap-inner">
                                <span class="price">{$product.price|escape:'htmlall':'UTF-8'}</span>
                                {if $product.has_discount}
                                <span class="regular-price">{$product.regular_price|escape:'htmlall':'UTF-8'}</span>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
</div>