<div class="tab-pane fade{if !Module::isEnabled('anproductextratabs') and !$product.description} in active{/if}"
     id="product-details"
     data-product="{$product.embedded_attributes|json_encode}"
     role="tabpanel"
  >
  {block name='product_reference'}
    {if version_compare($smarty.const._PS_VERSION_, '9.0.0.0', '<')}
        {if isset($product_manufacturer->id)}
          <div class="product-manufacturer">
            {if isset($manufacturer_image_url)}
              <a href="{$product_brand_url}">
                <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" alt="{$product_manufacturer->name}">
              </a>
            {else}
              <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
              <span>
                <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
              </span>
            {/if}
          </div>
        {/if}
    {else}
        {if !empty($product_manufacturer.id)}
          <div class="product-manufacturer">
            {assign var="product_manufacturer_image_key" value="`$product_manufacturer.id`-"}
            {if !empty($product_manufacturer.image.small.url) && strpos($product_manufacturer.image.small.url, $product_manufacturer_image_key)}
              <a href="{$product_manufacturer.url}">
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
              </a>
            {else}
              <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
              <span>
                <a href="{$product_manufacturer.url}">{$product_manufacturer.name}</a>
              </span>
            {/if}
          </div>
        {/if}
    {/if}

    {if isset($product.reference_to_display)}
      <div class="product-reference">
        <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
        <span itemprop="sku">{$product.reference_to_display}</span>
      </div>
    {/if}
  {/block}

  {block name='product_features'}
    {if isset($product.grouped_features) AND $product.grouped_features}
      <section class="product-features">
        <h3 class="h6">{l s='Data sheet' d='Shop.Theme.Catalog'}</h3>
        <dl class="data-sheet">
          {foreach from=$product.grouped_features item=feature}
            <dt class="name">{$feature.name}</dt>
            <dd class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
          {/foreach}
        </dl>
      </section>
    {/if}
  {/block}

  {* if product have specific references, a table will be added to product details section *}
  {block name='product_specific_references'}
    {if isset($product.specific_references)}
      <section class="product-features">
        <h3 class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</h3>
          <dl class="data-sheet">
            {foreach from=$product.specific_references item=reference key=key}
              <dt class="name">{$key}</dt>
              <dd class="value">{$reference}</dd>
            {/foreach}
          </dl>
      </section>
    {/if}
  {/block}

  {block name='product_condition'}
    {if $product.condition}
      <div class="product-condition">
        <label class="label">{l s='Condition' d='Shop.Theme.Catalog'} </label>
        <link itemprop="itemCondition" href="{$product.condition.schema_url}"/>
        <span>{$product.condition.label}</span>
      </div>
    {/if}
  {/block}
</div>
