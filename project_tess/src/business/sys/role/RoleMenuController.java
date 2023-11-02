/**
 * @ClassName	: RoleMenu
 * @FirstWriter	: 2011. 09.	30 ntarget
 * @Changer 	: 2011. 09. 30 ntarget
 * @Desc. 		: Admin - Role by Menu Management
 */
package business.sys.role;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import business.biz.FormTagManager;
import business.sys.role.domain.RoleDomain;
import common.base.BaseController;
import common.util.CommUtils;

@Controller
@SuppressWarnings({"rawtypes","unchecked"})
public class RoleMenuController extends BaseController {

    @Autowired
    private RoleMenuService  roleMenuService;

    @Autowired
    private RoleService  roleService;


    /**
     * Role By Menu Management Page Open
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/listRoleByMenuMgmt.do")
    public String listRoleByMenuMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		RoleDomain roleDoamin 	= new RoleDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(roleDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//


    	// Return Values
    	model.addAttribute("model", 	roleDoamin);

    	return "/admin/listRoleByMenuMgmt";
    }

    /**
     * Target Menu List
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/getNotRoleByMenuList.do")
    public ModelAndView getNotRoleByMenuList(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	RoleDomain roleDoamin 	= new RoleDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(roleDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	List list	= null;

    	if ("Y".equalsIgnoreCase((String)reqMap.get("mode"))) {
    		list = roleMenuService.listNotRoleByMenu(reqMap);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


        return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Role By Menu List
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/getRoleByMenuList.do")
    public ModelAndView getRoleByMenuList(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	RoleDomain roleDoamin 	= new RoleDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(roleDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	List list	= null;

    	if ("Y".equalsIgnoreCase((String)reqMap.get("mode"))) {
    		list = roleMenuService.listRoleByMenu(reqMap);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


    	return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Menu Management : SAVE
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/saveRoleByMenuMgmt.do")
    public ModelAndView saveRoleByMenuMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	RoleDomain roleDoamin 	= new RoleDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(roleDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = roleMenuService.saveRoleByMenu(reqMap);
    	} catch (Exception ex) {
    		msg = getErrMessage(ex);
    	}

    	if (!CommUtils.nvlTrim(msg).equals("")) {
    		rtnmap.put("success", false);
    		rtnmap.put("message", msg);
    	}

    	return new ModelAndView(ajaxView, rtnmap);
    }



	/*##################################   Data Management Zone   ##################################*/
	/**
	 * Default Values Setting
	 * @param model
	 * @param reqMap
	 */
	private void SetMappingValues(Map reqMap, String method) throws Exception {
		if (method.equalsIgnoreCase("listRoleByMenuMgmt")) {
			reqMap.put("roleId",		CommUtils.nvlTrim((String)reqMap.get("roleId"), "ROLE_ADMIN_SYS"));
		}

		// Form Tag Default Setting
		formObject(reqMap, method);
	}

	/**
	 * Form Search Values Setting
	 * @param Map reqMap
	 */
	public void formObject(Map map, String method) throws Exception {
		if (method.equalsIgnoreCase("listRoleByMenuMgmt")) {
			List listRole = roleService.listRole(map);
			request.setAttribute("roleList", FormTagManager.listToMapCombo(listRole, "roleList", "N"));
		}
	}

}