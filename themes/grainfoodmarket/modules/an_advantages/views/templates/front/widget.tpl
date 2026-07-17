{*
* 2022 Anvanto
*
* NOTICE OF LICENSE
*
* This file is not open source! Each license that you purchased is only available for 1 wesite only.
* If you want to use this file on more websites (or projects), you need to purchase additional licenses. 
* You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
*
*  @author Anvanto <anvantoco@gmail.com>
*  @copyright  2022 Anvanto
*  @license    Valid for 1 website (or project) for each purchase of license
*  International Registered Trademark & Property of Anvanto
*}

<div class="an_advantages" {if $widget.settings.bg_image != ''}style="background-image: url({$widget.settings.bg_image|escape:'htmlall':'UTF-8'}); background-size: cover;" {/if}>
    <div class="an_advantages-inner-wrap">
        {if ($widget.settings.title != '') || ($widget.settings.text != '')}
            <div class="an_advantages-head {if !$widget.settings.show_block}an_advantages-head-hidden{/if}">
                {if $widget.settings.title != ''}
                    <div class="an_advantages-title h2">
                        {$widget.settings.title|escape:'htmlall':'UTF-8'}
                    </div>
                {/if}
                {if $widget.settings.text != ''}
                    <div class="an_advantages-text">
                        {$widget.settings.text nofilter}
                    </div>
                {/if}
            </div>
        {/if}
        {if count($widget.advantages) > 0}
        <div class="an_advantages-list">
            {foreach from=$widget.advantages item=item}
                {if $item.link != ''}
                    <a href="{$item.link|escape:'htmlall':'UTF-8'}" class="an_advantages-item">
                {else}
                    <div class="an_advantages-item">
                {/if}
                    {if $item.image != ''}
                        <div class="an_advantages-item-img">
                            <img src="{$item.image|escape:'htmlall':'UTF-8'}" width="{if $item.width != 0}{$item.width|intval}{else}auto{/if}" height="{if $item.height != 0}{$item.height|intval}{else}auto{/if}" alt="{$item.title|escape:'htmlall':'UTF-8'}">
                        </div>
                    {/if}
                    {if ($item.title != '') || ($item.text != '')}
                        <div class="an_advantages-item-desc">
                            {if $item.title != ''}
                                <p class="an_advantages-item-title h4">{$item.title|escape:'htmlall':'UTF-8'}</p>
                            {/if}
                            {if $item.text != ''}
                                {$item.text nofilter}
                            {/if}
                        </div>
                    {/if}
                {if $item.link != ''}
                    </a>
                {else}
                    </div>
                {/if}
            {/foreach}
        </div>
        {/if}
    </div>
</div>