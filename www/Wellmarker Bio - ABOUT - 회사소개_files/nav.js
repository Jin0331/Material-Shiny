/* *******************************************************
 * filename : nav.js
 * description : 네비게이션 및 사이드바 on 등 메뉴에 관련된 JS
 * date : 2018-01-16
******************************************************** */

var dep1;
var dep2;

jQuery(function($){
	/* *********************** PC NAV ************************ */
	var $openMenu = $(".cm-top-menu");
	// PC
	var $gnb = $("#gnb");
	var $gnbList = $("#gnb > ul");
	var $gnb_dep1 = $("#gnb > ul > li");
	var $gnb_dep2 = $("#gnb > ul > li .gnb-2dep");
	var $gnbBg = $('.gnb-overlay-bg');
	var $snb = $(".snb");
	// 모바일
	var $menuBtn = $("#header .nav-open-btn");
	var $gnbM = $("#gnbM");
	var $gnbMList = $gnbM.find("#navigation").children("li");
	var $gnbMBg = $('.gnb-overlay-bg-m');
	var menuState = false;
	
	// 모바일 gnb열린 후 창 크게했을때 스크롤바 생성
	$(window).resize(function  () {
		var win_width = $(window).outerWidth(); 
		if ( menuState  ) {
			if ( win_width > 1200 ) {
				$("body").css({'height':'auto', 'overflow':'auto'});
			}
		}
	});

	if ( $gnb.is(".total-menu") ) {
		gnb_total_on();
	}else if ( $gnb.is(".each-menu") ) {
		gnb_each_on();
	}

	// gnb 전체메뉴
	function gnb_total_on () {
		$gnbList.children("li").children("a").on("mouseenter focus",function  () {
			if( $gnb_dep2.css('display') == 'none'){
				$("#header").addClass("over");		/* 헤더배경 흰색으로 변경될 경우에만 */
				$gnb_dep2.stop().slideDown("fast");
				$gnb.find('#gnbBg').stop().slideDown("fast");
				$gnbBg.stop().fadeIn();
			}
		})
	
		$gnbList.on("mouseleave",gnb_return);
		$gnbList.find("a").last().on("focusout",gnb_return);
		
		function gnb_return () {
			if( $gnb_dep2.css('display') == 'block'){
				$("#header").removeClass("over");	/* 헤더배경 흰색으로 변경될 경우에만 */
				$gnb_dep2.stop().slideUp("fast");
				$gnb.find('#gnbBg').stop().slideUp("fast");
				$gnbBg.hide();
			}
			if ( dep1 > 0 && dep2 ) {
				$gnbList.children("li").eq(dep1-1).addClass("active");
			}
		}
	}

	// gnb 각각메뉴
	function gnb_each_on () {
		$gnbList.children("li").children("a").on("mouseenter focus",function  () {
			$gnbList.children("li").removeClass("on").children(".gnb-2dep").removeClass("open"); //.hide();
			$(this).parent("li").addClass("on").children(".gnb-2dep").stop().addClass("open"); //.slideDown(500);
		})

		
		$gnbList.children("li").on("mouseleave",gnb_return);
		$gnbList.find("a").last().on("focusout",gnb_return);
		
		function gnb_return () {
			// if (!$gnb.find('*').is(':animated')) {
				$gnbList.children("li").removeClass("on").children(".gnb-2dep").removeClass("open"); //.hide();
			// }
			if ( dep1 > 0 && dep2 ) {
				$gnbList.children("li").eq(dep1-1).addClass("active");
			}
		}
	}
	
	// gnb 2차 메뉴에 마우스 올렸을때 대메뉴 on
	$gnb_dep2.hover(function(){
		$(this).parent("li").addClass("on");
	},function  () {
		$gnb_dep1.removeClass("on");
	});

	// 서브메뉴에서 해당메뉴 on
	if ( dep1 > 0 && dep2 > 0) {
		$gnbList.children("li").eq(dep1-1).addClass("active");
		$gnbMList.eq(dep1-1).addClass("on");
		$snb.each(function  () {
			$(this).find("li").eq(dep2-1).addClass("on");
		});
	}
	
	/* *********************** MOBILE NAV ************************ */
	$menuBtn.click(function  () {
		if ( menuState ) {
			menuClose();
			menuState = false;
			$(this).removeClass("active");
		}else {
			menuOpen();
			menuState = true;
			$(this).addClass("active");
		}
		return false;
	});

	$gnbMBg.click(function  () {
		menuClose();
		menuState = false;
		$menuBtn.removeClass("active");
	});

	/* 메뉴열기 */ 
	function menuOpen () {
		$gnbM.addClass("open");
		$gnbMBg.fadeIn();
		$("body").css({'height':$(window).height(), 'overflow':'hidden'});
	}
	/* 메뉴닫기 */ 
	function menuClose () {
		$gnbM.removeClass("open");
		$gnbMBg.hide();
		$("body").css({'height':'auto', 'overflow':'auto'});
	}
	
	/* GNB MOBILE 2DEPTH 클래스 붙이기  */ 
	$("#navigation > li:has('.gnb-2dep')").addClass("has-2dep");
	$("#navigation > li:has('.gnb-2dep')").each(function  () {
		$(this).children("a").append("<span class='gnb-icon close-icon'><i class='material-icons'>&#xE145;</i></span><span class='gnb-icon open-icon' style='display:none;'><i class='material-icons'>&#xE15B;</i></span>");
	});

	/* GNB MOBILE 2DEPTH 오픈 */ 
	$("#navigation > li:has('.gnb-2dep')").children("a").click(function(event){
		/* 2dep가 열려있을때 */		
		if ( $(this).parent("li").hasClass("active") ){
			$(this).parent("li").removeClass("active");
			$(this).children(".open-icon").hide();
			$(this).children(".close-icon").show();
			$(this).siblings(".gnb-2dep").slideUp(400);					
		}
		/* 2dep가 닫혀있을때 */ 
		else{	  
			$("#navigation > li").has(".gnb-2dep").each(function() {
				if ( $(this).hasClass("active") ){
					$(this).removeClass("active");
					$(this).find(".open-icon").hide();
					$(this).find(".close-icon").show();
					$(this).children(".gnb-2dep").slideUp(400);
				}
			});	
			$(this).parent("li").addClass("active");
			$(this).children(".close-icon").hide();
			$(this).children(".open-icon").show();
			$(this).siblings(".gnb-2dep").slideDown(400);
		}
		return false;
	});
	
	/* 해당페이지의 GNB 모바일 2depth 열기 & ON  */
	if ( dep1> 0 && dep2> 0 ) {
		$("#navigation > li").eq(dep1-1).addClass("active").children(".gnb-2dep").show().children("li").eq(dep2-1).addClass("on");
		$("#navigation > li").eq(dep1-1).find(".close-icon").hide();
		$("#navigation > li").eq(dep1-1).find(".open-icon").show(); // 모바일 네비 on
	}
	
	
	/* *********************** Full Navgation ************************ */
	/* 회원메뉴가 있는 full style  메뉴 */ 
	if ( ( $(".gnb-style-full").length > 0 ) && ( $(".member-menu-box").length > 0 ) ) {
		$(".gnb-style-full").addClass("gnb-style-full-member");
	}

	/* *********************** PC, 모바일 공통 ************************ */
	/* ------------------------
	*** 서브 상단 location (1차, 2차) 하위메뉴 ON & 열기 *** 
	------------------------ */ 
	$openMenu.find(".menu-location").each(function  () {
		// 클릭할때 펼치기
		$(this).find(".cur-location").click(function  () {
			$(this).toggleClass("open");
			$(this).siblings(".location-menu-con").slideToggle();

			return false;
		});
		// 2depth ON
		if ( $(this).is(".location1") ) {
			$(this).find(".location-menu-con").find("li").eq(dep1-1).addClass("on");
		}else {
			$(this).find(".location-menu-con").find("li").eq(dep2-1).addClass("on");
		}
	});
	
	$(".menu-location").mouseleave(function  () {
		if ( $(this).find(".location-menu-con").css("display") == "block" ) {
			$(this).find(".cur-location").removeClass("open");
			$(this).find(".location-menu-con").slideUp(300);
		}
	});

	/* ------------------------
	*** 이전페이지,다음페이지 링크걸기 *** 
	------------------------ */ 
	/*  (무조건 페이지의 dep1, dep2의 값을 가져와야함) */
	// 2depth 이동
	var $sub_prev_page_btn = $(".sub-prev-page-btn");
	var $sub_next_page_btn = $(".sub-next-page-btn");
	var $dep1_menu = $("#gnb > ul > li");
	var dep1_menu_lang = $dep1_menu.length;

	$sub_prev_page_btn.attr("href",$dep1_menu.eq(dep1-2).children("a").attr("href"));
	$sub_next_page_btn.attr("href",$dep1_menu.eq(dep1).children("a").attr("href"));

	$sub_prev_page_btn.find(".sub-page-name").text($dep1_menu.eq(dep1-2).children("a").text());
	$sub_next_page_btn.find(".sub-page-name").text($dep1_menu.eq(dep1).children("a").text());
	


	if ( dep1 == dep1_menu_lang ) {
		$sub_next_page_btn.attr("href",$dep1_menu.eq(0).children("a").attr("href"));
		$sub_next_page_btn.find(".sub-page-name").text($dep1_menu.eq(0).children("a").text());
	}else if ( dep1 == 1 ) {
		$sub_prev_page_btn.attr("href",$dep1_menu.eq(dep1_menu_lang-1).children("a").attr("href"));
		$sub_prev_page_btn.find(".sub-page-name").text($dep1_menu.eq(dep1_menu_lang-1).children("a").text());
	}
	
});
