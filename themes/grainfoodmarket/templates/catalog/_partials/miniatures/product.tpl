{*
* 2021 Anvanto
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses.
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
*  @author Anvanto <anvantoco@gmail.com>
*  @copyright  2021 Anvanto
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of Anvanto
*}
 {assign currency_code Context::getContext()->currency->iso_code}
{$image_limit = Module::getInstanceByName('an_theme')->getParam('segmentedviewsettinds_imagelimit')}
{block name='product_miniature_item'}
  <article class="product-miniature js-product js-product-miniature
{if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('product_productImageChange') == 'hover-slider'}
product-miniature-hover-slider
{/if}
{if Module::isEnabled('an_theme')}
js-img-view-type
type-{Module::getInstanceByName('an_theme')->getParam('product_productImageChange')}
{/if}
{if isset($smarty.get.view)}
		{if $smarty.get.view == 'col2'}
			col-lg-6
		{/if}
		{if $smarty.get.view == 'col3'}
			col-lg-4
		{/if}
		{if $smarty.get.view == 'col4'}
			col-lg-3
		{/if}
		{if $smarty.get.view == 'row'}
			col-lg-12
		{/if}
	{else}
    {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
        {if isset($smarty.cookies.an_collection_view)}
          col-lg-{$smarty.cookies.an_collection_view}
        {else}
          {Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount')}
        {/if}
      {/if}
  {/if}
{if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('product_productMobileRow')}
product-mobile-row
{/if}
 {if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('product_productHeight')}
      product-height
      {/if}
  " data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
		{if isset($product->ean13) AND $product->ean13}
        <meta itemprop="gtin13" content="{l s='EAN Code:'}{$product->ean13}">
        {/if}
        {if isset($product->isbn) AND $product->isbn}
        <meta itemprop="gtin13" content="{l s='ISBN Code:'}{$product->isbn}">
        {/if}
        {if isset($product->upc) AND $product->upc}
        <meta itemprop="gtin13" content="{l s='UPC Code:'}{$product->upc}">
        {/if}
		{if $product.cover.large.url}
		<meta itemprop="image" content="{$product.cover.large.url}">
		{/if}
		{if $product.id_manufacturer}
		<div itemprop="brand" itemtype="https://schema.org/Brand" itemscope>
        <meta itemprop="name" content="{Manufacturer::getnamebyid($product.id_manufacturer)}">
        </div>
		{/if}
		{if $product.description_short}
		<meta itemprop="description" content="{$product.description_short|strip_tags:'UTF-8'}">
		{/if}
		<meta itemprop="sku" content="{$product.id_product}">
    <div class="thumbnail-container">
         <div class="thumbnail-container-image" style="min-height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">
        {block name='product_thumbnail'}
        {if !$product.cover}
        		<a href="{$product.url}" class="thumbnail product-thumbnail"
        		style="height: {if isset($page) and $page.page_name == 'category'}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$urls.no_picture_image.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$urls.no_picture_image.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$urls.no_picture_image.bySize.catalog_large.height|strip}{else}{$urls.no_picture_image.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$urls.no_picture_image.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$urls.no_picture_image.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$urls.no_picture_image.bySize.catalog_large.height|strip}{else}{$urls.no_picture_image.bySize.home_default.height|strip}{/if}{/if}{else}{$urls.no_picture_image.bySize.home_default.height|strip}{/if}px;">
                    <picture>
                        {if isset($page) and $page.page_name == 'category'}
                             {if isset($smarty.cookies.an_collection_view)}
                                     {if $smarty.cookies.an_collection_view == 3}
                                            {if !empty($urls.no_picture_image.bySize.catalog_small.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.catalog_small.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                     {elseif $smarty.cookies.an_collection_view == 4}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {elseif $smarty.cookies.an_collection_view == 6}
                                            {if !empty($urls.no_picture_image.bySize.catalog_large.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.catalog_large.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                     {else}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {/if}
                             {else}
                                         {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                            {if !empty($urls.no_picture_image.bySize.catalog_small.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.catalog_small.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                            {if !empty($urls.no_picture_image.bySize.catalog_large.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.catalog_large.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                     {else}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                            {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {/if}
                             {/if}
                          {else}
                            {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                            {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                          {/if}
                        <img
                          src="
                          {if isset($page) and $page.page_name == 'category'}
                             {if isset($smarty.cookies.an_collection_view)}
                                     {if $smarty.cookies.an_collection_view == 3}
                                             {$urls.no_picture_image.bySize.catalog_small.url}
                                     {elseif $smarty.cookies.an_collection_view == 4}
                                             {$urls.no_picture_image.bySize.home_default.url}
                                     {elseif $smarty.cookies.an_collection_view == 6}
                                             {$urls.no_picture_image.bySize.catalog_large.url}
                                     {else}
                                             {$urls.no_picture_image.bySize.home_default.url}
                                     {/if}
                             {else}
                                         {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                             {$urls.no_picture_image.bySize.catalog_small.url}
                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                             {$urls.no_picture_image.bySize.home_default.url}
                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                             {$urls.no_picture_image.bySize.catalog_large.url}
                                     {else}
                                             {$urls.no_picture_image.bySize.home_default.url}
                                     {/if}
                             {/if}
                          {else}
                            {$urls.no_picture_image.bySize.home_default.url}
                          {/if}
                          "
                          data-catalog-small="{$urls.no_picture_image.bySize.catalog_small.url}"
                          data-catalog-medium="{$urls.no_picture_image.bySize.home_default.url}"
                          data-catalog-large="{$urls.no_picture_image.bySize.catalog_large.url}"
                          data-width="{$urls.no_picture_image.bySize.home_default.width}"
                          data-height="{$urls.no_picture_image.bySize.home_default.height}"
                        >
                    </picture>
                  </a>


                {else}
        {if Module::isEnabled('an_theme')}
          {if Module::getInstanceByName('an_theme')->getParam('product_productImageChange') == 'standart'}
         <a href="{$product.url}" class="thumbnail product-thumbnail"
         	        style="height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">
         						<picture>
         						    {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                         {if isset($smarty.cookies.an_collection_view)}
                                             {if $smarty.cookies.an_collection_view == 3}
                                                 {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                             {elseif $smarty.cookies.an_collection_view == 4}
                                                 {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                             {elseif $smarty.cookies.an_collection_view == 6}
                                                 {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                             {else}
                                                 {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                             {/if}
                                         {else}
                                             {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                                 {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                             {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                                 {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                             {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                                 {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                             {else}
                                                 {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                                 {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                             {/if}
                                         {/if}
                                     {else}
                                         {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                         {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {/if}
         						<img
         							src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
         							 {$urls.base_url}/modules/an_theme/views/img/loading.svg
         							 {else}
         							    {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                             {if isset($smarty.cookies.an_collection_view)}
                                 {if $smarty.cookies.an_collection_view == 3}
                                     {$product.cover.bySize.catalog_small.url}
                                 {elseif $smarty.cookies.an_collection_view == 4}
                                     {$product.cover.bySize.home_default.url}
                                 {elseif $smarty.cookies.an_collection_view == 6}
                                     {$product.cover.bySize.catalog_large.url}
                                 {else}
                                     {$product.cover.bySize.home_default.url}
                                 {/if}
                             {else}
                                   {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                     {$product.cover.bySize.catalog_small.url}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                     {$product.cover.bySize.home_default.url}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                     {$product.cover.bySize.catalog_large.url}
                                 {else}
                                     {$product.cover.bySize.home_default.url}
                                 {/if}
                             {/if}
                         {else}
                             {$product.cover.bySize.home_default.url}
                         {/if}
         							 {/if}"
                        {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                        data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                        {/if}
         							data-catalog-small="{$product.cover.bySize.catalog_small.url}"
         							data-catalog-medium="{$product.cover.bySize.home_default.url}"
         							data-catalog-large="{$product.cover.bySize.catalog_large.url}"
         							alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
         							data-full-size-image-url="{$product.cover.large.url}"
         							class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if}"
         							data-width="{$product.cover.bySize.home_default.width}"
         							data-height="{$product.cover.bySize.home_default.height}"
         							width="{$product.cover.bySize.home_default.width}"
         							height="{$product.cover.bySize.home_default.height}"
         							content="{$product.cover.bySize.home_default.url}"
                       data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                             {if isset($smarty.cookies.an_collection_view)}
                                 {if $smarty.cookies.an_collection_view == 3}
                                     {$product.cover.bySize.catalog_small.url}
                                 {elseif $smarty.cookies.an_collection_view == 4}
                                     {$product.cover.bySize.home_default.url}
                                 {elseif $smarty.cookies.an_collection_view == 6}
                                     {$product.cover.bySize.catalog_large.url}
                                 {else}
                                     {$product.cover.bySize.home_default.url}
                                 {/if}
                             {else}
                                 {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                     {$product.cover.bySize.catalog_small.url}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                     {$product.cover.bySize.home_default.url}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                     {$product.cover.bySize.catalog_large.url}
                                 {else}
                                     {$product.cover.bySize.home_default.url}
                                 {/if}
                             {/if}
                         {else}
                             {$product.cover.bySize.home_default.url}
                         {/if}"
         						>
                        </picture>
         		    </a>
          {elseif Module::getInstanceByName('an_theme')->getParam('product_productImageChange') == 'hover'}
            <a href="{$product.url}" class="thumbnail product-thumbnail"
                      style="height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">
  					{assign "imgcount" "1"}
  					{assign "hascover" "0"}
  					{foreach from=$product.images item=image name=foo2}
  					    {if ($image.id_image == $product.cover.id_image)}
  					        {$hascover=1}
  					    {/if}
  					{/foreach}
  					{if $hascover == 0}
  					    {$imgcount=$imgcount+1}
  					{/if}
                     {foreach from=$product.images item=image name=foo}
                     {if ($image.id_image == $product.cover.id_image) or $imgcount or $hascover}
                       {if ($image.id_image == $product.cover.id_image)}{$hascover=0}{$imgcount=$imgcount+1}{/if}
                       {$imgcount=$imgcount-1}
                         <picture>
                            {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                  {if isset($smarty.cookies.an_collection_view)}
                                      {if $smarty.cookies.an_collection_view == 3}
                                          {if !empty($image.bySize.catalog_small.sources.avif)}<source srcset="{$image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_small.sources.webp)}<source srcset="{$image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                      {elseif $smarty.cookies.an_collection_view == 4}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {elseif $smarty.cookies.an_collection_view == 6}
                                          {if !empty($image.bySize.catalog_large.sources.avif)}<source srcset="{$image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_large.sources.webp)}<source srcset="{$image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                      {else}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {/if}
                                  {else}
                                      {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                          {if !empty($image.bySize.catalog_small.sources.avif)}<source srcset="{$image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_small.sources.webp)}<source srcset="{$image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                          {if !empty($image.bySize.catalog_large.sources.avif)}<source srcset="{$image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_large.sources.webp)}<source srcset="{$image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                      {else}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {/if}
                                  {/if}
                              {else}
                                  {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                  {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                              {/if}
                          <img
                              class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if} img_hover_change {if ($image.id_image == $product.cover.id_image) || (($hascover == 0) && $smarty.foreach.foo.index == 0)} cover {/if} {if $smarty.foreach.foo.total == 1 } only_one {/if}"
                              data-full-size-image-url="{$image.bySize.large_default.url}"
                              src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                              {$urls.base_url}/modules/an_theme/views/img/loading.svg
                              {else}
                              {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                  {if isset($smarty.cookies.an_collection_view)}
                                      {if $smarty.cookies.an_collection_view == 3}
                                          {$image.bySize.catalog_small.url}
                                      {elseif $smarty.cookies.an_collection_view == 4}
                                          {$image.bySize.home_default.url}
                                      {elseif $smarty.cookies.an_collection_view == 6}
                                          {$image.bySize.catalog_large.url}
                                      {else}
                                          {$image.bySize.home_default.url}
                                      {/if}
                                  {else}
                                      {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                          {$image.bySize.catalog_small.url}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                          {$image.bySize.home_default.url}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                          {$image.bySize.catalog_large.url}
                                      {else}
                                          {$image.bySize.home_default.url}
                                      {/if}
                                  {/if}
                              {else}
                                  {$image.bySize.home_default.url}
                              {/if}
                          {/if}"
                          {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                          data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                          {/if}
                          data-catalog-small="{$image.bySize.catalog_small.url}"
                          data-catalog-medium="{$image.bySize.home_default.url}"
                          data-catalog-large="{$image.bySize.catalog_large.url}"
                          alt="{$image.legend}"
                          data-width="{$image.bySize.home_default.width}"
                          data-height="{$image.bySize.home_default.height}"
                          content="{$image.bySize.home_default.url}"
                          data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                              {if isset($smarty.cookies.an_collection_view)}
                                  {if $smarty.cookies.an_collection_view == 3}
                                      {$image.bySize.catalog_small.url}
                                  {elseif $smarty.cookies.an_collection_view == 4}
                                      {$image.bySize.home_default.url}
                                  {elseif $smarty.cookies.an_collection_view == 6}
                                      {$image.bySize.catalog_large.url}
                                  {else}
                                      {$image.bySize.home_default.url}
                                  {/if}
                              {else}
                                  {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                      {$image.bySize.catalog_small.url}
                                  {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                      {$image.bySize.home_default.url}
                                  {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                      {$image.bySize.catalog_large.url}
                                  {else}
                                      {$image.bySize.home_default.url}
                                  {/if}
                              {/if}
                          {else}
                              {$image.bySize.home_default.url}
                        {/if}"
                        >

                         </picture>
                        {/if}
                      {/foreach}
                      </a>
          {elseif Module::getInstanceByName('an_theme')->getParam('product_productImageChange') == 'hover-slider'}
            <a href="{$product.url}" class="thumbnail product-thumbnail hover_slider"
                                  style="height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">

              <ul {if $product.images|@count == 1} class="only_one_item"{/if}>
                <li class="cover-item">
                  <div class="hover-slider-img">
                    <picture>
                        {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                             {if isset($smarty.cookies.an_collection_view)}
                                 {if $smarty.cookies.an_collection_view == 3}
                                     {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                 {elseif $smarty.cookies.an_collection_view == 4}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {elseif $smarty.cookies.an_collection_view == 6}
                                     {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                 {else}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {/if}
                             {else}
                                 {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                     {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                     {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                 {else}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {/if}
                             {/if}
                         {else}
                             {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                             {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                         {/if}
                    <img
                             							src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                             							 {$urls.base_url}/modules/an_theme/views/img/loading.svg
                             							 {else}
                             							    {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                                 {if isset($smarty.cookies.an_collection_view)}
                                                     {if $smarty.cookies.an_collection_view == 3}
                                                         {$product.cover.bySize.catalog_small.url}
                                                     {elseif $smarty.cookies.an_collection_view == 4}
                                                         {$product.cover.bySize.home_default.url}
                                                     {elseif $smarty.cookies.an_collection_view == 6}
                                                         {$product.cover.bySize.catalog_large.url}
                                                     {else}
                                                         {$product.cover.bySize.home_default.url}
                                                     {/if}
                                                 {else}
                                                       {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                                         {$product.cover.bySize.catalog_small.url}
                                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                                         {$product.cover.bySize.home_default.url}
                                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                                         {$product.cover.bySize.catalog_large.url}
                                                     {else}
                                                         {$product.cover.bySize.home_default.url}
                                                     {/if}
                                                 {/if}
                                             {else}
                                                 {$product.cover.bySize.home_default.url}
                                             {/if}
                             							 {/if}"
                                            {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                                            data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                                            {/if}
                             							data-catalog-small="{$product.cover.bySize.catalog_small.url}"
                             							data-catalog-medium="{$product.cover.bySize.home_default.url}"
                             							data-catalog-large="{$product.cover.bySize.catalog_large.url}"
                             							alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                             							data-full-size-image-url="{$product.cover.large.url}"
                             							class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if}  hover-slider-image"
                             							data-width="{$product.cover.bySize.home_default.width}"
                                                        data-height="{$product.cover.bySize.home_default.height}"
                                                        width="{$product.cover.bySize.home_default.width}"
                             							height="{$product.cover.bySize.home_default.height}"
                             							content="{$product.cover.bySize.home_default.url}"
                                           data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                                 {if isset($smarty.cookies.an_collection_view)}
                                                     {if $smarty.cookies.an_collection_view == 3}
                                                         {$product.cover.bySize.catalog_small.url}
                                                     {elseif $smarty.cookies.an_collection_view == 4}
                                                         {$product.cover.bySize.home_default.url}
                                                     {elseif $smarty.cookies.an_collection_view == 6}
                                                         {$product.cover.bySize.catalog_large.url}
                                                     {else}
                                                         {$product.cover.bySize.home_default.url}
                                                     {/if}
                                                 {else}
                                                     {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                                         {$product.cover.bySize.catalog_small.url}
                                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                                         {$product.cover.bySize.home_default.url}
                                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                                         {$product.cover.bySize.catalog_large.url}
                                                     {else}
                                                         {$product.cover.bySize.home_default.url}
                                                     {/if}
                                                 {/if}
                                             {else}
                                                 {$product.cover.bySize.home_default.url}
                                             {/if}"
                             						>
                    </picture>
                  </div>
                </li>
                          {$image_limit_other = $image_limit}
                          {foreach from=$product.images item=image name=hoverslider}
                              {if $smarty.foreach.hoverslider.iteration == $image_limit and $image.id_image == $product.cover.id_image }
                                {$image_limit_other = $image_limit-1}
                              {elseif $smarty.foreach.hoverslider.iteration > $image_limit and $image.id_image == $product.cover.id_image }
                                  {$image_limit_other = $image_limit-1}
                              {/if}
                          {/foreach}
                {foreach from=$product.images item=image name=hoverslider}
                              {if $image.id_image != $product.cover.id_image and $smarty.foreach.hoverslider.iteration <= $image_limit_other}
                    <li class="no-cover-item">
                      <div class="hover-slider-img">
                        {if Module::getInstanceByName('an_theme')->getParam('segmentedviewsettinds_textonlastimg') == 1}
                          {if $smarty.foreach.hoverslider.iteration == $image_limit_other and ($product.images|@count-$image_limit)>0}
                            <div class="more-images">
                              {$product.images|@count-$image_limit}
                              {if ($product.images|@count-$image_limit) == 1}
                                {l s='more image' d='Shop.Theme.Actions'}
                              {else}
                                {l s='more images' d='Shop.Theme.Actions'}
                              {/if}
                            </div>
                          {/if}
                        {/if}
                        <picture>
                            {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                  {if isset($smarty.cookies.an_collection_view)}
                                      {if $smarty.cookies.an_collection_view == 3}
                                          {if !empty($image.bySize.catalog_small.sources.avif)}<source srcset="{$image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_small.sources.webp)}<source srcset="{$image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                      {elseif $smarty.cookies.an_collection_view == 4}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {elseif $smarty.cookies.an_collection_view == 6}
                                          {if !empty($image.bySize.catalog_large.sources.avif)}<source srcset="{$image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_large.sources.webp)}<source srcset="{$image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                      {else}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {/if}
                                  {else}
                                      {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                          {if !empty($image.bySize.catalog_small.sources.avif)}<source srcset="{$image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_small.sources.webp)}<source srcset="{$image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                          {if !empty($image.bySize.catalog_large.sources.avif)}<source srcset="{$image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.catalog_large.sources.webp)}<source srcset="{$image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                      {else}
                                          {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                          {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                      {/if}
                                  {/if}
                              {else}
                                  {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                  {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                              {/if}
                        <img
                                                      class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if}  hover-slider-image"
                                                      data-full-size-image-url="{$image.bySize.large_default.url}"
                                                      src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                                                      {$urls.base_url}/modules/an_theme/views/img/loading.svg
                                                      {else}
                                                      {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                                          {if isset($smarty.cookies.an_collection_view)}
                                                              {if $smarty.cookies.an_collection_view == 3}
                                                                  {$image.bySize.catalog_small.url}
                                                              {elseif $smarty.cookies.an_collection_view == 4}
                                                                  {$image.bySize.home_default.url}
                                                              {elseif $smarty.cookies.an_collection_view == 6}
                                                                  {$image.bySize.catalog_large.url}
                                                              {else}
                                                                  {$image.bySize.home_default.url}
                                                              {/if}
                                                          {else}
                                                              {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                                                  {$image.bySize.catalog_small.url}
                                                              {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                                                  {$image.bySize.home_default.url}
                                                              {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                                                  {$image.bySize.catalog_large.url}
                                                              {else}
                                                                  {$image.bySize.home_default.url}
                                                              {/if}
                                                          {/if}
                                                      {else}
                                                          {$image.bySize.home_default.url}
                                                      {/if}
                                                  {/if}"
                                                  {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                                                  data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                                                  {/if}
                                                  data-catalog-small="{$image.bySize.catalog_small.url}"
                                                  data-catalog-medium="{$image.bySize.home_default.url}"
                                                  data-catalog-large="{$image.bySize.catalog_large.url}"
                                                  alt="{$image.legend}"
                                                  data-width="{$image.bySize.home_default.width}"
                                                  data-height="{$image.bySize.home_default.height}"
                                                  width="{$image.bySize.home_default.width}"
                                                  height="{$image.bySize.home_default.height}"
                                                  content="{$image.bySize.home_default.url}"
                                                  data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                                      {if isset($smarty.cookies.an_collection_view)}
                                                          {if $smarty.cookies.an_collection_view == 3}
                                                              {$image.bySize.catalog_small.url}
                                                          {elseif $smarty.cookies.an_collection_view == 4}
                                                              {$image.bySize.home_default.url}
                                                          {elseif $smarty.cookies.an_collection_view == 6}
                                                              {$image.bySize.catalog_large.url}
                                                          {else}
                                                              {$image.bySize.home_default.url}
                                                          {/if}
                                                      {else}
                                                          {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                                              {$image.bySize.catalog_small.url}
                                                          {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                                              {$image.bySize.home_default.url}
                                                          {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                                              {$image.bySize.catalog_large.url}
                                                          {else}
                                                              {$image.bySize.home_default.url}
                                                          {/if}
                                                      {/if}
                                                  {else}
                                                      {$image.bySize.home_default.url}
                                                {/if}"
                                                >
                        </picture>
                      </div>
                    </li>
                  {/if}
                {/foreach}
              </ul>
            </a>
          {else}
          <div class="slider_product-wrapper">
                      <div class="slider-product-item">
                       <a href="{$product.url}" class="thumbnail product-thumbnail"
                       style="height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">

                    <picture>
                        {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                             {if isset($smarty.cookies.an_collection_view)}
                                 {if $smarty.cookies.an_collection_view == 3}
                                     {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                 {elseif $smarty.cookies.an_collection_view == 4}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {elseif $smarty.cookies.an_collection_view == 6}
                                     {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                 {else}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {/if}
                             {else}
                                 {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                     {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                     {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                 {else}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {/if}
                             {/if}
                         {else}
                             {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                             {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                         {/if}

                         <img
                        src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                              {$urls.base_url}/modules/an_theme/views/img/loading.svg
                          {else}
                              {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                  {if isset($smarty.cookies.an_collection_view)}
                                      {if $smarty.cookies.an_collection_view == 3}
                                          {$product.cover.bySize.catalog_small.url}
                                      {elseif $smarty.cookies.an_collection_view == 4}
                                          {$product.cover.bySize.home_default.url}
                                      {elseif $smarty.cookies.an_collection_view == 6}
                                          {$product.cover.bySize.catalog_large.url}
                                      {else}
                                          {$product.cover.bySize.home_default.url}
                                      {/if}
                                  {else}
                                      {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                          {$product.cover.bySize.catalog_small.url}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                          {$product.cover.bySize.home_default.url}
                                      {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                          {$product.cover.bySize.catalog_large.url}
                                      {else}
                                          {$product.cover.bySize.home_default.url}
                                      {/if}
                                  {/if}
                              {else}
                                  {$product.cover.bySize.home_default.url}
                              {/if}
                          {/if}"
                            {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                          data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                          {/if}
                          data-catalog-small="{$product.cover.bySize.catalog_small.url}"
                          data-catalog-medium="{$product.cover.bySize.home_default.url}"
                          data-catalog-large="{$product.cover.bySize.catalog_large.url}"
                         alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                         data-full-size-image-url="{$product.cover.large.url}"
                         class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if} slider_product cover"
                         data-width="{$product.cover.bySize.home_default.width}"
                         data-height="{$product.cover.bySize.home_default.height}"
                         content="{$product.cover.bySize.home_default.url}"
                         data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                          {if isset($smarty.cookies.an_collection_view)}
                              {if $smarty.cookies.an_collection_view == 3}
                                  {$product.cover.bySize.catalog_small.url}
                              {elseif $smarty.cookies.an_collection_view == 4}
                                  {$product.cover.bySize.home_default.url}
                              {elseif $smarty.cookies.an_collection_view == 6}
                                  {$product.cover.bySize.catalog_large.url}
                              {else}
                                  {$product.cover.bySize.home_default.url}
                              {/if}
                          {else}
                                {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                  {$product.cover.bySize.catalog_small.url}
                              {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                  {$product.cover.bySize.home_default.url}
                              {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                  {$product.cover.bySize.catalog_large.url}
                              {else}
                                  {$product.cover.bySize.home_default.url}
                              {/if}
                          {/if}
                        {else}
                          {$product.cover.bySize.home_default.url}
                        {/if}"
                        >
                        </picture>
                      </a>
                     </div>
                       {foreach from=$product.images item=image}
                         {if $image.id_image != $product.cover.id_image}
                         <div class="slider-product-item">
                         <a href="{$product.url}" class="thumbnail product-thumbnail"
                         style="height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">
                       <picture>
                           {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                 {if isset($smarty.cookies.an_collection_view)}
                                     {if $smarty.cookies.an_collection_view == 3}
                                         {if !empty($image.bySize.catalog_small.sources.avif)}<source srcset="{$image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.catalog_small.sources.webp)}<source srcset="{$image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                     {elseif $smarty.cookies.an_collection_view == 4}
                                         {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {elseif $smarty.cookies.an_collection_view == 6}
                                         {if !empty($image.bySize.catalog_large.sources.avif)}<source srcset="{$image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.catalog_large.sources.webp)}<source srcset="{$image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                     {else}
                                         {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {/if}
                                 {else}
                                     {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                         {if !empty($image.bySize.catalog_small.sources.avif)}<source srcset="{$image.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.catalog_small.sources.webp)}<source srcset="{$image.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                         {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                         {if !empty($image.bySize.catalog_large.sources.avif)}<source srcset="{$image.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.catalog_large.sources.webp)}<source srcset="{$image.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                     {else}
                                         {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                         {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                     {/if}
                                 {/if}
                             {else}
                                 {if !empty($image.bySize.home_default.sources.avif)}<source srcset="{$image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                 {if !empty($image.bySize.home_default.sources.webp)}<source srcset="{$image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                             {/if}

                           <img
                           class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if} slider_product not_cover"
                            data-full-size-image-url="{$image.bySize.large_default.url}"
                            src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                              {$urls.base_url}/modules/an_theme/views/img/loading.svg
                              {else}
                                  {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                              {if isset($smarty.cookies.an_collection_view)}
                                  {if $smarty.cookies.an_collection_view == 3}
                                      {$image.bySize.catalog_small.url}
                                  {elseif $smarty.cookies.an_collection_view == 4}
                                      {$image.bySize.home_default.url}
                                  {elseif $smarty.cookies.an_collection_view == 6}
                                      {$image.bySize.catalog_large.url}
                                  {else}
                                      {$image.bySize.home_default.url}
                                  {/if}
                              {else}
                                    {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                      {$image.bySize.catalog_small.url}
                                  {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                      {$image.bySize.home_default.url}
                                  {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                      {$image.bySize.catalog_large.url}
                                  {else}
                                      {$image.bySize.home_default.url}
                                  {/if}
                              {/if}
                          {else}
                              {$image.bySize.home_default.url}
                          {/if}
                          {/if}"
                          {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                        data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                        {/if}
                          data-catalog-small="{$image.bySize.catalog_small.url}"
                          data-catalog-medium="{$image.bySize.home_default.url}"
                          data-catalog-large="{$image.bySize.catalog_large.url}"
                          alt="{$image.legend}"
                          data-width="{$image.bySize.home_default.width}"
                          data-height="{$image.bySize.home_default.height}"
                          content="{$image.bySize.home_default.url}"
                          data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                              {if isset($smarty.cookies.an_collection_view)}
                                  {if $smarty.cookies.an_collection_view == 3}
                                      {$image.bySize.catalog_small.url}
                                  {elseif $smarty.cookies.an_collection_view == 4}
                                      {$image.bySize.home_default.url}
                                  {elseif $smarty.cookies.an_collection_view == 6}
                                      {$image.bySize.catalog_large.url}
                                  {else}
                                      {$image.bySize.home_default.url}
                                  {/if}
                              {else}
                                  {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                      {$image.bySize.catalog_small.url}
                                  {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                      {$image.bySize.home_default.url}
                                  {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                      {$image.bySize.catalog_large.url}
                                  {else}
                                      {$image.bySize.home_default.url}
                                  {/if}
                              {/if}
                          {else}
                              {$image.bySize.home_default.url}
                          {/if}"
                           >
                           </picture>
                          </a>
                         </div>
                          {/if}
                         {/foreach}
                     </div>
          {/if}
      {else}
      <a href="{$product.url}" class="thumbnail product-thumbnail"
            style="height: {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}{if isset($smarty.cookies.an_collection_view)|strip}{if $smarty.cookies.an_collection_view == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif $smarty.cookies.an_collection_view == 4}{$product.cover.bySize.home_default.height|strip}{elseif $smarty.cookies.an_collection_view == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{else}{if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}{$product.cover.bySize.catalog_small.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}{$product.cover.bySize.home_default.height|strip}{elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}{$product.cover.bySize.catalog_large.height|strip}{else}{$product.cover.bySize.home_default.height|strip}{/if}{/if}{else}{$product.cover.bySize.home_default.height|strip}{/if}px;">
                    <picture>
                        {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                             {if isset($smarty.cookies.an_collection_view)}
                                 {if $smarty.cookies.an_collection_view == 3}
                                     {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                 {elseif $smarty.cookies.an_collection_view == 4}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {elseif $smarty.cookies.an_collection_view == 6}
                                     {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                 {else}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {/if}
                             {else}
                                 {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                     {if !empty($product.cover.bySize.catalog_small.sources.avif)}<source srcset="{$product.cover.bySize.catalog_small.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_small.sources.webp)}<source srcset="{$product.cover.bySize.catalog_small.sources.webp}" type="image/webp">{/if}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                     {if !empty($product.cover.bySize.catalog_large.sources.avif)}<source srcset="{$product.cover.bySize.catalog_large.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.catalog_large.sources.webp)}<source srcset="{$product.cover.bySize.catalog_large.sources.webp}" type="image/webp">{/if}
                                 {else}
                                     {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                                     {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                                 {/if}
                             {/if}
                         {else}
                             {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                             {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                         {/if}

      					<img
      					class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if}"
      					src="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
      							 {$urls.base_url}/modules/an_theme/views/img/loading.svg
      							 {else}
      							    {if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                          {if isset($smarty.cookies.an_collection_view)}
                              {if $smarty.cookies.an_collection_view == 3}
                                  {$product.cover.bySize.catalog_small.url}
                              {elseif $smarty.cookies.an_collection_view == 4}
                                  {$product.cover.bySize.home_default.url}
                              {elseif $smarty.cookies.an_collection_view == 6}
                                  {$product.cover.bySize.catalog_large.url}
                              {else}
                                  {$product.cover.bySize.home_default.url}
                              {/if}
                          {else}
                                {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                                  {$product.cover.bySize.catalog_small.url}
                              {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                                  {$product.cover.bySize.home_default.url}
                              {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                                  {$product.cover.bySize.catalog_large.url}
                              {else}
                                  {$product.cover.bySize.home_default.url}
                              {/if}
                          {/if}
                      {else}
                          {$product.cover.bySize.home_default.url}
                      {/if}
      							 {/if}"
                     {if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')}
                     data-lazy-gif="{$urls.base_url}/modules/an_theme/views/img/loading.svg"
                     {/if}
      							data-catalog-small="{$product.cover.bySize.catalog_small.url}"
      							data-catalog-medium="{$product.cover.bySize.home_default.url}"
      							data-catalog-large="{$product.cover.bySize.catalog_large.url}"
      						alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
      						data-full-size-image-url="{$product.cover.large.url}"
      						class="{if Module::getInstanceByName('an_theme')->getParam('product_lazyLoad')} b-lazy {/if} "
      						data-width="{$product.cover.bySize.home_default.width}"
      						data-height="{$product.cover.bySize.home_default.height}"
      						content="{$product.cover.bySize.home_default.url}"
      						data-src="{if isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                      {if isset($smarty.cookies.an_collection_view)}
                          {if $smarty.cookies.an_collection_view == 3}
                              {$product.cover.bySize.catalog_small.url}
                          {elseif $smarty.cookies.an_collection_view == 4}
                              {$product.cover.bySize.home_default.url}
                          {elseif $smarty.cookies.an_collection_view == 6}
                              {$product.cover.bySize.catalog_large.url}
                          {else}
                              {$product.cover.bySize.home_default.url}
                          {/if}
                      {else}
                            {if Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 3}
                              {$product.cover.bySize.catalog_small.url}
                          {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 4}
                              {$product.cover.bySize.home_default.url}
                          {elseif Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 6}
                              {$product.cover.bySize.catalog_large.url}
                          {else}
                              {$product.cover.bySize.home_default.url}
                          {/if}
                      {/if}
                    {else}
                      {$product.cover.bySize.home_default.url}
                    {/if}"
      					>
                </picture>
      	    </a>
    {/if}
    {/if}
    {/block}

      {if !Module::isEnabled('an_productattributes')}
        {block name='product_variants'}
        {if $product.main_variants}
          {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
        {/if}
        {/block}
      {/if}



			<div class="highlighted-informations hidden-sm-down">
            {if Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('product_showquickview') == 1}
			  {block name='quick_view'}
				<a class="quick-view" href="#" data-link-action="quickview" aria-label="{$product.name|truncate:30:'...'}">
				  <svg
                   xmlns="http://www.w3.org/2000/svg"
                   xmlns:xlink="http://www.w3.org/1999/xlink"
                   width="20px" height="20px">
                  <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                   d="M19.770,18.673 L14.890,13.792 C16.103,12.333 16.834,10.459 16.834,8.418 C16.834,3.776 13.058,0.000 8.417,0.000 C3.776,0.000 -0.000,3.776 -0.000,8.418 C-0.000,13.059 3.776,16.835 8.417,16.835 C10.458,16.835 12.331,16.105 13.790,14.891 L18.671,19.772 C18.822,19.924 19.021,20.000 19.220,20.000 C19.419,20.000 19.618,19.924 19.770,19.772 C20.074,19.468 20.074,18.976 19.770,18.673 ZM1.555,8.418 C1.555,4.634 4.633,1.555 8.417,1.555 C12.200,1.555 15.279,4.634 15.279,8.418 C15.279,12.202 12.200,15.280 8.417,15.280 C4.633,15.280 1.555,12.202 1.555,8.418 Z"/>
                  </svg>
				</a>
			  {/block}
            {/if}
			</div>

        </div>
      <div class="product-description">
      {block name='product_reviews'}
        {hook h='displayProductListReviews' product=$product}
      {/block}
        {if $product.id_manufacturer}
          <span class="cash-product-card__brand">
            {Manufacturer::getnamebyid($product.id_manufacturer)}
          </span>
        {/if}
        {block name='product_name'}
          <h3 class="h3 product-title" itemprop="name"><a href="{$product.url}">
            {$product.name}
          </a></h3>
        {/block}

        <div class="cash-product-card__meta">
          {if isset($product.reference) && $product.reference}
            <span>Réf. {$product.reference|escape:'html':'UTF-8'}</span>
          {elseif isset($product.reference_to_display) && $product.reference_to_display}
            <span>Réf. {$product.reference_to_display|escape:'html':'UTF-8'}</span>
          {/if}
        </div>
       

        {block name='product_price_and_shipping'}
          {if $product.show_price}
            <div class="product-price-and-shipping" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
              <meta itemprop="priceCurrency" content="{if isset($currency_code)}{$currency_code}{/if}">
              <meta itemprop="url" content="{$product.url}">
              <link itemprop="availability" href="http://schema.org/InStock">

              {hook h='displayProductPriceBlock' product=$product type="before_price"}
                  <div class="product-prices-block">
              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span class="price" itemprop="price" content="{$product.price_tax_exc}">
                <span class="money" {if isset($currency_code)}data-currency-{$currency_code|lower}="{$product.price}"{/if}>{$product.price}</span>
              </span>
              {if $product.has_discount}
              {hook h='displayProductPriceBlock' product=$product type="old_price"}

              <span class="regular-price">{$product.regular_price}</span>
             {/if}
              {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('product_shortdescription') == 1) or (
                             Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('product_shortdescription') == 0 and isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer'))}
                         {$max_length = Module::getInstanceByName('an_theme')->getParam('product_shortdescriptionlength')}
                                 {block name='product_description_short'}
                                                 <p class="an_short_description {if Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('product_shortdescription') == 0 and isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}grid-view-desc{/if}" id="an_short_description_{$product.id}">
                                                                 {if Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('product_shortdescription') == 0 and isset($page) and ($page.page_name == 'category' or $page.page_name == 'new-products' or $page.page_name == 'prices-drop' or $page.page_name == 'best-sales' or $page.page_name == 'search' or $page.page_name == 'manufacturer')}
                                                                                 {$product.description_short|strip_tags:'UTF-8'|truncate:300:'...'}
                                                                 {else}
                                                                                 {$product.description_short|strip_tags:'UTF-8'|truncate:$max_length:'...'}
                                                                 {/if}
                                                 </p>
                                 {/block}
                         {/if}
             </div>

              {hook h='displayProductPriceBlock' product=$product type='unit_price'}

            {hook h='displayProductPriceBlock' product=$product type='weight'}

          
        {if isset($product.product_attribute_minimal_quantity)}
          {$min_quantity = $product.product_attribute_minimal_quantity}
        {else}
          {$min_quantity = $product.minimal_quantity}
        {/if}

          </div>
        {/if}
      {/block}

      <a class="cash-product-card__action" href="{$product.url}">
        <span>Voir la fiche produit</span>
        <span aria-hidden="true">→</span>
      </a>

    </div>

    {block name='product_flags'}
      <ul class="product-flags">
        {foreach from=$product.flags item=flag}
          <li class="product-flag {$flag.type}">{$flag.label}</li>
        {/foreach}
		
        {if $product.has_discount}
          {if $product.discount_type === 'percentage'}
		   <li class="discount-percentage">{$product.discount_percentage}</span>
	      {/if}
        {/if}
      </ul>
    {/block}

  </article>
{/block}
