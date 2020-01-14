<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page import="Student.StudentDAO"%>
<%@ page import="exam.jdbc.JDBC_clubDAO"%>
<%@ page import="java.io.PrintWriter"%>

<jsp:useBean id="student_dao" class="Student.StudentDAO" />
<jsp:useBean id="club_dao" class="exam.jdbc.JDBC_clubDAO" />

<%
	request.setCharacterEncoding("UTF-8");

	String username = null;
	if (session.getAttribute("username") != null) {
		username = (String) session.getAttribute("username");
	}
	int result = 1;
	int club_id = 1;
	if (request.getParameter("club_id") != null) {
		try {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		} catch (Exception e) {
			System.out.println("오류");
		}
	}
	String state = "";
	if (request.getParameter("state") != null) {
		state = request.getParameter("state");
	}

	if(state.equals("0")){
		result = club_dao.addStar(club_id, username);
	}else if(state.equals("1")){
		result = club_dao.deleteStar(club_id, username);
	}
	
	if (result == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("window.location = document.referrer;"); //이전 페이지 새로고침
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('먼저 동아리 가입 신청을 해주세요');");
		script.println("window.location = document.referrer;"); //이전 페이지 새로고침
		script.println("</script>");
		script.close();
		return;
	}
	
	
%>