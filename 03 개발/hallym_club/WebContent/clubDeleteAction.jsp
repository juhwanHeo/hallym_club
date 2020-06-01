<%@page import="club.ClubDAO"%>
<%@page import="clubMember.ClubMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	ClubDAO clubDAO = new ClubDAO();
	ClubMemberDAO clubMemberDAO = new ClubMemberDAO();
	
	if(clubMemberDAO.deleteClubMemberAll(club_id) != -1) {
		
		if(clubDAO.deleteClub(club_id) != -1) {
			out.println("<script>");
			out.println("alert('성공적으로 처리 되었습니다.')");
			out.println("</script>");
		}
		else {
			out.println("<script>");
			out.println("alert('CLUB ERROR')");
			out.println("</script>");
		}
		
	} else {
		out.println("<script>");
		out.println("alert('CLUBMEMBER ERROR')");
		out.println("</script>");
	}
	System.out.println("[register_cd_update.jsp] 거절");
	
	out.println("<script>");
	out.print("location.href='club_manage.jsp'");
	out.println("</script>");
%>

</body>
</html>