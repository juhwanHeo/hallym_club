<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="club.ClubDAO"%>
<%@page import="club.ClubVO"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	/* 로그인 새션 없음, 권한 체크 없음  */
	request.setCharacterEncoding("UTF-8");
	ClubDAO clubDAO = new ClubDAO();
	ClubVO clubVO = new ClubVO();
	
	String directory = application.getRealPath("/upload/club/");
	int maxSize = 1024 * 1024 * 100;
	String encoding = "UTF-8";
	
	File upDir = new File(directory);
	if (!upDir.exists()) {
		upDir.mkdirs();
	}
	
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
			new DefaultFileRenamePolicy());
	
	int club_id = Integer.parseInt(multipartRequest.getParameter("club_id"));
	String submit = multipartRequest.getParameter("delete");
	System.out.println("[Photo] club_id: " +club_id);
	System.out.println("[Photo] submit: " +submit);
	Enumeration fileNames = multipartRequest.getFileNames();
	
	String parameter = (String) fileNames.nextElement();
	String fileName = multipartRequest.getOriginalFileName(parameter);
	String fileSaveName = multipartRequest.getFilesystemName(parameter);
	String fileName1 = fileName;
	
	if(submit == null) {
	// 포스터
		if (fileName != null) {
			if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".png") && !fileName.toLowerCase().endsWith(".gif")
					&& !fileName.endsWith(".bmp")) {
				File file = new File(directory + fileSaveName);
				file.delete();
				out.write("<script>");
				out.write("alert('업로드할 수 없는 확장자입니다.');");
				out.write("history.back();");
				out.write("</script>");
	
			} 
			else {
				System.out.println("[file1] fileName: " + fileName);
				System.out.println("[file1] fileSaveName: " + fileSaveName);
				clubVO.setPoster_file_nm(fileName);
				clubVO.setPoster_save_file_nm(fileSaveName);
			}
		}
		
		
		
		parameter = (String) fileNames.nextElement();
		fileName = multipartRequest.getOriginalFileName(parameter);
		fileSaveName = multipartRequest.getFilesystemName(parameter);
		String fileName2 = fileName;
		// 프로필
		if (fileName != null) {
			if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".png") && !fileName.toLowerCase().endsWith(".gif")
					&& !fileName.endsWith(".bmp")) {
				File file = new File(directory + fileSaveName);
				file.delete();
				out.write("<script>");
				out.write("alert('업로드할 수 없는 확장자입니다.');");
				out.write("history.back();");
				out.write("</script>");
	
			} 
			else {
				System.out.println("[file2] fileName: " + fileName);
				System.out.println("[file2] fileSaveName: " + fileSaveName);
				clubVO.setIntro_file_nm(fileName);
				clubVO.setIntro_save_file_nm(fileSaveName);
	
			}
			
		}
		
		int error_cd = 0;
		if(fileName1 != null){
			if(clubDAO.setPosterName(club_id, clubVO) == -1) {
				error_cd +=1;
			}
		}
		
		if(fileName2 != null) {
			if(clubDAO.setIntroName(club_id, clubVO) == -1) {
				error_cd +=1;
			}
		}
		
		
		if(fileName1 == null && fileName2 == null) {
			out.print("<script>");
			out.println("alert('사진을 넣어 주세요!!')");
			out.print("history.back();");
			out.print("</script>");
		} else if(error_cd == 0) {
			out.print("<script>");
			out.println("alert('정상 처리 되었습니다.')");
			out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
			out.print("</script>");
		} else if(error_cd != 0){
			out.print("<script>");
			out.println("alert('오류 발생')");
			out.print("history.back();");
			out.print("</script>");
		}
	}
	
	else {
		if(submit.equals("프로필 삭제")){
			System.out.println("[photo] 프로필 삭제");
			if(clubDAO.setIntroNameNull(club_id) != -1){
				out.print("<script>");
				out.println("alert('프로필을 삭제 했습니다..')");
				out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
				out.print("</script>");
			} else {
				out.print("<script>");
				out.println("alert('프로필 오류 발생')");
				out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
				out.print("</script>");
			}
		}
		else if(submit.equals("포스터 삭제")) {
			System.out.println("[photo] 포스터 삭제");
			if(clubDAO.setPosterNameNull(club_id) != -1){
				out.print("<script>");
				out.println("alert('포스터를 삭제 했습니다..')");
				out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
				out.print("</script>");
			} else {
				out.print("<script>");
				out.println("alert('프로필 오류 발생')");
				out.println("location.href='club_info.jsp?club_id=" + club_id + "'");
				out.print("</script>");
			}
		}
	}
	
%>
</body>
</html>