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
{extends file='page.tpl'}

{block name='page_header_container'}{/block}

{block name='page_content_container'}
  <section id="content" class="page-content cash-stores-page">
    <header class="cash-stores-page__hero">
      <div class="cash-stores-page__container">
        <span>Cash Alimentaire près de chez vous</span>
        <h1>Nos magasins et notre centre logistique</h1>
        <p>Deux boutiques au cœur de Nice et une plateforme logistique à La Trinité pour servir les professionnels de la Côte d’Azur.</p>
      </div>
    </header>

    <div class="cash-stores-page__container cash-stores-grid">
      {foreach $stores as $store}
        {if $store.id == 1}
          {assign var='cash_store_image' value="{$urls.base_url}modules/cashhomepage/views/img/cash-store-france.webp"}
          {assign var='cash_store_kind' value='Boutique de proximité'}
          {assign var='cash_store_maps' value='https://www.google.com/maps/search/?api=1&query=Cash+Alimentaire+15+rue+de+France+06000+Nice'}
          {assign var='cash_store_reviews' value='https://www.google.com/search?q=Cash+Alimentaire+15+rue+de+France+Nice+avis'}
        {elseif $store.id == 2}
          {assign var='cash_store_image' value="{$urls.base_url}modules/cashhomepage/views/img/cash-store-villermont.webp"}
          {assign var='cash_store_kind' value='Boutique historique'}
          {assign var='cash_store_maps' value='https://www.google.com/maps/search/?api=1&query=Cash+Alimentaire+19+avenue+Villermont+06000+Nice'}
          {assign var='cash_store_reviews' value='https://www.google.com/search?q=Cash+Alimentaire+19+avenue+Villermont+Nice+avis'}
        {else}
          {assign var='cash_store_image' value="{$urls.base_url}modules/cashhomepage/views/img/cash-about-logistics.webp"}
          {assign var='cash_store_kind' value='Centre logistique'}
          {assign var='cash_store_maps' value='https://www.google.com/maps/search/?api=1&query=Cash+Alimentaire+38+boulevard+de+l%27Oli+06340+La+Trinite'}
          {assign var='cash_store_reviews' value='https://www.google.com/search?q=Cash+Alimentaire+38+boulevard+de+l%27Oli+La+Trinite+avis'}
        {/if}

        <article id="store-{$store.id}" class="cash-store-card">
          <figure class="cash-store-card__image">
            <img src="{$cash_store_image|escape:'htmlall':'UTF-8'}" width="1000" height="620" loading="lazy" alt="{$store.name|escape:'htmlall':'UTF-8'}">
            <figcaption>{$cash_store_kind|escape:'htmlall':'UTF-8'}</figcaption>
          </figure>

          <div class="cash-store-card__content">
            <h2>{$store.name|escape:'htmlall':'UTF-8'}</h2>
            {if $store.note}<p class="cash-store-card__intro">{$store.note nofilter}</p>{/if}

            <address class="cash-store-card__line">
              <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 21s7-6.1 7-12A7 7 0 0 0 5 9c0 5.9 7 12 7 12Z"/><circle cx="12" cy="9" r="2.4"/></svg>
              <span>{$store.address.formatted nofilter}</span>
            </address>

            {if $store.phone}
              <a class="cash-store-card__line" href="tel:{$store.phone|replace:' ':''|escape:'htmlall':'UTF-8'}">
                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7.2 3.2 9.6 7a1.5 1.5 0 0 1-.2 1.8l-1.5 1.5a15.4 15.4 0 0 0 5.8 5.8l1.5-1.5a1.5 1.5 0 0 1 1.8-.2l3.8 2.4a1.5 1.5 0 0 1 .7 1.5v2a1.5 1.5 0 0 1-1.5 1.5C10.2 21.8 2.2 13.8 2.2 4A1.5 1.5 0 0 1 3.7 2.5h2a1.5 1.5 0 0 1 1.5.7Z"/></svg>
                <strong>{$store.phone|escape:'htmlall':'UTF-8'}</strong>
              </a>
            {/if}

            <div class="cash-store-card__hours">
              <div class="cash-store-card__hours-title">
                <svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.4 2"/></svg>
                <strong>Horaires</strong>
              </div>
              <table>
                {foreach $store.business_hours as $day}
                  <tr>
                    <th>{$day.day|truncate:4:'.'}</th>
                    <td>{foreach $day.hours as $h}<span>{$h|escape:'htmlall':'UTF-8'}</span>{/foreach}</td>
                  </tr>
                {/foreach}
              </table>
            </div>
          </div>

          <footer class="cash-store-card__actions">
            <a href="{$cash_store_maps|escape:'htmlall':'UTF-8'}" target="_blank" rel="noopener noreferrer">Voir sur Google Maps</a>
            <a class="cash-store-card__review" href="{$cash_store_reviews|escape:'htmlall':'UTF-8'}" target="_blank" rel="noopener noreferrer">Laisser un avis Google</a>
          </footer>
        </article>
      {/foreach}
    </div>
  </section>
{/block}
