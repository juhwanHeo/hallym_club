<%@page import="user.UserVO"%>
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
<title>한림대학교 동아리</title>
</head>
<body>
	<%
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}
		if (bbs.getTITLE() == null || bbs.getCONTENTS() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO BbsDAO = new BbsDAO();
			int result = BbsDAO.write(bbs, userId);
			System.out.println("result: " + result);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='board.jsp?club_id=" + bbs.getClub_id() + "&board_cd="
						+ bbs.getBoard_cd() + "'");
				script.println("</script>");
			}
		}
	%>

</body>

</html>



