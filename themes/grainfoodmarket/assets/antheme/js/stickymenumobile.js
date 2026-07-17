$(document).ready(function() {
    var scrollHeight = $('.mobile-header-holder').offset().top;

    $(window).on('load resize scroll', function() {
        var headerHeight = $('.mobile-header').outerHeight();
        if ($(window).width() <= 767 && $(window).scrollTop() > scrollHeight) {
            $('.mobile-header').addClass('fixed-menu-mobile');
            $('.mobile-header-holder').css('height', headerHeight + 'px');
        } else {
            $('.mobile-header').removeClass('fixed-menu-mobile');
            $('.mobile-header-holder').css('height', 'auto');
        }
    });
});
