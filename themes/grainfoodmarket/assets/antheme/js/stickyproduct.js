$(document).ready(function() {
    var elementHeight, containerHeight, scrollHeightStart, scrollHeightEnd, fixedmenuSize;
    $(window).on('load resize scroll', function() {
        if ($('.fixed-menu').length) {
            fixedmenuSize = $('.fixed-menu').height();
        } else {
            fixedmenuSize = 0;
        }

        if ($(window).width() >= 768 && $('.sticky-product').height() < $('.productblock-content').height()) {
            if (($(window).scrollTop() + $('.sticky-product').height() + $('.sticky-product').position().top) < ($('.productblock-content').position().top + $('.productblock-content').height()) && $(window).scrollTop() > $('.productblock-content').offset().top - fixedmenuSize) {
                $('.sticky-product').removeClass('sticky-product-bottom');
                $('.sticky-product').addClass('sticky-product-fixed');
                $('.sticky-product').css('top', 10 + fixedmenuSize + 'px');
            } else if (($(window).scrollTop() + $('.sticky-product').height() + $('.sticky-product').position().top) > ($('.productblock-content').position().top + $('.productblock-content').height()) && $(window).scrollTop() > $('.productblock-content').offset().top - fixedmenuSize) {
                $('.sticky-product').removeClass('sticky-product-fixed');
                $('.sticky-product').addClass('sticky-product-bottom');
                $('.sticky-product').css('top', 0);
                if ($('.sticky-product').offset().top > $(window).scrollTop() + fixedmenuSize + 10) {
                    $('.sticky-product').removeClass('sticky-product-bottom');
                    $('.sticky-product').addClass('sticky-product-fixed');
                    $('.sticky-product').css('top', 10 + fixedmenuSize + 'px');
                }
            } else {
                $('.sticky-product').removeClass('sticky-product-bottom').removeClass('sticky-product-fixed');
                $('.sticky-product').css('top', 0);
            }
        } else {
            $('.sticky-product').removeClass('sticky-product-bottom').removeClass('sticky-product-fixed');
            $('.sticky-product').css('top', 0);
        }
    });
});
