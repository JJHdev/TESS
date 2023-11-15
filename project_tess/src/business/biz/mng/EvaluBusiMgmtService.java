package business.biz.mng;

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
 * Program Name    : EvaluBusiMgmtService
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
public class EvaluBusiMgmtService extends BaseService {
	
	//----------------------------
    // 첨부파일관련
    //----------------------------

	public static final String FL_DOCU_TYPE_AREA = "AREA";    // 사업대상지 정보
	
	// 사업대상지 정보 첨부파일의 attah_type 구분
    public static final String FL_AREA_ATTH_TYPE_01 = "A01";  // 조감도
    public static final String FL_AREA_ATTH_TYPE_02 = "A02";  // 위치도(교통현황도)
    public static final String FL_AREA_ATTH_TYPE_03 = "A03";  // 토지이용계획도
    public static final String FL_AREA_ATTH_TYPE_04 = "A04";  // 시설배치도
    public static final String FL_AREA_ATTH_TYPE_05 = "A05";  // 위성사진(개발현황도)
    public static final String FL_AREA_ATTH_TYPE_06 = "A06";  // 현장사진
    
    
    @Autowired
    private CommonDAOImpl dao;
    
    
    /************************************************/
    /******************* 평가사업관리 *******************/
    /************************************************/
    
    // 평가사업 리스트 조회.
    /* 23.11.07 LHB 구버전 평가 목록 조회 메소드 주석처리
    public PaginatedArrayList listEvaluBusiMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("MngEvalu.listEvaluBusiMgmt", paramMap, currPage, pageSize);
    }
    */
    
    // 평가사업 상세정보
    public Map viewEvaluBusiInfo(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluBusiInfo", paramMap);
    }
    
    // 평가이력 조회
    public List listEvaluBusiHist(Map paramMap) throws Exception {
    	return dao.list("MngEvalu.listEvaluBusiHist", paramMap);
    }
    
    // 평가사업 등록
    public String regiEvaluBusiStage(Map paramMap) throws Exception {
    	return (String)dao.insert("MngEvalu.regiEvaluBusiStage", paramMap);
    }
    
    // 평가단계 중복 체크
    public int checkEvaluStage(Map paramMap) throws Exception {
    	return (Integer)dao.view("MngEvalu.checkEvaluStage", paramMap);
    }
    
    // 평가단계삭제
    public int deltEvaluStage(Map paramMap) throws Exception {
    	return dao.save("MngEvalu.deltEvaluStage", paramMap);
    }
    
    // 평가 정보 조회
    public Map viewEvaluStageInfo(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluStageInfo", paramMap);
    }
    
    // 평가완료 정보 조회
    public Map viewEvaluEndStageInfo(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluEndStageInfo", paramMap);
    }
    
    // 평가 파일 등록
    public String regiEvaluFile(Map paramMap) throws Exception {
    	return (String)dao.insert("MngEvalu.regiEvaluFile", paramMap);
    }
    
    // 평가 파일 > 평가지침서 조회
    public Map viewEvaluAFile(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluAFile", paramMap);
    }
    
    // 평가 파일 > 서면검토서 조회
    public Map viewEvaluBFile(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluBFile", paramMap);
    }
    
    // 평가 파일 > 평가의견서 조회
    public Map viewEvaluCFile(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.viewEvaluCFile", paramMap);
    }
    
    // 평가지침 상태 변경
    public int updtEvaluGuideState(Map paramMap) throws Exception {
    	return dao.save("MngEvalu.updtEvaluGuideState", paramMap);
    }
    
    // 평가지침 평가진행이력 체크
    public Map checkEvaluStageHist(Map paramMap) throws Exception {
    	return (Map)dao.view("MngEvalu.checkEvaluStageHist", paramMap);
    }
    
    // 평가위원 조회
    public List listEvaluCommit(Map paramMap) throws Exception {
    	return dao.list("MngEvalu.listEvaluCommit", paramMap);
    }
    
    // 평가위원 등록
    public String regiEvaluCommit(Map paramMap) throws Exception {
    	return (String)dao.insert("MngEvalu.regiEvaluCommit", paramMap);
    }
    
    // 평가위원 삭제
    public int deltEvaluCommit(Map paramMap) throws Exception {
    	return dao.save("MngEvalu.deltEvaluCommit", paramMap);
    }
    
    // 실행계획 상태 변경
    public int updtEvaluPlanState(Map paramMap) throws Exception {
    	return dao.save("MngEvalu.updtEvaluPlanState", paramMap);
    }
    
    // 평가일정 조회
    public List listEvaluDetailPlan(Map paramMap) throws Exception {
    	return dao.list("MngEvalu.listEvaluDetailPlan", paramMap);
    }
    
    // 평가일정 등록
    public String regiEvaluDetailPlan(Map paramMap) throws Exception {
    	return (String)dao.insert("MngEvalu.regiEvaluDetailPlan", paramMap);
    }
    
    // 평가일정 삭제
    public int deltEvaluDetailPlan(Map paramMap) throws Exception {
    	return dao.save("MngEvalu.deltEvaluDetailPlan", paramMap);
    }
    
    // TDSS - 사업 정보 조회
    public Map viewTodeMgmtMast(Map paramMap) throws Exception {
        return (Map)dao.view("TDSS.viewTodeMgmtMast", paramMap);
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 파일 관련
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * 첨부파일 리스트 조회 (docuType별로 조회)
     * @param paramMap
     * @return
     * @throws Exception
     */
    /*public List listTodeFile(Map paramMap) throws Exception {
        List<Map> list = todeFileService.listTodeFile(paramMap);
        
        return list;
    }*/
    
    public List listTodeFile(Map paramMap) throws Exception {
    	
    	List<Map> list = (List)dao.list("TDSS.listTodeFile", paramMap);
    	
        return list;
    }
    
    //################################################################
    //SUNDOSOFT 평가사업관리 > 평가사업등록
    //################################################################
    
    // 평가사업 목록
    public PaginatedArrayList listEvaluBusiMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("MngEvalu.listEvaluBusiMgmt", paramMap, currPage, pageSize);
    }
    
    // 평가사업 상세
    public Map viewEvaluBusiMgmt(Map paramMap) throws Exception {
        return (Map) dao.view("MngEvalu.viewEvaluBusiMgmt", paramMap);
    }
    
    // 평가사업 상세 (평가이력 일련번호로 조회)
    public Map viewEvaluBusiMgmtByHist(Map paramMap) throws Exception {
        return (Map) dao.view("MngEvalu.viewEvaluBusiMgmtByHist", paramMap);
    }
    
    // 평가사업 등록
    public int regiEvaluBusiMgmt(Map paramMap) throws Exception {
    	int result = (Integer) dao.update("MngEvalu.regiEvaluBusiMgmt", paramMap);
    	return result;
    }
    
    // 평가사업 이력 존재 여부 조회
    public int chckEvaluBusiMgmtHist(Map paramMap) throws Exception {
    	return (Integer) dao.view("MngEvalu.chckEvaluBusiMgmtHist", paramMap);
    }
    
    // 평가사업 이력 목록
    public List listEvaluBusiMgmtHist(Map paramMap) throws Exception {
    	return dao.list("MngEvalu.listEvaluBusiMgmtHist", paramMap);
    }
    
    // 평가사업 이력 상세
    public Map viewEvaluBusiMgmtHist(Map paramMap) throws Exception {
    	return (Map) dao.view("MngEvalu.viewEvaluBusiMgmtHist", paramMap);
    }
    
    // 평가사업 이력 등록
    public int regiEvaluBusiMgmtHist(Map paramMap) throws Exception {
    	// 사업코드 채번
    	String evaluHistNo = (String) dao.view("MngEvalu.getEvaluBusiMgmtHistNo", paramMap);
    	paramMap.put("evaluHistNo", evaluHistNo);
    	
    	
    	int result = (Integer) dao.update("MngEvalu.regiEvaluBusiMgmtHist", paramMap);
    	
    	if (result > 0) {
    		// 로그 등록
    		dao.update("MngEvalu.regiEvaluBusiMgmtHistLog", paramMap);
    	}
    	
    	return result;
    }
    
    // 평가사업 이력 로그 목록
    public List listEvaluBusiMgmtHistLog(Map paramMap) throws Exception {
    	return dao.list("MngEvalu.listEvaluBusiMgmtHistLog", paramMap);
    }
    
    // 평가사업 이력 로그 기록
    public int regiEvaluBusiMgmtHistLog(Map paramMap) throws Exception {
    	int result = (Integer) dao.update("MngEvalu.regiEvaluBusiMgmtHistLog", paramMap);
    	return result;
    }
    
    // 사업관리 > 개발사업 개요 수정
    public int saveEvaluBusiMgmtGuide(Map paramMap) throws Exception {
    	// TODO 사업유형은 orgHist의 값을 그대로 사용해야 함
    	/*
    	paramMap.put("busiMbyAddr1",	orgHist.get("busiMbyAddr1"));
    	paramMap.put("busiMbyAddr2",	orgHist.get("busiMbyAddr2"));
    	paramMap.put("busiTypeLevel1",	orgHist.get("busiTypeLevel1"));
    	paramMap.put("busiTypeLevel2",	orgHist.get("busiTypeLevel2"));
    	paramMap.put("busiCate",		orgHist.get("busiCate"));
    	*/
    	
    	int result = (Integer) dao.update("MngEvalu.saveEvaluBusiMgmtGuide", paramMap);
    	if (result > 0) {
    		// 로그 등록
    		dao.update("MngEvalu.regiEvaluBusiMgmtHistLog", paramMap);
    	}
    	return result;
    }
}