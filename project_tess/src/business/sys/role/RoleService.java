package business.sys.role;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;

@Service
@SuppressWarnings({"rawtypes","unchecked", "static-access"})
public class RoleService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;


	public List listRole(Map reqMap) {
		List list = dao.list("Role.listRole", reqMap);
		return list;
	}

	public List listRoleHeirarchy(Map reqMap) {
		List list = dao.list("Role.listRoleHeirarchy", reqMap);
		return list;
	}

	/**
	 * Combo Code List Search
	 */
    public List listComboRole(Map reqMap) throws Exception {
		return dao.list("Role.listComboRole", reqMap);
	}


	// SAVE : Role
	public String saveRole(Map reqMap) throws Exception {
		String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
		String msg = "";
		int cnt = 0;

		if (CommUtils.nvlTrim((String) reqMap.get("roleId")).equals("")) {
			msg = "Role Id " + message.getMessage("common.required.msg");
		} else {

			// Insert
			if (oper.equals("add")) {
				boolean isDup = (Boolean) dao.view("Role.getRoleCnt", reqMap);
				if (!isDup) {
					cnt = dao.update("Role.regiRole", reqMap);
				} else {
					msg = message.getMessage("prompt.duplicate");
				}
			// Update
			} else if (oper.equals("edit")) {
				cnt = dao.update("Role.updtRole", reqMap);

			// delete (single)
			} else if (oper.equals("del")) {
				reqMap.put("parentRoleId", reqMap.get("roleId"));

				// reference table delete
				dao.update("Role.deltRoleHierarchy", reqMap);
				dao.update("Role.deltRoleUser", reqMap);
				dao.update("RoleMenu.deltRoleByMenuFromMenu", reqMap);
				dao.update("RoleProg.deltRoleByProgFromProg", reqMap);

				cnt = dao.update("Role.deltRole", reqMap);
			}


			if (cnt == 0 && msg.equals("")) {
				msg = message.getMessage("error.comm.fail");
			}
		}

		return msg;
	}

	// SAVE : Role Hierarchy
	public String saveRoleHierarchy(Map reqMap) throws Exception {
		String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
		String msg = "";
		int cnt = 0;

		// Insert
		if (oper.equals("add")) {
			String parentRoleId	= CommUtils.nvlTrim((String)reqMap.get("parentRoleId"));
			String roleId	= CommUtils.nvlTrim((String)reqMap.get("roleId"));

			if (parentRoleId.equals(roleId)) {
				msg = message.getMessage("exception.notDifferent");
			}

			boolean isDup = (Boolean) dao.view("Role.getRoleHierarchyCnt", reqMap);
			if (!isDup) {
				cnt = dao.update("Role.regiRoleHierarchy", reqMap);
			} else {
				msg = message.getMessage("prompt.duplicate");
			}
			// Update
		} else if (oper.equals("edit")) {
			String parentRoleId	= CommUtils.nvlTrim((String)reqMap.get("parentRoleId"));
			String roleId	= CommUtils.nvlTrim((String)reqMap.get("roleId"));

			if (parentRoleId.equals(roleId)) {
				msg = message.getMessage("exception.notDifferent");
			}

			boolean isDup = (Boolean) dao.view("Role.getRoleHierarchyCnt", reqMap);
			if (!isDup) {
				cnt = dao.update("Role.updtRoleHierarchy", reqMap);
			} else {
				msg = message.getMessage("prompt.duplicate");
			}
			// delete (multi)
		} else if (oper.equals("del")) {
			// Delete
			if (reqMap.get("jqGridDatas") != null) {
				List list = (ArrayList) reqMap.get("jqGridDatas");

				if (list != null) {
					String[] arrRoleId = new String[list.size()];
					for (int i = 0; i < list.size(); i++) {
						arrRoleId[i] = (String) ((HashMap) list.get(i)).get("roleId");
					}
					reqMap.put("arrRoleId", arrRoleId);

					cnt = dao.update("Role.deltRoleHierarchy", reqMap);
				}

			} else {
				msg = message.getMessage("errors.notdeldata");
			}
		}


		if (cnt == 0 && msg.equals("")) {
			msg = message.getMessage("error.comm.fail");
			//throw processException("error.comm.fail");
		}

		return msg;
	}
}
