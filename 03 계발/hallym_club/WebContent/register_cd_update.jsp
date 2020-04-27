
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="club.ClubDAO"%>
<%@page import="club.ClubVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
		request.setCharacterEncoding("UTF-8");
		int club_id = Integer.parseInt(request.getParameter("club_id"));
	%>

	<%
		String submit = request.getParameter("submit");
		ClubDAO clubDAO = new ClubDAO();
		
		
		
		if (submit.equals("수락")) {
		 	System.out.println("[register_cd_update.jsp] 수락");
			int result = clubDAO.setRegister_cd(club_id, "008001");
			
			if (result == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.print("alert('승인 처리 되었습니다.');");
				out.println("</script>");

			}
		 	
 
 		
		} else if (submit.equals("거절")) {
			
			System.out.println("[register_cd_update.jsp] 거절");
			int result = clubDAO.setRegister_cd(club_id, "008002");
			if (result == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.print("alert('승인 거부 하였습니다.');");
				out.println("</script>");
			}
		} 
		
		out.println("<script>");
		out.print("location.href='club_manage.jsp'");
		out.println("</script>");
	%>


</body>
</html>