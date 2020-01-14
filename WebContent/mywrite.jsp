<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@page import="clubMember.clubMemberDAO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
<!-- 스타일시트 참조  -->

<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<style>

/*datepicker에서 사용한 이미지 버튼 style적용*/
img.ui-datepicker-trigger {
	margin-left: 5px;
	vertical-align: middle;
	cursor: pointer;
}

ul li a:hover {
	font-size: 140%;
	opacity: 1.0;
	/* color: black; */
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

h2 {
	margin-left: 20%;
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
                    showOn: "both",                     // 달력을 표시할 타이밍 (both: focus or button)
                    buttonImage: "image/calendar.png", // 버튼 이미지
                    buttonImageOnly : true,             // 버튼 이미지만 표시할지 여부
                    buttonText: "날짜선택",             // 버튼의 대체 텍스트
                    dateFormat: "yy-mm-dd",             // 날짜의 형식
                    changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
                    //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
                    onClose: function( selectedDate ) {    
                        // 시작일(fromDate) datepicker가 닫힐때
                        // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                        $("#toDate").datepicker( "option", "minDate", selectedDate );
                    }                
                });

                //종료일
                $('#toDate').datepicker({
                    showOn: "both", 
                    buttonImage: "image/calendar.png", 
                    buttonImageOnly : true,
                    buttonText: "날짜선택",
                    dateFormat: "yy-mm-dd",
                    changeMonth: true,
                    //minDate: 0, // 오늘 이전 날짜 선택 불가
                    onClose: function( selectedDate ) {
                        // 종료일(toDate) datepicker가 닫힐때
                        // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                        $("#fromDate").datepicker( "option", "maxDate", selectedDate );
                    }                
                });
            });
        </script>
</head>

<body>

	<%request.setCharacterEncoding("UTF-8");%>

	<%

      //로긴한사람이라면    userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

      String username = null;

      if (session.getAttribute("username") != null) {

         username = (String) session.getAttribute("username");

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
	<div class="main">

		<form name="board_form" method="post" action="mywriteAction.jsp"
			style="margin: 0 auto;" onsubmit="return check_form();">
			<br>

			<table class="table" width="800px;" height="80px;">
				<thead>
					<tr>
						<th colspan="2">글 쓰기</th>
					</tr>
				</thead>
				<tr>
					<td>분류/제목</td>
					<td class="td_2"><select name="board_cd">
							<% if(board_cd.equals("007001")){%>
							<option value="007001">공지사항</option>
							<%}else if(board_cd.equals("007002")){%>
							<option value="007002">자유 게시판</option>
							<%}else if(board_cd.equals("007003")){%>
							<option value="007003">사진</option>
							<%}else if(board_cd.equals("007004")){%>
							<option value="007004">일정</option>
							<%}%>
					</select> <input type="text" name="TITLE" size="70"
						style="border: 1px solid black;"></td>
				</tr>
				<%if (board_cd.equals("007004")){%>

				<tr>
					<td style="text-align: center; padding-top: 17px;">일정</td>
					<td><label for="fromDate">시작일</label> <input type="text"
						name="start_date" id="fromDate" autocomplete="off"
						style="border: 1px solid black;"> ~ <label for="toDate">종료일</label>
						<input type="text" name="end_date" id="toDate" autocomplete="off"
						style="border: 1px solid black;"></td>
				</tr>


				<% }%>

				<tr>
					<td>동아리명</td>
					<%clubMemberDAO cm = new clubMemberDAO();%>
					<input type="hidden" name="club_id" value=<%=club_id %>>
					<td class="td_2"><%=cm.getClubNMs(club_id) %>
				</tr>

				<tr>
					<td>내용</td>
					<td class="td_2"><textarea name="CONTENTS" id="bbsTitle"
							rows="17" style="width: 645px;"></textarea></td>
				</tr>
			</table>

			<div id="lay-btn">
				<input type="submit" class="input-btn" name="작성" value="작성">

				<%if (board_cd.equals("007004")){%>
				<input type="reset" class="input-btn" name="취소" value="취소"
					onclick="location.href='club_calendar.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>'">

				<%}else{ %>
				<input type="reset" class="input-btn" name="취소" value="취소"
					onclick="location.href='myClub_Board.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>'">
				<%} %>
			</div>
	</div>
	</form>

</body>

<script>
function check_form(){
	var start = document.getElementById("fromDate").value;
	var end = document.getElementById("toDate").value;
	
	if (start.trim() == ""){
		alert("시작일을 입력해주세요");
		document.getElementById("fromDate").focus();
		return false;
	}
	
	if (end.trim() == ""){
		alert("종료일을 입력해주세요");
		document.getElementById("toDate").focus();
		return false;
	}
}
</script>

</html>

