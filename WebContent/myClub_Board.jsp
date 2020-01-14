<%@page import="javax.security.auth.callback.ConfirmationCallback"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=1200">

<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link rel="stylesheet" type="text/css" href="css/table.css">
<link rel="stylesheet" type="text/css" href="css/page.css">
<title>한림대학교 동아리</title>
</head>
<body>
	<jsp:useBean id="itemDAO" class="item.itemDAO" />
	<jsp:useBean id="dao" class="exam.jdbc.JDBC_clubDAO" />
	<jsp:useBean id="agreeDAO" class="club_Agree.clubAgreeDAO" />

	<%
		request.setCharacterEncoding("UTF-8");

		String username = null;

		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		int pageNumber = 1; //기본 페이지 넘버
		String condition = "";

		//페이지넘버값이 있을때

		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

		if (request.getParameter("condition") != null) {
			condition = request.getParameter("condition");
		}

		String board_cd = "";

		int club_id = Integer.parseInt(request.getParameter("club_id"));

		if (request.getParameter("board_cd") != null) {
			board_cd = request.getParameter("board_cd");
		}

		String header_title = "";
		if (board_cd.equals("007001"))
			header_title = "공지사항";
		else if (board_cd.equals("007002"))
			header_title = "자유게시판";
		else if (board_cd.equals("007003"))
			header_title = "사진";
		else if (board_cd.equals("007004"))
			header_title = "일정";

		int join_cd = dao.getJoin_cd(username, dao.getClubNMs(club_id));
	%>


	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<div class="main">
		<ul style="list-style: none;">
			<li style="font-size: 25px; font-weight: bold; font-align: center;"><%=header_title%></li>
		</ul>

		<div id="list">
			<div class="row">

				<table class="table">

					<thead>
						<tr>
							<%
								if (board_cd.equals("007004")) {
							%>
							<th style="width: 70%;">제목</th>
							<th style="width: 30%;">비고</th>
							<%
								} else {
							%>
							<th style="width: 100px;">글 번호</th>
							<th style="width: 500px;">제목</th>
							<th style="width: 100px;">분류</th>
							<th style="width: 100px;">작성자</th>
							<th style="width: 100px;">작성일</th>
							<!-- <th style="width: 100px;">동아리명</th> -->
							<th style="width: 100px;">조회수</th>
							<%
								}
							%>
						</tr>
					</thead>
					<tbody>
						<%
							BbsDAO bbsDAO = new BbsDAO();

							ArrayList<Bbs> board_list = bbsDAO.getclub_search(club_id, board_cd, pageNumber, condition);

							int totalcount = 0;

							if (board_list.isEmpty()) {

							} else {
								totalcount = board_list.get(0).getRow_count(); 
								for (int i = 0; i < board_list.size(); i++) {
						%>

						<tr>

							<%
								if (board_cd.equals("007004")) {
							%>
							<form action="club_agreeAction.jsp">
								<input type="hidden" name="board_no"
									value=<%=board_list.get(i).getBOARD_NO()%>> <input
									type="hidden" name="club_id" value=<%=club_id%>> <input
									type="hidden" name="board_cd" value=<%=board_cd%>>
								<!-- 여기 -->
								<td><a
									href="myview.jsp?BOARD_NO=<%=board_list.get(i).getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">
										<%=board_list.get(i).getTITLE()%></a></td>
								<%
									if (agreeDAO.check_agree(club_id, board_list.get(i).getBOARD_NO(), username) == 1) {
								%>
								<td>개인정보 사용 동의 <select name="agree_state"
									onchange="this.form.submit()">
										<option value="disagree">비동의</option>
										<option value="agree" selected>동의</option>
								</select>
								</td>
								<%
									} else {
								%>
								<td>개인정보 사용 동의 <select name="agree_state"
									onchange="this.form.submit()">
										<option value="disagree" selected>비동의</option>
										<option value="agree">동의</option>
								</select>
								</td>
								<%
									}
								%>
							</form>
							<%
								} else {
							%>
							<td><%=board_list.get(i).getBOARD_NO()%></td>

							<td><a
								href="myview.jsp?BOARD_NO=<%=board_list.get(i).getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">
									<%=board_list.get(i).getTITLE()%></a></td>

							<td style="text-align: center;"><%=header_title%></td>
							<td style="text-align: center;"><%=board_list.get(i).getINPUT_ID()%></td>
							<td style="text-align: center;"><%=board_list.get(i).getINPUT_DATE().substring(0, 10)%></td>
							<%-- <td style="text-align: center;"><%=board_list.get(i).getClub_id() %></td> --%>
							<td style="text-align: center;"><%=board_list.get(i).getOPEN_CNT()%></td>
							<%
								}
							%>
						</tr>

						<%
							}
						%>



						<%
							}
						%>
					</tbody>
				</table>
				<%
				if (board_cd.equals("007002")) {
						%>
				<a class="btn"
					href="mywrite.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>">글쓰기</a>
				<%
						} else {
							if (join_cd == 0) {
					%>
				<a class="btn"
					href="mywrite.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>">글
					쓰기</a>
				<%
						}
						}
					%>
				<!-- 페이지 넘기기 -->
				<div class="page_wrap">
					<div class="page_nation">
						<%
							int countList = 10;
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
							href="myClub_Board.jsp?pageNumber=<%=1%>&condition=<%=condition%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">처음</a>
						<%
							}

							if (pageNumber > 1) {
						%>
						<a class="arrow prev"
							href="myClub_Board?pageNumber=<%=pageNumber - 1%>&condition=<%=condition%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">이전</a>

						<%
							}
							for (int i = startPage; i <= endPage; i++) {
								if (i == pageNumber) {
						%>
						<a class="active"
							href="myClub_Board?pageNumber=<%=i%>&condition=<%=condition%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>"><%=i%></a>

						<%
							} else {
						%>

						<a
							href="myClub_Board.jsp?pageNumber=<%=i%>&condition=<%=condition%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>"><%=i%></a>

						<%
							}
							}
						%>

						<%
							if (pageNumber < totalPage) {
						%>

						<a class="arrow next"
							href="myClub_Board.jsp?pageNumber=<%=pageNumber + 1%>&condition=<%=condition%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">다음</a>

						<%
							}
						%>

						<%
							if (endPage < totalPage) {
						%>
						<a class="arrow nnext"
							href="myClub_Board?pageNumber=<%=totalPage%>&condition=<%=condition%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">끝</a>
						<%
							}
						%>
					</div>
				</div>

			</div>
		</div>
		<div class="category">
			<form method="get" action="myClub_Board.jsp">
				<input type="hidden" value=<%=board_cd%> name="board_cd"> <input
					type="hidden" value=<%=club_id%> name="club_id">
				<ul>
					<li><select><option value="">제목</option></select></li>
					<li><input type="text" size="20" name="condition"
						value=<%=condition%>> <input type="submit" value="검색"
						class="category-btn"></li>
				</ul>
			</form>

		</div>
	</div>

</body>
</html>