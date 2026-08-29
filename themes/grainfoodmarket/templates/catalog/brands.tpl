{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file=$layout}

{block name='content'}
  <section id="main" class="cash-brands-page">
    <header class="cash-brands-page__hero">
      <div class="cash-brands-page__container">
        <span class="cash-brands-page__eyebrow">Partenaires &amp; fabricants</span>
        <h1>Les marques professionnelles que nous distribuons</h1>
        <p>Retrouvez les fabricants et maisons sélectionnés par Cash Alimentaire pour répondre aux exigences des professionnels de la restauration.</p>
        <div class="cash-brands-page__facts"><strong data-brand-count>—</strong><span>marques proposant actuellement des produits</span></div>
      </div>
    </header>

    <div class="cash-brands-page__content">
      <div class="cash-brands-page__container">
        <div class="cash-brands-page__tools">
          <label class="cash-brands-page__search">
            <span>Rechercher une marque</span>
            <span class="cash-brands-page__search-field"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="10.5" cy="10.5" r="6.5"/><path d="m15.5 15.5 5 5"/></svg><input type="search" placeholder="Nom de la marque" data-brand-search autocomplete="off"></span>
          </label>
          <nav class="cash-brands-page__alphabet" aria-label="Filtrer par initiale">
            <button type="button" class="is-active" data-brand-letter="all">Toutes</button>
            <button type="button" data-brand-letter="#">#</button>
            {foreach from=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'] item=letter}
              <button type="button" data-brand-letter="{$letter}">{$letter}</button>
            {/foreach}
          </nav>
        </div>

        {block name='brand_miniature'}
          <ul class="cash-brands-page__grid" data-brand-grid>
            {foreach from=$brands item=brand}
              {if $brand.nb_products > 0 && $brand.name != '.'}
                {include file='catalog/_partials/miniatures/brand.tpl' brand=$brand}
              {/if}
            {/foreach}
          </ul>
          <p class="cash-brands-page__empty" data-brand-empty hidden>Aucune marque ne correspond à votre recherche.</p>
          <nav class="cash-brands-page__pagination" data-brand-pagination aria-label="Pagination des marques"></nav>
        {/block}
      </div>
    </div>

    <aside class="cash-brands-page__cta">
      <div class="cash-brands-page__container"><div><span class="cash-brands-page__eyebrow">Une référence précise ?</span><h2>Notre équipe vous aide à trouver le bon produit.</h2></div><a href="{$urls.pages.contact}" class="cash-brands-page__button">Nous contacter</a></div>
    </aside>
  </section>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      var page = document.querySelector('.cash-brands-page');
      if (!page) return;
      var cards = Array.prototype.slice.call(page.querySelectorAll('[data-brand-name]'));
      var search = page.querySelector('[data-brand-search]');
      var empty = page.querySelector('[data-brand-empty]');
      var count = page.querySelector('[data-brand-count]');
      var pagination = page.querySelector('[data-brand-pagination]');
      var activeLetter = 'all';
      var currentPage = 1;
      var pageSize = 25;
      function normalize(value) { return (value || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase(); }
      function update() {
        var query = normalize(search.value.trim());
        var matches = cards.filter(function (card) {
          var name = normalize(card.getAttribute('data-brand-name'));
          var letterMatch = activeLetter === 'all' || (activeLetter === '#' ? /^[0-9]/.test(name) : name.charAt(0) === activeLetter);
          return (!query || name.indexOf(query) !== -1) && letterMatch;
        });
        var pageCount = Math.max(1, Math.ceil(matches.length / pageSize));
        currentPage = Math.min(currentPage, pageCount);
        cards.forEach(function (card) { card.hidden = true; });
        matches.slice((currentPage - 1) * pageSize, currentPage * pageSize).forEach(function (card) { card.hidden = false; });
        count.textContent = matches.length;
        empty.hidden = matches.length !== 0;
        pagination.innerHTML = '';
        pagination.hidden = pageCount <= 1;
        for (var number = 1; number <= pageCount; number += 1) {
          var button = document.createElement('button');
          button.type = 'button';
          button.textContent = number;
          button.setAttribute('aria-label', 'Page ' + number);
          button.classList.toggle('is-active', number === currentPage);
          (function (targetPage) {
            button.addEventListener('click', function () {
              currentPage = targetPage;
              update();
              page.querySelector('[data-brand-grid]').scrollIntoView({behavior: 'smooth', block: 'start'});
            });
          }(number));
          pagination.appendChild(button);
        }
      }
      search.addEventListener('input', function () { currentPage = 1; update(); });
      page.querySelectorAll('[data-brand-letter]').forEach(function (button) {
        button.addEventListener('click', function () {
          activeLetter = button.getAttribute('data-brand-letter');
          currentPage = 1;
          page.querySelectorAll('[data-brand-letter]').forEach(function (item) { item.classList.toggle('is-active', item === button); });
          update();
        });
      });
      update();
    });
  </script>

{/block}
