{extends file='page.tpl'}

{block name='page_header_container'}{/block}

{block name='page_content_container'}
  <main class="cash-products-page">
    <header class="cash-products-page__hero">
      <div class="cash-home__container">
        <p class="cash-eyebrow">Catalogue professionnel</p>
        <h1>Nos familles de produits</h1>
        <p>Explorez une offre complète pensée pour les restaurateurs, hôteliers et métiers de bouche.</p>
      </div>
    </header>
    <section class="cash-products-page__content">
      <div class="cash-home__container">
        <div class="cash-products-page__grid">
          {foreach from=$cash_families item=family}
            <a class="cash-products-page__card" href="{$family.url|escape:'htmlall':'UTF-8'}">
              {if $family.image}
                <span class="cash-products-page__image" style="background-image:url('{$family.image|escape:'htmlall':'UTF-8'}')"></span>
              {else}
                <span class="cash-products-page__image cash-products-page__image--fallback"><b>{$family.initial|escape:'htmlall':'UTF-8'}</b></span>
              {/if}
              <span class="cash-products-page__card-copy"><strong>{$family.name|escape:'htmlall':'UTF-8'}</strong><em>Découvrir la gamme →</em></span>
            </a>
          {/foreach}
        </div>
      </div>
    </section>
    <aside class="cash-products-page__cta"><div class="cash-home__container"><div><p class="cash-eyebrow">Besoin d’une référence précise&nbsp;?</p><h2>Notre équipe vous accompagne.</h2></div><a class="cash-button cash-button--primary" href="{$cash_contact_url|escape:'htmlall':'UTF-8'}">Nous contacter</a></div></aside>
  </main>
{/block}
