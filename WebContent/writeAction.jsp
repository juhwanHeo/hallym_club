<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); 
%>

<jsp:useBean id="bbs" class="bbs.Bbs" />
<jsp:setProperty property="*" name="bbs" />
<jsp:useBean id="bbs_dao" class="bbs.BbsDAO" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("username") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("username");//유저아이디에 해당 세션값을 넣어준다.
	}
	if (bbs.getTITLE() == null || bbs.getCONTENTS() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		BbsDAO BbsDAO = new BbsDAO();
		int result = BbsDAO.write(bbs, userID);
			System.out.println("리졸트값"+result);
			if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='board.jsp?club_id="+bbs.getClub_id()+"&board_cd="+bbs.getBoard_cd()+"'");
			script.println("</script>");
		}
	}

	%>

</body>

</html>



