$(document).ready(function () {

	//=========================
	//실행 오브젝트
	//=========================

	//검색영역 셀렉트박스
	App.BoardSelectBox.init();

	//모바일 셀렉트박스
	App.MoSelBox.init();

	//캘린더
	if($(document).find('#calendar').length > 0){
		App.boardCalendar.init();
	}
	
	// FAQ 리스트
	App.BoardFaqTab.init();

	// 일반게시판 전시관 유형 리스트 object-fit : IE대응
	if($('.bn-list-common01.type01 .b-img-box').length > 0){
		var bnCommonImg = new App.BoardObjectFit();
		bnCommonImg.init('.bn-list-common01.type01 .b-img-box');
	}
	
	// 이미지 게시판 리스트 object-fit : IE대응
	if($('.bn-list-img01.type01 .b-box01 .b-img-box a').length > 0){
		var bnImg = new App.BoardObjectFit();
		bnImg.init('.bn-list-img01.type01 .b-box01 .b-img-box a');
	}

});

//======================================================================
//Mobile Select Box
//======================================================================
App.MoSelBox = function () {
	var self;
	var select, mcenter;
	return {
		init: function () {
			self = this;

			//모바일 셀렉트 박스(선택시 label text 변경)
			select = $('.b-tab-sel');
			mcenter = $('.b-m-tab-box > label');
			$(".b-m-tab-box").click(function(){
				$(this).toggleClass('active');
				select.change(function(){
					var select_name = $(this).children('option:selected').text();
					$(this).siblings('label').text(select_name);            
				});
			});
		}
	}
}();

//===================================================
//BoardSelectBox
//===================================================
App.BoardSelectBox = function () {
	var self;
	var $box;
	return {
		init: function () {
			self = this;
			$box = $(".b-sel-box");

			$box.each(function () {
				var $thisBox = $(this);
				$thisBox.click(self.onClick);

				$(document).mouseup(function (e) {
					if ($thisBox.has(e.target).length === 0) {
						$thisBox.removeClass("close");
					}
				});
			});

		},
		onClick: function () {
			if ($(this).find("ul").is(":hidden")) {
				$(this).addClass("close");
			} else if ($(this).find("ul").is(":visible")) {
				$(this).removeClass("close");
			}

			$(this).mouseleave(function () {
				$(this).removeClass("close");
			});
		}
	}
}();

//------------------------------------------------------
//board calendar
//------------------------------------------------------  

App.boardCalendar = function(){
	var self;
	return {
		init: function(){
			self = this;
			if($(window).width() <= 768){
				$(".b-calendar-main-wrap").click(self.onClickOpen);
				$(".b-calendar-m-close").click(self.onClickClose);
			}else{
				$(".b-calendar-sub-wrap").show();
			}
			$(window).resize(function(){
				if($(window).width() <= 768){
					$(".b-calendar-main-wrap").click(self.onClickOpen);
					$(".b-calendar-m-close").click(self.onClickClose);
				}else{
					$(".b-calendar-sub-wrap").show();
				}
			});
			$(".specificBtn").click(self.specificDay);
		},
		onClickOpen: function(){
			$(".b-calendar-sub-wrap").fadeIn();
			$("body").css({overflowY: "hidden"});
		},
		onClickClose: function(){
			$(".b-calendar-sub-wrap").fadeOut();
			$("body").css({overflowY: "auto"});
		},
		specificDay: function(){
			$(".b-calendar-specific").slideToggle();
		}
	}
}();

//------------------------------------------------------
//FAQ-list
//------------------------------------------------------ 
App.BoardFaqTab = function(){
	var self;
	var $item, $dest, $dv;
	return {
		init: function(){
			self = this;

			$(".bn-list-faq01 .b-title-box").find("a").click(self.onClick); 

		},
		onClick: function(){
			$item = $(this).parents(".b-quest-box");
			
			if ($item.next(".b-ans-box").is(":hidden")) {
				$(".bn-list-faq01").find(".b-ans-box").hide();
				$item.next(".b-ans-box").show();
				$(".b-quest-box").removeClass("active");
				$item.addClass("active");
			} else if ($item.next(".b-ans-box").is(":visible")) {
				$item.next(".b-ans-box").hide();
				$item.removeClass("active");
			}

		}
	}
}();

//------------------------------------------------------
//object-fit(IE)
//------------------------------------------------------  
App.BoardObjectFit = function () {
	var self;
	return {
		init: function (param) {
			if ('objectFit' in document.documentElement.style === false) {
				var container = document.querySelectorAll(param);
				for (var i = 0; i < container.length; i++) {
					var imageSource = container[i].querySelector('img').src;
					container[i].querySelector('img').style.display = 'none';
					container[i].style.backgroundSize = 'cover';
					container[i].style.backgroundImage = 'url(' + imageSource + ')';
					container[i].style.backgroundPosition = '50% 0';
				}
			}
		}
	}
};