<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
                   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%request.setCharacterEncoding("UTF-8");%>
 
    <jsp:useBean id="CM" class="clubMember.clubMemberVo" />
    <jsp:setProperty property="*" name="CM"/>
    <jsp:useBean id="CM_dao" class="clubMember.clubMemberDAO"/>

<%	    
	
    int result = CM_dao.writeMember(CM);
    
    if (result == -1) {
    	out.print("<script>");
        out.print("alert('가입 신청이 정상적으로 완료되지 않았습니다.');");  
        out.print("history.back();");          
        out.print("</script>");     
        } else {
        	out.print("<script>");
            out.print("alert('가입 신청을 완료했습니다.');");  
            out.print("location.href='club_search.jsp';");
            out.print("window.close();");
            out.print("</script>");
     }
 %>
</body>
</html>