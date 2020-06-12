Andwise.ns('Andwise.define','Andwise.app','Andwise.plugin');

Andwise.define.maxZIndex = 100;

/*
// 메인메뉴 이동중 선택된 페이지의 메뉴로 자동 이동하는 타임, 기본 1000(1초)
Andwise.app.MainMenu.prototype.returnTime = 1000;

// 풀다운 메뉴가 페이지에서 사라지는 타임, 기본 500(0.5초) 
Andwise.plugin.PullDownMainMenu.prototype.hideTime = 50;

// 풀다운 메뉴 마우스 아웃시 사라지는 효과 여부 (true/false) default true;
Andwise.plugin.PullDownMainMenu.prototype.outEffect = false;

// 초기 풀다운 메뉴가 페이지에서 사라지는 타임, 기본 100(0.1초)
Andwise.plugin.PullDownMainMenu.prototype.firstHideTime = 100

// 초기 풀다운 메뉴가 페이지에서 보이지 않게 하는 옵션
Andwise.app.MainMenu.prototype.firstShowMode = 'hide' / 'show'

// 슬라이드 효과에서 슬라이드 실행 주기, 기본 5000(5초)
Andwise.plugin.FxSlide.prototype.interval = 1000;

// 슬라이드 효과에서 슬라이드 효과 타임, 기본 300(0.3초)
Andwise.plugin.FxSlide.prototype.slideTime = 100;

// 디졸브 효과에서 디졸브 실행 주기, 기본 5000(5초)
Andwise.plugin.FxDissolve.prototype.interval = 1000;

// 디졸브 효과에서 슬라이드 효과 타임, 기본 1500(1.5초)
Andwise.plugin.FxDissolve.prototype.fadeTime = 10;

// 스크롤 효과에서 한번에 이동할 픽셀, 기본(1)
Andwise.plugin.FxHorizScroll.prototype.scrollStep = 1;

// 스크롤 효과에서 스크롤 주기 (적을수록 빠르게 이동), 기본 (40)
Andwise.plugin.FxHorizScroll.prototype.interval = 10;
*/

/**
 * create object factory
 * @param {Object} element
 * @param {Object} options
 */  
$(function() {
	
	for(var key in Andwise.app) {
		if(Andwise.app[key].prototype.factory) {
			Andwise.app[key].prototype.factory();
		}
	}
	for(var key in Andwise.plugin) {
		if(Andwise.plugin[key].prototype.factory) {
			Andwise.plugin[key].prototype.factory();
		}
	}
	
});


 

/**
 * Control Abstract Class
 */
Andwise.app.Container = function(element, options) {

	this.options = options || {};
	this.element = Andwise.$(element);
	this.allElement = this.element.find('*');
	
	this.events = {};
	
	if(this.options.listeners) {
		for(var key in options.listeners) {
			this.addListener(key,this.options.listeners[key],this.options.listeners['scope']);
		}
	}
	this.init(); 

}



Andwise.app.Container.prototype = {
	init: function() { // abstract
	},
	changeBgCss: function ($el, mode ) {
		
		// 이미지 타입
		if($el.length == 0 || !$el[0].bgObj) return;
		
		var obj = $el[0];
		
		if(obj.bgObj.imageTag) {
			if(mode == 'on' && obj.bgObj.overBg) {
				obj.bgObj.imageTag.src = obj.bgObj.overBg;
			} else if(mode == 'off' && obj.bgObj.outBg) {
				obj.bgObj.imageTag.src = obj.bgObj.outBg;
			}	
		}	
		//$(obj).fadeIn('fast');
	},
	setPlugin: function( plugin ) {
		this.plugin = plugin;
		plugin.init();
	},
	addListener: function(ename, callBack ,scope) {
			 
		if(!this.events[ename]) {
			this.events[ename] = [];
		}
		
		this.events[ename].push({
			callBack: callBack,
			scope: scope
		});
		
	},
	fireEvent: function() {
		var a = Array.prototype.slice.call(arguments, 0),
            ename = a[0];
		a.shift();	
			
		if(this.events && this.events[ename]) {
			for(var i=0; i<this.events[ename].length; i++) {
				this.events[ename][i].callBack.apply(this.events[ename][i].scope,a);
			}
			return true; 
		}
		return false; 
		
		
	},	
	enable: function() {
		if(this.plugin) this.plugin.enable();
	},
	disable: function() {
		if(this.plugin) this.plugin.disable();
	}
}




/**
 * BasicBox -------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.BasicBox = Andwise.extend(Andwise.app.Container, {

	init: function() {

		this.target = this.element.find(this.options.selector || 'a');
		this.focused = false;
		this.setup();
		
	},
	setup: function() {

		this.allElement = this.element.find('*');
		
		this.allElement
		.mouseover(this.setFoucsOn.createDelegate(this))
		.focus(this.setFoucsOn.createDelegate(this))
		.blur(this.setFoucsOff.createDelegate(this))
		.mouseout(this.setFoucsOff.createDelegate(this));
		
		this.element
		.mouseover(this.setFoucsOn.createDelegate(this))
		.focus(this.setFoucsOn.createDelegate(this))
		.blur(this.setFoucsOff.createDelegate(this))
		.mouseout(this.setFoucsOff.createDelegate(this));
		
		
	},
	setFoucsOn: function() {
		this.focused = true;
	},	
	setFoucsOff: function() {
		this.focused = false;
	},	
	getTargetEl: function() {
		return this.target;
	},
	setTargetEl: function( target ) {
		this.target = target;
	},
	getCurrentPosition: function() {
		var targets = this.getTargetEl(), target;
		for(var i=0; i<targets.length; i++) {
			target = $(targets[i]);
			if(target.attr('focused') == 'true') {
				return i;
			}
		};
		return -1;
		
	},
	gotoNext: function() {
		this.enable();		
		if(this.plugin) {
			this.plugin.playNext( false );
		}	
		
	},
	gotoPrevious: function() {
		
		this.enable();		
		if(this.plugin) {
			this.plugin.playPrevious( false );
		}	
	},
	onTargetChange: function() {
	},
	addClassParents: function ( el, parentSelector, cls ) {
	
		var parent = el.parent();
		
		while( parent.length > 0 && this.element.get(0) !== parent.get(0) ) {
			
			if(parent.is(parentSelector)) {
				parent.addClass( cls );
			}
			parent = parent.parent();
		}
		
		
	},
	removeClassParents: function ( el, parentSelector, cls ) {
	
		var parent = el.parent();
		
		while( parent.length > 0 && this.element.get(0) !== parent.get(0) ) {
			
			if(parent.is(parentSelector)) {
				parent.removeClass( cls );
			}
			parent = parent.parent();
		}
		
		
	}
	
		
});

/**
 * Image Gallery Box ---------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.ImageGallery = Andwise.extend(Andwise.app.BasicBox, {
	factory: function() {
			
		$('.jwxe_imagegallery').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.ImageGallery(this,{
					thumbId: $(this).attr('data-targetid'),
					startIndex: $(this).attr('data-startindex') || 0
				});	
			} 
		});
			
	},
	showDelay: 800,
	interval: 4000,
	init: function() {

		this.focused = false;
		this.setup();
		
	},
	setup: function() {
		
		Andwise.app.ImageGallery.superclass.setup.apply(this,arguments);
		
		var me = this;
		
		// 이미지 element 생성
		var bgImgWrap = $('<div>').css({
			position: 'absolute', left:0, top:0, width: '100%', height:'100%', 'text-align':'center'
		});
		this.bgimg = $('<img>').css({
			'max-width': '100%', 'max-height':'100%'
		});
		this.bgimg.wrap = bgImgWrap;
		bgImgWrap.append(this.bgimg);
		this.element.append(bgImgWrap);
		
		var imgWrap = $('<div>').css({
			position: 'absolute', left:0, top:0, width: '100%', height:'100%', 'text-align':'center'
		});
		this.img = $('<img>').css({
			'max-width': '100%', 'max-height':'100%'
		});
		this.img.wrap = imgWrap;
		imgWrap.append(this.img);
		this.element.append(imgWrap);
		
		this.target = this.element.find('img');
		
		this.currentImg = this.img;
		this.backImg = this.bgimg;
		this.currentIndex = 0;
		this.oldIndex = 0;
		this.direction = 'right';
		
		// 썸네일 박스 아이디 지정
		this.thumbList = $('#'+this.options.thumbId);
		if(!this.thumbList) {
			alert("thumb list of image gallery not found!!!!!!!!");
			return; 
		}
		
		
		this.thumbBoxObj = this.thumbList.get(0).andwise;
		if(!this.thumbBoxObj) {
			this.thumbList.get(0).andwise = new Andwise.app.TabBox(this.thumbList.get(0));			
			this.thumbBoxObj = this.thumbList.get(0).andwise;
		}
		if(this.thumbBoxObj) {
			this.thumbBoxObj.setPlugin( new Andwise.plugin.FxSlide( this.thumbBoxObj, {
				interval: 0,
				slideTime: 1000
			}));
		}
		
		this.imgAnchor = this.thumbList.find('img').parent('a');
		
		this.imgAnchor.each(function(index) {
			$(this).attr('index',index);
		});
		this.imgAnchor.click(function() {
			me.thumbClick.call(me, $(this).find('img'));
			return false;
		});
		
		this.start();
		
	},
	
	start: function() {
		
		if(this.imgAnchor.length > 0) {
			var a; 
			if(this.options.startIndex) {
				a = this.thumbList.find('a[index='+this.options.startIndex+']');
				if(a.length > 0) {
					this.currentIndex = this.options.startIndex;
					// 썸네일리스트와 맞춰준다.
					if(this.thumbBoxObj.uls.length > 1 ){
							this.thumbBoxObj.playTo(this.thumbBoxObj.plugin.getUlIndex(a.parent('li').parent('ul')));
					}
					
				}
			}
			if(!a) {
				a = this.thumbList.find('a[index=0]');
				this.currentIndex = 0;
			}
			this.thumbClick(a.children('img'));		
			//removeClass('active');
		}
		
		this.startInterval();	
		
	},
	stopInterval: function() {
		clearInterval(this.timeOut);
	},
	startInterval: function() {
		
		this.timeOut = setInterval(function() {
			
			if(this.focused == true || this.thumbBoxObj.focused == true) {
				return;
			}
			if(this.direction == 'right') {
				this.nextShow();
			} else {
				this.prevShow();
			}	
		}.createDelegate(this), this.options.interval || this.interval)
		
	},
	
	nextShow: function() {
		
		var nIndex = this.currentIndex + 1;
		if(nIndex == this.imgAnchor.length) {
			nIndex = 0;
		}
		//console.log(nIndex, this.imgAnchor.length);
		this.oldLink = this.acitveLink;
		var a = this.acitveLink = this.thumbList.find('a[index='+nIndex+']');
		this.oldLink = this.oldLink || a;
		
		
		if(this.thumbBoxObj.uls.length > 1 ){
			// 현재 메인 이미지와 썸네일 리스트가 맞지 않으면 맞춰준다.
			if(this.oldLink && this.oldLink.parent('li').parent('ul').css('left').toInt() != 0 ){
				this.thumbBoxObj.playTo(this.thumbBoxObj.plugin.getUlIndex(a.parent('li').parent('ul')));
			} else
			
			if(a.parent('li').prev().length == 0) {
				this.thumbBoxObj.gotoNext();
			} 
		} 
		this.thumbClick( a.children('img') );
					
	},
	prevShow: function() {
		
		var nIndex = this.currentIndex - 1;
		if(nIndex == -1) {
			nIndex = this.imgAnchor.length-1;
		}
		
		this.oldLink = this.acitveLink;
		var a = this.acitveLink = this.thumbList.find('a[index='+nIndex+']');
		this.oldLink = this.oldLink || a;

		if(this.thumbBoxObj.uls.length > 1 ){
			if(this.oldLink && this.oldLink.parent('li').parent('ul').css('left').toInt() != 0 ){
				this.thumbBoxObj.playTo(this.thumbBoxObj.plugin.getUlIndex(a.parent('li').parent('ul')));
			} else
			
			if(a.parent('li').next().length == 0) {
				this.thumbBoxObj.gotoPrevious();
			} 
		} 

		this.thumbClick( a.children('img') );
					
	},
	
	changeOrder: function() {
		
		this.currentImg = this.currentImg == this.bgimg ? this.img: this.bgimg;
		this.backImg = this.currentImg == this.bgimg ? this.img: this.bgimg;
		
	},
	
	thumbClick: function( thumbImg ) {
	

		this.activeAnchor = thumbImg.parent('a');
		this.oldIndex = this.currentIndex;
		
		this.currentIndex = parseInt(this.activeAnchor.attr('index'));
		
		this.changeOrder();
		
		var hasEvent = this.fireEvent('imgclick',thumbImg, this.currentImg, this.backImg);
		
		if(!hasEvent) {
			this.currentImg.attr('src',thumbImg.attr('src'));
		}
		this.showImage();
			
	},
	
	showImage: function() {
		
		this.imgAnchor.parent('li').removeClass('active');
		this.activeAnchor.parent('li').addClass('active');
		
		this.backImg.wrap.fadeOut(this.options.showDelay || this.showDelay);
		this.currentImg.wrap.fadeIn(this.options.showDelay || this.showDelay);
		
		this.stopInterval();
		this.startInterval();
		
	},
	
	gotoNext: function() {
		
		this.nextShow();
		this.direction = 'right';
		
	},
	
	gotoPrevious: function() {
		this.prevShow();
		this.direction = 'left';
	}
	
});


/**
 * DissolveBanner -------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.DissolveBanner = Andwise.extend(Andwise.app.BasicBox, {

	factory: function() {
			
		$('.jwxe_banner1').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.DissolveBanner(this);	
			} 
			this.andwise.setPlugin( new Andwise.plugin.FxDissolve(this.andwise) );
		});
			
	},
	setup: function() {
		this.target.css({'position':'absolute','left':'0','top':'0'});
		Andwise.app.DissolveBanner.superclass.setup.apply(this,arguments);

	}
		
});

/**
 * HorizScrollBanner -------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.HorizScrollBanner = Andwise.extend(Andwise.app.BasicBox, {

	factory: function() {
			
		$('.jwxe_banner2').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.HorizScrollBanner(this);	
			} 
			this.andwise.setPlugin( new Andwise.plugin.FxHorizScroll(this.andwise) );
		});
			
	}		
});

/**
 * SlideBanner -------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.SlideBanner = Andwise.extend(Andwise.app.BasicBox, {

	factory: function() {
			
		$('.jwxe_banner.fx_slide').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.SlideBanner(this);	
			} 
		});
			
	},
	setup: function() {
		
		this.target.css({'position':'absolute','left':'0','top':'0'});
		Andwise.app.SlideBanner.superclass.setup.apply(this,arguments);

	}		
});




/**
 * Main Menu
 */
Andwise.app.MainMenu = Andwise.extend(Andwise.app.Container,{
	
	factory: function() {
		
		$('.jwxe_menu_box0, .jwxe_main_menu_box').each(function() {
			this.andwise = new Andwise.app.MainMenu(this);
		});
		
	},
	
	returnTime: 2500, // 메인메뉴 이동중 선택된 페이지의 메뉴로 자동 이동하는 타임, 기본 1000(1초)
	
	firstShowMode: 'show', // 초기 하위 메뉴(ul)가 페이지에서 보이지 않게 하는 옵션

	init: function() {

		this.boxtag = 'ul';
		this.goToSelect = true;
		this.links = this.element.children('li').children('a');
		this.allLinks = this.element.find('a');
		this.uls = this.element.find('ul');
		
		this.child_uls = this.element.children('li').children('ul');
		this.child_li = this.element.children('li');
		
		this.setup();
		this.oldOverLink = null;
		
		this.customInit();
		
	},
	customInit: function() {
		// override custom 
	},
	setup: function() {
		
		var self = this;
		
		this.links.mouseover(function(event) {
			self.onFocus.call(self,$(this),event);
		}).focus(function(event) {
			self.onFocus.call(self,$(this),event);
		}).mouseout(function(event) {
			self.onBlur.call(self,$(this),event);
		}).blur(function(event) {
			self.onBlur.call(self,$(event.target),event);
		});
		
		if($.browser && $.browser.ismobile) {
			this.links.click(function(event) {
				self.onLinkClick.call(self,$(this),event);
			});
		}
		
		// on class 넣어 주기
		this.allLinks.mouseover(function(event) {
			self.onLinkOver.call(self,$(this),event,'a');
		});
		this.uls.mouseover(function(event) {
			self.onULOver.call(self,$(this),event);
		});
		
		
		
		// 주메뉴로 복귀 이벤트
		this.links.mouseout(this.onMouseout.createDelegate(this)).blur(this.onMouseout.createDelegate(this));
		this.uls.mouseout(this.onMouseout.createDelegate(this)).blur(this.onMouseout.createDelegate(this));
		
		// 상위 element z-index setup
		this.setParentZIndex();
		
		// 선택된 앵커가 있는지 여부
		this.selectedAnchor = this.element.find('a.jw_selected');

		// 초기 메뉴가 나오지 않게 하려면
		if(this.firstShowMode == 'hide' || this.firsShowMode == 'hide') { // this.firsShowMode == 'hide' 는 오타에 의한 하위 호환성
			// cms.js 의 jwxe_bubble_select 를 막는다.
			this.element.attr('bubble','false');
			this.element.find('.jw_selected + ul.jw-dsp-none').css('display','none');
		}
		
		
	},
	getUlEl: function() {
		return this.uls;
	},
	getLinkEl: function() {
		return this.links;
	},
	// 원래 선택된 메뉴로 복귀
	showSelectedMenu: function() {
		
		if(this.goToSelect == false || this.mainMenuOver == true || this.selectedAnchor.length == 0) {
			return;
		}
		
		var self = this;
		this.links.each(function() {
			if(this.bgObj && this.bgObj.outBg) {
				self.changeBgCss($(this),'off');
			}
		});
		
		this.child_uls.css('display','none');
		
		
		for(var i=0; i< this.selectedAnchor.length; i++) {
			jwxe_set_select(this.selectedAnchor[i]);
			this.onLinkOver($(this.selectedAnchor[i]),null,'a');
		}
		
	},
	
	setParentZIndex: function() {
		
		if(this.element.hasClass('jwxe_main_menu_box')) {
			return;
		}
		
		var root = this.element.parents('.jwxe_root');
		var parents = this.element.parentsUntil(root[root.length-1]);
		parents.css('z-index',Andwise.define.maxZIndex+1);
		var topParent = $(root[root.length-1]);
		topParent.css('z-index',Andwise.define.maxZIndex+11);
		
		var p = topParent.parent();
		while( p.length > 0 && (p.next() || p.prev()) ) { //
			if(p.next('noscript').length > 0) break; 
			p.css('z-index',Andwise.define.maxZIndex+11);
			p = p.parent();
		}
		
		
	},
	onLinkClick: function( $link, event ) {
		if($link.next('ul').find('> li').length > 0) {
			event.preventDefault();
		}
		
	},
	onMouseout: function() {
		
			this.mainMenuOver = false;
 			clearTimeout(this.timeout);
	 		this.timeout = setTimeout(this.showSelectedMenu.createDelegate(this), this.options.returnTime || this.returnTime);
			
	},
	onBlur: function(anchor, event) {
		
		this.mainMenuOver = false;
		var ul = anchor.next(this.boxtag);
		if(ul.length == 0) {
			this.changeBgCss(anchor,'off');
			return;
		}
		
	},	
	onFocus: function(anchor, event) {
		this.mainMenuOver = true;
		var next = anchor.next('ul');
		/*var parent = anchor.parentsUntil('.jwmnupulldown');
		if(parent.length > 0) {
			parent.stop(true,true).css('display','block');
		}*/
		next.stop(true,true).css('display','block');
		
		this.curUl = next;
		var self = this;
		this.child_uls.each( function(index) {
			if(next.get(0) == this) return;
			var ul = $(this);
			ul.css('display','none');
			var prev = ul.prev('a'); // 자신외의 anchor 의 마우스 아웃
			if(prev.length > 0) {
				if(prev.get(0).bgObj) {
					self.changeBgCss(prev,'off');
				}	
			}
		});
		
		
		/*
		this.uls.attr('display','none');
		anchor.parentsUntil(this.element).attr('display', 'block');
		next.attr('display', 'block');
	
		var self = this;
		this.uls.each( function(index) {
			var ul = $(this);
			if(ul.attr('display') == 'block') {
				ul.css({'display':'block'});
				ul.parent().addClass('on');			
			} else {
				ul.parent().removeClass('on');			
				ul.css({'display':'none'});
				var prev = ul.prev('a'); // 자신외의 anchor 의 마우스 아웃
				if(prev.length > 0) {
					if(prev.get(0).bgObj) {
						self.changeBgCss(prev,'off');
					}	
				}
							
			}
		});*/	
	
	},
	onLinkOver: function(a, event, tag) {
		
		if(a.length == 0) return;
		
		if(this.oldOverLink && this.oldOverLink.length > 0 && this.oldOverLink.get(0) == a.get(0)) return;

		if(this.oldOverLink) {
			this.oldOverLink.removeClass('over');
			this.oldOverLink.next('ul').removeClass('over');
			this.oldOverLink.parent('li').parent('ul').prev('a').removeClass('over');
			this.oldOverLink.parentsUntil(this.element).children('ul').prev('a').removeClass('over');
			this.oldOverLink.parentsUntil(this.element).removeClass('over');
		}
		
		a.addClass('over'); 
		a.next('ul').addClass('over');
		a.parentsUntil(this.element).children('ul').prev('a').addClass('over');
		a.parentsUntil(this.element).addClass('over');
		
		this.oldOverLink = a;
		this.lastEventTag = tag; 
	},
	onULOver: function(ul, event) {

		if(this.lastEventTag == 'a') {
			this.lastEventTag = 'ul'; 
			return;
		}	 
		
		if(ul.find('ul').length == 0 ) {
			this.onLinkOver(ul.prev('a'),event, 'ul');
		}
	},
	setGoToSelect: function( enable ) {
		this.goToSelect = enable;
	}	
});


/**
 * UL Box -------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.ULBox = Andwise.extend(Andwise.app.BasicBox, {
	factory: function() {
		
		$('.jwxe_ul').each(function() {
			if(!this.andwise)
				this.andwise = new Andwise.app.ULBox(this);
		});
		
	},
	init: function() {

		this.boxtag = this.options.boxtag || 'ul';
		this.links = this.element.find('> li > a');		
		this.setup();
		this.oldOverLink = this.element.find('> li > a.jw_selected,> li > a.over');
		
	},
	
	setup: function() {

		var self = this;
		
		this.links.mouseover(function(event) {
			self.onLinkOver.call(self,$(this),event);
		});
		
		Andwise.app.ULBox.superclass.setup.apply(this,arguments);
		
	},
	onLinkOver: function(a, event, tag) {
		
		if(a.length == 0) return;
		
		if(this.oldOverLink && this.oldOverLink.length > 0 && this.oldOverLink.get(0) == a.get(0)) return;

		if(this.oldOverLink) {
			this.oldOverLink.removeClass('over');
			this.oldOverLink.parent('li').parent('ul').prev('a').removeClass('over');
			this.oldOverLink.parentsUntil(this.element).children('ul').prev('a').removeClass('over');
			this.oldOverLink.parentsUntil(this.element).removeClass('over');
		}
		
		a.addClass('over'); 
		a.parentsUntil(this.element).children('ul').prev('a').addClass('over');
		a.parentsUntil(this.element).addClass('over');
		
		this.oldOverLink = a;
		 
	}
		
});



/**
 * Tab Box -------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.TabBox = Andwise.extend(Andwise.app.BasicBox, {
	factory: function() {
		
		$('.jwxe_menu_box2').each(function() {
			if(!this.andwise)
				this.andwise = new Andwise.app.TabBox(this);
		});
		
	},
	
	eventType: 'mouseover', 
	
	init: function() {

		this.boxtag = this.options.boxtag || 'ul';

		this.links = this.element.find('> li > a');		
		this.uls = this.element.find('> li > '+this.boxtag);
		
		
		// 선택된 앵커
		this.selectedAnchor = this.element.find('> li > a:first-child.jw_selected');
		this.guidAnchor = this.element.find('> li > a:first-child');
		this.focused = false;
		this.setup();
		this.oldOverLink = null;
		
	},
	
	setup: function() {

		var self = this;
		
		this.links.css('z-index',Andwise.define.maxZIndex+1);
		//this.element.find('> li > a').attr('guide','true');		

		this.links.bind(this.eventType, function(event) {
			self.onFocus.call(self,$(this),event);
		}).mouseout(function(event) {
			self.onBlur.call(self,$(this),event);
		}).focus(function(event) {
			self.onFocus.call(self,$(this),event);
		}).blur(function(event) {
			self.onBlur.call(self,$(event.target),event);
		}.createDelegate(this))	;
		
		
		this.links.bind(this.eventType,function(event) {
			self.onLinkOver.call(self,$(this),event);
		});
		this.uls.mouseover(function(event) {
			self.onULOver.call(self,$(this),event);
		});		
		
		this.alignTarget();
		
		Andwise.app.TabBox.superclass.setup.apply(this,arguments);
		
	},
	alignTarget: function() {
		
		this.uls.each(function(index, ul) {
			var ul = $(ul), prevLink;
			
			if(this.selectedAnchor.length == 0 && index == 0 ) { // 선택된 링크가 없고 첫 탭이면 활성
				ul.css({'display':'block','z-index':2});
				ul.attr({'focused':'true','display':'block'});
				this.addClassParents( ul, 'li','active');
				
				this.onTargetChange(ul,'on');

				ul.css('z-index', Andwise.define.maxZIndex);
			} else if(this.selectedAnchor.length > 0 && ul.prev('a').hasClass('jw_selected')) { // 선택된 링크가 있으면 링크의 다음 ul이 활성
				ul.css({'display':'block','z-index':2});
				ul.attr({'focused':'true','display':'block'});
				this.addClassParents( ul, 'li','active');
				
			} else {
				ul.css({'display':'none','z-index':''});
				ul.attr({'focused':'false','display':'none'});
				ul.parents('li').removeClass('active');
				this.removeClassParents( ul, 'li','active');
				
			}
			
		}.createDelegate(this));
		
	},
	onBlur: function(element, event) {
		
	  var link = $(element);
		
		var ul = link.next(this.boxtag);
		if(ul.length == 0) {
			this.changeBgCss(link,'off');
			return;
		}
		
	},	
	onFocus: function(element, event) {
		
		if(this.plugin && this.plugin.playing) {
			return;
		}
		
	  var link = $(element);
		var ul = link.next(this.boxtag);
		
		this.changeTab(link, ul);
		
		this.fireEvent('onfocus', this);
		
	},
	changeTab: function(link, ul) {	

		this.uls.attr('display','none');
		
		link.parentsUntil(this.element).attr('display', 'block');
		ul.attr('display', 'block');
		
		this.uls.each(function(index,element) {
			var ul = $(element);
			if(ul.attr('display') == 'block') {
				ul.css('display', 'block');
				ul.attr('focused', 'true');
				this.addClassParents( ul, 'li','active');
				
				this.onTargetChange(ul,'on');
				
				this.fireEvent('onshow',ul);
				
			} else {
				ul.css('display', 'none');
				ul.attr('focused', 'false');
				this.removeClassParents( ul, 'li','active');
				
				this.onTargetChange(ul,'off');
			}
				
		}.createDelegate(this));
			
					
	},	
	
	onLinkOver: function(a, event, tag) {
		
		if(a.length == 0) return;
		
		if(this.oldOverLink && this.oldOverLink.length > 0 && this.oldOverLink.get(0) == a.get(0)) return;

		if(this.oldOverLink) {
			this.oldOverLink.removeClass('over');
			this.oldOverLink.next('ul').removeClass('over');
			this.oldOverLink.parent('li').parent('ul').prev('a').removeClass('over');
			this.oldOverLink.parentsUntil(this.element).children('ul').prev('a').removeClass('over');
			this.oldOverLink.parentsUntil(this.element).removeClass('over');
		}
		
		a.addClass('over'); 
		a.next('ul').addClass('over');
		a.parentsUntil(this.element).children('ul').prev('a').addClass('over');
		a.parentsUntil(this.element).addClass('over');
		
		this.oldOverLink = a;
		this.lastEventTag = tag; 
	},
	onULOver: function(ul, event) {

		if(this.lastEventTag == 'a') {
			this.lastEventTag = 'ul'; 
			return;
		}	 
		
		if(ul.find('ul').length == 0 ) {
			this.onLinkOver(ul.prev('a'),event, 'ul');
		}
	},
	
	getTargetEl: function() {
		return this.uls;
	},
	getGuideEl: function() {
		return this.links;
	},
	onTargetChange: function (ul, mode) {

		var prev = ul.prev('a');
		if(prev.length > 0) {
			
			prev.css({'z-index': Andwise.define.maxZIndex + (mode=='on'?9:1) });
			
			this.changeBgCss(prev, mode );
		}
		
	},
	
	playTo: function(idx) {
		this.enable();
		if(this.plugin && this.plugin.playTo) {
			this.plugin.playTo(idx);
		}

	},
	gotoNext: function() {
		
		this.enable();
		this.element.attr('jwxe_dir','+');
		
		if(this.plugin) {
			this.plugin.playNext(false);
			return;
		} else {
			if(this.plugin) {
				this.plugin.palyWait();
			}
			var idx = this.getCurrentPosition()+1;
			if(idx == this.uls.length) idx = 0;
			var ul = $(this.uls[idx]), link = ul.prev('a');
			this.changeTab(link,ul);
		}	
		
	},
	gotoPrevious: function() {
		
		this.enable();
		this.element.attr('jwxe_dir','-');
		
		if(this.plugin) {
			this.plugin.playPrevious(false);
			return;
		} else {
			if(this.plugin) {
				this.plugin.palyWait();
			}
			var idx = this.getCurrentPosition()-1;
			if(idx == -1) idx = this.uls.length-1;
			var ul = $(this.uls[idx]), link = ul.prev('a');
			this.changeTab(link,ul);
		}	
	}	
		
});




/**
 * PopupZone Box ---------------------------------------------------------------------------------------------------------------------------------
 */
Andwise.app.PopupZone = Andwise.extend(Andwise.app.TabBox, {
	factory: function() {
		
		$('.jwxe_popupzone').each(function() {
			var box = $(this);
			this.andwise = new Andwise.app.PopupZone(this);
			if(!box.hasClass('fx_dissolve') && !box.hasClass('fx_slide') && !box.hasClass('fx_slide_over')) { // 하위 호환성 - 둘다 없으면 dissolve 를 강제로 넣어 준다.
				//this.andwise.setPlugin( new Andwise.plugin.FxDissolve( this.andwise ) );
			}
		});
		
	},
	init: function() {
		
		this.boxtag = 'span';

		this.links = this.element.find('a');		
		this.links.each(function() {
			var a = $(this), img;
			if(a.hasClass('popup_guide')) {
				var img = a.find('img');
				this.bgObj = {
					imageTag: (img.length > 0 ? img.get(0) : null),
					outBg: andwise.popupbtns[this.id].img,
					overBg: andwise.popupbtns[this.id].over_img
				}
			}
		});
		
		this.uls = this.element.find('li > '+this.boxtag);
		
		// 선택된 앵커
		this.selectedAnchor = this.element.find('> li > a:first-child.jw_selected');
		this.guidAnchor = this.element.find('> li > a:first-child');
		this.focused = false;
		
		this.setup();
		
		
	}		
});

var _scroll_btns = [];
$(window).load(function() {
	var button;
	for(var i=0; i < _scroll_btns.length; i++ ) {
		
		button = document.getElementById(_scroll_btns[i].id);
		
		if(!button) continue;
		
		var target = $('#'+_scroll_btns[i].target_id);
		
		if(target.length == 0) continue;
		
		if(target.attr('class').indexOf('_include_') > -1) { // 인클루드 이면
			target = target.children('ul');
			if(target.length == 0) continue;
		}
		
		var scroll_kind = _scroll_btns[i].scroll_kind;
		
		if (scroll_kind == 'right') {
				new Andwise.app.ControlRightButton( button, target );
		} else if(scroll_kind == 'left') {
				new Andwise.app.ControlLeftButton( button, target );
		} else if(scroll_kind == 'stop') {
				new Andwise.app.ControlStopButton( button, target );
		} else if(scroll_kind=='play') {
				new Andwise.app.ControlPlayButton( button, target );
		}
		
	}
});

Andwise.app.ControlAbstractButton = function( button, target ) {
	this.button = Andwise.$(button);
	
	this.target = Andwise.$(target).get(0).andwise;
	
	this.button.click(this.execute.createDelegate(this));
	
	this.button.mouseover(this.onFocus.createDelegate(this));
	this.button.focus(this.onFocus.createDelegate(this));
	
	this.button.mouseout(this.onBlur.createDelegate(this));
	this.button.blur(this.onBlur.createDelegate(this));
	
}
Andwise.app.ControlAbstractButton.prototype = {
	
	onFocus: function() {
	},
	onBlur: function() {
	},
	execute: function() {
	} 
}


Andwise.app.ControlRightButton = Andwise.extend(Andwise.app.ControlAbstractButton,{
	onFocus: function() {
		this.target.setFoucsOn();
	},
	onBlur: function() {
		this.target.setFoucsOff();
	},
	execute: function() {
		this.target.setFoucsOff();
		this.target.gotoNext();
		this.target.setFoucsOn();
	}	
});

Andwise.app.ControlLeftButton = Andwise.extend(Andwise.app.ControlAbstractButton,{
	onFocus: function() {
		this.target.setFoucsOn();
	},
	onBlur: function() {
		this.target.setFoucsOff();
	},
	execute: function() {
		this.target.setFoucsOff();
		this.target.gotoPrevious();
		this.target.setFoucsOn();
	}	
});

Andwise.app.ControlPlayButton = Andwise.extend(Andwise.app.ControlAbstractButton,{
	execute: function() {
		this.target.enable();
	}	
});

Andwise.app.ControlStopButton = Andwise.extend(Andwise.app.ControlAbstractButton,{
	execute: function() {
		this.target.disable();
	}	
});



/**
 * Plugin Abstract Class
 */
Andwise.plugin.Abstract = function(container, options) {
	
		this.options = options || {};
		this.container = container;
		this.element = container.element;
		
}


/**
 * Pulldown Main menu plugin -------------------------------------------------------------------------------------------------------
 */
Andwise.plugin.PullDownMainMenu = Andwise.extend(Andwise.plugin.Abstract,{
	factory: function() {
		
		$('.jwxe_menu_box0.jwmnupulldown').each(function() {
			this.andwise.setPlugin( new Andwise.plugin.PullDownMainMenu(this.andwise) );
		});
		
	},
	
	hideTime: 500,  //풀다운 메뉴가 페이지에서 사라지는 타임, 기본 500(0.5초) 
	
	firstHideTime: 300, // 초기 풀다운 메뉴가 페이지에서 사라지는 타임, 기본 200(0.2초)
	
	outEffect: true, // 마우스 아웃 시 사라지는 효과 여부
	
	init: function() {
		
		this.container.setGoToSelect(false);
		
		var self = this;
		
		if(this.container.firstShowMode != 'hide' && this.container.firsShowMode != 'hide') { //this.firsShowMode != 'hide' 는 오타에 의한 하위 호환성
	  	// 초기메뉴 감춤
	  	this.menuTimeout(this.element.find('li a.jw_selected + ul'),this.options.firstHideTime || this.firstHideTime);
		} 
	
	  // 링크에서 아웃되었으면 감춤
	  this.container.getLinkEl().mouseout(function() {
	    self.menuTimeout($(this).next());
	  }); 
	  // 링크에 오버되었으면 감춤 취소
	  this.container.getLinkEl().mouseover(function() {
	    clearTimeout(self.timeout);
	  });  
	 
	  // 메뉴 리스트 박스에 오버되었으면 감춤 취소
	  this.container.getUlEl().mouseover(function() {
	    clearTimeout(self.timeout);
	  });  
	  // 메뉴 리스트 박스에 아웃되었으면 감춤
	  this.container.getUlEl().mouseout(function() {
	    self.menuTimeout($(this));
	  });
		
		 		
		
	},
	menuTimeout: function( ul, delay ) {
		this.ul = ul;
		if(ul.length == 0) return;
    clearTimeout(this.timeout);
    this.timeout = setTimeout(this.onAfterMouseOut.createDelegate(this),delay || this.options.hideTime || this.hideTime);
	},
	onAfterMouseOut: function() {
      // 메뉴의 타이틀 링크 아웃 이미지
      var ul = this.container.curUl, a = this.ul.prev('a');
      if(a.length > 0 && a.get(0).bgObj) {
        this.container.changeBgCss(a,'off');
      }  
      // 메뉴를 감춘다
			if(this.outEffect == true) {
      	$(ul.get(0)).stop(true,true).fadeOut('slow');
			} else {
      	$(ul.get(0)).css('display','none');
			}
	}
});

/**
 * Fx plugin
 */
Andwise.plugin.Fx = Andwise.extend(Andwise.plugin.Abstract,{
	enable: function() {
		this.pause = false;	
	},
	disable: function() {
		this.pause = true;	
	},
	isFocused: function() {
		return this.container.focused;
	}	
	
});


/**
 * Tab Slide plugin
 */
Andwise.plugin.FxSlide = Andwise.extend(Andwise.plugin.Fx,{
	factory: function() {
		
		$('.tab_slide_play, .fx_slide').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.BasicBox( this );
			}
			this.andwise.setPlugin( new Andwise.plugin.FxSlide( this.andwise ) );
		});
				
	},
	
	interval: 5000, // 슬라이드 효과에서 슬라이드 실행 주기, 기본 5000(5초)
	
	slideTime: 300, // 슬라이드 효과에서 슬라이드 효과 타임, 기본 300(0.3초)
	
	init: function() {
		
		// 한li 에 여러개의 아이템 인지 확인 
		this.multi = this.container.element.hasClass('multi');
		this.target = this.multi ? this.container.element.find('li') : this.container.getTargetEl();
		this.container.setTargetEl( this.target );
		

		this.focus_idx = 0;
		this.playing = false;
		
		this.setup();
		
		if(this.options.interval !== 0 && this.target.length > 1) {
			this.timeout = setTimeout(this.play.createDelegate(this),this.options.interval || this.interval);
		}
		
	},
	onFocus: function() {
		
	},
	setup: function() {
		
		this.element.css('overflow','hidden');
		this.element.attr('jwxe_dir','+');
		this.target.each(function( index ) {
			var item = $(this);
			
			item.css({'position':'absolute','top':item[0].style.top});
			
			if(this.multi) {
				item.css('width','100%');
			}
			if(index != 0) {
				item.css('display','none');
			}
			
		});
		if(this.target.length > 0) {
			this.target.css({'position':'absolute','top':this.target[0].style.top});
			if(this.multi) {
				this.target.css('width','100%');
			}
		}
		
		this.container.addListener('onshow',function(target) {
			target.css('left','0');
		},this);
		
	},
	palyWait: function() {
		
		clearTimeout(this.timeout);
		this.timeout = setTimeout(this.play.createDelegate(this),this.options.interval || this.interval);
		
	},
	getCanPlay: function() {
		if(this.target.length < 2) {
			return false;
		}
		if(this.pause == true) {
			return false;
		}		
		if(this.playing == true) { // 작동중이면 중지
			return false;
		}
		if(this.isFocused()) { // 탭에 마우스가 올라가있으면 중지
			return false;
		}
		return true;
		
	},
	getCurrentIndex: function() {
		var idx = this.container.getCurrentPosition();
		if(idx == -1) idx = this.focus_idx;
		return idx;
	},
	getPreIndex: function(idx) {
		var pidx = idx-1;
		if(pidx == -1) {
			pidx = this.target.length-1;
		}
		this.focus_idx = pidx;
		return pidx;
	},
	getNextIndex: function(idx) {
		var nidx = idx+1;
		if(this.target.length == nidx) {
			nidx = 0;
		}
		this.focus_idx = nidx;
		return nidx;
	},
	getUlIndex: function(ul) {
		
		for(var i=0; i<this.target.length; i++ ) {
			if(this.target[i] == Andwise.$(ul).get(0)) {
				return i;
			}
		}
		return false;
	},
	
	getAcitveWidth: function( target ) {
		
		return target.width();
		
	},
	
	getTargetLeft: function( target ) {
		
		return 0;
		
	},
	
	playTo: function(newIdx) {
		
		try {
		
			if(!this.getCanPlay()) return;
			
			if(this.getCurrentIndex() == newIdx ) return;
			
			clearTimeout(this.timeout);
			this.playing = true; // 작동중
			
			var idx = this.getCurrentIndex(), nidx = newIdx;
			var curUl = $(this.target[idx]), nextUl = $(this.target[nidx]);
			var width = curUl.css('width').toInt(), left;
			
			nextUl.css({'left': width + 'px', 'display':'block'});
			
			for(var i=0;i<this.target.length;i++) {
				var item = $(this.target[i]);
				item.attr('focused','false');
				this.container.removeClassParents( item, 'li','active');
				
		
				left = item.css('left').toInt();
				if(isNaN(left)) {
					left = 0;
				}
				
				width = item.css('width').toInt();
				
				if(i==idx || i==nidx) {
					item.css('display','block');
					
					item.finish().animate({'left': (left-width)+'px'}, 100 ,'easeInOutExpo', function() {
						
						this.playing = false;
						
					}.createDelegate(this));
				} else {
					item.css('display','none');
				}
				this.container.onTargetChange(item,'off');
					
			}
			
			nextUl.attr('focused','true');
			this.container.addClassParents( nextUl, 'li','active');
			this.container.onTargetChange(nextUl,'on');
			
		} finally {	
			if(this.options.interval !== 0) 
			this.timeout = setTimeout(this.playNext.createDelegate(this),this.options.interval || this.interval);
		}			
		
	},
	playNext: function(effect) {
		
		try {

			if(!this.getCanPlay()) return;
			clearTimeout(this.timeout);
			this.playing = true; // 작동중
			
			var idx = this.getCurrentIndex(), nidx = this.getNextIndex(idx);
			var curUl = $(this.target[idx]), nextUl = $(this.target[nidx]);
			//var width = curUl.css('width').toInt(), left;
			//nextUl.css({'left': width + 'px', 'display':'block'});
			
			var width, left;
			nextUl.css({'left':  '100%', 'display':'block'});
			
			
			for(var i=0;i<this.target.length;i++) {
				var item = $(this.target[i]);
				item.attr('focused','false');
				this.container.removeClassParents( item, 'li','active');
				
		
				left = item.css('left').toInt();
				if(isNaN(left)) {
					left = 0;
				}
				//width = item.css('width').toInt();
				width = this.getAcitveWidth(item);
				
				if(i==idx || i==nidx) {
					
					item.css('display','block');
					item.finish().animate({'left': (left-width)+'px'},effect == false? 100: this.options.slideTime || this.slideTime 
					,'easeInOutExpo', function() {
						
						this.playing = false;
						
					}.createDelegate(this));
				} else {
					item.css('display','none');
				}
				this.container.onTargetChange(item,'off');
					
			}
			
			nextUl.attr('focused','true');
			this.container.addClassParents( nextUl, 'li','active');
			
			this.container.onTargetChange(nextUl,'on');
			
		} finally {	
			if(this.options.interval !== 0) 
			this.timeout = setTimeout(this.playNext.createDelegate(this),this.options.interval || this.interval);
		}	
		
	},
	playPrevious: function(effect) {
		try {
			if(!this.getCanPlay()) return;
			clearTimeout(this.timeout);
			this.playing = true; // 작동중
			
			var idx = this.getCurrentIndex(), pidx = this.getPreIndex(idx);
			var curUl = $(this.target[idx]), preUl = $(this.target[pidx]);
	
			//var width = curUl.css('width').toInt(), left;
			//preUl.css({'left': '-'+width + 'px', 'display':'block'});
					
			var width, left;
			preUl.css({'left': (this.getTargetLeft(curUl) - this.getAcitveWidth(curUl)) + 'px', 'display':'block'});
			
			for(var i=0;i<this.target.length;i++) {
				var item = $(this.target[i]);
				item.attr('focused','false');
				this.container.removeClassParents( item, 'li','active');
		
				left = item.css('left').toInt();
				if(isNaN(left)) {
					left = 0;
				}
				
				//width = item.css('width').toInt();
				width = this.getAcitveWidth(item);
				
				if(i==idx || i==pidx) {
					item.css('display','block');
					
					item.finish().animate({'left': (left + width)+'px'},effect == false? 100: this.options.slideTime || this.slideTime
					,'easeInOutExpo',function() {
						
						this.playing = false;
						
					}.createDelegate(this));
				} else {
					item.css('display','none');
				}
				this.container.onTargetChange(item,'off');
					
			}
			
			preUl.attr('focused','true');
			this.container.addClassParents( preUl, 'li','active');
			
			this.container.onTargetChange(preUl,'on');
		
		} finally {	
			if(this.options.interval !== 0) 
			this.timeout = setTimeout(this.playPrevious.createDelegate(this),this.options.interval || this.interval);
		}	
	},
	play: function() {
		
		
		var tab = this.element, dir = tab.attr('jwxe_dir');
		
		if(dir == '+') {
			this.playNext();
		} else {
			this.playPrevious();
		}

		
	}
});





/**
 * Tab SlideOverflow plugin
 */
Andwise.plugin.FxSlideOverflow = Andwise.extend(Andwise.plugin.FxSlide,{
	factory: function() {
		
		$('.fx_slide_over').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.BasicBox( this );
			}
			this.andwise.setPlugin( new Andwise.plugin.FxSlideOverflow( this.andwise ) );
		});
				
	},
	
	interval: 5000, // 슬라이드 효과에서 슬라이드 실행 주기, 기본 6000(6초)
	
	slideTime: 500, // 슬라이드 효과에서 슬라이드 효과 타임, 기본 300(0.3초)

	setup: function() {
		
		this.container.addListener('onfocus',this.onFocus.createDelegate(this));
		
		this.element.attr('jwxe_dir','+');
		this.element.css({overflow: 'visible'});
		
		this.imgs = this.target.find('img');
		
		this.boxwidth = this.element.width();

		
		//var targetLeft = parseInt( (boxwidth - activeWidth) /2 );
		var timeOut = 10;
		if(!this.getAcitveWidth(this.target)) {
			timeOut = 500;
		}
		if(this.target.length > 0) {
			setTimeout(function() {
					this.targetLeft = this.getTargetLeft(this.target);
					this.target.css({'position':'absolute','top':this.target[0].style.top, overflow: 'visible', 
						left: this.targetLeft+'px'});
			}.createDelegate(this),timeOut);
		}
		
	},
	onFocus: function() {
		
		this.target.css({left: this.targetLeft+'px'});
	},
	getAcitveWidth: function( target ) {
		
		var width = 0;
	    target.find('img').each(function() {
	      var thisWidth = $(this).width();
	      if(thisWidth > width ) {
	        width = thisWidth;
	      }
	    });
	    return width;
		
	},
	
	getTargetLeft: function( target ) {
		
		return parseInt( (this.boxwidth - this.getAcitveWidth(target)) /2 );
		
	}
});



/**
 * Fx FxDissolve plugin -------------------------------------------------------------------------------------------------------------------------------
 */

Andwise.plugin.FxDissolve = Andwise.extend(Andwise.plugin.FxSlide,{
	
	factory: function() {
			
		$('.tab_auto_play, .fx_dissolve').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.BasicBox(this);	
			}
			
			this.andwise.setPlugin( new Andwise.plugin.FxDissolve(this.andwise) );
		});
			
	},
	fadeTime: 1500, // 디졸브 효과에서 슬라이드 효과 타임, 기본 1500(1.5초)
	interval: 5000, // 디졸브 효과에서 디졸브 실행 주기, 기본 5000(5초)
	
	setup: function() {

		
		//this.target.css({'position':'absolute','left':'0'});
		this.container.element.attr('jwxe_dir','+');
		
		if(this.container.element.hasClass('no-effect')) {
			this.IsEffect = false;  
		} else {
			this.IsEffect = true;
		}  
		
		if(!this.container.alignTarget) {
			
			this.target.each(function(index, el) {
				
				var target = $(el), prevLink;
				
				if(index == 0 ) { // 선택된 링크가 없고 첫 탭이면 활성
					target.css({'display':'block','z-index':2});
					target.attr({'focused':'true','display':'block'});
					this.container.addClassParents( target, 'li','active');
					
					this.container.onTargetChange(target,'on');
				} else {
					target.css({'display':'none','z-index':''});
					target.attr({'focused':'false'});
					this.container.removeClassParents( target, 'li','active');
				}
				
			}.createDelegate(this));
			
		}
		
	},
	playTo: function(newIdx) {
		
		try {
		
			if(!this.getCanPlay()) return;
			
			if(this.getCurrentIndex() == newIdx ) return;
			
			clearTimeout(this.timeout);
			this.playing = true; // 작동중
			
			var idx = this.getCurrentIndex(), nidx = newIdx;
			var curUl = $(this.target[idx]), nextUl = $(this.target[nidx]);
			
			this.target.attr('focused','false');
			this.container.removeClassParents( this.target, 'li','active');
			this.container.onTargetChange(curUl,'off');

			curUl.css('display','none');				
			nextUl.css('display','block');				
			this.playing = false;
										
			nextUl.attr('focused','true');
			this.container.addClassParents( nextUl, 'li','active');
			
			this.container.onTargetChange(nextUl,'on');

			
		} finally {	
			this.timeout = setTimeout(this.playNext.createDelegate(this),this.options.interval || this.interval);
		}			
		
	},
	playNext: function(effect) {
		
		try {
			if(!this.getCanPlay()) return;
			clearTimeout(this.timeout);
			this.playing = true; // 작동중
			
			var idx = this.getCurrentIndex(), nidx = this.getNextIndex(idx);
			var curUl = $(this.target[idx]), nextUl = $(this.target[nidx]);
			
			this.target.attr('focused','false');
			this.container.removeClassParents( this.target, 'li','active');
			
			this.container.onTargetChange(curUl,'off');
			
			if(this.IsEffect) {
				curUl.fadeOut(effect == false? 200: this.options.fadeTime || this.fadeTime,function() {
					if(curUl.attr('focused') == 'true' ) {
						curUl.css({'display':'block'});
					} else {
						curUl.css({'display':'none'});
					}
				}.createDelegate(this));
				nextUl.fadeIn(effect == false? 200: this.options.fadeTime || this.fadeTime,function() {
						this.playing = false;
				}.createDelegate(this));							
			} else {
				curUl.css('display','none');				
				nextUl.css('display','block');				
				this.playing = false;
			}
										
			nextUl.attr('focused','true');
			this.container.addClassParents( nextUl, 'li','active');
			
			this.container.onTargetChange(nextUl,'on');
		
		} finally {	
			this.timeout = setTimeout(this.playNext.createDelegate(this),this.options.interval || this.interval);
		}	
		
	},
	playPrevious: function(effect) {

		try {
			if(!this.getCanPlay()) return;
			clearTimeout(this.timeout);
			this.playing = true; // 작동중
			
			var idx = this.container.getCurrentPosition(), pidx = this.getPreIndex(idx);
			var curUl = $(this.target[idx]), preUl = $(this.target[pidx]);
			
			this.target.attr('focused','false');
			this.container.removeClassParents( this.target, 'li','active');
			
			this.container.onTargetChange(curUl,'off');
			
			if(this.IsEffect) {
			
				curUl.fadeOut(effect == false? 200: this.options.fadeTime || this.fadeTime,function() {
					if(curUl.attr('focused') == 'true' ) {
						curUl.css({'display':'block'});
					} else {
						curUl.css({'display':'none'});
					}
				}.createDelegate(this));
				preUl.fadeIn(effect == false? 200: this.options.fadeTime || this.fadeTime,function() {
					this.playing = false;
				}.createDelegate(this));							
				
			} else {
				curUl.css('display','none');
				preUl.css('display','block');
				this.playing = false;
			}							

			preUl.attr('focused','true');
			this.container.addClassParents( preUl, 'li','active');
			this.container.onTargetChange(preUl,'on');
		} finally {	
			this.timeout = setTimeout(this.playPrevious.createDelegate(this),this.options.interval || this.interval);
		}	
	}
});



/**
 * Left Right Scroll plugin
 */
Andwise.plugin.FxHorizScroll = Andwise.extend(Andwise.plugin.Fx,{
	factory: function() {
		
		$('.fx_hscroll').each(function() {
			if(!this.andwise) {
				this.andwise = new Andwise.app.BasicBox(this);	
			} 
			this.andwise.setPlugin( new Andwise.plugin.FxHorizScroll(this.andwise) );
		});
				
	},
	scrollStep: 1, // // 스크롤 효과에서 한번에 이동할 픽셀, 기본(1)
	interval: 40,  // 스크롤 효과에서 스크롤 주기 (적을수록 빠르게 이동), 기본 (40)
	init: function() {
		
		var left = 0;
		this.container.element.attr("jwxe_dir", "+");
		this.target = this.container.getTargetEl();
		this.setup();
		this.play();
		
	},
	setup: function() {

		var left = 0, me = this, imgLoaded = true;
		
		for(var i=0; i< this.target.length; i++ ) {
			
			var a = $(this.target[i]), width = a.width();
			
			if(width == 0) {
				imgLoaded = false;
				setTimeout(this.setup.createDelegate(this),200);
				return;
			}
			
			a.css({'left':left+'px','top': me.options.top || 0});
			left += a.width()+(me.options.leftmargin || 5);
			
		};
		
		
		if(imgLoaded)
			this.play();
		
		
	},
	getCanPlay: function() {
		if(this.target.length < 2) {
			return false;
		}
		
		if(this.pause == true) {
			return false;
		}		
		if(this.isFocused()) { // 마우스가 올라가있으면 중지
			return false;
		}
		return true;
		
	},
	playNext: function( effect ) {
		
		var box = this.container.element;
		box.attr('jwxe_dir','-');
		
		if(effect == false) {
			this.gotoNext();
		} else {
			this.fxNext();			
		}
		
	},
	getPrevPosition: function( next ) {

		var box = this.container.element, left;
		var prev = box.scrollLeft();
		for(var i=0; i<this.target.length; i++) {
			var el = Andwise.$(this.target.get(i));
			left = el.css('left').toInt();
			if(left > prev) {
				return i; 
			} 	
		}
		return 0;
	},
	
	getNextPosition: function( next ) {

		var box = this.container.element, left;
		var prev = box.scrollLeft();
		for(var i=this.target.length-1; i>=0; i--) {
			var el = Andwise.$(this.target.get(i));
			left = el.css('left').toInt();
			if(left < prev) {
				return i; 
			} 	
		}
		return this.target.length-1;
	},
	gotoNext: function() {

		var box = this.container.element;
		var pos = this.getNextPosition(false);
		
		if(pos+1 == this.target.length) {
			return;
		}
		//console.log(pos);
		this.goPosition = Andwise.$(this.target.get(pos)).css('left').toInt();
		this.goStep = box.scrollLeft();
		this.goNextFx();
		//box.scrollLeft(Andwise.$(this.target.get(pos)).css('left').toInt());
		
	},
	goNextFx: function() {
		if(this.goStep <= this.goPosition) {
			return;
		}
		setTimeout(function(){
			this.goStep -=10;
			this.container.element.scrollLeft(this.goStep);
			this.goNextFx();
		}.createDelegate(this),5);
	},
	fxNext: function() {
		
		var box = this.container.element;
		var prev = box.scrollLeft();
		box.scrollLeft(box.scrollLeft()-(this.options.scrollStep || this.scrollStep));
		
		if(prev == box.scrollLeft()) {
			box.attr("jwxe_dir", "+");
		}
		
	},
	playPrevious: function( effect ) {
		
		var box = this.container.element;
		box.attr('jwxe_dir','+');
		if(effect == false) {
			this.gotoPrevious();
		} else {
			this.fxPrevious();			
		}
	},
	gotoPrevious: function() {
		
		var box = this.container.element;
		var pos = this.getPrevPosition();
		
		this.goPosition = Andwise.$(this.target.get(pos)).css('left').toInt();
		this.goStep = box.scrollLeft();
		this.goPreviousFx();
		//box.scrollLeft(Andwise.$(this.target.get(pos)).css('left').toInt());
		
		
	},
	goPreviousFx: function() {
		if(this.goStep >= this.goPosition) {
			return;
		}
		setTimeout(function(){
			this.goStep +=10;
			this.container.element.scrollLeft(this.goStep);
			this.goPreviousFx();
		}.createDelegate(this),5);
	},
	fxPrevious: function() {
		var box = this.container.element;
		var prev = box.scrollLeft();
		box.scrollLeft(box.scrollLeft()+(this.options.scrollStep || this.scrollStep));
		if(prev == box.scrollLeft()) {
			box.attr("jwxe_dir", "-");
		}
		
	},
	play: function() {
		
			setInterval(
			
				function() {
					
					if(!this.getCanPlay()) return;

					var dir = this.container.element.attr('jwxe_dir');
					
					if(dir == '+') {
						this.playPrevious();
					} else {
						this.playNext();
					}
					
				}.createDelegate(this)
				,this.options.interval || this.interval
			);				
	}
});

