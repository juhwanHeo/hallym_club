


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
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link rel="stylesheet" type="text/css" href="css/page.css">
<style>
.main {
	float: left;
	position: relative;
	width: 100%;
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

<div id="header">
		<jsp:include page="header.jsp"></jsp:include>
</div>
	<%
		request.setCharacterEncoding("UTF-8");
		
		UserVO userVO = null;
		String userId = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else if(!(userId.equals("20185280") || userId.equals("20185304") || userId.equals("20765"))) {
			out.println("<script>");
			out.println("alert('관리자 권환이 필요헙니다.')");
			out.println("location.href='index.jsp'");
			out.println("</script>");
		}
		String category = "NM";
		String search = "";
		int pageNumber = 1; //현재 페이지 번호

		if (request.getParameter("category") != null) {
			category = request.getParameter("category");
		}
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		if (request.getParameter("pageNumber") != null) {
			try {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			} catch (Exception e) {
				System.out.println("검색 페이지 번호 오류");
			}
		}
		
	%>


	<div class="main">
		<div class="mainLeft" style="height: 700px;" >


			<%
				ClubDAO clubDAO = new ClubDAO();
				ClubMemberDAO clubMemberDAO = new ClubMemberDAO();
				int totalcount = 0;

				ArrayList<ClubVO> registeredClubList = clubDAO.getRegisteredClub();
				ArrayList<ClubVO> notRegisteredClubList = clubDAO.getNotRegisteredClub();%>
				
				
			<%--
			try {
				totalcount = member_list.get(0).getRow_count();
				System.out.println("[manage_list.jsp] totalcount: "+totalcount);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			 if (totalcount == 0) {
			
			<p>검색 결과가 없습니다.</p>
			<%
				} else {
			%>
			<p>
				검색 결과는
				<%=totalcount%>개 입니다.
			</p>
			<%
				}
			%> --%>
			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">
				<th style="font-size: 25px; width: 200px;">등록요청한 동아리</th>
				<tr>
					<th style="font-size: 20px; width: 160px;">동아리 명</th>
					<th style="font-size: 20px; width: 50px;">분야</th>
					<th style="font-size: 20px; width: 250px;">목적</th>
					<th style="font-size: 20px; width: 130px;">활동</th>
					<th style="font-size: 20px; width: 140px;">개설년도</th>
					<th style="font-size: 20px; width: 70px;">동아리방</th>
					<th style="font-size: 20px; width: 110px;">회장 이름</th>
					<th style="font-size: 20px; width: 110px;">회장 학번</th>
					<th style="font-size: 20px; width: 125px;">기타</th>
				</tr>
				<%
					//for (clubMember.ClubMemberVo cvo : member_list) {
						
						if(notRegisteredClubList != null) {
							for(ClubVO vo :notRegisteredClubList) {
							
						
						
				%>
			<form name="form" method="post" action="register_cd_update.jsp">
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
						
						<input type="hidden" name="club_id" value=<%=vo.getClub_id()%>>

						<td>
						<input type="submit" value="수락" name="submit" class="manage-btn"
						onclick="return confirm('<%=vo.getClub_nm()%>(<%=vo.getClub_id()%>) 수락하시겠습니까?');">
						
						<input type="submit" value="거절" name="submit" class="manage-btn"
						onclick="return confirm('<%=vo.getClub_nm()%>(<%=vo.getClub_id()%>) 거절하시겠습니까?');"></td>
					</tr>
				</form>
				<%
							}
					}
				%>

			</table>

			<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
				<th style="font-size: 25px; width: 200px;">등록된 동아리</th>
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
						
						for(ClubVO vo :registeredClubList) {
							
						
						
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
					<form name="form" method="post" action="club_info.jsp">
						<td class="club_manage" onclick="popup(<%=vo.getClub_id()%>)"><%=vo.getClub_nm() %></td>
						<input type="hidden" name="club_id" value=<%=vo.getClub_id() %>>
					</form>
						<td><%=title%></td>
						<td><%=vo.getClub_aim() %></td>
						<td><%=vo.getClub_active() %></td>
						<td><%=vo.getOpen_dt() %></td>
						<td><%=vo.getClub_room() %></td>
						<td><%=clubMemberDAO.getNm(vo.getClub_id())%></td>
						<td><%=clubMemberDAO.getStudent_id(vo.getClub_id())%></td>
						
					<form name="form" method="post" action="clubDeleteAction.jsp">
						<td>
							<input type="hidden" name="club_id" value=<%=vo.getClub_id() %>>
							<input type="submit" value="삭제" name="submit" class="manage-btn"
							onclick="return confirm('<%=vo.getClub_nm()%>(<%=vo.getClub_id()%>) 삭제하겠습니까?');"> 
						</td>
					</form>
					</tr>
				
				<%
					}
				%>

			</table>
			
			
			
			
			<!-- <p>
			<button id="export" onclick="data_export();">Excel다운</button>
				오류
			</p> -->
			<div class="page_wrap">
				<div class="page_nation">
					<%
						int countList = 10;
						int countPage = 5;
						int totalPage = totalcount / countList;
						if (totalcount > countList * totalPage) {
							totalPage++;
						}
						//현재 페이지가 총 페이지 번호보다 클 경우 
						if (totalPage < pageNumber) {
							pageNumber = totalPage;
						}
						int startPage = ((pageNumber - 1) / countPage) * countPage + 1; //페이지 번호  시작
						int endPage = startPage + countPage - 1; //페이지 번호 끝
						if (endPage > totalPage) {
							endPage = totalPage;
						}

						if (startPage > 1) {
					%>
					<a class="arrow pprev"
						href="club_manage.jsp?&category=<%=category%>&search=<%=search%>&pageNumber=<%=1%>">처음</a>
					<%
						}
						if (pageNumber > 1) {
					%>
					<a class="arrow prev"
						href="club_manage.jsp?&category=<%=category%>&search=<%=search%>&pageNumber=<%=pageNumber - 1%>">이전</a>
					<%
						}
						for (int i = startPage; i <= endPage; i++) {
							if (i == pageNumber) {
					%>
					<a class="active"
						href="club_manage.jsp?&category=<%=category%>&search=<%=search%>&pageNumber=<%=i%>"><%=i%></a>
					<%
						} else {
					%>
					<a
						href="club_manage.jsp?&category=<%=category%>&search=<%=search%>&pageNumber=<%=i%>"><%=i%></a>
					<%
						}
						}
					%>

					<%
						if (pageNumber < totalPage) {
					%>
					<a class="arrow next"
						href="club_manage.jsp?&category=<%=category%>&search=<%=search%>&pageNumber=<%=pageNumber + 1%>">다음</a>
					<%
						}
					%>

					<%
						if (endPage < totalPage) {
					%>
					<a class="arrow nnext"
						href="club_manage.jsp?&category=<%=category%>&search=<%=search%>&pageNumber=<%=totalPage%>">끝</a>
					<%
						}
					%>
				</div>
			</div>
			
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

	<div id="footer">
			<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>