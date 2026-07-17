<ul class="product-flags {if (isset($smarty.get.view) and $smarty.get.view == 'leftcol') or (Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('productslider_minisPos') == 'left')}flags-left{/if}">
  {foreach from=$product.flags item=flag}
    <li class="product-flag {$flag.type}">{$flag.label}</li>
  {/foreach}


  {if $product.has_discount}
    {if $product.discount_type === 'percentage'}
      <li class="discount discount-percentage">{l s='Save %percentage%' d='Shop.Theme.Catalog' sprintf=['%percentage%' => $product.discount_percentage_absolute]}</li>
    {else}
      <li class="discount discount-amount">
          {l s='Save %amount%' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.discount_to_display]}
      </li>
    {/if}
  {/if}
</ul>