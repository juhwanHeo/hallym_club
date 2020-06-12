$(function(){
	$(".btn-menu").click(function(){
		$(".slideMenu").animate({
			right : "0"
		},300);
		$(".slideMenu").show();
		$(".m-gnb-bg").show();
		$(".slide-close").show();
		$("body").addClass('over-hidden');
	});

	$(".slide-close").click(function(){
		$(".slideMenu").animate({
			right : "-100%"
		},300);
		$(".slideMenu").hide(10);
		$(".m-gnb-bg").hide();
		$(".slide-close").hide();
		$("body").removeClass('over-hidden');
	});
	$(".dep1 > li > a").click(function() {
		if($(this).next().is(':hidden')){
			$(this).parent().find(".dep2").slideUp().siblings(".dep2").slideDown();
			/*$(this).parent().find(".dep3").slideUp();*/
			$(this).addClass("selected");
			$(this).next(".dep2").slideDown();
			$(this).parent().siblings().find(".dep2").slideUp();
			$(this).parent().siblings().find(".selected").removeClass("selected");
		}else{
			$(this).next(".dep2").slideUp();
			$(this).removeClass("selected");               
		}
		return false;
	});

	$(".dep2 > li > a").click(function() {
		if($(this).next().is(':hidden')){
			$(this).parent().find(".dep3").slideUp().siblings(".dep3").slideDown();
			$(this).parent().find(".dep3").slideUp().slideDown();
			$(this).addClass("selected");
			$(this).next(".dep3").slideDown();
			$(this).parent().siblings().find(".dep3").slideUp();
			//$(this).parent().siblings().find(">a").removeClass("selected");
			$(this).parent().siblings().find(".selected").removeClass("selected");
		}else{
			$(this).next(".dep3").slideUp();
			$(this).removeClass("selected");
		}      
	});

	$(function(){
		var hasDep = $(".dep3").parents(".dep2 > li").find("a:first");

		hasDep.addClass("has-dep03-open").attr('href', '#nomenu');
		$(".dep3").parents(".dep2 > li").each(function(){
			$(this).click(function(){
				$(this).find("a:first").switchClass("has-dep03-open", "has-dep03-close");
				$(".dep3").parents(".dep2 > li").find("a:first").not("a.selected").removeClass("has-dep03-close").removeClass("depth02-active").addClass("has-dep03-open");
				$(".dep3 > li > a.active").parents(".dep2 > li").find("a:first").addClass("depth02-active");
				$(this).find("a:first.selected").addClass("depth02-active");
			});
		});

		$(".dep1 > li > a.active").parents(".dep1 > li").find(".dep2").show();
		$(".dep3 > li > a.active").parents(".dep2 > li").find(".dep3").show();
		$(".dep3 > li > a.active").parents(".dep2 > li").find("a:first").switchClass("has-dep03-open", "has-dep03-close");
		$(".dep2 > li").find("a:first").removeClass("depth02-active");
		$(".dep3 > li > a.active").parents(".dep2 > li").find("a:first").addClass("depth02-active");

	});

	$(".dep3 > li > a").click(function() {
		$(this).addClass("selected");
		$(this).parent().siblings().find(">a").removeClass("selected");
	});


});