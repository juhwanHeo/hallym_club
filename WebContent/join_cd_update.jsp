<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="clubMember.clubMemberDAO"%>
<%@ page import="clubMember.clubMemberVo"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
		request.setCharacterEncoding("UTF-8");
		String club_id = request.getParameter("join_club");
	%>

	<%
		String submit_value = request.getParameter("submit");
		String student_id = request.getParameter("student_id");
		int join_club = Integer.parseInt(request.getParameter("join_club"));
		clubMemberDAO dao = new clubMemberDAO();

		if (submit_value.equals("승인")) {
			int result = dao.update(join_club, student_id);
			if (result == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.print("alert('승인 처리 되었습니다.');");
				out.println("</script>");

			}
	%>
	<script>
		      location.href="manage.jsp?club_id=<%=join_club%>";
		</script>
	<%
		} else if (submit_value.equals("거부")) {
			int result = dao.delete(join_club, student_id, "1");
			if (result == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.print("alert('승인 거부 하였습니다.');");
				out.println("</script>");
			}
			out.println("<script>");
			out.print("location.href='manage.jsp?club_id='+'" + club_id + "'");
			out.println("</script>");
	%>
	<script>
		     location.href="manage.jsp?club_id=<%=join_club%>";
	</script>
	<%
		} else if (submit_value.equals("제명")) {
			int result = dao.delete(join_club, student_id, "2");
			if (result == -1) {
				out.println("<script>");
				out.print("alert('다시 시도해주세요.');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.print("alert('제명하였습니다.');");
				out.println("</script>");
			}
	%>
	<script>
		      location.href="manage_list.jsp?club_id=<%=join_club%>";
	</script>
	<%
		} else {
			out.println("<script>");
			out.print("alert('오류가 발생했습니다.');");
			out.println("</script>");
	%>
	<script>
				      location.href="manage_list.jsp?club_id=<%=join_club%>";
	</script>
	<%
		}
	%>


</body>
</html>