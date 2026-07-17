/**
 * 2022 Anvanto
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 wesite only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses.
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 *  @author Anvanto <anvantoco@gmail.com>
 *  @copyright  2022 Anvanto
 *  @license    Valid for 1 website (or project) for each purchase of license
 *  International Registered Trademark & Property of Anvanto
 */

(function ($, window, undefined) {
    'use strict';

})(jQuery, window);

function anhp_slider_init(slider_id) {
    $('.an_homeproducts-slider .js-an_homeproducts-content .products').each(function(i, val) {
        var slider_id = '.js-an_homeproducts-content[data-block-id=' + $(this).parents('.js-an_homeproducts-content').data('block-id') + ']';
        let responsive_items;
        if ($(slider_id).data('items') == 4) {
            responsive_items = {
                0: {
                    items: 1
                },
                240: {
                    items: 1
                },
                380: {
                    margin: 0,
                    items: 2
                },
                720: {
                    margin: 30,
                    items: 3
                },
                960: {
                    margin: 30,
                    items: $(slider_id).data('items')
                }
            }
        }
        if ($(slider_id).data('items') == 5) {
            responsive_items = {
                0: {
                    items: 1
                },
                240: {
                    items: 1
                },
                380: {
                    margin: 30,
                    items: 2
                },
                720: {
                    margin: 30,
                    items: 3
                },
                960: {
                    margin: 30,
                    items: 4
                },
                1200: {
                    margin: 30,
                    items: $(slider_id).data('items')
                }
            }
        }
        if ($(slider_id).data('items') == 6) {
            responsive_items = {
                0: {
                    items: 1
                },
                240: {
                    items: 1
                },
                400: {
                    items: 2
                },
                600: {
                    margin: 5,
                    items: 4
                },
                800: {
                    margin: 5,
                    items: 4
                },
                1000: {
                    margin: 5,
                    items: 5
                },
                1200: {
                    margin: 5,
                    items: $(slider_id).data('items')
                }
            }
        }
        //$('.js-an_homeproducts-container').append('<div class="js-anhp-loader anhp-loader"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background-image: none; display: block; shape-rendering: auto; animation-play-state: running; animation-delay: 0s; background-position: initial initial; background-repeat: initial initial;" width="254px" height="254px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"><path fill="none" stroke="#1d0e0b" stroke-width="3" stroke-dasharray="42.76482137044271 42.76482137044271" d="M24.3 30C11.4 30 5 43.3 5 50s6.4 20 19.3 20c19.3 0 32.1-40 51.4-40 C88.6 30 95 43.3 95 50s-6.4 20-19.3 20C56.4 70 43.6 30 24.3 30z" stroke-linecap="round" style="transform: scale(0.22); transform-origin: 50px 50px; animation-play-state: running; animation-delay: 0s;"> <animate attributeName="stroke-dashoffset" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0;256.58892822265625" style="animation-play-state: running; animation-delay: 0s;"></animate></path></svg></div>');
        $(slider_id).find('.owl-carousel').trigger('destroy.owl.carousel');
        $(slider_id).find('.owl-carousel').owlCarouselAnBS({
            loop: $(slider_id).data('loop'),
            nav: $(slider_id).data('nav'),
            dots: $(slider_id).data('dots'),
            rows: 1,
            autoplay: 0,
            navText: ['<svg \n' +
            ' xmlns="http://www.w3.org/2000/svg"\n' +
            ' xmlns:xlink="http://www.w3.org/1999/xlink"\n' +
            ' width="6px" height="8px">\n' +
            '<path fill-rule="evenodd"  fill="rgb(134, 134, 134)"\n' +
            ' d="M0.517,3.870 L5.546,7.351 L5.546,0.389 L0.517,3.870 Z"/>\n' +
            '</svg>','<svg \n' +
            ' xmlns="http://www.w3.org/2000/svg"\n' +
            ' xmlns:xlink="http://www.w3.org/1999/xlink"\n' +
            ' width="6px" height="8px">\n' +
            '<path fill-rule="evenodd"  fill="rgb(134, 134, 134)"\n' +
            ' d="M5.483,3.870 L0.454,7.351 L0.454,0.389 L5.483,3.870 Z"/>\n' +
            '</svg>'],
            autoplayTimeout: 5000,
            responsive: responsive_items,
            //onChanged: anhp_slider_loaded(),
        });
    });
}
/*
function anhp_slider_loaded() {
    $('.js-an_homeproducts-container').find('.js-anhp-loader').remove();
}
*/
$(document).ready(function(){
    $('.an_homeproducts-slider .js-an_homeproducts-content').find('.products').addClass('owl-carousel');
    anhp_slider_init($('.an_homeproducts-slider .js-an_homeproducts-content[data-block-id='+1+']'));
});
