$(document).ready(function () {
	//----------------------------------
	//실행 오브젝트 목록
	//----------------------------------

	App.VisualCommon.init();

	//메인 비주얼
	if ($(document).find('.main-visual-box').length > 0) {
		var mainVi = new App.CarouselModule();
		mainVi.init({
			name: '.main-visual-box',
			carouselOption: {
				nav: false,
				dots: true,
				loop: true,
				items: 1
			}
		});
	}

	if($(document).find('.main-visual-img-box').length > 0){	
		var mainViImg = new App.ObjectFit();
		mainViImg.init(".main-visual-img-box");
	}

	// 메인 배너
	if ($(document).find('.main-banner').length > 0) {
		var mainbanner = new App.CarouselModule();
		mainbanner.init({
			name: '.main-banner',
			carouselOption: {
				nav: false,
				dots: false,
				autoplay: true,
				responsive: {
					0: {
						loop:true,
						items:2,					
						margin: 10
					},
					769: {
						loop:true,
						items:3,					
						margin: 10
					},
					1025: {
						loop:true,
						items:2,
						margin: 15
					}
				}
			}
		});
	}

});


//-----------------------------------------------------------------------------------------
//Visual Common
//-----------------------------------------------------------------------------------------
App.VisualCommon = function(){
	var self;
	var titNum, conNum//메인컨텐츠01 탭
	return {
		init: function(){
			self = this;

			// main content02 미니보드 탭
			$('.mini-board-tab').on('click', function () {
				$(this).parent().siblings().removeClass('active');
				$(this).parent().addClass('active');
			});

		}
	}
}();