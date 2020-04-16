<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" type="text/css" href="css/club_main.css">
<title>한림대학교 동아리</title>

</head>

<style>
.table {
	border-collapse: collapse;
	border-top: 3px solid #168;
	margin: 0 auto;
}

.table th {
	color: #168;
	background: #f0f6f9;
	text-align: center;
}

.table th, .table td {
	padding: 10px;
	border: 1px solid #ddd;
}

.table th:first-child, .table td:first-child {
	border-left: 0;
}

.table th:last-child, .table td:last-child {
	border-right: 0;
}

.table tr td:first-child {
	text-align: center;
}

.table caption {
	caption-side: bottom;
	display: none;
}

.intro {
	width: 100%;
	height: 30px;
}
</style>

<body>

	<%
		//로긴한사람이라면    userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

		String userID = null;

		if (session.getAttribute("username") != null) {

			userID = (String) session.getAttribute("username");

		}

		int bbsID = 0;

		if (request.getParameter("BOARD_NO") != null) {

			bbsID = Integer.parseInt(request.getParameter("BOARD_NO"));

		}

		String bbscd = "";

		if (request.getParameter("BOARD_CD") != null) {

			bbscd = request.getParameter("BOARD_CD");

		}

		if (request.getParameter("BOARD_NO") != null) {

			bbsID = Integer.parseInt(request.getParameter("BOARD_NO"));

		}

		int club_id = 1;
		String board_cd = "007001";

		if (request.getParameter("club_id") != null) {

			club_id = Integer.parseInt(request.getParameter("club_id"));

		}

		if (request.getParameter("board_cd") != null) {
			board_cd = request.getParameter("board_cd");
		}

		if (bbsID == 0) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('유효하지 않은 글 입니다.')");

			script.println("location.href = 'myclubboard__0.jsp'");

			script.println("</script>");

		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>


	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<!-- 게시판 -->
	<div class="main">
		<div class="container">

			<div class="row">

				<table class="table">

					<thead>

						<tr>

							<th colspan="3">글 보기</th>

						</tr>

					</thead>

					<tbody>

						<tr>

							<td style="width: 20%;">글 제목</td>

							<td colspan="2"><%=bbs.getTITLE()%></td>

						</tr>

						<%
							if (board_cd.equals("007004")) {
						%>
						<tr>
							<td>일정</td>
							<td><label for="fromDate"><%=bbs.getStart_date().substring(0, 10)%></label>
								~ <label for="toDate"><%=bbs.getEnd_date().substring(0, 10)%></label>
							</td>
							<!-- <td>개인정보 사용 동의 &nbsp;&nbsp;&nbsp;
		<select name="agree_state">
                        <option value="0">비동의</option>
                        <option value="1">동의</option>
                  </select> 
        </td> -->
						</tr>
						<%
							}
						%>

						<tr>

							<td>작성자</td>

							<td colspan="2"><%=bbs.getINPUT_ID()%></td>

						</tr>

						<tr>

							<td>작성일</td>

							<td colspan="2"><%=bbs.getINPUT_DATE().substring(0, 11) + bbs.getINPUT_DATE().substring(11, 13) + "시"

					+ bbs.getINPUT_DATE().substring(14, 16) + "분"%></td>

						</tr>
						<tr>
							<td>조회수</td>
							<td colspan="2"><%=bbs.getOPEN_CNT()%></td>
						</tr>

						<tr>

							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;">
								<textarea name="CONTENTS" rows="15" style="width: 645px;"
									readonly="readonly"><%=bbs.getCONTENTS()%></textarea>
							</td>


						</tr>
					</tbody>

				</table>
				<div id="lay-btn">
					<%
						if (board_cd.equals("007004")) {
					%>
					<a class="input-btn"
						href="club_calendar.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>">목록</a>
					<%
						} else {
					%>
					<a class="input-btn"
						href="myClub_Board.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>">목록</a>
					<%
						}
					%>


					<%
						//글작성자 본인일시 수정 삭제 가능 

						if (userID != null && userID.equals(bbs.getINPUT_ID())) {
					%>

					<a class="input-btn"
						href="myupdate.jsp?BOARD_NO=<%=bbs.getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">수정</a>

					<a class="input-btn"
						href="mydeleteAction.jsp?BOARD_NO=<%=bbs.getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>">삭제</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
