/**
 * 2021 Anvanto
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 wesite only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses. 
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 *  @author Anvanto <anvantoco@gmail.com>
 *  @copyright  2021 Anvanto
 *  @license    Valid for 1 website (or project) for each purchase of license
 *  International Registered Trademark & Property of Anvanto
 */
 
(function ($, window, undefined) {
	'use strict';
	
	resizeProduct();
	
	$(document).ajaxSuccess(function() {
		resizeProduct();
	});

	function resizeProduct(){
		/*
		$('.js-product-miniature').each( function(){
			var marginBottom = $(this).find('.an_productattributes').height()+40+'px'
			$(this).find('.thumbnail-container').css('margin-bottom', marginBottom);
		});
		*/
	}

	$(document).on('change','.an_productattributes [data-product-attribute], .an_productattributes-select select', function() {

		var self = this;

		getData($(this).closest('.an_productattributesForm').serialize(), function(data){
			isAvailableForOrder($(self).closest('.an_productattributesForm').find('.js-an_productattributes-add-to-cart'), data);
			setMaxQty($(self).closest('.an_productattributesForm').find('.an_productattributes-qty'), data);
			setMinQty($(self).closest('.an_productattributesForm').find('.an_productattributes-qty'), data);
			setPrices($(self).closest(an_productattributes.config.product_price_and_shipping), $(self).closest(an_productattributes.config.product_price_and_shipping).find(an_productattributes.config.price), data);
			setImages($(self).closest(an_productattributes.config.thumbnail_container).find('img'), data, $(self).closest(an_productattributes.config.product_miniature));
			setVariants(self, data);
		}, $(self).closest(an_productattributes.config.thumbnail_container).find('img').closest('.thumbnail-container-image'));

	});

	$(document).on('click','.an_productattributes-dropdown-menu li', function() {

		var self = this;

		if (attributeGroups){
			generateInputs($(this).closest('.an_productattributesForm'), parseInt($(this).closest(an_productattributes.config.product_miniature).attr('data-id-product')), $(this).data('value'));
		}

		getData($(this).closest('.an_productattributesForm').serialize(), function(data){
			isAvailableForOrder($(self).closest('.an_productattributesForm').find('.js-an_productattributes-add-to-cart'), data);
			setMaxQty($(self).closest('.an_productattributesForm').find('.an_productattributes-qty'), data);
			setMinQty($(self).closest('.an_productattributesForm').find('.an_productattributes-qty'), data);
			setPrices($(self).closest(an_productattributes.config.product_price_and_shipping), $(self).closest(an_productattributes.config.product_price_and_shipping).find(an_productattributes.config.price), data);
			setImages($(self).closest(an_productattributes.config.thumbnail_container).find('img'), data, $(self).closest(an_productattributes.config.product_miniature));
		}, $(self).closest(an_productattributes.config.thumbnail_container).find('img').closest('a'));
	});

	$(document).on('input','.an_productattributes-qty', function() {
		changeButInput(this);
	});

	function changeButInput(self){
		var val = parseInt($(self).val());
		var max = parseInt($(self).attr('data-max'));
		var addToCart = $(self).closest('.an_productattributesForm').find('.js-an_productattributes-add-to-cart');
		var addToCartStatus = parseInt(addToCart.attr('data-status'));

		if (max && val > max){
			addToCart.attr('disabled', 'disabled');
		} else if (addToCartStatus){
			addToCart.removeAttr('disabled');
		} else {
			addToCart.attr('disabled', 'disabled');
		}
	}

	function getData(dataUrl, callback, aContainer){

		aContainer.append(an_productattributes.loader);

		$.ajax({
			type: "POST",
			url: an_productattributes.controller,
			data: dataUrl + '&action=getProductAttributes',
			dataType: 'json',
		}).done(function(data){
			callback(data);
		}).always(function() {
			aContainer.find('.js-anpa-loader').remove();
		});
	}

	function generateInputs(an_productattributesForm, productId, attrebuteID){
		$('.an_productattributes-hiddeninputs').remove();

		$.each(attributeGroups[productId][attrebuteID], function(index, value) {
			an_productattributesForm.append("<input name='group[" + value['id_attribute_group'] + "]' value='" + value['id_attribute'] + "' type='hidden' class='an_productattributes-hiddeninputs' />");
		});
	}

	function isAvailableForOrder(addToCart, data){
		if (!data.availableForOrder){
			addToCart.attr('disabled', 'disabled');
			addToCart.find('span').html(addToCart.parents('.js-an_productattributes').data('text_out_of_stock'));
		} else {
			addToCart.removeAttr('disabled');
			addToCart.find('span').html(addToCart.parents('.js-an_productattributes').data('add_to_cart'));
		}
		addToCart.attr('data-status', data.availableForOrder);
	}

	function setVariants(self, data){
		if (data.variants){
			$(self).closest('.js-an_productattributes-standart').html(data.variants);
		}
	}

	function setMaxQty(qty, data){
		if (data.order_out_of_stock){
			qty.attr('data-max', data.quantity);
		} else {
			qty.removeAttr('data-max');
		}
	}

	function setMinQty(qty, data){
		if (data.minimal_quantity){
			qty.attr('min', data.minimal_quantity).val(data.minimal_quantity);
		}
	}
		
	function setPrices(priceContainer, price, data){
		priceContainer.find(an_productattributes.config.regular_price).remove();
		price.find('.money').html(data.prices.price);
		if (data.prices.regular_price){
			$('<span class="regular-price">'+data.prices.regular_price+'</span>').insertAfter(price);
		}
	}

	function setImages(img, data, miniature){
		var imgSize;
		if (miniature.hasClass('col-lg-6')) {
			imgSize = 'catalog_large';
		} else if (miniature.hasClass('col-lg-3')) {
			imgSize = 'catalog_small';
		} else {
			imgSize = 'home_default';
		}
		if (data.images){
			img.parents('.product-thumbnail').find('source').remove();
			if ($(img[0]).parents().hasClass('js-img-view-type')) {
				if ($(img[0]).parents().hasClass('type-standart')) {
					$.each(data.images, function (index) {
						if (this.cover || index == 0) {
							img.attr('src', this.bySize[imgSize].url);
						}
					});
				}
				if ($(img[0]).parents().hasClass('type-hover')) {
					let img_item = img[0],
						img_hover_container = img.parents('.product-thumbnail'),
						img_cover;
					img_hover_container.empty();

					$.each(data.images, function (index) {
						if (index == 0) {
							img_hover_container.append(img_item);
							img_cover = img_hover_container.find('img').eq(index);
							img_hover_container.find('img').eq(index).attr('src', this.bySize[imgSize].url);
						} else if (index == 1 || this.cover) {
							img_hover_container.find('img').eq(1).remove();
							img_hover_container.find('img:first').removeClass('cover').clone().appendTo(img_hover_container);
							if (this.cover) {
								img_cover = img_hover_container.find('img').eq(1);
							}
							img_hover_container.find('img').eq(1).attr('src', this.bySize[imgSize].url);
						}
						if (data.images.length < 2) {
							img_hover_container.find('img').eq(index).addClass('only_one_item');
						} else {
							img_hover_container.find('img').eq(index).removeClass('only_one_item');
						}
					});
					img_cover.addClass('cover');
				}

				if ($(img[0]).parents().hasClass('type-slider')) {
					slider_pr_delete($(img[0]).parents('.slider_product-wrapper'));

					let cover_index,
						img_item = $(img[0]).parents('.slider-product-item').removeClass('slick-slide slick-cloned'),
						img_hover_container = img.parents('.slider_product-wrapper');

					img_hover_container.empty();
					$.each(data.images, function (index) {
						if(index == 0) {
							img_hover_container.append(img_item);
						} else {
							if(this.cover) {
								img_hover_container.find('.slider-product-item:first').clone().prependTo(img_hover_container);
							} else {
								img_hover_container.find('.slider-product-item:first').clone().appendTo(img_hover_container);
							}
						}
						if(this.cover) {
							img_hover_container.find('.slider-product-item').eq(0).find('img').attr('src', this.bySize[imgSize].url);
						} else {
							img_hover_container.find('.slider-product-item').eq(index).find('img').attr('src', this.bySize[imgSize].url);
						}

					});
					slider_pr_init_one($(img[0]).parents('.an_slick-slider'));
				}

				if ($(img[0]).parents().hasClass('type-hover-slider')) {
					let keysArr = [],
						img_item = $(img[0]).parents('li:first'),
						img_hover_container = img.parents('.product-thumbnail ul'),
						img_cover,
						only_one_img;
					img_hover_container.empty();
					$.each(data.images, function (index) {
						if(index == 0) {
							img_hover_container.append(img_item);
						} else {
							img_hover_container.find('li:first').removeClass('cover-item').addClass('no-cover-item').clone().appendTo(img_hover_container);
						}
						img_hover_container.find('img').eq(index).attr('src', this.bySize[imgSize].url);
						if(this.cover) {
							img_cover = img_hover_container.find('img').eq(index);
						}
						if (data.images.length < 2) {
							only_one_img = true;
						} else {
							only_one_img = false;
						}
					});
					if (only_one_img) {
						img_hover_container.addClass('only_one_item');
					} else {
						img_hover_container.removeClass('only_one_item');
					}
					if (!img_cover) {
						img_cover = img_hover_container.find('img').eq(0);
					}
					img_cover.parents('li:first').removeClass('no-cover-item').addClass('cover-item');
				}

			} else {
				$.each(data.images, function (index) {
					if (this.cover || index == 0) {
						img.attr('src', this.bySize[imgSize].url);
					}
				});
			}
		}
	}

})(jQuery, window);

$(document).ready(function () {
	
	selectFilling();
	
	$(document).ajaxSuccess(function() {
		selectFilling();
	});

		
	$(document).on('click','.an_productattributes-dropdown-toggler', function() {
		$(this).parents('.an_productattributes-dropdown').toggleClass('open');
	});
	
	$(document).on('click','.an_productattributes-dropdown-menu', function() {
		$(this).parents('.an_productattributes-dropdown').toggleClass('open');
	});

	$(document).on('click','.js-an_productattributes-product-selectbox li', function() {
		$(this).parents('.js-an_productattributes-product-selectbox').find('.js-an_productattributes-filter-option').text($(this).children('.js-an_productattributes-text').text());
		$(this).parents('.js-an_productattributes-select').find('option').removeAttr('selected');
		$(this).parents('.js-an_productattributes-select').find('option').eq($(this).index()).attr('selected','');
	});
	
	$(document).on('mouseleave', an_productattributes.config.product_miniature, function() {
		$('.an_productattributes-dropdown').removeClass('open');
		
	});

	function selectFilling(){
		$('.js-an_productattributes-product-selectbox li.selected').each(function() {
			let item = $(this).parents('.js-an_productattributes-product-selectbox').find('.js-an_productattributes-filter-option');
			if (!item.hasClass('selected')) {
				item.text($(this).children('.js-an_productattributes-text').text());
				item.addClass('selected');
			}
		});
	}
});