
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="user.UserDAO"%>
<%@page import="club.ClubDAO"%>
<%@page import="user.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clubMember.ClubMemberDAO"%>
<%@page import="clubMember.ClubMemberVo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>club_info</title>
</head>
<link rel="stylesheet" type="text/css" href="css/club_main.css?after">
<link rel="stylesheet" type="text/css" href="css/page.css?after">
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
	/* width: 100%; */
	overflow: auto;
}

/* #staff {
	background-color: white;
	border: 1px solid purple;
	border-radius: 10px;
	display: inline-block;
	font: inherit;
	line-height: 1.5em;
	padding: 0.5em 3.5em 0.5em 1em;
	margin: 0;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-appearance: none;
	-moz-appearance: none;
	background-image: linear-gradient(45deg, transparent 50%, gray 50%),
		linear-gradient(135deg, gray 50%, transparent 50%),
		radial-gradient(#ddd 70%, transparent 72%);
	background-position: calc(100% - 20px) calc(1em + 2px),
		calc(100% - 15px) calc(1em + 2px), calc(100% - .5em) .5em;
	background-size: 5px 5px, 5px 5px, 1.5em 1.5em;
	background-repeat: no-repeat;
} */
</style>

<body>
	<%
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}
		if (userId == null) {
			out.println("<script>");
			out.println("alert('로그인을 하세요.')");
			out.print("window.close();");
			out.println("</script>");
		} else if (!(userId.equals("20185280") || userId.equals("20185304") || userId.equals("20765")
				|| userId.equals("20152318") || userId.equals("20152335"))) {
			out.println("<script>");
			out.println("alert('관리자 권환이 필요헙니다.')");
			out.print("window.close();");
			out.println("</script>");
		} else {
			int club_id = Integer.parseInt(request.getParameter("club_id"));
	
			System.out.println("[club_info.jsp] club_id: " + club_id);
			ClubMemberDAO clubMemberDAO = new ClubMemberDAO();
			ClubDAO clubDAO = new ClubDAO();
			String club_NM = clubDAO.getClubNMs(club_id);
			String club_poster = clubDAO.getSavePosterName(club_id);
			String club_intro = clubDAO.getSaveIntroName(club_id);
			ArrayList<ClubMemberVo> clubMemberlist = clubMemberDAO.allMember(club_id);
	%>

				
	<div class="main">
		<div class="mainLeft" style="height: 700px;">
		
			<table id="myTable" class="type04" border="1"
					style="table-layout: fixed;">
					<%
					if(clubDAO.getTopClub_YN(club_id).equals("Y")) {
					
					%>
					<th style="font-size: 25px; width: 200px;">우수 동아리 순위</th>
					
						<tr>
						<th>현재 순위</th>
						<td><%=clubDAO.getTopClubRank(club_id)%></td>
						</tr>
	
						<form method="post" action="topClubRankAction.jsp" >
							<input type="hidden" name="club_id" value=<%=club_id%>>
							<tr>
							<th>순위 수정</th>
							<td><input style="width: 99%; height: 99%; resize: none" name="rank"></td>
							<td><input name="update" type="submit" value="수정"></td>
							</tr>
							
						</form>
			</table>
			<%} %>
				
			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">

				<th style="font-size: 25px; width: 200px;">프로필 및 포스터</th>
				

					<form method="post" action="clubPhotoChangeAction.jsp" enctype="multipart/form-data" >
						<input type="hidden" name="club_id" value=<%=club_id%>>
						
							<tr>
							<th onclick="window.open('upload/club/<%=club_intro %>','new img', 'width=750,height=850')">프로필</th>
							<td><input type="file" name="file1"></td>
							<td><input name="delete" type="submit" value="프로필 삭제"></td>
							</tr>
						
							<tr>
							<th onclick="window.open('upload/club/<%=club_poster %>','new img', 'width=750,height=850')">홍보 포스터</th>
							<td><input type="file" name="file2"></td>
							<td><input name="delete" type="submit" value="포스터 삭제"></td>
							</tr>
						
						<th><input name="update" type="submit" value="업로드"></th>
							
							
					</form>
			</table>

			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">

				<th style="font-size: 25px; width: 200px;">동아리원 추가</th>
				<tr>

					<form method="post" action="clubMemberAddAction.jsp">
						<input type="hidden" name="club_id" value=<%=club_id%>>
						<th style="font-size: 20px; width: 130px;">학번</th>
						<td><input style="width: 99%; height: 99%; resize: none"
							name="student_id">
						
						</td>

						<td>
						<select id="staff" name="staff" style="font-size: 20px">
								<!-- <option value="004001">회장</option> -->
								<option value="004002">부회장</option>
								<option value="004003">총무</option>
								<option value="004004" selected>회원</option>
						</select>
						</td>
						<td><input name="write" type="submit" value="추가"></td>
				</tr>
				</form>
			</table>

			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">
			<th style="font-size: 25px; width: 200px;"><%=club_NM%></th>
				<tr>
					<th style="font-size: 20px; width: 130px;">이름</th>
					<th style="font-size: 20px; width: 160px;">전공</th>
					<th style="font-size: 20px; width: 50px;">학년</th>
					<th style="font-size: 20px; width: 120px;">학번</th>
					<th style="font-size: 20px; width: 140px;">연락처</th>
					<th style="font-size: 20px; width: 70px;">직위</th>
					<th style="font-size: 20px; width: 95px;">가입일자</th>
					
					
					<!-- <th style="font-size: 20px; width: 125px;">가입여부</th> -->
				</tr>
			<%
				for (ClubMemberVo cvo : clubMemberlist) {
			%>
			
			
			<tr>
			
			
				<form method="post" action="clubMemberAddAction.jsp">
					<td><%=cvo.getNM()%></td>
					<td><%=cvo.getMAJOR()%></td>
					<td><%=cvo.getGRADE()%></td>
					<td><%=cvo.getSTUDENT_ID()%></td>
					<td><%=cvo.getPHONE_NO()%></td>
					<td><%=cvo.getSTAFF_CD()%></td>
					<td><%=cvo.getJoin_dt()%></td>
					<td>
						<input name="write" type="submit" value="삭제">
					</td>
					
					<input type="hidden" name="club_id" value=<%=club_id%>>
					<input type="hidden" name="student_id" value=<%=cvo.getSTUDENT_ID()%>>
				</form>

			</tr>
			<%
				}
		}
			%>

			</table>
		</div>
	</div>


</body>
</html>