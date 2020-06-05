<%@page import="user.UserVO"%>
<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="clubMember.ClubMemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">

<link rel="stylesheet" type="text/css" href="css/common.css?after">
<link rel="stylesheet" type="text/css" href="css/view.css?after">

<!-- 
<link rel="stylesheet" type="text/css" href="css/ckeditor5.css?">
	-->
<title>한림대학교 동아리</title>


</head>

<body>
	<%
		request.setCharacterEncoding("UTF-8");

		UserVO userVO = new UserVO();
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}

		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 
		/* else if (!(userId.equals("20185280") || userId.equals("20185304") || userId.equals("20765")
		|| userId.equals("20152318") || userId.equals("20152335"))) { */
		else if (! userVO.getAdmin_cd().equals("010001")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 권환이 필요합니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}

		int club_id = 1;
		String board_cd = "007001";

		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
		if (request.getParameter("board_cd") != null) {
			board_cd = request.getParameter("board_cd");
		}
	%>

	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>
		<div id="content">
			<div class="info_tit">
				<h1>글 작성</h1>
			</div>

			<div class="view-lay">
				<form name="board_form" method="post" action="writeAction.jsp">
					<table class="write-tbl">
						<tr>
							<td>분류/제목</td>
							<td><select name="board_cd">
									<%
										if (board_cd.equals("007001")) {
									%>
									<option value="007001">공지사항</option>
									<%
										} else if (board_cd.equals("007002")) {
									%>
									<option value="007002">자유 게시판</option>
									<%
										} else if (board_cd.equals("007003")) {
									%>
									<option value="007003">사진</option>
									<%
										} else if (board_cd.equals("007004")) {
									%>
									<option value="007004">일정</option>
									<%
										}
									%>
							</select> <input type="text" name="TITLE" style="width: 80%;"
								autocomplete="off"></td>
						</tr>
						<tr>
							<td>고정 게시글</td>
							<td>
					           	<label>
					           		<input type="checkbox" name="BOARD_FIX" value="Y">
					           		고정글
					           	</label>
				           </td>
				        </tr>
						<tr>
							<td>작성자</td>
							<%
								clubMember.ClubMemberDAO cm = new clubMember.ClubMemberDAO();
							%>
							<input type="hidden" name="club_id" value=<%=club_id%>>
							<td><%=cm.getClubNMs(club_id)%></td>
						</tr>
					</table>
					<!-- 
					<div>
						<textarea name="CONTENTS" id="bbsTitle" class="editor" rows="20" style="width: 100%; resize: none;"></textarea>
					</div>
					-->
					<textarea name="CONTENTS" id="bbsTitle" rows="20" style="width: 100%; resize: none;">내용을 입력해주세요</textarea>
					<div class="write-btn">
						<input type="submit" class="input-btn" name="작성" value="작성">
						<input type="reset" class="input-btn" name="취소" value="취소"
							onclick="history.back();">
					</div>
				</form>

			</div>
			
		</div>
		<hr>
		<div id="footer">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
	
	
</body>

</html>