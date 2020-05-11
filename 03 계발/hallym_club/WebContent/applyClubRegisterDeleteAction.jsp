<%@page import="club.ClubDAO"%>
<%@page import="user.UserVO"%>
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

</body>
<%
		request.setCharacterEncoding("UTF-8");
		ClubMemberDAO clubMember = new ClubMemberDAO();
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}

		String clubNM = request.getParameter("clubNM");
		ClubDAO clubDAO = new ClubDAO();
		int club_id = clubDAO.getClubIds(clubNM);
		System.out.println("[applyClubRegisterDeleteAction.jsp] club_id: " + club_id);
		System.out.println("[applyClubRegisterDeleteAction.jsp] clubNM: " + clubNM);
		
		
		
		
		if(clubMember.removeApply(userId, clubDAO.getClubIds(clubNM)) != -1) {
			
			if(clubDAO.deleteClub(clubNM) != -1) {
				out.println("<script>");
				out.println("alert('성공적으로 처리 되었습니다.')");
				out.println("top.location.href='index.jsp'");
				out.println("</script>");
			}
			else {
				out.println("<script>");
				out.println("alert('CLUB ERROR')");
				out.println("top.location.href='index.jsp'");
				out.println("</script>");
			}
			
		} else {
			out.println("<script>");
			out.println("alert('CLUBMEMBER ERROR')");
			out.println("top.location.href='index.jsp'");
			out.println("</script>");
		}
		
		
	%>
</html>