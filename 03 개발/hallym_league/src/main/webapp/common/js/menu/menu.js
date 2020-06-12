if(!window.App) {
	App = {};
}
if(!App.CMSMenu){
	App.CMSMenu = {};
}

$(function() {

	var app = new App.CMSMenu();
	
    //----------------------------------
    //실행 오브젝트 목록
    //----------------------------------
    app.init();
    
});



//-----------------------------------------------------------------------------------------
// Menu 관련
//-----------------------------------------------------------------------------------------  
App.CMSMenu = function(){
	
	var self;
	
	return {
		init: function(){
			
			self = this;
			
			$("ul.jwxe-menu-ul a").each(function() {
			   var active =  $(this).hasClass("active") ;
			   if( active ) {
					$(this).parent().addClass("active");	
			   }
			});
				
			// 모바일 탭메뉴 : 선택시 해당 메뉴 페이지로 이동.
			self.mobileTabSelected();
			
		},
		/**
		 * 모바일 탭메뉴 : 선택시 해당 메뉴 페이지로 이동.
		 */
		mobileTabSelected : function() {
			
			var select = $("select#tab_sel");
			var select_name = $(".tab_sel").children("option:selected").text();
			$(".tab_sel").siblings("label").text(select_name);
			
			select.change(function(){	
				var select_name = $(this).children("option:selected").text(), url = $(this).children("option:selected").val();
				$(this).siblings("label").text(select_name);
				if( url != '')	location.href = url;
			});
			
		}
	}
};

