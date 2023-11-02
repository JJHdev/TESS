package business.biz.evalu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.FileUtil;
import common.util.properties.ApplicationProperty;


/**
 * Program Name    : EvaluFileService
 * Description     : 파일 처리 Service
 * Programmer Name : LCS
 * Creation Date   : 2014-10-10
 * Used Table(주요) : TB_Evalu_BUSIFILE (관광개발사업 첨부파일)
 * 
 * @author LCS
 *
 */
@Service
@SuppressWarnings( { "unchecked", "rawtypes"})
public class EvaluFileService extends BaseService {
    
    protected final Log logger = LogFactory.getLog(getClass());
    
    @Autowired
    private CommonDAOImpl dao;
    
    /**
     * 파일 일괄 처리.
     * @param infoMap
     * @param listNewFile
     * @throws Exception
     */
    public int fileManagement(Map paramMap, List<Map> upfileInfoList) throws Exception {
        
        int cnt = 0;
        
        //-------------------------------------
        // 삭제 대상 파일 리스트 구성 관련
        //-------------------------------------
        deltFiles(paramMap);
        
        //------------------------
        // 신규 파일 일괄 처리.
        //------------------------
        if(upfileInfoList != null && !upfileInfoList.isEmpty()) {
            for(Map fileInfo : upfileInfoList){
                cnt += addFile(fileInfo);
            }
        }
        
        return cnt;
    }
    
    /**
     * 화면에서 기 첨부된 파일을 삭제한 파일 정보 모두 삭제 처리.
     * @param paramMap
     * @return
     * @throws Exception
     */
    public int deltFiles(Map paramMap) throws Exception{
        
        int cnt = 0;
        
        // 화면에서 넘어온 파일번호 문자열 (1,2,3....)
        String deltFileDatas = (String)paramMap.get("deltFileDatas");
        
        if(!CommUtils.empty(deltFileDatas)){
            // 파일 번호 배열로 변경.
            String[] arrFileNo = deltFileDatas.split(",");
            
            Map dfMap = new HashMap();
            dfMap.put("arrFileNo", arrFileNo);
            
            // 삭제대상 파일리 정보 리스트 조회
            List listDelFile    = listEvaluFileDelt(dfMap);
            
            // 물리적 파일을 삭제하고 db 삭제할 대상 List 객체(deFileList) 구성
            List delFileList = deletePhysicalFiles(listDelFile);
            
            // Delete DB
            if (delFileList.size() > 0) {
                cnt += deltEvaluFiles(arrFileNo);
            }
        }
        
        return cnt;
    }
    
    /**
     * 특정 관광사업정보의 모든 첨부파일을 삭제한다.
     * @param paramMap
     * @return
     * @throws Exception
     */
    public int deltAllFiles(Map paramMap) throws Exception{
        int cnt = 0;
        
        // 삭제대상 파일리 정보 리스트 조회
        List listDelFile    = listEvaluFileDelt(paramMap);
        
        // 물리적 파일을 삭제하고 db 삭제할 대상 List 객체(deFileList) 구성
        List delFileList = deletePhysicalFiles(listDelFile);
        
        // Delete DB
        if (delFileList.size() > 0) {
            cnt += deltEvaluFileAll(paramMap);
        }
        
        return cnt;
    }
    
    /**
     * 하나의 신규 파일을 등록처리하는 method
     * @param fileInfo
     * @return
     * @throws Exception
     */
    public int addFile(Map fileInfo) throws Exception {
        
        int cnt = 0;
        
        // 정보가 없으면 그대로 종료
        if(fileInfo == null || fileInfo.isEmpty()) return cnt;
        
        String docuType = (String)fileInfo.get("docuType");
        if(CommUtils.empty(docuType)) return cnt;
        
        //------------------------
        // path 정보 설정.
        //------------------------
        String tempPath = ApplicationProperty.get("upload.temp.dir");
        String realPath = ApplicationProperty.get("upload.real.dir");
        
        //subDir 항목 설정.
        String subDir = "";
        //[기타정보>년도별 사업계획서]  subDir 설정
        
        if(EvaluCommService.FL_DOCU_TYPE_PLYY.equals(docuType)){
            subDir = ApplicationProperty.get("upload.sub.dir.evaluPlyy");
        }
        
        String realFullPath        = realPath + subDir + "/" + CommUtils.getToday("");
        // db에 등록할 항목 (파일명을 제외한 전체 path)
        fileInfo.put("filePath"  , realFullPath);

        //------------------------
        // 임시dir에서 실제dir로 이동
        //------------------------
        String serverFileName   = CommUtils.nvlTrim((String)fileInfo.get("fileSvrNm"));
        
        //디렉토리 생성
        FileUtil.makeDirectories(realFullPath);
        
        // Temp Dir ---> Real Dir.  Moving
        String srcFilePath = tempPath + serverFileName;
        String trgFilePath = realFullPath + "/" + serverFileName;
        FileUtil.moveFile(srcFilePath, trgFilePath);
        
        //------------------------
        // DB 저장 처리.
        //------------------------
        cnt += regiEvaluFile(fileInfo);
        
        return cnt;
    }
    
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    // 파일 저장 정보 구성 부분
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * 화면에서 넘어온 업로드 파일정보와 해당하는 meta 정보를 파일 정보 객체에 추가
     * @param paramMap
     * @param upfileInfoList
     * @throws Exception
     */
    public void initMetaInfoUpfileList(Map paramMap, List upfileInfoList) throws Exception {
        
        String[] arrFileDocuType = (String[])paramMap.get("arrFileDocuType");
        String[] arrFileAtthType = (String[])paramMap.get("arrFileAtthType");
        int fileAreaIdx = -1;
        int filePlyyIdx = -1;
        int fileStahIdx = -1;
        
        if(upfileInfoList!=null && !upfileInfoList.isEmpty()) {
            
            for(int i=0;i<arrFileDocuType.length;i++) {
            	
            	System.out.println("i의 값은 얼마인가??????????????? " + i);
            	
                Map fMap = (Map)upfileInfoList.get(i);
                String atthType = arrFileAtthType[i];
                String docuType = arrFileDocuType[i];
                
//            	파일 첨부유형 갯수에 맞게 순번추가
            	if (docuType.equals("PLYY")){
            		filePlyyIdx++;
            	}
                
                if(fMap!=null && !fMap.isEmpty()) {
                    fMap.put("rootNo"  , paramMap.get("evaluBusiNo"));   //rootNo를 EvaluBusiNo 값으로 설정.
                    fMap.put("docuType", docuType);                     //docuType 설정
                    fMap.put("atthType", atthType);                     //atthType 설정
                    fMap.put("regiId"  , paramMap.get("gsUserId"));
                    fMap.put("updtId"  , paramMap.get("gsUserId"));
                    
//                	첨부유형 순번 저장
                	if (docuType.equals("PLYY")){
                		fMap.put("fileIdx", filePlyyIdx); 
                	}
                }
            }
        }
    }
    
    /**
     * 삭제 파일 대상을 파일삭제 대상 문자열 attr에 등록.
     * @param paramMap
     * @param delInfo
     * @throws Exception
     */
    public void addDeltFilesInfo(Map paramMap, Map delInfo) throws Exception {
        
        // 삭제대상 pk를 나열한 문자열 form값.
        String deltFileDatas = CommUtils.nvl((String)paramMap.get("deltFileDatas")) ;
        
        // 삭제할 파일 대상을 조회한다.
        List<Map> delFileList = listEvaluFile(delInfo);
        
        // 검색된 파일이 존재하면 삭제대상임.
        if(delFileList!=null && !delFileList.isEmpty()){
            
            for(Map fMap : delFileList) {
                // 파일 번호(pk)
                String EvaluFileNo = CommUtils.toString((HashMap)fMap, "EvaluFileNo");
                // 파일번호를 파일삭제 문자열에 추가
                deltFileDatas += ( ((CommUtils.empty(deltFileDatas))? "":",")  + EvaluFileNo );
            }
        }
        
        // parameter Map에 파일 삭제 attr을 다시 설정.
        paramMap.put("deltFileDatas",deltFileDatas);
    }
    
    //+++++++++++++++++++++++++++++++++++
    // DB 관련 내용
    //+++++++++++++++++++++++++++++++++++
    public List listEvaluFile(Map paramMap) throws Exception {
        return dao.list("EvaluFile.listEvaluFile", paramMap);
    } 
    public Map viewEvaluFile(Map paramMap) throws Exception {
        return (Map)dao.view("EvaluFile.viewEvaluFile", paramMap);
    } 
    public int regiEvaluFile(Map paramMap) throws Exception {
        return dao.save("EvaluFile.regiEvaluFile", paramMap);
    }
    public List<Map> listEvaluFileDelt(Map params) {
        List list = dao.list("EvaluFile.listEvaluFileDelt", params);
        return list;
    }
    // 첨부파일 등록
    public int regiEvaluFiles(List<HashMap> fileList) throws Exception {
        int cnt = 0;
        for (int i = 0; i < fileList.size(); i++) {
            Map fileMap = (Map)fileList.get(i);
            cnt += regiEvaluFile(fileMap);
        }

        return cnt;
    }// 해당 fileNo에 속하는 파일 정보 수정.
    public int updtEvaluFile(Map paramMap) throws Exception {
        return dao.save("EvaluFile.updtEvaluFile", paramMap);
    }
    // 첨부파일 삭제 (선택 파일)
    public int deltEvaluFiles(String[] arrFileNo) throws Exception {
        int cnt = 0;
        for (int i = 0; i < arrFileNo.length; i++) {
            Map fileMap = new HashMap();
            fileMap.put("EvaluFileNo", arrFileNo[i]);
            cnt += deltEvaluFile(fileMap);
        }

        return cnt;
    }
    // 해당 fileNo에 속하는 파일 정보 삭제
    public int deltEvaluFile(Map paramMap) throws Exception {
        return dao.save("EvaluFile.deltEvaluFile", paramMap);
    }
    // 해당 rootNo에 속하는 모든 파일 정보 삭제
    public int deltEvaluFileAll(Map paramMap) throws Exception {
        return dao.save("EvaluFile.deltEvaluFileAll", paramMap);
    }
    
    //+++++++++++++++++++++++++++++++++++
    // private methods
    //+++++++++++++++++++++++++++++++++++

    /**
     * 물리적인 파일을 삭제함.
     * @param listDelFile  삭제대상파일 리스트 객체
     * @param deFileList   DB 삭제대상 구성 List
     * @throws Exception
     */
    private List deletePhysicalFiles(List listDelFile) {
        
        List<Map> deFileList = new ArrayList();
        
        // 삭제 파일이 존재하면 처리...
        if (listDelFile != null) {
            // 파일 삭제
            for (int i = 0; i < listDelFile.size(); i++) {
                Map fileInfo          = (Map)listDelFile.get(i);
                String serverFileName = CommUtils.nvlTrim((String)fileInfo.get("fileSvrNm"));
                String path           = CommUtils.nvlTrim((String)fileInfo.get("filePath"));

                // Server File Delete
                String fullPath = path + "/" + serverFileName;
                FileUtil.deleteFile(fullPath);
                logger.debug("[DELETE-file] " + fullPath);
                
                deFileList.add(fileInfo);
            }
        }
        
        return deFileList;
    }
    
    
}