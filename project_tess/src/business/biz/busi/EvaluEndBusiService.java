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
public class EvaluEndBusiService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    
    /************************************************/
    /******************* 평가사업관리 *******************/
    /************************************************/
    
    
    // 평가완료사업 리스트 조회.
    public PaginatedArrayList listEvaluEndBusi(Map paramMap, int currPage, int pageSize) throws Exception {
    	return dao.pageList("Busi.listEvaluEndBusi", paramMap, currPage, pageSize);
    }
    
    // 평가위원별 평가정보
    public List listEvaluCommitInfo(Map paramMap) throws Exception {
        return dao.list("Busi.listEvaluCommitInfo", paramMap);
    }
    
    // 평가완료사업 상세 조회
    public Map viewEvaluEndBusiInfo(Map paramMap) throws Exception {
    	return (Map)dao.view("Busi.viewEvaluEndBusiInfo", paramMap);
    }

    
    // 사업 조회
	public Map viewTodeEndMast(Map paramMap) {
		return (Map)dao.view("Busi.viewTodeEndMast", paramMap);
	}

	// 평가사업 조회
	public Map viewEvaluStageEndInfo(Map paramMap) {
		return (Map)dao.view("Busi.viewEvaluStageEndInfo", paramMap);
	}

	// 시스템 파일 목록 조회
	public List getSysRrencFileProgList(Map paramMap) {
		return dao.list("Busi.getSysRrencFileProgList", paramMap);
	}

	// 시스템 파일 유저 업로드 관련 목록 조회
	public List getSysUldFileProgEndList(Map paramMap) {
		return dao.list("Busi.getsysUldFileProgList", paramMap);
	}

	// 유저 업로드 목록 조회
	public List getupFileProgEndList(Map paramMap) {
		return dao.list("Busi.getupFileProgList", paramMap);
	}

}
