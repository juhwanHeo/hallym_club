<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>

<%@page import="exam.jdbc.ClubVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.jdbc.JDBC_clubDAO"%>

<%@page import="clubMember.clubMemberVo"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 </title>
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link rel="stylesheet" type="text/css" href="css/table.css">

<style>
html, body {
	width: 100%;
	height: 100%;
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
	border-right: 1px solid #ccc;
	border-top: 3px solid #369;
	margin: 5px 3px;
}

table.type02 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: top;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type02 td {
	font-size:13px;
	padding: 3px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

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
	border: 1px solid #ccc;
	float: left;
	height: 300px;
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
*
/
</style>
</head>
<body>
	<%
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		if (username == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}

		int row_index = 0;

		if (request.getParameter("row_index") != null) {
			row_index = Integer.parseInt(request.getParameter("row_index"));
		}

		int club_id = 1;
		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
		request.setCharacterEncoding("UTF-8");
	%>

	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>


	<div class="main">
		<div class="mainLeft">
			<input type="hidden" name="row_index" id="row_index"
				value=<%=row_index%>>

			<jsp:useBean id="member_dao" class="clubMember.clubMemberDAO" />
			<%
				ArrayList<clubMemberVo> member_list = member_dao.club_getMember(club_id, "008003");
			%>
			<table class="type04" border="1">
				<tr>
					<th style="font-size: 15px; width: 500px;">전공</th>
					<th style="font-size: 15px; width: 500px;">학번</th>
					<th style="font-size: 15px; width: 500px;">이름</th>
				</tr>
				<%
					if (member_list.size() == 0) {
				%>
				<tr>
					<th colspan="3">동아리 가입 신청이 없습니다.</th>
				</tr>
				<%
					} else {
						for (clubMemberVo cvo : member_list) {
				%>
				<tr onclick="getIndex(this);" id="club_table"
					style="cursor: pointer">
					<td><%=cvo.getMAJOR()%></td>
					<td><%=cvo.getSTUDENT_ID()%></td>
					<td><%=cvo.getNM()%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>

		<div class="mainRight">

			<form method="post" action="join_cd_update.jsp">
				<input type="hidden" name="join_club" id="join_club"
					value=<%=club_id%>>
				<table class="type02">
					<tr>
						<th rowspan="6" width="20%"><br> <br> <br>인 적<br>사
							항</th>
						<td width="20%">학과<font>*</font></td>
						<td width="20%"><input type="text" name="MAJOR" id="MAJOR"
							value=<%=member_list.get(row_index).getMAJOR()%>
							readonly="readonly"></td>
						<td width="20%">학년<font>*</font></td>
						<td width="20%"><input type="text" name="GRADE" id="GRADE"
							value=<%=member_list.get(row_index).getGRADE()%>
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>학번<font>*</font></td>
						<td><input type="text" name="student_id" readonly="readonly"
							value=<%=member_list.get(row_index).getSTUDENT_ID()%>></td>

						<td>성명<font>*</font></td>
						<td><input type="text" style="width: 62%" name="NM" id="NM"
							value=<%=member_list.get(row_index).getNM()%> readonly="readonly">
							<%
								if (member_list.get(row_index).getGENDER_CD().equals("003001")) {
										out.println("남성");
									} else {
										out.println("여성");
									}
							%></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td colspan="3"><input type="text" style="width: 99%"
							name="BIRTH_DT" id="BIRTH_DT" readonly="readonly"
							value=<%=member_list.get(row_index).getBIRTH_DT()%>></td>
					</tr>
					<tr>
						<td>전화번호<font>*</font></td>
						<td colspan="3"><input type="text" style="width: 99%"
							name="PHONE_NO" id="PHONE_NO" readonly="readonly"
							value=<%=member_list.get(row_index).getPHONE_NO()%>></td>
					</tr>
					<tr>
						<td>주소</td>
						<td colspan="3"><input type="text" style="width: 99%"
							name="ADDRESS" readonly="readonly"
							value=<%=member_list.get(row_index).getADDRESS()%>></td>
					</tr>
					<tr>
						<td>E-mail</td>
						<td colspan="3"><input type="text" style="width: 99%"
							name="EMAIL" readonly="readonly"
							value=<%=member_list.get(row_index).getEMAIL()%>></td>
					</tr>

					<tr>
						<th><br>차 후<br>활동계획</th>
						<td colspan="4" height="100px"><textarea
								style="width: 99%; height: 99%; resize: none"
								readonly="readonly" name="plan"><%=member_list.get(row_index).getPlan()%> </textarea></td>
					</tr>

					<tr>
						<th><br>바라는 점</th>
						<td colspan="4" height="80px"><textarea
								style="width: 99%; height: 99%; resize: none"
								readonly="readonly" name="hope"><%=member_list.get(row_index).getHope()%></textarea></td>
					</tr>

				</table>
				<input type="submit" value="승인" name="submit" class="manage-btn"> 
				<input type="submit" value="거부" name="submit" class="manage-btn">
				<%
					}
				%>
			</form>
		</div>
	</div>
	<script>
	
	var a = document.getElementById("club_table").parentNode;
	var idx = parseInt(document.getElementById("row_index").value) + 1;
	var trs = a.getElementsByTagName('tr');

	for ( var i = 0; i < trs.length; i++ ) {
			trs[i].style.backgroundColor = "white";
			trs[idx].style.backgroundColor = "#dcdcdc";
		}

	function club_post(){
		var id = document.getElementById("club_id").value;
		location.href="manage.jsp?club_id="+id;	//선택 값이 바뀌면 첫 행부터
	}

	function getIndex(x){
		var idx = x.rowIndex-1;
		document.getElementById("row_index").value = x.rowIndex-1;
		location.href="manage.jsp?club_id=<%=club_id%>&row_index=" + idx;
	}
	</script>

</body>
</html>