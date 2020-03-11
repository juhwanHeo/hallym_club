<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<%@ page import="bbs.Bbs"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	//sresponse.setContentType("text/html; charset=UTF-8");

%>

<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>


	<jsp:useBean id="bbs_bean" class="bbs.Bbs" />
	<jsp:setProperty property="*" name="bbs_bean" />
	<jsp:useBean id="bbs_dao" class="bbs.BbsDAO" />
	
	
	<%
	
	
	  	 String club_name = "";;
	  	 if (request.getParameter("club_name") != null){
	  		 club_name = request.getParameter("club_name");
	  	 }
  	 
  	 

		String userID = null;

		if (session.getAttribute("username") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

			userID = (String) session.getAttribute("username");//유저아이디에 해당 세션값을 넣어준다.

		}

		if (userID == null) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('로그인을 하세요.')");

			script.println("location.href = 'login.jsp'");

			script.println("</script>");

		} 

		

		//글이 유효한지 판별

		int BOARD_NO = 0;
        int club_id = 1;
		
		if (request.getParameter("club_id") != null) {

			club_id = Integer.parseInt(request.getParameter("club_id"));

		}

		if (request.getParameter("BOARD_NO") != null) {

			BOARD_NO = Integer.parseInt(request.getParameter("BOARD_NO"));

		}
		
		String board_cd="";
		
		if (request.getParameter("board_cd") != null) {
			board_cd = request.getParameter("board_cd");
		}
		

		if (BOARD_NO == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'frame.jsp'");
			script.println("</script>");

		}

		Bbs bbs = new BbsDAO().getBbs(BOARD_NO);
		
		if (!userID.equals(bbs.getINPUT_ID())) {

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'myClub_Board.jsp'");
			script.println("</script>");				

		} else {

			if (request.getParameter("TITLE") == null || request.getParameter("CONTENTS") == null

					|| request.getParameter("TITLE").equals("") || request.getParameter("CONTENTS").equals("") ) {

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");

			} else {

				BbsDAO BbsDAO = new BbsDAO();
				int result = BbsDAO.update(bbs_bean);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");

				} else {	
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정되었습니다.')");
					if(board_cd.equals("007004")){
						script.println("location.href='club_calendar.jsp?club_id="+club_id+"&board_cd="+board_cd+"'");
					}else{
						script.println("location.href='myClub_Board.jsp?club_id="+club_id+"&board_cd="+board_cd+"'");
					}
					
					script.println("</script>");
				}
	

			}
			

		}

	%>

</body>

</html>



