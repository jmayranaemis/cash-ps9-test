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
    $(document).ready(function(){
        $('.an_homeslider').addClass('owl-carousel');
        $('.an_homeslider').each(function(i, val) {
            var anhs_id = '#'+$(this).attr('id');
            $(anhs_id).owlCarouselAnBS({
                items: 1,
                loop: $(anhs_id).data('loop'),
                nav: $(anhs_id).data('nav'),
                autoplay: $(anhs_id).data('autoplay'),
                navText: ['<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="10px" height="17px"> <path fill-rule="evenodd"  fill="rgb(255, 255, 255)" d="M8.092,-0.000 L9.993,1.997 L3.818,8.500 L9.993,15.002 L8.092,17.000 L0.002,8.500 L8.092,-0.000 Z"/> </svg>',
                    '<svg xmlns="http://www.w3.org/2000/svg" width="10px" height="17px"> <path fill-rule="evenodd"  fill="rgb(255, 255, 255)" d="M1.908,-0.000 L0.007,1.997 L6.182,8.500 L0.007,15.002 L1.908,17.000 L9.998,8.500 L1.908,-0.000 Z"/> </svg>'],
                autoplayTimeout: $(anhs_id).data('autoplaytimeout'),
                smartSpeed: $(anhs_id).data('smartspeed'),
                dots: $(anhs_id).data('dots'),
                dotsClass: 'owl-dots container',
                lazyLoad: $(anhs_id).data('lazy'),
                onInitialize: callFixAuto,
            });
            function callFixAuto() {
                if ($(anhs_id).data('autoplay')) {
                    setTimeout(function(){$(anhs_id).addClass('slide-next');}, $(anhs_id).data('autoplaytimeout'));
                }
            }
            $(this).parent('.an_homeslider-block').addClass('initialized');
        });
    });

})(jQuery, window);

