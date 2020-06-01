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
	int rank=0;
	try{
		rank =  Integer.parseInt(request.getParameter("rank"));
	}
	catch(Exception e){
		System.out.println("[topClubRankAction.jsp] rank: " + request.getParameter("rank"));
		System.out.println("[topClubRankAction.jsp] rank: e.getMessage" + e.getMessage());
		out.print("<script>");
		out.println("alert('숫자형 데이터를 넣어 주세요.!')");
		out.println("location.href='club_info.jsp?club_id=" + club_id + "'");;
		out.print("</script>");
		
	}
	String submit = request.getParameter("submit");
	System.out.println("[topClubRankAction.jsp] club_id: " + club_id);
	System.out.println("[topClubRankAction.jsp] rank: " + rank);
	System.out.println("[topClubRankAction.jsp] submit: " + submit);
	


	if(clubDAO.setTopClubRank(club_id, rank) == -1) {
		out.print("<script>");
		out.println("alert('오류 발생')");
		out.println("location.href='club_info.jsp?club_id=" + club_id + "'");;
		out.print("</script>");
	} else {
		out.print("<script>");
		out.println("alert('정상 처리 되었습니다.')");
		out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
		out.print("</script>");
	}
	


%>
</body>
</html>