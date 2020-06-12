package hallym.league.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;

public class CommonUtils {

	public static final String SAVE_PATH = "/home/league/files/upload";
	public static final String PREFIX_URL = "/home/league/files/upload/";
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	public static String getTimeBasePath() {
		String str = "/";
		
		Calendar calendar = Calendar.getInstance();
		str += calendar.get(Calendar.YEAR);
		str += "/";
		str += calendar.get(Calendar.MONTH);
		str += "/";
		str += calendar.get(Calendar.DATE);
//		str += calendar.get(Calendar.HOUR);
//		str += calendar.get(Calendar.MINUTE);
//		str += calendar.get(Calendar.SECOND);
//		str += calendar.get(Calendar.MILLISECOND);
//		str += "/";
		
		return str;
	}
	
	public static String getExtension(String fileName) {
		return FilenameUtils.getExtension(fileName);
//		return fileName.substring(fileName.lastIndexOf("."), fileName.length());
	}
	
	public static String getMD5(byte[] str) {
		String MD5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str);
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			MD5 = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			MD5 = null;
		}
		
		return MD5;
	}
	public static String getMD5(String str) {
		String MD5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			MD5 = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			MD5 = null;
		}
		
		return MD5;
	}

	public static String getSHA256(byte[] str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str);
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		
		return SHA;
	}
	public static String getSHA256(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		
		return SHA;
	}
	
	public static void showAlert(HttpServletResponse response, String msg) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("window.close();");
			out.println("</script>");
	        //out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void showAlert(HttpServletResponse response, String msg, String link) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("location.href='" + link + "';");
			out.println("window.close();");
			out.println("</script>");
	        out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
//	    System.out.println("> X-FORWARDED-FOR : " + ip);

	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
//	        System.out.println("> Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
//	        System.out.println(">  WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
//	        System.out.println("> HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
//	        System.out.println("> HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
//	        System.out.println("> getRemoteAddr : "+ip);
	    }
//	    System.out.println("> Result : IP Address : "+ip);

	    return ip;
	}
}
