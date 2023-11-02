package business.sys.menu;

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
@SuppressWarnings({"rawtypes","unchecked", "static-access"})
public class MenuService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

	// Menu List (For Main)
	public List listMainMenu(Map reqMap) throws Exception {
		List list = null;
		list = dao.list("Menu.listMainMenu", reqMap);
		return list;
	}
	// Menu List (Not Login User)
	public List listNotUserMainMenu(Map reqMap) throws Exception {
		List list = null;
		list = dao.list("Menu.listNotUserMainMenu", reqMap);
		return list;
	}

	// Parent Menu List (For Combo)
	public List listTopMenu(Map map) throws Exception {
		return dao.list("Menu.listTopMenu", map);
	}

	// Menu List Search
	public List listMenu(Map reqMap) throws Exception {
		List list = null;
		list = dao.list("Menu.listMenu", reqMap);
		return list;
	}

	// Menu Save(Registration, Update)
	public String saveMenu(Map reqMap) throws Exception {
		String oper = CommUtils.nvlTrim((String) reqMap.get("oper"));
		String msg = "";
		int cnt = 0;

		if (CommUtils.nvlTrim((String) reqMap.get("menuId")).equals("")) {
			msg = "Menu Id " + message.getMessage("common.required.msg");
		} else {

			// Insert
			if (oper.equals("add")) {
				boolean isDup = (Boolean) dao.view("Menu.getMenuCnt", reqMap);
				if (!isDup) {
					cnt = dao.update("Menu.regiMenu", reqMap);
				} else {
					msg = message.getMessage("prompt.duplicate");
				}
			// Update
			} else if (oper.equals("edit")) {
				cnt = dao.update("Menu.updtMenu", reqMap);

			// delete (multi)
			} else if (oper.equals("del")) {
				// Delete
				if (reqMap.get("jqGridDatas") != null) {
					List list = (ArrayList) reqMap.get("jqGridDatas");

					if (list != null) {
						String[] arrMenuId = new String[list.size()];
						for (int i = 0; i < list.size(); i++) {
							arrMenuId[i] = (String) ((HashMap) list.get(i)).get("menuId");
						}
						reqMap.put("arrMenuId", arrMenuId);

						// reference table delete
						dao.update("RoleMenu.deltRoleByMenuFromMenu", reqMap);

						cnt = dao.update("Menu.deltMenu", reqMap);
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


}
