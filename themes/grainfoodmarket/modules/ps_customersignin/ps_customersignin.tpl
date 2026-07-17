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
 <div id="_desktop_user_info">
   <div class="user-info">
       {if $logged}
         <a
         class="account dropdown-item
         {if $an_width_on_mobile =='992'}
           hidden-lg-up
         {else}
           hidden-md-up
         {/if}
         "
         href="{$my_account_url}"
         title="{l s='View my customer account' d='Shop.Theme.Customeraccount'}"
         rel="nofollow"
         >

             <svg class="hidden-md-up"
               xmlns="http://www.w3.org/2000/svg"
               xmlns:xlink="http://www.w3.org/1999/xlink"
               width="20px" height="20px">
              <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
               d="M10.000,20.000 C7.329,20.000 4.818,18.960 2.929,17.071 C1.040,15.182 -0.000,12.671 -0.000,10.000 C-0.000,7.329 1.040,4.818 2.929,2.929 C4.818,1.040 7.329,0.000 10.000,0.000 C12.671,0.000 15.182,1.040 17.071,2.929 C18.960,4.818 20.000,7.329 20.000,10.000 C20.000,12.671 18.960,15.182 17.071,17.071 C15.182,18.960 12.671,20.000 10.000,20.000 L10.000,20.000 ZM10.000,1.562 C5.348,1.562 1.563,5.348 1.563,10.000 C1.563,14.653 5.348,18.437 10.000,18.437 C14.652,18.437 18.438,14.653 18.438,10.000 C18.438,5.348 14.652,1.562 10.000,1.562 ZM9.961,10.742 C7.893,10.742 6.211,9.060 6.211,6.992 C6.211,4.924 7.893,3.242 9.961,3.242 C12.029,3.242 13.711,4.924 13.711,6.992 C13.711,9.060 12.029,10.742 9.961,10.742 ZM9.961,4.805 C8.755,4.805 7.773,5.786 7.773,6.992 C7.773,8.198 8.755,9.180 9.961,9.180 C11.167,9.180 12.148,8.198 12.148,6.992 C12.148,5.786 11.167,4.805 9.961,4.805 ZM14.911,15.292 C15.244,15.019 15.293,14.526 15.020,14.192 C13.915,12.844 12.283,12.070 10.542,12.070 L9.615,12.070 C7.873,12.070 6.241,12.844 5.136,14.192 C4.863,14.526 4.912,15.019 5.246,15.292 C5.579,15.565 6.072,15.516 6.345,15.183 C7.152,14.198 8.344,13.633 9.615,13.633 L10.542,13.633 C11.813,13.633 13.004,14.198 13.811,15.183 C13.966,15.371 14.190,15.469 14.416,15.469 C14.590,15.469 14.765,15.411 14.911,15.292 L14.911,15.292 Z"/>
              </svg>
           <span class="hidden-sm-down">{$customerName|truncate:20:'...'}</span>
         </a>
         <div class="signin dropdown js-dropdown
         {if $an_width_on_mobile =='992'}
           hidden-md-down
         {else}
           hidden-sm-down
         {/if}
         ">
           <button data-toggle="dropdown" class="hidden-sm-down btn-unstyle" aria-haspopup="true" aria-expanded="false" aria-label="{l s='Logout dropdown' d='Shop.Theme.Global'}">
             {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
             or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
             or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')
             or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
             <svg class="hidden-sm-down"
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              width="20px" height="20px">
             <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
              d="M10.000,20.000 C7.329,20.000 4.818,18.960 2.929,17.071 C1.040,15.182 -0.000,12.671 -0.000,10.000 C-0.000,7.329 1.040,4.818 2.929,2.929 C4.818,1.040 7.329,0.000 10.000,0.000 C12.671,0.000 15.182,1.040 17.071,2.929 C18.960,4.818 20.000,7.329 20.000,10.000 C20.000,12.671 18.960,15.182 17.071,17.071 C15.182,18.960 12.671,20.000 10.000,20.000 L10.000,20.000 ZM10.000,1.562 C5.348,1.562 1.563,5.348 1.563,10.000 C1.563,14.653 5.348,18.437 10.000,18.437 C14.652,18.437 18.438,14.653 18.438,10.000 C18.438,5.348 14.652,1.562 10.000,1.562 ZM9.961,10.742 C7.893,10.742 6.211,9.060 6.211,6.992 C6.211,4.924 7.893,3.242 9.961,3.242 C12.029,3.242 13.711,4.924 13.711,6.992 C13.711,9.060 12.029,10.742 9.961,10.742 ZM9.961,4.805 C8.755,4.805 7.773,5.786 7.773,6.992 C7.773,8.198 8.755,9.180 9.961,9.180 C11.167,9.180 12.148,8.198 12.148,6.992 C12.148,5.786 11.167,4.805 9.961,4.805 ZM14.911,15.292 C15.244,15.019 15.293,14.526 15.020,14.192 C13.915,12.844 12.283,12.070 10.542,12.070 L9.615,12.070 C7.873,12.070 6.241,12.844 5.136,14.192 C4.863,14.526 4.912,15.019 5.246,15.292 C5.579,15.565 6.072,15.516 6.345,15.183 C7.152,14.198 8.344,13.633 9.615,13.633 L10.542,13.633 C11.813,13.633 13.004,14.198 13.811,15.183 C13.966,15.371 14.190,15.469 14.416,15.469 C14.590,15.469 14.765,15.411 14.911,15.292 L14.911,15.292 Z"/>
             </svg>
             {/if}
             <div class="profile-label">
                 <span class="expand-more">{$customerName|truncate:20:'...'}</span>
                 <i class="material-icons expand-more">&#xE313;</i>
             </div>
           </button>
         <ul class="dropdown-menu  
           " aria-labelledby="signin-label">
           <li>
               <a
                 class="logout dropdown-item"
                 href="{$my_account_url}"
                 rel="nofollow"
               >
                 {l s='Your account' d='Shop.Theme.Customeraccount'}
               </a>
             </li>
           <li>
             <a
               class="logout dropdown-item"
               href="{$logout_url}"
               rel="nofollow"
             >
               {l s='Sign out' d='Shop.Theme.Actions'}
             </a>
           </li>
         </ul>
       </div>
       {else}
         <a
           href="{$my_account_url}"
           title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}"
           rel="nofollow"
         >
            {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
            or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
            or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')
            or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
            <svg class="hidden-sm-down"
             xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             width="20px" height="20px">
            <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
             d="M10.000,20.000 C7.329,20.000 4.818,18.960 2.929,17.071 C1.040,15.182 -0.000,12.671 -0.000,10.000 C-0.000,7.329 1.040,4.818 2.929,2.929 C4.818,1.040 7.329,0.000 10.000,0.000 C12.671,0.000 15.182,1.040 17.071,2.929 C18.960,4.818 20.000,7.329 20.000,10.000 C20.000,12.671 18.960,15.182 17.071,17.071 C15.182,18.960 12.671,20.000 10.000,20.000 L10.000,20.000 ZM10.000,1.562 C5.348,1.562 1.563,5.348 1.563,10.000 C1.563,14.653 5.348,18.437 10.000,18.437 C14.652,18.437 18.438,14.653 18.438,10.000 C18.438,5.348 14.652,1.562 10.000,1.562 ZM9.961,10.742 C7.893,10.742 6.211,9.060 6.211,6.992 C6.211,4.924 7.893,3.242 9.961,3.242 C12.029,3.242 13.711,4.924 13.711,6.992 C13.711,9.060 12.029,10.742 9.961,10.742 ZM9.961,4.805 C8.755,4.805 7.773,5.786 7.773,6.992 C7.773,8.198 8.755,9.180 9.961,9.180 C11.167,9.180 12.148,8.198 12.148,6.992 C12.148,5.786 11.167,4.805 9.961,4.805 ZM14.911,15.292 C15.244,15.019 15.293,14.526 15.020,14.192 C13.915,12.844 12.283,12.070 10.542,12.070 L9.615,12.070 C7.873,12.070 6.241,12.844 5.136,14.192 C4.863,14.526 4.912,15.019 5.246,15.292 C5.579,15.565 6.072,15.516 6.345,15.183 C7.152,14.198 8.344,13.633 9.615,13.633 L10.542,13.633 C11.813,13.633 13.004,14.198 13.811,15.183 C13.966,15.371 14.190,15.469 14.416,15.469 C14.590,15.469 14.765,15.411 14.911,15.292 L14.911,15.292 Z"/>
            </svg>
            {/if}
             <svg class="hidden-md-up"
               xmlns="http://www.w3.org/2000/svg"
               xmlns:xlink="http://www.w3.org/1999/xlink"
               width="20px" height="20px">
              <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
               d="M10.000,20.000 C7.329,20.000 4.818,18.960 2.929,17.071 C1.040,15.182 -0.000,12.671 -0.000,10.000 C-0.000,7.329 1.040,4.818 2.929,2.929 C4.818,1.040 7.329,0.000 10.000,0.000 C12.671,0.000 15.182,1.040 17.071,2.929 C18.960,4.818 20.000,7.329 20.000,10.000 C20.000,12.671 18.960,15.182 17.071,17.071 C15.182,18.960 12.671,20.000 10.000,20.000 L10.000,20.000 ZM10.000,1.562 C5.348,1.562 1.563,5.348 1.563,10.000 C1.563,14.653 5.348,18.437 10.000,18.437 C14.652,18.437 18.438,14.653 18.438,10.000 C18.438,5.348 14.652,1.562 10.000,1.562 ZM9.961,10.742 C7.893,10.742 6.211,9.060 6.211,6.992 C6.211,4.924 7.893,3.242 9.961,3.242 C12.029,3.242 13.711,4.924 13.711,6.992 C13.711,9.060 12.029,10.742 9.961,10.742 ZM9.961,4.805 C8.755,4.805 7.773,5.786 7.773,6.992 C7.773,8.198 8.755,9.180 9.961,9.180 C11.167,9.180 12.148,8.198 12.148,6.992 C12.148,5.786 11.167,4.805 9.961,4.805 ZM14.911,15.292 C15.244,15.019 15.293,14.526 15.020,14.192 C13.915,12.844 12.283,12.070 10.542,12.070 L9.615,12.070 C7.873,12.070 6.241,12.844 5.136,14.192 C4.863,14.526 4.912,15.019 5.246,15.292 C5.579,15.565 6.072,15.516 6.345,15.183 C7.152,14.198 8.344,13.633 9.615,13.633 L10.542,13.633 C11.813,13.633 13.004,14.198 13.811,15.183 C13.966,15.371 14.190,15.469 14.416,15.469 C14.590,15.469 14.765,15.411 14.911,15.292 L14.911,15.292 Z"/>
              </svg>
           <span class="account-login hidden-sm-down">{l s='Sign in' d='Shop.Theme.Actions'}</span>
         </a>
       {/if}
       <!--
     {if $logged}
       <a
         class="account"
         href="{$my_account_url}"
         title="{l s='View my customer account' d='Shop.Theme.Customeraccount'}"
         rel="nofollow"
       >
         <span>{$customerName}</span>
       </a>
       <a
         class="logout"
         href="{$logout_url}"
         rel="nofollow"
       >
         {l s='Sign out' d='Shop.Theme.Actions'}
       </a>
     {else}
       <a
         href="{$my_account_url}"
         title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}"
         rel="nofollow"
       >
         <span>{l s='Sign Up' d='Shop.Theme.Actions'}</span>
       </a>
     {/if}
     -->
   </div>
 </div>
 