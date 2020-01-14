<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link rel="stylesheet" type="text/css" href="css/table.css">

<jsp:useBean id="bbsDAO" class="bbs.BbsDAO" />
<jsp:useBean id="agreeDAO" class="club_Agree.clubAgreeDAO" />
<style>
table.type04 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-left: 1px solid #ccc;
	border-top: 3px solid #369;
	margin: auto;
	text-align: center;
	width: 100%;
	font-size: 13px;
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
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type02 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-right: 1px solid #369;
	border-top: 1px solid #ccc;
}

table.type02 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: center;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

/* table.type02 td {
	font-size: 13px;
	padding: 3px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
} */
#left_side {
	float: left;
	margin: 5px;
	margin-left: 3%;
	padding: 10px;
	min-height: 60%;
	width: 15.5%;
	margin-top: 7%;
}

.mainLeft {
	float: left;
	height: 50px;
	width: 100%;
	overflow: auto;
}

.mainRight {
	border: 0px;
	float: left;
	height: 450px;
	width: 100%;
	overflow: hidden;
}

/* .type03 a{
	text-decoration: none;
} */
a:link {
	color: black;
	text-decoration: none;
}

a:active {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}
</style>
</head>
<body>
	<%
		String userID = null;

		if (session.getAttribute("username") != null) {

			userID = (String) session.getAttribute("username");

		}

		int club_id = Integer.parseInt(request.getParameter("club_id"));

		int title_no = Integer.parseInt(request.getParameter("title_no"));
	%>
	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<div class="main">
		<div class="mainLeft">
			<table class="type04" border="1">
				<tr>
					<th style="font-size: 15px; width: 40%;">일정</th>
					<td>
						<form action="club_agreeMember.jsp">
							<input type="hidden" name="club_id" value=<%=club_id%>> <select
								name="title_no" onchange="this.form.submit()">
								<%
									ArrayList<String[]> Title = bbsDAO.get_CalendarTitle(club_id);
									if (!Title.isEmpty()) {
										for (int i = 0; i < Title.size(); i++) {
											if (Integer.parseInt(Title.get(i)[1]) == title_no) {
								%>
								<option value=<%=Title.get(i)[1]%> selected>
									<%=Title.get(i)[0]%>
								</option>
								<%
									} else {
								%>
								<option value=<%=Title.get(i)[1]%>>
									<%=Title.get(i)[0]%>
								</option>
								<%
									}
										}
									}
								%>
							</select>
						</form>
					</td>
				</tr>
			</table>
		</div>

		<div class="mainRight">
			<table class="type04" style="border-top:0px;">
				<tr>
					<th style="font-size: 15px; width: 40%;">학번</th>
					</tr>
					<tr>
					
						<%
							if (!Title.isEmpty()) {
								if (title_no == -1)
									title_no = Integer.parseInt(Title.get(0)[1]);
								
									ArrayList<String> AgreeMember = agreeDAO.getAgreeMember(club_id, title_no);
									if (AgreeMember != null) {
										for (int i = 0; i < AgreeMember.size(); i++) {%>
											<tr><td><%=AgreeMember.get(i)%></td></tr>
										<%}
									}
								}
						%>

			</table>
		</div>
	</div>
</body>
</html>