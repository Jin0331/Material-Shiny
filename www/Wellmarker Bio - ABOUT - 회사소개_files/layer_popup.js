/* *******************************************************
 * filename : layer_popup.js
 * description : 모달레이어를 띄울때 사용되는 ajax JS
 * date : 2017-05-30
******************************************************** */


function layerLoad(strUrl){
	var $modalWrap = $(".modal-fixed-pop-wrapper");

	$("html").css({
		"margin-right":"17px",
		"overflow-y":"hidden"
	});
	$modalWrap.fadeIn();
	
	$.ajax({
		type: "POST",
		url: strUrl,
		data: "",
		success: function(resultText){
			$modalWrap.find(".modal-inner-content").html(resultText);
		},
		error: function() {
			alert("호출에 실패했습니다.");
			$(".modal-fixed-pop-wrapper").hide();
			$("html").css({
				"margin-right":"0",
				"overflow-y":"scroll"
			});
		},
		beforeSend:function(){ 
			$('.modal-loading').fadeIn(); 
		},
		complete:function(){ 
			$('.modal-loading').hide();
		}
	});
}
$(document).ready(function  () {
	var $modalWrap = $(".modal-fixed-pop-wrapper");
	$(".modal-close-btn").click(function  () {
		$(".modal-inner-content").empty();
		$modalWrap.css("display","none");
		$("html").css({
			"margin-right":"0",
			"overflow-y":"scroll"
		});
		$modalWrap.fadeOut();
		return false;
	});
});