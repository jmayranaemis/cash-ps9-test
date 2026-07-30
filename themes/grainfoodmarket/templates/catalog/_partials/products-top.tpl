{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{assign isLeftCol 0}
{assign var='showCollectionView' value=false}
{foreach from=$page.body_classes key=k item=v}
	{if $k == 'layout-left-column'}
	    {assign isLeftCol 1}
	{/if}
{/foreach}


<div id="js-product-list-top" class="products-selection">
  <div class="row products-selection-inner">
  {if isset($smarty.get.view) && (($smarty.get.view == 'leftColDefault') || ($smarty.get.view == 'leftColLeft') || ($smarty.get.view == 'leftColRight'))}
    {if $smarty.get.view == 'leftColDefault'}
          <div class="col-md-4 hidden-sm-down total-products">
            {if $listing.pagination.total_items > 1}
              <p>{l s='There are %product_count% products.' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</p>
            {else if $listing.pagination.total_items > 0}
              <p>{l s='There is 1 product.' d='Shop.Theme.Catalog'}</p>
            {/if}
          </div>
          <div class="col-md-8 sort-block">
            <div class="sort-by-row row">

              {block name='sort_by'}
                {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
              {/block}

              {if $isLeftCol && (!empty($listing.rendered_facets) || Module::isEnabled('ps_categorytree'))}
                <div class="hidden-md-up filter-button">
                  <button id="search_filter_toggler" class="btn btn-secondary">
                      <svg
                      xmlns="http://www.w3.org/2000/svg"
                      xmlns:xlink="http://www.w3.org/1999/xlink"
                      width="16px" height="4px">
                     <image  x="0px" y="0px" width="16px" height="4px"  xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAECAMAAACwak/eAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAASFBMVEUAAAAmIyQmIyQmIyQmJCQmJCQmIyQmIyQmJCQmJCUmJCQmIyQmJCUmIyQmIyQlIyQlIyQmJCQmIyQmJCUmIyQmJCQmJCX///8Qy8P+AAAAFHRSTlMAX/PXIT7oIV/vksHBku+S7/M+6A9vNoEAAAABYktHRBcL1piPAAAAB3RJTUUH4wofECIkmVmdZQAAAD1JREFUCNcly1sOgCAMRcFTKqCg+Lp2/0s1xt9JBks+QS4lQ/U0s0gN+hMrbBGDIe0fqENTHNjpFa5y/8VeQ58CGrPKWTsAAAAASUVORK5CYII=" />
                     </svg>
                    {l s='Filter' d='Shop.Theme.Actions'}
                  </button>
                </div>
              {/if}
            </div>
          </div>

          {if $showCollectionView}
          <div class="col-md-6 collection-view">
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'col2'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 6}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-6'}
              active
            {/if}{/if}" data-xl="6">
              <div class="view-type view-type-3">

              </div>
            </div>
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'col3'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 4}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-4'}
              active
            {/if}{/if}" data-xl="4">
                <div class="view-type view-type-2"></div>
            </div>
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'col4'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 3}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-3'}
              active
            {/if}{/if}" data-xl="3">
                <div class="view-type view-type-1"></div>
            </div>
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'row'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 12}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-12'}
              active
            {/if}{/if}" data-xl="12">
                <div class="view-type view-type-4"></div>
            </div>
          </div>
          {/if}
          <div class="col-sm-6 showing text-xs-right">
            <div class="showing-text">
            {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=[
            '%from%' => $listing.pagination.items_shown_from ,
            '%to%' => $listing.pagination.items_shown_to,
            '%total%' => $listing.pagination.total_items
            ]}
            </div>
          </div>
    {/if}
  {elseif Module::isEnabled('an_theme') AND Module::getInstanceByName('an_theme')->getParam('categoryPage_leftCol') == 'leftColDefault'}
          <div class="col-md-4 hidden-sm-down total-products">
            {if $listing.pagination.total_items > 1}
              <p>{l s='There are %product_count% products.' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</p>
            {else if $listing.pagination.total_items > 0}
              <p>{l s='There is 1 product.' d='Shop.Theme.Catalog'}</p>
            {/if}
          </div>
          <div class="col-md-8 sort-block">
            <div class="sort-by-row row">

              {block name='sort_by'}
                {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
              {/block}

              {if $isLeftCol && (!empty($listing.rendered_facets) || Module::isEnabled('ps_categorytree'))}
                <div class="hidden-md-up filter-button">
                  <button id="search_filter_toggler" class="btn btn-secondary">
                      <svg
                      xmlns="http://www.w3.org/2000/svg"
                      xmlns:xlink="http://www.w3.org/1999/xlink"
                      width="16px" height="4px">
                     <image  x="0px" y="0px" width="16px" height="4px"  xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAECAMAAACwak/eAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAASFBMVEUAAAAmIyQmIyQmIyQmJCQmJCQmIyQmIyQmJCQmJCUmJCQmIyQmJCUmIyQmIyQlIyQlIyQmJCQmIyQmJCUmIyQmJCQmJCX///8Qy8P+AAAAFHRSTlMAX/PXIT7oIV/vksHBku+S7/M+6A9vNoEAAAABYktHRBcL1piPAAAAB3RJTUUH4wofECIkmVmdZQAAAD1JREFUCNcly1sOgCAMRcFTKqCg+Lp2/0s1xt9JBks+QS4lQ/U0s0gN+hMrbBGDIe0fqENTHNjpFa5y/8VeQ58CGrPKWTsAAAAASUVORK5CYII=" />
                     </svg>
                    {l s='Filter' d='Shop.Theme.Actions'}
                  </button>
                </div>
              {/if}
            </div>
          </div>

          {if $showCollectionView}
          <div class="col-md-6 collection-view">
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'col2'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 6}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-6'}
              active
            {/if}{/if}" data-xl="6">
              <div class="view-type view-type-3">

              </div>
            </div>
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'col3'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 4}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-4'}
              active
            {/if}{/if}" data-xl="4">
                <div class="view-type view-type-2"></div>
            </div>
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'col4'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 3}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-3'}
              active
            {/if}{/if}" data-xl="3">
                <div class="view-type view-type-1"></div>
            </div>
            <div class="collection-view-btn
            {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
              {if $smarty.get.view == 'row'}
                active no-cookie
              {/if}
            {else}
            {if isset($smarty.cookies.an_collection_view)}
              {if $smarty.cookies.an_collection_view == 12}
                active
              {/if}
            {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-12'}
              active
            {/if}{/if}" data-xl="12">
                <div class="view-type view-type-4"></div>
            </div>
          </div>
          {/if}
          <div class="col-sm-6 showing text-xs-right">
            <div class="showing-text">
            {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=[
            '%from%' => $listing.pagination.items_shown_from ,
            '%to%' => $listing.pagination.items_shown_to,
            '%total%' => $listing.pagination.total_items
            ]}
            </div>
          </div>
  {/if}


  {if isset($smarty.get.view) && (($smarty.get.view == 'leftColDefault') || ($smarty.get.view == 'leftColLeft') || ($smarty.get.view == 'leftColRight'))}
    {if ($smarty.get.view == 'leftColLeft') || ($smarty.get.view == 'leftColRight')}
           <div class="product-list-top-wrap">
                <div class="col-md-4 collection-view">
                     {if $isLeftCol && (!empty($listing.rendered_facets) || Module::isEnabled('ps_categorytree'))}
                        <div class="filter-button">
                          <button id="search_filter_toggler" class="btn btn-secondary">
                              <svg
                               xmlns="http://www.w3.org/2000/svg"
                               xmlns:xlink="http://www.w3.org/1999/xlink"
                               width="18px" height="13px">
                              <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                               d="M17.100,11.143 C17.597,11.143 18.000,11.559 18.000,12.071 C18.000,12.584 17.597,13.000 17.100,13.000 L0.900,13.000 C0.403,13.000 -0.000,12.584 -0.000,12.071 C-0.000,11.559 0.403,11.143 0.900,11.143 L17.100,11.143 ZM17.100,5.571 C17.597,5.571 18.000,5.987 18.000,6.500 C18.000,7.013 17.597,7.429 17.100,7.429 L0.900,7.429 C0.403,7.429 -0.000,7.013 -0.000,6.500 C-0.000,5.987 0.403,5.571 0.900,5.571 L17.100,5.571 ZM17.100,-0.000 C17.597,-0.000 18.000,0.416 18.000,0.929 C18.000,1.441 17.597,1.857 17.100,1.857 L0.900,1.857 C0.403,1.857 -0.000,1.441 -0.000,0.929 C-0.000,0.416 0.403,-0.000 0.900,-0.000 L17.100,-0.000 Z"/>
                              </svg>
                            {l s='Filter' d='Shop.Theme.Actions'}
                          </button>
                        </div>
                      {/if}
                    {if $showCollectionView}
                    <div class="collection-view-wrap">
                        <div class="collection-view-btn
                        {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                          {if $smarty.get.view == 'col2'}
                            active no-cookie
                          {/if}
                        {else}
                        {if isset($smarty.cookies.an_collection_view)}
                          {if $smarty.cookies.an_collection_view == 6}
                            active
                          {/if}
                        {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-6'}
                          active
                        {/if}{/if}" data-xl="6">
                          <div class="view-type view-type-3">

                          </div>
                        </div>
                        <div class="collection-view-btn
                        {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                          {if $smarty.get.view == 'col3'}
                            active no-cookie
                          {/if}
                        {else}
                        {if isset($smarty.cookies.an_collection_view)}
                          {if $smarty.cookies.an_collection_view == 4}
                            active
                          {/if}
                        {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-4'}
                          active
                        {/if}{/if}" data-xl="4">
                            <div class="view-type view-type-2"></div>
                        </div>
                        <div class="collection-view-btn
                        {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                          {if $smarty.get.view == 'col4'}
                            active no-cookie
                          {/if}
                        {else}
                        {if isset($smarty.cookies.an_collection_view)}
                          {if $smarty.cookies.an_collection_view == 3}
                            active
                          {/if}
                        {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-3'}
                          active
                        {/if}{/if}" data-xl="3">
                            <div class="view-type view-type-1"></div>
                        </div>
                        <div class="collection-view-btn
                        {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                          {if $smarty.get.view == 'row'}
                            active no-cookie
                          {/if}
                        {else}
                        {if isset($smarty.cookies.an_collection_view)}
                          {if $smarty.cookies.an_collection_view == 12}
                            active
                          {/if}
                        {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-12'}
                          active
                        {/if}{/if}" data-xl="12">
                            <div class="view-type view-type-4"></div>
                        </div>
                    </div>
                    {/if}
                  </div>

                  <div class="col-md-4 hidden-sm-down total-products">
                    {if $listing.pagination.total_items > 1}
                      <p>{l s='There are %product_count% products.' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</p>
                    {else if $listing.pagination.total_items > 0}
                      <p>{l s='There is 1 product.' d='Shop.Theme.Catalog'}</p>
                    {/if}
                  </div>
                  <div class="col-md-4 sort-block">
                    <div class="sort-by-row row">

                      {block name='sort_by'}
                        {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
                      {/block}


                    </div>
                  </div>
              </div>
    {/if}
  {elseif Module::isEnabled('an_theme') AND Module::getInstanceByName('an_theme')->getParam('categoryPage_leftCol') != 'leftColDefault'}
    <div class="product-list-top-wrap">
        <div class="col-md-4 collection-view">
             {if $isLeftCol && (!empty($listing.rendered_facets) || Module::isEnabled('ps_categorytree'))}
                <div class="filter-button">
                  <button id="search_filter_toggler" class="btn btn-secondary">
                      <svg
                       xmlns="http://www.w3.org/2000/svg"
                       xmlns:xlink="http://www.w3.org/1999/xlink"
                       width="18px" height="13px">
                      <path fill-rule="evenodd"  fill="rgb(0, 0, 0)"
                       d="M17.100,11.143 C17.597,11.143 18.000,11.559 18.000,12.071 C18.000,12.584 17.597,13.000 17.100,13.000 L0.900,13.000 C0.403,13.000 -0.000,12.584 -0.000,12.071 C-0.000,11.559 0.403,11.143 0.900,11.143 L17.100,11.143 ZM17.100,5.571 C17.597,5.571 18.000,5.987 18.000,6.500 C18.000,7.013 17.597,7.429 17.100,7.429 L0.900,7.429 C0.403,7.429 -0.000,7.013 -0.000,6.500 C-0.000,5.987 0.403,5.571 0.900,5.571 L17.100,5.571 ZM17.100,-0.000 C17.597,-0.000 18.000,0.416 18.000,0.929 C18.000,1.441 17.597,1.857 17.100,1.857 L0.900,1.857 C0.403,1.857 -0.000,1.441 -0.000,0.929 C-0.000,0.416 0.403,-0.000 0.900,-0.000 L17.100,-0.000 Z"/>
                      </svg>
                    {l s='Filter' d='Shop.Theme.Actions'}
                  </button>
                </div>
              {/if}
            {if $showCollectionView}
            <div class="collection-view-wrap">
                <div class="collection-view-btn
                {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                  {if $smarty.get.view == 'col2'}
                    active no-cookie
                  {/if}
                {else}
                {if isset($smarty.cookies.an_collection_view)}
                  {if $smarty.cookies.an_collection_view == 6}
                    active
                  {/if}
                {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-6'}
                  active
                {/if}{/if}" data-xl="6">
                  <div class="view-type view-type-3">

                  </div>
                </div>
                <div class="collection-view-btn
                {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                  {if $smarty.get.view == 'col3'}
                    active no-cookie
                  {/if}
                {else}
                {if isset($smarty.cookies.an_collection_view)}
                  {if $smarty.cookies.an_collection_view == 4}
                    active
                  {/if}
                {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-4'}
                  active
                {/if}{/if}" data-xl="4">
                    <div class="view-type view-type-2"></div>
                </div>
                <div class="collection-view-btn
                {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                  {if $smarty.get.view == 'col4'}
                    active no-cookie
                  {/if}
                {else}
                {if isset($smarty.cookies.an_collection_view)}
                  {if $smarty.cookies.an_collection_view == 3}
                    active
                  {/if}
                {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-3'}
                  active
                {/if}{/if}" data-xl="3">
                    <div class="view-type view-type-1"></div>
                </div>
                <div class="collection-view-btn
                {if isset($smarty.get.view) && ($smarty.get.view == 'col2' || $smarty.get.view == 'col3' || $smarty.get.view == 'col4' || $smarty.get.view == 'row')}
                  {if $smarty.get.view == 'row'}
                    active no-cookie
                  {/if}
                {else}
                {if isset($smarty.cookies.an_collection_view)}
                  {if $smarty.cookies.an_collection_view == 12}
                    active
                  {/if}
                {elseif Module::isEnabled('an_theme') and Module::getInstanceByName('an_theme')->getParam('categoryPage_productsAmount') == 'col-xs-12'}
                  active
                {/if}{/if}" data-xl="12">
                    <div class="view-type view-type-4"></div>
                </div>
            </div>
            {/if}
          </div>

          <div class="col-md-4 hidden-sm-down total-products">
            {if $listing.pagination.total_items > 1}
              <p>{l s='There are %product_count% products.' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</p>
            {else if $listing.pagination.total_items > 0}
              <p>{l s='There is 1 product.' d='Shop.Theme.Catalog'}</p>
            {/if}
          </div>
          <div class="col-md-4 sort-block">
            <div class="sort-by-row row">

              {block name='sort_by'}
                {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
              {/block}


            </div>
          </div>
      </div>
  {/if}
  </div>
</div>
