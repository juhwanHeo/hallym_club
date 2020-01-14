<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="item.itemVo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>

<body>

	<jsp:useBean id="itemDAO" class="item.itemDAO" />

	<%
		request.setCharacterEncoding("UTF-8");

		String club_id = request.getParameter("club_id");
		String club_name = itemDAO.getClubNMs(Integer.parseInt(club_id));

		String[] Item_nm = request.getParameterValues("Item_nm");
		String[] Tot_cnt = request.getParameterValues("Tot_cnt");
		String[] Item_cont = request.getParameterValues("Item_cont");
		
		int result=-1;
		
		if (Item_nm == null) {
			 result = itemDAO.resetItme(Integer.parseInt(club_id));
		} else {
			ArrayList<itemVo> list = new ArrayList<itemVo>();

			for (int i = 0; i < Item_nm.length; i++) {
				if (!(Item_nm[i].equals("") || Tot_cnt[i].equals("") || Item_cont[i].equals(""))) {
					itemVo iV = new itemVo(Integer.parseInt(Tot_cnt[i]), Item_nm[i], Item_cont[i]);
					list.add(iV);
				}

			}
			result = itemDAO.modItme(Integer.parseInt(club_id), list);
		}
		
		if (result == -1) {
			out.print("<script>");
			out.print("alert('오류.');");
			out.print("history.back();");
			out.print("</script>");
		} else {
			out.print("<script>");
			out.print("alert('완료되었습니다.');");
			out.print("location.href='club_item.jsp?club_id='+'" + club_id + "'");

			out.print("</script>");
		}

		/* int totalElements = list.size();// arrayList의 요소의 갯수를 구한다.
		System.out.println(totalElements);
		for (int index = 0; index < totalElements; index++) {
			out.println(list.get(index).getITEM_NM());
		} */
	%>

</body>


</html>






