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




{foreach from=$widget item=slider}
<div class="an_homeslider-block {if $slider.responsive_image}an_homeslider-responsive{/if} {if $slider.show_on == '1'}an_homeslider-hide-mobile{/if} {if $slider.show_on == '2'}an_homeslider-hide-desktop{/if} {if $slider.show_content_on == '1'}an_homeslider-hide-mobile-content{/if} {if $slider.show_content_on == '2'}an_homeslider-hide-desktop-content{/if}">
	<div class="an_homeslider {if $slider.responsive_image}an_homeslider-responsive{/if}" id="an_homeslider_{$slider.id_slider}" data-lazy="{$slider.lazy_load}" data-nav="{$slider.nav}" data-dots="{$slider.dots}" data-loop="{$slider.loop}" data-autoplay="{$slider.autoplay}" data-autoplaytimeout="{$slider.autoplay_timeout}" data-smartspeed="{$slider.smartspeed}">
	{foreach from=$slider.slides item=slide}
	    {if $slide.link != ''}
	        <a href="{$slide.link}" class="an_homeslider-item {if $slide.image == ''}an_homeslider-item-noimg{/if}">
        {else}
            <div class="an_homeslider-item {if $slide.image == ''}an_homeslider-item-noimg{/if}">
        {/if}
            	{if $slide.image != ''}
            	<img
                    {if $slider.lazy_load}
                    class="owl-lazy" data-src="{$slide.image}"
                    {else}
                    src="{$slide.image}"
                    {/if}
                    width="{$slide.width|intval}" height="{$slide.height|intval}" alt="{$slide.title|escape:'htmlall':'UTF-8'} image"
                >
            	{/if}
            	{if ($slide.title != '') or ($slide.text != '') or $slide.show_button}
            	<div class="an_homeslider-desc">
            		<div class="container">
            		    {if $slide.title}
            			<div class="h2">{$slide.title|escape:'htmlall':'UTF-8'}</div>
            			{/if}
            			{$slide.text nofilter}
            			{if ($slide.show_button == 1) and ($slide.text_of_button != '')}
            			<button class="btn btn-primary">{$slide.text_of_button}</button>
            			{/if}
            		</div>
            	</div>
            	{/if}
        {if $slide.link != ''}
            </a>
        {else}
            </div>
        {/if}
    {/foreach}
	</div>
    {if $slider.preloader}
    <div class="an_homeslider-loader">
        <div class="an_homeslider-loader-image"></div>
    </div>
    <style>
        {if $slider.preloader_height_1920}
            .an_homeslider-block:not(.initialized),
            .an_homeslider-loader {
                height: {$slider.preloader_height_1920}px;
            }
        {/if}
        {if $slider.preloader_height_1600}
            @media (max-width: 1600px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_height_1600}px;
                }
            }
        {/if}
        {if $slider.preloader_height_1366}
            @media (max-width: 1366px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_height_1366}px;
                }
            }
        {/if}
        {if $slider.preloader_height_991}
            @media (max-width: 991px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_height_991}px;
                }
            }
        {/if}
        {if $slider.preloader_height_767}
            @media (max-width: 767px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_height_767}px;
                }
            }
        {/if}
        {if $slider.preloader_mobile_height_580}
            @media (max-width: 580px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_mobile_height_580}px;
                }
            }
        {/if}
        {if $slider.preloader_mobile_height_440}
            @media (max-width: 440px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_mobile_height_440}px;
                }
            }
        {/if}
        {if $slider.preloader_mobile_height_320}
            @media (max-width: 320px) {
                .an_homeslider-block:not(.initialized),
                .an_homeslider-loader {
                    height: {$slider.preloader_mobile_height_320}px;
                }
            }
        {/if}
    </style>
    {/if}
</div>

{/foreach}