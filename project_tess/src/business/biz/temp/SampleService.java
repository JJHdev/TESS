package business.biz.temp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;

/**
 * Sample Service Class
 * @author ntarget
 * @since 2011.06.15
 * @version 1.0
 * @see
 *
 * <pre>
 * << Modification Information >>
 *    Date	         Name          	    Desc
 * ----------      --------    ---------------------------
 *  2011.06.15      ntarget      Init.
 *
 * </pre>
 */

@Service
@SuppressWarnings({"rawtypes","static-access","unused","unchecked" })
public class SampleService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

	/**
	 * 사용 가능한  DAO Statement Method
	 * 1. list 		: 리스트 조회시 사용함.
	 * 2. pageList	: 페이징처리용 리스트조회시 사용함.
	 * 3. view		: 단건조회, 상세조회시 사용함.
	 * 4. save 		: INSERT, UPDATE, DELETE 모두 사용가능. Return Integer
	 * 5. insert	: INSERT (Return String : Key 채번 사용함.)
	 * 6. update	: UPDATE
	 * 7. delete	: DELETE
	 * 8. batch		: Batch 등록 사용시.
	 */

    /**
     * 샘플 리스트 조회
     */
	public List listSample(Map paramMap) throws Exception {
		List list = null;

		list = dao.list("Sample.listSample", paramMap);

    	if (list == null) {
            throw processException("exception.NoResult");
    	}

		return list;
	}

    /**
     * 샘플 페이징 리스트 조회
     */
	public PaginatedArrayList listSample(Map paramMap, int currPage, int pageSize) throws Exception {
		return dao.pageList("Sample.listSample", paramMap, currPage, pageSize);
	}

    /**
     * 샘플 상세조회
     */
	public Map viewSample(Map paramMap) throws Exception {
		return (HashMap)dao.view("Sample.viewSample", paramMap);
	}

	/**
	 * 샘플  등록
	 * @param listNewFile
	 */
	public int regiSample(Map paramMap) throws Exception {
		int cnt = 0;
		cnt += dao.save("Sample.regiSample", paramMap);

		// Business Exception TEST
		if (cnt != 0) {
			egovLogger.debug("Exception : "+message.getMessage("exception.invo.CantOverSysMon"));
			throw processException("exception.invo.CantOverSysMon");
    	}

		return cnt;
	}

	/**
	 * 샘플 등록 with 첨부파일
	 * @param listNewFile
	 */
	public String regiSample2(Map paramMap) throws Exception {
		int cnt = 0;
		Map	saveMap	= new HashMap(paramMap);

		String keyNo = (String)dao.insert("Sample.regiSample2", saveMap);


		return keyNo;
	}

	/**
	 * 샘플 수정
	 * @param listNewFile
	 */
	public int updtSample(Map paramMap) {
		return (Integer)dao.update("Sample.updtSample", paramMap);
	}

	/**
	 * 샘플 삭제
	 * @param listNewFile
	 */
	public int deltSample(Map paramMap) {
		return (Integer)dao.update("Sample.deltSample", paramMap);
	}




	/**
	 * ###########################   GRID 샘플   #############################
	 */

	/**
	 * 샘플  GRID 수정, 삭제
	 * @param listNewFile
	 */
	public String saveSampleGrid(Map paramMap) {
    	String oper = CommUtils.nvlTrim((String)paramMap.get("oper"));
		String msg = "";
    	int cnt = 0;

    	List list = new ArrayList();

		// Insert
		if (oper.equals("add")) {
			cnt = dao.update("Sample.regiSample", paramMap);

			egovLogger.info("GRID ----------------- INSERT");

		// Update
		} else if (oper.equals("edit")) {
			cnt = dao.update("Sample.updtSampleGrid", paramMap);

			egovLogger.info("GRID ----------------- UPDATE");


		// delete (multiple)
		} else if (oper.equals("del")) {
			if (paramMap.get("jqGridDatas") != null) {
	    		list = (ArrayList)paramMap.get("jqGridDatas");

	    		if (list != null) {
	    			String[] arrSeq = new String[list.size()];
		    		for (int i = 0; i < list.size(); i++) {
		    			arrSeq[i] = (String)((HashMap)list.get(i)).get("seq");
		    		}

		    		paramMap.put("arrSeq", arrSeq);
	    		}

	    		cnt = dao.update("Sample.deltSampleGrid", paramMap);

	    		list.clear();
			}

			egovLogger.info("GRID ----------------- DELETE");
		}

		if (cnt == 0 && msg.equals("")) {
			msg = message.getMessage("error.comm.fail");
		}

		return msg;
	}

	/**
	 * Sample Multiple  GRID Update
	 * @param listNewFile
	 */
	public String saveMultiSampleGrid(Map paramMap) {
		String oper = CommUtils.nvlTrim((String)paramMap.get("oper"));
		String msg = "";
		int cnt = 0;

		if (paramMap.get("jqGridDatas") != null) {
			List list = (ArrayList) paramMap.get("jqGridDatas");

			Map saveMap = new HashMap();

			if (list != null) {
				for (Iterator iterator = list.iterator(); iterator.hasNext();) {
					saveMap = (HashMap)iterator.next();
					//saveMap.putAll(paramMap);
					saveMap.put("gsUserId", "ntarget3");

					// update
					cnt += dao.update("Sample.updtSampleGrid", saveMap);

					saveMap.clear();
				}
			}
		}

		if (cnt == 0 && msg.equals("")) {
			msg = message.getMessage("error.comm.fail");
		}

		return msg;
	}

	public List listSampleChart(Map paramMap) throws Exception  {
		List list = null;

		list = dao.list("Sample.listSampleChart", paramMap);

    	if (list == null) {
            throw processException("exception.NoResult");
    	}

		return list;
	}

}
