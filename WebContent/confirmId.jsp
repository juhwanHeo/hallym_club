<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 확인</title>

<style>
#btn {
	
	width: 100px;
	background-color: #4285F4;
	border: none;
	color: #fff;
	padding: 15px 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px;
	cursor: pointer;
	border-radius: 10px;
}
</style>
</head>
<body>

<%request.setCharacterEncoding("UTF-8");%>
 
    <jsp:useBean id="vo" class="Student.StudentVO" />
    <jsp:setProperty property="*" name="vo"/>
    <jsp:useBean id="dao" class="exam.jdbc.JDBC_studentDAO"/>
    
    
 <%
 	
 	String id = (String)request.getParameter("username");
 	if(dao.check(id)){%>
 		<center>
 		<h4>이미 사용중인 ID 입니다.</h4>
 				
		<button id="btn" href="#" onclick = "window.close(); opener.document.getElementById('username').value = ''; ">닫기</button>
		</center>
		<script>
		opener.document.getElementById('username').focus();
		</script>
		
		
 	<% } else{ %>
 		<center>
 		<h4>입력하신 <%=id %>는 사용하실 수 있는 ID입니다.</h4>
 		<button id="btn" href="#" onclick = "window.close();">사용하기</button>
 		</center> 		
 		<script>
		opener.document.getElementById('password').focus();
		</script>
 	<% } %>

 
</body>
</html>