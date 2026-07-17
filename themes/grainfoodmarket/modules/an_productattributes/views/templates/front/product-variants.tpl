{**
* 2021 Anvanto
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses. 
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
*  @author Anvanto <anvantoco@gmail.com>
*  @copyright  2021 Anvanto
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of Anvanto
*}

{if isset($groups)}
<div class="an_pa_product-variants">
  {foreach from=$groups key=id_attribute_group item=group}
	{if !empty($group.attributes)}
	<div class="clearfix product-variants-item {if $group.group_type == 'color'}product-variants-item-color{/if} {if $group.group_type == 'radio'}product-variants-item-radio{/if}">
	  {if $config.display_labels=='1'}
	  <span class="control-label">{$group.name|escape:'htmlall':'UTF-8'}</span>
	  {/if}
	  {if $group.group_type == 'select'}
		<select
		  class="form-control form-control-select"
		  aria-label="{$group.name|escape:'htmlall':'UTF-8'}"
		  data-product-attribute="{$id_attribute_group|intval}"
		  name="group[{$id_attribute_group|intval}]">
		  {foreach from=$group.attributes key=id_attribute item=group_attribute}
			<option value="{$id_attribute|intval}" title="{$group_attribute.name|escape:'htmlall':'UTF-8'}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name|escape:'htmlall':'UTF-8'}</option>
		  {/foreach}
		</select>
	  {elseif $group.group_type == 'color'}
		<ul  class="an_productattributes-group">
		  {foreach from=$group.attributes key=id_attribute item=group_attribute}
			<li class="float-xs-left input-container {if $group_attribute.selected} an-input-container-checked{/if}">
			  <label {if ($config.color_type_view == 'image' OR $config.color_type_view == 'only_image') and isset($combinationImages) and $combinationImages}class="an_attr-color"{/if}>
				<input class="input-color" type="radio" data-product-attribute="{$id_attribute_group|intval}" name="group[{$id_attribute_group|intval}]" value="{$id_attribute|intval}"{if $group_attribute.selected} checked="checked"{/if}>
				{if ($config.color_type_view == 'image' OR $config.color_type_view == 'only_image') and isset($combinationImages) and $combinationImages}
										
					<img
						src="{$group_attribute.img_url|escape:'html':'UTF-8'}"
						alt="{$group_attribute.legend|escape:'html':'UTF-8'}"
						class="{$group_attribute.id_product_attribute|escape:'html':'UTF-8'} {$product_link_rewrite} js-an_productattributes-img an_productattributes-img"
					>
					<span class="an_attr-effect"></span>

				{elseif ($config.color_type_view <> 'only_image')}
				<span
				  {if $group_attribute.html_color_code}class="color" style="background-color: {$group_attribute.html_color_code|escape:'htmlall':'UTF-8'}" {/if}
				  {if $group_attribute.texture}class="color texture" style="background-image: url({$group_attribute.texture|escape:'htmlall':'UTF-8'})" {/if}
				><span class="sr-only">{$group_attribute.name|escape:'htmlall':'UTF-8'}</span></span>
				{/if}
			  </label>
			</li>
		  {/foreach}
		</ul>
	  {elseif $group.group_type == 'radio'}
		<ul  class="an_productattributes-group">
		  {foreach from=$group.attributes key=id_attribute item=group_attribute}
			<li class="input-container float-xs-left">
			  <label>
				<input class="input-radio" type="radio" data-product-attribute="{$id_attribute_group|intval}" name="group[{$id_attribute_group|intval}]" value="{$id_attribute|intval}"{if $group_attribute.selected} checked="checked"{/if}>
				<span class="radio-label">{$group_attribute.name|escape:'htmlall':'UTF-8'}</span>
			  </label>
			</li>
		  {/foreach}
		</ul>
	  {/if}
	</div>
	{/if}
  {/foreach}
</div>
{/if}