package business.biz.mng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import business.biz.FileController;
import business.biz.FileService;
import business.biz.FormTagManager;
import business.biz.additionals.AddtnlsService;
import business.biz.bbs.BbsService;
import business.biz.comm.CommService;
import business.biz.evalu.EvaluCommService;
import business.biz.evalu.domain.EvaluMgmtDomain;
import business.biz.main.domain.MainDomain;
import commf.message.Message;
import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 *  Evalu Env Controller Class
 * @author lsz
 * @since 2018.11.26
 * @version 1.0
 * @see
 *
 * <pre>
 * << Modification Information >>
 *    Date	         Name          	       Desc
 * ----------      --------    ---------------------------
 *  2018.11.26      lsz      	Init.
 *
 * </pre>
 */

@Controller
@SuppressWarnings({ "rawtypes", "unused"})
public class EvaluEnvController extends BaseController {

    @Autowired
    private CommService  commService;
        
	@Autowired
    private FileService  fileService;
	
	@Autowired
    private EvaluEnvService  evaluEnvService;
	
	@Resource(name="fileManager")
    FileManager fileManager;
	
	@Autowired
    private FileController fileController;
	
    
    //################################################################
  	//	평가환경설정
  	//################################################################	
	
    /**
     * [관리자] 평가단계관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/listEvaluEnvStep.do")
    public String listEvaluEnvStep(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가단계 목록 조회
        List evaluEnvStepList = evaluEnvService.listEvaluEnvStep(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("evaluEnvStepList",  evaluEnvStepList);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        //setEvaluRtnSessionFg(request, model);
        
        return "mng/listEvaluEnvStep";
    }
    
    /**
     *  [관리자] 평가단계 등록 ajax
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/regiEvaluEnvStep.do")
    public ModelAndView regiEvaluEnvStep(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        String resultParam = evaluEnvService.regiEvaluEnvStep(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     *  [관리자] 평가단계 수정 ajax
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/updtEvaluEnvStep.do")
    public ModelAndView updtManagerEnvStep(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        int resultParam = evaluEnvService.updtEvaluEnvStep(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     *  [관리자] 평가단계 삭제 ajax
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/deltEvaluEnvStep.do")
    public ModelAndView deltManagerEnvStep(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        int resultParam = evaluEnvService.deltEvaluEnvStep(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가지표관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/listEvaluEnvIndex.do")
    public String listEvaluEnvIndex(HttpServletRequest request, ModelMap model)
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
        //setEvaluRtnSessionFg(request, model);
        
        return "mng/listEvaluEnvIndex";
    }
    
    /**
     *  [관리자] 평가지표관리 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/getEvaluEnvIndex.do")
    public ModelAndView getEvaluEnvIndex(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	System.out.println("request :: " + request);
        
        //---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        System.out.println("paramMap1 :: " + paramMap);
        
        // 평가지표 목록 조회
        List evaluEnvIndexList = evaluEnvService.listEvaluEnvIndex(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("evaluEnvIndexList", evaluEnvIndexList);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     *  [관리자] 평가지표 등록 ajax
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/regiEvaluEnvIndex.do")
    public ModelAndView regiEvaluEnvIndex(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        String resultParam = evaluEnvService.regiEvaluEnvIndex(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     *  [관리자] 평가지표 수정 ajax
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/updtEvaluEnvIndex.do")
    public ModelAndView updtEvaluEnvIndex(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        int resultParam = evaluEnvService.updtEvaluEnvIndex(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     *  [관리자] 평가지표 삭제 ajax
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/deltEvaluEnvIndex.do")
    public ModelAndView deltEvaluEnvIndex(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        int resultParam = evaluEnvService.deltEvaluEnvIndex(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

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
        // Form 설정.
        //---------------------------------------------------
        // 폼 객체 옵션 데이터를 추가한다.
        formObject(paramMap, method);
        
        return paramMap;
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
        if (method.equalsIgnoreCase("listEvaluEnvIndex")) {
            
            // 평가단계
            paramMap.put("parentCode", "EVALU_ITEM");
            List evaluStageComboList = commService.listEvaluCode(paramMap);
            request.setAttribute("evaluStageComboList", evaluStageComboList);
        }
    }

}

