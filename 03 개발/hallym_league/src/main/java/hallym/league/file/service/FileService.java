package hallym.league.file.service;

import java.util.List;
import java.util.Map;

import hallym.league.file.vo.FileVO;

public interface FileService {

	List<FileVO> getFileList(Map<String, Object> params); //파일 목록 조회
	
	int getFileListCnt(Map<String, Object> params); // 파일 개수
	
	FileVO getFile(Map<String, Object> params); // 단일 파일 조회

	void addFile(Map<String, Object> params); // 파일 정보 추가
	
	void attachFile(Map<String, Object> params); // 파일 게시글 첨부(연결)

	void updateFile(Map<String, Object> params); // 파일 정보 갱신(수정)
	
	void deleteFile(Map<String, Object> params); // 파일 정보 삭제
	
}
