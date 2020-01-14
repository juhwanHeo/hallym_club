<%@page import="exam.jdbc.JDBC_clubDAO"%>
<%@page import="exam.jdbc.ClubVO"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
		request.setCharacterEncoding("UTF-8");

		String directory = application.getRealPath("/upload/club/");
		// String directory = application.getRealPath("C:/JSP/upload/"); 보안코딩 
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";

 		File upDir = new File(directory);
		if (!upDir.exists()) {
			upDir.mkdirs();
		} 

		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());

		ClubVO CV = new ClubVO();
		CV.setClub_nm(multipartRequest.getParameter("club_nm"));
		CV.setClub_gb_cd(multipartRequest.getParameter("club_gb_cd"));
		CV.setClub_at_cd(multipartRequest.getParameter("club_at_cd"));
		CV.setCnt(1);
		CV.setClub_aim(multipartRequest.getParameter("club_aim"));
		CV.setClub_active(multipartRequest.getParameter("club_active"));
		CV.setClub_room(multipartRequest.getParameter("club_room"));
		CV.setOpen_dt(multipartRequest.getParameter("open_dt"));
		String student_id = multipartRequest.getParameter("student_id");

		// 다중 업로드
		Enumeration fileNames = multipartRequest.getFileNames();

		String parameter = (String) fileNames.nextElement();
		String fileName = multipartRequest.getOriginalFileName(parameter);
		String fileSaveName = multipartRequest.getFilesystemName(parameter);

		if (fileName == null) {
			CV.setPoster_file_nm(fileName);
			CV.setPoster_save_file_nm(fileSaveName);
		} else {
			if (!fileName.endsWith(".jpg") && !fileName.endsWith(".png") && !fileName.endsWith(".gif")
					&& !fileName.endsWith(".bmp")) {
				File file = new File(directory + fileSaveName);
				file.delete();
				out.write("<script>");
				out.write("alert('업로드할 수 없는 확장자입니다.');");
				out.write("history.back();");
				out.write("</script>");
			} else {
				CV.setPoster_file_nm(fileName);
				CV.setPoster_save_file_nm(fileSaveName);
			}
		}

		parameter = (String) fileNames.nextElement();
		fileName = multipartRequest.getOriginalFileName(parameter);
		fileSaveName = multipartRequest.getFilesystemName(parameter);

		if (fileName == null) {
			CV.setIntro_file_nm(fileName);
			CV.setIntro_save_file_nm(fileSaveName);
		} else {
			if (!fileName.endsWith(".jpg") && !fileName.endsWith(".png") && !fileName.endsWith(".gif")
					&& !fileName.endsWith(".bmp")) {
				File file = new File(directory + fileSaveName);
				file.delete();
				out.write("<script>");
				out.write("alert('업로드할 수 없는 확장자입니다.');");
				out.write("history.back();");
				out.write("</script>");
			} else {
				CV.setIntro_file_nm(fileName);
				CV.setIntro_save_file_nm(fileSaveName);
			}
		}

		int result = new JDBC_clubDAO().createClub(CV, student_id);
		if (result == -1) {
			out.print("<script>");
			out.print("alert('등록이 정상적으로 완료되지 않았습니다.');");
			out.print("history.back();");
			out.print("</script>");
		} else {
			out.print("<script>");
			out.print("alert('등록을 완료했습니다.');");
			out.print("window.close();");
			out.print("</script>");
		}
	%>

</body>
</html>