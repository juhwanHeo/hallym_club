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

	System.out.println("[logoutAction.jsp]: before " + session.getAttribute("userVO"));
	session.invalidate();
	/* if(session.getAttribute("uesrVO") != null){
		session.removeAttribute("userVO");
	}
	if (session.getAttribute("club_id") != null) {
		session.removeAttribute("club_id");
	}
	
	if(session.getAttribute("staff_cd") != null) {
		session.removeAttribute("staff_cd");
	}
	 */
	//System.out.println("[logoutAction.jsp]: after " + session.getAttribute("userVO"));
	%>
<script>
	location.href="index.jsp";
</script>
</body>
</html>