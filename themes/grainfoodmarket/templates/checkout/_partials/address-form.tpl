{extends file='customer/_partials/address-form.tpl'}

{block name='form_field'}
  {if $field.name eq "alias"}
    {* we don't ask for alias here *}
  {else}
    {$smarty.block.parent}
  {/if}
{/block}

{block name="address_form_url"}
    <form
      method="POST"
      action="{url entity='order' params=['id_address' => $id_address]}"
      data-id-address="{$id_address}"
      data-refresh-url="{url entity='order' params=['ajax' => 1, 'action' => 'addressForm']}"
    >
{/block}

{block name='form_fields' append}
  <input type="hidden" name="saveAddress" value="{$type}">
  {if $type === "delivery"}
    <div class="addresses-checkout form-group row">
        <label class="col-md-3 form-control-label{if $field.required} required{/if}">

        </label>
        <div class="col-md-6">
           <span class="custom-checkbox">
              <label>
                  <input name="use_same_address" type="checkbox" value="1"  {if $use_same_address} checked {/if}>
                  <span><i class="material-icons rtl-no-flip checkbox-checked">
                     <svg
                         xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink"
                         width="14px" height="10px">
                        <path fill-rule="evenodd"  fill="rgb(57, 181, 208)"
                         d="M12.149,-0.000 L14.000,1.761 L5.339,10.000 L0.000,4.921 L1.851,3.160 L5.339,6.478 L12.149,-0.000 Z"/>
                        </svg>
                  </i></span>
                  <p class="custom-checkbox-label">{l s='Use this address for invoice too' d='Shop.Theme.Checkout'}</p>
              </label>
            </span>
        </div>
    </div>
  {/if}
{/block}

{block name='form_buttons'}
  {if !$form_has_continue_button}
    <button type="submit" class="btn btn-primary float-xs-right">{l s='Save' d='Shop.Theme.Actions'}</button>
    <a class="js-cancel-address cancel-address float-xs-right" href="{url entity='order' params=['cancelAddress' => {$type}]}">{l s='Cancel' d='Shop.Theme.Actions'}</a>
  {else}
    <form>
      <button type="submit" class="continue btn btn-primary float-xs-right" name="confirm-addresses" value="1">
          {l s='Continue' d='Shop.Theme.Actions'}
      </button>
      {if $customer.addresses|count > 0}
        <a class="js-cancel-address cancel-address float-xs-right" href="{url entity='order' params=['cancelAddress' => {$type}]}">{l s='Cancel' d='Shop.Theme.Actions'}</a>
      {/if}
    </form>
  {/if}
{/block}
