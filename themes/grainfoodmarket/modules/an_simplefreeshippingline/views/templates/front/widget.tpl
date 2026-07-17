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

<div class="an-sfsl">
    <p>
        {if isset($an_sfsl_link) && $an_sfsl_link <> ''}
        <a href="{$an_sfsl_link|escape:'htmlall':'UTF-8'}">
        {/if}
        {$an_sfsl_title nofilter}
        {if isset($an_sfsl_link) && $an_sfsl_link <> ''}
        </a>
        {/if}
    </p>
</div>
        