<div class="
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header1')}
    col-md-3
    {/if}
    {if (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header2')
    or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header3')
    or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header4')
    or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('header_typeHeader') == 'header5')}
    col-md-3
    {/if}
    hidden-sm-down" id="_desktop_logo">
	<a href="{$urls.pages.index|escape:'html':'UTF-8'}">
		<img class="logo img-responsive"
			src="{$shop.logo|escape:'html':'UTF-8'}"
			style="mix-blend-mode:multiply"
			alt="{$shop.name|escape:'html':'UTF-8'}">
	</a>
</div>
