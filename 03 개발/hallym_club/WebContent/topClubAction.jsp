<%@page import="club.ClubDAO"%>
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
	ClubDAO clubDAO = new ClubDAO();
	//ClubVO clubVO = new ClubVO();
	
	int club_id = Integer.parseInt(request.getParameter("club_id"));
	String at_cd = request.getParameter("at_cd");
	String gb_cd = request.getParameter("gb_cd");
	String submit = request.getParameter("submit");
	System.out.println("[topClubAction.jsp] club_id: " + club_id);
	System.out.println("[topClubAction.jsp] gb_cd: " + gb_cd);
	System.out.println("[topClubAction.jsp] at_cd: " + at_cd);
	System.out.println("[topClubAction.jsp] submit: " + submit);

	if(submit.equals("top in")) {
		//System.out.println("[topClubAction.jsp] submit if in ");
		
		if(clubDAO.setTopClub(club_id, "Y") == -1) {
			out.print("<script>");
			out.println("alert('오류 발생')");
			out.println("location.href='club_manage.jsp'");
			out.print("</script>");
		} else {
			out.print("<script>");
			out.println("alert('정상 처리 되었습니다. ')");
			out.println("location.href='club_manage.jsp'");
			out.print("</script>");
		}
		
		
	} else if(submit.equals("top out")) {
		//System.out.println("[topClubAction.jsp] submit else if in ");
		
		if(clubDAO.setTopClub(club_id, "N") == -1) {
			out.print("<script>");
			out.println("alert('오류 발생')");
			out.println("location.href='club_manage.jsp'");
			out.print("</script>");
		} else {
			out.print("<script>");
			out.println("alert('정상 처리 되었습니다. ')");
			out.println("location.href='club_manage.jsp'");
			out.print("</script>");
		}
		 
		
	} else {
		//error
		out.print("<script>");
		out.println("alert('오류 발생')");
		out.println("location.href='club_manage.jsp'");
		out.print("</script>");
	}

%>

</body>
</html>