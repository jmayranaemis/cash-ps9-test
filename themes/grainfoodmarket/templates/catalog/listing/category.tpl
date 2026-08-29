{*
* 2021 Anvanto
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses.
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
*  @author Anvanto <anvantoco@gmail.com>
*  @copyright  2021 Anvanto
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of Anvanto
*}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
    <div class="block-category card card-block cash-category-hero">
        <div class="cash-category-hero__copy">
            <span class="cash-category-hero__eyebrow">La sélection Cash Alimentaire</span>
            <h1 class="h1">{$category.name}</h1>
            {if $category.description}
                <div id="category-description" class="{if Module::isEnabled('an_theme') AND Module::getInstanceByName('an_theme')->getParam('categoryPage_showCategoryDescription')!='1'}hidden-sm-down{/if}">
                    {$category.description nofilter}
                </div>
            {/if}
            <div class="cash-category-hero__meta">
                <span>Catalogue professionnel</span>
            </div>
        </div>
        {if isset($category.image.bySize.category_default.url) AND ($category.image.bySize.category_default.url!='')}
            <div class="cash-category-hero__visual {if Module::isEnabled('an_theme') AND Module::getInstanceByName('an_theme')->getParam('categoryPage_showCategoryDescription')!='1'}hidden-sm-down{/if}">
                <span class="cash-category-hero__image">
                    <img fetchpriority="high" src="{$category.image.bySize.category_default.url}" alt="{$category.image.legend}">
                </span>
                <small>Une offre pensée pour les professionnels</small>
            </div>
        {/if}
    </div>
{/block}
