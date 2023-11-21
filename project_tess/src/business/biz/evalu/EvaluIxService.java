package business.biz.evalu;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import oracle.net.aso.p;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import business.biz.CommConst;
import business.biz.comm.CommService;
import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;

/**
 * 평가지표 관련 서비스
 * 
 * @class   : EvaluIxService
 * @author  : LHB
 * @since   : 2023.11.19
 * @version : 1.0
 *
 *   수정일       수정자                수정내용
 *  --------   --------    ---------------------------
 *  23.11.19     LHB           지표 관련 서비스 생성
 */
@Service
@SuppressWarnings({ "all" })
public class EvaluIxService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    @Autowired
    private  EvaluCommService evaluCommService;
    
    @Autowired
    private EvaluFileService evaluFileService;
    
    // 평가 지표 일련번호 조회
	public Map getEvlIxSn(Map paramMap) {
		return (Map) dao.view("EvaluIx.getEvlIxSn", paramMap);
	}
	
	// 평가 지표 항목 일련번호로 조회
	public List listEvlIx(Map paramMap) {
		return dao.list("EvaluIx.listEvlIx", paramMap);
	}
	
	// 평가 지표 평가위원 데이터 저장
	public Map saveEvlIxList(Map paramMap) {
		Map returnMap = new HashMap();
		
		String evaluHistSn	= paramMap.get("evaluHistSn") == null ? null : (String) paramMap.get("evaluHistSn");
		
		if (evaluHistSn == null) {
        	// 평가사업 일련번호 없는 경우
        	returnMap.put("code", -3);
        	returnMap.put("msg", "평가사업 일련번호가 정의되지 않았습니다.");
        } else {
        	if (paramMap.get("gsRoleId") == null || !paramMap.get("gsRoleId").equals(CommConst.ROLE_SCHL)) {
        		// 평가위원이 아닌 경우
        		returnMap.put("code", -1);
            	returnMap.put("msg", "평가위원만 평가 의견서를 작성할 수 있습니다.");
        	} else {
        		// 평가사업에 대한 권한 있는지 확인
        		String auth = (String) dao.view("EvaluIx.chckEvlIxAuth", paramMap);
        		if (auth == null) {
        			returnMap.put("code", -2);
                	returnMap.put("msg", "평가의견서 작성 권한이 없거나 작성할 수 없는 상태입니다.");
        		} else {
        			HashMap<String, Object> ixDataMap = new HashMap<String, Object>();
        	        try {
        	        	ixDataMap = new ObjectMapper().readValue((String) paramMap.get("data"), HashMap.class);
        	        } catch (IOException ioe) {
        	        	logger.error("saveEvlIxList error ::: " + ioe);
        	        	ixDataMap = null;
        	        } catch (Exception e) {
        	        	logger.error("saveEvlIxList error ::: " + e);
        	        	ixDataMap = null;
        	        }
        	        
        	        if (ixDataMap == null) {
        	        	returnMap.put("code", -4);
                    	returnMap.put("msg", "시스템 에러가 발생했습니다.");
                    	logger.error("평가 지표 데이터 json to hashmap error");
        	        } else {
        	        	// TODO 평가의견서 전부 삭제 (TB_EVL_MFCMM_DATA)
            			
            			// TODO 평가의견서 INSERT
        	        }
        		}
        	}
        }
		
		return returnMap;
	}
	
	
    
}
