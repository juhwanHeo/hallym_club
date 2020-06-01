<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>
<jsp:useBean id="clubMem_DAO" class="clubMember.ClubMemberDAO" />
<jsp:useBean id="club_DAO" class="club.ClubDAO" />

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

		if (club_id == -1) {
			out.println("<script>alert('가입 동아리를 선택해주세요.');</script>");
		} else {
			ArrayList<String[]> allClubItem = club_DAO.getItems(club_id);
			System.out.println(allClubItem.size());
			int staff_cd = clubMem_DAO.getStaff_CD(userId, club_id);
	%>

	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<div class="main">
		<form method=post action="club_itemAction.jsp">
			<input type="hidden" value=<%=club_id%> name="club_id">
			<table id="table"
				style="margin: 0 auto; overflow: auto; display: block;">
				<tr>
					<th scope="col" style="width: 20%;">물품명</th>
					<th scope="col" style="width: 10%;">물품 수</th>
					<th scope="col" style="width: 60%; text-align: center;">물품 설명</th>
					<th scope="col" style="width: 10%; text-align: center;">*</th>
				</tr>

				<tbody id="my-tbody">
					<%
						if (allClubItem.size() != 0) {
								for (int index = 0; index < allClubItem.size(); index++) {
					%>

					<tr>
						<%
							// ^[0-9]*$
										// /[^0-9]/g,''
										if (staff_cd == 0) {
											System.out.println("[club_item.jsp] 물품 수: " + allClubItem.get(index)[2]);
						%>
						<td style="border: 1px solid #dddddd;"><input type="text"
							value=<%=allClubItem.get(index)[0]%>
							style="text-align: center; width: 20%; height: 30px;"
							name="Item_nm"></td>

						<td style="border: 1px solid #dddddd;"><input type="text"
							value=<%=allClubItem.get(index)[2]%>
							style="text-align: center; width: 100%; height: 30px;"
							name="Tot_cnt"
							onKeyup="this.value=this.value.replace(/^[0-9]*$/g,''); numberWithCommas(this);"></td>

						<td style="border: 1px solid #dddddd;"><input type="text"
							value="<%=allClubItem.get(index)[1]%>"
							style="text-align: center; width: 60%; height: 30px;"
							name="Item_cont"></td>
						<td style="border: 1px solid #dddddd; width: 10%;"><span>삭제</span></td>
						<%
							} else {
						%>
						<td style="border: 1px solid #dddddd;"><input type="text"
							value=<%=allClubItem.get(index)[0]%>
							style="text-align: center; width: 20%; height: 30px;"
							name="Item_nm" readonly></td>

						<td style="border: 1px solid #dddddd;"><input type="text"
							value=<%=allClubItem.get(index)[2]%>
							style="text-align: center; width: 10%; height: 30px;"
							name="Tot_cnt" readonly></td>

						<td style="border: 1px solid #dddddd;"><input type="text"
							value="<%=allClubItem.get(index)[1]%>"
							style="text-align: center; width: 60%; height: 30px;"
							name="Item_cont" readonly></td>
						<td style="border: 1px solid #dddddd; width: 10%;"><span></span></td>
						<%
							}
						%>
					</tr>
					<%
						}
							}
					%>
				</tbody>
				<%
					if (staff_cd == 0) {
				%>
				<tfoot>
					<tr>
						<td colspan="3"></td>
						<th scope="row">
							<%-- <input type="text" value=<%=club_id%>
							name="club_name" style="display: none;" />  --%> <input
							type="submit" value="완료"
							style="float: center; background-color: white; border: 2px solid lightblue; font-size: 13px;">
							<button type="button" onclick="add_row()"
								style="float: center; background-color: white; border: 2px solid lightblue; font-size: 13px;">행
								추가</button>
					</tr>

				</tfoot>
				<%
					} else {
				%>
				<tfoot>
				</tfoot>
				<%
					}
				%>
			</table>
		</form>
		<%
			}
		%>
		
	</div>
	<hr>
		<div id="footer">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	<hr>

	<script>
		function numberWithCommas(x) {
			var y = x.value;
			y = y.replace(/[^0-9]/g, ''); // 입력값이 숫자가 아니면 공백
			y = y.replace(/,/g, ''); // ,값 공백처리
			var x_id = x.getAttribute('id');
			$('#' + x_id).val(y.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
		}

		function add_row() {
			var newDiv = document.createElement("tr");
			newDiv.innerHTML = "<td style='border: 1px solid #dddddd;' ><input type='text' style='text-align: center; width: 100px; height: 30px;' name='Item_nm'></td> <td style='border: 1px solid #dddddd;'><input type='text' style='text-align: center; width: 50px; height: 30px;' name='Tot_cnt' onKeyup=this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);></td> <td style='border: 1px solid #dddddd;'><input type='text' style='text-align: center; width: 500px; height: 30px;' name='Item_cont'></td> <td style='border: 1px solid #dddddd;'><span>삭제</span></td>";
			document.getElementById('my-tbody').appendChild(newDiv);
			var objDiv = document.getElementById("table");
			objDiv.scrollTop = objDiv.scrollHeight;
		}
	</script>

	<script type="text/javascript"
		src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>

	<script type="text/javascript">
		$(function() {
			$("#table").on("click", "span", function() {
				$(this).closest("tr").remove();
			});
		});
	</script>
</body>
</html>