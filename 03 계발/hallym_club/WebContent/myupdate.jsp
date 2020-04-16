<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="bbs.Bbs"%>

<%@ page import="bbs.BbsDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" type="text/css" href="css/club_main.css"> -->
<title>한림대학교 동아리</title>

<style>

/*datepicker에서 사용한 이미지 버튼 style적용*/
img.ui-datepicker-trigger {
	margin-left: 5px;
	vertical-align: middle;
	cursor: pointer;
}

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
</style>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script>
	$(function() {

		//오늘 날짜를 출력
		$("#today").text(new Date().toLocaleDateString());

		//datepicker 한국어로 사용하기 위한 언어설정
		$.datepicker.setDefaults($.datepicker.regional['ko']);

		// 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
		// 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

		//시작일.
		$('#fromDate').datepicker({
			showOn : "both", // 달력을 표시할 타이밍 (both: focus or button)
			buttonImage : "image/calendar.png", // 버튼 이미지
			buttonImageOnly : true, // 버튼 이미지만 표시할지 여부
			buttonText : "날짜선택", // 버튼의 대체 텍스트
			dateFormat : "yy-mm-dd", // 날짜의 형식
			changeMonth : true, // 월을 이동하기 위한 선택상자 표시여부
			//minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
			onClose : function(selectedDate) {
				// 시작일(fromDate) datepicker가 닫힐때
				// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
				$("#toDate").datepicker("option", "minDate", selectedDate);
			}
		});

		//종료일
		$('#toDate').datepicker({
			showOn : "both",
			buttonImage : "image/calendar.png",
			buttonImageOnly : true,
			buttonText : "날짜선택",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			//minDate: 0, // 오늘 이전 날짜 선택 불가
			onClose : function(selectedDate) {
				// 종료일(toDate) datepicker가 닫힐때
				// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
				$("#fromDate").datepicker("option", "maxDate", selectedDate);
			}
		});
	});
</script>
</head>

<body>

	<%
		String club_name = "";;
		if (request.getParameter("club_name") != null) {
			club_name = request.getParameter("club_name");
		}

		//로긴한사람이라면    userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

		String userID = null;

		if (session.getAttribute("username") != null) {

			userID = (String) session.getAttribute("username");

		}

		//로그인 안한 경우

		if (userID == null) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('로그인을 하세요.')");

			script.println("location.href = 'main.jsp'");

			script.println("</script>");

		}

		int BOARD_NO = 0;

		if (request.getParameter("BOARD_NO") != null) {

			BOARD_NO = Integer.parseInt(request.getParameter("BOARD_NO"));

		}

		String bbscd = "";

		if (request.getParameter("BOARD_CD") != null) {

			bbscd = request.getParameter("BOARD_CD");

		}

		if (BOARD_NO == 0) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('유효하지 않은 글 입니다.')");

			script.println("location.href = 'myclubboard__0.jsp'");

			script.println("</script>");

		}

		Bbs bbs = new BbsDAO().getBbs(BOARD_NO);

		if (!userID.equals(bbs.getINPUT_ID())) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('권한이 없습니다.')");

			script.println("location.href = 'myClub_Board.jsp'");

			script.println("</script>");

		}
		int club_id = 1;
		String board_cd = "";

		if (request.getParameter("club_id") != null) {

			club_id = Integer.parseInt(request.getParameter("club_id"));

		}

		if (request.getParameter("board_cd") != null) {
			board_cd = request.getParameter("board_cd");
		}
	%>




	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>
	<!-- 게시판 -->
	<div class="main">
		<div class="container">

			<div class="row" style="margin: 0 auto; display: block;">

				<form method="post"
					action="myupdateAction.jsp?BOARD_NO=<%=BOARD_NO%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>"
					onsubmit="return check_form();">

					<table class="table">

						<thead>
							<tr>
								<th colspan="2">글수정</th>
							</tr>
						</thead>

						<tbody>

							<tr>
								<td>제목</td>
								<td><input type="text" style="width: 700px;"
									placeholder="글 제목" name="TITLE" maxlength="50"
									value="<%=bbs.getTITLE()%>"></td>

							</tr>
							<%
								if (board_cd.equals("007004")) {
							%>

							<tr>
								<td style="text-align: center; padding-top: 17px;">일정</td>
								<td><label for="fromDate">시작일</label> <input type="text"
									name="start_date" id="fromDate" value=<%=bbs.getStart_date()%>
									autocomplete="off" style="border: 1px solid black;"> ~
									<label for="toDate">종료일</label> <input type="text"
									name="end_date" id="toDate" value=<%=bbs.getEnd_date()%>
									autocomplete="off" style="border: 1px solid black;"></td>
							</tr>


							<%
								}
							%>
							<tr>

								<td colspan="2"><textarea placeholder="글 내용"
										name="CONTENTS" maxlength="2048"
										style="height: 350px; width: 100%;"><%=bbs.getCONTENTS()%></textarea></td>

							</tr>

						</tbody>

					</table>

					<div id="lay-btn">
					<button type="submit" class="input-btn">수정</button>
					<a class="input-btn" href="javascript:history.back();">취소</a>
					</div>
				</form>

			</div>

		</div>
	</div>
	<script>
		function check_form() {
			var start = document.getElementById("fromDate").value;
			var end = document.getElementById("toDate").value;

			if (start.trim() == "") {
				alert("시작일을 입력해주세요");
				document.getElementById("fromDate").focus();
				return false;
			}

			if (end.trim() == "") {
				alert("종료일을 입력해주세요");
				document.getElementById("toDate").focus();
				return false;
			}
		}
	</script>


</body>

</html>


