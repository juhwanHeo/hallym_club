<%@page import="java.util.ArrayList"%>
<%@page import="user.UserVO"%>
<jsp:useBean id="clubDAO" class="club.ClubDAO" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
</head>
<body>

	<%
		UserVO userVO = null;
		String userId = null;
		String username = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
			username = userVO.getName();
		}
	%>

	<h1>
		<a href="index.jsp"><img src="image/logo.gif" alt="한림대학교 동아리"></a>
	</h1>
	<a href="#content" class="skip">본문 바로가기</a>

	<%
		if (userId == null) {
	%>
	<ul id="snb">
		<li><a href="login.jsp">로그인</a></li>
		<!-- <li><a href="index.jsp">회원가입</a></li> -->
	</ul>
	<%
		} else {
	%>
	<ul id="snb">
		<li><span class="txt"> <%
 	out.print(username + " 님 환영합니다.");
	 %>				
		</span></li>
		<li><a href='logoutAction.jsp'>로그아웃</a></li>
		<%
			if (userId.equals("20185289") || userId.equals("20185304") || userId.equals("20185280")) {
		%>
		<li><a href="club_manage.jsp">동아리 관리</a></li>
		<%
			}
		%>
	</ul>
	<%
		}
	%>

	<ul id="gnb">
		<li><a href="club_search.jsp">동아리조회</a></li>
		<li><a href="top_club.jsp">우수동아리</a></li>
		<li><a href="board.jsp">공지사항</a></li>
		<li><a href="createClub.jsp">동아리 등록</a></li>
	</ul>
</body>
</html>