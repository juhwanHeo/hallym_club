<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="budget.BudgetVO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link rel="stylesheet" type="text/css" href="css/budget.css">
<style>

</style>
</head>
<body>

	<script>
		function addComma(num) {
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			return num.toString().replace(regexp, ',');
		}
	</script>


	<%
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int yyyy = cal.get(cal.YEAR);
		int year = cal.get(cal.YEAR);
		if (request.getParameter("year") != null) {
			year = Integer.parseInt(request.getParameter("year"));
		}

		int month = cal.get(cal.MONTH) + 1;
		if (request.getParameter("month") != null) {
			month = Integer.parseInt(request.getParameter("month"));
		}

		int club_id = 1;
		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}

		String io_gb_cd = "";
		if (request.getParameter("io_gb_cd") != null) {
			io_gb_cd = request.getParameter("io_gb_cd");
		}
	%>

	<script>
		function move_url(x) {
			var io_gb_cd = x.value;
			var url = "club_budget.jsp?club_id=" +
	<%=club_id%>
		+ "&io_gb_cd="
					+ io_gb_cd;
			location.href = url;
		}
	</script>

	<jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

	<div class="main">
		<div style="text-align: justify;">
			<div id="up-btn">
				<button class="io-btn" name="io_gb_cd" value="009001"
					onclick="move_url(this);">수입</button>
				<button class="io-btn" name="io_gb_cd" value="009002"
					onclick="move_url(this);">지출</button>
				<button class="io-btn-select"
					onclick="location.href = 'club_budgetTotal.jsp?club_id=<%=club_id%>';">월별
					보고서</button>
			</div>

			<form method="post"
				action="club_budgetTotal.jsp?club_id=<%=club_id%>"
				style="margin-bottom: 30px;">
				<select name="year" style="font-size: 18px;">
					<option value='0' selected>전체(년)</option>
					<%
						for (int i = -2; i < 5; i++) {
					%>
					<option value=<%=yyyy + i%>
						<%if (yyyy + i == year)
					out.println("selected");%>>
						<%=yyyy + i%>년
					</option>
					<%
						}
					%>

				</select> 
				<select name="month" style="font-size: 18px;">
					<option value='0' selected>전체(월)</option>
					<%
						for (int i = 1; i < 13; i++) {
					%>
					<option value=<%=i%>
						<%if (i == month)
					out.println("selected");%>>
						<%=i%>월
					</option>
					<%
						}
					%>
				</select> <input type="submit" name="submit" value="조회" class="search-btn"/>
			</form>

			<jsp:useBean id="budget_dao" class="budget.BudgetDAO" />

			<table class="total-tbl" style="margin-right: 30px;">
				<tr>
					<th colspan="3">수입</th>
				</tr>
				<tr>
					<th style="width: 100px;">날짜</th>
					<th class="cont">내용</th>
					<th class="price">금액</th>
				</tr>
				<%
					ArrayList<BudgetVO> budget_list = budget_dao.getBudget(club_id, "009001", year, month);

					if (budget_list.isEmpty()) {
				%>
				<tr>
					<td colspan="3">조회된 값이 없습니다.</td>
				</tr>
				<%
					} else {

						for (BudgetVO vo : budget_list) {
				%>
				<tr>
					<td><%=vo.getUse_dt()%></td>
					<td class="cont"><%=vo.getContents()%></td>
					<td class="price"><script>
						document.write(addComma(
					<%=vo.getPrice()%>
						));
					</script></td>

				</tr>
				<%
					}
				%>
				<%
					}
				%>
			</table>

			<table class="total-tbl">
				<tr>
					<th colspan="3">지출</th>
				</tr>
				<tr>
					<th style="width: 100px;">날짜</th>
					<th class="cont">내용</th>
					<th class="price">금액</th>
				</tr>
				<%
					budget_list = budget_dao.getBudget(club_id, "009002", year, month);

					if (budget_list.isEmpty()) {
				%>
				<tr>
					<td colspan="3">조회된 값이 없습니다.</td>
				</tr>
				<%
					} else {

						for (BudgetVO vo : budget_list) {
				%>
				<tr>
					<td><%=vo.getUse_dt()%></td>
					<td class="cont"><%=vo.getContents()%></td>
					<td class="price"><script>
						document.write(addComma(
					<%=vo.getPrice()%>
						));
					</script></td>
				</tr>
				<%
					}
				%>
				<%
					}
				%>
			</table>

			<%
				int in_total = 0;
				int out_total = 0;
				in_total = budget_dao.getTotal(club_id, "009001", year, month);
				out_total = budget_dao.getTotal(club_id, "009002", year, month);
			%>


			<table class="total-tbl" style="position:absolute; left:670px; top:0px; height: 125px;">
				<tr>
					<th colspan="2" style="width: 200px;">통 계</th>
				</tr>

				<tr>
					<th>수입</th>
					<td class="price"><script>
						document.write(addComma(
					<%=in_total%>
						));
					</script></td>
				</tr>
				<tr>
					<th>지출</th>
					<td class="price"><script>
						document.write(addComma(
					<%=out_total%>
						));
					</script></td>
				</tr>
				<tr>
					<th>총 합계</th>
					<td class="price" style="width: 120px;"><script>
						document.write(addComma(
					<%=in_total - out_total%>
					));
				</script></td>
				</tr>

			</table>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script>
	$('select[name=year]').on("change", function() {
		var value = $(this).val();
		$("select[name=month] option:eq(0)").prop("selected", true);
		
		/* var idx = $('select[name=year] option:first').val();
		if(value==idx){
			$("select[name=month] option:eq(0)").prop("selected", true);
		} */
	});
	
	</script>
</body>
</html>