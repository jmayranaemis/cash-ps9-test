{extends file='page.tpl'}

{block name='page_header_container'}{/block}

{block name='page_content_container'}
  <section id="content" class="page-content cash-stores-page">
    <header class="cash-stores-page__hero">
      <div class="cash-stores-page__container">
        <span>Deux adresses à Nice</span>
        <h1>Nos magasins</h1>
        <p>Retrouvez CASE dans nos deux magasins niçois, ouverts aux professionnels comme aux particuliers. Découvrez leurs horaires, leurs coordonnées et leurs spécificités pour choisir le point de vente le plus adapté à vos besoins.</p>
      </div>
    </header>

    <div class="cash-stores-page__container cash-stores-grid">
      <article id="store-villermont" class="cash-store-card">
        <figure class="cash-store-card__image">
          <img src="{$urls.base_url}modules/cashhomepage/views/img/cash-store-villermont.webp" width="1000" height="620" loading="eager" alt="Devanture du magasin CASE Villermont">
        </figure>
        <div class="cash-store-card__content">
          <p class="cash-store-card__eyebrow">L’adresse historique</p>
          <h2>Magasin Villermont</h2>
          <p class="cash-store-card__intro">Premier magasin de CASE, Villermont est particulièrement apprécié des professionnels pour son large choix de produits et ses conditionnements adaptés à la restauration. Les particuliers peuvent également y retrouver de nombreuses références proposées en grand format.</p>
          <dl class="cash-store-card__details">
            <div><dt>Adresse</dt><dd>19 &amp; 21 avenue Villermont,<br>06000 Nice</dd></div>
            <div><dt>Numéro de téléphone</dt><dd><a href="tel:+33493853009">04 93 85 30 09</a></dd></div>
            <div><dt>Horaires</dt><dd>Du lundi au vendredi : 07h30-13h00, 14h30-18h30<br>Le samedi : 08h00-13h00</dd></div>
          </dl>
        </div>
        <footer class="cash-store-card__actions">
          <a href="https://www.google.com/maps/search/?api=1&amp;query=Cash+Alimentaire+19+avenue+Villermont+06000+Nice" target="_blank" rel="noopener noreferrer">Google Maps <span aria-hidden="true">↗</span></a>
          <a class="cash-store-card__review" href="https://www.google.com/search?q=Cash+Alimentaire+19+avenue+Villermont+Nice+avis" target="_blank" rel="noopener noreferrer">Laisser un avis Google <span aria-hidden="true">↗</span></a>
        </footer>
      </article>

      <article id="store-rue-de-france" class="cash-store-card">
        <figure class="cash-store-card__image">
          <img src="{$urls.base_url}modules/cashhomepage/views/img/cash-store-france.webp" width="1000" height="620" loading="lazy" alt="Devanture du magasin CASE Rue de France">
        </figure>
        <div class="cash-store-card__content">
          <p class="cash-store-card__eyebrow">Le magasin de proximité</p>
          <h2>Magasin Rue de France</h2>
          <p class="cash-store-card__intro">Idéalement situé au cœur de Nice, notre magasin de la rue de France s’adresse principalement aux particuliers. Il propose une sélection de produits accessibles et des formats adaptés aux besoins du quotidien, tout en restant ouvert aux professionnels.</p>
          <dl class="cash-store-card__details">
            <div><dt>Adresse</dt><dd>15 &amp; 17 rue de France,<br>06000 Nice</dd></div>
            <div><dt>Numéro de téléphone</dt><dd><a href="tel:+33483660126">04 83 66 01 26</a></dd></div>
            <div><dt>Horaires</dt><dd>Du lundi au samedi : 07h45-13h45, 15h45-19h45<br>Le dimanche : 09h15-13h15</dd></div>
          </dl>
        </div>
        <footer class="cash-store-card__actions">
          <a href="https://www.google.com/maps/search/?api=1&amp;query=Cash+Alimentaire+15+17+rue+de+France+06000+Nice" target="_blank" rel="noopener noreferrer">Google Maps <span aria-hidden="true">↗</span></a>
          <a class="cash-store-card__review" href="https://www.google.com/search?q=Cash+Alimentaire+15+17+rue+de+France+Nice+avis" target="_blank" rel="noopener noreferrer">Laisser un avis Google <span aria-hidden="true">↗</span></a>
        </footer>
      </article>
    </div>
  </section>
{/block}
