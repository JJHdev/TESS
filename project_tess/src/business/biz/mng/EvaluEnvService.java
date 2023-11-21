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
 * Program Name    : EvaluEnvService
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
public class EvaluEnvService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
  
    /************************************************/
    /******************* 평가환경설정 *******************/
    /************************************************/
    
    
    
    // 평가지표 조회
    public List listEvaluEnvIndex(Map paramMap) {
		return  dao.list("MngEnv.listEvaluEnvIndexCodeTree", paramMap);
	}
    
    // 평가지표 등록
    public String regiEvaluEnvIndex(Map paramMap) throws Exception {
    	return (String)dao.insert("MngEnv.regiEvaluEnvIndex", paramMap);
    }
    
    // 평가지표 수정
    public int updtEvaluEnvIndex(Map paramMap) throws Exception {
    	return dao.save("MngEnv.updtEvaluEnvIndex", paramMap);
    }
    
    // 평가지표 삭제
    public int deltEvaluEnvIndex(Map paramMap) throws Exception {
    	return dao.save("MngEnv.deltEvaluEnvIndex", paramMap);
    }
    
    //################################################################
    //SUNDOSOFT 평가사업관리 > 평가사업등록
    //################################################################
    
    // 평가단계 등록
    public int regiEvaluEnvStage(Map paramMap) throws Exception {
    	return (Integer) dao.update("MngEnv.regiEvaluEnvStage", paramMap);
    }

    // 평가단계 수정
    public int updtEvaluEnvStage(Map paramMap) throws Exception {
    	return dao.save("MngEnv.updtEvaluEnvStage", paramMap);
    }
    
    // 평가단계 삭제
    public int deltEvaluEnvStage(Map paramMap) throws Exception {
    	return dao.save("MngEnv.deltEvaluEnvStage", paramMap);
    }
    
    
    // 평가 지표 관련
    
    
    // 참조파일 등록
    public int saveEvaluEnvSampleFile(Map paramMap) throws Exception {
    	return (Integer) dao.update("MngEnv.saveEvaluEnvSampleFile", paramMap);
    }
    
    
}
