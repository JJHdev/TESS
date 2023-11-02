package business.sys.program;

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

@Service
@SuppressWarnings({"rawtypes", "unchecked", "static-access"})
public class ProgService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

	public Map getProgInfo(Map reqMap) {
		// 2014.10.15 path info 처리
		Map progInfo = (HashMap)dao.view("Prog.getProgInfo", reqMap);
		List pathList	= null;

		if (progInfo != null) {
			String[] menuPath	= CommUtils.split((String)progInfo.get("menuPath"), ",");
			String[] urlPath	= CommUtils.split((String)progInfo.get("urlPath"), ",");

			if (menuPath != null) {
				pathList	= new ArrayList();
				for (int i = 0; i < menuPath.length; i++) {
					Map pathmap = new HashMap();
						pathmap.put("menuPath", menuPath[i]);
						pathmap.put("urlPath", urlPath[i]);

					pathList.add(pathmap);
				}
			}
			progInfo.put("pathList", pathList);
		}

		return progInfo;
	}

	// Program List Search
	public List listProg(Map reqMap) throws Exception {
		List list = null;
		list = dao.list("Prog.listProg", reqMap);
		return list;
	}

	// Program Save(Registration, Update)
	public String saveProg(Map reqMap) throws Exception {
		String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
		String msg = "";
		int cnt = 0;

		if (CommUtils.nvlTrim((String) reqMap.get("progId")).equals("")) {
			msg = "Prog Id " + message.getMessage("common.required.msg");
		} else {

			// Insert
			if (oper.equals("add")) {
				boolean isDup = (Boolean) dao.view("Prog.getProgCnt", reqMap);
				if (!isDup) {
					cnt = dao.update("Prog.regiProg", reqMap);
				} else {
					msg = message.getMessage("prompt.duplicate");
				}
				// Update
			} else if (oper.equals("edit")) {
				cnt = dao.update("Prog.updtProg", reqMap);

				// delete (multi)
			} else if (oper.equals("del")) {
				// Delete
				if (reqMap.get("jqGridDatas") != null) {
					List list = (ArrayList) reqMap.get("jqGridDatas");

					if (list != null) {
						String[] arrProgId = new String[list.size()];
						for (int i = 0; i < list.size(); i++) {
							arrProgId[i] = (String) ((HashMap) list.get(i)).get("progId");
						}
						reqMap.put("arrProgId", arrProgId);

						// reference table delete
						dao.update("RoleProg.deltRoleByProgFromProg", reqMap);

						cnt = dao.update("Prog.deltProg", reqMap);
					}

				} else {
					msg = message.getMessage("errors.notdeldata");
				}
			}

			if (cnt == 0 && msg.equals("")) {
				msg = message.getMessage("error.comm.fail");
			}
		}

		return msg;
	}

	/**
	 * Combo Code List Search
	 */
    public List listComboMenu(Map reqMap) throws Exception {
		return dao.list("Menu.listComboMenu", reqMap);
	}

}
