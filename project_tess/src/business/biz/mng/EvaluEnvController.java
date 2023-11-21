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

import com.sun.org.apache.bcel.internal.util.InstructionFinder.CodeConstraint;

import business.biz.CommConst;
import business.biz.FileController;
import business.biz.FileService;
import business.biz.FormTagManager;
import business.biz.additionals.AddtnlsService;
import business.biz.bbs.BbsService;
import business.biz.comm.CommService;
import business.biz.evalu.EvaluCommService;
import business.biz.evalu.domain.EvaluMgmtDomain;
import business.biz.main.domain.MainDomain;
import business.sys.code.CodeService;
import commf.message.Message;
import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * [관리자] - 평가환경설정 클래스
 * 
 * @class   : EvaluEnvController
 * @author  : LHB
 * @since   : 2023.11.17
 * @version : 1.0
 *
 *   수정일       수정자             수정내용
 *  --------   --------    ---------------------------
 *  23.11.17     LHB        코드 수정 시작.
 */

@Controller
@SuppressWarnings({ "all" })
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
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
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
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
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
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
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
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
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
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
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
    
    //################################################################
    //SUNDOSOFT 평가사업관리 > 평가사업등록
    //################################################################

    /**
     * [관리자] 평가환경설정 - 평가단계관리 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/listEvaluEnvStep.do")
    public String listEvaluEnvStep(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가단계 목록 조회
        paramMap.put("parentCode", CommConst.ES);
        List evaluStageList = commService.listCode(paramMap);
        
        model.addAttribute("model"   ,			evaluMgmtDomain);
        model.addAttribute("paramMap",			paramMap);
        model.addAttribute("evaluStageList",	evaluStageList);
        
        return "mng/listEvaluEnvStep";
    }
    
    /**
     * [관리자] 평가환경설정 - 평가단계관리 등록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/regiEvaluEnvStage.do")
    public ModelAndView regiEvaluEnvStage(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        int resultParam = evaluEnvService.regiEvaluEnvStage(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("code", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가환경설정 - 평가단계관리 수정
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/updtEvaluEnvStage.do")
    public ModelAndView updtEvaluEnvStage(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        int resultParam = evaluEnvService.updtEvaluEnvStage(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("code", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가환경설정 - 평가단계관리 삭제
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/deltEvaluEnvStage.do")
    public ModelAndView deltEvaluEnvStage(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        int resultParam = evaluEnvService.deltEvaluEnvStage(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("code", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    
    
    /* 평가지표관리 */
    
    
    
    /**
     * [관리자] 평가환경설정 - 참조파일관리 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/listEvaluEnvFile.do")
    public String listEvaluEnvFile(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가단계 목록 조회
        paramMap.put("parentCode", CommConst.ES);
        List evaluStageList = commService.listCode(paramMap);
        
        model.addAttribute("model"   ,			evaluMgmtDomain);
        model.addAttribute("paramMap",			paramMap);
        model.addAttribute("evaluStageList",	evaluStageList);
        
        return "mng/listEvaluEnvFile";
    }
    
    /**
     * [관리자] 평가환경설정 - 참조파일관리 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/listEvaluEnvSampleFile.do")
    public ModelAndView listEvaluEnvSampleFile(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        if (paramMap.get("evaluStage") == null || CommUtils.isEmpty((String) paramMap.get("evaluStage"))) {
        	paramMap.put("evaluStage", CommConst.ES_PREV);
        }
        
        // 샘플 파일 조회
        paramMap.put("parentCode",	CommConst.FT);
        paramMap.put("addCol02",	paramMap.get("evaluStage"));
        paramMap.put("useYn",	CommConst.YES);
        List evaluStageList = commService.listCode(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("code", (evaluStageList != null ? evaluStageList.size() : 0));
        returnMap.put("data", evaluStageList);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가지침 파일업로드 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/saveEvaluEnvSampleFile.do")
    public String saveEvaluEnvSampleFile(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------

        //------------------
        // 파일 처리 부분
        //------------------
        List<Map> upfileInfoList = fileManager.multiFileUploadEvaluSample(request);
        
        for(Map map : upfileInfoList) {
        	paramMap.put("fileSize", map.get("fileSize"));
        	paramMap.put("tempDir", map.get("tempDir"));
        	paramMap.put("idx", map.get("idx"));
        	paramMap.put("fileSvrNm", map.get("fileSvrNm"));
        	paramMap.put("fileOrgNm", map.get("fileOrgNm"));
        }
        
        if (upfileInfoList != null && upfileInfoList.size() > 0) {
        	// TODO SYS_CODE 수정 필요함
        	Map tempMap = upfileInfoList.get(0);
        	tempMap.put("gsUserId", paramMap.get("gsUserId"));
        	evaluEnvService.saveEvaluEnvSampleFile(tempMap);
        	resultFlag("정상적으로 저장되었습니다.");
        } else {
        	resultFlag("저장에 실패했습니다.");
        }
        
        return "redirect:/mng/listEvaluEnvFile.do";
    }
}