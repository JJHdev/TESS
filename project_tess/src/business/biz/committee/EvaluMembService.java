package business.biz.committee;

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
 * Program Name    : EvaluMembService
 * Description     : 관리/운영 개발사업관리 Service
 * Programmer Name : LCS
 * Creation Date   : 2014-09-29
 * Used Table(주요) :
 * 
 * @author LCS
 *
 */
@Service
@SuppressWarnings({"rawtypes", "unchecked"})
public class EvaluMembService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    @Autowired
    private  EvaluCommService evaluCommService;

    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluMbrMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("Memb.listEvaluMbrMgmt", paramMap, currPage, pageSize);
    }
    
    /**
     * 위원 정보 보기 / 수정
     * @param paramMap
     * @param listFileInfo
     */
    public Map viewEvaluMbrCommit(Map paramMap) throws Exception {
        return (Map)dao.view("Memb.getEvaluCommitInfo", paramMap);
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
		            dao.save("Memb.regiCommitMemb", paramMap);
		            
	            }
	            //수정
	            else {
	            	//------------------
		            // TB_EVALU_COMMIT_INFO 업데이트
		            //------------------
	            	logger.debug("************ updateCommitMemb:" +(String)paramMap.get("userId"));
	            	dao.save("Memb.updateCommitMemb", paramMap);
	            
		            //------------------
		            // TB_EVALU_COMMIT_FIELD 삭제 후 재등록
		            //------------------
	            	logger.debug("************ deleteCommitField:" +(String)paramMap.get("userId"));
	            	dao.delete("Memb.deleteCommitField", paramMap);
	            	
	            	logger.debug("************ regiCommitField:" +(String)paramMap.get("userId"));
	            	dao.save("Memb.regiCommitField", paramMap);
	            	
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
	            String fieldList = (String)paramMap.get("fieldList");
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
		            cnt += dao.save("Memb.regiCommitField", paramMap);
		            
	            }
	            //수정
	            else {
	                //-------------------------
	                // TB_USCM 수정
	                //-------------------------
	            	cnt += dao.save("Memb.updtMembUscm", paramMap);
	            
		            //------------------
		            // TB_EVALU_COMMIT_FIELD 등록
		            //------------------
	            	cnt += dao.save("Memb.updtMembUser", paramMap);
		            
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
        return dao.pageList("Memb.listEvaluMbrBusi", paramMap, currPage, pageSize);
    }
	
	 /**
     * 사용자 ID 중복 검사
     * @param paramMap
     * @return
     */
    public int viewMembCheckDuplUserId(Map paramMap) throws Exception {
        return (Integer)dao.view("Memb.viewMembCheckDuplUserId", paramMap);
    }

}



