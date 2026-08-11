{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
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
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{block name='brand_miniature_item'}
  <li class="brand cash-brand-card" data-brand-name="{$brand.name|escape:'html':'UTF-8'}">
    <a href="{$brand.url}" class="cash-brand-card__link" aria-label="Voir les produits {$brand.name|escape:'html':'UTF-8'}">
      <div class="brand-img cash-brand-card__logo">
            {if version_compare($smarty.const._PS_VERSION_, '9.0.0.0', '<')}
                <img src="{$brand.image}" alt="{$brand.name}">
            {else}
                <picture>
                  {if !empty($brand.image.bySize.small_default.sources.avif)}<source srcset="{$brand.image.bySize.small_default.sources.avif}" type="image/avif">{/if}
                  {if !empty($brand.image.bySize.small_default.sources.webp)}<source srcset="{$brand.image.bySize.small_default.sources.webp}" type="image/webp">{/if}
                  <img
                    src="{$brand.image.bySize.small_default.url}"
                    alt="{if !empty($brand.image.legend)}{$brand.image.legend}{else}{$brand.name}{/if}"
                    class="img-fluid"
                    loading="lazy"
                  >
                </picture>
            {/if}
      </div>
      <div class="brand-infos cash-brand-card__body">
        <h2>{$brand.name}</h2>
        {if $brand.text}<p>{$brand.text|strip_tags|truncate:105:'…'}</p>{/if}
        <div class="cash-brand-card__footer"><span>{$brand.nb_products} {if $brand.nb_products > 1}produits{else}produit{/if}</span><strong>Découvrir <b aria-hidden="true">→</b></strong></div>
      </div>
    </a>
  </li>
{/block}
