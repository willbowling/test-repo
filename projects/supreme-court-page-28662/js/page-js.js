$(function() {


	$('.content .slides:first').show()
	$('.content .slides h3:first').css('margin','0 0 5px');
	// $('li.icon-1 a img').attr('src','images/icon-supreme-1-on.jpg').parent().addClass('selected');
	

	/*
	var iconNum = $('supreme-nav li').getAttribute('data-icon')
	var imgOffUrl = 'images/icon-supreme-' + iconNum + 'off.jpg'
	var imgOnUrl = 'images/icon-supreme-' + iconNum + 'on.jpg'

	$('supreme-nav li a img').attr('src', imgOffUrl);
	*/
	

/*
	function moveSlide1 () {
		$('.supreme-nav li a.selected').addClass('icon-1-on');
		//$('.supreme-nav li a:not(.selected)').removeClass('.icon-2-on | .icon-3-on | .icon-4-on');
		$('.supreme-nav li a.icon-2-on').attr('class', 'icon-2');
		$('.supreme-nav li a.icon-3-on').attr('class', 'icon-3');
		$('.supreme-nav li a.icon-4-on').attr('class', 'icon-4');
		$('.slides').filter(':visible').hide();
		$('.slides.slide1').show();
	}

	function moveSlide2 () {
		$('.supreme-nav li a.selected').addClass('icon-2-on');
		//$('.supreme-nav li a:not(.selected)').removeClass('.icon-1-on | .icon-3-on | .icon-4-on');
		$('.supreme-nav li a.icon-1-on').attr('class', 'icon-1');
		$('.supreme-nav li a.icon-3-on').attr('class', 'icon-3');
		$('.supreme-nav li a.icon-4-on').attr('class', 'icon-4');
		$('.slides').filter(':visible').hide();
		$('.slides.slide2').show();
	}

	function moveSlide3 () {
		$('.supreme-nav li a.selected').addClass('icon-3-on');
		//$('.supreme-nav li a:not(.selected)').removeClass('.icon-1-on | .icon-2-on | .icon-4-on');
		$('.supreme-nav li a.icon-2-on').attr('class', 'icon-2');
		$('.supreme-nav li a.icon-1-on').attr('class', 'icon-1');
		$('.supreme-nav li a.icon-4-on').attr('class', 'icon-4');
		$('.slides').filter(':visible').hide();
		$('.slides.slide3').show();
	}

	function moveSlide4 () {
		$('.supreme-nav li a.selected').addClass('icon-4-on');
		//$('.supreme-nav li a:not(.selected)').removeClass('.icon-2-on | .icon-3-on | .icon-1-on');
		$('.supreme-nav li a.icon-2-on').attr('class', 'icon-2');
		$('.supreme-nav li a.icon-3-on').attr('class', 'icon-3');
		$('.supreme-nav li a.icon-1-on').attr('class', 'icon-1');
		$('.slides').filter(':visible').hide();
		$('.slides.slide4').show();
	}
*/



	// var slideNum = 0

	function moveSlide (slideNum) {
		$('.supreme-nav li a').removeClass('on');
		$('.supreme-nav li a')[slideNum + 1].addClass('on');
		$('.slides').filter(':visible').hide();
		$('.slides')[slideNum + 1].show();
	}


	$('.supreme-nav li a').bind('click', function (e) {

		//console.log($('.supreme-nav li a').index(this));

		moveSlide($('.supreme-nav li a').index(this));

/*
		if ($(this).hasClass('selected')) {
			return false;
			// do nothing
		} else if (($(this).is('.icon-1'))) {
			$('.supreme-nav li a.selected').removeClass('selected');
			$(this).addClass('selected');
			moveSlide1();
		} else if (($(this).is('.icon-2'))) {
			$('.supreme-nav li a.selected').removeClass('selected');
			$(this).addClass('selected');
			moveSlide2();
		} else if (($(this).is('.icon-3'))) {
			$('.supreme-nav li a.selected').removeClass('selected');
			$(this).addClass('selected');
			moveSlide3();
		} else if (($(this).is('.icon-4'))) {
			$('.supreme-nav li a.selected').removeClass('selected');
			$(this).addClass('selected');
			moveSlide4();
		} else {
			return false;
		}
*/

		// $('.supreme-nav li a.selected').toggleClass('selected');
		// moveSlide1();
		e.preventDefault();
	});
/*
	$('li a.icon-2 ').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide2();
		e.preventDefault();
	});
	$('li a.icon-3').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide3();
		e.preventDefault();
	});
	$('li a.icon-4').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide4();
		e.preventDefault();
	});
*/


/*
	$('li a.icon-1').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide1();
		e.preventDefault();
	});
	$('li a.icon-2 ').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide2();
		e.preventDefault();
	});
	$('li a.icon-3').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide3();
		e.preventDefault();
	});
	$('li a.icon-4').click(function (e) {
		$('.supreme-nav li a.selected').toggleClass('selected');
		moveSlide4();
		e.preventDefault();
	});


	function navIncrement () {
		if ($('.slides').filter(':visible').is('.slide1')) {
			console.log('its slide one!');

		};
	}

*/
	
	
	$('.content a.prev').hide();
	$('.supreme-nav li a.icon-1').addClass('icon-1-on selected');


	
	$('.content').delegate('a.next', 'click', function (e) {
	//$('.content a.next').click(function (e) {
		$('.content a.prev').show();

		$('.slides').filter(':visible').hide().next().show();
		if ($('.slides:last').is(':visible')) {
			$('.content a.next').hide();
		}


	/* 

        if (currentSlide + 1 <= $('slides').length) {
        	currentSlide = currentSlide ++
        }

        $('.slides').hide();
        $('.slides:eq(' + currentSlide + ')').show();

		if (currentImgSrc + 1 <= $('.supreme-nav li a img').length) {
        	currentImgSrc = currentImgSrc ++
        }

        // $('.supreme-nav li a img').attr('src', 'images/icon-supreme-'+ currentImgSrc +'-off.jpg');
        $('.supreme-nav li a img:eq(' + currentImgSrc + ')').attr('src', 'images/icon-supreme-'+ currentImgSrc +'-on.jpg');


		$('.content a.prev').show();

		if ($('.slides:last').is(':visible')) {
			$('.content a.next').hide();
		}
	*/




		// var $navIcon = $(this).parent().parent().find('.supreme-nav li a');
       
        // $('.slides').filter(':visible').hide().next().show();
		/* 

		if ($('.slides:last').is(':visible')) {
			$('.content a.next').hide();
		}
		if ($navIcon.hasClass('selected')) {
			$navIcon.removeClass('selected').parent().next().find('a img[src$="off.jpg"]').filter(':first').parent().addClass('selected');
		}

		console.log(navIconOn)

		// $navIcon.find('img').attr('src', navIconOn);

		*/


		e.preventDefault();
	});

	$('.content a.prev').click(function (e) {
		$('.slides').filter(':visible').hide().prev().show();
		if ($('.slides:first').is(':visible')) {
			$('.content a.prev').hide();
		}
		e.preventDefault();
	});


});

