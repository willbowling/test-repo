$(function() {


	$('.content .slides:first').show()
	$('.content .slides h3:first').css('margin','0 0 5px');
	$('li.icon-1 a img').attr('src','images/icon-supreme-1-on.jpg').parent().addClass('selected');
	

	/*
	var iconNum = $('supreme-nav li').getAttribute('data-icon')
	var imgOffUrl = 'images/icon-supreme-' + iconNum + 'off.jpg'
	var imgOnUrl = 'images/icon-supreme-' + iconNum + 'on.jpg'

	$('supreme-nav li a img').attr('src', imgOffUrl);
	*/

	$('li.icon-1 a').click(function (e) {
		$('li.icon-1 a img').attr('src','images/icon-supreme-1-on.jpg').parent().addClass('selected');
		$('li.icon-2 a img').attr('src','images/icon-supreme-2-off.jpg').parent().removeClass('selected');
		$('li.icon-3 a img').attr('src','images/icon-supreme-3-off.jpg').parent().removeClass('selected');
		$('li.icon-4 a img').attr('src','images/icon-supreme-4-off.jpg').parent().removeClass('selected');
		// $('li.icon-1 a img').attr('src', imgOnUrl ).parent().addClass('selected');
		// $(this).siblings('a img').attr('src', imgOffUrl ).parent().removeClass('selected');
		$('.slides').filter(':visible').hide();
		$('.slides.slide1').show();
		e.preventDefault();
	});
	$('li.icon-2 a').click(function (e) {
		$('li.icon-1 a img').attr('src','images/icon-supreme-1-off.jpg').parent().removeClass('selected');
		$('li.icon-2 a img').attr('src','images/icon-supreme-2-on.jpg').parent().addClass('selected');
		$('li.icon-3 a img').attr('src','images/icon-supreme-3-off.jpg').parent().removeClass('selected');
		$('li.icon-4 a img').attr('src','images/icon-supreme-3-off.jpg').parent().removeClass('selected');
		// $('li.icon-2 a img').attr('src', imgOnUrl ).parent().addClass('selected');
		// $(this).siblings('a img').attr('src', imgOffUrl ).parent().removeClass('selected');
		$('.slides').filter(':visible').hide();
		$('.slides.slide2').show();
		e.preventDefault();
	});
	$('li.icon-3 a').click(function (e) {
		$('li.icon-1 a img').attr('src','images/icon-supreme-1-off.jpg').parent().removeClass('selected');
		$('li.icon-2 a img').attr('src','images/icon-supreme-2-off.jpg').parent().removeClass('selected');
		$('li.icon-3 a img').attr('src','images/icon-supreme-3-on.jpg').parent().addClass('selected');
		$('li.icon-4 a img').attr('src','images/icon-supreme-4-off.jpg').parent().removeClass('selected');
		// $('li.icon-3 a img').attr('src', imgOnUrl ).parent().addClass('selected');
		// $(this).siblings('a img').attr('src', imgOffUrl ).parent().removeClass('selected');
		$('.slides').filter(':visible').hide();
		$('.slides.slide3').show();
		e.preventDefault();
	});
	$('li.icon-4 a').click(function (e) {
		$('li.icon-1 a img').attr('src','images/icon-supreme-1-off.jpg').parent().removeClass('selected');
		$('li.icon-2 a img').attr('src','images/icon-supreme-2-off.jpg').parent().removeClass('selected');
		$('li.icon-3 a img').attr('src','images/icon-supreme-3-off.jpg').parent().removeClass('selected');
		$('li.icon-4 a img').attr('src','images/icon-supreme-4-on.jpg').parent().addClass('selected');
		// $('li.icon-4 a img').attr('src', imgOnUrl ).parent().addClass('selected');
		// $(this).siblings('a img').attr('src', imgOffUrl ).parent().removeClass('selected');
		$('.slides').filter(':visible').hide();
		$('.slides.slide4').show();
		e.preventDefault();
	});




	$('.content a.next').click(function () {
		$('.content').find('.slides:eq(1)').show();
	});


});

