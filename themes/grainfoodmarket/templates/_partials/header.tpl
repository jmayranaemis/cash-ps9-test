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
 {block name='header_banner'}
 <div class="header-banner">
  {hook h='displayBanner'}
</div>
{/block}

{block name='header_nav'}
<nav class="header-nav">
  <div class="container">
    <div class="row">
      <div class="hidden-sm-down">
        <div class="
         {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
            col-lg-4 col-md-5 col-sm-4
         {/if}
         {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')}
            col-lg-6 col-md-5 col-sm-6
         {/if}
         {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
             col-lg-4 col-md-3 col-sm-4
          {/if}
        col-xs-12 left-nav">
          {hook h='displayNav1'}
        </div>
        {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
        <div class="col-lg-4 col-md-4 col-sm-4">
          <div id="_desktop_social">
            <a class="cash-header-pro" href="https://www.cmdcase.fr/" target="_blank" rel="noopener noreferrer">
              <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 8.5h16v11H4zM7 8.5V6a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v2.5M4 12h16M10 12v2h4v-2"/></svg>
              <span><small>Commandes en ligne</small><strong>Notre espace pro</strong></span>
              <span class="cash-header-pro__arrow" aria-hidden="true">↗</span>
            </a>
          </div>
        </div>
        {/if}
        <div class="
            {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
                col-lg-4 col-md-3 col-sm-4
            {/if}
            {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')}
                col-lg-6 col-md-7 col-sm-6
             {/if}
             {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
                 col-lg-8 col-md-9 col-sm-8
              {/if}
            right-nav">
            {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
                {hook h='displayNav3'}
            {/if}
          {hook h='displayNav2'}
        </div>
      </div>
      <div class="hidden-md-up text-xs-center mobile">
        <div class="mobile-header">
            <div class="pull-xs-right" id="_mobile_cart"></div>
            <div class="pull-xs-right" id="_mobile_user_info"></div>
            <div class="pull-xs-right" id="_mobile_clientservice"></div>
            <div class="top-logo" id="_mobile_logo"></div>
            </div>
            <div class="mobile-header-holder"></div>
        <div class="pull-xs-right" id="_mobile_search_widget"></div>
        <div class="cash-mobile-actions">
          <a class="cash-header-pro cash-header-pro--mobile" href="https://www.cmdcase.fr/" target="_blank" rel="noopener noreferrer">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 8.5h16v11H4zM7 8.5V6a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v2.5M4 12h16M10 12v2h4v-2"/></svg>
            <span><small>Commandes en ligne</small><strong>Notre espace pro</strong></span>
            <span class="cash-header-pro__arrow" aria-hidden="true">↗</span>
          </a>
          <div class="cash-mobile-quicklinks">{hook h='displayNav3'}</div>
        </div>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</nav>
{/block}

{block name='header_top'}
<div class="header-top">
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
    <div class="container header_middle_line">
      {hook h='displayLogoHeader'}
      <div class="header-middle col-md-6">
        {hook h='displaySearch'}
      </div>
      <div class="header-right col-md-3">
        {hook h='displayNav3'}
      </div>
    </div>
    {if Module::isEnabled('an_theme') && Module::getInstanceByName('an_theme')->getParam('header_logoMiddle') == '1'}
    <div class="navigation position-static fixed-menu-target">
    {else}
      <div class="navigation position-static fixed-menu-target">
    {/if}
        <div class="container anmm-dropdown-container">
          <div class="row">
            {hook h='displayTop'}
            <div class="clearfix"></div>
          </div>
        </div>
      </div>
       {/if}
       {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')}
       <div class="fixed-menu-target">
           <div class="container header_middle_line anmm-dropdown-container">
            {hook h='displayLogoHeader'}

             <div class="header-middle col-md-6 static-position">
                  {hook h='displayTop'}
             </div>
             <div class="header-right col-md-3">
                {hook h='displaySearch'}
             </div>
           </div>
       </div>
       {/if}
       {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')}
        <div class="container header_middle_line">
        {hook h='displayLogoHeader'}
         <div class="header-middle col-md-6 col-lg-7">
              {hook h='displaySearch'}
         </div>
         <div class="header-right col-md-3 col-lg-2">
            {hook h='displayHeaderRight'}
         </div>
       </div>
       <div class="header-menu-line fixed-menu-target">
        <div class="container">
          <div class="row header-menu-wrap anmm-dropdown-container">
            <div class="col-md-6 header-menu-left static-position">
                {hook h='displayTop'}
            </div>
            <div class="col-md-6 header-menu-right">
                {hook h='displayTopRight'}
                {hook h='displayCart'}
            </div>
          </div>
        </div>
       </div>
      {/if}
      {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')}
      <div class="fixed-menu-target">
        <div class="container header_middle_line anmm-dropdown-container">
        {hook h='displayLogoHeader'}

         <div class="header-middle col-md-6 static-position">
              {hook h='displayTop'}
         </div>
         <div class="header-right col-md-3">
            {hook h='displaySearch'}
         </div>
       </div>
     </div>
     {/if}
     {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
        <div class="container header_middle_line">
            {hook h='displayLogoHeader'}
             <div class="header-middle col-md-5 col-xl-6">
                {hook h='displayNav3'}
             </div>
             <div class="header-right col-md-4 col-xl-3">
                {hook h='displayHeaderRight'}
             </div>
           </div>
           <div class="header-menu-line fixed-menu-target">
            <div class="container anmm-dropdown-container">
              <div class="row header-menu-wrap">
                <div class="col-md-6 header-menu-left static-position">
                    {hook h='displayTop'}
                </div>
                <div class="col-md-4 header-menu-middle">
                     {hook h='displaySearch'}
                </div>
                <div class="col-md-2 header-menu-right">
                    {hook h='displayTopRight'}
                    {hook h='displayCart'}
                </div>
              </div>
            </div>
           </div>
    {/if}
    </div>

    <div class="amegamenu_mobile-cover"></div>
         <div class="amegamenu_mobile-modal">
           <div id="mobile_top_menu_wrapper" class="row hidden-lg-up" data-level="0">
             <div class="mobile-menu-header">
               <div class="megamenu_mobile-btn-back">
                 <svg
                 xmlns="http://www.w3.org/2000/svg"
                 xmlns:xlink="http://www.w3.org/1999/xlink"
                 width="26px" height="12px">
                 <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                 d="M25.969,6.346 C25.969,5.996 25.678,5.713 25.319,5.713 L3.179,5.713 L7.071,1.921 C7.324,1.673 7.324,1.277 7.071,1.029 C6.817,0.782 6.410,0.782 6.156,1.029 L1.159,5.898 C0.905,6.145 0.905,6.542 1.159,6.789 L6.156,11.658 C6.283,11.782 6.447,11.844 6.616,11.844 C6.785,11.844 6.949,11.782 7.076,11.658 C7.330,11.411 7.330,11.014 7.076,10.767 L3.184,6.975 L25.329,6.975 C25.678,6.975 25.969,6.697 25.969,6.346 Z"/>
                 </svg>
               </div>
               <div class="megamenu_mobile-btn-close">
                 <svg
                 xmlns="http://www.w3.org/2000/svg"
                 xmlns:xlink="http://www.w3.org/1999/xlink"
                 width="16px" height="16px">
                 <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                 d="M16.002,0.726 L15.274,-0.002 L8.000,7.273 L0.725,-0.002 L-0.002,0.726 L7.273,8.000 L-0.002,15.274 L0.725,16.002 L8.000,8.727 L15.274,16.002 L16.002,15.274 L8.727,8.000 L16.002,0.726 Z"/>
                 </svg>
               </div>
             </div>
             <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
               <div class="js-top-menu-bottom">
                 <div class="mobile-menu-fixed">
                  <div class="anmm-list-mobile {if Module::isEnabled('an_theme') and  !Module::getInstanceByName('an_theme')->getParam('topmenu_mobileLinks')}anmm-list-mobile-nolink{/if} "></div>
                   {hook h='displayMobileMenu'}
                    <div id="_mobile_contactslink">
                        <a href="{$urls.pages.contact}">{l s='Contact us' d='Shop.Theme.Global'}</a>
                    </div>
                   <div class="mobile-lang-and-cur">
                     <div id="_mobile_currency_selector"></div>
                     <div id="_mobile_language_selector"></div>
                   </div>
                 </div>
               </div>
             </div>
           </div>
         </div>
{hook h='displayNavFullWidth'}
{/block}
{if $page.page_name == 'index'} 
{hook h='displaySliderFullWidth'}
{/if}
