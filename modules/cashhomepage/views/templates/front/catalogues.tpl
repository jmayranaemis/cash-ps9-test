{extends file='page.tpl'}

{block name='page_header_container'}{/block}

{block name='page_content_container'}
  <div class="cash-catalogues-page">
    <header class="cash-catalogues-page__hero">
      <div class="cash-home__container">
        <p class="cash-eyebrow">Sélections & nouveautés</p>
        <h1>Nos catalogues professionnels</h1>
      </div>
    </header>

    <section class="cash-catalogues-page__content">
      <div class="cash-home__container">
        {if $cash_catalogues}
          <div class="cash-catalogues-page__heading">
            <div>
              <p class="cash-eyebrow">Disponibles actuellement</p>
              <h2>Les catalogues du moment</h2>
            </div>
            <p>Cliquez sur «&nbsp;Feuilleter&nbsp;» pour ouvrir le lecteur plein écran.</p>
          </div>
          <div class="cash-catalogues-page__grid">
            {foreach from=$cash_catalogues item=catalogue}
              {include file='module:cashhomepage/views/templates/_partials/catalogue-card.tpl' catalogue=$catalogue}
            {/foreach}
          </div>
        {else}
          <div class="cash-catalogues-page__empty">
            <p class="cash-eyebrow">Prochainement</p>
            <h2>Aucun catalogue n’est publié actuellement.</h2>
            <p>Notre équipe peut néanmoins vous transmettre la documentation adaptée à votre activité.</p>
            <a class="cash-button cash-button--primary" href="{$cash_catalogue_contact_url|escape:'htmlall':'UTF-8'}">Demander un catalogue</a>
          </div>
        {/if}
      </div>
    </section>

    <aside class="cash-catalogues-page__help">
      <div class="cash-home__container">
        <div>
          <p class="cash-eyebrow">Besoin d’une sélection précise&nbsp;?</p>
          <h2>Parlez-nous de votre activité.</h2>
        </div>
        <a class="cash-button cash-button--primary" href="{$cash_catalogue_contact_url|escape:'htmlall':'UTF-8'}">Contacter l’équipe commerciale</a>
      </div>
    </aside>
  </div>
{/block}
