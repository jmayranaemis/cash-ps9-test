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

    $(document).on('click','.js-an_homeproducts-tab', function() {

        var self = this;
        if(!$(self).hasClass('tab-loaded')) {
            getData(
                $('.js-an_homeproducts').attr('data-url'),
                $(self).attr('data-block-id'),
                1,
                '',
                'tab',
                function(data){
                    $(self).closest('.js-an_homeproducts').find('.js-an_homeproducts-container').append(data.products);
                    $(self).addClass('tab-loaded');
                    if ($('.js-an_homeproducts').hasClass('an_homeproducts-slider') && !$('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']').find('.products').hasClass('owl-loaded')) {
                        $('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']').find('.products').addClass('owl-carousel');
                        if (typeof anhp_slider_init === "function") {
                            anhp_slider_init($('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']'));
                        }
                    }

                    $('.js-an_homeproducts-tab, .js-an_homeproducts-content').removeClass('active');
                    $(self).addClass('active');
                    $('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']').addClass('active');
                },
            );
        } else {
            $('.js-an_homeproducts-tab, .js-an_homeproducts-content').removeClass('active');
            $(self).addClass('active');
            $('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']').addClass('active');
        }
        window.dispatchEvent(new Event('resize'));
    });


    $(document).on('click','.js-an_homeproducts-category', function() {

        var self = this;

        getData(
            $('.js-an_homeproducts').attr('data-url'),
            $(self).closest('.js-an_homeproducts-content').attr('data-block-id'),
            1,	// page
            $(self).val(), // sort
            'sort',
            function(data){
                $(self).siblings('.js-an_homeproducts-category').removeClass('active');
                $(self).addClass('active');
                $(self).closest('.js-an_homeproducts-content').find('.products').html(data.products);
                if (typeof anhp_slider_init === "function") {
                    anhp_slider_init($('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']'));
                }
            },
            $(this).attr('data-cat')
        );
    });

    $(document).on('change','.js-an_homeproducts-sort', function() {

        var self = this;

        getData(
            $('.js-an_homeproducts').attr('data-url'),
            $(self).closest('.js-an_homeproducts-content').attr('data-block-id'),
            1,	// page
            $(self).val(), // sort
            'sort',
            function(data){
                $(self).closest('.js-an_homeproducts-content').find('.products').html(data.products);
                if (typeof anhp_slider_init === "function") {
                    anhp_slider_init($('.js-an_homeproducts-content[data-block-id='+$(self).attr('data-block-id')+']'));
                }
            },
            $('.js-an_homeproducts-category.active').attr('data-cat')
        );
    });

    $(document).on('click','.js-an_homeproducts-loadmore', function() {

        var self = this;
        $(self).append('<div class="js-anhp-loader anhp-loader"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background-image: none; display: block; shape-rendering: auto; animation-play-state: running; animation-delay: 0s; background-position: initial initial; background-repeat: initial initial;" width="254px" height="254px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"><path fill="none" stroke="#1d0e0b" stroke-width="3" stroke-dasharray="42.76482137044271 42.76482137044271" d="M24.3 30C11.4 30 5 43.3 5 50s6.4 20 19.3 20c19.3 0 32.1-40 51.4-40 C88.6 30 95 43.3 95 50s-6.4 20-19.3 20C56.4 70 43.6 30 24.3 30z" stroke-linecap="round" style="transform: scale(0.22); transform-origin: 50px 50px; animation-play-state: running; animation-delay: 0s;"> <animate attributeName="stroke-dashoffset" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0;256.58892822265625" style="animation-play-state: running; animation-delay: 0s;"></animate></path></svg></div>');

        getData(
            $('.js-an_homeproducts').attr('data-url'),
            $(self).closest('.js-an_homeproducts-content').attr('data-block-id'),
            $(self).attr('data-page'),
            $(self).closest('.js-an_homeproducts-content').find('.js-an_homeproducts-sort').val(),
            'loadMore',
            function(data){
                if (data.products){
                    $(self).closest('.js-an_homeproducts-content').find('.products').append(data.products);
                    $(self).attr('data-page', parseInt($(self).attr('data-page')) + 1);
                    if (data.productsNextPage < 1) {
                        $(self).hide();
                    }
                } else {
                    $(self).hide();
                }
            },
        );

    });


    function getData(url, blockId, page, sort, type, callback, idCategory = false){
        let hpContainer;
        if ($('.js-an_homeproducts').hasClass('an_homeproducts-type-tabs')) {
            hpContainer = $('.js-an_homeproducts-container');
        } else {
            hpContainer = $('.js-an_homeproducts-content[data-block-id='+blockId+']');
        }
        hpContainer.append('<div class="js-anhp-loader anhp-loader"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background-image: none; display: block; shape-rendering: auto; animation-play-state: running; animation-delay: 0s; background-position: initial initial; background-repeat: initial initial;" width="254px" height="254px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"><path fill="none" stroke="#1d0e0b" stroke-width="3" stroke-dasharray="42.76482137044271 42.76482137044271" d="M24.3 30C11.4 30 5 43.3 5 50s6.4 20 19.3 20c19.3 0 32.1-40 51.4-40 C88.6 30 95 43.3 95 50s-6.4 20-19.3 20C56.4 70 43.6 30 24.3 30z" stroke-linecap="round" style="transform: scale(0.22); transform-origin: 50px 50px; animation-play-state: running; animation-delay: 0s;"> <animate attributeName="stroke-dashoffset" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0;256.58892822265625" style="animation-play-state: running; animation-delay: 0s;"></animate></path></svg></div>');

        $.ajax({
            type: "POST",
            url: url,
            data: { action: "getProducts", blockId: blockId, page: page, sort: sort, type: type, idCategory: idCategory },
            dataType: 'json',
        }).done(function(data){
            callback(data);
        }).always(function() {
            hpContainer.find('.js-anhp-loader').remove();
        });
    }

})(jQuery, window);