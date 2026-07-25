<nav class="cash-main-nav" aria-label="Navigation principale">
  <div class="cash-main-nav__products">
    <a href="{$cash_nav_products_url|escape:'htmlall':'UTF-8'}">Produits</a>
    {if $cash_nav_families}
      <div class="cash-main-nav__dropdown">
        {foreach from=$cash_nav_families item=family}
          <a href="{$family.url|escape:'htmlall':'UTF-8'}">{$family.name|escape:'htmlall':'UTF-8'}</a>
        {/foreach}
      </div>
    {/if}
  </div>
  <a href="{$urls.base_url|escape:'htmlall':'UTF-8'}#catalogues">Catalogues</a>
  <a href="{$urls.base_url|escape:'htmlall':'UTF-8'}#familles-produits">Nos métiers</a>
  <a class="cash-main-nav__client" href="{$cash_nav_become_client_url|escape:'htmlall':'UTF-8'}">Devenir client</a>
  <a href="{$cash_nav_contact_url|escape:'htmlall':'UTF-8'}">Nous contacter</a>
</nav>
