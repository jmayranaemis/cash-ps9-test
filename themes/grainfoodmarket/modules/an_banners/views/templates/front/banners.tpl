{*
* 2022 Anvanto
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
*
*  @author    Anvanto <anvantoco@gmail.com>
*  @copyright 2022 Anvanto
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

{if count($banners) > 0}
<div class="row{if isset($class)} {$class|escape:'htmlall':'UTF-8'}{/if}">
{foreach from=$banners item=banner}
    {include file=$banner.tplFilePath}
{/foreach}
</div>
{/if}

