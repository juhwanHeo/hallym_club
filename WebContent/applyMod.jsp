<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="clubMember.clubMemberDAO"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<jsp:useBean id="club_DAO" class="exam.jdbc.JDBC_clubDAO" />

<style>
table.type03 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 5px solid #369;
	margin-top: 30px;
}

table.type03 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: top;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type03 td {
	padding: 3px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

.bottom {
	position: absolute;
	width: 60%;
	top: 55%;
	left: 20%;
	text-align: center;
}

.apply {
	position: absolute;
	width: 36%;
	top: 62%;
	left: 64%;
}

font {
	color: red;
}

.button {
	width: 80px;
	background-color: #046BB9;
	border: none;
	color: #fff;
	padding: 5px 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	border-radius: 10px;
	cursor: pointer;
}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		int club_id = Integer.parseInt(request.getParameter("club_id"));
		/* String clunNM = request.getParameter("clubNM2");  */

		clubMemberDAO clubMember = new clubMemberDAO();

		String myInfo[] = new String[10];
		myInfo = clubMember.getUserForm(username, club_id);
	%>

	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>
	
	<div class="main">
		<form method="post" action="applyMod_Action.jsp">
			<h2>
				<input type="text" name="dong_name"
					value=<%=club_DAO.getClubNMs(club_id)%>
					style="border: none; Outline: none; font-size: 20pt; text-align: center;"
					readonly> 동아리 가입 정보 수정 
			</h2>
			<table class="type03">
				<tr>
					<th rowspan="6" width="20%"><br>
					<br>
					<br>인 적<br>사 항</th>
					<td width="20%">학과<font>*</font></td>
					<td width="20%"><input type="text" name="MAJOR"
						value=<%=myInfo[1]%>></td>
					<td width="20%">학년<font>*</font></td>
					<td width="20%"><input type="text" name="GRADE"
						value=<%=myInfo[2]%>></td>
				</tr>
				<tr>
					<td>학번<font>*</font></td>
					<td><input type="text" name="STUDENT_ID" value=<%=username%> readOnly></td>
					<!-- <input type="text" name="STUDENT_ID"></td>  -->
					<td>성명<font>*</font></td>
					<td><input type="text" style="width: 62%" name="NM"
						value=<%=myInfo[0]%>> <select name="GENDER_CD">
							<%-- <%myInfo[3]%> --%>
							<%
								if (myInfo[3].equals("003001")) {
							%>
							<option value="003001">남성</option>
							<option value="003002">여성</option>
							<%
								} else {
							%>
							<option value="003002">여성</option>
							<option value="003001">남성</option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td colspan="3"><input type="text" style="width: 99%"
						name="BIRTH_DT" placeholder="  ex)  19951212" value=<%=myInfo[7]%>></td>
				</tr>
				<tr>
					<td>전화번호<font>*</font></td>
					<td colspan="3"><input type="text" style="width: 99%"
						name="PHONE_NO" placeholder="  ex)  01012345678"
						value=<%=myInfo[4]%>></td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="3"><input type="text" style="width: 99%"
						name="ADDRESS" value=<%=myInfo[5]%>></td>
				</tr>
				<tr>
					<td>E-mail</td>
					<td colspan="3"><input type="text" style="width: 99%"
						name="EMAIL" value=<%=myInfo[6]%>></td>
				</tr>

				<tr>
					<th><br>차 후<br>활동계획</th>
					<td colspan="4" height="100px"><textarea
							style="width: 99%; height: 99%; resize: none" name="plan"><%=myInfo[8]%></textarea></td>
				</tr>

				<tr>
					<th><br>바라는 점</th>
					<td colspan="4" height="80px"><textarea
							style="width: 99%; height: 99%; resize: none" name="hope"><%=myInfo[9]%></textarea></td>
				</tr>
				<!-- 
    <tr>
       <th><br>비고</th>
        <td colspan="4" height="80px"><textarea style="width:99%; height:99%; resize: none" ></textarea></td> 
    </tr>
    -->

			</table>

			<div class="bottom">위의 기재한 내용이 틀림없음을 확인하며, 나의 정보를 수정 하겠습니다.</div>

			<div class="apply">
				<input type="submit" class="button" value="수정 하기">
			</div>
		</form>
	</div>

</body>
</html>