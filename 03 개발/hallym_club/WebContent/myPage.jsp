


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="user.UserVO"%>
<%@page import="club.ClubVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="clubMember.ClubMemberDAO"%>
<%@page import="club.ClubDAO"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/club_main.css?after">
<link rel="stylesheet" type="text/css" href="css/page.css?after">
<style>
.main {
	float: left; 
	left:12%;
	position: relative;
	width: 75%;
	height: 100%;
	margin-left: 20px;
}

table.type04 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-left: 1px solid #ccc;
	border-top: 3px solid #369;
	margin: auto;
	text-align: center;
	width: 100%;
	font-size: 25px;
}

table.type04 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: top;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type04 td {
	padding: 3px;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	vertical-align: middle;
}

.mainLeft {
	border: 1px solid #ccc;
	margin: 0 auto;
	display: block;
	padding: 10px;
	min-height: 75%;
	/*width: 100%; */
	overflow: auto;
}

.club_manage {
	text-decoration: none;
	color: black;
}

.club_manage:hover {
	text-decoration: underline;
	color: blue;
}
</style>
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
		if (userId == null) {
			
			out.println("<script>");
			out.println("alert('로그인을 하세요.')");
			out.println("location.href = 'login.jsp'");
			out.println("</script>");
		} 
		
		
		
	%>
	<div id="wrap">
		<div id="header">
				<jsp:include page="header.jsp"></jsp:include>
		</div>

		<div id="content">
			<div class="main">
				<div class="mainLeft" style="height: 700px;" >
		
		
					<%
						ClubDAO clubDAO = new ClubDAO();
						ClubMemberDAO clubMemberDAO = new ClubMemberDAO();
						
						ArrayList<ClubVO> waitMyClub = clubDAO.getMyWaitClubList(userId);
						ArrayList<ClubVO> waitRegisteredMyClub = clubDAO.getMyWaitRegisteredClubList(userId);
						
					%>
						
					<table id="myTable" class="type04" border="1"
						style="table-layout: fixed;">
						<th style="font-size: 25px; width: 500px;">가입 승인 중인 동아리</th>
						<tr>
							<th style="font-size: 20px; width: 500px;">동아리 명</th>
							<th style="font-size: 20px; width: 125px;">기타</th>
						</tr>
						<%
								
								if(waitMyClub != null) {
									for(ClubVO clubVO :waitMyClub) {
									
								
								
						%>
						<form method="post" action="applyDeleteAction.jsp">
							<tr>
								
								<td><%=clubVO.getClub_nm() %></td>
								
								<input type="hidden" name="club_id" value=<%=clubVO.getClub_id()%>>
								<input type="hidden" name="clubNM" value=<%=clubVO.getClub_nm()%>>
		
								<td>
								<input type="submit" value="신청 취소" name="submit" class="manage-btn"
								onclick="return confirm('<%=clubVO.getClub_nm()%> 가입 신청을 취소하시겠습니까?');">
							</tr>
						</form>
						<%
									}
							} else {
						%>
						<p> 없음 </p>
						
						<% } %>
						
						
						
		
					</table>
					
					
					
		
					<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
						<th style="font-size: 25px; width: 200px;">동아리 등록 현황</th>
						<tr>
						
						
						
							<th style="font-size: 20px; width: 160px;">동아리 명</th>
							<th style="font-size: 20px; width: 50px;">분야</th>
							<th style="font-size: 20px; width: 550px;">목적</th>
							<th style="font-size: 20px; width: 130px;">활동</th>
							<th style="font-size: 20px; width: 140px;">개설년도</th>
							<th style="font-size: 20px; width: 70px;">동아리방</th>
							<th style="font-size: 20px; width: 110px;">회장 이름</th>
							<th style="font-size: 20px; width: 110px;">회장 학번</th>
							<th style="font-size: 20px; width: 125px;">기타</th>
						</tr>
						<%
							//for (clubMember.ClubMemberVo cvo : member_list) {
								
								for(ClubVO vo :waitRegisteredMyClub) {
									
						%>
					
						<tr>
						
								<%
								String title = "";
									switch(vo.getClub_at_cd() ) {
									case "002001":
										title = "공연";
										break;
									case "002002":
										title = "학술";
										break;
									case "002003":
										title = "취미예술";
										break;
									case "002004":
										title = "종교";
										break;
									case "002005":
										title = "체육";
										break;
									case "002006":
										title = "봉사";
										break;
									case "002007":
										title = "기타";
										break;
										
										
										
										
									}
									
									%>
							
								<td><%=vo.getClub_nm() %></td>
								<td><%=title%></td>
								<td><%=vo.getClub_aim() %></td>
								<td><%=vo.getClub_active() %></td>
								<td><%=vo.getOpen_dt() %></td>
								<td><%=vo.getClub_room() %></td>
								<td><%=clubMemberDAO.getNm(vo.getClub_id())%></td>
								<td><%=clubMemberDAO.getStudent_id(vo.getClub_id())%></td>
								
							<form name="form" method="post" action="applyClubRegisterDeleteAction.jsp">
								<td>
									<input type="hidden" name="club_id" value=<%=vo.getClub_id() %>>
									<input type="hidden" name="clubNM" value=<%=vo.getClub_nm() %>>
									<input type="submit" value="신청 취소" name="submit" class="manage-btn"
									onclick="return confirm('<%=vo.getClub_nm()%> 동아리 등록을 취소하시겠습니까?');"> 
								</td>
							</form>
							</tr>
						
						<%
							}
						%>
		
					</table>
					
					
					
				</div>
			</div>
		</div>

		<div id="footer">
				<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

	<script>
		function popup(frm) {
			var url = "club_info.jsp?club_id="+frm;
			var title = "testpop";
			var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=950, height=500, top=50,left=20";
			window.open(url, title, status); 
			//window.open(url,title,status); window.open 함수에 url을 앞에와 같이
			//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
			//가능합니다.
			frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
			frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
			frm.method = "post";
			frm.submit();
		}
	</script>

</body>
</html>