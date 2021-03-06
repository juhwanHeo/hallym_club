<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko" class="no-js" style="height: 100%;">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
	<!--css-->
        <link rel="canonical" href="http://hleague.hallym.ac.kr/index.do">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/main/res/league/css/owl.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
        <link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
        <link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
        
        <!--js-->
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
        <script defer="" type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
        <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
        <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
        <script type="text/javascript">
	        //<![CDATA[
			var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
			,_cur_menu_cd = '4131',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/res/league/'
			,editorVendor = '',sslYN = 'N',sslPort = '8443',servicePort = '',developMode = false,device='pc',isMobile=false
			,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = ''
			,locale= 'ko',localeScriptPath='${pageContext.request.contextPath}/custom/js/';
			//]]>	
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
        <script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
        <style type="text/css"></style>
        <script type="text/javascript" src="${pageContext.request.contextPath}/main/res/league/js/user/owl.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/main/res/league/js/user/visual.js"></script>
        <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
        <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20200506_00/e/js/element/element_main.js"></script>
        
</head>
<body id="item_body" class="pc" style="position: relative; min-height: 100%; top: 0px;">
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
	</ul>
	<div class="wrap">
		<header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
		<div class="container">
			<div class="main-visual-wrap"><jsp:include page="/WEB-INF/jsp/item/main-visual.jsp"/></div>
			<div class="main-content-wrap01" id="jwxe_main_content"><jsp:include page="/WEB-INF/jsp/item/main-content01.jsp"/></div>
			<div class="main-content-wrap02"><jsp:include page="/WEB-INF/jsp/item/main-content02.jsp"/></div>
		</div>
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
	</div>
</body>
</html>