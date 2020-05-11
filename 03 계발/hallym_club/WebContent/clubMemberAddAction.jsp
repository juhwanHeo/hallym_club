<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="club.ClubDAO"%>
<%@page import="user.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clubMember.ClubMemberDAO"%>
<%@page import="clubMember.ClubMemberVo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
		if (userId == null) {
			out.println("<script>");
			out.println("alert('로그인을 하세요.')");
			out.print("window.close();");
			out.println("</script>");
		} else if (!(userId.equals("20185280") || userId.equals("20185304") || userId.equals("20765"))) {
			out.println("<script>");
			out.println("alert('관리자 권환이 필요헙니다.')");
			out.print("window.close();");
			out.println("</script>");
		} else {
			String student_id = request.getParameter("student_id");
			int club_id = Integer.parseInt(request.getParameter("club_id"));
			String staff_cd = request.getParameter("staff");

			String write = request.getParameter("write");
			System.out.println("[clubMemberAddAction.jsp] student_id: " + student_id);
			System.out.println("[clubMemberAddAction.jsp] club_id: " + club_id);
			System.out.println("[clubMemberAddAction.jsp] write: " + write);
			System.out.println("[clubMemberAddAction.jsp] staff: " + staff_cd);
			UserDAO userDAO = new UserDAO();

			ClubMemberDAO clubMemberDAO = new ClubMemberDAO();

			UserVO joinUserVO = userDAO.getUser(student_id);

			String join_cd = clubMemberDAO.getJoin_cd(student_id, club_id);
			System.out.println("[clubMemberAddAction.jsp] join_cd: " + join_cd);

			System.out.println("[clubMemberAddAction.jsp] joinUserVO.getId(): " + joinUserVO.getId());

			if (joinUserVO.getId() == null) {
				out.print("<script>");
				out.println("alert('학번/사번 이 존재하지 않습니다.')");
				out.print("history.back();");
				out.print("</script>");
			} else if (write.equals("추가")) {

				if (join_cd.equals("")) {

					ClubMemberVo clubMemberVO = new ClubMemberVo();
					clubMemberVO.setCLUB_ID(club_id);
					clubMemberVO.setNM(joinUserVO.getName());
					clubMemberVO.setSTAFF_CD(staff_cd);
					clubMemberVO.setGRADE(joinUserVO.getGrade());
					clubMemberVO.setEMAIL(joinUserVO.getE_mail());
					clubMemberVO.setMAJOR(joinUserVO.getMajor());
					clubMemberVO.setSTUDENT_ID(joinUserVO.getId());
					clubMemberVO.setPHONE_NO(joinUserVO.getPhoneNumber());
					if (joinUserVO.getGender().equals("1")) {
						clubMemberVO.setGENDER_CD("003001");
					} else {
						clubMemberVO.setGENDER_CD("003002");
					}

					if (clubMemberDAO.joinMember(clubMemberVO) == -1) {
						out.print("<script>");
						out.println("alert('오류 발생')");
						out.print("history.back();");
						out.print("</script>");
					} else {
						out.print("<script>");
						out.println("alert('추가 되었습니다.')");
						out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
						out.print("</script>");

					}
				} else if (join_cd.equals("008003")) {
					if (clubMemberDAO.update(club_id, student_id, staff_cd) == -1) {

						out.print("<script>");
						out.println("alert('오류 발생')");
						out.print("history.back();");
						out.print("</script>");
					} else {
						out.print("<script>");
						out.println("alert('추가 되었습니다.')");
						out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
						out.print("</script>");

					}

				} else {
					out.println("<script>");
					out.println("alert('이미 가입완료된 사용자 입니다.')");
					out.print("history.back();");
					out.println("</script>");
				}

			}

			else if (write.equals("삭제")) {

				if (clubMemberDAO.getStaff_cd(club_id, student_id).equals("004001")) {
					out.print("<script>");
					out.println("alert('회장은 삭제할 수 없습니다.')");
					out.print("history.back();");
					out.print("</script>");
				} else {
					if (clubMemberDAO.delete(club_id, student_id, "2") == -1) {
						out.print("<script>");
						out.println("alert('오류 발생')");
						out.print("history.back();");
						out.print("</script>");
					} else {
						out.print("<script>");
						out.println("alert('삭제 완료')");
						out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
						out.print("</script>");
					}
				}

			} else {

			}
		}
	%>

</body>
</html>