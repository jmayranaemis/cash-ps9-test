<div class="cash-home">
  <section class="cash-hero">
    <div class="cash-home__container cash-hero__inner">
      <div class="cash-hero__content">
        <p class="cash-eyebrow">Grossiste alimentaire pour les professionnels</p>
        <h1>Tout pour votre activité,<br>avec un interlocuteur local</h1>
        <p class="cash-hero__lead">Une offre complète pour la restauration, la vente à emporter et les métiers de bouche, disponible dans nos magasins et en livraison.</p>
        <div class="cash-actions">
          <a class="cash-button cash-button--primary" href="{$cash_become_client_url|escape:'htmlall':'UTF-8'}">Devenir client</a>
          <a class="cash-button cash-button--secondary" href="#familles-produits">Découvrir les produits</a>
        </div>
      </div>
      <aside class="cash-hero__panel" aria-label="Accès rapide">
        <span class="cash-hero__panel-kicker">Déjà professionnel ?</span>
        <strong>Construisons votre offre ensemble.</strong>
        <p>Un besoin produit, une ouverture ou une demande de livraison&nbsp;?</p>
        <a href="{$cash_contact_url|escape:'htmlall':'UTF-8'}">Parler à l’équipe commerciale →</a>
      </aside>
    </div>
  </section>

  <section class="cash-proof" aria-label="Nos engagements">
    <div class="cash-home__container cash-proof__grid">
      <div><strong>Depuis 1984</strong><span>Une expérience terrain</span></div>
      <div><strong>Des milliers de références</strong><span>Pour tous les métiers</span></div>
      <div><strong>Livraison professionnelle</strong><span>Selon votre zone</span></div>
      <div><strong>Une équipe locale</strong><span>Disponible et réactive</span></div>
    </div>
  </section>

  <section id="familles-produits" class="cash-section cash-families">
    <div class="cash-home__container" data-cash-carousel>
      <div class="cash-section__heading">
        <div>
          <p class="cash-eyebrow">L’essentiel en un coup d’œil</p>
          <h2>Nos familles de produits</h2>
        </div>
        <div class="cash-section__tools">
          <a href="{$cash_products_url|escape:'htmlall':'UTF-8'}">Voir tous les produits →</a>
          <div class="cash-carousel-buttons">
            <button type="button" data-cash-carousel-prev aria-label="Catégories précédentes">←</button>
            <button type="button" data-cash-carousel-next aria-label="Catégories suivantes">→</button>
          </div>
        </div>
      </div>
      <div class="cash-carousel">
      <div class="cash-card-scroll" data-cash-carousel-track>
        {foreach from=$cash_families item=family}
          <a class="cash-family-card" href="{$family.url|escape:'htmlall':'UTF-8'}">
            <span class="cash-family-card__image" style="background-image:url('{$family.image|escape:'htmlall':'UTF-8'}')"></span>
            <strong>{$family.name|escape:'htmlall':'UTF-8'}</strong>
            <span>Explorer la gamme →</span>
          </a>
        {/foreach}
      </div>
      </div>
    </div>
  </section>

  <section class="cash-section cash-trades">
    <div class="cash-home__container">
      <div class="cash-section__heading">
        <div>
          <p class="cash-eyebrow">Une offre pensée pour votre métier</p>
          <h2>Vous êtes…</h2>
        </div>
      </div>
      <div class="cash-trades__grid">
        <article><span>01</span><h3>Restaurateur</h3><p>Produits frais, épicerie, surgelés, boissons et consommables au même endroit.</p></article>
        <article><span>02</span><h3>Fast-food & snacking</h3><p>Des références adaptées aux volumes, au rendement et à la rapidité de service.</p></article>
        <article><span>03</span><h3>Pizza & vente à emporter</h3><p>Ingrédients, emballages et boissons pour composer une offre complète.</p></article>
      </div>
    </div>
  </section>

  <section id="catalogues" class="cash-section cash-catalogues">
    <div class="cash-home__container cash-catalogues__grid">
      <div>
        <p class="cash-eyebrow">Sélections & nouveautés</p>
        <h2>Les catalogues du moment</h2>
        <p>Feuilletez nos sélections professionnelles et retrouvez rapidement les références adaptées à votre activité.</p>
      </div>
      <div class="cash-catalogue-card">
        <span>Catalogue professionnel</span>
        <strong>Nos sélections arrivent bientôt en ligne</strong>
        <p>En attendant, notre équipe vous transmet le catalogue correspondant à votre besoin.</p>
        <a class="cash-button cash-button--primary" href="{$cash_contact_url|escape:'htmlall':'UTF-8'}">Demander un catalogue</a>
      </div>
    </div>
  </section>

  <section id="services" class="cash-section cash-services">
    <div class="cash-home__container">
      <div class="cash-section__heading">
        <div><p class="cash-eyebrow">Plus qu’un fournisseur</p><h2>Des services utiles au quotidien</h2></div>
      </div>
      <div class="cash-services__grid">
        <article><span>✓</span><h3>Conseil</h3><p>Une équipe qui connaît les produits et votre métier.</p></article>
        <article><span>✓</span><h3>Disponibilité</h3><p>Une offre large et des solutions de remplacement.</p></article>
        <article><span>✓</span><h3>Livraison</h3><p>Un service organisé selon votre secteur et vos besoins.</p></article>
        <article><span>✓</span><h3>Accompagnement</h3><p>Un interlocuteur pour suivre votre activité dans la durée.</p></article>
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
        <h2>Devenir client Cash Alimentaire</h2>
        <p>Déposez votre demande en moins de 2 minutes. Après vérification de vos informations, notre équipe vous recontacte pour finaliser l’ouverture.</p>
        <ul><li>SIRET de l’établissement</li><li>Coordonnées professionnelles</li><li>Extrait Kbis au format PDF</li></ul>
      </div>
      <div class="cash-client__action">
        <a class="cash-button cash-button--primary" href="{$cash_become_client_url|escape:'htmlall':'UTF-8'}">Déposer ma demande</a>
        <a href="{$cash_contact_url|escape:'htmlall':'UTF-8'}">Vous avez une question&nbsp;?</a>
      </div>
    </div>
  </section>

  {if $cash_manufacturers}
    <section class="cash-section cash-brands">
      <div class="cash-home__container" data-cash-carousel>
        <div class="cash-section__heading">
          <div><p class="cash-eyebrow">Nos partenaires</p><h2>Des marques professionnelles reconnues</h2></div>
          <div class="cash-carousel-buttons">
            <button type="button" data-cash-carousel-prev aria-label="Marques précédentes">←</button>
            <button type="button" data-cash-carousel-next aria-label="Marques suivantes">→</button>
          </div>
        </div>
        <div class="cash-carousel">
        <div class="cash-brands__scroll" data-cash-carousel-track>
          {foreach from=$cash_manufacturers item=manufacturer}
            <a href="{$manufacturer.url|escape:'htmlall':'UTF-8'}" aria-label="{$manufacturer.name|escape:'htmlall':'UTF-8'}">
              <img loading="lazy" src="{$manufacturer.image|escape:'htmlall':'UTF-8'}" alt="{$manufacturer.name|escape:'htmlall':'UTF-8'}">
            </a>
          {/foreach}
        </div>
        </div>
      </div>
    </section>
  {/if}

  <section class="cash-contact">
    <div class="cash-home__container cash-contact__grid">
      <div><p class="cash-eyebrow">Besoin d’aide&nbsp;?</p><h2>Contactez-nous</h2><p>Notre équipe vous oriente vers le bon produit, le bon service ou le magasin le plus proche.</p></div>
      <div class="cash-contact__links">
        <a href="{$cash_contact_url|escape:'htmlall':'UTF-8'}"><strong>Écrire à l’équipe</strong><span>Formulaire de contact →</span></a>
        <a href="{$cash_stores_url|escape:'htmlall':'UTF-8'}"><strong>Nos magasins</strong><span>Adresses et horaires →</span></a>
      </div>
    </div>
  </section>
</div>
