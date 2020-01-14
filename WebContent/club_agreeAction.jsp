<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="club_Agree.clubAgreeDAO"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		clubAgreeDAO agreeDAO = new clubAgreeDAO();

		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		String state = request.getParameter("agree_state");
		int club_id = Integer.parseInt(request.getParameter("club_id"));
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String board_cd = request.getParameter("board_cd");

		int result = 0;
		if (state.equals("agree")) {
			result = agreeDAO.agree_save(club_id, board_no, username);
		} else {
			result = agreeDAO.disagree_save(club_id, board_no, username);
		}

		PrintWriter script = response.getWriter();

		if (result == 1) {
			script.println("<script>");
			script.println("alert('수정되었습니다.')");
			script.println("location.href='myClub_Board.jsp?club_id=" + club_id + "&board_cd=" + board_cd + "'");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('오류가 발생하였습니다.')");
			script.println("location.href='myClub_Board.jsp?club_id=" + club_id + "&board_cd=" + board_cd + "'");
			script.println("</script>");
		}
	%>
</body>
</html>