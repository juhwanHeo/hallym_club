<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 등록</title>

<style>

.manage-btn {
background: #3b5998; width:60px; height:35px; color:white; 
border:none; border-radius: 5px; cursor: pointer; font-size:13px;
float: right;
}

   table.type03 {
    border-collapse: collapse;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 5px solid #369;
    margin : 20px 3px;
    font-size: 140%;
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

<%request.setCharacterEncoding("UTF-8");%>


<jsp:useBean id="CV_dao" class="exam.jdbc.JDBC_clubDAO"/>

<h2>신규 동아리 등록</h2>
<form method="post" action="clubCreateAction.jsp" enctype="multipart/form-data" onsubmit="return check_form();">
	<table class="type03">
	
	<tr>
	<th>동아리명</th>
	<td style="color: #153d73; font-weight: bold;"><input type="text" id="club_nm" name="club_nm" style="font-size:20px; margin-right:30px;"> 
	<!-- 회원수
	 <input type="text" name="cnt" style="font-size:20px; text-align:right;" size="4" value="0">명</td> -->
	</tr>
	
	<tr>
	<th>구분</th>
	<td>
		<input type="radio" name="club_gb_cd" value="001001" checked="checked" /> 중앙동아리
		<input type="radio" name="club_gb_cd" value="001002"/> 과동아리
	</td>
	</tr>
	
	<tr>
	<th>분야</th>
    <td>
	    <input type="radio" name="club_at_cd" value="002001" checked="checked" /> 학술
		<input type="radio" name="club_at_cd" value="002002"/> 운동
		<input type="radio" name="club_at_cd" value="002003"/> 봉사
		<input type="radio" name="club_at_cd" value="002004"/> 문화
		<input type="radio" name="club_at_cd" value="002005"/> 종교
		<input type="radio" name="club_at_cd" value="002006"/> 기타
	</td>
	</tr>
		
	<tr>
	<th>목적</th>
	<td colspan="2" height="60px"><textarea style="width:99%; height:99%; resize: none" name="club_aim"></textarea></td>
	</tr>
	
	<tr>
	<th>활동</th>
	<td colspan="2" height="60px"><textarea style="width:99%; height:99%; resize: none" name="club_active"></textarea></td>
	</tr>
	
	<tr>
	<th>동아리 정보</th>
	<td style="text-align:left">
	개설년도<input type="text" name="open_dt" style="font-size:20px; margin-left:20px;" size="6" maxlength="8">
	동아리방<input type="text" name="club_room" style="font-size:20px; margin-left:20px;" >
	</td></tr>
	
	
	
	<tr>
	<th>프로필</th>
	<td><input type="file" name="file1"></td>
	</tr>
	
	<tr>
	<th>홍보 포스터</th>
	<td><input type="file" name="file2"></td>
	</tr>
	
	<tr>
	<th>회장</th>
	<td><input type="text" id="student_nm" name="student_id" style="font-size:20px"></td>
	</table>
	
	<input type="reset" value="취소" class="manage-btn" onclick="self.close();" style="margin-right:40px;">
	<input type="submit" value="등록" class="manage-btn" style="margin-right:10px;">
	
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
function check_form(){
	var ck_name = document.getElementById("club_nm").value;
	var ck_student = document.getElementById("student_nm").value;
	
	if (ck_name.trim() == ""){
		alert("동아리 이름을 입력해주세요");
		document.getElementById("club_nm").focus();
		return false;
	}
	
	if (ck_student.trim() == ""){
		alert("회장을 입력해주세요");
		document.getElementById("student_nm").focus();
		return false;
	}
}
</script>

</body>
</html>