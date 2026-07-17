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
<div class="an_homeproducts-banner an_homeproducts-banner-type2 {if $banner.imgUrlFile != ''}an_homeproducts-banner-overlay{else}an_homeproducts-banner-noimg{/if} col-xl-{$banner.col|intval}">
    {if $banner.imgUrlFile !=''}
        <img class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}b-lazy{/if}"
        {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
        src="{$urls.base_url}/modules/an_theme/views/img/loading.svg" data-src="{$banner.imgUrlFile|escape:'htmlall':'UTF-8'}"
        {else}
        src="{$banner.imgUrlFile|escape:'htmlall':'UTF-8'}"
        {/if}
        width="{$banner.width|intval}" height="{$banner.height|intval}" alt="{$banner.title|escape:'htmlall':'UTF-8'}" />
    {/if}
    {if $banner.link !=''}
        <a href="{$banner.link|escape:'htmlall':'UTF-8'}" class="an_homeproducts-banner-link" aria-label="{$banner.title|escape:'htmlall':'UTF-8'}"></a>
    {/if}
    <div class="an_homeproducts-banner-content">
        {$banner.text nofilter}
        <p class="an_homeproducts-banner-title h2 {if $banner.text != ''}an_homeproducts-banner-title-margin{/if}">{$banner.title|escape:'htmlall':'UTF-8'}</p>
    </div>
</div>