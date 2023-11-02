package business.biz.mng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import oracle.net.aso.p;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.comm.CommService;
import business.biz.evalu.EvaluCommService;
import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;


/**
 * Program Name    : EvaluCommitteeService
 * Description     : 관리자 Service
 * Programmer Name : lsz
 * Creation Date   : 2018-11-26
 * Used Table(주요) :
 * 
 * @author lsz
 *
 */
@Service
@SuppressWarnings({"rawtypes", "unchecked"})
public class EvaluCommitteeService extends BaseService {
    
	@Autowired
    private CommonDAOImpl dao;
    
    @Autowired
    private  EvaluCommService evaluCommService;

    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluMbrMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("MngComm.listEvaluMbrMgmt", paramMap, currPage, pageSize);
    }
 
    
    /**
     * 위원 정보 보기 / 수정
     * @param paramMap
     * @param listFileInfo
     */
    public Map viewEvaluMbrCommit(Map paramMap) throws Exception {
        return (Map)dao.view("MngComm.getEvaluCommitInfo", paramMap);
    } 
    
    /**
     * 회원정보 입력 부분 등록/수정 처리.
     * @param paramMap
     * @param listFileInfo
     */
	public void saveCommitMembInfo(Map paramMap, String procType) throws Exception {
		logger.debug("saveCommitMembInfo!!");
        try {
	            //------------------
	            // 기본 항목값 설정.
	            //------------------
	            Map initMap = new HashMap();
	            
	            // 사용여부(USE_YN)는 'Y'으로 설정.
	            paramMap.put("useYn", "Y");
	            
	            // 비밀번호가 전달되었을 때 converting 처리.
	            String passwd = (String)paramMap.get("passwd");
	            if(CommUtils.empty(passwd) == false) {
	                String encPasswd = CommUtils.getPasswordEncodingString(passwd);
	                paramMap.put("passwd", encPasswd);
	            }
	            
	            
	            logger.debug("************ procType:" +procType);
	            //저장
	            if(procType.equals("I")){
	               
		            //------------------
		            // TB_EVALU_COMMIT_INFO 등록
		            //------------------
		            dao.save("MngComm.regiCommitMemb", paramMap);
		            
	            }
	            //수정
	            else {
	            	//------------------
		            // TB_EVALU_COMMIT_INFO 업데이트
		            //------------------
	            	logger.debug("************ updateCommitMemb:" +(String)paramMap.get("userId"));
	            	dao.save("MngComm.updateCommitMemb", paramMap);
	            
		            //------------------
		            // TB_EVALU_COMMIT_FIELD 삭제 후 재등록
		            //------------------
	            	logger.debug("************ deleteCommitField:" +(String)paramMap.get("userId"));
	            	dao.delete("MngComm.deleteCommitField", paramMap);
	            	
	            	logger.debug("************ regiCommitField:" +(String)paramMap.get("userId"));
	            	dao.save("MngComm.regiCommitField", paramMap);
	            	
	            }
	            
	            /*
                // 일반사용자일 경우에만 저장
	            if( paramMap.get("uscmType").equals("U1") || procType.equals("U") ){
		            //-------------------------
		            // SYS_ROLE_USER 저장
		            //-------------------------
		            	
		            cnt += updtMembUserRoles(paramMap);
	            }
	            */

                //-------------------------
                // 오류 검사.
                //-------------------------
              
        }catch(Exception ex){
            ex.printStackTrace();
            throw processException(ex.getMessage() );
        }
    }
	
    /**
     * 회원정보 분야 입력 부분 등록/수정 처리.
     * @param paramMap
     * @param listFileInfo
     */
	public void saveCommitMembField(Map paramMap, String procType) throws Exception {

    	int cnt = 0;
    	
        try {
	            //------------------
	            // 기본 항목값 설정.
	            //------------------
	            Map initMap = new HashMap();
	            //String fieldList = (String)paramMap.get("fieldList");
	            
	            String fieldCodeList = (String)paramMap.get("fieldCodeList");
	            System.out.println("fieldCodeList : " + fieldCodeList);
	            String fieldParentCodeList = (String)paramMap.get("fieldParentCodeList");
	            String fieldDetailContList = (String)paramMap.get("fieldDetailContList");
	            
	            String[] fieldCodeListArr = fieldCodeList.split(",");
	            String[] fieldParentCodeListArr = fieldParentCodeList.split(",");
	            String[] fieldDetailContListArr = fieldDetailContList.split(",");
	            
	            logger.debug("************ paramMap:" +paramMap);
	            
	            // 사용여부(USE_YN)는 'Y'으로 설정.
	            paramMap.put("useYn", "Y");
	            
	            // 비밀번호가 전달되었을 때 converting 처리.
	            String passwd = (String)paramMap.get("passwd");
	            if(CommUtils.empty(passwd) == false) {
	                String encPasswd = CommUtils.getPasswordEncodingString(passwd);
	                paramMap.put("passwd", encPasswd);
	            }
	            
	            logger.debug("************ procType:" +procType);
	            //저장
	            if(procType.equals("I")){
	               
		            //------------------
		            // TB_EVALU_COMMIT_FIELD 등록
		            //------------------
	            	
	            	for(int i=0 ; i<fieldCodeListArr.length ; i++) {
	            		
	            		System.out.println("fieldDetailContListArr[i] : " + fieldDetailContListArr[i]);
	            		
	            		paramMap.put("parentCode", fieldParentCodeListArr[i]);
	            		paramMap.put("code", fieldCodeListArr[i]);
	            		if(fieldDetailContListArr[i].isEmpty()) {
	            			paramMap.put("detailField", "");
	            		} else {
	            			paramMap.put("detailField", fieldDetailContListArr[i]);
	            		}
	            		
	            		cnt += dao.save("MngComm.regiCommitField", paramMap);
	            	}
	            }
	            //수정
	            else {
	                //-------------------------
	                // TB_USCM 수정
	                //-------------------------
	            	cnt += dao.save("MngComm.updtMembUscm", paramMap);
	            
		            //------------------
		            // TB_EVALU_COMMIT_FIELD 등록
		            //------------------
	            	cnt += dao.save("MngComm.updtMembUser", paramMap);
		            
	            }
	            
	            /*
                // 일반사용자일 경우에만 저장
	            if( paramMap.get("uscmType").equals("U1") || procType.equals("U") ){
		            //-------------------------
		            // SYS_ROLE_USER 저장
		            //-------------------------
		            	
		            cnt += updtMembUserRoles(paramMap);
	            }
	            */

                //-------------------------
                // 오류 검사.
                //-------------------------
                if(cnt == 0 ) {
                    // msg : 저장된 내역이 없습니다.
                    throw processException("exception.user.notExistSaveResult");
                }

        }catch(Exception ex){
            ex.printStackTrace();
            throw processException(ex.getMessage() );
        }
    }
    
    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluBusiList(Map paramMap, int currPage, int pageSize) throws Exception {
    	logger.debug("check listEvaluBusiList--aaa");
        return dao.pageList("MngComm.listEvaluMbrBusi", paramMap, currPage, pageSize);
    }
	
	 /**
     * 사용자 ID 중복 검사
     * @param paramMap
     * @return
     */
    public int viewMembCheckDuplUserId(Map paramMap) throws Exception {
        return (Integer)dao.view("MngComm.viewMembCheckDuplUserId", paramMap);
    }
    
    // 평가위원 세부분야 조회
    public List listCommitDetailField(Map reqMap) throws Exception {
    	return dao.list("MngComm.listCommitDetailField", reqMap);
    }
    
    // 평가위원 승인처리
    public int updateCommUseStat(Map paramMap) throws Exception {
    	return dao.save("MngComm.updateCommUseStat", paramMap);
    }
    
    
}
