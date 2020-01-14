<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:useBean id="clubDAO" class="exam.jdbc.JDBC_clubDAO" />
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/club_main.css">
</head>
<body>
	<%
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		int club_id = Integer.parseInt(request.getParameter("club_id"));
		String club_name = clubDAO.getClubNMs(club_id);

		/* club_NM = "한림특허청"; */
		String open_dt = clubDAO.getOpen_Dt(club_id);
		String masterNm = clubDAO.getMaster(club_id);
		
		int join_cd = clubDAO.getJoin_cd(username, club_name);
	%>

	<div id="wrap">
		<div id="header">
			<h1>
				<a href="index.jsp"><img src="image/logo.gif" alt="한림대학교 동아리"></a>
			</h1>
			<a href="index.jsp" class="skip">본문 바로가기</a>

			<!-- <ul id="snb">
				<li><a href="index.html">로그인</a></li>
				<li><a href="index.html">회원가입</a></li>
			</ul> -->

			<ul id="gnb">
				<li><a href="">가입 동아리</a>
					<ul>
						<%
							ArrayList<String> joinMyClub = clubDAO.getMyJoinClubList(username);
							int totalNum = joinMyClub.size();
							if (totalNum > 0) {
								for (int index = 0; index < totalNum; index++) {
						%>
						<li>
							<form method="post">
								<input type="button" value=<%=joinMyClub.get(index)%>
									onclick="location.href ='club_intro.jsp?club_id=<%=clubDAO.getClubIds(joinMyClub.get(index))%>'" />
							</form>
						</li>
						<%
							}
							}
						%>
					</ul></li>
				<li><a href="">가입 승인 중 동아리</a>
					<ul>
						<%
							ArrayList<String> WaitMyClub = clubDAO.getMyWaitClubList(username);
							totalNum = WaitMyClub.size();
							if (totalNum > 0) {
								for (int index = 0; index < totalNum; index++) {
						%>
						<li>
							<form method="post" action="applyDeleteAction.jsp"
								onSubmit="return confirm('가입 신청을 취소하시겠습니까?');" align="center">
								<input type="text" name="clubNM" readOnly
									value=<%=WaitMyClub.get(index)%>
									style="width: 70px; height: auto;"> <input
									type="submit" value="신청 취소">
							</form> <script>
								function postPopUp() {
									window
											.open('', 'w',
													'width=900,height=650,location=no,status=no');
									return true;
								}
							</script>
						</li>
						<%
							}
							}
						%>
					</ul></li>
			</ul>
		</div>
		<hr>
		<div id="visual">
			<img src="image/visualEx.jpg" alt="">
		</div>
		<br>
		<hr>
		<!-- <div id="content"> -->
		<div class="latest">
			<form method="post" name="form">
				<div class="notice">
					<h4>카페
						정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="나의정보" style="background-color:transparent;  border:0px transparent solid;"
					onclick="location.href ='applyMod.jsp?club_id=<%=club_id%>';" /></h4>
					<ul>
						<div class="icon">
							<img src="image/thm_clubEx.gif" alt="">
						</div>
						<li><input type="text" name="club_name" value=<%=club_name%> size=16
							readonly></li>
						<li>회장 : <%=masterNm%></li>
						<li style="border-bottom: 2px solid #797979;">개설일 : <%=open_dt%></li>
					</ul>
					<hr>

					<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
						<li style="font-size: 13px; border-bottom: 0.5px solid #797979;">동아리</li>
						<li style="margin-left: 15px;"><input type="button"
							value="소개"
							onclick="location.href ='club_intro.jsp?club_id=<%=club_id%>';" /></li>
						<li style="margin-left: 15px;"><input type="button"
							value="물품목록"
							onclick="location.href ='club_item.jsp?club_id=<%=club_id%>';" /></li>
						<li style="margin-left: 15px;"><input type="button"
							value="예산"
							onclick="location.href ='club_budget.jsp?club_id=<%=club_id%>';" /></li>
						<li style="margin-left: 15px;"><input type="button"
							value="회원목록"
							onclick="location.href ='club_member.jsp?club_id=<%=club_id%>';" /></li>
					</ul>
					<hr>

					<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
						<li style="font-size: 13px; border-bottom: 0.5px solid #797979;">게시판</li>
						<li style="margin-left: 15px;"><input type="button"
							value="공지사항"
							onclick="location.href='myClub_Board.jsp?club_id=<%=club_id%>&board_cd=007001';" /></li>
						<li style="margin-left: 15px;"><input type="button"
							value="자유게시판"
							onclick="location.href='myClub_Board.jsp?club_id=<%=club_id%>&board_cd=007002';" /></li>
						<li style="margin-left: 15px;"><input type="button"
							value="사진"
							onclick="location.href='myClub_Board.jsp?club_id=<%=club_id%>&board_cd=007003';" /></li>
						<li style="margin-left: 15px;"><input type="button"
							value="일정"
							onclick="location.href='club_calendar.jsp?club_id=<%=club_id%>&board_cd=007004';" />

						</li>
						<li style="margin-left: 25px;"><input type="button"
							value="└개인 정보 동의"
							onclick="location.href='myClub_Board.jsp?club_id=<%=club_id%>&board_cd=007004';" /></li>
							<%if (join_cd == 0) { %>
						<li style="margin-left: 25px;"><input type="button"
							value="└개인 정보 동의 목록"
							onclick="location.href='club_agreeMember.jsp?club_id=<%=club_id%>&title_no=-1';" /></li>
							<%} %>
					</ul>
					<hr>


					<%
						/* int join_cd = clubDAO.getJoin_cd(username, club_name); */

						if (join_cd == 0) {
					%>
					<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
						<li style="font-size: 13px; border-bottom: 0.5px solid #797979;">동아리 관리</li>
						<li style="margin-left: 15px;"><input type="button" value="동아리 회원 승인"
					onclick="location.href='manage.jsp?club_id=<%=club_id%>';" /></li>
						<li style="margin-left: 15px;"><input type="button" value="동아리 회원 관리"
					onclick="location.href='manage_list.jsp?club_id=<%=club_id%>';" /></li>
						<li style="margin-left: 15px;"><input type="button" value="동아리 정보 수정"
					onclick="location.href='updateClub.jsp?club_id=<%=club_id%>';" /></li>
					</ul>
					<hr>
					<%
						}
					%>
				
			</form>
			
			<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
				<form method="post" action="applyDeleteAction.jsp"
					onSubmit="return confirm('탈퇴 신청을 하시겠습니까?');">
					<input type="hidden" name="clubNM" value=<%=club_name%>> <input
						type="submit" value="탈퇴 하기"
						style="background-color: transparent; border: 0px transparent solid; cursor: pointer;">
				</form>
			</ul>
			<hr>
		</div>
		<!-- 	</div> -->

		<!-- <div class="main">
				<img width="980" height="700" src="img/clubposter/prac1.jpg" alt="">
			</div> -->

		<hr>
		<div id="footer">
			<div class="copyright">
				<address>Copyright 2019. 김정인, 김진섭. All Rights Reserved.</address>
			</div>
		</div>
	</div>
</body>
</html>