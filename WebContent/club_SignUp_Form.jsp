<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 가입 양식</title>

<style>
table.type03 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 5px solid #369;
	margin: 5px 3px;
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
	top: 72%;
	left: 20%;
	text-align: center;
}

.apply {
	position: absolute;
	width: 36%;
	top: 78%;
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
	%>
	<jsp:useBean id="CM_dao" class="clubMember.clubMemberDAO" />
	<jsp:useBean id="student_dao" class="Student.StudentDAO" />
	<jsp:useBean id="club_dao" class="exam.jdbc.JDBC_clubDAO" />
	<%
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}

		String club_nm = "";
		if (request.getParameter("club_nm") != null)
			club_nm = request.getParameter("club_nm");

		int club_id = 1;
		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}

		int check = CM_dao.overlapCheck(username, club_id);

		if (check == 0) {
			out.print("<script>");
			out.print("self.close();");
			out.print("alert('이미 가입신청 한 동아리 입니다. 나의 정보 페이지를 확인해주세요.');");
			out.print("</script>");
		} else if (check == 1) {
			out.print("<script>");
			out.print("self.close();");
			out.print("alert('이미 가입한 동아리 입니다. 나의 정보 페이지를 확인해주세요.');");
			out.print("</script>");
		} else if (check == 2) {
	%>

	<form method="post" action="club_SignUp_Action.jsp"
		onsubmit="return check_form();">
		<h2><%=club_nm%>
			동아리 가입 신청서
		</h2>
		<input type="text" name="CLUB_ID" value=<%=club_id%>
			style="display: none">

		<table class="type03">
			<tr>
				<th rowspan="6" width="20%"><br> <br> <br>인 적<br>사
					항</th>
				<td width="20%">학과<font>*</font></td>
				<td width="20%"><input type="text" name="MAJOR" id="MAJOR"></td>
				<td width="20%">학년<font>*</font></td>
				<td width="20%"><input type="text" name="GRADE" id="GRADE"
					placeholder=" ex) 1"></td>
			</tr>
			<tr>
				<td>학번<font>*</font></td>
				<td><input type="text" name="STUDENT_ID" readonly="readonly"
					value=<%=username%>></td>
				<!-- <input type="text" name="STUDENT_ID"></td>  -->
				<td>성명<font>*</font></td>
				<td><input type="text" style="width: 62%" name="NM" id="NM">
					<select name="GENDER_CD" id="GENDER">
						<option value="">성별*</option>
						<option value="003001">남성</option>
						<option value="003002">여성</option>
				</select></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td colspan="3"><input type="text" style="width: 99%"
					name="BIRTH_DT" id="BIRTH_DT" placeholder="  ex)  19951212"></td>
			</tr>
			<tr>
				<td>전화번호<font>*</font></td>
				<td colspan="3"><input type="text" style="width: 99%"
					name="PHONE_NO" id="PHONE_NO" placeholder="  ex)  01012345678"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td colspan="3"><input type="text" style="width: 99%"
					name="ADDRESS"></td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td colspan="3"><input type="text" style="width: 99%"
					name="EMAIL"></td>
			</tr>

			<tr>
				<th><br>차 후<br>활동계획</th>
				<td colspan="4" height="100px"><textarea
						style="width: 99%; height: 99%; resize: none" name="plan"></textarea></td>
			</tr>

			<tr>
				<th><br>바라는 점</th>
				<td colspan="4" height="80px"><textarea
						style="width: 99%; height: 99%; resize: none" name="hope"></textarea></td>
			</tr>
		</table>

		<div class="bottom">위의 기재한 내용이 틀림없음을 확인하며 가입을 신청합니다.</div>

		<div class="apply">
			신청자(학번)<font>*</font> ( <input type="text" style="width: 30%;"
				id="apply"> ) <input type="submit" class="button"
				value="제출 하기">
		</div>

	</form>
	<%
		}
	%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		function check_form() {
			var ck_major = document.getElementById("MAJOR").value;
			var ck_grade = document.getElementById("GRADE").value;
			var ck_nm = document.getElementById("NM").value;
			var ck_gender = document.getElementById("GENDER").value;
			var ck_phone = document.getElementById("PHONE_NO").value;
			var ck_apply = document.getElementById("apply").value;
			var ck_birth = document.getElementById("BIRTH_DT").value;

			var exp = /^[0-9]{1}$/; //숫자만, 글자수 1
			var exp1 = /^[0-9]{9,13}$/; //숫자만, 전화번호 검증
			var exp2 = /^[0-9]{8}$/; //숫자만, 글자수8

			if (ck_major.trim() == "") {
				alert("학과를 입력해주세요");
				document.getElementById("MAJOR").focus();
				return false;
			}
			if (!ck_grade.match(exp)) {
				alert("학년은 숫자 1글자로 입력해주세요.");
				document.getElementById("GRADE").focus();
				return false;
			}
			if (ck_nm.trim() == "") {
				alert("이름을 입력해주세요");
				document.getElementById("NM").focus();
				return false;
			}
			if (ck_gender == "") {
				alert("성별을 선택해주세요");
				document.getElementById("GENDER").focus();
				return false;
			}
			if (ck_phone.trim() == "") {
				alert("전화번호를 입력해주세요.");
				document.getElementById("PHONE_NO").focus();
				return false;
			}
			if (!ck_phone.match(exp1)) {
				alert("전화번호는 -를 제외하고 입력해주세요");
				document.getElementById("PHONE_NO").focus();
				return false;
			}
			if (ck_apply.trim() == "") {
				alert("서명해주세요.");
				document.getElementById("apply").focus();
				return false;
			}
			if (ck_apply !=
	<%=username%>
		) {
				alert("학번을 정확하게 서명해주세요.");
				document.getElementById("apply").focus();
				return false;
			}
			if (ck_birth.trim() != "" && !ck_birth.match(exp2)) {
				alert("생년월일 순으로 입력해주세요. \n 입력예) 19950101");
				document.getElementById("BIRTH_DT").focus();
				return false;
			}

		}
	</script>


</body>
</html>