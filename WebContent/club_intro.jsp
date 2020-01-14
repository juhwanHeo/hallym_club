<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>
<jsp:useBean id="DAO" class="exam.jdbc.JDBC_clubDAO" />
<link rel="stylesheet" type="text/css" href="css/club_main.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int club_id = Integer.parseInt(request.getParameter("club_id"));
	String club_poster = DAO.getIntro_FilePath(club_id);
%>
<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

		<div class="main">
			<img width="980" height="700" src="upload/club/<%=club_poster%>" onerror="this.src='image/error.png'">
		</div>
</body>
</html>