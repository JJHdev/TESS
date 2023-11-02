package business.biz.evalu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.map.LinkedMap;
import org.hamcrest.core.Is;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.sqlmap.engine.mapping.sql.dynamic.elements.IsEmptyTagHandler;

import business.biz.FileController;
import business.biz.FormTagManager;
import business.biz.comm.CommService;
import business.biz.evalu.domain.EvaluMgmtDomain;
import commf.message.Message;
import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * Program Name    : EvaluMgmtController
 * Description     : 관리/운영 개발사업관리 Controller
 * Programmer Name : LCS
 * Creation Date   : 2014-09-29
 * Used Table(주요) :
 * 
 * @author LCS
 *
 */
@Controller
@SuppressWarnings({ "rawtypes", "unchecked" })
public class EvaluIndicatController extends BaseController {
    
    @Autowired
    private EvaluIndicatService evaluIndicatService;
    
    @Autowired
    private CommService  commService;
    
    @Resource(name="fileManager")
    FileManager fileManager;
    
    @Autowired
    private FileController fileController;
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/indicat/listEvaluIndicatMgmt.do")
    public String listEvaluIndicatMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "indicat/listEvaluIndicatMgmt";
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/indicat/getEvaluIndicatMgmt.do")
    public ModelAndView getEvaluIndicatMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        List list = null;
        list = evaluIndicatService.listEvaluIndicatMgmt(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("gridList", list);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/indicat/saveEvaluIndicatMgmt.do")
    public ModelAndView saveEvaluIndicatMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = evaluIndicatService.saveEvaluIndicatMgmt(paramMap);
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
     * Evalu에서 사용할 retrun 정보를 얻고 session 정보를 정리하는 methode
     * @param request
     * @param model
     */
    private void setEvaluRtnSessionFg(HttpServletRequest request, ModelMap model){
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        String sessEvaluRtnFg = (String)request.getSession().getAttribute(EvaluCommService.SESSKEY_EVALU_RTNFG);
        if( !CommUtils.empty(sessEvaluRtnFg) ) {
            model.addAttribute("sessEvaluRtnFg", sessEvaluRtnFg);
            request.getSession().removeAttribute(EvaluCommService.SESSKEY_EVALU_RTNFG);
        }
    }
    
    /**
     * check wrong access
     * @param request
     * @param reqMap
     * @param method
     * @return
     */
    private EgovBizException checkWrongAccess(HttpServletRequest request)  {

        EgovBizException ex = null;

        //+++++++++++++++++++++++++++++++
        // check wrong access
        //+++++++++++++++++++++++++++++++
        String reqReferer =  request.getHeader("REFERER");
        if(CommUtils.empty(reqReferer)){
            // msg : 잘못된 방법으로 접근하였습니다.
            ex = new EgovBizException(Message.getMessage("exception.Evalu.accsWrongWay"));
        }

        return ex;
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
        
        // 리스트화면 구성 관련 
        if (method.equalsIgnoreCase("listEvaluIndicatMgmt")) {
            
            // 평가단계
            paramMap.put("parentCode", "EVALU_ITEM");
            List evaluStageComboList = commService.listEvaluCode(paramMap);
            request.setAttribute("evaluStageComboList", evaluStageComboList);
        }
    }
}