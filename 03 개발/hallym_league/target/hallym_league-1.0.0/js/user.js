$(document).ready(function () {

	setTimeout(function () {
		$("html").removeClass("no-js");
	}, 10);

	App.Common.init();  
	App.SelectBox2.init();
	
	//----------------------------------
    //GNB 실행
    //----------------------------------
    if ($(document).has('.gnb').length > 0) {
        App.MainGnb.init();
        $(window).resize(function () {
            App.MainGnb.init();
        });
    }
	
	if($(document).find('.lnb').length > 0){
		App.LnbSlide.init();
	}
	
	App.SelectBoxMenu.init();
	App.TableScroll.init();
	
	/* GNB autoList */
	var timer02 = null;
	var timer02 = 30;

	autoListOpt02();

	function autoListOpt02() {
		var autoListObj = new App.autoList();

		autoListObj.init({
			list: ".footer-link",
			endWidth: "center"
		});
	}

	$(window).on('resize', function () {
		clearTimeout(timer02);
		timer02 = setTimeout(autoListOpt02, timer02);
	});	

	/* 푸터 상단 autoList */
	var timer = null;
	var delta = 30;

	autoListOpt();

	function autoListOpt() {
		var autoListObj = new App.autoList();

		autoListObj.init({
			list: ".gnb-ul",
			endWidth: "center"
		});
	}

	$(window).on('resize', function () {
		clearTimeout(timer);
		timer = setTimeout(autoListOpt, delta);
	});


});

//-----------------------------------------------------------------------------------------
//common
//-----------------------------------------------------------------------------------------
App.Common = function () {
	var self;
	return {
		init: function () {
			
			//사이트맵
			$(".sitemap-btn").click(function(){
				$(".sitemap-wrap").show();
				$('html, body').css('overflow', 'hidden');
				$(".slideMenu").animate({
					right: "-100%"
				}, 300);
				$(".slideMenu").hide(500);
				$(".m-gnb-bg").hide();
				$(".slide-close").hide();
			});
			$(".sitemap-close").click(function(){
				$(".sitemap-wrap").hide();
				$('html, body').css('overflow', '');
			});

			//메뉴 연동 select box - selected 처리
			$(".tab-sel").find("option[value='" + window.location.pathname + "']").prop("selected", true);

		}
	}
}();

//======================================================================
//MainGNB
//======================================================================
App.MainGnb = function () {
	var self, depth02Arr, maxLength, max, indexNum, maxHeight;
	return {
		init: function () {
			self = this;
			depth02Arr = new Array();
			
			$(".gnb-bg, .sub-mn").css({height : 'auto'});

			$(".gnb-ul > li > a").on("mouseenter focusin", self.onMouseOver);
			$(".sub-mn > li:last-of-type > a").on("focusout", self.onMouseLeave);
			$(".bottom-header-wrap").on("mouseleave", self.onMouseLeave);
			$(".sub-mn").each(function () {
				depth02Arr.push($(this).find("li").length);
			});

			maxLength = depth02Arr.reduce(function (previous, current) {
				return previous > current ? max = previous : max = current;
			});

			indexNum = jQuery.inArray(max, depth02Arr);

			maxHeight = $(".sub-mn:eq(" + indexNum + ")").outerHeight();

			$(".gnb-bg, .sub-mn").css({height: maxHeight + 45 + "px"});
		},
		onMouseOver: function () {
			$(".gnb-ul > li > a").removeClass('active');
			$(this).addClass('active');
			$(".sub-mn, .gnb-bg, .site-link-box").stop(true, true).delay(100).slideDown(300);
		},
		onMouseLeave: function () {
			$(".gnb-ul > li > a").removeClass('active');
			$(".sub-mn, .gnb-bg, .site-link-box").stop(true, true).delay(100).slideUp(300);
		}
	}
}();

//======================================================================
//CarouselModule(ver.05.01)
//======================================================================
App.CarouselModule = function () {
	var self, opt;
	var offset, pos; //[정지/재생] 버튼 위치 설정(절대값/상대값)
	var $controlBtn; //[이전/다음] 컨트롤 버튼
	var $carouselWrap, $carouselBox; //owl carousel 선택자
	var resOptKey, resOptVal, resArr, resWinWidth, resResult, resMatch; //반응형 옵션
	var result;
	return {
		init: function (param) { //모듈 옵션을 parameter로 받는다.
			self = this;
			opt = param;

			//owl carousel 선택자
			$carouselWrap = $(opt.name); //.carousel-wrap
			$carouselBox = $(opt.name).find('.owl-carousel'); //.owl-carousel
			$controlBtn = $(opt.name).find('.control-wrap > a'); //[이전/다음] 버튼

			//각각의 owl-carousel 실행
			$(opt.name).find('.owl-carousel').owlCarousel(opt.carouselOption);

			//정지/재생 컨트롤버튼
			$controlBtn.off(); //owl destroy후 rebuild했을 경우 trigger이벤트가 중복 발생되면서 rebuild된 횟수만큼 실행됨(슬라이드가 한꺼번에 2개 이상씩 넘어감) 따라서, 컨트롤버튼(이전/다음) 이벤트 초기화로 이벤트 중복발생 방지.
			$controlBtn.on('click', self.onClick);
			$(document).on('click', '.carousel-stop', self.onClickStop); //정지
			$(document).on('click', '.carousel-play', self.onClickPlay); //재생

			//owl-carousel에 dot가 없는경우 클래스 추가하여 [정지/재생] hide처리
			if ($carouselWrap.find('.owl-dots.disabled').length > 0) {
				$carouselWrap.find('.mini-board-ctrl').addClass('no-dots');
			}

			//[정지/재생] 컨트롤버튼 위치 설정
			self.insertCtrl();

			//화면 resize 후에 다시 autoplay되는 bug 해결	
			$carouselBox.on('resized.owl.carousel', function () {
				if ($(opt.name).find('.mini-board-ctrl').hasClass('carousel-play') === true) {
					$(this).trigger('stop.owl.autoplay');
				}
				self.noLoop();
				self.direction();
			});

			//owl carousel이 loop인 경우 화면에 노출될 아이템 개수보다 실제 등록된 아이템의 개수가 작을때 loop 해제
			self.noLoop();

			//direction
			self.direction();

			//autoplay false 설정시 한번 롤링되는오류 수정
			if (opt.carouselOption.customautoplay === false) {
				$(opt.name).find('.owl-carousel').trigger('stop.owl.autoplay');
				$(opt.name).find('.mini-board-ctrl').removeClass('carousel-stop').addClass('carousel-play');
				$(opt.name).find('.mini-board-ctrl').attr('title', '재생');
			}

			$('.carousel-wrap').each(function () {
				//cms적용된 홈페이지에서 carousel이 멈춘상태에서 owl-dot클릭시 자동으로 autoplay되는 오류해결
				$(this).find('.owl-dot').click(function () {
					var dotCarousel = $(this).parents('.owl-carousel');
					if ($(this).parents('.carousel-wrap').find('.mini-board-ctrl').hasClass('carousel-play') === true) {
						setTimeout(function () {
							dotCarousel.trigger('play.owl.autoplay');
							dotCarousel.trigger('stop.owl.autoplay');
						}, 10);
					}
				});

				//carousel이 멈춘상태에서 mouseDrag시 자동으로 autoplay되는 오류해결
				$(this).find('.owl-carousel').on('translated.owl.carousel', function () {
					var dragCarousel = $(this);
					if ($(this).parents('.carousel-wrap').find('.mini-board-ctrl').hasClass('carousel-play') === true) {
						setTimeout(function () {
							dragCarousel.trigger('play.owl.autoplay');
							dragCarousel.trigger('stop.owl.autoplay');
						}, 10);
					}
				});

				//carousel이 멈춘상태에서 prev, next 버튼 클릭시 자동으로 autoplay되는 오류해결		
				$(this).find('.control-wrap').on('click', function () {
					var conCarousel = $(this).parents('.owl-carousel');
					if ($(this).parents('.carousel-wrap').find('.mini-board-ctrl').hasClass('carousel-play') === true) {
						setTimeout(function () {
							conCarousel.trigger('play.owl.autoplay');
							conCarousel.trigger('stop.owl.autoplay');
						}, 10);
					}
				});
			});

		},
		onClick: function () { //[이전/다음] 컨트롤 버튼
			if ($(this).hasClass('prev')) {
				$(this).parents('.carousel-wrap').find('.owl-carousel').trigger('prev.owl.carousel');
			} else if ($(this).hasClass('next')) {
				$(this).parents('.carousel-wrap').find('.owl-carousel').trigger('next.owl.carousel');
			}

			return false;

		},
		onClickStop: function () { //정지
			$(this).parents('.carousel-wrap').find('.owl-carousel').trigger('stop.owl.autoplay');
			$(this).removeClass('carousel-stop').addClass('carousel-play');
			$(this).attr('title', '재생');
		},
		onClickPlay: function () { //재생
			$(this).parents('.carousel-wrap').find('.owl-carousel').trigger('play.owl.autoplay');
			$(this).removeClass('carousel-play').addClass('carousel-stop');
			$(this).attr('title', '정지');
		},
		ctrlOffset: function () { //[정지/재생] 컨트롤 버튼 절대값 위치계산
			if (opt.carouselOption.ctrlPoint === 'first') {
				offset = $carouselBox.find('.owl-dots .owl-dot:' + opt.carouselOption.ctrlPoint + '-of-type').offset().left;
				$carouselWrap.find('.mini-board-ctrl').css({
					left: offset - $carouselWrap.find('.mini-board-ctrl').width() + 'px'
				});
			} else if (opt.carouselOption.ctrlPoint === 'last') {
				offset = $carouselBox.find('.owl-dots .owl-dot:' + opt.carouselOption.ctrlPoint + '-of-type').offset().left + $carouselBox.find('.owl-dots .owl-dot:' + opt.carouselOption.ctrlPoint + '-of-type').outerWidth();
				$carouselWrap.find('.mini-board-ctrl').css({
					left: offset - $carouselWrap.find('.mini-board-ctrl').width() + 'px'
				});
			}
		},
		ctrlPos: function () { //[정지/재생] 컨트롤 버튼 상대값 위치계산
			if (opt.carouselOption.ctrlPoint === 'first') {
				pos = $carouselBox.find('.owl-dots .owl-dot:' + opt.carouselOption.ctrlPoint + '-of-type').position().left;
				$carouselWrap.find('.mini-board-ctrl').css({
					left: pos - $carouselWrap.find('.mini-board-ctrl').width() + 'px'
				});
			} else if (opt.carouselOption.ctrlPoint === 'last') {
				pos = $carouselBox.find('.owl-dots .owl-dot:' + opt.carouselOption.ctrlPoint + '-of-type').position().left + $carouselBox.find('.owl-dots .owl-dot:' + opt.carouselOption.ctrlPoint + '-of-type').outerWidth();
				$carouselWrap.find('.mini-board-ctrl').css({
					left: pos - $carouselWrap.find('.mini-board-ctrl').width() + 'px'
				});
			}
		},
		insertCtrl: function () { //[정지/재생] 컨트롤 버튼 위치 설정
			setTimeout(function () { //렌더링시 owl 로딩이 느려 위치를 제대로 계산하지 못하는 경우가 있기 때문에 setTimeout으로 일정시간 이후 위치를 지정하도록 한다.
				if (opt.carouselOption.ctrlVer === 'offset') {
					self.ctrlOffset();
					$(window).resize(function () {
						self.ctrlOffset();
					});
				} else if (opt.carouselOption.ctrlVer === 'pos') {
					self.ctrlPos();
					$(window).resize(function () {
						self.ctrlPos();
					});
				}
			}, 200);
		},
		noLoop: function () { //화면에 노출될 아이템 개수보다 실제 등록된 아이템의 개수가 작을때 loop 해제
			if ('responsive' in opt.carouselOption) { //owl carousel 옵션 중 responsive 옵션이 있는경우
				resArr = [];
				resOptKey = Object.keys(opt.carouselOption.responsive);

				for (var i = 0; i < resOptKey.length; i++) {
					resOptVal = (opt.carouselOption.responsive[resOptKey[i]]);
					resArr.push(resOptVal);
				}

				resWinWidth = $(window).innerWidth();
				resOptKey.reduce(function (current, next) {
					return resResult = resWinWidth > next ? next : current;
				});

				resMatch = resOptKey.indexOf(resResult);

				if (resArr[resMatch].loop === true && $carouselBox.find('.owl-item:not(.cloned)').length <= resArr[resMatch].items) {
					$carouselBox.find('.owl-item.cloned').remove();
					$carouselWrap.addClass('no-loop'); //css에서 .no-loop .owl-stage{transform:none !important;} / .no-loop .mini-board-ctrl{display:none;} / .no-loop .owl-dots{display:none;} 처리 필요
				} else {
					$carouselWrap.removeClass('no-loop');
					self.insertCtrl();
					if ($carouselWrap.find('.carousel-stop').length > 0) {
						$carouselBox.trigger('play.owl.autoplay');
					}
				}
			} else { //owl carousel 옵션 중 responsive 옵션이 없는 일반적인 경우
				if (opt.carouselOption.loop === true && $carouselBox.find('.owl-item:not(.cloned)').length <= opt.carouselOption.items) {
					$carouselBox.find('.owl-item.cloned').remove();
					$carouselWrap.addClass('no-loop');
				} else {
					$carouselWrap.removeClass('no-loop');
					self.insertCtrl();
					if ($carouselWrap.find('.carousel-stop').length > 0) {
						$carouselBox.trigger('play.owl.autoplay');
					}
				}
			}
		},
		direction: function () {
			var loopFlag = null;
			var itemsVal = null;
			if ('responsive' in opt.carouselOption) {
				loopFlag = resArr[resMatch].loop;
				itemsVal = resArr[resMatch].items;
			} else {
				loopFlag = opt.carouselOption.loop;
				itemsVal = opt.carouselOption.items;
			}

			//owl-stage 초기화
			if (loopFlag === false) {
				setTimeout(function () {
					$carouselWrap.find('.owl-carousel .owl-stage').css({
						transform: 'translate3d(0,0,0)'
					});
				}, 20);
			}

			if ('responsive' in opt.carouselOption) { //owl carousel 옵션 중 responsive 옵션이 있는경우
				if (resArr[resMatch].direction === 'vertical') {
					self.directionModule(loopFlag, itemsVal);
				} else {
					$carouselWrap.removeClass('owl-vertical');
					$carouselWrap.find('.owl-item').removeClass('active');
					if (opt.carouselOption.items) {
						setTimeout(function () {
							$carouselWrap.find('.owl-item:not(.cloned)').slice(0, opt.carouselOption.items).addClass('active');
						}, 200);
					} else if (resArr[resMatch].items) {
						$carouselWrap.find('.owl-item:not(.cloned)').slice(0, resArr[resMatch].items).addClass('active');
					}
					$carouselWrap.find('.owl-carousel').trigger('to.owl.carousel', 0);
				}
			} else if (opt.carouselOption.direction === 'vertical') {
				self.directionModule(loopFlag, itemsVal);
			}
		},
		directionModule: function (loopFlag, itemsVal) {
			$carouselWrap.addClass('owl-vertical');
			var itemHeight = $carouselWrap.find('.owl-item').innerHeight();
			var clickNum = 0;
			var limitNum = 0;
			var prevFlag = 'off';
			var nextFlag = 'off';
			var posArr = null;
			var curPos = 0;
			var resetStage = 0;
			var autoBox = null;

			if (loopFlag === false && $carouselWrap.hasClass('owl-vertical') === true) {
				$carouselWrap.find('.owl-carousel').on('resized.owl.carousel', function () {
					calcStage(clickNum * itemHeight);
					itemHeight = $carouselWrap.find('.owl-item').innerHeight();
				});
			} else if (loopFlag === true && $carouselWrap.hasClass('owl-vertical') === true) {
				resetStage = $carouselWrap.find('.owl-item.active:eq(0)').prevAll().length * itemHeight;
				calcStage(-resetStage);
				curPos = resetStage;
			}

			function calcStage(resetVal) {
				$carouselWrap.find('.owl-carousel .owl-stage').css('transform', 'translate3d(0px,' + resetVal + 'px' + ', 0px)');
			}

			if (opt.carouselOption.autoplay === true && $carouselWrap.hasClass('owl-vertical') === true) {
				autoLoop();

				function autoLoop() {
					$carouselWrap.find('.owl-carousel').trigger('play.owl.autoplay');
					$carouselWrap.find('.owl-carousel').trigger('stop.owl.autoplay');
					if ('autoplayTimeout' in opt.carouselOption) {
						autoBox = setInterval(function () {
							$carouselWrap.find('.control-wrap .next').trigger('click');
						}, opt.carouselOption.autoplayTimeout);
					} else {
						autoBox = setInterval(function () {
							$carouselWrap.find('.control-wrap .next').trigger('click');
						}, 5000);
					}
				}

				$carouselWrap.find('.mini-board-ctrl').click(function () {
					if ($(this).hasClass('carousel-stop')) {
						clearTimeout(autoBox);
					} else if ($(this).hasClass('carousel-play')) {
						autoLoop();
					}
					$carouselWrap.find('.owl-carousel').trigger('play.owl.autoplay');
					$carouselWrap.find('.owl-carousel').trigger('stop.owl.autoplay');
					setTimeout(function () {
						$carouselWrap.find('.owl-carousel').trigger('stop.owl.autoplay');
					}, 100);
				});
			}

			$carouselWrap.find('.control-wrap a').click(function () {
				var $stageArea = $(this).parents('.carousel-wrap').find('.owl-carousel .owl-stage');
				var itemNum = $stageArea.find('.owl-item').length;
				$carouselWrap.find('.owl-carousel').on('translated.owl.carousel', function () {
					posArr = $carouselWrap.find('.owl-stage').css('transform').replace(/[^0-9^,^-^.]/g, "").split(',');
					curPos = posArr[5];
				});

				if ($(this).attr('class') === 'next') {
					clickNum = --clickNum;
				} else if ($(this).attr('class') === 'prev') {
					clickNum = ++clickNum;
				}

				if (loopFlag === false && $carouselWrap.hasClass('owl-vertical') === true) {
					if (1 <= clickNum) {
						clickNum = 0;
						$stageArea.css('transform', 'none');
					} else if (itemNum <= -(clickNum - itemsVal)) {
						limitNum = -(itemNum - itemsVal);
						clickNum = limitNum;
						calcStage(limitNum * itemHeight);
					} else {
						calcStage(clickNum * itemHeight);
					}

				} else if (loopFlag === true && $carouselWrap.hasClass('owl-vertical') === true) {
					if ($(this).attr('class') === 'next') {
						if ($carouselWrap.find('.owl-item:not(.cloned).active').length <= 1) {
							nextFlag = 'on';
						}

						if (nextFlag === 'off') {
							calcStage(-itemHeight - curPos);
						} else if (nextFlag === 'on') {
							$carouselWrap.addClass('no-transition');
							calcStage(itemHeight - resetStage);
							setTimeout(function () {
								$carouselWrap.removeClass('no-transition');
								calcStage(-resetStage);
							}, 100);
							nextFlag = 'off';
							clickNum = 0;
						}
					} else if ($(this).attr('class') === 'prev') {
						if ($carouselWrap.find('.owl-item:not(.cloned):first').prev('.owl-item.cloned').hasClass('active')) {
							prevFlag = 'on';
							nextFlag = 'on';
						}

						if (prevFlag === 'off') {
							calcStage(itemHeight - curPos);
						} else if (prevFlag === 'on') {
							$carouselWrap.addClass('no-transition');
							calcStage(-(itemHeight * $carouselWrap.find('.owl-item:not(.cloned)').length) - resetStage);
							setTimeout(function () {
								$carouselWrap.removeClass('no-transition');
								calcStage(-(itemHeight * ($carouselWrap.find('.owl-item:not(.cloned)').length - 1)) - resetStage);
							}, 100);
							prevFlag = 'off';
							clickNum = 0;
						}
					}
				}
			});
		}
	}
};

//-----------------------------------------------------------------------------------------
//select box(related site box)
//-----------------------------------------------------------------------------------------
App.SelectBox2 = function(){
	var self;
	var $relatedTitle, $relatedList;
	return {
		init: function(){
			self = this;
			$relatedTitle = $(".related-site-title");
			$relatedList = $(".related-site");
			$relatedTitle.click(self.onClick);

			$(".related-site-wrap").each(function(){
				var $thisBox = $(this);

				$(document).mouseup(function(e){
					if($thisBox.has(e.target).length === 0){
						$thisBox.find(".related-site-title").removeClass("active");
						$thisBox.find("ul").hide();
					}
				});

			});

		},
		onClick: function(){
			$(this).siblings('.related-site').toggle();
			$(this).toggleClass("active", "");
		}
	}
}();

//------------------------------------------------------
//List 자동화
//------------------------------------------------------  
App.autoList = function () {
	var self, ulWidth, liArr, liSum, liNum, space, liOneSpace, autoOpt, remainder;
	return {
		init: function (opt) {
			autoOpt = opt;

			ulWidth = $(autoOpt.list).innerWidth();
			liArr = [];
			liSum = 0;
			liNum = $(autoOpt.list).children("li").length;

			$(autoOpt.list).children("li").each(function () {
				liArr.push($(this).find("a").innerWidth());
			});

			liArr.reduce(function (a, b) {
				result = a + b;
				return result;
			});

			liSum = result;

			if ((ulWidth - liSum) >= 0) {
				space = ulWidth - liSum;
			} else {
				space = 0;
				remainder = ulWidth - liSum;
				ulWidth = ulWidth + (-remainder);
			}

			if ((space / liNum) >= 0) {
				liOneSpace = space / liNum;
			} else {
				liOneSpace = 0;
			}

			if (autoOpt.endWidth == "center") {
				$(autoOpt.list).children("li").each(function () {
					$(this).css({
						width: (($(this).children("a").innerWidth() + liOneSpace) / ulWidth) * 100 + "%"
					});
				});
			} else if (autoOpt.endWidth == "end") {
				$(autoOpt.list).children("li").each(function () {
					$(this).not(":first-of-type, :last-of-type").css({
						width: (($(this).children("a").innerWidth() + liOneSpace + (liOneSpace / (liNum - 1))) / ulWidth) * 100 + "%"
					});
				});
				$(autoOpt.list).children("li:first-of-type").css({
					width: (($(autoOpt.list).children("li:first-of-type").children("a").innerWidth() + (liOneSpace / 2) + ((liOneSpace / (liNum - 1))) / 2) / ulWidth) * 100 + "%"
				});
				$(autoOpt.list).children("li:last-of-type").css({
					width: (($(autoOpt.list).children("li:last-of-type").children("a").innerWidth() + (liOneSpace / 2) + ((liOneSpace / (liNum - 1))) / 2) / ulWidth) * 100 + "%"
				});
			}

		}
	}
};

//-----------------------------------------------------------------------------------------
//Lnb Slide
//-----------------------------------------------------------------------------------------  
App.LnbSlide = function(){
	var self;
	var $lnbDep02;
	return {
		init: function(){
			self = this;
			$lnbDep02 = $(".lnb-menu > li > a");

			$(".lnb-menu > li.active").find(".lnb-depth03").show();

			$lnbDep02.click(self.onClick);  
			
			//하위메뉴(3depth)있는경우 2depth li에 lnb-open class 추가
			$('.lnb-depth03').parents('li:not(".active")').addClass('lnb-open');
			$('.lnb-depth03').parents('li.active').addClass('lnb-close');
			

		},
		onClick: function(){
			if($(this).attr("href") == "#none"){        
				if($(this).parents("li").find(".lnb-depth03").is(":visible")){
					$(this).parents("li").find(".lnb-depth03").slideUp();
					$(this).parent("li").removeClass("active");
					$(this).removeClass("active");
					$(this).parent("li").removeClass("lnb-close").addClass("lnb-open");
				}else if($(this).parents("li").find(".lnb-depth03").is(":hidden")){
					$(this).parents("li").find(".lnb-depth03").slideDown();
					$(this).parent("li").addClass("active");
					$(this).addClass("active");
					$(this).parent("li").removeClass("lnb-open").addClass("lnb-close");
				}

				return false;
			}
		}
	}
}();

//------------------------------------------------------
//object-fit(IE)
//------------------------------------------------------  
App.ObjectFit = function () {
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
//------------------------------------------------------
//table scroll
//------------------------------------------------------  
App.TableScroll = function(){
	return {
		init: function(){
			$(".scrollbox").each(function() {
				$(this).scroll(function() {
					$(this).find(".msg-touch-help").fadeOut();
				});
			});
		}
	}
}();

//------------------------------------------------------
//메뉴 연동 select box
//------------------------------------------------------
App.SelectBoxMenu = function () {
	var self;
	var $tabSel, $mTab;
	return {
		init: function () {
			self = this;
			$tabSel = $('.tab-sel');
			$mTab = $(".m-tab-box");

			var select_name = $('.tab-sel').children('option:selected').text();
			$('.tab-sel').siblings('label').text(select_name);

			$tabSel.on('change', function () {
				var url = $(this).val();
				if (url) {
					window.location = url; // redirect
				}

				return false;
			});

			$mTab.click(self.onClick);
		},
		onClick: function(){
			$mTab.toggleClass("active");
			$(".tab-sel").blur(function(){
				$mTab.removeClass("active");
			});
		}
	}
}();