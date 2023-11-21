package business.biz.busi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import oracle.net.aso.p;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.comm.CommService;
import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;


/**
 * Program Name    : EvaluBusiService
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
public class EvaluBusiService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    
    /************************************************/
    /******************* 평가사업관리 *******************/
    /************************************************/
    
    // 평가사업 리스트 조회.
    public PaginatedArrayList listEvaluBusi(Map paramMap, int currPage, int pageSize) throws Exception {
    	return dao.pageList("Busi.listEvaluBusi", paramMap, currPage, pageSize);
    }
    
    // 평가완료사업 리스트 조회.
    public List listEvaluEndBusi(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluEndBusi", paramMap);
    }
    
    // 평가사업 상세정보
    public Map viewEvaluBusiInfo(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluBusiInfo", paramMap);
    }
    
    // 평가위원 평가진행현황
    public Map viewEvaluCommitStatus(Map paramMap) throws Exception {
    	return (Map)dao.view("Busi.viewEvaluCommitStatus", paramMap);
    }
    
    // 평가위원 이용 동의서 상태 변경
    public int updtEvaluCommitAgree(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluCommitAgree", paramMap);
    }
    
    // 평가위원 서면검토서 상태 변경
    public int updtEvaluCommitReview(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluCommitReview", paramMap);
    }
    
    // 평가위원 평가의견서 상태 변경
    public int updtEvaluCommitOpinion(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluCommitOpinion", paramMap);
    }
    
    // 평가사업정보 첨부파일 조회
    public List listEvaluBusiAtthFile(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluBusiAtthFile", paramMap);
    }
    
    // 첨부파일 조회
    public Map getEvaluBusiAtthFile(Map paramMap) throws Exception {
    	return (Map)dao.view("Busi.getEvaluBusiAtthFile", paramMap);
    }
    
    // 삭제 대상 첨부파일 조회
    public Map getDeleteAtthFile(Map paramMap) throws Exception {
    	return (Map)dao.view("Busi.getDeleteAtthFile", paramMap);
    }

    // 파일 삭제
    public int deptEvaluAtthFile(Map paramMap) throws Exception {
    	return dao.save("Busi.deptEvaluAtthFile", paramMap);
    }
    
    // 평가정보 평가위원 리스트
    public List listEvaluCommitList(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluCommitList", paramMap);
    }
    
    // 평가진행현황 이용동의 평가위원 리스트
    public List listEvaluStageAgreeCommitList(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluStageAgreeCommitList", paramMap);
    }
    
    // 평가진행현황 서면검토서 평가위원 리스트
    public List listEvaluStageReviewCommitList(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluStageReviewCommitList", paramMap);
    }
    
    // 평가진행현황 평가의견서 평가위원 리스트
    public List listEvaluStageOpinionCommitList(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluStageOpinionCommitList", paramMap);
    }
    
    // 평가위원 서면검토서 승인 상태 변경
    public int updtEvaluCommitReviewApv(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluCommitReviewApv", paramMap);
    }
    
    // 평가위원 평가의견서 승인 상태 변경
    public int updtEvaluCommitOpinionApv(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluCommitOpinionApv", paramMap);
    }
    
    // 평가단계 종합결과서 제출 상태 변경
    public int updtEvaluTotalResult(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluTotalResult", paramMap);
    }
    
    // 평가단계 종합결과서 제출 상태 조회
    public Map getEvaluTotalResult(Map paramMap) throws Exception {
    	return (Map)dao.view("Busi.getEvaluTotalResult", paramMap);
    }
    
    // 평가위원 종합의견 내용 등록
    public int regiEvaluOpinionNote(Map paramMap) throws Exception {
    	return dao.save("Busi.regiEvaluOpinionNote", paramMap);
    }
    
    // 평가위원 종합의견 내용 삭제
    public int deltEvaluOpinionNote(Map paramMap) throws Exception {
    	return dao.save("Busi.deltEvaluOpinionNote", paramMap);
    }
    
    // 평가위원 개선사항 내용 등록
    public int regiEvaluIpmNote(Map paramMap) throws Exception {
    	return dao.save("Busi.regiEvaluIpmNote", paramMap);
    }
    
    // 평가위원 개선사항 내용 삭제
    public int deltEvaluIpmNote(Map paramMap) throws Exception {
    	return dao.save("Busi.deltEvaluIpmNote", paramMap);
    }
    
    // 평가단계 종합의견 내용 등록
    public int regiEvaluFinalOpinionNote(Map paramMap) throws Exception {
    	return dao.save("Busi.regiEvaluFinalOpinionNote", paramMap);
    }
    
    // 평가단계 종합의견 내용 삭제
    public int deltEvaluFinalOpinionNote(Map paramMap) throws Exception {
    	return dao.save("Busi.deltEvaluFinalOpinionNote", paramMap);
    }
    
    // 평가단계 개선사항 내용 등록
    public int regiEvaluFinalIpmNote(Map paramMap) throws Exception {
    	return dao.save("Busi.regiEvaluFinalIpmNote", paramMap);
    }
    
    // 평가단계 개선사항 내용 삭제
    public int deltEvaluFinalIpmNote(Map paramMap) throws Exception {
    	return dao.save("Busi.deltEvaluFinalIpmNote", paramMap);
    }
    
    // 평가종료 승인
    public int updtEvaluFinalApv(Map paramMap) throws Exception {
    	return dao.save("Busi.updtEvaluFinalApv", paramMap);
    }
    
    public Map viewAllEvaluInfo(Map paramMap) throws Exception {
    	
    	Map rtnMap = new HashMap();
    	
    	Map stgMap = viewEvaluStgMgmt(paramMap);
	    	
	    //평가결과 입력
		int fndCnt =   Integer.parseInt( String.valueOf(stgMap.get("fndCnt")) );
		
		System.out.println("CommUtils.empty(fndCnt) " + fndCnt);
	
		//정상
		paramMap.put("evaluStage", stgMap.get("evaluStage"));
    	
    	List indiList;	
    	List commList;
    	
    	indiList = dao.list("Busi.viewEvaluIndiMgmt", paramMap);
    	
    	String arrIndi = "";
    	
    	for (int i = 0; i < indiList.size(); i++) {
    		Map map = (Map)indiList.get(i);
    		String strIndi = (String)map.get("evaluIndicatCd");
    		
    		arrIndi = ( arrIndi.equals("") ) ? strIndi : arrIndi + "," + strIndi;
		}
    	
    	commList = dao.list("Busi.viewEvaluCommMgmt", paramMap);
    	
    	rtnMap.put("stgMap", stgMap);
    	rtnMap.put("indiList", indiList);
    	rtnMap.put("arrIndi", arrIndi);
    	rtnMap.put("commList", commList);
		
		return rtnMap;
	}
	
    
	public Map viewEvaluStgMgmt(Map paramMap) throws Exception {
    	return (Map)dao.view("Busi.viewEvaluStgMgmt", paramMap);
    }

	// 지자체 사업개요 수정
	public int updtEvaluHist(Map paramMap) {
		return dao.save("Busi.updtEvaluHist", paramMap);
	}

	// 평가위원 파일 다운로드 기록
	public int updtPrgrGubun(Map params) {
		return dao.save("Busi.updtPrgrGubun", params);
		
	}
    
}
