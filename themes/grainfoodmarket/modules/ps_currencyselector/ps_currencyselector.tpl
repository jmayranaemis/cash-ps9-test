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
 
 <div id="_desktop_currency_selector" class="lang_and_сr">
   <div class="currency-selector dropdown js-dropdown">
     <span id="currency-selector-label" class="
    
  lang_and_сr_label">{l s='Currency:' d='Shop.Theme.Global'}</span>
     <button data-target="#" data-toggle="dropdown" class="
       {if $an_width_on_mobile =='992'}
         hidden-md-down
       {else}
         hidden-sm-down
       {/if}
      btn-unstyle" aria-haspopup="true" aria-expanded="false" aria-label="{l s='Currency dropdown' d='Shop.Theme.Global'} {$current_currency.iso_code}">
       <span class="expand-more _gray-darker">{$current_currency.iso_code}</span>
       <i class="material-icons expand-more">keyboard_arrow_down</i>
     </button>
     <ul class="dropdown-menu 
       {if $an_width_on_mobile =='992'}
         hidden-md-down
       {else}
         hidden-sm-down
       {/if}
      " aria-labelledby="currency-selector-label">
       {foreach from=$currencies item=currency}
         <li {if $currency.current} class="current" {/if}>
           <a title="{$currency.name}" rel="nofollow" href="{$currency.url}" class="dropdown-item">{$currency.iso_code}</a>
         </li>
       {/foreach}
     </ul>
     <select class="link 
       {if $an_width_on_mobile =='992'}
         hidden-lg-up
       {else}
         hidden-md-up
       {/if}
      " aria-labelledby="currency-selector-label">
       {foreach from=$currencies item=currency}
         <option value="{$currency.url}"{if $currency.current} selected="selected"{/if}>{$currency.iso_code}</option>
       {/foreach}
     </select>
     <div class="mobile_item_wrapper
     {if $an_width_on_mobile =='992'}
       hidden-lg-up
     {else}
       hidden-md-up
     {/if}
     ">
       <span>{$current_currency.iso_code}</span>
       <span class="mobile-toggler">
        <svg 
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        width="5px" height="9px">
       <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
        d="M4.913,4.292 L0.910,0.090 C0.853,0.030 0.787,-0.000 0.713,-0.000 C0.639,-0.000 0.572,0.030 0.515,0.090 L0.086,0.541 C0.029,0.601 -0.000,0.670 -0.000,0.749 C-0.000,0.827 0.029,0.896 0.086,0.956 L3.462,4.500 L0.086,8.044 C0.029,8.104 -0.000,8.173 -0.000,8.251 C-0.000,8.330 0.029,8.399 0.086,8.459 L0.515,8.910 C0.572,8.970 0.639,9.000 0.713,9.000 C0.787,9.000 0.853,8.970 0.910,8.910 L4.913,4.707 C4.970,4.647 4.999,4.578 4.999,4.500 C4.999,4.422 4.970,4.353 4.913,4.292 Z"/>
       </svg>
       </span>
     </div>
      <div class="adropdown-mobile">
       {foreach from=$currencies item=currency}
         <a title="{$currency.name}" rel="nofollow" href="{$currency.url}" class="">{$currency.iso_code}</a>
       {/foreach}
     </div>
   </div>
 </div>
 