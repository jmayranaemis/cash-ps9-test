{*
 * Classic theme doesn't use this subtemplate, feel free to do whatever you need here.
 * This template is generated at each ajax calls.
 * See ProductListingFrontController::getAjaxProductSearchVariables()
 *}
<div id="js-product-list-bottom">
    {if isset($category) && isset($category.additional_description) && $category.additional_description && $listing.pagination.items_shown_from == 1}
        <div class="card">
            <div class="card-block category-additional-description">
                {$category.additional_description nofilter}
            </div>
        </div>
    {/if}
</div>
