package hallym.league.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.league.board.dao.BoardDAO;
import hallym.league.board.vo.BoardVO;
import hallym.league.board.service.BoardService;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	
	@Override
	public List<BoardVO> getBoardList(Map<String, Object> params) {
		/* 게시글 목록 조회 */
		return boardDAO.getBoardList(params);
	}
	
	@Override
	public int getTotalPageCnt(Map<String, Object> params) {
		/* 총 페이지 수 */
		return boardDAO.getTotalPageCnt(params);
	}
	
	@Override
	public BoardVO getBoard(Map<String, Object> params) {
		/* 단일 게시글 조회 */
		return boardDAO.getBoard(params);
	}
	
	@Override
	public int getBoardListCnt(Map<String, Object> params) {
		/* 게시글 개수 */
		return boardDAO.getBoardListCnt(params);
	}
	
	@Override
	public void addBoard(Map<String, Object> params) {
		/* 게시글 작성 */
		boardDAO.addBoard(params);
//		return (int)params.get("seq_no");
	}
	
	@Override
	public void deleteBoard(Map<String, Object> params) {
		/* 게시글 임시 삭제 */
		boardDAO.deleteBoard(params);
	}

	@Override
	public void deleteBoardReal(Map<String, Object> params) {
		/* 게시글 영구 삭제 */
		boardDAO.deleteBoard(params);
	}

	@Override
	public void updateBoard(Map<String, Object> params) {
		/* 게시글 수정 */
		boardDAO.updateBoard(params);
	}
	
	@Override
	public void increaseOpenCnt(Map<String, Object> params) {
		/* 조회수 증가 */
		boardDAO.increaseOpenCnt(params);
	}
}
