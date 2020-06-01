<%@page import="user.UserVO"%>
<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="clubMember.ClubMemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">

<link rel="stylesheet" type="text/css" href="css/common.css?after">
<link rel="stylesheet" type="text/css" href="css/view.css?after">

<title>한림대학교 동아리</title>

<style>

	.ck-editor__editable {
		min-height: 400px;
		max-height: 500px;
	}
	
	.ck.ck-editor__editable:not(.ck-editor__nested-editable).ck-focused {
    	width: auto;
	}
	
	.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) {
    	width: auto;
	}
</style>
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
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href='login.jsp'");
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

		int BOARD_NO = 0;
		if (request.getParameter("BOARD_NO") != null) {
			BOARD_NO = Integer.parseInt(request.getParameter("BOARD_NO"));
		}
		if (BOARD_NO == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href='board.jsp?club_id=" + club_id + "&board_cd=" + board_cd + "'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(BOARD_NO);
		if (!userId.equals(bbs.getINPUT_ID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>

	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>
		<div id="content">
			<div class="info_tit">
				<h1>글 수정</h1>
			</div>

			<div class="view-lay">
				<form method="post" action="updateAction.jsp?BOARD_NO=<%=BOARD_NO%> ">
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
								autocomplete="off" value="<%=bbs.getTITLE()%>"></td>
						</tr>
						
						<tr>
							<td>고정 게시글</td>
							<td>
					           	<label>
				            		<input type="checkbox" name="BOARD_FIX" value="Y"
				            	<%
				            		if(bbs.getBOARD_FIX().equalsIgnoreCase("Y")) {
				            	%>
				            		checked
				            	<%
				            		}
				            	%>
				            		>
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

						<!-- 
						<tr>
							<td>내용</td>
							<td>
								<textarea name="CONTENTS" id="bbsTitle" class="editor" rows="20" style="width: 100%; resize: none;"><%=bbs.getCONTENTS()%></textarea>
							</td>
						</tr>
						-->
					</table>
					
					<div>
						<textarea name="CONTENTS" id="bbsTitle" class="editor" rows="20" style="width: 100%; resize: none;"><%=bbs.getCONTENTS()%></textarea>
					</div>
					
					<div class="write-btn">
						<input type="submit" class="input-btn" value="수정"> <input
							type="reset" class="input-btn" name="취소" value="취소"
							onclick="history.back();">
					</div>
				</form>

			</div>

		</div>
		<hr>
		<div id="footer2">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
	
	<script src="https://cdn.ckeditor.com/ckeditor5/19.0.0/classic/ckeditor.js"></script>
	<script>
	    ClassicEditor
	        .create( document.querySelector( '.editor' ), {
	        	
	        })
	        .then( editor => {
	        	window.editor = editor;
	        })
	        .catch( error => {
	            console.error( error );
	        } );
	</script>
	
</body>

</html>