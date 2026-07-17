{*
* 2022 Anvanto
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses. 
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
*  @author Anvanto <anvantoco@gmail.com>
*  @copyright  2022 Anvanto
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of Anvanto
*}


<div class="an_homecategories">
    {if ($widget.settings.title != '') || ($widget.settings.text != '')}
        <div class="an_homecategories-head">
            {if $widget.settings.title != ''}
            <p class="h2 an_homecategories-title">{$widget.settings.title|escape:'htmlall':'UTF-8'}</p>
            {/if}
            {$widget.settings.text nofilter}
        </div>
    {/if}
    <div class="an_homecategories-list {if $widget.settings.slider}an_homecategories-slider owl-carousel owl-theme{/if}" id="an_homecategories" data-nav="{$widget.settings.slider_nav|escape:'htmlall':'UTF-8'}" data-dots="{$widget.settings.slider_dots|escape:'htmlall':'UTF-8'}" data-loop="{$widget.settings.slider_loop|escape:'htmlall':'UTF-8'}" data-autoplay="0" data-autoplaytimeout="0">
        {foreach from=$widget.homecategories item=item}
            {if $item.link != ''}
            <a href="{$item.link|escape:'htmlall':'UTF-8'}" class="an_homecategories-item">
            {else}
            <div class="an_homecategories-item">
            {/if}
                {if $item.image != ''}
                <div class="an_homecategories-image">
                    <img class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}b-lazy{/if}" {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                    src="{$urls.base_url}/modules/an_theme/views/img/loading.svg" data-src="{$item.image|escape:'htmlall':'UTF-8'}"
                    {else}
                    src="{$item.image|escape:'htmlall':'UTF-8'}"
                    {/if}
                    width="{$item.width|intval}" height="{$item.height|intval}" alt="{$item.title|escape:'htmlall':'UTF-8'} image">
                </div>
                {/if}
                {if ($item.title != '') || ($item.text != '')}
                <div class="an_homecategories-item-desc">
                    <p class="h6">{$item.title|escape:'htmlall':'UTF-8'}</p>
                    {$item.text nofilter}
                </div>
                {/if}
            {if $item.link != ''}
            </a>
            {else}
            </div>
            {/if}
        {/foreach}
    </div>
    {if $widget.settings.slider && $widget.settings.slider_nav}
        <div class="an_homecategories-nav"></div>
    {/if}
</div>
