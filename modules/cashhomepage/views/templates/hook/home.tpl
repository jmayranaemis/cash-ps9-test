<div class="cash-home">
  <section class="cash-hero">
    <div class="cash-home__container cash-hero__layout">
      <article class="cash-hero__primary" style="--cash-hero-image:url('{$cash_content.hero_image_url|escape:'htmlall':'UTF-8'}')">
        <div class="cash-hero__content">
          <p class="cash-eyebrow">{$cash_content.hero_eyebrow|escape:'htmlall':'UTF-8'}</p>
          <h1>{$cash_content.hero_title|escape:'htmlall':'UTF-8'}</h1>
          <p class="cash-hero__lead">{$cash_content.hero_lead|escape:'htmlall':'UTF-8'}</p>
          <div class="cash-actions">
            <a class="cash-button cash-button--primary" href="{$cash_become_client_url|escape:'htmlall':'UTF-8'}">Devenir client</a>
            <a class="cash-button cash-button--secondary" href="#familles-produits">Découvrir les produits</a>
          </div>
        </div>
      </article>

      <div class="cash-hero__aside" aria-label="Accès rapides">
        <a class="cash-hero-card cash-hero-card--promotions" href="{$cash_promotions_url|escape:'htmlall':'UTF-8'}">
          <span class="cash-hero-card__kicker">Offres professionnelles</span>
          <strong>Les promotions du moment</strong>
          <span class="cash-hero-card__cta">Découvrir les promotions <b aria-hidden="true">→</b></span>
        </a>
        <a class="cash-hero-card cash-hero-card--stores" href="{$cash_stores_url|escape:'htmlall':'UTF-8'}">
          <span class="cash-hero-card__kicker">Au plus près de vous</span>
          <strong>Découvrez nos magasins</strong>
          <span class="cash-hero-card__cta">Trouver un magasin <b aria-hidden="true">→</b></span>
        </a>
      </div>
    </div>
  </section>

  <section class="cash-proof" aria-label="Nos engagements">
    <div class="cash-home__container cash-proof__grid">
      <div>
        <svg aria-hidden="true" viewBox="0 0 48 48"><path d="M24 5a19 19 0 1 0 19 19"/><path d="M24 13v12l8 5"/><path d="M37 5v10H27"/></svg>
        <p><strong>{$cash_content.proof_1_title|escape:'htmlall':'UTF-8'}</strong><span>{$cash_content.proof_1_text|escape:'htmlall':'UTF-8'}</span></p>
      </div>
      <div>
        <svg aria-hidden="true" viewBox="0 0 48 48"><rect x="6" y="7" width="15" height="15" rx="2"/><rect x="27" y="7" width="15" height="15" rx="2"/><rect x="6" y="28" width="15" height="15" rx="2"/><rect x="27" y="28" width="15" height="15" rx="2"/></svg>
        <p><strong>{$cash_content.proof_2_title|escape:'htmlall':'UTF-8'}</strong><span>{$cash_content.proof_2_text|escape:'htmlall':'UTF-8'}</span></p>
      </div>
      <div>
        <svg aria-hidden="true" viewBox="0 0 48 48"><path d="M5 12h25v22H5z"/><path d="M30 20h7l6 7v7H30z"/><circle cx="14" cy="37" r="4"/><circle cx="37" cy="37" r="4"/></svg>
        <p><strong>{$cash_content.proof_3_title|escape:'htmlall':'UTF-8'}</strong><span>{$cash_content.proof_3_text|escape:'htmlall':'UTF-8'}</span></p>
      </div>
      <div>
        <svg aria-hidden="true" viewBox="0 0 48 48"><circle cx="24" cy="16" r="9"/><path d="M8 42c2-11 9-16 16-16s14 5 16 16"/><path d="M15 15c0-8 4-12 9-12s9 4 9 12"/><path d="M33 16h5v9h-5"/></svg>
        <p><strong>{$cash_content.proof_4_title|escape:'htmlall':'UTF-8'}</strong><span>{$cash_content.proof_4_text|escape:'htmlall':'UTF-8'}</span></p>
      </div>
    </div>
  </section>

  <section id="familles-produits" class="cash-section cash-families">
    <div class="cash-home__container" data-cash-carousel>
      <div class="cash-section__heading">
        <div>
          <p class="cash-eyebrow">L’essentiel en un coup d’œil</p>
          <h2>{$cash_content.families_title|escape:'htmlall':'UTF-8'}</h2>
        </div>
        <div class="cash-section__tools">
          <a href="{$cash_products_url|escape:'htmlall':'UTF-8'}">Voir tous les produits →</a>
        </div>
      </div>
      <div class="cash-carousel">
      <div class="cash-card-scroll" data-cash-carousel-track>
        {foreach from=$cash_families item=family}
          <a class="cash-family-card" href="{$family.url|escape:'htmlall':'UTF-8'}">
            {if $family.image}
              <span class="cash-family-card__image" style="background-image:url('{$family.image|escape:'htmlall':'UTF-8'}')"></span>
            {else}
              <span class="cash-family-card__image cash-family-card__image--fallback" aria-hidden="true"><b>{$family.initial|escape:'htmlall':'UTF-8'}</b></span>
            {/if}
            <strong>{$family.name|escape:'htmlall':'UTF-8'}</strong>
            <span>Explorer la gamme →</span>
          </a>
        {/foreach}
      </div>
      </div>
      <div class="cash-carousel-buttons cash-carousel-buttons--below">
        <button type="button" data-cash-carousel-prev aria-label="Catégories précédentes">←</button>
        <button type="button" data-cash-carousel-next aria-label="Catégories suivantes">→</button>
      </div>
    </div>
  </section>

  <section id="catalogues" class="cash-section cash-catalogues">
    <div class="cash-home__container cash-catalogues__grid">
      <div class="cash-catalogues__intro">
        <p class="cash-eyebrow">Sélections & nouveautés</p>
        <h2>{$cash_content.catalogue_title|escape:'htmlall':'UTF-8'}</h2>
        <p>{$cash_content.catalogue_text|escape:'htmlall':'UTF-8'}</p>
        <a class="cash-catalogues__all" href="{$cash_catalogues_url|escape:'htmlall':'UTF-8'}">Voir tous les catalogues →</a>
      </div>
      {if $cash_catalogues}
        <div class="cash-catalogues__showcase" data-cash-carousel>
          <div class="cash-catalogues__list" data-cash-carousel-track>
            {foreach from=$cash_catalogues item=catalogue}
              {include file='module:cashhomepage/views/templates/_partials/catalogue-card.tpl' catalogue=$catalogue}
            {/foreach}
          </div>
          {if $cash_catalogues|count > 1}
            <div class="cash-carousel-buttons cash-catalogues__buttons">
              <button type="button" data-cash-carousel-prev aria-label="Catalogue précédent">←</button>
              <button type="button" data-cash-carousel-next aria-label="Catalogue suivant">→</button>
            </div>
          {/if}
        </div>
      {else}
        <div class="cash-catalogue-card cash-catalogue-card--empty">
          <span>Catalogue professionnel</span>
          <strong>{$cash_content.catalogue_card_title|escape:'htmlall':'UTF-8'}</strong>
          <p>{$cash_content.catalogue_card_text|escape:'htmlall':'UTF-8'}</p>
          <a class="cash-button cash-button--primary" href="{$cash_catalogue_contact_url|escape:'htmlall':'UTF-8'}">Demander un catalogue</a>
        </div>
      {/if}
    </div>
  </section>

  <section class="cash-section cash-product-selection" aria-label="Sélection de produits">
    <div class="cash-home__container">
      <div class="cash-section__heading">
        <div>
          <p class="cash-eyebrow">Un aperçu concret de notre offre</p>
          <h2>Des produits pour les professionnels</h2>
        </div>
        <a href="{$cash_products_url|escape:'htmlall':'UTF-8'}">Explorer tout le catalogue →</a>
      </div>
      <div class="cash-product-selection__module">
        {widget name='an_homeproducts'}
        <script>
          document.querySelectorAll('.cash-product-selection .js-an_homeproducts-content').forEach(function (block) {
            block.setAttribute('data-items', '6');
          });
        </script>
      </div>
    </div>
  </section>

  <section class="cash-section cash-trades">
    <div class="cash-home__container">
      <div class="cash-section__heading">
        <div>
          <p class="cash-eyebrow">Une offre pensée pour votre métier</p>
          <h2>{$cash_content.trades_title|escape:'htmlall':'UTF-8'}</h2>
        </div>
      </div>
      <div class="cash-trades__grid">
        <article><span>01</span><h3>Restaurateur</h3><p>Produits frais, épicerie, surgelés, boissons et consommables au même endroit.</p></article>
        <article><span>02</span><h3>Fast-food & snacking</h3><p>Des références adaptées aux volumes, au rendement et à la rapidité de service.</p></article>
        <article><span>03</span><h3>Pizza & vente à emporter</h3><p>Ingrédients, emballages et boissons pour composer une offre complète.</p></article>
      </div>
    </div>
  </section>

  <section id="services" class="cash-section cash-services">
    <div class="cash-home__container">
      <div class="cash-section__heading">
        <div><p class="cash-eyebrow">Plus qu’un fournisseur</p><h2>{$cash_content.services_title|escape:'htmlall':'UTF-8'}</h2></div>
      </div>
      <div class="cash-services__grid">
        <article>
          <span class="cash-service-icon" aria-hidden="true"><svg viewBox="0 0 48 48"><path d="M9 8h30v23H22l-9 7v-7H9z"/><path d="M16 16h16M16 22h11"/></svg></span>
          <h3><a href="{$cash_services_url|escape:'htmlall':'UTF-8'}#conseil">Conseil</a></h3>
          <p>Une équipe qui connaît les produits et votre métier.</p>
        </article>
        <article>
          <span class="cash-service-icon" aria-hidden="true"><svg viewBox="0 0 48 48"><rect x="7" y="8" width="14" height="14" rx="2"/><rect x="27" y="8" width="14" height="14" rx="2"/><rect x="7" y="28" width="14" height="14" rx="2"/><path d="m29 35 4 4 8-10"/></svg></span>
          <h3><a href="{$cash_services_url|escape:'htmlall':'UTF-8'}#disponibilite">Disponibilité</a></h3>
          <p>Une offre large et des solutions de remplacement.</p>
        </article>
        <article>
          <span class="cash-service-icon" aria-hidden="true"><svg viewBox="0 0 48 48"><path d="M5 12h25v22H5zM30 20h7l6 7v7H30z"/><circle cx="14" cy="37" r="4"/><circle cx="37" cy="37" r="4"/></svg></span>
          <h3><a href="{$cash_services_url|escape:'htmlall':'UTF-8'}#livraison">Livraison</a></h3>
          <p>Un service organisé selon votre secteur et vos besoins.</p>
        </article>
        <article>
          <span class="cash-service-icon" aria-hidden="true"><svg viewBox="0 0 48 48"><circle cx="18" cy="15" r="7"/><circle cx="34" cy="18" r="5"/><path d="M5 41c1-10 6-15 13-15s12 5 13 15M29 28c7 0 12 4 14 12"/><path d="m31 11 3-3 3 3"/></svg></span>
          <h3><a href="{$cash_services_url|escape:'htmlall':'UTF-8'}#accompagnement">Accompagnement</a></h3>
          <p>Un interlocuteur pour suivre votre activité dans la durée.</p>
        </article>
      </div>
    </div>
  </section>

  <section class="cash-section cash-advice">
    <div class="cash-home__container cash-advice__grid">
      <div><p class="cash-eyebrow">Conseils & actualités</p><h2>Des idées directement utiles à votre activité</h2></div>
      <a class="cash-advice__item" href="{$cash_contact_url|escape:'htmlall':'UTF-8'}"><span>Conseil pro</span><strong>Besoin d’une référence ou d’une alternative&nbsp;?</strong><em>Poser une question →</em></a>
      <a class="cash-advice__item" href="{$cash_products_url|escape:'htmlall':'UTF-8'}"><span>Inspiration</span><strong>Découvrez nos familles produits</strong><em>Explorer l’offre →</em></a>
    </div>
  </section>

  <section class="cash-section cash-client">
    <div class="cash-home__container cash-client__inner">
      <div>
        <p class="cash-eyebrow">Réservé aux professionnels</p>
        <h2>{$cash_content.client_title|escape:'htmlall':'UTF-8'}</h2>
        <p>{$cash_content.client_text|escape:'htmlall':'UTF-8'}</p>
        <ul><li>SIRET de l’établissement</li><li>Coordonnées professionnelles</li><li>Extrait Kbis au format PDF</li></ul>
      </div>
      <div class="cash-client__action">
        <a class="cash-button cash-button--primary" href="{$cash_become_client_url|escape:'htmlall':'UTF-8'}">Devenir client</a>
        <a href="{$cash_faq_url|escape:'htmlall':'UTF-8'}">Vous avez une question&nbsp;?</a>
      </div>
    </div>
  </section>

  {if $cash_manufacturers}
    <section class="cash-section cash-brands">
      <div class="cash-home__container" data-cash-carousel>
        <div class="cash-section__heading">
          <div><p class="cash-eyebrow">Nos partenaires</p><h2>Des marques professionnelles reconnues</h2></div>
          <div class="cash-section__tools">
            <a href="{$cash_manufacturers_url|escape:'htmlall':'UTF-8'}">Découvrir toutes nos marques →</a>
          </div>
        </div>
        <div class="cash-carousel">
          <div class="cash-brands__scroll" data-cash-carousel-track>
            {foreach from=$cash_manufacturers item=manufacturer}
              <a href="{$manufacturer.url|escape:'htmlall':'UTF-8'}" aria-label="{$manufacturer.name|escape:'htmlall':'UTF-8'}">
                {if $manufacturer.image}
                  <img loading="lazy" src="{$manufacturer.image|escape:'htmlall':'UTF-8'}" alt="{$manufacturer.name|escape:'htmlall':'UTF-8'}">
                {else}
                  <span class="cash-brands__name">{$manufacturer.name|escape:'htmlall':'UTF-8'}</span>
                {/if}
              </a>
            {/foreach}
          </div>
        </div>
        <div class="cash-carousel-buttons cash-carousel-buttons--below">
          <button type="button" data-cash-carousel-prev aria-label="Marques précédentes">←</button>
          <button type="button" data-cash-carousel-next aria-label="Marques suivantes">→</button>
        </div>
      </div>
    </section>
  {/if}

  <section class="cash-contact">
    <div class="cash-home__container cash-contact__grid">
      <div><p class="cash-eyebrow">Besoin d’aide&nbsp;?</p><h2>{$cash_content.contact_title|escape:'htmlall':'UTF-8'}</h2><p>{$cash_content.contact_text|escape:'htmlall':'UTF-8'}</p></div>
      <div class="cash-contact__links">
        <a href="{$cash_contact_url|escape:'htmlall':'UTF-8'}"><strong>Écrire à l’équipe</strong><span>Formulaire de contact →</span></a>
        <a href="{$cash_stores_url|escape:'htmlall':'UTF-8'}"><strong>Nos magasins</strong><span>Adresses et horaires →</span></a>
      </div>
    </div>
  </section>
</div>
