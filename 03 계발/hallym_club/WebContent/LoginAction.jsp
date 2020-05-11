<%@page import="user.UserDAO"%>
<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>


<%-- 
<jsp:useBean id="userdata" class="student.StudentVO" scope="page" />

<jsp:setProperty name="userdata" property="username" />
<jsp:setProperty name="userdata" property="password" />
<jsp:setProperty name="userdata" property="usergroup"/> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		
		UserDAO userDAO = new UserDAO();
		String username = request.getParameter("username"); // id
		String usergroup = request.getParameter("usergroup"); // group
		String password = request.getParameter("password"); // pw
		System.out.println("[LoginAtion.jsp] username: " + username);
		System.out.println("[LoginAtion.jsp] password: ****");
		System.out.println("[LoginAtion.jsp] usergroup: " + usergroup);
		int result = userDAO.login(usergroup, username ,password);
		System.out.println("[LoginAtion.jsp] result:" + result);
		
		if (result == 1) {
			UserVO userVO = userDAO.getUser(username);
			
			if(userVO.getId() != null) {
				session.setAttribute("userVO", userVO);
				System.out.println("[LoginAtion.jsp] userdata.getUsername(): " + username);
				System.out.println("[LoginAtion.jsp] userVO: " + userVO);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB ERROR \n 다시 로그인을 시도해 주세요!!')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			}
		} else if (result == 0 || result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력하신 아이디 혹은 비밀번호가 일치하지 않습니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>