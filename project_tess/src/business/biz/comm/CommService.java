package business.biz.comm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;


@Service
@SuppressWarnings({"rawtypes"})
public class CommService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

	/**
	 * Combo Code List Search
	 */
    public List listComboCode(Map reqMap) throws Exception {
    	
    	String parentCode = (String)reqMap.get("parentCode");
    	List list = null;
    	
		//지자체조회 경우
		if ("COMM.CITYAUTH".equals(parentCode)) {
			
			Map param = new HashMap();
			if (reqMap.containsKey("addCol1"))
				param.put("parentCode", reqMap.get("addCol1"));
			else
				param.put("parentCode", "NONE");
			
			return  dao.list("Comm.listComboCityAuth", param);
		}
		
		else{ 	
		    // [2014.11.25 LCS] listComboCode는 맞지 않아서 변경.
//			return dao.list("Comm.listComboCode", reqMap);
			String mode = (String)reqMap.get("mode");
			
			if("evaluCd".equals(mode)){
				return dao.list("Comm.listEvaluCode", reqMap);
			}else{
				return dao.list("Comm.listCode", reqMap);
			}
		}
	}

    /**
     * Code List Search
     */
    public List listCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listCode", reqMap);
    }
    
    /**
     * Code List Search
     */
    public List listEvaluCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listEvaluCode", reqMap);
    }
    
    /**
     * Code List Search
     */
    public Map listSelEvaluCode(Map reqMap) throws Exception {
    	return (Map) dao.view("Comm.listSelEvaluCode", reqMap);
    }

    /**
     * Code List Search
     */
    public List listSelEvaluEtcCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listSelEvaluEtcCode", reqMap);
    }

    /**
     * CENT Code List Search
     */
    public List listSelEvaluCentCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listSelEvaluCentCode", reqMap);
    }

    /**
     * PROG Code List Search
     */
    public List listSelEvaluProgCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listSelEvaluProgCode", reqMap);
    }

    /**
     * PREV Code List Search
     */
    public List listSelEvaluPrevCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listSelEvaluPrevCode", reqMap);
    }
    
    /**
     * Code List Search
     * @param reqMap
     * @return
     * @throws Exception
     */
    public List listEvaluItemSpanCode(Map reqMap) throws Exception {
    	return dao.list("Comm.listEvaluItemSpanCode", reqMap);
    }

    //CT410 값 불러오기
    public Map getCT410 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getCT410", paramMap);
    	return map;
    }
    //CT310 값 불러오기
    public Map getCT310 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getCT310", paramMap);
    	return map;
    }
    //CT210 값 불러오기
    public Map getCT210 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getCT210", paramMap);
    	return map;
    }
    //CT220 값 불러오기
    public Map getCT220 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getCT220", paramMap);
    	return map;
    }
    //CT230 값 불러오기
    public Map getCT230 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getCT230", paramMap);
    	return map;
    }
    //CT110 값 불러오기
    public Map getCT110 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getCT110", paramMap);
    	return map;
    }
    //PR310 값 불러오기
    public Map getPR310 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPR310", paramMap);
    	return map;
    }
    //PR220 값 불러오기
    public Map getPR220 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPR220", paramMap);
    	return map;
    }
    //PR210 값 불러오기
    public Map getPR210 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPR210", paramMap);
    	return map;
    }
    //PR110 값 불러오기
    public Map getPR110 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPR110", paramMap);
    	return map;
    }

    //PV 값 불러오기
    public Map getPv (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPv", paramMap);
    	return map;
    }
    //PV file 불러오기
    public Map getPvFile (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPvFile", paramMap);
    	return map;
    }
	
    //PV211 값 불러오기
    public Map getPV211 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV211", paramMap);
    	return map;
    }
    //PV212 값 불러오기
    public Map getPV212 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV212", paramMap);
    	return map;
    }
    //PV213 값 불러오기
    public Map getPV213 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV213", paramMap);
    	return map;
    }
    //PV221 값 불러오기
    public Map getPV221 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV221", paramMap);
    	return map;
    }
    //PV222 값 불러오기
    public Map getPV222 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV222", paramMap);
    	return map;
    }
    //PV223 값 불러오기
    public Map getPV223 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV223", paramMap);
    	return map;
    }
    //PV311 값 불러오기
    public Map getPV311 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV311", paramMap);
    	return map;
    }
    //PV312 값 불러오기
    public Map getPV312 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV312", paramMap);
    	return map;
    }
    //PV321 값 불러오기
    public Map getPV321 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV321", paramMap);
    	return map;
    }
    //PV322 값 불러오기
    public Map getPV322 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV322", paramMap);
    	return map;
    }
    //PV331 값 불러오기
    public Map getPV331 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV331", paramMap);
    	return map;
    }
    //PV332 값 불러오기
    public Map getPV332 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV332", paramMap);
    	return map;
    }
    //PV341 값 불러오기
    public Map getPV341 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV341", paramMap);
    	return map;
    }
    //PV342 값 불러오기
    public Map getPV342 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV342", paramMap);
    	return map;
    }
    //PV411 값 불러오기
    public Map getPV411 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV411", paramMap);
    	return map;
    }
    //PV412 값 불러오기
    public Map getPV412 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV412", paramMap);
    	return map;
    }
    //PV413 값 불러오기
    public Map getPV413 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV413", paramMap);
    	return map;
    }
    //PV421 값 불러오기
    public Map getPV421 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV421", paramMap);
    	return map;
    }
    //PV422 값 불러오기
    public Map getPV422 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV422", paramMap);
    	return map;
    }
    //PV423 값 불러오기
    public Map getPV423 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPV423", paramMap);
    	return map;
    }
    //PV710 진단평가표 값 불러오기
    public Map getPv710 (Map paramMap) throws Exception {
    	Map map = new HashMap();
    	map = (Map) dao.view("Comm.getPv710", paramMap);
    	return map;
    }
    
    //################################################################
    //SUNDOSOFT 공통코드
    //################################################################
    
    /**
     * 법정동 코드 조회
     */
    public List listBjdCode(Map paramMap) throws Exception {
    	return dao.list("Comm.listBjd", paramMap);
    }
	
}
