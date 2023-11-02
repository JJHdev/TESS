/**
 * @Class Name	: Menu
 * @First Writer: 2011. 09.	26 ntarget
 * @Changer 	: 2011. 09. 26 ntarget
 * @Description	: Admin - Menu Management
 */
package business.sys.menu;

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

import business.biz.FormTagManager;
import business.sys.menu.domain.MenuDomain;

import common.base.BaseController;
import common.util.CommUtils;

@Controller
@SuppressWarnings({"rawtypes","unchecked"})
public class MenuController extends BaseController {

    @Autowired
    private MenuService  menuService;

    /**
     * Menu Page Open
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/menu/listMenuMgmt.do")
    public String listMenuMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		MenuDomain menuDoamin 	= new MenuDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(menuDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	// Return Values
    	model.addAttribute("model", 	menuDoamin);

    	return "/admin/listMenuMgmt";
    }

    /**
     * Menu Data Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/menu/getMenuList.do")
    public ModelAndView getMenuList(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		MenuDomain menuDoamin 	= new MenuDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(menuDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	List list	= null;

    	if ("Y".equalsIgnoreCase((String)reqMap.get("mode"))) {
    		list = menuService.listMenu(reqMap);
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
    @RequestMapping("/sys/menu/saveMenuMgmt.do")
    public ModelAndView saveMenuMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	MenuDomain menuDoamin 	= new MenuDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(menuDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = menuService.saveMenu(reqMap);
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
	 * @param userInfo
	 * @throws Exception
	 */
	private void SetMappingValues(Map reqMap, String method) throws Exception {
		if (method.equalsIgnoreCase("listMenuMgmt")) {
			reqMap.put("parentMenuId",		"");
			reqMap.put("menuNm",		"");
		}

		// Form Tag Default Setting
		formObject(reqMap, method);
	}

	/**
	 * Form Search Values Setting
	 * @param Map reqMap
	 * @throws Exception
	 */
	public void formObject(Map map, String method) throws Exception {
		if (method.equalsIgnoreCase("listMenuMgmt")) {
			List listTopMenu = menuService.listTopMenu(map);
			request.setAttribute("menuTopList", FormTagManager.listToMapCombo(listTopMenu, "menuTopList", "NULL"));
		}
	}

}