/**
 * @ClassName	: Code
 * @FirstWriter	: 2010. 11.	23 ntarget
 * @Changer 	: 2010. 11. 23 ntarget
 * @Desc. 		: Admin - Code management
 */
package business.sys.code;

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

import business.sys.code.domain.CodeDomain;

import common.base.BaseController;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;

@Controller
@SuppressWarnings({"rawtypes","unchecked"})
public class CodeController extends BaseController {

    @Autowired
    private CodeService  codeService;

    /**
     * Code Type & Code Search Page.
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/listCodeMgmt.do")
    public String listCodeMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		CodeDomain codeDomain 	= new CodeDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(codeDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

    	// Return Values
    	model.addAttribute("model", 	codeDomain);

    	return "/admin/listCodeMgmt";
    }
    /**
     * Code Type & Code Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/getCodeTypeList.do")
    public ModelAndView getCodeTypeList(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	CodeDomain codeDomain 	= new CodeDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(codeDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

    	List list = null;

    	if ("Y".equalsIgnoreCase((String)paramMap.get("mode"))) {
    		list = codeService.listCodeType(paramMap);
    	}
    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);


        return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Code Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/getCodeList.do")
    public ModelAndView getCodeList(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	CodeDomain codeDomain 	= new CodeDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(codeDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

    	PaginatedArrayList list	= null;

    	CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), 	1);
    	PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), "10"));

    	if ("Y".equalsIgnoreCase((String)paramMap.get("mode"))) {
    		list = codeService.listCode(paramMap, CURR_PAGE, PAGE_SIZE);
    	}

    	Map returnMap	= new HashMap();
    	returnMap.put("pageGridList", list);


        return new ModelAndView(ajaxView, returnMap);

    }

    /**
     * Code Management[Code Type] : SAVE
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/saveCodeType.do")
    public ModelAndView saveCodeType(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	CodeDomain codeDomain 	= new CodeDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(codeDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = codeService.saveCodeType(paramMap);
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
     * Code Management[Code] : SAVE
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/saveCode.do")
    public ModelAndView saveCode(HttpServletRequest request, ModelMap model)
    throws Exception {
    	// Business Define
    	String method 			= getMethodName(new Throwable());
    	CodeDomain codeDomain 	= new CodeDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(codeDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

		Map rtnmap	= new HashMap();
		String msg = "";

    	try {
    		msg = codeService.saveCode(paramMap);
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
     * [20140904 LCS] Tree view용 저장 controller
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/saveCodeTree.do")
    public ModelAndView saveCodeTree(HttpServletRequest request, ModelMap model)
    throws Exception {
        // Business Define
        String method           = getMethodName(new Throwable());
        CodeDomain codeDomain   = new CodeDomain();

        // Request Parameter Values Setting
        Map paramMap = getParameterMap(request, true);

        // Default Value Setting
        SetMappingValues(paramMap, method);

        BeanUtils.copyProperties(codeDomain, paramMap);
        //-------------------- Default Setting End -----------------------//

        Map rtnmap  = new HashMap();
        String msg = "";

        try {
            msg = codeService.saveCodeTree(paramMap);
        } catch (Exception ex) {
            msg = getErrMessage(ex);
        }

        if (!CommUtils.nvlTrim(msg).equals("")) {
            rtnmap.put("success", false);
            rtnmap.put("message", msg);
        }

        return new ModelAndView(ajaxView, rtnmap);
    }


    /*##################################   Tree grid type view   ##################################*/

    /**
     * [20140904 LCS] Code Type & Code Search Page.
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/listCodeTreeMgmt.do")
    public String listCodeTreeMgmt(HttpServletRequest request, ModelMap model)
    throws Exception {
		// Business Define
		String method 			= getMethodName(new Throwable());
		CodeDomain codeDomain 	= new CodeDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(codeDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

    	// Return Values
    	model.addAttribute("model", 	codeDomain);

    	return "/admin/listCodeTreeMgmt";
    }

    /**
     * Code Data (Tree type) Search
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/code/getCodeTreeList.do")
    public ModelAndView getCodeTreeList(HttpServletRequest request, ModelMap model)
    throws Exception {
        // Business Define
        String method           = getMethodName(new Throwable());
        CodeDomain codeDoamin   = new CodeDomain();

        // Request Parameter Values Setting
        Map reqMap = getParameterMap(request, true);

        // Default Value Setting
        SetMappingValues(reqMap, method);

        BeanUtils.copyProperties(codeDoamin, reqMap);
        //-------------------- Default Setting End -----------------------//

        List list   = null;

        if ("Y".equalsIgnoreCase((String)reqMap.get("mode"))) {
            list = codeService.listCodeTree(reqMap);
        }

        Map returnMap   = new HashMap();
        returnMap.put("gridList", list);


        return new ModelAndView(ajaxView, returnMap);
    }

    /*##################################   Data Management Zone   ##################################*/
	/**
	 * Default Values Setting
	 * @param model
	 * @param userInfo
	 */
	private void SetMappingValues(Map paramMap, String method) {

		if (method.equalsIgnoreCase("getCodeTypeList")) {
			paramMap.put("mode", 			CommUtils.nvlTrim((String)paramMap.get("mode"), "N"));
			paramMap.put("parentCode", 		CommUtils.nvlTrim((String)paramMap.get("parentCode")));
		}

		if (method.equalsIgnoreCase("getCodeList")) {
			paramMap.put("mode", 			CommUtils.nvlTrim((String)paramMap.get("mode"), "N"));
			paramMap.put("parentCode", 		CommUtils.nvlTrim((String)paramMap.get("parentCode")));
		}

		// Form Tag Default Setting
		formObject(paramMap, method);
	}

	/**
	 * Form Search Values Setting
	 * @param Map paramMap
	 */
	public void formObject(Map map, String method) {
		if (method.equalsIgnoreCase("listCodeMgmt")) {

		}
	}

}