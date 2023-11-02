package business.biz.additionals;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.FileService;
import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;

/**
 * Program Name    : BbsService
 * Description     : 게시판 Service
 * Programmer Name : SYM
 * Creation Date   : 2014-11-05
 * Used Table(주요) : TB_BBS, TB_ATTHFILE
 * 
 * @author SYM
 *
 */

@Service
@SuppressWarnings({ "unchecked" })
public class AddtnlsService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

    @Autowired
    private FileService fileService;


	/**
	 * 게시물 리스트 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public PaginatedArrayList listExcelntCase(Map paramMap, int currPage, int pageSize) throws Exception {
		
		PaginatedArrayList list =  dao.pageList("Additionals.listCase", paramMap, currPage, pageSize);
		Map descMap = new HashMap();
		
	
		//본문내용 검색
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map)list.get(i);
			descMap.put("case_no", map.get("caseNo")) ;
			
			//본문내용
			List descList= dao.list("Additionals.viewCaseDesc", descMap);
			
			String tempStr ="";
			for (int j = 0; j < descList.size(); j++) {
				Map tempMap = (Map)descList.get(j);
				tempStr += tempMap.get("CASE_DESC");
			}
			map.put("caseDesc", tempStr);
		}
		
		return list;
	}

	/**
	 * 게시물 등록, 수정, 삭제처리
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("null")
	public void saveCase(Map paramMap, List fileList, String procType) throws UnsupportedEncodingException {
		int nNum = 0; //반복횟수
		int cutSize	= 3500;		//3500자로
		int cnt = 0;
		String  caseDesc = (String)paramMap.get("caseDesc"); //게시물 내용
		
		if(caseDesc != null){
			int strlen = caseDesc.getBytes("MS949").length; //바이트로 전체 길이 구함
			logger.debug("strLen 값은:::::::::::::::::::::::"+strlen);

			nNum = strlen/3500;
			if(strlen % 3500!=0){
				nNum+=1; //나머지가 있을경우는 +1해준다.
			}
		}

		try {
			//게시물 등록
			if(procType.equals("I")){
				//내용을 제외한 나머지 내용 입력
				String case_no = (String)dao.insert("Additionals.saveCase", paramMap);
	            if(CommUtils.empty(case_no) == false){
	                cnt ++;
	            }
			}
			//게시물 수정
			else if(procType.equals("U")){
				//내용을 제외한 나머지 내용 입력
				cnt += dao.update("Additionals.updtCase", paramMap);
				
				//본문내용 삭제
				dao.delete("Additionals.delCaseDesc", paramMap);
			}
			//게시물 삭제
			else if(procType.equals("D")){
				//게시물 삭제 처리
				cnt += dao.update("Additionals.deltCase", paramMap);
			}
			//본문 등록
			if(procType.equals("I") || procType.equals("U")){
				for (int i = 0; i < nNum; i++) {
					String tempDesc = CommUtils.cutByte(caseDesc, i*cutSize, i*cutSize+cutSize);
					paramMap.put("caseDesc", tempDesc);
					dao.insert("Additionals.saveCaseDesc", paramMap); // 본분내용 입력
				}
			}

	        //------------------
	        // 파일 처리 부분
	        //------------------
	        Map infoMap = new HashMap();
	        infoMap.put("subDir",  ApplicationProperty.get("upload.sub.dir1"));		//파일 경로
	        infoMap.put("rootNo", paramMap.get("case_no"));	        				//root 번호
	        infoMap.put("docuType", "ExcellentCase");						//게시판 구분
	        
	        //삭제파일 배열로 변환
            if (!CommUtils.empty((String)paramMap.get("ArrdelFileNo"))) {
            	infoMap.put("arrFileNo", ((String) paramMap.get("ArrdelFileNo")).split(","));
            }
            
            if(procType.equals("D")){
            	infoMap.put("status", procType);
            }

	        //파일정보 Db입력
	        cnt += fileService.fileManagement(infoMap, fileList);
	        
            //-------------------------
            // 오류 검사.
            //-------------------------
            if(cnt == 0 ) {
                // msg : 저장된 내역이 없습니다.
                throw processException("exception.user.notExistSaveResult");
            }
	        
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 우수사례 상세내용 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public Map viewCase(Map paramMap) throws Exception {
		
		Map viewMap = new HashMap<String, Object>();
		try {
			//내용검색
			 viewMap = (HashMap) dao.view("Additionals.viewCase", paramMap);
			//본문내용
			List descList= dao.list("Additionals.viewCaseDesc", paramMap);

			//파일맵 생성
			Map fileMap = new HashMap<String, String>();

			fileMap.put("rootNo", paramMap.get("case_no")) ; //파일조회번호 키
			//fileMap.put("docuType", paramMap.get("bbs_type")) ; //게시판 코드값

			List fileList = fileService.listFile(fileMap);

			viewMap.put("fileList", fileList);

			String tempStr ="";
			for (int i = 0; i < descList.size(); i++) {
				Map tempMap = (Map)descList.get(i);
				tempStr += tempMap.get("CASE_DESC");
			}
			viewMap.put("caseDesc", tempStr);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return viewMap;
	}
	
	/**
	 * 게시물 조회수 증가
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public void updtCaseCnt(Map paramMap) {
		dao.update("Additionals.updtCaseCnt", paramMap);
	}
	
	 // 페이징을 위한 리스트 조회
    public PaginatedArrayList getBusiList(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("Additionals.getBusiList", paramMap, currPage, pageSize);
    }
    
	
}
