<article class="cash-flipbook-card">
  <div class="cash-flipbook-card__media">
    <div
      id="cash_catalogue_{$catalogue.id|intval}"
      class="_df_thumb cash-flipbook-card__cover"
      source="{$catalogue.pdf_url|escape:'htmlall':'UTF-8'}"
      {if $catalogue.thumb_url}thumb="{$catalogue.thumb_url|escape:'htmlall':'UTF-8'}"{/if}
      sound="{$catalogue.sound|intval}"
      title="{$catalogue.title|escape:'htmlall':'UTF-8'}"
      download="{$catalogue.download|intval}"
      backgroundcolor="{$catalogue.background_color|escape:'htmlall':'UTF-8'}"
    ></div>
    <script>
      var option_cash_catalogue_{$catalogue.id|intval} = {
        text: {
          previousPage: "Précédent",
          nextPage: "Suivant",
          toggleThumbnails: "Miniatures",
          zoomOut: "Zoom arrière",
          zoomIn: "Zoom avant",
          toggleFullscreen: "Plein écran",
          downloadPDFFile: "Télécharger",
          gotoFirstPage: "Première page",
          gotoLastPage: "Dernière page",
          toggleSound: "Activer ou désactiver le son"
        }
      };
    </script>
  </div>
  <div class="cash-flipbook-card__body">
    <span class="cash-flipbook-card__label">Catalogue interactif</span>
    <h3>{$catalogue.title|escape:'htmlall':'UTF-8'}</h3>
    <p>Feuilletez ce catalogue en ligne et retrouvez rapidement les références utiles à votre activité.</p>
    <div class="cash-flipbook-card__actions">
      <button
        type="button"
        class="cash-button cash-button--primary"
        data-cash-open-catalogue="cash_catalogue_{$catalogue.id|intval}"
      >Feuilleter</button>
      {if $catalogue.download}
        <a
          class="cash-flipbook-card__download"
          href="{$catalogue.pdf_url|escape:'htmlall':'UTF-8'}"
          download
        >Télécharger le PDF</a>
      {/if}
    </div>
  </div>
</article>
