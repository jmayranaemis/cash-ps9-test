/**
* 2019 Anvanto
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author Anvanto (anvantoco@gmail.com)
*  @copyright  2019 anvanto.com

*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

(function ($, window, undefined) {
	'use strict';
	
	resizeProduct();
	
	$(document).ajaxSuccess(function() {
		resizeProduct();
	});
	
	function resizeProduct(){
		$('.js-product-miniature').each( function(){
			var marginBottom = $(this).find('.an_stickyAddToCart').height()+40+'px'
			$(this).find('.thumbnail-container').css('margin-bottom', marginBottom);		
		});
	}

	$(document).on('change','.an_stickyAddToCart [data-product-attribute], .an_stickyAddToCart-select select', function() {
		
		var self = this;
		
		getData($(this).closest('.an_stickyAddToCartForm').serialize(), function(data){ 			
			isAvailableForOrder($(self).closest('.an_stickyAddToCartForm').find('.js-an_stickyAddToCart-add-to-cart'), data);
			setMaxQty($(self).closest('.an_stickyAddToCartForm').find('.an_stickyAddToCart-qty'), data);
			setMinQty($(self).closest('.an_stickyAddToCartForm').find('.an_stickyAddToCart-qty'), data);			
			setPrices($('.an_stickyAddToCart-product-price-and-shipping'), $('.an_stickyAddToCart-price-price'), data);
 			setImages($('.js-an_stickyAddToCart-image'), data);
			setVariants(self, data);
		});
	});

	$(document).on('click','.an_stickyAddToCart-dropdown-menu li', function() {
		
		var self = this;
				
		if (attributeGroups){
			generateInputs($(this).closest('.an_stickyAddToCartForm'), parseInt($('.js-an_stickyAddToCart').attr('data-id-product')), $(this).data('value'));
		}		

		getData($(this).closest('.an_stickyAddToCartForm').serialize(), function(data){ 
			isAvailableForOrder($(self).closest('.an_stickyAddToCartForm').find('.js-an_stickyAddToCart-add-to-cart'), data);
			setMaxQty($(self).closest('.an_stickyAddToCartForm').find('.an_stickyAddToCart-qty'), data);
			setMinQty($(self).closest('.an_stickyAddToCartForm').find('.an_stickyAddToCart-qty'), data);
			setPrices($('.an_stickyAddToCart-product-price-and-shipping'), $('.an_stickyAddToCart-price-price'), data);
 			setImages($('.js-an_stickyAddToCart-image'), data);
		});
	}); 
	
 	
	
	$(document).on('input','.an_stickyAddToCart-qty', function() {
		changeButInput(this);
	});
	
	
function changeButInput(self){
	var val = parseInt($(self).val());
	var max = parseInt($(self).attr('data-max'));
	var addToCart = $(self).closest('.an_stickyAddToCartForm').find('.js-an_stickyAddToCart-add-to-cart');
	var addToCartStatus = parseInt(addToCart.attr('data-status'));

	if (max && val > max){
		addToCart.attr('disabled', 'disabled');
	} else if (addToCartStatus){
		addToCart.removeAttr('disabled');
	} else {
		addToCart.attr('disabled', 'disabled');
	}
}
	
	

function getData(dataUrl, callback){	
	$.ajax({
		type: "POST",
		url: an_stickyaddtocart.controller,
		async: false,
		data: dataUrl + '&action=getProductAttributes',
		dataType: 'json',
	}).done(function(data){
		callback(data);
	});
}

function generateInputs(an_stickyAddToCartForm, productId, attrebuteID){
	$('.an_stickyAddToCart-hiddeninputs').remove();
	
	$.each(attributeGroups[productId][attrebuteID], function(index, value) {
		an_stickyAddToCartForm.append("<input name='group[" + value['id_attribute_group'] + "]' value='" + value['id_attribute'] + "' type='hidden' class='an_stickyAddToCart-hiddeninputs' />");
	});
}
	
function isAvailableForOrder(addToCart, data){
	if (!data.availableForOrder){
		addToCart.attr('disabled', 'disabled');
	} else {
		addToCart.removeAttr('disabled');
	}
	addToCart.attr('data-status', data.availableForOrder);
}

function setVariants(self, data){
	if (data.variants){
		$(self).closest('.js-an_stickyAddToCart-standart').html(data.variants);
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
	priceContainer.find('.an_stickyAddToCart-regular-price').remove();
	if (data.prices.regular_price){
		priceContainer.prepend('<span class="an_stickyAddToCart-regular-price regular-price">'+data.prices.regular_price+'</span>');
	}
	
	price.html(data.prices.price);
}	

function setImages(img, data){
	if (data.images){
		img.attr('src', data.images.home[data.cover_id]);
	}
}

})(jQuery, window);

$(document).ready(function () {
	
	selectFilling();
	
	$(document).ajaxSuccess(function() {
		selectFilling();
	});

	$(document).mouseup(function (e){ // событие клика по веб-документу
		var div = $(".an_stickyAddToCart .an_stickyAddToCart-product-selectbox"); // тут указываем ID элемента
		if (!div.is(e.target) // если клик был не по нашему блоку
			&& div.has(e.target).length === 0) { // и не по его дочерним элементам
			div.removeClass('open'); // скрываем его
		}
	});
	$(document).on('click','.an_stickyAddToCart-dropdown-toggler', function() {
		$(this).parents('.an_stickyAddToCart-dropdown').toggleClass('open');
	});
	
	$(document).on('click','.an_stickyAddToCart-dropdown-menu', function() {
		$(this).parents('.an_stickyAddToCart-dropdown').toggleClass('open');
	});

	$(document).on('click','.js-an_stickyAddToCart-product-selectbox li', function() {
		$(this).parents('.js-an_stickyAddToCart-product-selectbox').find('.js-an_stickyAddToCart-filter-option').text($(this).children('.js-an_stickyAddToCart-text').text());
		$(this).parents('.js-an_stickyAddToCart-select').find('option').removeAttr('selected');
		$(this).parents('.js-an_stickyAddToCart-select').find('option').eq($(this).index()).attr('selected','');
	});

	$(document).on('mouseleave', '.an_stickyAddToCart', function() {
		$('.an_stickyAddToCart-dropdown').removeClass('open');

	});

	function selectFilling(){
		$('.js-an_stickyAddToCart-product-selectbox li.selected').each(function() {
			let item = $(this).parents('.js-an_stickyAddToCart-product-selectbox').find('.js-an_stickyAddToCart-filter-option');
			if (!item.hasClass('selected')) {
				item.text($(this).children('.js-an_stickyAddToCart-text').text());
				item.addClass('selected');
			}
		});
	}

	$('<div class="quantity-button quantity-up">' +
		'+' +
		'</div>').insertAfter('#an_stickyAddToCart_qty');
	$('<div class="quantity-button quantity-down">' +
		'-' +
		'</div>').insertBefore('#an_stickyAddToCart_qty');
	$('.an_stickyAddToCart-qty-container').each(function() {
		var spinner = jQuery(this),
			input = spinner.find('input[type="number"]'),
			btnUp = spinner.find('.quantity-up'),
			btnDown = spinner.find('.quantity-down'),
			min = input.attr('min'),
			max = input.attr('max');

		btnUp.click(function() {
			var oldValue = parseFloat(input.val());
			if (oldValue >= max) {
				var newVal = oldValue;
			} else {
				var newVal = oldValue + 1;
			}
			spinner.find("input").val(newVal);
			spinner.find("input").trigger("change");
		});

		btnDown.click(function() {
			var oldValue = parseFloat(input.val());
			if (oldValue <= min) {
				var newVal = oldValue;
			} else {
				var newVal = oldValue - 1;
			}
			spinner.find("input").val(newVal);
			spinner.find("input").trigger("change");
		});
	});

	let scrollStart = ($('.product-add-to-cart .add-to-cart').offset().top + $('.product-add-to-cart .add-to-cart').height() + 20);
	stickyScroll(scrollStart);
	$(window).scroll(function(){
		stickyScroll(scrollStart);
	})

    $(function() {
        if ($('.an_stickyAddToCart .btn').data('animation')) {
            setInterval(function() {
                var animationName = 'animated '+$('.an_stickyAddToCart .btn').data('animation');
                var animationend = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
                $('.an_stickyAddToCart .btn').addClass(animationName).one(animationend, function() {
                    $(this).removeClass(animationName);
                });
            }, $('.an_stickyAddToCart .btn').data('interval'));
        }
    });
});

function stickyScroll (scrollStart) {
	if($(window).scrollTop() > scrollStart && $('.an_stickyAddToCart').attr('data-hidden') == 1){
		$('.an_stickyAddToCart').attr('data-hidden',0);
		$('#footer').css('padding-bottom',$('.an_stickyAddToCart').height() + 'px');
		$('#scrolltopbtn').css('margin-bottom',$('.an_stickyAddToCart').height() + 'px');
	}
	if($(window).scrollTop() < scrollStart && $('.an_stickyAddToCart').attr('data-hidden') == 0) {
		$('.an_stickyAddToCart').attr('data-hidden',1);
		$('#footer').css('padding-bottom', '0');
		$('#scrolltopbtn').css('margin-bottom','0');
	}
}