<%@page import="user.UserVO"%>
<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		/*max-height: 500px;*/
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

		int bbsID = 0;
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
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>

	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>
		<div id="content">
			<div class="info_tit">
				<h1>공지사항</h1>
			</div>

			<div class="view-lay">
				<div class="view-top">
					<p><%=bbs.getTITLE()%></p>
					<div class="view-info">
						<strong>작성자 </strong> <span><%=bbs.getINPUT_ID()%> </span> <strong>등록일
						</strong> <span><%=bbs.getINPUT_DATE().substring(0, 11)%></span> <strong>조회수
						</strong> <span><%=bbs.getOPEN_CNT()%></span>
					</div>
				</div>

				<!-- <div class="view-con"><%=bbs.getCONTENTS()%></div> -->
				<div class="view-con">
					<textarea class="editor"><%=bbs.getCONTENTS()%></textarea>
				</div>
				<div class="view-btn">
					<a
						href="update.jsp?BOARD_NO=<%=bbs.getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>"
						class="list-btn">수정</a> <a
						href="deleteAction.jsp?BOARD_NO=<%=bbs.getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>"
						class="list-btn">삭제</a> <a href="board.jsp" class="list-btn">목록</a>
				</div>

			</div>

		</div>
		<hr>
		<div id="footer" style="position: static;">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>

	<script src="https://cdn.ckeditor.com/ckeditor5/19.0.0/classic/ckeditor.js"></script>
	<script>
	    ClassicEditor
	        .create( document.querySelector( '.editor' ), {
	        	toolbar: []
	        })
	        .then( editor => {
				editor.isReadOnly = true;
	        })
	        .catch( error => {
	            console.error( error );
	        } );
	</script>
	<script>
		var header = document.querySelector("h1");	//제거하고자 하는 엘리먼트
		header.parentNode.removeChild(header);
	</script>
</body>

</html>