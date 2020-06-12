<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
				<div class="info" style="width: auto; height: 200px;">
					<form method="post" action="/club.do" style="display: block;">
			
						<input style="width: auto; height: 40px;" type="radio" name="gbn" value="S" checked="checked">학부생
						<input style="width: auto; height: 40px;" type="radio" name="gbn" value="G">대학원생
						<input style="width: auto; height: 40px;" type="radio" name="gbn" value="O">교직원
						
						<div class="id">
							<input type="text" name="user_id" placeholder="학번을 입력하시오." required />
						</div>
						
						<div class="pwd">
							<input type="password" name="password" placeholder="비밀번호를 입력하시오." required />
						</div>
						
						<div class="ok">
							<input type="submit" value="LOGIN ">
						</div>
						

					</form>
				</div>
</body>
</html>