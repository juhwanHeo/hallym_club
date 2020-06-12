package hallym.league.board.service;

import java.util.List;
import java.util.Map;

import hallym.league.board.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(Map<String, Object> params); //게시글 목록 조회
	
	int getTotalPageCnt(Map<String, Object> params); // 총 페이지 수
	
	BoardVO getBoard(Map<String, Object> params); //단일 게시글 조회
	
	int getBoardListCnt(Map<String, Object> params); //게시글 개수

	void addBoard(Map<String, Object> params); //게시글 작성

	void deleteBoard(Map<String, Object> params); //게시글 임시 삭제
	
	void deleteBoardReal(Map<String, Object> params); //게시글 영구 삭제

	void updateBoard(Map<String, Object> params); //게시글 수정

	void increaseOpenCnt(Map<String, Object> params); //조회수 증가
}
