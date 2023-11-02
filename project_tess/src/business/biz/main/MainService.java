package business.biz.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.MailManager;
import commf.dao.CommonDAOImpl;
import commf.message.Message;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.properties.ApplicationProperty;


/**
 * Program Name    : MainService
 * Description     : Main Service
 * Programmer Name : SYM
 * Creation Date   : 2014-11-18
 * Used Table(주요) :
 * 
 * @author SYM
 *
 */
@Service
public class MainService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    
    /**
     * 평가단계별 통계현황
     * @param paramMap
     * @return
     */
    public List listEvaluMainStat(Map paramMap) throws Exception {
    	
        return (List)dao.list("EvaluMgmt.listEvaluMainStat", paramMap);
    }
    
    /**
     * 평가단계별 통계현황02
     * @param paramMap
     * @return
     */
    public List listEvaluMainStat02(Map paramMap) throws Exception {
    	
        return (List)dao.list("EvaluMgmt.listEvaluMainStat02", paramMap);
    }
    /**
    * 평가완료 사업 조회
    * @param paramMap
    * @return
    */
    	public List listEvaluFinalBusi(Map paramMap) throws Exception {
    	
    	return (List)dao.list("EvaluMgmt.listEvaluFinalBusi", paramMap);
    }
	/**
	 * 평가위원 분야별 통계
	 * @param paramMap
	 * @return
	 */
	public List listEvaluCommitStat(Map paramMap) throws Exception {
		
		return (List)dao.list("EvaluMgmt.listEvaluCommitStat", paramMap);
	}
    
}