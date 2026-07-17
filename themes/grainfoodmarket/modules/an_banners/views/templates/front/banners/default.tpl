{*
* 2022 Anvanto
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
*
*  @author    Anvanto <anvantoco@gmail.com>
*  @copyright 2022 Anvanto
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

<div{if $banner.col != 'div'} class="an_banner col-sm-{$banner.col|intval}"{/if}>
    {if $banner.link !=''}
        <a href="{$banner.link|escape:'htmlall':'UTF-8'}" class="an_banner-link" aria-label="{$banner.title|escape:'htmlall':'UTF-8'}"></a>
    {/if}
    {if $banner.imgUrlFile !=''}
    <div class="an_banner-img">
        <img class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}b-lazy{/if}"
        {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
        src="{$urls.base_url}/modules/an_theme/views/img/loading.svg" data-src="{$banner.imgUrlFile}"
        {else}
        src="{$banner.imgUrlFile}"
        {/if}
        width="{$banner.width|intval}" height="{$banner.height|intval}" alt="{$banner.title|escape:'htmlall':'UTF-8'}"
        />
    </div>
    {/if}
    <div class="an_banner-content">
        {$banner.text nofilter}
    </div>
</div>