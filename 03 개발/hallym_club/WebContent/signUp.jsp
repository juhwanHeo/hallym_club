<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style rel="stylesheet">

.form {
	z-index: 15;
	position: relative;
	background: #FFFFFF;
	width: 600px;
	border-radius: 4px;
	box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
	box-sizing: border-box;
	overflow: hidden;
}

.form-toggle {
	z-index: 10;
	position: absolute;
	top: 60px;
	right: 60px;
	background: #FFFFFF;
	width: 60px;
	height: 60px;
	border-radius: 100%;
	-webkit-transform-origin: center;
	-ms-transform-origin: center;
	transform-origin: center;
	-webkit-transform: translate(0, -25%) scale(0);
	-ms-transform: translate(0, -25%) scale(0);
	transform: translate(0, -25%) scale(0);
	opacity: 0;
	cursor: pointer;
	-webkit-transition: all 0.3s ease;
	transition: all 0.3s ease;
}

.form-group {
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-flex-wrap: wrap;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	-webkit-box-pack: justify;
	-webkit-justify-content: space-between;
	-ms-flex-pack: justify;
	justify-content: space-between;
	margin: 0 0 20px;
}

.form-group label {
	display: block;
	margin: 0 0 10px;
	color: rgba(0, 0, 0, 0.6);
	font-size: 12px;
	font-weight: 500;
	line-height: 1;
	text-transform: uppercase;
	letter-spacing: .2em;
}

.form-group input {
	outline: none;
	display: block;
	background: rgba(0, 0, 0, 0.1);
	width: 100%;
	border: 0;
	border-radius: 4px;
	box-sizing: border-box;
	padding: 12px 20px;
	color: rgba(0, 0, 0, 0.6);
	font-family: inherit;
	font-size: inherit;
	font-weight: 500;
	line-height: inherit;
	-webkit-transition: 0.3s ease;
	transition: 0.3s ease;
}


.form-group button {
	outline: none;
	background: #4285F4;
	width: 100%;
	border: 0;
	border-radius: 4px;
	padding: 12px 20px;
	color: #FFFFFF;
	font-family: inherit;
	font-size: inherit;
	font-weight: 500;
	line-height: inherit;
	text-transform: uppercase;
	cursor: pointer;
}

.form-panel {
	padding: 60px calc(5% + 60px) 60px 60px;
	box-sizing: border-box;
}


#btn {
	position: absolute;
	top: 30%;
	right: 14%;
	width: 100px;
	background-color: #f8585b;
	border: none;
	color: #fff;
	padding: 15px 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px;
	cursor: pointer;
	border-radius: 10px;
}
</style>
</head>
<body onresize="parent.resizeTo(630,620)"
	onload="parent.resizeTo(630,620)">


	<!-- Form-->
	<div class="form">
		<div class="form-toggle"></div>
		<div class="form-panel one">
			<div class="form-header">
				<h1>회원 가입</h1>
			</div>
			<div class="form-content">
				<form id="login-form" method="post" action="signUpAction.jsp">

					<input type="button" id="btn" name="btn1" value="중복 검사" onclick="confirmId()">
					<div class="form-group">
						<label for="username">ID(학번)</label> <input type="text" id="username" name="username" required="required" />
					</div>
					<div class="form-group">
						<label for="password">비밀번호</label> <input type="password" id="password" name="password" required="required" />
					</div>
					<div class="form-group">
						<label for="cpassword">비밀번호 확인</label> <input type="password" id="cpassword" name="cpassword" required="required" />
					</div>
					<div class="form-group">
          				<button type="submit" id="btn_submit">Register</button>
        			</div>
				</form>

			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script type="text/javascript">
	var result = false;
	var chk = false;
	function confirmId(){
		var username = document.getElementById("username").value;
		
		if(username.trim() == ""){
			alert("아이디를 입력해주세요");
			result = false;
			return false;
		}
		url = "confirmId.jsp?username="+username;
		open(url,"중복 검사","width=400,height=150,resizable=yes,top=300,left=400, scrollbars = no");
		result = true;
	}
	
	$("#username").on("change paste keyup", function() { 
		   result = false;
		});
	
	
	$("#btn_submit").click(function(e) {
		var username = $("#username");
		var password = $("#password");
		var cpassword = $("#cpassword");

		if (username.val().trim() == ""){
			alert("아이디를 입력해주세요");
			username.focus();
			e.preventDefault();
			return false;
		}
		
		if (result == false){
			alert("ID 중복검사를 해주세요");
			e.preventDefault();
			return false;
		}
		
		if (username.val().trim() == ""){
			alert("아이디를 입력해주세요");
			username.focus();
			e.preventDefault();
			return false;
		}
		
		if (password.val().trim() == ""){
			alert("비밀번호를 입력해주세요");
			password.focus();
			e.preventDefault();
			return false;
		}
		
		if (password.val() != cpassword.val()){
			alert("비밀번호를 확인해주세요");
			cpassword.focus();
			e.preventDefault();
			return false;
		}
		
		e.preventDefault();
		$('#login-form')[0].submit();
	});
	

</script>
</body>
</html>