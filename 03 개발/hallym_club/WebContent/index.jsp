<%@page import="club.ClubDAO"%>
<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="club.ClubVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/default.css?after">

</head>

<body>

	<%
		request.setCharacterEncoding("UTF-8");
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}

		if (session.getAttribute("club_id") != null) {
			session.removeAttribute("club_id");
		}
		
		if(session.getAttribute("staff_cd") != null) {
			session.removeAttribute("staff_cd");
		}
	%>

	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>

		<hr>
		<div id="visual">
			<img src="image/visual.jpg" alt="">
		</div>

		<hr>

		<div id="content">
			<div class="latest">
				<div class="notice">
					<h2>공지사항</h2>
					<ul>
						<jsp:useBean id="bbsDao" class="bbs.BbsDAO" />
						<%
							ArrayList<Bbs> bbs = bbsDao.get_intro(1, "007001");
							if (bbs != null) {
								for (Bbs vo : bbs) {
						%>
						<li>
								<%
									String fix = vo.getBOARD_FIX();
									if(fix.equalsIgnoreCase("Y")) {
								%>
							<img src="image/ic_notice.gif" border="0" valign="middle" alt="고정글">
								<% 	} %>
							
							<a href="view.jsp?BOARD_NO=<%=vo.getBOARD_NO()%>&club_id=1&board_cd=007001"><%=vo.getTITLE()%> </a>
							<span class="date"><%=vo.getINPUT_DATE()%></span></li>
						<%
								}
							}
						%>
					</ul>
					<a href="board.jsp" class="more">더보기</a>
				</div>
				
				<%-- <%if(userId == null) { %> --%>
				
				
				<div class="banner">
					<h2>배너</h2>
					<p>
						<img src="image/banner.gif" alt="지금 로그인하고 다양한 동아리를 만나세요!">
					</p>
				</div>
				
				<%-- <% } else { 
					
					ClubDAO clubDAO = new ClubDAO();
					ArrayList<String> WaitMyClub = clubDAO.getMyWaitClubList(userId);
					int totalNum = WaitMyClub.size();
					
					%>
				
				
				<div class="banner">	
					<li> 가입 승인 중 동아리 </li>
				<% 
					if (totalNum > 0) {
						for (int index = 0; index < totalNum; index++) {
						
				
					
				%>
					<ul>
						<li>
							<form method="post" action="applyDeleteAction.jsp"
								onSubmit="return confirm('가입 신청을 취소하시겠습니까?');" align="center">
								<input type="text" name="clubNM" readOnly
									value=<%=WaitMyClub.get(index)%>
									style="width: 70px; height: auto;"> <input
									type="submit" value="신청 취소">
							</form> <script>
								function postPopUp() {
									window.open('', 'w',
													'width=900,height=650,location=no,status=no');
									return true;
								}
							</script>
						</li>
					</ul>
					
				
				<% 		} 
				
					} else {
				%>
					
					<p> 없음 </p>
					
				<% } %>
					
				
					<li> 동아리 등록 현황 </li>
				<% 
				
				
					ArrayList<String> WaitRegisteredMyClub = clubDAO.getMyWaitRegisteredClubList(userId);
					totalNum = WaitRegisteredMyClub.size();
				
					
					if (totalNum > 0) {
						for (int index = 0; index < totalNum; index++) {
						
				
					
				%>
					<ul>
						<li>
							<form method="post" action="applyClubRegisterDeleteAction.jsp"
								onSubmit="return confirm('동아리 등록을 취소하시겠습니까?');" align="center">
								<input type="text" name="clubNM" readOnly
									value=<%=WaitRegisteredMyClub.get(index)%>									
									style="width: 70px; height: auto;"> 
									
									<input type="submit" value="신청 취소">
							</form> <script>
								function postPopUp() {
									window.open('', 'w',
													'width=900,height=650,location=no,status=no');
									return true;
								}
							</script>
						</li>
					</ul>
					
				
				<% 		} 
				
					} else {
					
				%>
					<p> 없음 </p>
					
				<% } %>
					
				
				</div>
				
				<% } %>--%>
			</div> 

			<jsp:useBean id="clubDao" class="club.ClubDAO" />

			<div class="club">
				<div class="intro">
					<h2>동아리</h2>
					<%
						if (userId == null) {
					%>
					<%
						ArrayList<ClubVO> list = clubDao.getClubIntro("");
					%>
					<ul>
						<%
							if (list != null) {
									for (ClubVO vo : list) {
						%>
						<li>
							<div class="thm">
								<img class="logo"
									src="upload/club/<%=vo.getIntro_save_file_nm()%>"
									onerror="this.src='image/error.png'" alt="">
							</div>
							<div class="tit">
								<a href="club_search.jsp?search=<%=vo.getClub_nm()%>"><%=vo.getClub_nm()%></a>
							</div>
							<div class="note"><%=vo.getClub_aim()%></div>
							<div class="tag">
								<%-- #<%=vo.getClub_active()%> --%>
								#<%=vo.getClub_gb_cd()%>
								#<%=vo.getClub_at_cd()%></div>
						</li>
						<%
							}
								}
						%>
					</ul>
					<%
						} else {
							ArrayList<ClubVO> list = clubDao.getClubIntro(userId);
					%>
					<ul>
						<%
							for (ClubVO vo : list) {
						%>
						<li>
							<div class="thm">
								<img class="logo"
									src="upload/club/<%=vo.getIntro_save_file_nm()%>"
									onerror="this.src='image/error.png'" alt="">

							</div> 
							<jsp:useBean id="dao" class="club.ClubDAO" /> 
							<%	String star_state = dao.getStar(vo.getClub_id(), userId);%>
							<div class="tit">
								<%-- <a href="club_search.jsp?search=<%=vo.getClub_nm()%>"><%=vo.getClub_nm()%></a> --%>
								<a href="club_intro.jsp?club_id=<%=vo.getClub_id()%>"><%=vo.getClub_nm()%></a>
								<!--여기-->
								<%
									if (star_state.equals("Y")) {
								%>
								<button type="button" class="star-btn"
									onclick="location.href='likeAction.jsp?club_id=<%=vo.getClub_id()%>&state=1'">
									<img src="image/star1.png" width="23" height="23">
								</button>
								<%
									} else if (star_state.equals("N")) {
								%>
								<button type="button" class="star-btn"
									onclick="location.href='likeAction.jsp?club_id=<%=vo.getClub_id()%>&state=0'">
									<img src="image/star0.png" width="23" height="23">
								</button>
								<%
									}
								%>

							</div>
							<div class="note"><%=vo.getStaff_cd()%></div>
							<div class="tag">
								#<%=vo.getClub_gb_cd()%>
								#<%=vo.getClub_at_cd()%></div>
						</li>
						<%
							}
						%>
					</ul>
					<%
						}
					%>
				</div>
			</div>

		</div>
		<hr>
		<div id="footer">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
		<hr>
	</div>
</body>
</html>