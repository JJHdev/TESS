package business.sys.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;

@Service
@SuppressWarnings({"rawtypes","unchecked", "static-access"})
public class CodeService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

	public List listCodeType(Map reqMap) {
		List list = null;
		list = dao.list("Code.listCodeType", reqMap);
		return list;
	}

	public PaginatedArrayList listCodeType(Map reqMap, int currPage,
			int pageSize) {
		PaginatedArrayList list = dao.pageList("Code.listCodeType", reqMap, currPage, pageSize);
		return list;
	}

	public List listCode(Map reqMap) {
		List list = null;
		list = dao.list("Code.listCode", reqMap);
		return list;
	}

	public PaginatedArrayList listCode(Map reqMap, int currPage, int pageSize) {
		PaginatedArrayList list = dao.pageList("Code.listCode", reqMap, currPage, pageSize);
		return list;
	}

	// SAVE : Code Type
	public String saveCodeType(Map reqMap) throws Exception {
		String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
		String msg = "";
		int cnt = 0;

		if (CommUtils.nvlTrim((String)reqMap.get("parentCode")).equals("")) {
			msg = "Code Type " + message.getMessage("common.required.msg");
		} else {
			// Insert
			if (oper.equals("add")) {
				boolean isDup = (Boolean) dao.view("Code.getCodeTypeCnt", reqMap);
				if (!isDup) {
					cnt = dao.update("Code.regiCodeType", reqMap);
				} else {
					msg = message.getMessage("prompt.duplicate");
				}
				// Update
			} else if (oper.equals("edit")) {
				cnt = dao.update("Code.updtCodeType", reqMap);

				// delete (single)
			} else if (oper.equals("del")) {
				// reference table delete
				dao.update("Code.deltCode", reqMap);

				cnt = dao.update("Code.deltCodeType", reqMap);

			}

			if (cnt == 0 && msg.equals("")) {
				msg = message.getMessage("error.comm.fail");
			}
		}


		return msg;
	}

	// SAVE : Code
	public String saveCode(Map reqMap) {
		String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
		String msg = "";
		int cnt = 0;

		if (oper.equals("del")) {
			// Delete
			if (reqMap.get("jqGridDatas") != null) {
				List list = (ArrayList) reqMap.get("jqGridDatas");

				String keyParentCode = "";

				if (list != null) {
					String[] arrCode = new String[list.size()];
					for (int i = 0; i < list.size(); i++) {
						if (i == 0) keyParentCode = (String)((HashMap)list.get(i)).get("parentCode");
						arrCode[i] = (String) ((HashMap) list.get(i)).get("code");
					}

					reqMap.put("parentCode", keyParentCode);
					reqMap.put("arrCode", arrCode);

					cnt = dao.update("Code.deltCode", reqMap);
				}

			} else {
				msg = message.getMessage("errors.notdeldata");
			}
		} else {
			if (CommUtils.nvlTrim((String)reqMap.get("parentCode")).equals("")
					|| CommUtils.nvlTrim((String)reqMap.get("code")).equals("")) {
				msg = "Code Type or Code " + message.getMessage("common.required.msg");
			} else {
				// Insert
				if (oper.equals("add")) {
					boolean isDup = (Boolean) dao.view("Code.getCodeCnt",reqMap);
					if (!isDup) {
						cnt = dao.update("Code.regiCode", reqMap);
					} else {
						msg = message.getMessage("prompt.duplicate");
					}
				}
				// Update
				if (oper.equals("edit")) {
					cnt = dao.update("Code.updtCode", reqMap);
				}
			}
		}

		if (cnt == 0 && msg.equals("")) {
			msg = message.getMessage("error.comm.fail");
		}



		return msg;
	}
	
	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// [20140904 LCS] Tree view를 추가 관련
	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	/**
	 * Tree Grid를 위한 Code 리스트 조회
	 * @param reqMap
	 * @return
	 */
	public List listCodeTree(Map reqMap) {
        List list = dao.list("Code.listCodeTree", reqMap);
        return list;
    }

	
	// SAVE : Code Tree view
    public String saveCodeTree(Map reqMap) {
        String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
        String msg = "";
        int cnt = 0;

        if (oper.equals("del")) {
            // Delete
            if (reqMap.get("jqGridDatas") != null) {
                List list = (ArrayList) reqMap.get("jqGridDatas");

                String keyParentCode = "";
                
                // [20140912 LCS] 다중선택했을 때 가능한 부분임. treeview는 일단 다중선택이 되지 않기 때문에 일단 여기로 들어올수 없음.
                if (list != null && !list.isEmpty() ) {
                    String[] arrCode = new String[list.size()];
                    for (int i = 0; i < list.size(); i++) {
                        if (i == 0) keyParentCode = (String)((HashMap)list.get(i)).get("parentCode");
                        arrCode[i] = (String) ((HashMap) list.get(i)).get("code");
                    }

                    reqMap.put("parentCode", keyParentCode);
                    reqMap.put("arrCode", arrCode);

                    cnt = dao.update("Code.deltCode", reqMap);
                }
                else {
                    String parentCode = (String)reqMap.get("parentCode");
                    String code     = (String)reqMap.get("code");
                    
                    // code와 parentCode가 존재할 때 처리
                    if(CommUtils.empty(parentCode) == false && CommUtils.empty(code) == false) {
                        
                        // 코드타입일 때 
                        if("NONE".equals(parentCode)){
                            
                            Map typeMap = new HashMap();
                            typeMap.put("parentCode", code);
                            
                            // 해당 코드타입에 속하는 모든 코드 삭제
                            dao.update("Code.deltCode", typeMap);
                            // 해당 코드타입 삭제
                            cnt = dao.update("Code.deltCodeType", typeMap);
                        }
                        // 코드일 때 삭제
                        else {
                            cnt = dao.update("Code.deltCode", reqMap);
                        }
                    }
                }

            } else {
                msg = message.getMessage("errors.notdeldata");
            }
        } else {
            if (CommUtils.nvlTrim((String)reqMap.get("parentCode")).equals("")
                    || CommUtils.nvlTrim((String)reqMap.get("code")).equals("")) {
                msg = "Code Type or Code " + message.getMessage("common.required.msg");
            } else {
                // Insert
                if (oper.equals("add")) {
                    boolean isDup = (Boolean) dao.view("Code.getCodeCnt",reqMap);
                    if (!isDup) {
                        cnt = dao.update("Code.regiCode", reqMap);
                    } else {
                        msg = message.getMessage("prompt.duplicate");
                    }
                }
                // Update
                if (oper.equals("edit")) {
                    cnt = dao.update("Code.updtCode", reqMap);
                }
            }
        }

        if (cnt == 0 && msg.equals("")) {
            msg = message.getMessage("error.comm.fail");
        }



        return msg;
    }
}
