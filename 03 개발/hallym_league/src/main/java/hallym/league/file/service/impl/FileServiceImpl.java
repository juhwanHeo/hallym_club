package hallym.league.file.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import hallym.league.file.dao.FileDAO;
import hallym.league.file.vo.FileVO;
import hallym.league.file.service.FileService;

@Service("fileService")
public class FileServiceImpl implements FileService {
	
	@Resource(name = "fileDAO")
	private FileDAO fileDAO;

	
	@Override
	public List<FileVO> getFileList(Map<String, Object> params) {
		return fileDAO.getFileList(params);
	}

	@Override
	public int getFileListCnt(Map<String, Object> params) {
		return fileDAO.getFileListCnt(params);
	}

	@Override
	public FileVO getFile(Map<String, Object> params) {
		return fileDAO.getFile(params);
	}

	@Override
	public void addFile(Map<String, Object> params) {
		fileDAO.addFile(params);
//		return (int)params.get("file_no");
	}

	@Override
	public void attachFile(Map<String, Object> params) {
		fileDAO.attachFile(params);
	}
	
	@Override
	public void updateFile(Map<String, Object> params) {
		fileDAO.updateFile(params);
	}

	@Override
	public void deleteFile(Map<String, Object> params) {
		fileDAO.deleteFile(params);
	}
	
}
