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
{block name='address_selector_blocks'}
  {foreach $addresses as $address}
    <article
      class="address-item{if $address.id == $selected} selected{/if}"
      id="{$name|classname}-address-{$address.id}"
    >
      <header class="h4">
        <label class="radio-block">
          <span class="custom-radio">
            <input
              type="radio"
              name="{$name}"
              value="{$address.id}"
              {if $address.id == $selected}checked{/if}
            >
            <span></span>
          </span>
          <span class="address-alias h4">{$address.alias}</span>
          <div class="address">{$address.formatted nofilter}</div>
        </label>
      </header>
      <footer class="address-footer">
        {if $interactive}
          <a
            style="color: #000!important"
            class="edit-address"
            data-link-action="edit-address"
            href="{url entity='order' params=['id_address' => $address.id, 'editAddress' => $type, 'token' => $token]}"
          >
            <svg
             xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             width="17px" height="17px">
            <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
             d="M10.566,2.840 L14.023,6.319 L5.273,15.125 L1.819,11.646 L10.566,2.840 ZM16.646,2.001 L15.104,0.449 C14.509,-0.150 13.541,-0.150 12.944,0.449 L11.467,1.935 L14.923,5.414 L16.646,3.681 C17.108,3.216 17.108,2.466 16.646,2.001 ZM0.010,16.536 C-0.053,16.821 0.202,17.076 0.485,17.007 L4.337,16.067 L0.883,12.588 L0.010,16.536 Z"/>
            </svg>
            <span>{l s='Edit' d='Shop.Theme.Actions'}<span>
          </a>
          <a
            class="delete-address"
            data-link-action="delete-address"
            href="{url entity='order' params=['id_address' => $address.id, 'deleteAddress' => true, 'token' => $token]}"
          >
            <svg
             xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             width="15px" height="17px">
            <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
             d="M15.000,3.884 L13.665,3.884 L12.623,16.392 C12.595,16.736 12.322,17.000 11.996,17.000 L2.983,17.000 C2.656,17.000 2.384,16.736 2.355,16.393 L1.313,3.884 L-0.000,3.884 L-0.000,2.552 L4.391,2.552 L4.391,1.110 C4.391,0.498 4.862,-0.000 5.441,-0.000 L9.559,-0.000 C10.138,-0.000 10.609,0.498 10.609,1.110 L10.609,2.552 L15.000,2.552 L15.000,3.884 ZM9.349,1.332 L5.651,1.332 L5.651,2.552 L9.349,2.552 L9.349,1.332 ZM2.579,3.884 L3.560,15.668 L11.418,15.668 L12.400,3.884 L2.579,3.884 ZM9.034,13.691 L9.307,5.812 L10.567,5.861 L10.294,13.740 L9.034,13.691 ZM6.870,5.837 L8.130,5.837 L8.130,13.715 L6.870,13.715 L6.870,5.837 ZM4.433,5.861 L5.693,5.812 L5.966,13.691 L4.706,13.740 L4.433,5.861 Z"/>
            </svg>{l s='Delete' d='Shop.Theme.Actions'}
          </a>
        {/if}
      </footer>
    </article>
  {/foreach}
  {if $interactive}
    <p>
      <button class="ps-hidden-by-js form-control-submit center-block" type="submit">{l s='Save' d='Shop.Theme.Actions'}</button>
    </p>
  {/if}
{/block}
