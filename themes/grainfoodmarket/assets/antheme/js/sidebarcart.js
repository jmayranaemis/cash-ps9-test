$(document).ready(function() {
    $('html').append('<div class="scroll-example" style="overflow-y: scroll; visibility: hidden; height: 0px;"></div>');
    let scroll_example, scroll_width;
    scroll_example = $('.scroll-example');
    scroll_width = scroll_example[0].offsetWidth - scroll_example[0].clientWidth;
    $('head').append($('<style>').addClass('sidebar-offset-style').html('.sb-open body, .amegamenu_mobile-open body, .clientservice_sg-open body, .sb-open .fixed-menu, .clientservice_sg-open .fixed-menu{padding-right:' + scroll_width + 'px;'));

    var elemSideBar = $('<div id="js-cart-sidebar" class="cart-preview"></div>').insertAfter('main').wrapAll('<div class="sb-menu-right"></div>'),
        elemOverlay = $('<div class="sb-overlay"></div>').insertAfter('main'),
        elemCloseBtn = $('<div class="sb-close-btn"><i class="material-icons">&#xE5CD;</i></div>');

    elemCloseBtn.prependTo('.sb-menu-right');

    $('#js-cart-sidebar').html($('.js-cart-source').html());

    $('#_desktop_cart, #_fixed_cart').add('#_mobile_cart').on('click', function(e) {
        $('html').addClass('sb-open');
        $('.sb-overlay ').fadeIn(500);
        $('#scrolltopbtn').hide();
        return false;
    });

    $(document).on('click', '.sb-overlay, .sb-close-btn', function() {
        $('.sb-overlay').fadeOut('500');
        $('html').removeClass('sb-open');
        $('#scrolltopbtn').show();
    });
    $('body').on('click', '.js-an_productattributes-add-to-cart', function (event) {
        $(this).append('<div class="js-add-loader"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background-image: none; display: block; shape-rendering: auto; animation-play-state: running; animation-delay: 0s; background-position: initial initial; background-repeat: initial initial;" width="254px" height="254px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"><path fill="none" stroke="#1d0e0b" stroke-width="3" stroke-dasharray="42.76482137044271 42.76482137044271" d="M24.3 30C11.4 30 5 43.3 5 50s6.4 20 19.3 20c19.3 0 32.1-40 51.4-40 C88.6 30 95 43.3 95 50s-6.4 20-19.3 20C56.4 70 43.6 30 24.3 30z" stroke-linecap="round" style="transform: scale(0.22); transform-origin: 50px 50px; animation-play-state: running; animation-delay: 0s;"> <animate attributeName="stroke-dashoffset" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0;256.58892822265625" style="animation-play-state: running; animation-delay: 0s;"></animate></path></svg></div>');
    });
    prestashop.on(
        'updateCart',
        function (event) {
            var refreshURL = $('.blockcart').data('refresh-url');
            var requestData = {};

            if (event && event.reason) {
                requestData = {
                    id_product_attribute: event.reason.idProductAttribute,
                    id_product: event.reason.idProduct,
                    action: event.reason.linkAction
                };
            }

            $.post(refreshURL, requestData).then(function (resp) {
                $('.blockcart .header').replaceWith($(resp.preview).find('.blockcart .header'));
                $('.blockcart .cart-dropdown-wrapper').replaceWith($(resp.preview).find('.blockcart .cart-dropdown-wrapper'));
                $('.blockcart').removeClass('inactive').addClass('active');
                $('.an_productattributes-add .btn-primary').find('.js-add-loader').remove();
                if ($('.sb-menu-right').length) {
                    $('#js-cart-sidebar .cart-dropdown-wrapper').replaceWith($(resp.preview).find('.blockcart .cart-dropdown-wrapper'));
                    $('#_fixed_cart .fixed-cart-products-count').html($("#_desktop_cart .cart-products-count").html());
                    if (prestashop.page.page_name != 'cart' && prestashop.page.page_name != 'checkout' && requestData.action!='refresh') {
                        $('html').addClass('sb-open');
                        $('.sb-overlay ').fadeIn(500);
                        $('#scrolltopbtn').hide();
                    }
                } else {
                    if (resp.modal) {
                        showModal(resp.modal);
                    }
                }
            }).fail(function (resp) {
                prestashop.emit('handleError', {eventType: 'updateShoppingCart', resp: resp});
            });
        }
    );
});