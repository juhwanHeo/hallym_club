<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clubMember.ClubMemberVo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>
<jsp:useBean id="DAO" class="clubMember.ClubMemberDAO" />

<link rel="stylesheet" type="text/css" href="css/club_main.css?after">
<link rel="stylesheet" type="text/css" href="css/table.css?after">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}

		int club_id = Integer.parseInt(request.getParameter("club_id"));

		if (club_id == -1)
			out.println("<script>alert('가입 동아리를 선택해주세요.');</script>");
		else {
			ArrayList<clubMember.ClubMemberVo> getMember = DAO.allMember(club_id);
	%>

	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<div class="main" style="overflow: auto; max-height: 550px;">
		<table id="table">
			<thead>
				<tr>
					<th scope="col" style="width: 20%;">이름</th>
					<!-- <th scope="col" style="width: 15%;">성별</th> -->
					<th scope="col" style="width: 20%;">직위</th>
					<th scope="col" style="width: 20%;">전공</th>
					<th scope="col" style="width: 22%;">전화번호</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (int i = 0; i < getMember.size(); i++) {
				%>
				<tr>
					<td><strong><%=getMember.get(i).getNM()%></strong></td>
					<%--<td>
						 <%
							if (getMember.get(i).getGENDER_CD().equals("003001")) {
						%> 남성 <%
							} else {
						%> 여성 <%
							}
						%> 
					</td>--%>
					
					<td><%=getMember.get(i).getSTAFF_CD()%></td>
					<td><%=getMember.get(i).getMAJOR()%></td>
					<td><%=getMember.get(i).getPHONE_NO()%></td>
				</tr>
				<%
					}
					}
				%>
			</tbody>
		</table>
	</div>
	<hr>
	<div id="footer">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<hr>
</body>
</html>