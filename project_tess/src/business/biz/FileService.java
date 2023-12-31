/**
 * Program Name    : FileService
 * Description     : File Common Service
 * Programmer Name : ntarget
 * svn ID          : ntarget
 * Creation Date   : 2010-03-03 ( File Common Addition )
 * Used Table      :
 */

package business.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.FileUtil;
import common.util.properties.ApplicationProperty;

@SuppressWarnings( {"rawtypes", "unchecked"})
@Service
public class FileService extends BaseService {

	//protected final Log logger = LogFactory.getLog(getClass());
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private CommonDAOImpl dao;

	//==================================================================================
	//  파일 조회
	//==================================================================================
	public List<Map> listFile(Map params) {
		List list = dao.list("File.listFile", params);
		return list;
	}

	//==================================================================================
	//  삭제 대상파일 조회
	//==================================================================================
	public List<Map> listDelFile(Map params) {
		List list = dao.list("File.listDelFile", params);
		return list;
	}

	//==================================================================================
	//  첨부파일 처리
	//  mode : I 등록, U 수정, D 삭제
	//==================================================================================
	@SuppressWarnings("unused")
	public int fileManagement(Map paramFileMap, List<HashMap> listNewFile) {
		
		String regiId 	= CommUtils.nvlTrim(userInfo.getUserId());							//등록자
		String updtId 	= CommUtils.nvlTrim(userInfo.getUserId());							//수정자
		String ip 		= CommUtils.nvlTrim(userInfo.getIpAddr());								//ip

		String tempPath = ApplicationProperty.get("upload.temp.dir");
		String realPath = ApplicationProperty.get("upload.real.dir");

		String subDir	= CommUtils.nvlTrim((String)paramFileMap.get("subDir"));			//경로
		String rootNo	= CommUtils.nvlTrim((String)paramFileMap.get("rootNo"));		//Root 번호
		String status	= CommUtils.nvlTrim((String)paramFileMap.get("status"));				//상태 값
		String docuType	= CommUtils.nvlTrim((String)paramFileMap.get("docuType"));		//게시판 구분

		String[] arrFileNo	= (String[])paramFileMap.get("arrFileNo");						// 삭제 체크SEQ


		realPath 	= realPath + subDir + "/" + CommUtils.getToday("");

		int cnt = 0;
		List<HashMap> regFileList = new ArrayList();

		// 기존 파일 삭제
		if ((arrFileNo != null && arrFileNo.length > 0) || status.equalsIgnoreCase("D")) {
			// 삭제파일 조회
			List listDelFile	= listDelFile(paramFileMap);

			// 삭제 파일이 존재하면 처리...
			if (listDelFile != null) {
				// 파일 삭제(서버)
				for (int i = 0; i < listDelFile.size(); i++) {
					HashMap fileInfo 		= (HashMap)listDelFile.get(i);
					String serverFileName 	= CommUtils.nvlTrim((String)fileInfo.get("fileSvrNm"));
					String path 			= CommUtils.nvlTrim((String)fileInfo.get("filePath"));

					if(status.equalsIgnoreCase("P"))	
						// Server File Delete
						FileUtil.deleteFile(path + "/" + serverFileName);
				}

				// 게시물 삭제일경우 첨부 전체 삭제 [파일 삭제(DB)]
				if (status.equalsIgnoreCase("D")) {
					cnt = deltFiles(rootNo,updtId);
				} 
				else if(status.equalsIgnoreCase("P")){
					cnt = deltPopFiles(listDelFile);
				}
				else {
					cnt = deltFiles(listDelFile,updtId);
				}
			}

		}

		// 파일 등록
		if (listNewFile != null && listNewFile.size() > 0) {
			for (int i = 0; i < listNewFile.size(); i++) {
				HashMap fileInfo 		= (HashMap)listNewFile.get(i);
				String serverFileName 	= CommUtils.nvlTrim((String)fileInfo.get("fileSvrNm"));

				//디렉토리 생성
				FileUtil.makeDirectories(realPath);

				// Temp Dir ---> Real Dir.  Moving
				FileUtil.moveFile(tempPath + serverFileName, realPath + "/" + serverFileName);

				fileInfo.put("ip"				, ip);
				fileInfo.put("regiId"			, regiId);
				if(CommUtils.empty((String)fileInfo.get("rootNo"))){
				    fileInfo.put("rootNo"			, rootNo);
				}
				if(CommUtils.empty((String)fileInfo.get("docuType"))){
					fileInfo.put("docuType"			, docuType);
				}
				
				fileInfo.put("filePath"				, realPath);

				regFileList.add(fileInfo);
			}

			// Insert DB
			if (regFileList.size() > 0)
				cnt = regiFiles(regFileList);
		}
		
		return cnt;

	}

	// 첨부파일 등록
	public int regiFiles(List<HashMap> fileList) {
		int cnt = 0;
		for (int i = 0; i < fileList.size(); i++) {
			HashMap fileInfo = (HashMap)fileList.get(i);
			cnt = (Integer)dao.update("File.insertFile", fileInfo);
		}

		return cnt;
	}

	// 첨부파일 삭제 (선택 파일)
	public int deltFiles(List<HashMap> fileList, String updtId) {
		int cnt = 0;
		for (int i = 0; i < fileList.size(); i++) {
			HashMap fileInfo = (HashMap)fileList.get(i);
			fileInfo.put("updtId", updtId);
			cnt += (Integer)dao.update("File.deleteFile", fileInfo);
		}

		return cnt;
	}
	
	// 첨부파일 팝업삭제 (선택 파일)
	public int deltPopFiles(List<HashMap> fileList) {
		int cnt = 0;
		for (int i = 0; i < fileList.size(); i++) {
			HashMap fileInfo = (HashMap)fileList.get(i);
			cnt += (Integer)dao.delete("File.deltPopFiles", fileInfo);
		}
		
		return cnt;
	}

	// 첨부파일 삭제 (전체 파일)
	public int deltFiles(String delNo, String updtId) {
		Map fileMap = new HashMap();
		fileMap.put("rootNo", delNo);
		fileMap.put("updtId", updtId);
		// DB 데이터 삭제
		int cnt = (Integer)dao.update("File.deleteAllFiles", fileMap);
		return cnt;
	}


    public Map viewFile(Map params) {
        Map file = (Map)dao.view("File.viewFile", params);
        return file;
    }
    
    public Map viewSampleFile(Map params) {
        Map file = (Map)dao.view("File.viewSampleFile", params);
        return file;
    }
    
    public int getMaxFileNo(Map params) {
    	int fileNo = (Integer) dao.view("File.getMaxFileNo", params);
    	return fileNo;
    }
    public Map viewEvaluBusiFile(Map params) {
        Map file = (Map)dao.view("File.viewEvaluBusiFile", params);
        return file;
    }

    // PDF파일 미리보기용 조회
	public Map getupFileAT02(Map paramMap) {
		return (Map)dao.view("File.getupFileAT02", paramMap);
	}
    
}
