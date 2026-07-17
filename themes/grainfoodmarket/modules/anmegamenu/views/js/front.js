/**
 * 2025 Anvanto
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 *
 *  @author    Anvanto <anvantoco@gmail.com>
 *  @copyright 2025 Anvanto
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 */

$(function() {
    $('.anmm-menu-item').hover(function(){
        if ($(window).width() > 991) {
            var item = $(this);
            if (!item.hasClass('open')) {
                $('.anmm-menu-item').removeClass('open');
                item.addClass('open');
                item.parents('.anmm-menu-wrapper').addClass('anmm-zindex');
                $('.anmm-popupbg').addClass('active');
                if (item.hasClass('anmm-menu-vertical')) {
                    item.find('.anmm-dropdown .anmm-link').css('width', item.data('submenu-width'));
                    item.find('.anmm-dropdown-item.anmm-has-submenu').first().trigger('mouseenter');
                }
            }
        }
    }, function(e) {
        if ($(window).width() > 991) {
            var item = $(this);
            item.removeClass('open');
            item.parents('.anmm-menu-wrapper').removeClass('anmm-zindex');
            $('.anmm-popupbg').removeClass('active');
        }
    });

    $('.anmm-dropdown').each(function () {
        var item = $(this);
        var contWidth = $('.anmm-dropdown-container').width();

        if (item.parents('.anmm-menu-item').position().left + (item.data('width') * contWidth / 100) <= contWidth) {
            item.css({
                left: item.parents('.anmm-menu-item').position().left - 15
            });
        } else {
            item.css({
                left: 'unset',
                right: 0
            });
        }
    });

    $('.anmm-dropdown-item').hover(function(){
        if ($(window).width() > 991) {
            var item = $(this);
            $('.anmm-has-submenu').removeClass('open');
            if (item.hasClass('anmm-has-submenu')) {
                item.addClass('open');
                item.parents('.anmm-menu-wrapper').addClass('anmm-zindex');
                $('.anmm-popupbg').addClass('active');
                item.find('.anmm-dropdown-submenu').css({
                    'width': 'calc((100% - '+item.width()+'px) * '+item.find('.anmm-dropdown-submenu').data('width')+' / 100)',
                    'left': item.width()
                });
            }
        }
    }, function(e) {
        if ($(window).width() > 991) {
            var item = $(this);
            item.removeClass('open');
            item.parents('.anmm-menu-wrapper').removeClass('anmm-zindex');
            $('.anmm-popupbg').removeClass('active');
        }
    });

    $('.anmm-dropdown-block-item').hover(function(){
        if ($(window).width() > 991) {
            var item = $(this);
            $('.anmm-block-has-submenu').removeClass('open');
            if (item.hasClass('anmm-block-has-submenu')) {
                item.addClass('open');
                item.parents('.anmm-menu-wrapper').addClass('anmm-zindex');
                $('.anmm-popupbg').addClass('active');
                item.find('.anmm-dropdown-block-submenu').css({
                    'width': 'calc('+item.parents('.container').width()+'px - '+item.width()+'px)',
                    'left': item.width()
                });
            }
        }
    }, function(e) {
        if ($(window).width() > 991) {
            var item = $(this);
            item.removeClass('open');
            item.parents('.anmm-menu-wrapper').removeClass('anmm-zindex');
            $('.anmm-popupbg').removeClass('active');
        }
    });



});

function anmmDropdownPos() {
    $('.anmm-menu-item').each(function () {
        var elem = $(this);
        elem.find('.anmm-dropdown').css('top', elem.position().top + elem.height());
    });
}


$(document).ready(function(){

    $('body').append('<div class="anmm-popupbg"></div>');

    $(window).on('load resize scroll', function() {
        anmmDropdownPos();
    });
    if ($('.anmm-menu-sticky').length) {
        var headerHeight = $('.anmm-menu-sticky').first().outerHeight();
        var scrollHeight = $('.anmm-menu-sticky').first().offset().top;

        $(window).on('load resize scroll', function() {
            if (!$('.anmm-menu-sticky').first().hasClass('anmm-menu-fixed')) {
                headerHeight = $('.anmm-menu-sticky').first().outerHeight();
            }
            if ($(window).width() >= 767 && $(window).scrollTop() > scrollHeight) {
                $('.anmm-menu-sticky').first().addClass('anmm-menu-fixed');
                $('.anmm-menu-sticky-container').first().addClass('container');
                $('.anmm-menu-placeholder').first().css('height', headerHeight + 'px');
            } else {
                $('.anmm-menu-sticky').first().removeClass('anmm-menu-fixed');
                $('.anmm-menu-sticky-container').first().removeClass('container');
                $('.anmm-menu-placeholder').first().css('height', 'auto');
            }
        });
    }

    $('.anmm-menu-vertical, .anmm-menu-horizontal').clone().appendTo('.anmm-list-mobile');

});