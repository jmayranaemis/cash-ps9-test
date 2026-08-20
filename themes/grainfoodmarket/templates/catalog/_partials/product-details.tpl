<div
  class="tab-pane fade{if !Module::isEnabled('anproductextratabs') and !$product.description} in active{/if} cash-product-details"
  id="product-details"
  data-product="{$product.embedded_attributes|json_encode}"
  role="tabpanel"
>
  <header class="cash-product-details__header">
    <div>
      <span class="cash-product-details__eyebrow">Informations produit</span>
      <h2>L’essentiel en un coup d’œil</h2>
      <p>Conditionnement, caractéristiques et références utiles pour préparer votre commande professionnelle.</p>
    </div>
    <span class="cash-product-details__index" aria-hidden="true">01</span>
  </header>

  <div class="cash-product-details__layout">
    <section class="cash-product-details__panel cash-product-details__panel--features" aria-labelledby="cash-product-features-title">
      <div class="cash-product-details__panel-heading">
        <span class="cash-product-details__icon" aria-hidden="true">✓</span>
        <div>
          <span>Fiche technique</span>
          <h3 id="cash-product-features-title">Caractéristiques</h3>
        </div>
      </div>

      {if isset($product.grouped_features) AND $product.grouped_features}
        <dl class="cash-product-details__specs">
          {foreach from=$product.grouped_features item=feature}
            <div class="cash-product-details__spec">
              <dt>{$feature.name}</dt>
              <dd>{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
            </div>
          {/foreach}
        </dl>
      {else}
        <p class="cash-product-details__empty">Les caractéristiques détaillées de ce produit sont disponibles auprès de notre équipe commerciale.</p>
      {/if}
    </section>

    <aside class="cash-product-details__panel cash-product-details__panel--identity" aria-labelledby="cash-product-identity-title">
      <div class="cash-product-details__panel-heading">
        <span class="cash-product-details__icon cash-product-details__icon--light" aria-hidden="true">#</span>
        <div>
          <span>Identification</span>
          <h3 id="cash-product-identity-title">Repères produit</h3>
        </div>
      </div>

      {if version_compare($smarty.const._PS_VERSION_, '9.0.0.0', '<')}
        {if isset($product_manufacturer->id)}
          <div class="cash-product-details__brand">
            {if isset($manufacturer_image_url)}
              <a href="{$product_brand_url}">
                <img src="{$manufacturer_image_url}" alt="{$product_manufacturer->name}" loading="lazy">
              </a>
            {else}
              <span>Marque</span>
              <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
            {/if}
          </div>
        {/if}
      {else}
        {if !empty($product_manufacturer.id)}
          <div class="cash-product-details__brand">
            {assign var="product_manufacturer_image_key" value="`$product_manufacturer.id`-"}
            {if !empty($product_manufacturer.image.small.url) && strpos($product_manufacturer.image.small.url, $product_manufacturer_image_key)}
              <a href="{$product_manufacturer.url}">
                <picture>
                  {if !empty($product_manufacturer.image.small.sources.avif)}<source srcset="{$product_manufacturer.image.small.sources.avif}" type="image/avif">{/if}
                  {if !empty($product_manufacturer.image.small.sources.webp)}<source srcset="{$product_manufacturer.image.small.sources.webp}" type="image/webp">{/if}
                  <img
                    src="{$product_manufacturer.image.small.url}"
                    alt="{if !empty($product_manufacturer.image.legend)}{$product_manufacturer.image.legend}{else}{$product_manufacturer.name}{/if}"
                    loading="lazy"
                  >
                </picture>
              </a>
            {else}
              <span>Marque</span>
              <a href="{$product_manufacturer.url}">{$product_manufacturer.name}</a>
            {/if}
          </div>
        {/if}
      {/if}

      <dl class="cash-product-details__identity-list">
        {if isset($product.reference_to_display)}
          <div>
            <dt>Référence Cash</dt>
            <dd itemprop="sku">{$product.reference_to_display}</dd>
          </div>
        {/if}

        {if isset($product.specific_references)}
          {foreach from=$product.specific_references item=reference key=key}
            <div>
              <dt>{$key}</dt>
              <dd>{$reference}</dd>
            </div>
          {/foreach}
        {/if}

        {if $product.condition}
          <div>
            <dt>État</dt>
            <dd>
              <link itemprop="itemCondition" href="{$product.condition.schema_url}">
              {$product.condition.label}
            </dd>
          </div>
        {/if}
      </dl>
    </aside>
  </div>

  <div class="cash-product-details__help">
    <div>
      <span>Besoin d’une précision&nbsp;?</span>
      <p>Notre équipe vous renseigne sur la disponibilité, le conditionnement ou une référence équivalente.</p>
    </div>
    <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}?id_contact=2&amp;product_reference={$product.reference_to_display|escape:'url':'UTF-8'}">
      Contacter le service commercial <span aria-hidden="true">→</span>
    </a>
  </div>
</div>
