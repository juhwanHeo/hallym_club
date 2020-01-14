
<%@page import="java.util.List"%>
<%@page import="sun.security.krb5.internal.PAEncTSEnc"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="exam.jdbc.ClubVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.jdbc.JDBC_clubDAO"%>
<%@page import="Student.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException,
                   java.util.Arrays"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/search.css">
<link rel="stylesheet" type="text/css" href="css/top.css">


</head>

<body>

	<%
		request.setCharacterEncoding("UTF-8");
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		String club_gb_cd = ""; //클럽 구분(중앙,과)
		String club_at_cd = ""; //클럽 속성(학술,운동)
		String search = "";
		int pageNumber = 1; //현재 페이지 번호

		if (request.getParameter("club_gb_cd") != null) {
			club_gb_cd = request.getParameter("club_gb_cd");
		}
		if (request.getParameter("club_at_cd") != null) {
			club_at_cd = request.getParameter("club_at_cd");
		}
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		if (request.getParameter("pageNumber") != null) {
			try {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			} catch (Exception e) {
				System.out.println("검색 페이지 번호 오류");
			}
		}
	%>

	<%
		String title = "";
		if (club_at_cd.equals("002001")) {
			title = "학술 동아리 TOP3";
		} else if (club_at_cd.equals("002002")) {
			title = "운동 동아리 TOP3";
		} else if (club_at_cd.equals("002003")) {
			title = "봉사 동아리 TOP3";
		} else if (club_at_cd.equals("002004")) {
			title = "문화 동아리 TOP3";
		} else if (club_at_cd.equals("002005")) {
			title = "종교 동아리 TOP3";
		} else if (club_at_cd.equals("002006")) {
			title = "기타 동아리 TOP3";
		} else if (club_gb_cd.equals("001001")) {
			title = "중앙 동아리 TOP5";
		} else if (club_gb_cd.equals("001002")) {
			title = "과 동아리 TOP5";
		} else {
			title = "전체 동아리 TOP5";
		}
	%>
	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>

		<div id="content">
			<div class="result">
				<form method="get" action="top_club.jsp" id="frm">
					<h2><%=title%></h2>
					<ul>
						<!-- 						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="">전체</button></li>
						<li><button name="club_gb_cd" onclick="this.form.submit()"
								value="001001">중앙</button></li>
						<li><button name="club_gb_cd" onclick="this.form.submit()"
								value="001002">과</button></li>

						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="002001">학술</button></li>
						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="002002">운동</button></li>
						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="002003">봉사</button></li>
						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="002004">문화</button></li>
						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="002005">종교</button></li>
						<li><button name="club_at_cd" onclick="this.form.submit()"
								value="002006">기타</button></li> -->
						<li class="on"><a href="top_club.jsp?">전체</a></li>
						<li><a href="top_club.jsp?club_gb_cd=001001 ">중앙</a></li>
						<li><a href="top_club.jsp?club_gb_cd=001002 ">과</a></li>
						<li><a href="top_club.jsp?club_at_cd=002001 ">학술</a></li>
						<li><a href="top_club.jsp?club_at_cd=002002 ">운동</a></li>
						<li><a href="top_club.jsp?club_at_cd=002003 ">봉사</a></li>
						<li><a href="top_club.jsp?club_at_cd=002004 ">문화</a></li>
						<li><a href="top_club.jsp?club_at_cd=002005 ">종교</a></li>
						<li><a href="top_club.jsp?club_at_cd=002006 ">기타</a></li>
					</ul>
				</form>
			</div>

			<jsp:useBean id="dao" class="exam.jdbc.JDBC_clubDAO" />
			<%
				ArrayList<ClubVO> gb_list = dao.getTopClub(club_gb_cd, club_at_cd);

				int rank = 0;
				for (ClubVO vo : gb_list) {
					rank++;
			%>

			<%
				String star_state = "";
			%>
			<div class="latest">
				<div class="logo">
					<span class="num_item"> <%=rank%>
					</span> <img class="img" src="upload/club/<%=vo.getIntro_save_file_nm()%>"
						onerror="this.src='image/error.png'"></img>
				</div>
				<div class="tbl-info">
					<h3><%=vo.getClub_nm()%></h3>
					<div class="star">
						<%
							if (username == null) {
						%>
						<button type="button" class="star-btn" onclick="postPopUp();">
							<img src="image/star0.png" width="23" height="23">
						</button>
						<%
							} else {
									star_state = dao.getStar(vo.getClub_id(), username);
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
								}
						%>
						<%=dao.getStarCnt(vo.getClub_id())%>
					</div>
					<table class="tbl">
						<tr>
							<th>회원수</th>
							<td><%=vo.getCnt()%></td>
							<th>결성년도</th>
							<%
								if (vo.getOpen_dt().equals("")) {
							%><td></td>
							<%
								} else {
							%><td><%=vo.getOpen_dt().substring(0, 4)%>년</td>
							<%
								}
							%>
						</tr>
						<tr>
							<th>회장</th>
							<td><%=vo.getStaff_nm()%></td>
							<th>지도교수</th>
							<td><%=dao.getProfessor(vo.getClub_id())%></td>
						</tr>
						<tr>
							<th>설립 목적</th>
							<td colspan="3"><%=vo.getClub_aim()%></td>
						</tr>
						<tr>
							<th>주요 활동</th>
							<td colspan="3"><%=vo.getClub_active()%></td>
						</tr>
					</table>
				</div>

				<form method="post" action="club_SignUp_Form.jsp" target="w"
					onsubmit="return postPopUp();">
					<input type="hidden" name="club_id" value="<%=vo.getClub_id()%>">
					<input type="hidden" name="club_nm" value="<%=vo.getClub_nm()%>">
					<ul>
						<li><input type="submit" value="가입 신청" class="tbl-btn"></li>
						<li><button type="button" class="tbl-btn">더보기</button></li>
						<li><button type="button" class="tbl-btn"
								onclick="window.open('upload/club/<%=vo.getPoster_save_file_nm()%>','new img', 'width=750,height=850')">동아리
								포스터</button></li>
					</ul>
				</form>

			</div>
			<%
				}
			%>

		</div>
		<hr>
		<div id="footer" style="position: relative;">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
		<hr>
	</div>
	<script>
		function postPopUp() {
	<%if (username == null) {%>
		alert("로그인이 필요합니다.");
			return false;
	<%} else {%>
		window.open('', 'w', 'width=900,height=650,location=no,status=no');
			return true;
	<%}%>
		}
	</script>
</body>
</html>