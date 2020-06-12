package hallym.league.user.dao;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.league.user.vo.UserVO;


@Mapper("userDAO")
public interface UserDAO {
	public String checkLogin(Map<String, Object> params);
	public UserVO getUserVO(Map<String, Object> params);
}
