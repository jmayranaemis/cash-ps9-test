{*
* 2024 Anvanto
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
*
*  @author    Anvanto <anvantoco@gmail.com>
*  @copyright 2024 Anvanto
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*}

{function name=printList nodes=[] depth=0}
	<ul {if $parent != 1}id="sub_{$parent|escape:'htmlall':'UTF-8'}"{/if} class="category-sub-menu{if $level != 1} collapse{/if}">
		{foreach $items as $item}
			<li id="list_{$item['id_anblogcat']|escape:'htmlall':'UTF-8'}" data-depth="{$depth}">
				<a href="{$urls.base_url|escape:'htmlall':'UTF-8'}module/anblog/category?rewrite={$item['link_rewrite']|escape:'url'}&amp;id={$item['id_anblogcat']|intval}" class="category-sub-link" title="{$item['title']|escape:'htmlall':'UTF-8'}">
					{if ($item['icon_class'])}
						<i class="fa fa-{$item['icon_class']|escape:'htmlall':'UTF-8'}"></i>
					{/if}
					<span>{$item['title']|escape:'htmlall':'UTF-8'}</span>
				</a>
				{if isset($item['children'])}
					<div class="navbar-toggler collapse-icons"
						 data-toggle="collapse" data-target="#sub_{$item['id_anblogcat']|escape:'htmlall':'UTF-8'}">
						<i class="material-icons add">
						    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="9px" height="6px"><path fill-rule="evenodd" fill="rgb(0, 0, 0)" d="M4.566,5.375 L0.551,0.375 L8.580,0.375 L4.566,5.375 Z"></path></svg>
						</i>
						<i class="material-icons remove" style="transform: rotate(180deg)">
						    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="9px" height="6px"><path fill-rule="evenodd" fill="rgb(0, 0, 0)" d="M4.566,5.375 L0.551,0.375 L8.580,0.375 L4.566,5.375 Z"></path></svg>
						</i>
					</div>
					{assign var=level value=$level+1}
					{call name=printList level=$level parent=$item['id_anblogcat'] items=$item['children'] depth=$depth+1}
				{else}
					{assign var=level value=$level-1}
				{/if}
			</li>
		{/foreach}
	</ul>
{/function}

{call name=printList level=1 parent=1 items=$tree}

