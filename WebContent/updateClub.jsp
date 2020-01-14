<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="exam.jdbc.ClubVO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/club_main.css">


<style>
table.type03 {
	border-collapse: collapse;
	line-height: 1.5;
	border-top: 3px solid #369;
	border-left: 1px solid #ccc;
	font-size: 140%;
	width:100%;
	margin-bottom: 10px;
}

table.type03 th {
	padding: 3px;
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
</style>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");

		int club_id = 1;

		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
	%>


	<jsp:useBean id="CV_dao" class="exam.jdbc.JDBC_clubDAO" />

	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<div class="main">
		<h2>동아리 수정</h2>

		<%
			ArrayList<ClubVO> list = CV_dao.getClubInfo(club_id);
		%>

		<form method="post" action="clubUpdateAction.jsp" enctype="multipart/form-data"
			onsubmit="return check_form();">
			<table class="type03">

				<tr>
					<th>동아리명</th>
					<td style="color: #153d73; font-weight: bold;"><input
						type="hidden" name="club_id" value=<%=club_id%> /> <font
						color="black" style="margin-right: 100px;"><%=list.get(0).getClub_nm()%></font>
						<%-- 회원수 <input type="text" id="club_nm" name="club_nm" style="font-size:20px; margin-right:30px;" value=<%=list.get(0).getClub_nm() %>> 회원수
						<input type="text" name="cnt"
						style="font-size: 20px; text-align: right;" size="4"
						value=<%=list.get(0).getCnt()%>>명</td> --%>
				</tr>

				<tr>
					<th>구분</th>
					<td><input type="radio" name="club_gb_cd" value="001001"
						<%if (list.get(0).getClub_gb_cd().equals("001001"))
				out.println("checked='checked'");%> />
						중앙동아리 <input type="radio" name="club_gb_cd" value="001002"
						<%if (list.get(0).getClub_gb_cd().equals("001002"))
				out.println("checked='checked'");%> />
						과동아리</td>
				</tr>

				<tr>
					<th>분야</th>
					<td><input type="radio" name="club_at_cd" value="002001"
						<%if (list.get(0).getClub_at_cd().equals("002001"))
				out.println("checked='checked'");%> />
						학술 <input type="radio" name="club_at_cd" value="002002"
						<%if (list.get(0).getClub_at_cd().equals("002002"))
				out.println("checked='checked'");%> />
						운동 <input type="radio" name="club_at_cd" value="002003"
						<%if (list.get(0).getClub_at_cd().equals("002003"))
				out.println("checked='checked'");%> />
						봉사 <input type="radio" name="club_at_cd" value="002004"
						<%if (list.get(0).getClub_at_cd().equals("002004"))
				out.println("checked='checked'");%> />
						문화 <input type="radio" name="club_at_cd" value="002005"
						<%if (list.get(0).getClub_at_cd().equals("002005"))
				out.println("checked='checked'");%> />
						종교 <input type="radio" name="club_at_cd" value="002006"
						<%if (list.get(0).getClub_at_cd().equals("002006"))
				out.println("checked='checked'");%> />
						기타</td>
				</tr>

				<tr>
					<th>목적</th>
					<td colspan="2" height="60px"><textarea
							style="width: 99%; height: 99%; resize: none" name="club_aim"><%=list.get(0).getClub_aim()%></textarea></td>
				</tr>

				<tr>
					<th>활동</th>
					<td colspan="2" height="60px"><textarea
							style="width: 99%; height: 99%; resize: none" name="club_active"><%=list.get(0).getClub_active()%></textarea></td>
				</tr>

				<tr>
					<th>동아리 정보</th>
					<td style="text-align: left">
					개설년도<input type="text" name="open_dt" style="font-size: 20px; margin-left: 20px; border: 1px solid #ccc;"
						size="10" maxlength="8" value=<%=list.get(0).getOpen_dt()%>>
						동아리방<input type="text" name="club_room" style="font-size: 20px; margin-left: 20px; border :1px solid #ccc;" size="10"
						value=<%=list.get(0).getClub_room()%>>
					</td>
				</tr>



				<tr>
					<th>프로필</th>
					<td style="text-align: justify;"><input type="file" name="file1"></td>
				</tr>

				<tr>
					<th>홍보 포스터</th>
					<td style="text-align: justify;"><input type="file" name="file2"></td>
				</tr>

			</table>

			<input type="submit" value="수정" class="manage-btn">
			<input type="reset" value="취소" class="manage-btn" onclick="history.back();">

		</form>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		function check_form() {
			var ck_name = document.getElementById("club_nm").value;

			if (ck_name.trim() == "") {
				alert("동아리 이름을 입력해주세요");
				document.getElementById("club_nm").focus();
				return false;
			}

		}
	</script>
</body>
</html>