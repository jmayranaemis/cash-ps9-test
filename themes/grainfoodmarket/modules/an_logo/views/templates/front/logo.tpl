<div class="
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
    col-md-4
    {/if}
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
    or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
    or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')
    or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
    col-md-3
    {/if}
    hidden-sm-down" id="_desktop_logo">
	<a href="{$urls.pages.index|escape:'html':'UTF-8'}">
		{if $an_logo_view_type == 'svg' && $an_logo_img}
			<img class="logo img-responsive" src="{$an_logo_img|escape:'html':'UTF-8'}"
			{if $an_logo_width > 0} width="{$an_logo_width|intval}" {/if}
            {if $an_logo_height > 0} height="{$an_logo_height|intval}" {/if} alt="{$shop.name|escape:'html':'UTF-8'}">
		{elseif $an_logo_view_type == 'svg_text' && $svg_textarea}
			{$svg_textarea nofilter}
		{else}
			<img class="logo img-responsive" src="{$shop.logo|escape:'html':'UTF-8'}"
			{if $an_logo_width > 0} width="{$an_logo_width|intval}" {/if}
            {if $an_logo_height > 0} height="{$an_logo_height|intval}" {/if} alt="{$shop.name|escape:'html':'UTF-8'}">
		{/if}
	</a>
</div>