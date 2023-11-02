/**
 * @ClassName	: RoleProg
 * @FirstWriter	: 2011. 09.	29 ntarget
 * @Changer 	: 2011. 09. 29 ntarget
 * @Desc. 		: Admin - Program by Role Management
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
public class RoleProgController extends BaseController {

    @Autowired
    private RoleProgService  roleProgService;

    @Autowired
    private RoleService  roleService;


    /**
     * Role By Program Management Page Open
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/listRoleByProgMgmt.do")
    public String listRoleByProgMgmt(HttpServletRequest request, ModelMap model)
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

    	return "/admin/listRoleByProgMgmt";
    }

    /**
     * Target Program List
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/getNotRoleByProgList.do")
    public ModelAndView getNotRoleByProgList(HttpServletRequest request, ModelMap model)
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
    		list = roleProgService.listNotRoleByProg(reqMap);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


        return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Role By Program List
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/getRoleByProgList.do")
    public ModelAndView getRoleByProgList(HttpServletRequest request, ModelMap model)
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
    		list = roleProgService.listRoleByProg(reqMap);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


    	return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Program Management : SAVE
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/saveRoleByProgMgmt.do")
    public ModelAndView saveRoleByProgMgmt(HttpServletRequest request, ModelMap model)
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
    		msg = roleProgService.saveRoleByProg(reqMap);
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
		if (method.equalsIgnoreCase("listRoleByProgMgmt")) {
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
		if (method.equalsIgnoreCase("listRoleByProgMgmt")) {
			List listRole = roleService.listRole(map);
			request.setAttribute("roleList", FormTagManager.listToMapCombo(listRole, "roleList", "N"));
		}
	}

}