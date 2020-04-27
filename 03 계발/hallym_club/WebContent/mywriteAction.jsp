<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>


<jsp:useBean id="bbs" class="bbs.Bbs" />
<jsp:setProperty property="*" name="bbs" />
<jsp:useBean id="bbs_dao" class="bbs.BbsDAO" />


<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>한림대학교 동아리</title>

</head>

<body>
	<jsp:useBean id="itemDAO" class="item.ItemDAO" />
	<%
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}

		if (bbs.getTITLE() == null || bbs.getCONTENTS() == null) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('입력이 안된 사항이 있습니다')");

			script.println("history.back()");

			script.println("</script>");

		} else {

			BbsDAO BbsDAO = new BbsDAO();

			int result = BbsDAO.write(bbs, userId);

			if (result == -1) {

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");

			} else {

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글을 작성하였습니다.')");
				if (bbs.getBoard_cd().equals("007004")) {
					script.println("location.href='club_calendar.jsp?club_id=" + bbs.getClub_id() + "&board_cd="
							+ bbs.getBoard_cd() + "'");
				} else {
					script.println("location.href='myClub_Board.jsp?club_id=" + bbs.getClub_id() + "&board_cd="
							+ bbs.getBoard_cd() + "'");
				}
				script.println("</script>");

			}

		}
	%>

</body>

</html>


