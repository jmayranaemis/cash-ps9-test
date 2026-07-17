

$(document).ready(function() {
	var scrollHeight = $('.fixed-menu-target').offset().top;

	$(window).on('load resize scroll', function() {
		var headerHeight = $('.header-top').outerHeight();
		if ($(window).width() >= 768 && $(window).scrollTop() > scrollHeight) {
			$('.fixed-menu-target').addClass('fixed-menu');
			$('.fixed-menu-target-container').addClass('container');
			$('.header-top').css('height', headerHeight + 'px');
		} else {
			$('.fixed-menu-target').removeClass('fixed-menu');
			$('.fixed-menu-target-container').removeClass('container');
			$('.header-top').css('height', 'auto');
		}
	});
});

