/**
 * @Class Name	: Program
 * @First Writer: 2011. 09.	29 ntarget
 * @Changer 	: 2011. 09. 29 ntarget
 * @Description	: Admin - Program Management
 */
package business.sys.program;

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

import business.sys.program.domain.ProgDomain;
import business.sys.role.domain.RoleDomain;
import common.base.BaseController;
import common.util.CommUtils;

@Controller
@SuppressWarnings({"rawtypes", "unchecked"})
public class ProgController extends BaseController {

    @Autowired
    private ProgService  progService;

    /**
     * Program Page Open
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/prog/listProgMgmt.do")
    public String listProgMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		ProgDomain progDoamin 	= new ProgDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(progDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	// Return Values
    	model.addAttribute("model", 	progDoamin);

    	return "/admin/listProgMgmt";
    }

    /**
     * Program Data Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/prog/getProgList.do")
    public ModelAndView getProgList(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		ProgDomain progDoamin 	= new ProgDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(progDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	List list	= null;

    	if ("Y".equalsIgnoreCase((String)reqMap.get("mode"))) {
    		list = progService.listProg(reqMap);
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
    @RequestMapping("/sys/prog/saveProgMgmt.do")
    public ModelAndView saveProgMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	ProgDomain progDoamin 	= new ProgDomain();

    	// Request Parameter Values Setting
    	Map reqMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(reqMap, method);

    	BeanUtils.copyProperties(progDoamin, reqMap);
    	//-------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = progService.saveProg(reqMap);
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
     * Common Code List for GRID ComboBox,
     * 2014.10.14 ntarget
     * @return
     */
    @RequestMapping("/sys/prog/listComboMenu.do")
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
		List listCombo = progService.listComboMenu(reqMap);

    	Map returnMap	= new HashMap();
    	returnMap.put("combo", listCombo);


    	return new ModelAndView(ajaxView, returnMap);
    }



	/*##################################   Data Management Zone   ##################################*/
	/**
	 * Default Values Setting
	 * @param model
	 * @param userInfo
	 * @throws Exception
	 */
	private void SetMappingValues(Map reqMap, String method) throws Exception {
		if (method.equalsIgnoreCase("listProgMgmt")) {

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
		if (method.equalsIgnoreCase("listProgMgmt")) {

		}
	}

}