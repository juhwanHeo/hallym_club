<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="hallym.league.user.vo.UserVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		String cusername = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = ((UserVO) session.getAttribute("userVO"));
			cuserId = cuserVO.getId();
			cusername = cuserVO.getName();
		}
	%>
	<div class="bottom-header-box">
		<a class="btn-menu" href="#a"><span class="hide">모바일 메뉴 열기</span></a>
		<h1>
			<a href="/${siteId}" title="한림대학교 일반대학원 바로가기">
				<img src="${pageContext.request.contextPath}/images/common/img-logo.png" alt="한림대학교">
				<span>Intramural League</span>
			</a>
		</h1>
		<!--
		<div class="gnb">
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/menu/gnb/pc/gnb_type04" />
				<c:param name="depth" value="2" />
			</c:import>            
		</div>
		-->
		<div class="gnb">
			<ul class="gnb-ul jwxe-menu-ul">
				<li>
				 	<a title="소개" href="/league/newFolder/graduate/dean.do" class="">
				 		<span>소개</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/league/newFolder/graduate/dean.do">Intramural League 소개</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="이벤트 리그" href="/BoardSearch.do?&bdc=007207">
				 		<span>이벤트 리그</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/BoardSearch.do?&bdc=007207">풋살</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007202">길거리 농구</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="참가 신청" href="/BoardSearch.do?&bdc=007001">
				 		<span>참가 신청</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/BoardSearch.do?&bdc=007001">축구</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007002">농구</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007003">야구</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007006">족구</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007004">배드민턴</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007010">테니스</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007009">피구</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007007">풋살</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007008">탁구</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="게시판" href="/BoardSearch.do?&bdc=007101" class="">
				 		<span>게시판</span>
				 			<span>notice</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/BoardSearch.do?&bdc=007101">공지사항</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007102">Photos</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007103">경기영상</a>
						</li>
						<li>
							<a href="/BoardSearch.do?&bdc=007104">News</a>
						</li>
					</ul>
				</li>
			</ul>			
		</div>
	</div>
	<nav class="slideMenu">
	<div class="m-util">
		<ul>
			<li><a href="/index.do" title="home 바로가기">Home</a></li>
			<li><a href="#a" title="사이트맵 보기" class="sitemap-btn">Sitemap</a></li>
		<%	if(cuserId == null) { %>
			<li class="login">
				<a href="/login.do" class="login" title="Login">Login</a>
			</li>
		<%	} else { %>
			<li class="profile">
				<a href="/profile.do" class="profile" title="Profile"><%=cusername%>님</a>
			</li>
			<li class="logout">
				<a href="/logout.do" class="logout" title="Logout">Logout</a>
			</li>
		<%	} %>
		</ul>
	</div>
	<!--
		<div class="m-gnb">
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/menu/gnb/mobile/gnb_type01" />
				<c:param name="depth" value="3" />
			</c:import>
		</div>
		-->
	<div class="m-gnb">
		<ul class="dep1 jwxe-menu-ul">
			<li><a href="/league/newFolder/graduate/dean.do">소개</a>
				<ul class="dep2">
					<li><a href="/league/newFolder/graduate/dean.do">Intramural
							League 소개</a></li>
				</ul></li>
			<li><a href="/BoardSearch.do?&bdc=007207">이벤트 리그</a>
				<ul class="dep2">
					<li><a href="/BoardSearch.do?&bdc=007207">풋살</a></li>
					<li><a href="/BoardSearch.do?&bdc=007202">길거리 농구</a></li>
				</ul></li>
			<li><a href="/BoardSearch.do?&bdc=007001">참가 신청</a>
				<ul class="dep2">
					<li><a href="/BoardSearch.do?&bdc=007001">축구</a></li>
					<li><a href="/BoardSearch.do?&bdc=007002">농구</a></li>
					<li><a href="/BoardSearch.do?&bdc=007003">야구</a></li>
					<li><a href="/BoardSearch.do?&bdc=007006">족구</a></li>
					<li><a href="/BoardSearch.do?&bdc=007004">배드민턴</a></li>
					<li><a href="/BoardSearch.do?&bdc=007010">테니스</a></li>
					<li><a href="/BoardSearch.do?&bdc=007009">피구</a></li>
					<li><a href="/BoardSearch.do?&bdc=007007">풋살</a></li>
					<li><a href="/BoardSearch.do?&bdc=007008">탁구</a></li>
				</ul></li>
			<li><a href="/BoardSearch.do?&bdc=007101">게시판</a>
				<ul class="dep2">
					<li><a href="/BoardSearch.do?&bdc=007101">공지사항</a></li>
					<li><a href="/BoardSearch.do?&bdc=007102">Photos</a></li>
					<li><a href="/BoardSearch.do?&bdc=007103">경기영상</a></li>
					<li><a href="/BoardSearch.do?&bdc=007104">News</a></li>
				</ul></li>
		</ul>
	</div>
	</nav>
	<a href="#a" class="slide-close"><span class="hide">모바일 메뉴 닫기</span></a>
	<div class="m-gnb-bg">&nbsp;</div>
	<!-- 사이트 맵 -->
	<div class="sitemap-wrap">
		<div class="sitemap-box">
			<!--
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/site-map/site_map" />
			</c:import>
		-->
			<ul>
				<li id="menu_4137" class="depth_1 first"><a
					href="/league/newFolder/graduate/dean.do" class="depth_1 ">소개</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first"><a
							href="/league/newFolder/graduate/dean.do" class="depth_2 ">Intramural
								League 소개</a></li>
					</ul></li>
				<li id="menu_4138" class="depth_1"><a
					href="/BoardSearch.do?&bdc=007202" class="depth_1 ">이벤트 리그</a>
					<ul class="depth_2">
						<li id="menu_4441" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007207" class="depth_2 ">풋살</a></li>
						<li id="menu_4435" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007202" class="depth_2 ">길거리 농구</a></li>
					</ul></li>
				<li id="menu_4138" class="depth_1"><a
					href="/BoardSearch.do?&bdc=007001" class="depth_1 ">참가 신청</a>
					<ul class="depth_2">
						<li id="menu_4146" class="depth_2 first"><a
							href="/BoardSearch.do?&bdc=007001" class="depth_2 ">축구</a></li>
						<li id="menu_4435" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007002" class="depth_2 ">농구</a></li>
						<li id="menu_4436" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007003" class="depth_2 ">야구</a></li>
						<li id="menu_4437" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007006" class="depth_2 ">족구</a></li>
						<li id="menu_4438" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007004" class="depth_2 ">배드민턴</a></li>
						<li id="menu_4439" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007010" class="depth_2 ">테니스</a></li>
						<li id="menu_4440" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007009" class="depth_2 ">피구</a></li>
						<li id="menu_4441" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007007" class="depth_2 ">풋살</a></li>
						<li id="menu_4442" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007008" class="depth_2 ">탁구</a></li>
					</ul></li>
				<li id="menu_4141" class="depth_1"><a
					href="/BoardSearch.do?&bdc=007101" class="depth_1 ">게시판</a>
					<ul class="depth_2">
						<li id="menu_4157" class="depth_2 first"><a
							href="/BoardSearch.do?&bdc=007101" class="depth_2 ">공지사항</a></li>
						<li id="menu_4131" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007102" class="depth_2 ">Photos</a></li>
						<li id="menu_4133" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007103" class="depth_2 ">경기영상</a></li>
						<li id="menu_4130" class="depth_2"><a
							href="/BoardSearch.do?&bdc=007104" class="depth_2 ">News</a></li>
					</ul></li>
			</ul>
			<a href="#" title="닫기" class="sitemap-close">
				<img src="${pageContext.request.contextPath}/images/board/btn-sitemap-close.png" alt="닫기">
			</a>
		</div>
	</div>
	<!-- //사이트 맵 -->
</body>
</html>