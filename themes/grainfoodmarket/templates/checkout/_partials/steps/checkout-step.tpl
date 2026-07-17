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
{block name='step'}
  <section  id    = "{$identifier}"
            class = "{[
                        'checkout-step'   => true,
                        '-current'        => $step_is_current,
                        '-reachable'      => $step_is_reachable,
                        '-complete'       => $step_is_complete,
                        'js-current-step' => $step_is_current
                    ]|classnames}"
  >
    <h1 class="step-title h3">

      <span class="step-number">{$position}.</span>
      {$title}
        <div class="mobile-step-status">

            <span class="step-edit">
             <svg
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              width="17px" height="17px">
             <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
              d="M10.566,2.840 L14.023,6.319 L5.273,15.125 L1.819,11.646 L10.566,2.840 ZM16.646,2.001 L15.104,0.449 C14.509,-0.150 13.541,-0.150 12.944,0.449 L11.467,1.935 L14.923,5.414 L16.646,3.681 C17.108,3.216 17.108,2.466 16.646,2.001 ZM0.010,16.536 C-0.053,16.821 0.202,17.076 0.485,17.007 L4.337,16.067 L0.883,12.588 L0.010,16.536 Z"/>
             </svg>
             {l s='Edit' d='Shop.Theme.Actions'}
             </span>
             <i class="material-icons rtl-no-flip done">&#xE876;</i>
        </div>
        <i class="desktop-step-status material-icons rtl-no-flip done">&#xE876;</i>
      <span class="desktop-step-status step-edit">
       <svg
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        width="17px" height="17px">
       <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
        d="M10.566,2.840 L14.023,6.319 L5.273,15.125 L1.819,11.646 L10.566,2.840 ZM16.646,2.001 L15.104,0.449 C14.509,-0.150 13.541,-0.150 12.944,0.449 L11.467,1.935 L14.923,5.414 L16.646,3.681 C17.108,3.216 17.108,2.466 16.646,2.001 ZM0.010,16.536 C-0.053,16.821 0.202,17.076 0.485,17.007 L4.337,16.067 L0.883,12.588 L0.010,16.536 Z"/>
       </svg>
       {l s='Edit' d='Shop.Theme.Actions'}
       </span>

    </h1>

    <div class="content">
      {block name='step_content'}DUMMY STEP CONTENT{/block}
    </div>
  </section>
{/block}
