{*
* 2024 Anvanto
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
*
*  @author    Anvanto <anvantoco@gmail.com>
*  @copyright 2024 Anvanto
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

<article class="blog-item blog-item-type-2">
    <div class="blog-image-container">
        <div class="blog-image"> 
            <a href="{$post.link|escape:'html':'UTF-8'}" title="{$post.title|escape:'html':'UTF-8'}">
                <img {if Module::isEnabled('an_theme') AND Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                     src="{Module::getInstanceByName('an_theme')->getImageStatic('loading.svg')}" data-src="{$post.preview.url|escape:'html':'UTF-8'}"
                     {else}
                     src="{$post.preview.url|escape:'html':'UTF-8'}"
                     {/if}
                class="{if Module::isEnabled('an_theme') AND Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}b-lazy{/if}"
                width="{$post.preview.width|intval}" height="{$post.preview.height|intval}" title="{$post.title|escape:'html':'UTF-8'}" alt="{$post.title|escape:'html':'UTF-8'} {l s='image' mod='anblog'}" />
            </a>
        </div>
        {if $config->get('meta_info_pos') == 'above'}
        <div class="blog-meta">
            <span class="blog-created">
                {if $config->get('icons_meta','1')}<i class="material-icons">&#xE192;</i>{/if}
                <time class="date" datetime="{$post.format_date_add|escape:'html':'UTF-8'}">
                    {$post.format_date_add|escape:'html':'UTF-8'}
                </time>
            </span>
            {if $config->get('listing_show_counter','1')}
                <span class="blog-ctncomment">
                    {if $config->get('icons_meta','1')}<i class="material-icons">comment</i> {/if}<span>{$post.comment_count|intval} {l s='comments' mod='anblog'}</span>
                </span>
            {/if}
        </div>
        {/if}
        <div class="title h4">
            <a href="{$post.link|escape:'html':'UTF-8'}" title="{$post.title|escape:'html':'UTF-8'}">{$post.title|escape:'html':'UTF-8'}</a>
        </div>
        {if $config->get('meta_info_pos') == 'under'}
        <div class="blog-meta">
            <span class="blog-created">
                {if $config->get('icons_meta','1')}<i class="material-icons">&#xE192;</i>{/if}
                <time class="date" datetime="{$post.format_date_add|escape:'html':'UTF-8'}">
                    {$post.format_date_add|escape:'html':'UTF-8'}
                </time>
            </span>
            {if $config->get('listing_show_counter','1')}
                <span class="blog-ctncomment">
                    {if $config->get('icons_meta','1')}<i class="material-icons">comment</i> {/if}<span>{$post.comment_count|intval} {l s='comments' mod='anblog'}</span>
                </span>
            {/if}
        </div>
        {/if}
    </div>
    <div class="blog-info">
        <div class="blog-shortinfo">{$post.description|strip_tags:'UTF-8'|truncate:$config->get('listing_descr_max','90'):'...' nofilter}{* HTML form , no escape necessary *}</div>
        {if $widget.show_read_more}
        {if $config->get('listing_show_readmore', 1) == '2'}
        <a href="{$post.link|escape:'html':'UTF-8'}" title="{$post.title|escape:'html':'UTF-8'}" class="more btn btn-primary">{l s='Read more' mod='anblog'}</a>
        {else}
        <a href="{$post.link|escape:'html':'UTF-8'}" title="{$post.title|escape:'html':'UTF-8'}" class="more">{l s='Read more' mod='anblog'}</a>
        {/if}
        {/if}
    </div>
</article>
