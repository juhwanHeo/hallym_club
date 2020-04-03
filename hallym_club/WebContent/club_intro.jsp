<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>
<jsp:useBean id="DAO" class="club.ClubDAO" />
<jsp:useBean id="clubMemberDAO" class="clubMember.ClubMemberDAO" />
<link rel="stylesheet" type="text/css" href="css/club_main.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int club_id = Integer.parseInt(request.getParameter("club_id"));
	String username = (String) session.getAttribute("username");
	String club_poster = DAO.getIntro_FilePath(club_id);
	if(clubMemberDAO.getJoin_cd(username, club_id) != null){
		session.setAttribute("club_id", club_id);
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('가입승인이 안된 동아리 입니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	}
%>
<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

		<div class="main">
			<img width="980" height="700" src="upload/club/<%=club_poster%>" onerror="this.src='image/error.png'">
		</div>
</body>
</html>