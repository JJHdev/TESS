package business.sys.role;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
@SuppressWarnings({"rawtypes","unchecked", "static-access"})
public class RoleProgService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;


	public List listNotRoleByProg(Map reqMap) {
		List list = dao.list("RoleProg.listNotRoleByProg", reqMap);
		return list;
	}

	public List listRoleByProg(Map reqMap) {
		List list = dao.list("RoleProg.listRoleByProg", reqMap);
		return list;
	}

	// SAVE : Role By Program
	public String saveRoleByProg(Map reqMap) throws Exception {
		String msg = "";
		int cnt = 0;

		String operMode	= CommUtils.nvlTrim((String)reqMap.get("operMode"));

		if (operMode.equalsIgnoreCase("RIGHT")) {
			if (reqMap.get("jqGridDatas") != null) {
				List list = (ArrayList) reqMap.get("jqGridDatas");

				if (list != null) {
					Map saveMap = null;
					for (Iterator iterator = list.iterator(); iterator.hasNext();) {
						saveMap = (HashMap)iterator.next();
						saveMap.put("roleId", (String)reqMap.get("roleId"));
						saveMap.putAll(reqMap);

						// Insert
						cnt += dao.update("RoleProg.regiRoleByProg", saveMap);
						saveMap.clear();
					}
				}

			} else {
				msg = message.getMessage("errors.notprocdata");
			}
		}

		if (operMode.equalsIgnoreCase("LEFT")) {
			if (reqMap.get("jqGridDatas") != null) {
				List list = (ArrayList) reqMap.get("jqGridDatas");

				if (list != null) {
					Map saveMap = null;
					for (Iterator iterator = list.iterator(); iterator.hasNext();) {
						saveMap = (HashMap)iterator.next();
						saveMap.putAll(reqMap);

						// Delete
						cnt += dao.update("RoleProg.deltRoleByProg", saveMap);
						saveMap.clear();
					}
				}

			} else {
				msg = message.getMessage("errors.notprocdata");
			}
		}


		if (cnt == 0 && msg.equals("")) {
			msg = message.getMessage("error.comm.fail");
		}

		return msg;
	}
	
}
