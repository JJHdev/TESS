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
import business.biz.committee.EvaluMembService;
import business.biz.committee.domain.EvaluMbrMgmtDomain;
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
 *  EvaluCommittee Controller Class
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
public class EvaluCommitteeController extends BaseController {

	@Autowired
    private EvaluCommitteeService committeeService;
    
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
    @RequestMapping(value="/mng/listEvaluMbrMgmt.do")
    public String listEvaluMbrMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
        // default domain setting
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain();
        BeanUtils.copyProperties(evaluMbrMgmtDomain, paramMap);
        //---------------------------------------------
    	
        model.addAttribute("model"   ,  evaluMbrMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "mng/listEvaluMbrMgmt";
    }
    
    /**
     * [사업관리] 평가위원 등록 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/regiEvaluMbrCommit.do")
    public String regiEvaluMbrCommit(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
        // default domain setting
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain();
        BeanUtils.copyProperties(evaluMbrMgmtDomain, paramMap);
        //---------------------------------------------
    	
        model.addAttribute("model"   ,  evaluMbrMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "mng/regiEvaluMbrCommit";
    }
 
    /**
     * [사업관리] 평가위원 등록 처리.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/saveCommitMembInfo.do")
    public String saveCommitMembInfo(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
        // default domain setting
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain();
        BeanUtils.copyProperties(evaluMbrMgmtDomain, paramMap);
        //---------------------------------------------
    	
        model.addAttribute("model"   ,  evaluMbrMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //입력 수정 구분
        String procType = "I";
        
        try {
            //------------------
            // DB 작업 부분
            //------------------
        	committeeService.saveCommitMembInfo(paramMap, procType);
        	committeeService.saveCommitMembField(paramMap, procType);
            resultFlag(message.getMessage("message.user.regiCommitComplete"));
            //resultFlag(message.getMessage("message.user.regiCommitComplete"));
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        return "redirect:/mng/listEvaluMbrMgmt.do";
    }    
    
    
    /**
     * [사업관리] 평가위원 수정 등록 처리.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/updateCommitMembInfo.do")
    public String updateCommitMembInfo(HttpServletRequest request, ModelMap model)
            throws Exception {
    	logger.debug("/mng/updateCommitMembInfo.do");
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
        // default domain setting
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain();
        BeanUtils.copyProperties(evaluMbrMgmtDomain, paramMap);
        //---------------------------------------------
    	
        model.addAttribute("model"   ,  evaluMbrMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //입력 수정 구분
        String procType = "U";
        logger.debug( procType);
        try {
            //------------------
            // DB 작업 부분
            //------------------
        	committeeService.saveCommitMembInfo(paramMap, procType);
            //resultFlag(message.getMessage("message.user.regiMembComplete"));
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        return "redirect:/mng/listEvaluMbrMgmt.do";
    }
    
    /**
     * 사용자 ID(USER_ID) 중복 검사.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/getMembCheckIdDupl.do")
    public ModelAndView getMembCheckIdDupl(HttpServletRequest request, ModelMap model)
            throws Exception {
        //---------------------------------------------
        //Default Setting Start
        String method       = getMethodName(new Throwable());
        // mapping request parameters to map
        Map paramMap = setMappingValues(request, method);
        // Default Value Setting
       
        //Default Setting End
        //---------------------------------------------
        Map returnMap = new HashMap();
        ModelAndView mav = new ModelAndView();
        
        try {
        	//아이디 중복 검사
        	 int duplCnt = committeeService.viewMembCheckDuplUserId(paramMap);
        	 returnMap.put("duplCnt", duplCnt);
        	 
         	 mav.addObject("AJAX_MODEL", returnMap);
         	 mav.setViewName(ajaxView);
         	 
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        return mav;
    }
    
    /**
     * 위원 분야 목록 
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    /*
    @RequestMapping("/memb/getEvaluCommitField.do")
    public ModelAndView getMembField(HttpServletRequest request, ModelMap model)
            throws Exception {
    	logger.debug("check1111111");
        //---------------------------------------------
        //Default Setting Start
        String method       = getMethodName(new Throwable());
        // mapping request parameters to map
        Map paramMap = setMappingValues(request, method);
        // Default Value Setting
       
        //Default Setting End
        //---------------------------------------------
        Map returnMap = new HashMap();
        ModelAndView mav = new ModelAndView();
        
        String fieldList = evaluMembService.getMembField(paramMap);
        returnMap.put("fieldList", fieldList);
        mav.addObject("AJAX_MODEL", returnMap);
        mav.setViewName(ajaxView);
        
        return mav;
    }
    */
    
    /**
     *  [관리자] 평가위원 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    
    @RequestMapping("/mng/getEvaluMbrMgmt.do")
    public ModelAndView getEvaluMbrMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain(); 
        BeanUtils.copyProperties(evaluMbrMgmtDomain, paramMap);
        //---------------------------------------------
        
        System.out.println("paramMap :::: " + paramMap);
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));
        
        PaginatedArrayList list = null;
        list = committeeService.listEvaluMbrMgmt(paramMap, CURR_PAGE, PAGE_SIZE);
        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [사업관리] 평가위원 정보 보기 이동
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/viewEvaluMbrCommit.do")
    public String viewEvaluMbrCommit(HttpServletRequest request, ModelMap model)
            throws Exception {
    	//---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method);
        logger.debug("paramMap:::::: " + paramMap);
        Map mastMap =  committeeService.viewEvaluMbrCommit(paramMap);
        // default domain setting
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain();
        BeanUtils.copyProperties(evaluMbrMgmtDomain, mastMap);
        //---------------------------------------------
        model.addAttribute("model"   ,  evaluMbrMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "mng/viewEvaluMbrCommit";
    }
   
    
    /**
     *  [평가관리] 평가대상 목록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/getEvaluBusiList.do")
    public ModelAndView getEvaluBusiList(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
    	logger.debug("find!!!!!!");
    	String method       = getMethodName(new Throwable());
    	logger.debug("method::::"+method);
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMbrMgmtDomain evaluMbrMgmtDomain = new EvaluMbrMgmtDomain(); 
        BeanUtils.copyProperties(evaluMbrMgmtDomain, paramMap);
        logger.debug("paramMap::::"+paramMap);
        //---------------------------------------------
       
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));

        PaginatedArrayList list = null;
        list = committeeService.listEvaluBusiList(paramMap, CURR_PAGE, PAGE_SIZE);
        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
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
        // 잘못된 방법으로 접근여부 확인
        //---------------------------------------------------
        
        // 예외를 제외하고 다른 화면은 직접 url에서 입력후 들어가지 못하게 함.
        if (!(method.equalsIgnoreCase("listEvaluMgmt")               // 리스트화면열기
                || method.equalsIgnoreCase("getEvaluMgmtSrch")           // 리스트 조회
                || method.equalsIgnoreCase("getEvaluMgmt")           // 리스트 조회
                || method.equalsIgnoreCase("openRegiEvaluMgmtSumm")  // 관광사업 신규 등록 화면
                || method.equalsIgnoreCase("listEvaluStgMgmt") 		// 사업평가관리 리스트
                || method.equalsIgnoreCase("regiEvaluStgMgmt") 		// 사업평가관리 등록
                || method.equalsIgnoreCase("listEvaluBudtMgmt") 		// 사업평가관리 등록
                || method.equalsIgnoreCase("regiEvaluFinlBudtMgmt") 		// 사업평가관리 등록
             )) {
            
            EgovBizException egovEx = checkWrongAccess(request);
            if(egovEx != null) throw egovEx;
        }
        
        //---------------------------------------------------
        // 공통 설정.
        //---------------------------------------------------
        
        // mode 오류가 나지 않게 자동 설정
        if(method.indexOf("view") == 0) {
            // view 설정
            paramMap.put("mode", EvaluCommService.MODE_VIEW);
        }
        else if(method.indexOf("openRegi") == 0 ) {
            // regi 설정 (openRegiEvaluMgmtExpsYear[사업비현황 년단위 등록화면] 제외)
            if(!method.equals("openRegiEvaluMgmtExpsYear")) {
                paramMap.put("mode", EvaluCommService.MODE_REGI);
            }
        }
        else if(method.indexOf("openUpdt") == 0) {
            // updt 설정 (openRegiEvaluMgmtExpsYear[사업비현황 년단위 수정화면] 제외)
            if(!method.equals("openUpdtEvaluMgmtExpsYear")) {
                paramMap.put("mode", EvaluCommService.MODE_UPDT);
            }
        }
        
        // 메뉴 구분 값 설정
        String menuFg = EvaluCommService.MENU_MGMT;
        if(method.indexOf("EvaluMgmtSrch") > 0) {
            menuFg = EvaluCommService.MENU_SRCH;
        }
        paramMap.put("menuFg", menuFg);
        
        // 등록/수정 사용자 id 설정
        paramMap.put("regiId", paramMap.get("gsUserId"));
        paramMap.put("updtId", paramMap.get("gsUserId"));
        
        //----------------------------------
        // 허용된 첨부 파일 TYPE 설정
        //----------------------------------
        String allowedFileExts = ApplicationProperty.get("file.base.allow.exts");
        paramMap.put("allowedFileExts", allowedFileExts);
        String allowedImgFileExts = ApplicationProperty.get("file.img.allow.exts");
        paramMap.put("allowedImgFileExts", allowedImgFileExts);
        
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
        if (method.equalsIgnoreCase("listEvaluMbrMgmt")) {
            
            paramMap.put("parentCode", "OCCUPA_TYPE");
            List occupaList = commService.listCode(paramMap);
            request.setAttribute("occupaList", occupaList);
            
            paramMap.put("parentCode", "FIELD_TYPE");
            List fieldTypeList = commService.listCode(paramMap);
            request.setAttribute("fieldTypeList", fieldTypeList);
            
            // 평가결과 조회 콤보
            List finlRestlSel = new ArrayList ();
            Map srchType1Map = new HashMap();
            srchType1Map.put("code"  , "P");
            srchType1Map.put("codeNm", "적합");
            finlRestlSel.add(srchType1Map);
            Map srchType2Map = new HashMap();
            srchType2Map.put("code"  , "C");
            srchType2Map.put("codeNm", "조건부적합");
            finlRestlSel.add(srchType2Map);
            Map srchType3Map = new HashMap();
            srchType3Map.put("code"  , "F");
            srchType3Map.put("codeNm", "부적합");
            finlRestlSel.add(srchType3Map);
            request.setAttribute("finlRestlSelComboList", finlRestlSel);
            
        } else if (method.equalsIgnoreCase("regiEvaluMbrCommit")) {
        	
        	// 이메일 도메인 코드 리스트
            paramMap.put("parentCode", "EMAIL_CD");
            List emailCdCodeList = commService.listCode(paramMap);
            request.setAttribute("emailCdCodeList", emailCdCodeList) ;

            // 휴대폰 국번 코드 리스트
            paramMap.put("parentCode", "CELL_FNUM");
            List phoneFNumCodeList = commService.listCode(paramMap);
            request.setAttribute("phoneFNumCodeList", phoneFNumCodeList) ;
            
            // 직종 리스트
            paramMap.put("parentCode", "OCCUPA_TYPE");
            List occupaList = commService.listCode(paramMap);
            request.setAttribute("occupaList", occupaList);
            
            // 전문 분야별 코드 리스트(관광)
            paramMap.put("parentCode", "FT01");
            List fieldTravList = commService.listCode(paramMap);
            request.setAttribute("fieldTravList", fieldTravList) ;
            
            // 전문 분야별 코드 리스트(경제, 경영)
            paramMap.put("parentCode", "FT02");
            List fieldEcoList = commService.listCode(paramMap);
            request.setAttribute("fieldEcoList", fieldEcoList) ;
            
            // 전문 분야별 코드 리스트(문화)
            paramMap.put("parentCode", "FT03");
            List fieldCultList = commService.listCode(paramMap);
            request.setAttribute("fieldCultList", fieldCultList) ;
            
            // 전문 분야별 코드 리스트(콘텐츠)
            paramMap.put("parentCode", "FT04");
            List fieldContList = commService.listCode(paramMap);
            request.setAttribute("fieldContList", fieldContList) ;
            
            // 전문 분야별 코드 리스트(환경)
            paramMap.put("parentCode", "FT05");
            List fieldEnvList = commService.listCode(paramMap);
            request.setAttribute("fieldEnvList", fieldEnvList) ;
            
            // 전문 분야별 코드 리스트(도시, 건축)
            paramMap.put("parentCode", "FT06");
            List fieldConsList = commService.listCode(paramMap);
            request.setAttribute("fieldConsList", fieldConsList);
            
        } else if(method.equalsIgnoreCase("viewEvaluMbrCommit")) {
        	
        	// 이메일 도메인 코드 리스트
            paramMap.put("parentCode", "EMAIL_CD");
            List emailCdCodeList = commService.listCode(paramMap);
            request.setAttribute("emailCdCodeList", emailCdCodeList) ;

            // 휴대폰 국번 코드 리스트
            paramMap.put("parentCode", "CELL_FNUM");
            List phoneFNumCodeList = commService.listCode(paramMap);
            request.setAttribute("phoneFNumCodeList", phoneFNumCodeList) ;
            
            // 직종 리스트
            paramMap.put("parentCode", "OCCUPA_TYPE");
            List occupaList = commService.listCode(paramMap);
            request.setAttribute("occupaList", occupaList);
            
            // 전문 분야별 코드 리스트(관광)
            paramMap.put("parentCode", "FT01");
            List fieldTravList = committeeService.listCommitDetailField(paramMap);
            request.setAttribute("fieldTravList", fieldTravList) ;
            
            // 전문 분야별 코드 리스트(경제, 경영)
            paramMap.put("parentCode", "FT02");
            List fieldEcoList = committeeService.listCommitDetailField(paramMap);
            request.setAttribute("fieldEcoList", fieldEcoList) ;
            
            // 전문 분야별 코드 리스트(문화)
            paramMap.put("parentCode", "FT03");
            List fieldCultList = committeeService.listCommitDetailField(paramMap);
            request.setAttribute("fieldCultList", fieldCultList) ;
            
            // 전문 분야별 코드 리스트(콘텐츠)
            paramMap.put("parentCode", "FT04");
            List fieldContList = committeeService.listCommitDetailField(paramMap);
            request.setAttribute("fieldContList", fieldContList) ;
            
            // 전문 분야별 코드 리스트(환경)
            paramMap.put("parentCode", "FT05");
            List fieldEnvList = committeeService.listCommitDetailField(paramMap);
            request.setAttribute("fieldEnvList", fieldEnvList) ;
            
            // 전문 분야별 코드 리스트(도시, 건축)
            paramMap.put("parentCode", "FT06");
            List fieldConsList = committeeService.listCommitDetailField(paramMap);
            request.setAttribute("fieldConsList", fieldConsList);
        }
    }

}

