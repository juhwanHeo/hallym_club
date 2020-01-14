<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@page import="clubMember.clubMemberDAO"%>
<%@page import="clubMember.clubMemberVo"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 관리</title>
<style>
	table.type03 {
    border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 5px solid #369;
	margin : 5px 3px;
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
		

    .button {
    width:80px;
    background-color: #046BB9;
    border: none;
    color:#fff;
    padding: 5px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    border-radius:10px;
    cursor: pointer;
	}   
    
    ul{
    padding-left:10px;
    }
   	ul li{
   	display:inline;
   	font-size:20px;  
   	margin-right:100px;
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
	
	String student_id = "";
	int club_id;
	
	student_id = request.getParameter("update");
	club_id = Integer.parseInt(request.getParameter("join_club"));

%>	

	<jsp:useBean id="member_dao" class="clubMember.clubMemberDAO" />
		<%
			ArrayList<clubMemberVo> member_list = member_dao.getMemberInfo(club_id,student_id);
		%>	
	
	<ul>
		<form method="post" action="staff_update.jsp" >
			<input type="hidden" name="user_name" value=<%=username %>>
			<input type="hidden" name="club_id" value=<%=club_id %>>
			<input type="hidden" name="student_id" value=<%=member_list.get(0).getSTUDENT_ID() %>>
			<li> <%= member_list.get(0).getNM()%> (<%= member_list.get(0).getSTUDENT_ID()%>)</li>
			<li style="float:right;">직책&nbsp;
			<select id="staff" name="staff" style="font-size:20px" onchange="staff_change(this.form);"> 
				<option value="004004" <%if (member_list.get(0).getSTAFF_CD().equals("회원"))
					out.println("selected");%>>회원</option>
				<option value="004001" <%if (member_list.get(0).getSTAFF_CD().equals("회장"))
					out.println("selected");%>>회장</option>
				<option value="004002" <%if (member_list.get(0).getSTAFF_CD().equals("부회장"))
					out.println("selected");%>>부회장</option>
				<option value="004003" <%if (member_list.get(0).getSTAFF_CD().equals("총무"))
					out.println("selected");%>>총무</option>
			</select>
			<%if (username.equals("admin")) { %>
				<input class="button" type="submit" name="btn" value="회장등록"  style="margin-left:50px;"/></li>
			
			<% }
			else if(member_dao.getMemberInfo(club_id, username).get(0).getSTAFF_CD().equals("회장")) { %>
			<input class="button" type="submit" name="btn" value="회장위임"  style="margin-left:50px;"/></li>
			<%} %>
			</form>
	
	</ul>
	
		<table class="type03">
    <tr>
        <th rowspan="6" width="20%"><br><br><br>인 적<br>사 항</th>
        <td width="20%">학과<font>*</font></td>
        <td width="20%"><input type="text"  name="MAJOR" id="MAJOR" readonly="readonly" value=<%= member_list.get(0).getMAJOR()%>  ></td> 
        <td width="20%">학년<font>*</font></td>
        <td width="20%"><input type="text"  name="GRADE" id="GRADE" readonly="readonly" value=<%= member_list.get(0).getGRADE() %> ></td>
    </tr>
    <tr>
        <td>학번<font>*</font></td>
        <td><input type="text" name="STUDENT_ID" readonly="readonly" value=<%= member_list.get(0).getSTUDENT_ID()%>></td>
       
        <td>성명<font>*</font></td>
        <td><input type="text" style="width:62%" name="NM" id="NM" readonly="readonly" value=<%= member_list.get(0).getNM()%>  >
       <% if (member_list.get(0).getGENDER_CD().equals("003001")) {
       		out.println("남성");
       }else{
    	   out.println("여성");
       }
       %> 

        </td>
    </tr>
    <tr>
        <td>생년월일</td>
        <td colspan="3"><input type="text" style="width:99%" name="BIRTH_DT" id="BIRTH_DT" readonly="readonly" value=<%= member_list.get(0).getBIRTH_DT()%> ></td>    
    </tr>
    <tr>
        <td>전화번호<font>*</font></td>
        <td colspan="3"><input type="text" style="width:99%" name="PHONE_NO" id="PHONE_NO" readonly="readonly" value=<%= member_list.get(0).getPHONE_NO()%> ></td>    
    </tr>
    <tr>
        <td>주소</td>
        <td colspan="3"><input type="text" style="width:99%" name="ADDRESS" readonly="readonly" value=<%= member_list.get(0).getADDRESS()%> ></td> 
    </tr>
    <tr>
        <td>E-mail</td>
        <td colspan="3"><input type="text" style="width:99%" name="EMAIL" readonly="readonly" value=<%= member_list.get(0).getEMAIL()%> ></td> 
    </tr>
    
    <tr>
       <th><br>차      후<br>활동계획</th>
        <td colspan="4" height="100px"><textarea style="width:99%; height:99%; resize: none" name="plan" readonly="readonly"><%= member_list.get(0).getPlan()%> </textarea></td> 
    </tr>
    
    <tr>
       <th><br>바라는 점</th>
        <td colspan="4" height="80px"><textarea style="width:99%; height:99%; resize: none" name="hope" readonly="readonly"><%= member_list.get(0).getHope()%></textarea></td> 
    </tr>

	</table>

	<script>
	function staff_change(e){
		var name = document.getElementById("NM").value;
		var staff = document.getElementById("staff").value;
		
		if (staff == "004001") 
			staff = "회장";
		else if (staff == "004002") 
			staff = "부회장";
		else if (staff == "004003") 
			staff = "총무";
		else 
			staff = "회원";
		
		if (confirm(name+"을(를) " + staff +"(으)로 변경 하시겠습니까?") == true){    //확인
			e.submit();
			
		}else{   //취소
		    return;
		}
	}
	
	</script>
</body>
</html>