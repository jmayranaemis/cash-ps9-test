{**
* 2019 Anvanto
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
*  @author Anvanto (anvantoco@gmail.com)
*  @copyright  2019 anvanto.com

*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div  class="an_wishlist-nav-link" id="_desktop_an_wishlist-nav">
	<a href="{$link->getModuleLink('an_wishlist', 'list', array(), true)|escape:'htmlall':'UTF-8'}" title="{l s='My wishlist' d='Shop.Theme.Global'}">
	    <svg
         xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         width="20px" height="17px">
        <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
         d="M14.609,0.000 C12.946,0.000 11.487,0.745 10.392,2.154 C10.246,2.341 10.115,2.529 10.000,2.711 C9.885,2.529 9.754,2.341 9.608,2.154 C8.513,0.745 7.054,0.000 5.391,0.000 C2.248,0.000 -0.000,2.642 -0.000,5.811 C-0.000,9.435 2.959,12.851 9.595,16.886 C9.720,16.962 9.860,17.000 10.000,17.000 C10.140,17.000 10.280,16.962 10.405,16.886 C17.041,12.851 20.000,9.435 20.000,5.811 C20.000,2.643 17.754,0.000 14.609,0.000 ZM16.373,10.324 C14.992,11.871 12.904,13.501 10.000,15.297 C7.096,13.501 5.008,11.871 3.627,10.324 C2.238,8.768 1.563,7.292 1.563,5.811 C1.563,3.529 3.099,1.568 5.391,1.568 C6.558,1.568 7.553,2.078 8.348,3.082 C8.984,3.886 9.252,4.715 9.254,4.721 C9.356,5.049 9.658,5.272 10.000,5.272 C10.342,5.272 10.644,5.049 10.746,4.721 C10.748,4.713 11.008,3.909 11.623,3.119 C12.423,2.090 13.428,1.568 14.609,1.568 C16.903,1.568 18.438,3.531 18.438,5.811 C18.438,7.292 17.762,8.768 16.373,10.324 Z"/>
        </svg>
	    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
		<span class="hidden-sm-down">Favoris{if ($config.display_likes_nav)} (<span class="js-an_wishlist-nav-count">{$count|intval}</span>){/if}</span>
		{/if}
		{if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
		or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
		or  (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
		    <svg class="hidden-sm-down"
             xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             width="20px" height="17px">
            <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
             d="M14.609,0.000 C12.946,0.000 11.487,0.745 10.392,2.154 C10.246,2.341 10.115,2.529 10.000,2.711 C9.885,2.529 9.754,2.341 9.608,2.154 C8.513,0.745 7.054,0.000 5.391,0.000 C2.248,0.000 -0.000,2.642 -0.000,5.811 C-0.000,9.435 2.959,12.851 9.595,16.886 C9.720,16.962 9.860,17.000 10.000,17.000 C10.140,17.000 10.280,16.962 10.405,16.886 C17.041,12.851 20.000,9.435 20.000,5.811 C20.000,2.643 17.754,0.000 14.609,0.000 ZM16.373,10.324 C14.992,11.871 12.904,13.501 10.000,15.297 C7.096,13.501 5.008,11.871 3.627,10.324 C2.238,8.768 1.563,7.292 1.563,5.811 C1.563,3.529 3.099,1.568 5.391,1.568 C6.558,1.568 7.553,2.078 8.348,3.082 C8.984,3.886 9.252,4.715 9.254,4.721 C9.356,5.049 9.658,5.272 10.000,5.272 C10.342,5.272 10.644,5.049 10.746,4.721 C10.748,4.713 11.008,3.909 11.623,3.119 C12.423,2.090 13.428,1.568 14.609,1.568 C16.903,1.568 18.438,3.531 18.438,5.811 C18.438,7.292 17.762,8.768 16.373,10.324 Z"/>
            </svg>
		    <span class="hidden-sm-down">{l s='My wishlist' d='Shop.Theme.Global'}{if ($config.display_likes_nav)} (<span class="js-an_wishlist-nav-count">{$count|intval}</span>){/if}</span>
		{/if}
		{if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
		     <svg class="hidden-sm-down"
                 xmlns="http://www.w3.org/2000/svg"
                 xmlns:xlink="http://www.w3.org/1999/xlink"
                 width="20px" height="17px">
                <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                 d="M14.609,0.000 C12.946,0.000 11.487,0.745 10.392,2.154 C10.246,2.341 10.115,2.529 10.000,2.711 C9.885,2.529 9.754,2.341 9.608,2.154 C8.513,0.745 7.054,0.000 5.391,0.000 C2.248,0.000 -0.000,2.642 -0.000,5.811 C-0.000,9.435 2.959,12.851 9.595,16.886 C9.720,16.962 9.860,17.000 10.000,17.000 C10.140,17.000 10.280,16.962 10.405,16.886 C17.041,12.851 20.000,9.435 20.000,5.811 C20.000,2.643 17.754,0.000 14.609,0.000 ZM16.373,10.324 C14.992,11.871 12.904,13.501 10.000,15.297 C7.096,13.501 5.008,11.871 3.627,10.324 C2.238,8.768 1.563,7.292 1.563,5.811 C1.563,3.529 3.099,1.568 5.391,1.568 C6.558,1.568 7.553,2.078 8.348,3.082 C8.984,3.886 9.252,4.715 9.254,4.721 C9.356,5.049 9.658,5.272 10.000,5.272 C10.342,5.272 10.644,5.049 10.746,4.721 C10.748,4.713 11.008,3.909 11.623,3.119 C12.423,2.090 13.428,1.568 14.609,1.568 C16.903,1.568 18.438,3.531 18.438,5.811 C18.438,7.292 17.762,8.768 16.373,10.324 Z"/>
                </svg>
                <span class="hidden-sm-down hidden-md-up">{l s='My wishlist' d='Shop.Theme.Global'}</span>{if ($config.display_likes_nav)}<span class="js-an_wishlist-nav-count hidden-sm-down">{$count|intval}</span>{/if}
		{/if}
	</a>
</div>
