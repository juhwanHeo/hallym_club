package hallym.league.user.service.impl;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import hallym.league.user.service.UserService;
import hallym.league.user.dao.UserDAO;
import hallym.league.user.vo.UserVO;
import hallym.league.utils.CommonUtils;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource(name="userDAO")
	private UserDAO userDAO;

	
	@Override
	public String checkLogin(HttpSession session, Map<String, Object> params) {
		System.out.println("[UserServiceImpl] checkLogin");
		System.out.println("GBN : " + params.get("GBN"));
		System.out.println("ID : " + params.get("ID"));
		System.out.println("PASSWORD : " + new String(new char[params.get("PASSWORD").toString().length()]).replace("\0", "*"));
		
		String result = null;
		String requestLogin = userDAO.checkLogin(params); //로그인
		
		if(requestLogin.equalsIgnoreCase("true")) { //로그인 성공
			UserVO userVO = this.getUserVO(params);
			session.setAttribute("userVO", userVO);
			
//			System.out.println("[UserServiceImpl]userVO: "+ userVO);
//			System.out.println("[UserServiceImpl](session) userVO: "+ (UserVO) session.getAttribute("userVO"));
			
			result = "redirect:index.do";
		}
		else if(requestLogin.equalsIgnoreCase("false")) { //로그인 실패
			result = "F";
		}
		else { //로그인 DB에서 오류 발생
			result = "E";
		}
		return result;
	}

	@Override
	public UserVO getUserVO(Map<String, Object> params) {
		return userDAO.getUserVO(params);
	}	
		
}
