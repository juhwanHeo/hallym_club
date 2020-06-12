package hallym.league.user.service;

import java.util.Map;
import javax.servlet.http.HttpSession;

import hallym.league.user.vo.UserVO;

public interface UserService {

	String checkLogin(HttpSession session, Map<String, Object> params);
	UserVO getUserVO(Map<String, Object> params);
}
