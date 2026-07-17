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
{if $field.type == 'hidden'}

  {block name='form_field_item_hidden'}
    <input type="hidden" name="{$field.name}" value="{$field.value}">
  {/block}

{else}

  <div class="form-group row {if ($field.type === 'radio-buttons')} form-group-radio {/if} {if !empty($field.errors)}has-error{/if} {if isset($field.availableValues.comment)}form-group-with-comment{/if}">
    <label class="col-md-3 form-control-label{if $field.required} required{/if}">
      {if $field.type !== 'checkbox'}
        {$field.label}
      {/if}
    </label>
    <div class="col-md-6{if ($field.type === 'radio-buttons')} form-control-valign{/if}">

      {if $field.type === 'select'}

        {block name='form_field_item_select'}
          <select class="form-control form-control-select" name="{$field.name}" {if $field.required}required{/if}>
            <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
            {foreach from=$field.availableValues item="label" key="value"}
              <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
            {/foreach}
          </select>
        {/block}

      {elseif $field.type === 'countrySelect'}

        {block name='form_field_item_country'}
          <select
          class="form-control form-control-select js-country"
          name="{$field.name}"
          {if $field.required}required{/if}
          >
            <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
            {foreach from=$field.availableValues item="label" key="value"}
              <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
            {/foreach}
          </select>
        {/block}

      {elseif $field.type === 'radio-buttons'}

        {block name='form_field_item_radio'}
          {foreach from=$field.availableValues item="label" key="value"}
            <label class="radio-inline">
              <span class="custom-radio">
                <input
                  name="{$field.name}"
                  type="radio"
                  value="{$value}"
                  {if $field.required}required{/if}
                  {if $value eq $field.value} checked {/if}
                >
                <span></span>
              </span>
              {$label}
            </label>
          {/foreach}
        {/block}

      {elseif $field.type === 'checkbox'}

        {block name='form_field_item_checkbox'}
          <span class="custom-checkbox">
            <label>
                <input name="{$field.name}" type="checkbox" value="1" {if $field.value}checked="checked"{/if} {if $field.required}required{/if}>
                <span><i class="material-icons rtl-no-flip checkbox-checked">
                    <svg
                     xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink"
                     width="14px" height="10px">
                    <path fill-rule="evenodd"  fill="rgb(57, 181, 208)"
                     d="M12.149,-0.000 L14.000,1.761 L5.339,10.000 L0.000,4.921 L1.851,3.160 L5.339,6.478 L12.149,-0.000 Z"/>
                    </svg>
                </i></span>
                <p class="custom-checkbox-label">{$field.label nofilter}</p>
            </label>
          </span>
        {/block}

      {elseif $field.type === 'date'}

        {block name='form_field_item_date'}
          <input name="{$field.name}" class="form-control {if isset($field.availableValues.comment)}form-control-padding{/if}" type="date" value="{$field.value}" placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}">
          {if isset($field.availableValues.comment)}
            <span class="form-control-comment">
              {$field.availableValues.comment}
            </span>
          {/if}
        {/block}

      {elseif $field.type === 'birthday'}

        {block name='form_field_item_birthday'}
          <div class="js-parent-focus">
            {html_select_date
            field_order=DMY
            time={$field.value}
            field_array={$field.name}
            prefix=false
            reverse_years=true
            field_separator='<br>'
            day_extra='class="form-control form-control-select"'
            month_extra='class="form-control form-control-select"'
            year_extra='class="form-control form-control-select"'
            day_empty={l s='-- day --' d='Shop.Forms.Labels'}
            month_empty={l s='-- month --' d='Shop.Forms.Labels'}
            year_empty={l s='-- year --' d='Shop.Forms.Labels'}
            start_year={'Y'|date}-100 end_year={'Y'|date}
            }
          </div>
        {/block}

      {elseif $field.type === 'password'}

        {block name='form_field_item_password'}
          <div class="input-group js-parent-focus">
            <input
              class="form-control js-child-focus js-visible-password {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox']))}form-control-padding{/if}"
              name="{$field.name}"
              type="password"
              value=""
              pattern=".{literal}{{/literal}5,{literal}}{/literal}"
              {if $field.required}required{/if}
              placeholder="{l s='Password' d='Shop.Forms.Labels'}"
            >
            <span class="input-group-btn">
              <button
                class="btn"
                type="button"
                data-action="show-password"
                data-text-show=""
                data-text-hide=""
              >

              </button>

                <svg
                   xmlns="http://www.w3.org/2000/svg"
                   xmlns:xlink="http://www.w3.org/1999/xlink"
                   width="23px" height="13px">
                  <path fill-rule="evenodd"  fill="rgb(125, 125, 125)"
                   d="M11.090,0.000 C6.888,0.000 3.077,2.280 0.266,5.982 C0.036,6.286 0.036,6.710 0.266,7.013 C3.077,10.720 6.888,13.000 11.090,13.000 C15.292,13.000 19.102,10.720 21.914,7.017 C22.144,6.714 22.144,6.290 21.914,5.987 C19.102,2.280 15.292,0.000 11.090,0.000 ZM11.391,11.077 C8.602,11.251 6.299,8.972 6.474,6.201 C6.618,3.917 8.485,2.066 10.789,1.923 C13.578,1.749 15.881,4.028 15.706,6.799 C15.557,9.079 13.690,10.930 11.391,11.077 ZM11.252,8.963 C9.749,9.056 8.508,7.829 8.606,6.339 C8.683,5.108 9.691,4.113 10.932,4.033 C12.435,3.939 13.677,5.166 13.578,6.656 C13.497,7.892 12.489,8.887 11.252,8.963 Z"/>
                  </svg>
                    {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox']))}
                      <span class="form-control-comment">
                        {block name='form_field_comment'}
                           {l s='optional' d='Shop.Forms.Labels'}
                        {/block}
                      </span>
                   {/if}
            </span>
          </div>
        {/block}

      {else}

        {block name='form_field_item_other'}
          <input
            class="form-control {if (!$field.required && $field.type != 'password' && !in_array($field.type, ['radio-buttons', 'checkbox']))}form-control-padding{/if}"
            name="{$field.name}"
            type="{$field.type}"
            value="{$field.value}"
            {if $field.type == 'email'}
            placeholder="{l s='Email' d='Shop.Forms.Labels'}"
            {else}
            placeholder=" "
            {/if}
            {if isset($field.availableValues.placeholder)}placeholder="{$field.availableValues.placeholder}"{/if}
            {if $field.maxLength}maxlength="{$field.maxLength}"{/if}
            {if $field.required}required{/if}
          >
          {if isset($field.availableValues.comment)}
            <div class="form-control-static-comment">
              {$field.availableValues.comment}
            </div>
          {/if}
        {/block}

      {/if}
         {if (!$field.required && $field.type != 'password' && !in_array($field.type, ['radio-buttons', 'checkbox']))}
            <span class="form-control-comment">
              {block name='form_field_comment'}
                 {l s='optional' d='Shop.Forms.Labels'}
              {/block}
            </span>
         {/if}
      {block name='form_field_errors'}
        {include file='_partials/form-errors.tpl' errors=$field.errors}
      {/block}

    </div>

  </div>

{/if}
