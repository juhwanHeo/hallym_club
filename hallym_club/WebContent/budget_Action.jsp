<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@page import="budget.BudgetVO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%request.setCharacterEncoding("UTF-8");%>

	<jsp:useBean id="budget_dao" class="budget.BudgetDAO" />

	<%  
		ArrayList<BudgetVO> vo_list = null ;
    	String use_dt[] = request.getParameterValues("use_dt");
   	 	String contents[] = request.getParameterValues("contents");
    	String price[] = request.getParameterValues("price");
     	
    	int club_id =   Integer.parseInt(request.getParameter("club_id"));
    	String io_gb_cd = request.getParameter("hidden_io_gb_cd");
    	
    	
    	vo_list = new ArrayList<BudgetVO>();
    	
 		for(int i=0; i<use_dt.length;i++){
 			
 			BudgetVO vo = new BudgetVO();
 			if(use_dt[i] == ""){
 				break;
 			}
 			use_dt[i] = use_dt[i].replaceAll("\\-", ""); 
 			vo.setUse_dt(use_dt[i]);
 			int tmp_price = Integer.parseInt(price[i].replaceAll("\\,", ""));
 			vo.setPrice(tmp_price);
 			
 			vo.setContents(contents[i]);
 		

 			vo_list.add(vo);
			
 		}

    %>


	<%	    

    int result = budget_dao.writeBudget(vo_list,club_id,io_gb_cd);
	
	String url = "club_budget.jsp?club_id=" + club_id + "&io_gb_cd=" + io_gb_cd;
	
    if (result == -1) {
    	out.print("<script>");
        out.print("alert('저장에 실패했습니다.');");  
        out.print("history.back();");          
        out.print("</script>");     
        } else {
        	out.print("<script>");
            out.print("alert('저장되었습니다.');"); 
            out.print("window.location.href='" + url +"';");
            out.print("</script>");
     }
 %>
</body>
</html>