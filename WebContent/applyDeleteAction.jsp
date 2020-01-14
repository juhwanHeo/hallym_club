<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "clubMember.clubMemberDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<jsp:useBean id="clubDAO" class="exam.jdbc.JDBC_clubDAO" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8");
   
   String username = null;
   if (session.getAttribute("username") != null) {
      username = (String) session.getAttribute("username");
   }

   String clubNM = request.getParameter("clubNM"); 
   
   clubMemberDAO clubMember = new clubMemberDAO();
   
   if(clubMember.removeApply(username,clubDAO.getClubIds(clubNM)) ==1){
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('성공적으로 처리 되었습니다.')");
      /* script.println("parent.parent.myInfo_signList.location.reload(true);"); */
      script.println("top.location.href='index.jsp'");
      script.println("</script>");
   }
   else{
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('오류.')");
      script.println("history.back();");
      script.println("</script>");
   }
      
%>   
</body>
</html>