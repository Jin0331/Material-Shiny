/* *******************************************************
 * filename : common.js
 * description : 전체적으로 사용되는 JS
 * date : 2018-03-02
******************************************************** */


function detectBrowser() {
	var word;
	var versionOrType = "another";
	var ieName = navigator.appName;
	var agent = navigator.userAgent.toLowerCase(); 
	
	/*** 1. IE 버전 체크 ***/ 
	// IE old version ( IE 10 or Lower ) 
	if ( ieName == "Microsoft Internet Explorer" ){ 
		word = "msie "; 
	}else{ 
		// IE 11 
		if( agent.search("trident") > -1 ) word = "trident/.*rv:"; 
		// IE 12 ( Microsoft Edge ) 
		else if( agent.search("edge/") > -1 ) word = "edge/"; 
	} 
	
	var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" ); 
	if ( reg.exec( agent ) != null ) 
	versionOrType = RegExp.$1 + RegExp.$2;
	
	/*** 2. IE가 아닌 경우 브라우저 체크 ***/ 
	if( versionOrType == "another" ){ 
		if (agent.indexOf("chrome") != -1) versionOrType = "Chrome"; 
		else if (agent.indexOf("opera") != -1) versionOrType = "Opera"; 
		else if (agent.indexOf("firefox") != -1) versionOrType = "Firefox"; 
		else if (agent.indexOf("safari") != -1) versionOrType = "Safari"; 
		else if (agent.indexOf("mozilla/5.0") != -1) versionOrType = "Mozilla"; 
	} 
	
	return versionOrType; 
};

jQuery(function($){
	
	// 임의의 영역을 만들어 스크롤바 크기 측정
	function getScrollBarWidth(){
		if($(document).height() > $(window).height()){
			$('body').append('<div id="fakescrollbar" style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"></div>');
			fakeScrollBar = $('#fakescrollbar');
			fakeScrollBar.append('<div style="height:100px;">&nbsp;</div>');
			var w1 = fakeScrollBar.find('div').innerWidth();
			fakeScrollBar.css('overflow-y', 'scroll');
			var w2 = $('#fakescrollbar').find('div').html('html is required to init new width.').innerWidth();
			fakeScrollBar.remove();
			return (w1-w2);
		}
		return 0;
	}

	/* *********************** 헤더 FIXED ************************ */
	$(window).scroll(function  () {
		var scrollHeight = $(window).scrollTop();
		var startTop = $("#header").height();
		if ( scrollHeight > startTop ) {
			$("#header").addClass("fixed");
		}else {
			$("#header").removeClass("fixed");
		}
	});

	/* *********************** 상단 언어 목록 ************************ */
	$(".header-lang").click(function  () {
		$(this).toggleClass("open");
	}).mouseleave(function  () {
		$(this).removeClass("open");
	});

	/* *********************** 상단 검색 toggle ************************ */
	$(".header-search-box").each(function  () {
		var $searchBox = $(this);
		var $openBtn = $(this).find(".header-search-open-btn");
		var $closeBtn = $(this).find(".header-search-close-btn");
		
		$openBtn.click(function  () {
			$searchBox.addClass("open");
		});
		$closeBtn.click(function  () {
			$searchBox.removeClass("open");
		});
	});

	/* *********************** top버튼 ************************ */
	$(".to-top-btn").each(function  () {
		// top버튼 나오게 (필요한 경우에만 넣으세요)
		if ( $(this).length > 0 ) {
			$(window).scroll(function  () {
				if ( $(window).scrollTop() > 0 ) {
					$(".to-top-btn").addClass("fixed");
				}else {
					$(".to-top-btn").removeClass("fixed");
				}
			});
		}
		// top버튼 클릭
		$(this).on("click",function  () {
			$("html, body").animate({scrollTop:0},600,"easeInOutExpo");	// easing 효과 사용하기위해서는 jquery.easing.1.3.js이 필요함, 없을 시 기본 "swing"
			return false;
		});
	});

	
	
	/* *********************** 패밀리사이트 ************************ */
	$(".family-site-box").each(function  () {
		var $familyBox = $(this);
		var $familyListOpenBtn = $(this).children(".family-site-open-btn");
		var $familyList = $(this).children(".family-site-list");
		$familyListOpenBtn.click(function  () {
			$familyList.slideToggle(500);
			$familyBox.toggleClass("open");
			return false;
		});
		$(this).mouseleave(function  () {
			$familyList.slideUp(500);
			$familyBox.removeClass("open");
		});
	});

	/* *********************** 탭 공통 ************************ */
	$(".cm-tab-container").each(function  () {
		var $cmTabList = $(this).children(".cm-tab-list");
		var $cmTabListli = $cmTabList.find("li");
		var $cmConWrapper = $(this).children(".cm-tab-content-wrapper");
		var $cmContent = $cmConWrapper.children(".cm-tab-con");
		
		
		// 탭 영역 숨기고 selected 클래스가 있는 영역만 보이게
		var $selectCon = $cmTabList.find("li.selected").find("a").attr("href");
		$cmContent.hide().removeClass("on");
		$($selectCon).show().addClass("on");

		$cmTabListli.children("a").click(function  () {
			if ( !$(this).parent().hasClass("selected")) {
				var visibleCon = $(this).attr("href");
				$cmTabListli.removeClass("selected");
				$(this).parent("li").addClass("selected");
				$cmContent.hide().removeClass("on");
				$(visibleCon).fadeIn().addClass("on");
			}
			return false;
		});
	});

	/* *********************** 스크롤 터치시 커버 사라지게 ************************ */
	$(".custom-scrollbar-wrapper").on("touchmove click",function  () {
		$(this).find(".custom-scrollbar-cover").fadeOut(200);
	});

	/* *********************** 에디터 테이블 스크롤넣기 ************************ */
	$(".editor table").each(function  () {
		$(this).wrap("<div class='editor-table-box'></div>");
	});
	

	
	/* *********************** 브라우저 타입 넣기 ************************ */
	if ( $.isNumeric(detectBrowser())) {
		$("body").addClass("ie-browser");
	}

	/* *********************** 하단 :: 모달영역 붙이기 ************************ */
	$("body").append(" <article class='modal-fixed-pop-wrapper'><div class='modal-fixed-pop-inner'><div class='modal-loading'><span class='loading'></span></div><div class='modal-inner-box'><div class='modal-inner-content'></div></div></div></article>");

});
/* *********************** 동영상 자동재생 ************************ */
$(window).load(function  () {
	if ( $("#mainVisualVideo").length > 0 ) {
		$("#mainVisualVideo").get(0).play();
	}
});

/* *********************** 드래그/우클릭방지 ************************ */
/*  $(document).ready(function(){
	$(document).bind("contextmenu", function(e) {

		return false;

	});
});

$(document)[0].oncontextmenu = function() { return false; }

$(document).mousedown(function(e) {

	if( e.button == 2 ) {

			//alert('내용을 복사할 수 없습니다.');

			return false;

	} else {

			return true;

	}

}); */