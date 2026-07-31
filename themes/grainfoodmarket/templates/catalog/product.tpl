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
{extends file=$layout}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta property="og:url" content="{$urls.current_url}">
  <meta property="og:title" content="{$page.meta.title}">
  <meta property="og:site_name" content="{$shop.name}">
  <meta property="og:description" content="{$page.meta.description}">
  <meta property="og:image" content="{$product.cover.large.url}">
  <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
  <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
  <meta property="product:price:amount" content="{$product.price_amount}">
  <meta property="product:price:currency" content="{$currency.iso_code}">
  {if isset($product.weight) && ($product.weight != 0)}
  <meta property="product:weight:value" content="{$product.weight}">
  <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-jsonld.tpl'}
{/block}

{block name='content'}

  <section id="main" itemscope itemtype="https://schema.org/Product">
    <meta itemprop="url" content="{$product.url}">
    {if $product.id_manufacturer}
		<div itemprop="brand" itemtype="https://schema.org/Brand" itemscope>
        <meta itemprop="name" content="{Manufacturer::getnamebyid($product.id_manufacturer)}">
        </div>
    {/if}
    <div class="row product-mainblock {if Module::getInstanceByName('an_theme')->getParam('productslider_stickyProduct')}sticky-product-row{/if}">
    <div class="col-md-6 productblock-image">
        {block name='page_content_container'}
          <section class="page-content {if Module::getInstanceByName('an_theme')->getParam('productslider_stickyProduct')}sticky-product{/if}" id="content">
          {hook h='displayProductAdditionalInfo2' product=$product}
            {block name='page_content'}
              {block name='product_flags'}
                {include file='catalog/_partials/product-flags.tpl'}
              {/block}

              {block name='product_cover_thumbnails'}
                {include file='catalog/_partials/product-cover-thumbnails-product.tpl'}
              {/block}

            {/block}
          </section>
        {/block}
        </div>
    <div class="col-md-6 productblock-content">
          {block name='page_header_container'}
            {block name='page_header'}
              <p class="cash-product-kicker">Catalogue professionnel</p>
              <h1 class="h1" itemprop="name">{block name='page_title'}{$product.name}{/block}</h1>
            {/block}
          {/block}

      {block name='product_prices'}
      {include file='catalog/_partials/product-prices.tpl'}
      {/block}

      {hook h='displayProductVisitors' product=$product}
      <div class="product-information">

        {if $product.is_customizable && count($product.customizations.fields)}
        {block name='product_customization'}
        {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
        {/block}
        {/if}

        {block name='product_additional_info'}
        {include file='catalog/_partials/product-additional-info.tpl'}
        {/block}

        <div class="product-actions">
          {block name='product_buy'}
          <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
            <input type="hidden" name="token" value="{$static_token}">
            <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
            <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id">

            {block name='product_variants'}
            {include file='catalog/_partials/product-variants.tpl'}
            {/block}

            {block name='product_pack'}
            {if $packItems}
            <section class="product-pack">
              <h3 class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</h3>
              {foreach from=$packItems item="product_pack"}
              {block name='product_miniature'}
              {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
              {/block}
              {/foreach}
             </section>
             {/if}
             {/block}

            {block name='product_discounts'}
            {include file='catalog/_partials/product-discounts.tpl'}
            {/block}

            {block name='product_add_to_cart'}
            {include file='catalog/_partials/product-add-to-cart.tpl'}
            {/block}

            {block name='product_refresh'}
            <input class="product-refresh ps-hidden-by-js" name="refresh" type="submit" value="{l s='Refresh' d='Shop.Theme.Actions'}">
            {/block}
          </form>
          {/block}
            {hook h='displayProductGuarantee' product=$product}
            {hook h='displayProductSocials' product=$product}

        </div>

        <aside class="cash-product-enquiry" aria-labelledby="cash-product-enquiry-title">
          <span class="cash-product-enquiry__eyebrow">Service commercial</span>
          <h2 id="cash-product-enquiry-title">Ce produit vous intéresse&nbsp;?</h2>
          <p>
            Disponibilité, conditionnement ou produit équivalent&nbsp;:
            notre équipe vous répond selon les besoins de votre établissement.
          </p>
          <div class="cash-product-enquiry__actions">
            <a
              class="cash-product-enquiry__primary"
              href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}?id_contact=2&amp;product_reference={$product.reference_to_display|escape:'url':'UTF-8'}"
            >
              Demander des informations
            </a>
            <a class="cash-product-enquiry__phone" href="tel:+33489032323">
              <span aria-hidden="true">☎</span>
              04 89 03 23 23
            </a>
          </div>
          <small>Du lundi au vendredi de 9h à 17h · samedi de 8h30 à 12h</small>
        </aside>

      </div>
    </div>
  </div>

            {block name='product_tabs'}
              <div class="tabs an-product-page-description">
                <ul class="nav nav-tabs">
                  {if $product.description}
                  <li class="nav-item">
                    <a class="nav-link{if $product.description} active{/if}" data-toggle="tab" href="#description">
                      {l s='Description' d='Shop.Theme.Catalog'}
                    </a>
                  </li>
                  {/if}
                  {if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('productinfo_detailstab')}
                  <li class="nav-item">
                    <a class="nav-link{if !Module::isEnabled('anproductextratabs') and !$product.description} active{/if}" data-toggle="tab" href="#product-details">
                      {l s='Product Details' d='Shop.Theme.Catalog'}
                    </a>
                  </li>
                  {/if}
                  {if $product.attachments}
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#attachments">
                      {l s='Attachments' d='Shop.Theme.Catalog'}
                    </a>
                  </li>
                  {/if}
                  {foreach from=$product.extraContent item=extra key=extraKey}
                  {if $extra.title != 'Custom tab 1' && $extra.title != 'Custom tab 2'}
                  <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#extra-{$extraKey}">{$extra.title}</a>
                  </li>
                  {/if}
                  {/foreach}
                </ul>

                <div class="tab-content" id="tab-content">
                 <div class="tab-pane fade in{if $product.description} active{/if}" id="description">
                   {block name='product_description'}
                     <div class="product-description">{$product.description nofilter}</div>
                   {/block}
                 </div>
                 {if Module::isEnabled('an_theme') and  Module::getInstanceByName('an_theme')->getParam('productinfo_detailstab')}
                 {block name='product_details'}
                   {include file='catalog/_partials/product-details.tpl'}
                 {/block}
                 {/if}
                 {block name='product_attachments'}
                   {if $product.attachments}
                    <div class="tab-pane fade in" id="attachments">
                       <section class="product-attachments">
                         <h3 class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</h3>
                         {foreach from=$product.attachments item=attachment}
                           <div class="attachment">
                             <h4><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></h4>
                             <p>{$attachment.description}</p
                             <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                               {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                             </a>
                           </div>
                         {/foreach}
                       </section>
                     </div>
                   {/if}
                 {/block}

                 {foreach from=$product.extraContent item=extra key=extraKey}
                 {if $extra.title != 'Custom tab 1' && $extra.title != 'Custom tab 2'}
                 <div class="tab-pane fade in {$extra.attr.class}" id="extra-{$extraKey}" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
                   {$extra.content nofilter}
                 </div>
                 {/if}
                 {/foreach}
              </div>
            
          </div>	
		{/block}

    {block name='product_footer'}
      {hook h='displayFooterProduct' product=$product category=$category}
    {/block}

    {block name='product_accessories'}
    {if $accessories}
      <section class="product-accessories clearfix">
        <h2 class="product-accessories-title">{l s='You might also like' d='Shop.Theme.Catalog'}</h2>
        <div class="products">
          {foreach from=$accessories item="product_accessory" name=accessories}
            {if $smarty.foreach.accessories.index < 4}
              {block name='product_miniature'}
                {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory}
              {/block}
            {/if}
          {/foreach}
        </div>
      </section>
    {/if}
  {/block}

    <div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="pswp__bg"></div>
      <div class="pswp__scroll-wrap">
        <div class="pswp__container">
          <div class="pswp__item"></div>
          <div class="pswp__item"></div>
          <div class="pswp__item"></div>
        </div>
        <div class="pswp__ui pswp__ui--hidden">
          <div class="pswp__top-bar">
            <div class="pswp__counter"></div>
            <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
            <div class="pswp__preloader">
              <div class="pswp__preloader__icn">
                <div class="pswp__preloader__cut">
                  <div class="pswp__preloader__donut"></div>
                </div>
              </div>
            </div>
          </div>
    
          <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
          </button>
    
          <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
          </button>
    
          <div class="pswp__caption">
              <div class="pswp__caption__center"></div>
          </div>
        </div>
      </div>
    </div>



    {block name='product_images_modal'}
      {include file='catalog/_partials/product-images-modal.tpl'}
    {/block}

    {block name='page_footer_container'}
      <footer class="page-footer">
        {block name='page_footer'}
          <!-- Footer content -->
        {/block}
      </footer>
    {/block}
  </section>

{/block}
