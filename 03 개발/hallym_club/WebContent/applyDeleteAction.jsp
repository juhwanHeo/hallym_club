<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="clubMember.ClubMemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="clubDAO" class="club.ClubDAO" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		ClubMemberDAO clubMemberDAO = new ClubMemberDAO();
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}

		String clubNM = request.getParameter("clubNM");

		int club_id = clubDAO.getClubIds(clubNM);
		String staff_cd = clubMemberDAO.getStaff_CD(club_id, userId);
		String join_cd = clubMemberDAO.getJoin_cd(userId, club_id);
		System.out.println("[applyDeleteAction.jsp] club_id: " + club_id);
		System.out.println("[applyDeleteAction.jsp] join_cd: " + join_cd);
		System.out.println("[applyDeleteAction.jsp] staff_cd: " + staff_cd);

		if (clubMemberDAO.getStaff_CD(club_id, userId).equals("004001")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회장은 탈퇴 할 수 없습니다.')");
			// script.println("parent.parent.myInfo_signList.location.reload(true);"); 
			script.println("top.location.href='index.jsp'");
			script.println("</script>");

			
		} 
		else if(join_cd.equals("008003")) {
			if (clubMemberDAO.delete(club_id, userId) != -1) {
				out.println("<script>");
				out.println("alert('성공적으로 처리 되었습니다.')");
				out.println("top.location.href='index.jsp'");
				out.println("</script>");
			} 
			else {
				out.println("<script>");
				out.println("alert('오류.')");
				out.println("history.back();");
				out.println("</script>");
			}
					
		} 
		
		else { 
			if (clubMemberDAO.removeApply(userId, clubDAO.getClubIds(clubNM)) == 1) {
			
				out.println("<script>");
				out.println("alert('성공적으로 처리 되었습니다.')");
				out.println("top.location.href='index.jsp'");
				out.println("</script>");
			} 
			else {
				out.println("<script>");
				out.println("alert('오류.')");
				out.println("history.back();");
				out.println("</script>");
			}
		}
	%>
</body>
</html>