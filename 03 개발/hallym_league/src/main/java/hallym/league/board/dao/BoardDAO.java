package hallym.league.board.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.league.board.vo.BoardVO;

@Mapper("boardDAO")
public interface BoardDAO {
	
	public List<BoardVO> getBoardList(Map<String, Object> params); //게시글 목록 조회
	
	public int getTotalPageCnt(Map<String, Object> params); // 총 페이지 수
	
	public BoardVO getBoard(Map<String, Object> params); //단일 게시글 조회
	
	public int getBoardListCnt(Map<String, Object> params); //게시글 개수

	public void addBoard(Map<String, Object> params); //게시글 작성

	public void deleteBoard(Map<String, Object> params); //게시글 임시 삭제
	
	public void deleteBoardReal(Map<String, Object> params); //게시글 영구 삭제

	public void updateBoard(Map<String, Object> params); //게시글 수정

	public void increaseOpenCnt(Map<String, Object> params); //조회수 증가

}
