package business.biz.evalu;

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
 * Program Name    : EvaluMgmtService
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
public class EvaluIndicatService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    @Autowired
    private  EvaluCommService evaluCommService;
    
    @Autowired
    private EvaluFileService evaluFileService;

	public List listEvaluIndicatMgmt(Map paramMap) {
		return  dao.list("EvaluIndicat.listEvaluIndicatCodeTree", paramMap);
	}
	
	public String saveEvaluIndicatMgmt(Map paramMap) {

        String oper = CommUtils.nvlTrim((String) paramMap.get("oper"));
        String msg = "";
        int cnt = 0;

        if (oper.equals("del")) {
            // Delete
            if (paramMap.get("jqGridDatas") != null) {
                List list = (ArrayList) paramMap.get("jqGridDatas");

                String keyParentCode = "";
                
                // [20140912 LCS] 다중선택했을 때 가능한 부분임. treeview는 일단 다중선택이 되지 않기 때문에 일단 여기로 들어올수 없음.
                if (list != null && !list.isEmpty() ) {
                    String[] arrCode = new String[list.size()];
                    for (int i = 0; i < list.size(); i++) {
                        if (i == 0) keyParentCode = (String)((HashMap)list.get(i)).get("parentCode");
                        arrCode[i] = (String) ((HashMap) list.get(i)).get("code");
                    }

                    paramMap.put("parentCode", keyParentCode);
                    paramMap.put("arrCode", arrCode);

                    cnt = dao.update("EvaluIndicat.deltCode", paramMap);
                }
                else {
                    String parentCode = (String)paramMap.get("parentCode");
                    String code     = (String)paramMap.get("code");
                    
                    // code와 parentCode가 존재할 때 처리
                    if(CommUtils.empty(parentCode) == false && CommUtils.empty(code) == false) {
                        
                        // 코드타입일 때 
                        if("NONE".equals(parentCode)){
                            
                            Map typeMap = new HashMap();
                            typeMap.put("parentCode", code);
                            
                            // 해당 코드타입에 속하는 모든 코드 삭제
                            dao.update("EvaluIndicat.deltCode", typeMap);
                            // 해당 코드타입 삭제
                            cnt = dao.update("EvaluIndicat.deltCodeType", typeMap);
                        }
                        // 코드일 때 삭제
                        else {
                            cnt = dao.update("EvaluIndicat.deltCode", paramMap);
                        }
                    }
                }

            } else {
                msg = message.getMessage("errors.notdeldata");
            }
        } else {
            if (CommUtils.nvlTrim((String)paramMap.get("parentCode")).equals("")
                    || CommUtils.nvlTrim((String)paramMap.get("code")).equals("")) {
                msg = "Code Type or Code " + message.getMessage("common.required.msg");
            } else {
                // Insert
                if (oper.equals("add")) {
                    boolean isDup = (Boolean) dao.view("EvaluIndicat.getCodeCnt",paramMap);
                    if (!isDup) {
                        cnt = dao.update("EvaluIndicat.regiCode", paramMap);
                    } else {
                        msg = message.getMessage("prompt.duplicate");
                    }
                }
                // Update
                if (oper.equals("edit")) {
                    cnt = dao.update("EvaluIndicat.updtCode", paramMap);
                }
            }
        }

        if (cnt == 0 && msg.equals("")) {
            msg = message.getMessage("error.comm.fail");
        }



        return msg;
	}
    
}
