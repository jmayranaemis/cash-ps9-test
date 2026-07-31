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
{if isset($smarty.get.view)}
    {$orientation = ''}
    {$minis_pos = 'left'}
    {$nav_vertical = 'false'}

    {if $smarty.get.view == 'leftcol'}
         {$minis_pos = 'left'}
         {$orientation = 'an_productpage-slider-vertical'}
         {$nav_vertical = 'true'}
    {/if}
    {if $smarty.get.view == 'rightcol'}
         {$minis_pos = 'right'}
         {$orientation = 'an_productpage-slider-vertical'}
         {$nav_vertical = 'true'}
    {/if}
    {if $smarty.get.view == 'botslider'}
         {$minis_pos = 'bottom'}
    {/if}
    {if $smarty.get.view == 'botlist'}
         {$minis_pos = 'bottomlist'}
    {/if}
    {if $smarty.get.view == 'nominis'}
         {$minis_pos = 'disabled'}
    {/if}

    <div class="images-container an_productpage-slider-wrap {$orientation}">
        {block name='product_cover'}
            <div {if Module::getInstanceByName('an_theme')->getParam('productslider_zoomclick')}id="an_product-zoom"{/if} class="an_productpage-slider an_productpage-slider-main minis-{$minis_pos}" data-draggable="true">
                {foreach from=$product.images item=image}
                    <div class="an_productpage-slider-item">
                        <div class="an_productpage-slider-image">
                            <picture>
                            {if !empty($image.bySize.large_default.sources.avif)}<source srcset="{$image.bySize.large_default.sources.avif}" type="image/avif">{/if}
                            {if !empty($image.bySize.large_default.sources.webp)}<source srcset="{$image.bySize.large_default.sources.webp}" type="image/webp">{/if}
                                <img
                                    class="productslider-main-image"
                                    data-image-zoom-src="{$image.bySize.product_zoom.url}"
                                    data-width="{$product.cover.bySize.product_zoom.width}"
                                    data-height="{$product.cover.bySize.product_zoom.height}"
                                    src="{$image.bySize.large_default.url}"
                                    alt="{$image.legend}"
                                    title="{$image.legend}"
                                    width="{$image.bySize.large_default.width}"
                                    itemprop="image"
                                >
                            </picture>
                        </div>
                    </div>
                {/foreach}
                {hook h='displayAnvantoProductThumbsList' product=$product type="image"}
            </div>
        {/block}
        {if version_compare($smarty.const._PS_VERSION_, '1.7.7.0', '<')}
           <div class="an_productpage-slider-holder" style="height: {$product.cover.bySize.large_default.height}px"></div>
        {else}
            <div class="an_productpage-slider-holder" style="height: {$product.default_image.bySize.large_default.height}px"></div>
        {/if}
        {if $smarty.get.view != 'nominis' && $product.images|@count > 1}
            {block name='product_images'}
            <div class="an_productpage-slider {if $smarty.get.view == 'botlist'}an_productpage-list{else}an_productpage-slider-nav{/if} {if $product.images|@count > 4}an_productpage-slider-scroll{/if} {if $smarty.get.view == 'rightcol'}nav-vertical-right{/if}" data-vertical="{$nav_vertical}" data-draggable="true">
                {foreach from=$product.images item=image name=navimages}
                    <div class="an_productpage-slider-item {if $image.id_image == $product.cover.id_image}nav-slide-selected{/if}" data-index="{$smarty.foreach.navimages.index}">
                        <picture>
                        {if !empty($image.bySize.slider_photo.sources.avif)}<source srcset="{$image.bySize.slider_photo.sources.avif}" type="image/avif">{/if}
                        {if !empty($image.bySize.slider_photo.sources.webp)}<source srcset="{$image.bySize.slider_photo.sources.webp}" type="image/webp">{/if}
                            <img
                                src="{$image.bySize.slider_photo.url}"
                                alt="{$image.legend}"
                                title="{$image.legend}"
                                width="{$image.bySize.slider_photo.width}"
                                height="{$image.bySize.slider_photo.height}"
                                itemprop="image"
                            >
                        </picture>
                    </div>
                {/foreach}
                {hook h='displayAnvantoProductThumbsList' product=$product type="thumb"}
            </div>
            {/block}
        {/if}
    </div>
{else}
    {if Module::isEnabled('an_theme')}
        {$orientation = ''}
        {if Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') != 'none' && $product.images|@count > 1}
            {$minis_pos = Module::getInstanceByName('an_theme')->getParam('productslider_minisPos')}
            {$nav_vertical = 'false'}
            {if Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') == 'right' || Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') == 'left'}
                {$orientation = 'an_productpage-slider-vertical'}
                {$nav_vertical = 'true'}
            {/if}
        {else}
            {$minis_pos = 'disabled'}
        {/if}
    {/if}

    <div class="images-container an_productpage-slider-wrap {$orientation}">
        {block name='product_cover'}
            <div {if Module::getInstanceByName('an_theme')->getParam('productslider_zoomclick')}id="an_product-zoom"{/if} class="an_productpage-slider an_productpage-slider-main minis-{$minis_pos}" data-draggable="true">
                {foreach from=$product.images item=image}
                    <div class="an_productpage-slider-item">
                        <div class="an_productpage-slider-image">
                            <picture>
                            {if !empty($image.bySize.large_default.sources.avif)}<source srcset="{$image.bySize.large_default.sources.avif}" type="image/avif">{/if}
                            {if !empty($image.bySize.large_default.sources.webp)}<source srcset="{$image.bySize.large_default.sources.webp}" type="image/webp">{/if}
                                <img
                                    class="productslider-main-image"
                                    data-image-zoom-src="{$image.bySize.product_zoom.url}"
                                    data-width="{$product.cover.bySize.product_zoom.width}"
                                    data-height="{$product.cover.bySize.product_zoom.height}"
                                    src="{$image.bySize.large_default.url}"
                                    alt="{$image.legend}"
                                    title="{$image.legend}"
                                    width="{$image.bySize.large_default.width}"
                                    itemprop="image"
                                >
                            </picture>
                        </div>
                    </div>
                {/foreach}
                {hook h='displayAnvantoProductThumbsList' product=$product type="image"}
            </div>
        {/block}
        {if version_compare($smarty.const._PS_VERSION_, '1.7.7.0', '<')}
           <div class="an_productpage-slider-holder" style="height: {$product.cover.bySize.large_default.height}px"></div>
        {else}
            <div class="an_productpage-slider-holder" style="height: {$product.default_image.bySize.large_default.height}px"></div>
        {/if}
        {if Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') != 'none'}
            {block name='product_images'}
            <div class="an_productpage-slider {if Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') == 'bottomlist'}an_productpage-list{else}an_productpage-slider-nav{/if} {if $product.images|@count > 4}an_productpage-slider-scroll{/if} {if Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') == 'right'}nav-vertical-right{/if}" data-vertical="{$nav_vertical}" data-draggable="true">
                {foreach from=$product.images item=image name=navimages}
                    <div class="an_productpage-slider-item {if $image.id_image == $product.cover.id_image}nav-slide-selected{/if}" data-index="{$smarty.foreach.navimages.index}">
                        <picture>
                        {if !empty($image.bySize.slider_photo.sources.avif)}<source srcset="{$image.bySize.slider_photo.sources.avif}" type="image/avif">{/if}
                        {if !empty($image.bySize.slider_photo.sources.webp)}<source srcset="{$image.bySize.slider_photo.sources.webp}" type="image/webp">{/if}
                            <img
                                src="{$image.bySize.slider_photo.url}"
                                alt="{$image.legend}"
                                title="{$image.legend}"
                                width="{$image.bySize.slider_photo.width}"
                                height="{$image.bySize.slider_photo.height}"
                                itemprop="image"
                            >
                        </picture>
                    </div>
                {/foreach}
                {hook h='displayAnvantoProductThumbsList' product=$product type="thumb"}
            </div>
            {/block}
        {/if}
    </div>
{/if}
{hook h='displayAfterProductThumbs'}
