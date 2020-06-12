package hallym.league.common.web;

import javax.annotation.Resource;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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

import hallym.league.board.service.BoardService;
import hallym.league.board.vo.BoardVO;
import hallym.league.user.service.UserService;
import hallym.league.user.vo.UserVO;
import hallym.league.utils.CommonUtils;

@Controller
public class CommonController {
	
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "boardService")
	private BoardService boardService;
	
	
	@RequestMapping(value = "/index.do")
	public ModelAndView IndexFormSetup(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav)
	{
		
		HttpSession session = request.getSession();
		List<BoardVO> boardList = null;
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("available", 1);
		params.put("board_cd", "007101");
		params.put("opt", 0);
		params.put("opt2", 0);
		params.put("startNum", 1);
		params.put("endNum", 6);
		boardList = boardService.getBoardList(params);
		
		mav.addObject("boardList", boardList);
		mav.setViewName("hallym/index");
		return mav;
	}
	
}