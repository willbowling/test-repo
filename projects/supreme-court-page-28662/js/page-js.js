$(function() {

	$('li a.icon-1','.supreme-nav').addClass('on selected');
	$('.slides:first','.content').show()
	$('.slides h3:first','.content').css('margin','0 0 5px');
	$('.content a.prev').show();
	$('.content a.next').show();


	var currentSlideNav = $('li a.on','.supreme-nav')

	function hideNav () {
		if ($('.slides:last').is(':visible')) {
			$('a.next', '.content').hide();
		} else if ($('.slides:first').is(':visible')) {
			$('a.prev', '.content').hide();
		} else {
			$('.content a.prev').show();
			$('.content a.next').show();
		}
	}


	// The top nav navigation
	$('li a.icon-1','.supreme-nav').click(function (e) {
		$('.supreme-nav li a').removeClass('on selected');
		$('.slides').hide();
		$(this).addClass('on selected');
		$('.slides.slide1').show();
		hideNav();
		$('.content a.next').show();
		e.preventDefault();
	});

	$('li a.icon-2','.supreme-nav').click(function (e) {
		$('.supreme-nav li a').removeClass('on selected');
		$('.slides').hide();
		$(this).addClass('on selected');
		$('.slides.slide2').show();
		hideNav();
		e.preventDefault();
	});

	$('li a.icon-3','.supreme-nav').click(function (e) {
		$('.supreme-nav li a').removeClass('on selected');
		$('.slides').hide();
		$(this).addClass('on selected');
		$('.slides.slide3').show();
		hideNav();
		e.preventDefault();
	});

	$('li a.icon-4','.supreme-nav').click(function (e) {
		$('.supreme-nav li a').removeClass('on selected');
		$('.slides').hide();
		$(this).addClass('on selected');
		$('.slides.slide4').show();
		hideNav();
		$('.content a.prev').show();
		e.preventDefault();
	});


	// The ARROW navigation Next
	$('a.next', '.content').bind('click', function (e) {
		$('.slides', '.content').filter(':visible').hide().next().show();
		$('.supreme-nav li a.selected').parent().next().find('a').addClass('on').addClass('selected');
		$('.supreme-nav li a.selected').parent().prev().find('a').removeClass('on').removeClass('selected');
		hideNav();
		e.preventDefault();
	});

	// The ARROW navigation Previous
	$('a.prev', '.content').bind('click', function (e) {
		$('.slides', '.content').filter(':visible').hide().prev().show();
		$('.supreme-nav li a.selected').parent().prev().find('a').addClass('on').addClass('selected');
		$('.supreme-nav li a.selected').parent().next().find('a').removeClass('on').removeClass('selected');
		hideNav();
		e.preventDefault();
	});


});

