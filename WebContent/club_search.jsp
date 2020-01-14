
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
<link rel="stylesheet" type="text/css" href="css/search.css?after">
<link rel="stylesheet" type="text/css" href="css/page.css?after">
</head>

<body>

	<%
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}
	%>

	<%
		request.setCharacterEncoding("UTF-8");
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
			title = "학술 동아리";
		} else if (club_at_cd.equals("002002")) {
			title = "운동 동아리";
		} else if (club_at_cd.equals("002003")) {
			title = "봉사 동아리";
		} else if (club_at_cd.equals("002004")) {
			title = "문화 동아리";
		} else if (club_at_cd.equals("002005")) {
			title = "종교 동아리";
		} else if (club_at_cd.equals("002006")) {
			title = "기타 동아리";
		} else {
			title = "전체 동아리";
		}
	%>
	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>

		<div class="category">
			<form method="get" action="club_search.jsp">

				<ul>
					<li class="title"><%=title%></li>
					<li><select class="club_gb" name="club_gb_cd"
						onchange="this.form.submit();">
							<option value="">전체</option>
							<option value="001001"
								<%if (club_gb_cd.equals("001001"))
				out.println("selected");%>>중앙
								동아리</option>
							<option value="001002"
								<%if (club_gb_cd.equals("001002"))
				out.println("selected");%>>과
								동아리</option>
					</select></li>
					<li><input type="text" id="search" name="search" size="30"
						value="<%=search%>" onfocus="this.select()" autocomplete="off">
						<button type="submit" class="category-btn">검색</button></li>

				</ul>

				<ul>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="">전체</button></li>
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
							value="002006">기타</button></li>
				</ul>
			</form>
		</div>
		<hr>

		<jsp:useBean id="dao" class="exam.jdbc.JDBC_clubDAO" />

		<div id="content">
			<div class="result">
				<%
					ArrayList<ClubVO> gb_list = dao.getClublist(club_gb_cd, search, club_at_cd, pageNumber);
					int totalcount = 0;
					try {
						totalcount = gb_list.get(0).getRow_count();
					} catch (Exception e) {
					}
					if (totalcount == 0) {
				%><h4>검색 결과가 없습니다.</h4>
				<%
					} else {
				%>
				<h4>
					검색 결과는<%=totalcount%>개 입니다.
				</h4>
				<%
					}
				%>
			</div>

			<%
				for (ClubVO vo : gb_list) {
					String star_state = "";
			%>
			
			<div class="latest">
				<div class="logo">
					<img class="img" src="upload/club/<%=vo.getIntro_save_file_nm()%>" onerror="this.src='image/error.png'"></img>
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
						<!-- <input name="submit" type="image" src="image/star0.png" width="23"
							height="23"> &nbsp; 3 -->
					</div>
					<table class="tbl">
						<tr>
							<th>회원수</th>
							<td><%=vo.getCnt()%>명</td>
							<th>결성년도</th>
							<%
								if (vo.getOpen_dt().equals("")) {
							%>
							<td></td>
							<%
								} else {
							%>
							<td><%=vo.getOpen_dt().substring(0, 4)%>년</td>
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
					<input type="hidden" name="club_id" value="<%=vo.getClub_id()%>" >
					<input type="hidden" name="club_nm" value="<%=vo.getClub_nm()%>" >
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
			<div class="page_wrap">
				<div class="page_nation">
					<%
						int countList = 4;
						int countPage = 5;
						int totalPage = totalcount / countList;
						if (totalcount > countList * totalPage) {
							totalPage++;
						}
						//현재 페이지가 총 페이지 번호보다 클 경우 
						if (totalPage < pageNumber) {
							pageNumber = totalPage;
						}
						int startPage = ((pageNumber - 1) / countPage) * countPage + 1; //페이지 번호  시작
						int endPage = startPage + countPage - 1; //페이지 번호 끝
						if (endPage > totalPage) {
							endPage = totalPage;
						}

						if (startPage > 1) {
					%>
					<a class="arrow pprev"
						href="club_search.jsp?club_gb_cd=<%=club_gb_cd%>&search=<%=search%>&club_at_cd=<%=club_at_cd%>&pageNumber=<%=1%>">처음</a>
					<%
						}
						if (pageNumber > 1) {
					%>
					<a class="arrow prev"
						href="club_search.jsp?club_gb_cd=<%=club_gb_cd%>&search=<%=search%>&club_at_cd=<%=club_at_cd%>&pageNumber=<%=pageNumber - 1%>">이전</a>
					<%
						}
						for (int i = startPage; i <= endPage; i++) {
							if (i == pageNumber) {
					%>
					<a class="active"
						href="club_search.jsp?club_gb_cd=<%=club_gb_cd%>&search=<%=search%>&club_at_cd=<%=club_at_cd%>&pageNumber=<%=i%>"><%=i%></a>
					<%
						} else {
					%>
					<a
						href="club_search.jsp?club_gb_cd=<%=club_gb_cd%>&search=<%=search%>&club_at_cd=<%=club_at_cd%>&pageNumber=<%=i%>"><%=i%></a>
					<%
						}
						}
					%>

					<%
						if (pageNumber < totalPage) {
					%>
					<a class="arrow next"
						href="club_search.jsp?club_gb_cd=<%=club_gb_cd%>&search=<%=search%>&club_at_cd=<%=club_at_cd%>&pageNumber=<%=pageNumber + 1%>">다음</a>
					<%
						}
					%>

					<%
						if (endPage < totalPage) {
					%>
					<a class="arrow nnext"
						href="club_search.jsp?club_gb_cd=<%=club_gb_cd%>&search=<%=search%>&club_at_cd=<%=club_at_cd%>&pageNumber=<%=totalPage%>">끝</a>
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