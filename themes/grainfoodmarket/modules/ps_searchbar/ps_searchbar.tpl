{*
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2017 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<!-- Block search module TOP -->
<div id="_desktop_search_widget" class="search-wrapper dropdown">
<div id="search_widget" class="search-widget" data-search-controller-url="{$search_controller_url}">
	<form method="get" action="{$search_controller_url}">
		<input type="hidden" name="controller" value="search">
		<input type="text" name="s" value="{$search_string}" placeholder="{l s='Search' d='Shop.Theme.Catalog'}" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
		<button type="submit" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
			<svg
             xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             width="19px" height="18px">
            <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
             d="M13.899,11.849 L18.603,16.552 L17.239,17.916 L12.536,13.212 L13.238,12.510 C10.413,15.333 5.835,15.333 3.011,12.509 C0.186,9.684 0.186,5.105 3.011,2.281 C5.835,-0.543 10.414,-0.543 13.239,2.281 C16.063,5.105 16.063,9.683 13.239,12.508 L13.899,11.849 ZM11.829,3.692 C9.783,1.646 6.467,1.646 4.421,3.692 C2.376,5.737 2.376,9.054 4.421,11.099 C6.467,13.144 9.783,13.144 11.829,11.099 C13.874,9.054 13.874,5.737 11.829,3.692 Z"/>
            </svg>
		</button>

	</form>
</div>
</div>
<!-- /Block search module TOP -->
