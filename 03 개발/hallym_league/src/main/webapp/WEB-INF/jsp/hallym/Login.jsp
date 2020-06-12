<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="hallym.league.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Login</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
	<!--css-->
	<link rel="canonical" href="http://league.hallym.ac.kr/league/board/photos.do" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" />

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css" />
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
		,editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = '',developMode = false,device='pc',isMobile=false
		,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = ''
		,locale= 'ko',localeScriptPath='${pageContext.request.contextPath}/custom/js/';
	//]]>
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
</head>
<body id="item_body" class="pc">
<%
	Cookie[] cookies = request.getCookies();
	String ID = "";
	String GBN = "";
	if(cookies != null) {
		for(Cookie c : cookies) {
			if(c.getName().trim().equals("ID")) {
				ID = c.getValue();
			} else if(c.getName().trim().equals("GBN")) {
				GBN = c.getValue();
			}
		}
	}

%>
	<ul id="go_main">
		<li><a href="#jwxe_main_content" >본문 바로가기</a></li>
		<li><a href="#jwxe_main_menu" >주메뉴 바로가기</a></li>
		<li><a href="#jwxe_sub_menu" >서브메뉴 바로가기</a></li>
	</ul>
	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
		<div class="sub-visual-wrap"></div>
		<div class="path-wrap">
            <div class="path-box">
                <div class="jwxe_navigator jw-relative">
                    <ul>
                        <li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>기타</li>
                        <li>로그인</li>
                    </ul>
                </div>
            </div>
        </div>
        <!--로그인-->
		<div class="sub-container">	
			<!--게시판 메뉴-->
			<div class="lnb-wrap">
				<div class="lnb">
					<div class="lnb-title-box">
						<div>			
							<h2>기타</h2>
						</div>
					</div>
					<ul class="lnb-menu jwxe-menu-ul">
						<li>
							<a href="/login.do" >로그인</a>
						</li>
					</ul>
				</div>
			</div>
	              
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>로그인</h3>
                    </div>
                </div>
                <div class="tab"></div>
                <div class="content" id="jwxe_main_content">
                    
                    <div class="bn-login01 type01">
                        <div class="b-login-etc-box">
                             <p><img src="images/board/logo-login.gif" alt="한림대학교 HALLYM UNIVERSITY"></p>
                             <p>
                                 <span>LOGIN</span>
                                 <span>로그인 후 이용할 수 있습니다.</span>
                                </p>
                        </div>
                        <form id="loginForm" class="b-login-box jw-form-valid" method="post" action="/login.do">
                            <fieldset class="b-login-zone">
                                <legend class="hide">로그인</legend>
                    
                                <input type="hidden" name="referer" value="">
                                <input type="hidden" name="site_id" value="support">
                                
                                <!--로그인박스  -->
                                <div class="b-login-link-wrap">
                                    <ul>
                                        <li>
                                            <input type="radio" id="loginS" name="gbn" class="b-radio" value="S" <% if(GBN.isEmpty() || GBN.equalsIgnoreCase("S")) out.print("checked"); %>>
                                            <label for="loginS">학부생</label>
                                        </li>
                                        <li>
                                            <input type="radio" id="loginG" name="gbn" class="b-radio" value="G" <% if(GBN.equalsIgnoreCase("G")) out.print("checked"); %>>
                                            <label for="loginG">대학원생</label>
                                        </li>
                                        <li>
                                            <input type="radio" id="loginO" name="gbn" class="b-radio" value="O" <% if(GBN.equalsIgnoreCase("O")) out.print("checked"); %>>
                                            <label for="loginO">교직원</label>
                                        </li>
                                    </ul>
                                    <div>							
                                        <input type="checkbox" id="chk_id" name="chk_id" value="Y"
                                        <% if(ID.length() > 0) out.println("checked"); %>>
                                        <label for="chk_id">아이디 저장</label>
                                    </div>
                                </div>
                                <div class="b-login-input-wrap">
                                    <label for="member_id" class="id hide">아이디</label>
                                    <input type="text" id="member_id" name="user_id" title="아이디" placeholder="아이디" maxlength="30" class="jwvalid-must" data-valid-title="아이디" value="<%=ID %>">
                                    <label for="member_pw" class="pw hide">비밀번호</label>
                                    <input type="password" id="member_pw" name="password" title="비밀번호" placeholder="비밀번호" maxlength="30" class="jwvalid-must" data-valid-title="비밀번호">	
                                </div>
                
                                <!-- 로그인 버튼 -->
                                <button type="submit" class="b-btn-login" value="LOGIN ">로그인</button>
                                <!-- 회원가입/비밀번호찾기 -->
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
		<!--마지막페이지-->
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
	</div>
	<noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>