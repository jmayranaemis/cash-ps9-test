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

<div class="product-variants">
  {foreach from=$groups key=id_attribute_group item=group}
    {if !empty($group.attributes)}
    <div class="clearfix product-variants-item">
      <span class="control-label">{$group.name}: {foreach from=$group.attributes key=id_attribute item=group_attribute}{if $group_attribute.selected}{$group_attribute.name}{/if}{/foreach}</span>
      {if $group.group_type == 'select'}
        <select
          class="form-control form-control-select"
          id="group_{$id_attribute_group}"
          data-product-attribute="{$id_attribute_group}"
          name="group[{$id_attribute_group}]">
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            <option value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
          {/foreach}
        </select>
      {elseif $group.group_type == 'color'}
        <ul id="group_{$id_attribute_group}">
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            <li class="float-xs-left input-container color-margin {if $group_attribute.selected}input-container-checked{/if} {if (isset($smarty.get.view) and $smarty.get.view == 'images') or (!isset($smarty.get.view) and Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('product_productColorType') == 'images' and isset($combinationImages) and $combinationImages)}input-container-color{/if}">
              <input class="input-color" type="radio" data-product-attribute="{$id_attribute_group}" name="group[{$id_attribute_group}]" value="{$id_attribute}"{if $group_attribute.selected} checked="checked"{/if}>
              {if (isset($smarty.get.view) and $smarty.get.view == 'images') or
                (!isset($smarty.get.view) and Module::isEnabled('an_theme') and
                Module::getInstanceByName('an_theme')->getParam('product_productColorType') == 'images') and
                isset($combinationImages) and $combinationImages}

                {$imageAttribute = Module::getInstanceByName('an_theme')->getImageByGroupId($product->id, $id_attribute)}

                {if $imageAttribute.img_url != ''}
                <img
                    src="{$imageAttribute.img_url|escape:'html':'UTF-8'}"
                    alt="{$imageAttribute.legend|escape:'html':'UTF-8'}"
                >
                {else}
                <span class="an_attr-color-fill" style="background-color: {$group_attribute.html_color_code}"></span>
                {/if}
                <div class="an_attr-effect"></div>
            {else}
              <span
                {if $group_attribute.html_color_code}class="color {if $group_attribute.html_color_code == '#ffffff'}color-white{/if}" style="background-color: {$group_attribute.html_color_code}" {/if}
                {if $group_attribute.texture}class="color texture" style="background-image: url({$group_attribute.texture})" {/if}
              ><span class="sr-only">{$group_attribute.name}</span></span>
              {/if}
            </li>
          {/foreach}
        </ul>
      {elseif $group.group_type == 'radio'}
        <ul id="group_{$id_attribute_group}">
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            <li class="input-container float-xs-left">
              <input class="input-radio" type="radio" data-product-attribute="{$id_attribute_group}" name="group[{$id_attribute_group}]" value="{$id_attribute}"{if $group_attribute.selected} checked="checked"{/if}>
              <span class="radio-label">{$group_attribute.name}</span>
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>
    {/if}
  {/foreach}
</div>
