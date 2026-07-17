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
<div id="_desktop_contact_link">
  <div id="contact-link">
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
        <ul id="nav_contact_info">
        {if $contact_infos.phone}
          <li>
            {* [1][/1] is for a HTML tag. *}
            {l s='[1]%phone%[/1]'
              sprintf=[
              '[1]' => '<a href="tel:'|cat:$contact_infos.phone|cat:'">',
              '[/1]' => '</a>',
              '%phone%' => $contact_infos.phone
              ]
              d='Shop.Theme.Global'
            }
          </li>
          {/if}
             {if $contact_infos.address.address1}
                <li class="hidden-lg-down">
                  {* [1][/1] is for a HTML tag. *}
                  {l
                    s='[1]%city% %address%[/1]'
                    sprintf=[
                      '[1]' => '<span>',
                      '[/1]' => '</span>',
                      '%city%' => $contact_infos.address.city,
                      '%address%' => $contact_infos.address.address1
                    ]
                    d='Shop.Theme.Global'
                  }
                </li>
                {/if}
          {if $contact_infos.email}
          <li>
          {* [1][/1] is for a HTML tag. *}
          {l
            s='[1]%email%[/1]'
            sprintf=[
              '[1]' => '<a href="mailto:'|cat:$contact_infos.email|cat:'" class="dropdown">',
              '[/1]' => '</a>',
              '%email%' => $contact_infos.email
            ]
            d='Shop.Theme.Global'
          }
          </li>
        {/if}

      </ul>
    {/if}
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
        <a href="{$urls.pages.contact}">
          <svg class="hidden-sm-down"
           xmlns="http://www.w3.org/2000/svg"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           width="18px" height="21px">
          <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
           d="M10.931,19.818 C10.588,20.116 10.292,20.373 10.055,20.591 C9.759,20.864 9.380,21.000 9.000,21.000 C8.620,21.000 8.240,20.864 7.944,20.591 C7.708,20.373 7.412,20.116 7.069,19.818 C4.598,17.673 -0.000,13.681 -0.000,8.882 C-0.000,6.510 0.936,4.279 2.636,2.601 C4.336,0.924 6.596,0.000 9.000,0.000 C11.404,0.000 13.664,0.924 15.364,2.601 C17.064,4.279 18.000,6.510 18.000,8.882 C18.000,13.681 13.402,17.673 10.931,19.818 ZM9.000,1.230 C4.725,1.230 1.246,4.663 1.246,8.882 C1.246,13.125 5.569,16.878 7.892,18.894 C8.243,19.199 8.546,19.461 8.795,19.692 C8.910,19.798 9.090,19.798 9.205,19.692 C9.454,19.461 9.757,19.199 10.108,18.894 C12.431,16.878 16.753,13.125 16.753,8.882 C16.753,4.663 13.275,1.230 9.000,1.230 ZM9.000,12.460 C6.813,12.460 5.034,10.705 5.034,8.546 C5.034,6.388 6.813,4.632 9.000,4.632 C11.187,4.632 12.966,6.388 12.966,8.546 C12.966,10.705 11.187,12.460 9.000,12.460 ZM9.000,5.862 C7.500,5.862 6.280,7.066 6.280,8.546 C6.280,10.026 7.500,11.230 9.000,11.230 C10.500,11.230 11.720,10.026 11.720,8.546 C11.720,7.066 10.500,5.862 9.000,5.862 Z"/>
          </svg>
          {l s='Contact us' d='Shop.Theme'}</a>
    {/if}
  </div>
</div>
