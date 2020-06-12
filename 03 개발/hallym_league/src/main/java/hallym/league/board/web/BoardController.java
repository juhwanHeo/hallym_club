package hallym.league.board.web;

import javax.annotation.Resource;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import hallym.league.board.service.BoardService;
import hallym.league.board.vo.BoardVO;
import hallym.league.file.service.FileService;
import hallym.league.file.vo.FileVO;
import hallym.league.user.service.UserService;
import hallym.league.user.vo.UserVO;
import hallym.league.utils.CommonUtils;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService service;
	
	@Resource(name = "userService")
	private UserService service3;
	
	@Resource(name = "fileService")
	private FileService service2;
	
	// 게시판 리스트 검색
	@RequestMapping(value = "/BoardSearch.do")
	public ModelAndView BoardSearch(HttpServletRequest request, ModelAndView mav,
									@RequestParam(value = "bdc", required = false) String bdc,
									@RequestParam(value = "page", required = false, defaultValue = "1") String page,
									@RequestParam(value = "o1", required = false, defaultValue = "0") String o1,
									@RequestParam(value = "o2", required = false, defaultValue = "0") String o2,
									@RequestParam(value = "cdn", required = false, defaultValue = "") String cdn)
	{
		HttpSession session = request.getSession();
		List<BoardVO> boardList = null;
		int available = 1;
		String board_cd = null;
		if(bdc != null) {
			board_cd = bdc;
			session.setAttribute("board_cd", board_cd);
		}
		board_cd = (String) session.getAttribute("board_cd");
		int opt = Integer.parseInt(o1);
		int opt2 = Integer.parseInt(o2);
		String condition = cdn;
		
		int boardListCount = 1;
		int limit = 5;
		int currPage = Integer.parseInt(page);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("available", available);
		params.put("board_cd", board_cd);
		params.put("opt", opt);
		params.put("opt2", opt2);
		params.put("condition", condition);
		params.put("limit", limit);
		
		boardListCount = service.getBoardListCnt(params);
		totalPage = service.getTotalPageCnt(params);
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (boardListCount < limit) ? boardListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (boardListCount > endNum) ? (currPage+1):currPage;
		}
		
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		boardList = service.getBoardList(params);
		
		mav.addObject("board_cd", board_cd);
		mav.addObject("opt", opt);
		mav.addObject("opt2", opt2);
		mav.addObject("condition", condition);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("boardList", boardList);
		mav.addObject("boardListCount", boardListCount);
		mav.setViewName("hallym/BoardListForm");
		return mav;
	}
	
	// 게시판 글쓰기
	@RequestMapping(value = "/BoardWriteForm.do")
	public ModelAndView BoardWriteForm(ModelAndView mav)
	{
		mav.setViewName("hallym/BoardWriteForm");
		return mav;
	}
	
	// 게시판 글수정
	@RequestMapping(value = "/BoardUpdateForm.do")
	public ModelAndView BoardUpdateForm(ModelAndView mav,
			  							HttpServletRequest request,
			  							@RequestParam(value = "num", required = false) int seq_no)
	{
		HttpSession session = request.getSession();
		String board_cd = (String) session.getAttribute("board_cd");
		session.setAttribute("seq_no", seq_no);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("seq_no", seq_no);
		
		BoardVO searchBoard =  service.getBoard(params);
		service.increaseOpenCnt(params);
		
		mav.addObject("searchBoard", searchBoard);
		mav.setViewName("hallym/BoardUpdateForm");
		return mav;
	}
	
	// 게시판 삭제
	@RequestMapping(value = "/BoardDeleteForm.do")
	public String BoardDeleteForm(HttpServletRequest request, HttpServletResponse response,
									@RequestParam(value = "num", required = false) int seq_no)
	{
		response.setContentType("text/html; charset=UTF-8");
        String redrt = "redirect:BoardSearch.do";
        
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(userVO == null || userVO.getId().isEmpty()) {
			redrt = "redirect:login.do";
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.");
		} else {
			String board_cd = (String) session.getAttribute("board_cd");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("board_cd", board_cd);
			params.put("seq_no", seq_no);
			
			service.deleteBoard(params);
			
			
			params.put("opt", 2);
			int fileListCnt = service2.getFileListCnt(params);
			if(fileListCnt > 0) {
				List<FileVO> fileList = service2.getFileList(params);
				
				for(FileVO fileVO : fileList) {
					File del = new File(fileVO.getFILE_PATH());
					if(del.exists() && !del.isDirectory()) {
						del.delete();
					}
				}
				
				service2.deleteFile(params);
			}

			CommonUtils.showAlert(response, "정상적으로 삭제하였습니다.");
		}
		return redrt;
	}
	
	// 게시판 보기
	@RequestMapping(value = "/BoardReadForm.do")
	public ModelAndView BoardReadForm(ModelAndView mav,
									  HttpServletRequest request, HttpServletResponse response,
									  @RequestParam(value = "num", required = false) int seq_no)
	{
		response.setContentType("text/html; charset=UTF-8");
        String redrt = "BoardReadForm";
        
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(userVO == null || userVO.getId().isEmpty()) {
			redrt = "Login";
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.");
		} else {
			String board_cd = (String) session.getAttribute("board_cd");
			session.setAttribute("seq_no", seq_no);
	
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("board_cd", board_cd);
			params.put("seq_no", seq_no);
			
			BoardVO searchBoard =  service.getBoard(params);
			service.increaseOpenCnt(params);
			
			params.put("seq_no", seq_no-1);
			BoardVO prevBoard = service.getBoard(params);
			
			params.put("seq_no", seq_no+1);
			BoardVO nextBoard = service.getBoard(params);
			
			params.put("seq_no", seq_no);
			params.put("opt", 2);
			List<FileVO> fileList = null;
			int fileListCnt = service2.getFileListCnt(params);
			if(fileListCnt > 0) {
				fileList = service2.getFileList(params);
			}
			
			mav.addObject("fileList", fileList);
			mav.addObject("fileListCnt", fileListCnt);
			mav.addObject("prevBoard", prevBoard);
			mav.addObject("nextBoard", nextBoard);
			mav.addObject("searchBoard", searchBoard);
		}
		mav.setViewName("hallym/" + redrt);
		return mav;
	}
	
	// 게시판 수정
	@RequestMapping(value = "/BoardUpdateAction.do")
	public String BoardUpdateAction(HttpServletRequest request, HttpServletResponse response,
									@RequestParam(value = "title",  required = false) String title,
									@RequestParam(value = "contents", required = false) String contents,
									@RequestParam(value = "writer", required = false) String writer,
									@RequestParam(value = "fix_yn", required = false) String fix_yn,
									@RequestParam(value = "start_date", required = false) String start_date,
									@RequestParam(value = "end_date", required = false) String end_date)
	{
		response.setContentType("text/html; charset=UTF-8");
        String redrt = "redirect:BoardSearch.do";
        
		HttpSession session = request.getSession();
		String board_cd = (String) session.getAttribute("board_cd");
		int seq_no = (int) session.getAttribute("seq_no");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(userVO == null || userVO.getId().isEmpty()) {
			redrt = "redirect:login.do";
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.");
		} else {
			Date dt = new java.util.Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String today = sdf.format(dt);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("board_cd", board_cd);
			params.put("seq_no", seq_no);
			params.put("opt", 2);
			int cnt = service2.getFileListCnt(params);
			params.put("opt", 0);
			params.put("title", title);
			params.put("contents", contents);
			params.put("fix_yn", (fix_yn == null)?"N":fix_yn); //체크박스 선택 안하면 null이 넘어옴
			params.put("attach_yn", (cnt > 0)?"Y":"N");
			params.put("start_date", today);
			params.put("end_date", today);
			params.put("update_id", (writer.isEmpty())?userVO.getId():writer);
			params.put("update_ip", CommonUtils.getClientIP(request));
			service.updateBoard(params);
			
			redrt = "redirect:BoardReadForm.do?&num=" + seq_no;
			CommonUtils.showAlert(response, "정상적으로 수정되었습니다.");
		}
		return redrt;
	}
	
	// 게시판 글 추가하기
	@RequestMapping(value = "/BoardWriteAction.do")
	public String BoardWriteAction(MultipartHttpServletRequest request,
								   HttpServletResponse response,
								   @RequestParam(value = "title",  required = false) String title,
							       @RequestParam(value = "contents", required = false) String contents,
								   @RequestParam(value = "writer", required = false, defaultValue = "") String writer,
							       @RequestParam(value = "fix_yn", required = false) String fix_yn)
	{	
		response.setContentType("text/html; charset=UTF-8");
        String redrt = "redirect:BoardSearch.do";
        
		HttpSession session = request.getSession();
		String board_cd = (String) session.getAttribute("board_cd");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		try {
			if(userVO == null || userVO.getId().isEmpty()) {
				redrt = "redirect:login.do";
				CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.");
			} else {
				/* 업로드할 폴더 체크 */
				String path = CommonUtils.SAVE_PATH + CommonUtils.getTimeBasePath();
				File dir = new File(path);
		        if (!dir.isDirectory()) { // 폴더가 없다면 생성
		            dir.mkdirs(); // 폴더 생성
		        }
		        
		        List<FileVO> recentFiles = new ArrayList<FileVO>();
		        BoardVO recentBoard = null;
		        // 넘어온 파일을 리스트로 저장
				List<MultipartFile> mpList = request.getFiles("attachFile"); // attachFile로 넘어온 파일을 가져옴
				if(mpList.size() < 1 || mpList.isEmpty()) {
					// 업로드할 파일 없음
				} else {
					for(MultipartFile multipartFile : mpList) {
						if(multipartFile.getOriginalFilename().equalsIgnoreCase("")) {
							continue;
						}
						
		                String genId = CommonUtils.getRandomString(); // 파일명 중복 방지
		                String originalfileName = multipartFile.getOriginalFilename(); // 원본 파일명
		                String saveFileName = genId + "." + CommonUtils.getExtension(originalfileName); // 서버에 저장될 파일명
		                String savePath = path + "/" + saveFileName; // 서버에 저장된 파일 경로
		                String hash = CommonUtils.getSHA256(multipartFile.getBytes()); // SHA-256 해쉬 알고리즘
		                multipartFile.transferTo(new File(savePath)); // 서버에 파일 저장
		                
		                /* 무결성 검사 시작 */
		                boolean isIntegrity = false;
		                File up = new File(savePath);
		                if(up.exists()) {
		                	if(CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
		                		isIntegrity = true; // 무결성 확인 완료
		                	} else {
		                		up.delete(); // 손상된 파일 삭제
		                	}
		                }
		                
	                	if(isIntegrity) { // 무결성 체크 완료
			                Map<String, Object> params = new HashMap<String, Object>();
							params.put("board_cd", board_cd);
							params.put("seq_no", 0);
							params.put("file_nm", originalfileName);
							params.put("file_save_nm", saveFileName);
							params.put("file_path", savePath);
							params.put("enclude_yn", "N");
							params.put("input_id", (writer.isEmpty())?userVO.getId():writer);
							params.put("input_ip", CommonUtils.getClientIP(request));
	//						params.put("hash", hash);
							service2.addFile(params);
							
							params.put("opt", 1);
							recentFiles.add(service2.getFile(params));
		                }
					}
				}
				
				Date dt = new java.util.Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String today = sdf.format(dt);
				
				Map<String, Object> params = new HashMap<String, Object>();
		 		params.put("board_cd", board_cd);
				// seq_no은 자동으로 +1 하기 때문에 필요 없음
		 		params.put("up_seq_no", 0);
				params.put("title", title); //게시글 제목
				params.put("contents", contents); //게시글 내용
				params.put("fix_yn", (fix_yn == null)?"N":fix_yn); //체크박스 선택 안하면 null이 넘어옴
				params.put("attach_yn", (recentFiles.size() > 0)?"Y":"N");
		 		params.put("start_date", today);
		 		params.put("end_date", today);
				params.put("input_id", (writer.isEmpty())?userVO.getId():writer); //게시글을 작성한 사용자 ID
		 		params.put("input_ip", CommonUtils.getClientIP(request));
				service.addBoard(params);

				/* 첨부파일 등록 */
				params = new HashMap<String, Object>();
				params.put("board_cd", board_cd);
				params.put("opt", 1);

				recentBoard = service.getBoard(params);
				
				if(recentFiles != null && !recentFiles.isEmpty() && recentBoard != null) {
					for (FileVO f : recentFiles) {
						params.put("file_no", f.getFILE_NO());
						params.put("seq_no", recentBoard.getSEQ_NO());
						service2.attachFile(params);
					}
					
					CommonUtils.showAlert(response, "정상적으로 등록되었습니다.");
				} 
				/*
				else {
					throw new Exception("DB Error : NullPointer");	
				}
				*/
			}
		} catch(Exception e) {
			CommonUtils.showAlert(response, "등록에 실패했습니다.");
			e.printStackTrace();
		}
        return redrt;
	}
	
}
