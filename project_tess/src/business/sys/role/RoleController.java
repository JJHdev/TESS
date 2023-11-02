/**
 * @ClassName	: Role
 * @FirstWriter	: 2011. 01.	24 ntarget
 * @Changer 	: 2011. 01. 24 ntarget
 * @Desc. 		: Admin - Role management
 */
package business.sys.role;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import business.sys.role.domain.RoleDomain;

import common.base.BaseController;
import common.util.CommUtils;

@Controller
@SuppressWarnings({"rawtypes","unchecked"})
public class RoleController extends BaseController {

    @Autowired
    private RoleService  roleService;

    /**
     * Role Management Page Open
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/listRoleMgmt.do")
    public String listRoleMgmt(HttpServletRequest request, ModelMap model)
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

    	return "/admin/listRoleMgmt";
    }

    /**
     * Role Data Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/getRoleList.do")
    public ModelAndView getRoleList(HttpServletRequest request, ModelMap model)
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
    		list = roleService.listRole(reqMap);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


        return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Role Hierarchy Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/getRoleHierarchyList.do")
    public ModelAndView getRoleHierarchyList(HttpServletRequest request, ModelMap model)
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
    		list = roleService.listRoleHeirarchy(reqMap);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


        return new ModelAndView(ajaxView, returnMap);

    }

    /**
     * Common Code List for GRID ComboBox,
     * 2011.09.28 ntarget
     * @return
     */
    @RequestMapping("/sys/role/listComboRole.do")
    public ModelAndView listComboRole(HttpServletRequest request, ModelMap model)
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

		// [Combo]
		List listCombo = roleService.listComboRole(reqMap);

    	Map returnMap	= new HashMap();
    	returnMap.put("combo", listCombo);


    	return new ModelAndView(ajaxView, returnMap);
    }



    /**
     * Role Management : SAVE
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/saveRole.do")
    public ModelAndView saveRole(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	RoleDomain roleDoamin 	= new RoleDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	logger.info("reqMap ==> ",reqMap);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(roleDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = roleService.saveRole(reqMap);
    	} catch (Exception ex) {
    		msg = getErrMessage(ex);
    	}

    	if (!CommUtils.nvlTrim(msg).equals("")) {
    		rtnmap.put("success", false);
    		rtnmap.put("message", msg);
    	}

    	return new ModelAndView(ajaxView, rtnmap);
    }

    /**
     * Role Hierarchy Management : SAVE
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/role/saveRoleHierarchy.do")
    public ModelAndView saveRoleHierarchy(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	RoleDomain roleDoamin 	= new RoleDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	logger.info("reqMap ==> ",reqMap);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(roleDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = roleService.saveRoleHierarchy(reqMap);
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
	private void SetMappingValues(Map reqMap, String method) {
		reqMap.put("mode", 			CommUtils.nvlTrim((String)reqMap.get("mode"), "N"));

		// Form Tag Default Setting
		formObject(reqMap, method);
	}

	/**
	 * Form Search Values Setting
	 * @param Map reqMap
	 */
	public void formObject(Map map, String method) {
		if (method.equalsIgnoreCase("listRoleMgmt")) {

		}
	}

}