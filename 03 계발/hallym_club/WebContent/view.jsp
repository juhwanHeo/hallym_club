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
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/view.css?">
<title>한림대학교 동아리</title>
</head>

<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
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
					<p><%=bbs.getTITLE() %></p>
					<div class="view-info">
						<strong>작성자 </strong> <span><%=bbs.getINPUT_ID() %> </span> <strong>등록일
						</strong> <span><%=bbs.getINPUT_DATE().substring(0, 11) %></span> <strong>조회수 </strong> <span><%=bbs.getOPEN_CNT() %></span>
					</div>
				</div>

				<div class="view-con"><%=bbs.getCONTENTS() %></div>

				<div class="view-btn">
					<a href="update.jsp?BOARD_NO=<%= bbs.getBOARD_NO() %>&club_id=<%=club_id%>&board_cd=<%=board_cd%>" class="list-btn">수정</a>
					<a href="deleteAction.jsp?BOARD_NO=<%=bbs.getBOARD_NO()%>&club_id=<%=club_id%>&board_cd=<%=board_cd%>" class="list-btn">삭제</a>
					<a href="board.jsp" class="list-btn">목록</a>
				</div>

			</div>
			<hr>
			<div id="footer">
				<jsp:include page="footer.jsp"></jsp:include>
			</div>

		</div>
	</div>
</body>

</html>