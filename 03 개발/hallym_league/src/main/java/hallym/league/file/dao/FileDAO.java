package hallym.league.file.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.league.file.vo.FileVO;

@Mapper("fileDAO")
public interface FileDAO {
	
	public List<FileVO> getFileList(Map<String, Object> params); //파일 목록 조회
	
	public int getFileListCnt(Map<String, Object> params); // 파일 개수
	
	public FileVO getFile(Map<String, Object> params); // 단일 파일 조회

	public void addFile(Map<String, Object> params); // 파일 정보 추가
	
	public void attachFile(Map<String, Object> params); // 파일 게시글 첨부(연결)

	public void updateFile(Map<String, Object> params); // 파일 정보 갱신(수정)
	
	public void deleteFile(Map<String, Object> params); // 파일 정보 삭제
	
}
