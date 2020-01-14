<%@page import="clubMember.clubMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<%
		String student_id = request.getParameter("student_id");
		int club_id = Integer.parseInt(request.getParameter("club_id"));
		String staff_cd = request.getParameter("staff");
		String btn = request.getParameter("btn");
		String user_name = request.getParameter("user_name");

		clubMemberDAO dao = new clubMemberDAO();
		String url = "manage_list.jsp?club_id=" + club_id;
		
		if (staff_cd == "")
			staff_cd = null;
	%>

	<%
		if (btn == null) {
			if (dao.update(club_id, student_id, staff_cd) == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.print("<script>");
				out.print("alert('변경되었습니다.');");
				//out.print("parent.location.href='" + url + "';");
				out.print("opener.document.location.reload();");
				out.print("window.close();");
				out.print("</script>");
			}
		} else {
			int result = dao.update(club_id, student_id, "004001"); //다음 회장
			
			int result2 = 0;
			if(!user_name.equals("admin")){
				 result2 = dao.update(club_id, user_name, "004004"); //전 회장
			}
					
			if (result == -1 || result2 == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.print("<script>");
				out.print("alert('변경되었습니다.');");
				//out.print("parent.location.href='" + url + "';");
				out.print("opener.document.location.reload();");
				out.print("window.close();");
				out.print("</script>");
			}
		}
	%>

</body>
</html>