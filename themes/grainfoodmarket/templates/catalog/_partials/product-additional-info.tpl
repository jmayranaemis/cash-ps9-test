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

{assign prod_ean 1}
<div class="product-additional-info">
    <div class="product-details-info-wrapper">
        <div class="product-details-info">

            {if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('productinfo_reference') == 1}
              {if isset($product.reference_to_display) and ($product.reference_to_display != "")}
                <div class="product-reference">
                  <label class="label">{l s='Reference' d='Shop.Theme.Catalog'}: </label>
                  <span itemprop="sku">{$product.reference_to_display}</span>
                </div>
              {/if}
            {/if}
            {if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('productinfo_brand') != 'hide'}
             {if isset($product_manufacturer->id)}
              <div class="product-manufacturer">
                {if Module::getInstanceByName('an_theme')->getParam('productinfo_brand') == 'image'}
                    {if isset($manufacturer_image_url)}
                      {if isset($product_brand_url)}
                      <a href="{$product_brand_url}">
                      {/if}
                        {if version_compare($smarty.const._PS_VERSION_, '9.0.0.0', '<')}
                            <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" alt="{$product_manufacturer->name}">
                        {else}
                            <picture>
                              {if !empty($product_manufacturer.image.small.sources.avif)}<source srcset="{$product_manufacturer.image.small.sources.avif}" type="image/avif">{/if}
                              {if !empty($product_manufacturer.image.small.sources.webp)}<source srcset="{$product_manufacturer.image.small.sources.webp}" type="image/webp">{/if}
                              <img
                                src="{$product_manufacturer.image.small.url}"
                                alt="{if !empty($product_manufacturer.image.legend)}{$product_manufacturer.image.legend}{else}{$product_manufacturer.name}{/if}"
                                class="img img-thumbnail manufacturer-logo"
                                loading="lazy"
                              >
                            </picture>
                        {/if}
                      {if isset($product_brand_url)}
                      </a>
                      {/if}
                    {/if}
                  {/if}
                {if Module::getInstanceByName('an_theme')->getParam('productinfo_brand') == 'title'}
                  <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}: </label>
                  <span>
                    {if isset($product_brand_url)}
                    <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
                    {else}
                    <span>{$product_manufacturer->name}</span>
                    {/if}
                  </span>
                {/if}
              </div>
             {/if}
            {/if}
             {if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('productinfo_ean13') == 1}
              {if isset($product.specific_references)}
                 {foreach from=$product.specific_references item=reference key=key}
                   {if $key == 'ean13'}
                   {$prod_ean = 0}
                   <div class="product-ean13">
                       <label class="label">{l s='EAN13' d='Shop.Theme.Catalog'}:</label>
                       <span itemprop="ean13">{$reference}</span>
                    </div>
                   {/if}
                 {/foreach}
              {/if}
              {if isset($product->ean13) and $product->ean13 != "" and $prod_ean}
                 <div class="product-ean13">
                     <label class="label">{l s='EAN13' d='Shop.Theme.Catalog'}:</label>
                     <span itemprop="ean13">{$product->ean13|escape:'html':'UTF-8'}</span>
                 </div>
              {/if}
            {/if}
        </div>
    </div>

      {block name='product_description_short'}
    <div id="product-description-short-{$product.id}" class="productblock-description an-product-page-description" itemprop="description">{$product.description_short nofilter}</div>
    {/block}
{hook h='displaySizeGuide' product=$product}
{hook h='displayProductAdditionalInfo' product=$product}
 </div>