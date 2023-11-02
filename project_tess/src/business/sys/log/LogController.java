/**
 * @ClassName   : LogController
 * @FirstWriter : 2014. 11. 19 lcs
 * @Changer     : 2014. 11. 19 lcs
 * @Desc.       : Admin - Log management
 */
package business.sys.log;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import business.biz.comm.CommService;
import common.base.BaseController;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;

@Controller
@SuppressWarnings({"rawtypes","unchecked"})
public class LogController extends BaseController {

    @Autowired
    private LogService logService;
    
    @Autowired
    private CommService  commService;
    
    
    //++++++++++++++++++++++++++++++++++++++
    //메뉴별 접속통계
    //++++++++++++++++++++++++++++++++++++++
    
    /**
     * 메뉴별 접속통계 조회
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sys/log/listLogAccMenu.do")
    public String listLogAccMenu(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, getMethodName(new Throwable()) );
        //---------------------------------------------
        
        model.addAttribute("paramMap",  paramMap);
        
        return "admin/listLogAccMenu";
    }
    
    /**
     * 메뉴별 접속통계 조회 (jqGrid로 리스트 ajax 조회 method)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/log/getLogAccMenu.do")
    public ModelAndView getLogAccMenu(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, getMethodName(new Throwable()) );
        //---------------------------------------------
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));

        PaginatedArrayList list = null;
        list = logService.listLogAccMenu(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    //++++++++++++++++++++++++++++++++++++++
    //사용자별 접속통계
    //++++++++++++++++++++++++++++++++++++++
    
    /**
     * 사용자별 접속통계 조회
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sys/log/listLogAccUser.do")
    public String listLogAccUser(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, getMethodName(new Throwable()) );
        //---------------------------------------------
        
        model.addAttribute("paramMap",  paramMap);
        
        return "admin/listLogAccUser";
    }
    
    /**
     * 사용자별 접속통계 조회 (jqGrid로 리스트 ajax 조회 method)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sys/log/getLogAccUser.do")
    public ModelAndView getLogAccUser(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, getMethodName(new Throwable()) );
        //---------------------------------------------
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));

        PaginatedArrayList list = null;
        list = logService.listLogAccUser(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // Data Management Zone
    //++++++++++++++++++++++++++++++++++++++++++++++
    /**
     * Data Management
     * @param request
     * @param method
     * @return
     * @throws Exception
     */
    private Map setMappingValues(HttpServletRequest request, String method) throws Exception {
        logger.debug("************ method:" + method);
        
        //---------------------------------------------------
        // mapping request parameters to map
        //---------------------------------------------------
        Map paramMap = getParameterMap(request, true);
        
        //---------------------------------------------------
        // 화면별 설정.
        //---------------------------------------------------
        if (method.equalsIgnoreCase("listLogAccMenu") ) {
            
        }
        
        //---------------------------------------------------
        // Form 설정.
        //---------------------------------------------------
        // 폼 객체 옵션 데이터를 추가한다.
        formObject(paramMap, method);
        
        return paramMap;
    }
    
    /**
     * 폼 객체 옵션 데이터를 추가한다.
     *
     * @param paramMap 파라메터
     * @param method 메소드
     * @throws Exception 발생오류
     */
    private void formObject(Map paramMap, String method) throws Exception {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        
        // 사용자별접속통계 리스트화면 구성 관련 
        if (method.equalsIgnoreCase("listLogAccUser") ) {
            
            // [사용자유형] 콤보 리스트 조회
            paramMap.put("parentCode", "USCM_TYPE");
            List uscmTypeComboList = commService.listCode(paramMap);
            request.setAttribute("uscmTypeComboList", uscmTypeComboList);
        }
        
    }
}