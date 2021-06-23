/* *******************************************************
 * filename : sub.js
 * description : 서브컨텐츠에만 사용되는 JS
 * date : 2019-09-03
******************************************************** */

jQuery(function($){
	/* *********************** 서브 비주얼 Active ************************ */
	setTimeout(function  () {
		$("#visual").addClass("active");
	});


	/* *********************** 서브 사이드바 FIXED ************************ */
	$.exists = function(selector) {
        return ($(selector).length > 0);
    }

	// All Funtions
	sidebarFixed();
	sidebarFixedMobile();

	function sidebarFixed () {
		if ($.exists('.sidemenu-fixed')) {
			var startScroll = $("#sideMenu").offset().top;
			
			$(window).scroll(function  () {
				var scrollTop = $(window).scrollTop();
				
				if ( scrollTop < startScroll - 50 ) {
					$("#sideMenu").removeClass("fixed");
				}else{
					$("#sideMenu").addClass("fixed");
				}
			 
				var menuCount=$(".remote-tab-list .remote-inner li").size();
				var nav= new Array();
				for(var i=0;i < menuCount;i++){
					nav[i]="nav"+i;
					nav[i]=$($(".remote-tab-list .remote-inner li").eq(i).find("a").attr("href")).offset().top - 110;
				}
				 
				$(".remote-tab-list li").each(function  (idx) {
					if( scrollTop >= nav[idx] ){
						$('.remote-tab-list .remote-inner li').removeClass('on');
						$('.remote-tab-list .remote-inner li').eq(idx).addClass('on');
					};
				});
			});

			$(".remote-tab-list .remote-inner li a").click(function  () {
				var fixedHeight = $(".remote-tab-list.fixed").outerHeight() + 10;
				var goDiv = $($(this).attr("href")).offset().top - fixedHeight;

				$("html, body").animate({scrollTop:goDiv},300,"swing");
				 
				return false;
			});
		}
	}

	function sidebarFixedMobile () {
		if ($.exists('.sidemenu-fixed')) {
			var $fixedSubMenu = $("#topMenuM02");
			var topMenuStart =  $fixedSubMenu.offset().top - $("#header").height();
			
			$(window).scroll(function  () {
				var scrollHeight = $(window).scrollTop();
				
				if ( scrollHeight > topMenuStart ) {
					$fixedSubMenu.addClass("fixed");
				}else {
					$fixedSubMenu.removeClass("fixed");
				}
			 
				var mmenuCount=$("#topMenuM02 li").size();
				var mnav= new Array();
				for(var i=0;i < mmenuCount;i++){
					mnav[i]="nav"+i;
					mnav[i]=$($("#topMenuM02 li").eq(i).find("a").attr("href")).offset().top - 150;
				}
				 
				$("#topMenuM02 li").each(function  (idx) {
					if( scrollHeight >= mnav[idx] ){
						$('#topMenuM02 li').removeClass('on');
						$('#topMenuM02 li').eq(idx).addClass('on');
						$(".cur-location span").text($(".location-menu-con li").eq(idx).find("span").text());
						// console.log($("#topMenuM02 li").eq(idx).find("span").text());
					};
				});
			});
			$("#topMenuM02 li a").click(function  () {
				var mgoDiv = $($(this).attr("href")).offset().top - 149;
				$("html, body").animate({scrollTop:mgoDiv},300,"swing");
		
				$(".cur-location").removeClass("open");
				$(".location-menu-con").hide();
				 
				return false;
			});

		}
	}
	


	/* *********************** 연구소소개 슬라이드 ************************ */




	var numSlick = 0;
	$('.laboratory-for').each( function() {
	  numSlick++;
	  $(this).addClass( 'slider-' + numSlick ).slick({
		 slidesToShow: 1,
		 slidesToScroll: 1,
		 arrows: true,
		 dots:false,
		 fade: true,
	     autoplay:true,
	     autoplaySpeed:2500,
		 prevArrow: '<button type="button" data-role="none" class="slick-prev font-godo" aria-label="Prev" tabindex="0" role="button"><</button>',
		 nextArrow: '<button type="button" data-role="none" class="slick-next font-godo" aria-label="Next" tabindex="0" role="button">></button>',
		asNavFor: '.laboratory-nav.slider-' + numSlick
	  });
	});

	numSlick = 0;
	$('.laboratory-nav').each( function() {
	  numSlick++;
	  $(this).addClass( 'slider-' + numSlick ).slick({
		slidesToShow: 6,
		slidesToScroll: 1,
		asNavFor: '.laboratory-for',
		dots: false,
		arrows:true,
		prevArrow: '<button type="button" data-role="none" class="slick-prev font-godo" aria-label="Prev" tabindex="0" role="button"><</button>',
		nextArrow: '<button type="button" data-role="none" class="slick-next font-godo" aria-label="Next" tabindex="0" role="button">></button>',
		focusOnSelect: true,
		asNavFor: '.laboratory-for.slider-' + numSlick,
		 responsive: [
			{
			  breakpoint: 800,
			  settings: {
				slidesToShow: 4,
			  }
			},
			{
			  breakpoint: 480,
			  settings: {
				slidesToShow: 3,
			  }
			}
		  ]
	  });
	});


	$('.coorper-slide').slick({
	  dots: false,
	  arrows:true,
	  infinite: true,
	  speed: 1500,
	  autoplay:true,
	  autoplaySpeed:2800,
	  slidesToShow: 5,
	  slidesToScroll: 5,
	  prevArrow: '<button type="button" data-role="none" class="slick-prev font-godo" aria-label="Prev" tabindex="0" role="button"><</button>',
	  nextArrow: '<button type="button" data-role="none" class="slick-next font-godo" aria-label="Next" tabindex="0" role="button">></button>',
	  responsive: [
		{
		  breakpoint: 800,
		  settings: {
			slidesToShow: 3,
			slidesToScroll: 3,
		  }
		},
		{
		  breakpoint: 480,
		  settings: {
			slidesToShow: 2,
			slidesToScroll: 2,
		  }
		}
	  ]
	});

});
