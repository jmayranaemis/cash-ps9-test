{*
 * Surcharge Cash : six produits visibles sur ordinateur.
 *}

<div class="an_homeproducts-content js-an_homeproducts-content active" {if $widget.config.slider}data-items="6" data-nav="{$widget.config.slider_nav}" data-dots="{$widget.config.slider_dots}" data-loop="{$widget.config.slider_loop}"{/if} data-block-id="{$block.id_block|escape:'htmlall':'UTF-8'}">
    {if $block.text != ''}
        <div>{$block.text nofilter}</div>
    {/if}

    {if isset($widget.banners[$block.special_id_block]['0'])}
        {include file='./banners.tpl' banners=$widget.banners[$block.special_id_block]['0']}
    {/if}

    {if ($block.show_sort && count($block.sort)) || ($widget.config.view_type == 'tabs' && $block.link !='')}
        <div class="an_homeproducts-tab-top">
            {if $block.show_sort && count($block.sort)}
                <div class="an_homeproducts-sort">
                    <span>{l s='Sort by:' mod='an_homeproducts'}</span>
                    <select class="js-an_homeproducts-sort">
                        {foreach from=$block.sort item=sort}
                            <option value="{$sort.urlParameter|escape:'htmlall':'UTF-8'}">{$sort.label|escape:'htmlall':'UTF-8'}</option>
                        {/foreach}
                    </select>
                </div>
            {/if}

            {if $widget.config.view_type == 'tabs' && $block.link !=''}
                <a href="{$block.link|escape:'htmlall':'UTF-8'}" class="an_homeproducts-link-all">{l s='All products' mod='an_homeproducts'}</a>
            {/if}
        </div>
    {/if}

    {if $block.show_sub_cat && isset($block.childrenCats)}
        <div class="an_homeproducts-conteiner-category js-an_homeproducts-conteiner-category">
            {foreach from=$block.childrenCats item=subCat name=subcatlist}
                <a class="an_homeproducts-category js-an_homeproducts-category {if $smarty.foreach.subcatlist.index == 0}active{/if}" data-cat="{$subCat.id_category|intval}">{$subCat.name|escape:'htmlall':'UTF-8'}</a>
            {/foreach}
        </div>
    {/if}

    <section class="featured-products an_homeproducts-products clearfix mt-3 js-an_homeproducts-products">
        {include file="catalog/_partials/productlist.tpl" products=$block.products cssClass="row" productClass="col-xs-6 col-lg-4 col-xl-3"}
    </section>

    {if !$widget.config.slider && $widget.config.show_load_more && $block.productsNextPage > 0}
        <button class="btn btn-primary an_homeproducts-loadmore js-an_homeproducts-loadmore" data-page="2">{l s='Load more' mod='an_homeproducts'}</button>
    {/if}

    {if isset($widget.banners[$block.special_id_block]['1'])}
        {include file='./banners.tpl' banners=$widget.banners[$block.special_id_block]['1']}
    {/if}
</div>
