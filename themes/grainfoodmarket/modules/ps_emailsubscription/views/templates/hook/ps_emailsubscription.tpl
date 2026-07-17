{*
  * 2007-2015 PrestaShop
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
  *  @copyright  2007-2015 PrestaShop SA
  *  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
  *  International Registered Trademark & Property of PrestaShop SA
  *}
  <div class="block_newsletter">
    <div class="container">
      <div class="row">
    <div class="col-lg-2">
      <h2 class="h1">{l s='Newsletter' d='Modules.Emailsubscription.Shop'}</h2>
    </div>
    <div class="col-lg-10">
        <form action="{$urls.pages.index}#footer" method="post">

              <div class="input-wrapper">
                <input
                name="email"
                type="text"
                value="{$value}"
                placeholder="{l s='Your e-mail' d='Modules.Emailsubscription.Shop'}"
                >
                <button
                class="pull-xs-right subscribe-btn btn"
                name="submitNewsletter"
                type="submit"
                value="{l s='Subscribe' d='Shop.Theme.Actions'}"
                aria-label="{l s='Subscribe' d='Shop.Theme.Actions'}"
                ><svg
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                  width="21px" height="18px">
                 <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                  d="M0.010,-0.000 L-0.000,7.000 L15.000,9.000 L-0.000,11.000 L0.010,18.000 L21.000,9.000 L0.010,-0.000 Z"/>
                 </svg></button>
              </div>
              <input type="hidden" name="action" value="0">
              <div class="clearfix"></div>
            <div class="col-xs-12">
              {if $msg}
              <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
                {$msg}
              </p>
              {/if}
              {if isset($id_module)}
                   <div class="gdpr-newsletter row">
                  {hook h='displayGDPRConsent' id_module=$id_module}
                   </div>
                {/if}
            </div>

        </form>
      </div>
    </div>
  </div>
    </div>
