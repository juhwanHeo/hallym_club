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
    %>
    
    <jsp:useBean id="CM" class="clubMember.clubMemberVo" />
    <jsp:setProperty property="*" name="CM"/>
    <jsp:useBean id="CM_dao" class="clubMember.clubMemberDAO"/>
    
    <%
    request.setCharacterEncoding("UTF-8");
    
    String username = null;
   if (session.getAttribute("username") != null) {
      username = (String) session.getAttribute("username");
   }
    String dong_name = request.getParameter("dong_name");
    System.out.println(dong_name);
     int result = CM_dao.modMember(CM,username,dong_name);
    
    if (result == -1) {
       out.print("<script>");
        out.print("alert('가입 신청 내용 수정이 정상적으로 완료되지 않았습니다.');");  
        out.print("history.back();");          
        out.print("</script>");     
        } else {
           out.print("<script>");
            out.print("alert('가입 신청 내용을 수정했습니다.');"); 
            out.print("history.back();");
            out.print("</script>");
     } 
 %>
</body>
</html>