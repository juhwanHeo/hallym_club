package hallym.league.user.web;

import javax.annotation.Resource;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import hallym.league.user.service.UserService;
import hallym.league.user.vo.UserVO;
import hallym.league.utils.CommonUtils;

@Controller
public class UserController {
	
	@Resource(name = "userService")
	private UserService userService;

	
	//0. 로그인 화면
	@RequestMapping(value = "/loginView.do")
	public ModelAndView ViewLogin(HttpServletRequest request,
								  ModelAndView mav){
		mav.setViewName("hallym/BoardListForm");
		return mav;
	}
	
	
	@RequestMapping(value="/login.do", method = RequestMethod.GET)
	public ModelAndView loginFormSetUp(HttpServletRequest request, HttpServletResponse response,
			  ModelAndView mav)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(userVO == null || userVO.getId().isEmpty()) {
			mav.setViewName("hallym/Login");
		} else {
			CommonUtils.showAlert(response, "이미 로그인이 되어있습니다.");
			mav.setViewName("hallym/index");
		}
		return mav;
	}
	
	
	//0. 로그인 확인
	@RequestMapping(value="/login.do",  method=RequestMethod.POST)
	public String loginAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "gbn", required = false) String GBN,
							 @RequestParam(value = "user_id", required = false) String ID,
							 @RequestParam(value = "password", required = false) String PASSWORD,
							 @RequestParam(value = "chk_id", required = false) String chk_id){
		
		HttpSession session = request.getSession();
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("GBN", GBN);
		params.put("ID", ID);
		params.put("PASSWORD", PASSWORD);
		
		// 사용자 로그인 체크
		String result = userService.checkLogin(session, params);
		Cookie cookie = null;
		if(chk_id != null && !chk_id.isEmpty() && chk_id.equalsIgnoreCase("Y")) {
			cookie = new Cookie("ID", ID);
			cookie.setMaxAge(60*60*24*7); /* 7 days */
			response.addCookie(cookie);
			
			cookie = new Cookie("GBN", GBN);
			cookie.setMaxAge(60*60*24*7); /* 7 days */
			response.addCookie(cookie);
		} else {
			cookie = new Cookie("ID", null);
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			
			cookie = new Cookie("GBN", null);
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		
		if(result.equalsIgnoreCase("F")) {
			result = "redirect:login.do";
			CommonUtils.showAlert(response, "아이디 또는 비밀번호가 올바르지 않습니다.");
		} else if(result.equalsIgnoreCase("E")) {
			result = "redirect:login.do";
			CommonUtils.showAlert(response, "알 수 없는 오류가 발생했습니다.");
		} else {
			System.out.println("IP : " + CommonUtils.getClientIP(request));
			System.out.println("[UserController][login.do] (session) userVO: "+ (UserVO) session.getAttribute("userVO"));
		}
		
		return result;
	}
	
	@RequestMapping(value="/logout.do")
	public ModelAndView logoutAction(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav) throws Exception {
		
		HttpSession session = request.getSession();
		session.invalidate();

		mav.setViewName("hallym/Login");
		
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.')");
		out.println("location.href='index.do'");
		out.println("window.close();");
		out.println("</script>");
        out.flush();

		return mav;
	}
	
	@RequestMapping(value="/profile.do")
	public ModelAndView myPageFormSetUp(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav) throws Exception {
		
		HttpSession session = request.getSession();
		session.invalidate();

		mav.setViewName("hallym/Login");
		
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('준비중입니다.')");
		//out.println("location.href='index.do'");
		out.println("history.go(-1);");
		out.println("window.close();");
		out.println("</script>");
        out.flush();

		return mav;
	}
	
}