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

<style>

#ggnb {position:absolute; top:0; left:300px; width:600px; height:50px; margin:0; padding:0; list-style:none;}
#ggnb li {float:left; width:150px; height:50px; margin:0; padding:0;}
#ggnb li ul {
   background: white;
   display: none;
   width: 25%;
   height: auto;
   padding: 0px;
   margin: 0px;
   border: 0px;
   position: absolute;
   top:50px;
   z-index: 200;
   font-size:13px;
}
#ggnb li ul li{float:center; width:150px; height:23px; margin:0; padding:0; }

#ggnb li:hover ul {
   display: block; 
}
#ggnb a {float:left; width:150px; height:50px; font-weight:600; font-size:15px; line-height:50px; text-align:center;}



</style>
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
		<li><span class="txt" onclick="location.href='myPage.jsp'" style="cursor:pointer;"><%out.print(username + " 님 환영합니다.");%></span></li>
		<li><a href='logoutAction.jsp'>로그아웃</a></li>
		<%
			if (userId.equals("20185289") || userId.equals("20185304") || userId.equals("20185280") || userId.equals("20765")) {
		%>
		<li><a href="club_manage.jsp">동아리 관리</a></li>
		<%
			}
		%>
		<!-- <li><a href="myPage.jsp">myPage</a></li> -->
	</ul>
	
	<%
		}
	%>


	

		<ul id="gnb">
			<li><a href="club_search.jsp">조회 및 가입</a></li>
			<li><a href="top_club.jsp">우수동아리</a></li>
			<li><a href="board.jsp">공지사항</a></li>
			<li><a href="createClub.jsp">개설</a></li>
		</ul>
</body>
</html>