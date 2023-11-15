package business.biz.mng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
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
import business.biz.evalu.EvaluMgmtService;
import business.biz.evalu.domain.EvaluBusiMgmtDomain;
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
 *  Evalu Busi Mgmt Controller Class
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
public class EvaluBusiMgmtController extends BaseController {

    @Autowired
    private CommService  commService;
        
	@Autowired
    private FileService  fileService;
	
	@Autowired
    private EvaluBusiMgmtService  evaluBusiMgmtService;
	
	@Autowired
    private EvaluEnvService  evaluEnvService;
	
	@Autowired
    private EvaluMgmtService evaluMgmtService;
	
	@Resource(name="fileManager")
    FileManager fileManager;
	
	@Autowired
    private FileController fileController;
	
	// 사업코드 변수
    public static final String BS_CODE				= "EV"; // EVTDSS 사업 공통 부여 코드
	
	//################################################################
	//	평가사업관리
	//################################################################	
    
	/**
     * [관리자] 평가사업관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/listEvaluBusiMgmt.do")
    public String listEvaluBusiMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
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
        
        return "mng/listEvaluBusiMgmt";
    }
    
    /**
     *  [관리자] 평가사업관리 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/getEvaluBusiMgmt.do")
    public ModelAndView getEvaluBusiMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));
        
        PaginatedArrayList list = null;
        list = evaluBusiMgmtService.listEvaluBusiMgmt(paramMap, CURR_PAGE, PAGE_SIZE);
        
        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    
    
    /**
     * [관리자] 평가사업 등록 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/regiEvaluBusi.do")
    public ModelAndView regiEvaluBusi(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        ///paramMap.put("startParentCode", evaluItem);
        String resultParam = evaluBusiMgmtService.regiEvaluBusiStage(paramMap);
        
        Map returnMap   = new HashMap();
        returnMap.put("resultParam", resultParam);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가단계 존재 여부 체크 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/checkEvaluStage.do")
    public ModelAndView checkEvaluStage(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiMgmtService.checkEvaluStage(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가단계 삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/deltEvaluStage.do")
    public ModelAndView deltEvaluStage(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int deleteResult = evaluBusiMgmtService.deltEvaluStage(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("deleteResult", deleteResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    
    /**
     * [관리자] 평가지침 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/viewEvaluBusiGuide.do")
    public String viewEvaluBusiGuide(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가 정보
        //Map busiInfo = evaluBusiMgmtService.viewEvaluBusiInfo(paramMap);
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);
        
        // 평가이력 조회
        //List evaluBusiHistList = evaluBusiMgmtService.listEvaluBusiHist(paramMap);
        
        // 평가지침서 조회
        Map evaluDocA = evaluBusiMgmtService.viewEvaluAFile(paramMap);
        // 서면검토서 조회
        Map evaluDocB = evaluBusiMgmtService.viewEvaluBFile(paramMap);
        // 평가의견서 조회
        Map evaluDocC = evaluBusiMgmtService.viewEvaluCFile(paramMap);
        
        // 평가진행이력 체크
        Map checkStagekHist = evaluBusiMgmtService.checkEvaluStageHist(paramMap);
        
        
        List areaFileList = null;
        List areaFormList = null;
        
        //----------------------
        // 파일 리스트 조회
        //----------------------
        Map fpMap = new HashMap();
        fpMap.put("rootNo", paramMap.get("evaluBusiNo"));
        
        // [사업대상지 정보] 부분 첨부파일 리스트 조회.
        fpMap.put("docuType", evaluBusiMgmtService.FL_DOCU_TYPE_AREA);
        areaFileList = evaluBusiMgmtService.listTodeFile(fpMap);
        
        System.out.println("areaFileList : " + areaFileList);
        
        // 사업 대상지 정보 form을 구성하는 list
        areaFormList = new ArrayList();
        Map a01Map = new HashMap();
        Map a02Map = new HashMap();
        Map a03Map = new HashMap();
        Map a04Map = new HashMap();
        Map a05Map = new HashMap();
        Map a06Map = new HashMap();
        a01Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_01);
        a02Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_02);
        a03Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_03);
        a04Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_04);
        a05Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_05);
        a06Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_06);
        a01Map.put("title"   , "조감도");
        a02Map.put("title"   , "위치도(교통현황도)");
        a03Map.put("title"   , "토지이용계획도");
        a04Map.put("title"   , "시설배치도");
        a05Map.put("title"   , "위성사진(개발현황도)");
        a06Map.put("title"   , "현장사진");
        areaFormList.add(a01Map);
        areaFormList.add(a02Map);
        areaFormList.add(a03Map);
        areaFormList.add(a04Map);
        areaFormList.add(a05Map);
        areaFormList.add(a06Map);
        
        // 사업 정보
        Map mastMap = evaluBusiMgmtService.viewTodeMgmtMast(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("mastMap",  mastMap);
        model.addAttribute("evaluInfo",  evaluInfo);
        model.addAttribute("areaFileList" ,  areaFileList);
        model.addAttribute("areaFormList" ,  areaFormList);
        model.addAttribute("evaluDocA" ,  evaluDocA);
        model.addAttribute("evaluDocB" ,  evaluDocB);
        model.addAttribute("evaluDocC" ,  evaluDocC);
        model.addAttribute("checkStagekHist" ,  checkStagekHist);
        //model.addAttribute("busiInfo",  busiInfo); 
        //model.addAttribute("evaluBusiHistList",  evaluBusiHistList);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        //setEvaluRtnSessionFg(request, model);
        
        return "mng/viewEvaluBusiGuide";
    }
    
    /**
     * [관리자] 평가지침 파일업로드 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/evaluFileUpload.do")
    public ModelAndView evaluFileUpload(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String msg          = "";
        String resultM		= "";
    	
    	//int checkResult = evaluBusiMgmtService.checkEvaluStage(paramMap);
        
        //------------------
        // 파일 처리 부분
        //------------------
        

        List<Map> upfileInfoList = fileManager.multiFileUploadEvalu02(request);
        
        System.out.println("upfileInfoList : " + upfileInfoList);
        
        for(Map map : upfileInfoList) {
        	paramMap.put("fileSize", map.get("fileSize"));
        	paramMap.put("tempDir", map.get("tempDir"));
        	paramMap.put("idx", map.get("idx"));
        	paramMap.put("fileSvrNm", map.get("fileSvrNm"));
        	paramMap.put("fileOrgNm", map.get("fileOrgNm"));
        }
        
        System.out.println("paramMap :: " + paramMap);
        
        String resultFIle = evaluBusiMgmtService.regiEvaluFile(paramMap);
        
        //paramMap.put("fileSize", upfileInfoList.)
        
        //----------------------
        // 저장 처리.
        //----------------------
        
        // 메시지가 없으면 성공/있으면 실패.
        //msg = evaluMgmtService.saveEvaluMgmt(paramMap, upfileInfoList);
        
        if( !CommUtils.empty(msg) ) {
        	resultM = "false";
        } else {
        	resultM = "true";
        }
        
    	
    	Map returnMap   = new HashMap();
        //returnMap.put("checkResult", checkResult);
    	returnMap.put("resultM", resultM);
    	
    	//return new ModelAndView(ajaxView, returnMap);
    	return new ModelAndView("redirect:/mng/viewEvaluBusiGuide.do",paramMap);
    }
    
    /**
     * [관리자] 평가지침 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/updtEvaluGuideState.do")
    public ModelAndView updtEvaluGuideState(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiMgmtService.updtEvaluGuideState(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 실행계획 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/viewEvaluBusiPlan.do")
    public String viewEvaluBusiPlan(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가 정보
        //Map busiInfo = evaluBusiMgmtService.viewEvaluBusiInfo(paramMap);
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);
        
        // 평가진행이력 체크
        Map checkStagekHist = evaluBusiMgmtService.checkEvaluStageHist(paramMap);
        
        // 평가일정 조회
        List<Map> detailPlanList = evaluBusiMgmtService.listEvaluDetailPlan(paramMap);
        
        // 평가위원 조회
        List<Map> evaluCommitList = evaluBusiMgmtService.listEvaluCommit(paramMap);
        
        System.out.println("오나요11111111111111111");
        
        Map commitMap01 = new HashMap();
        Map commitMap02 = new HashMap();
        Map commitMap03 = new HashMap();
        
        Map planMap01 = new HashMap();
        Map planMap02 = new HashMap();
        Map planMap03 = new HashMap();
        Map planMap04 = new HashMap();
        Map planMap05 = new HashMap();
        
        int commit_count = 1;
        
        for(Map map : evaluCommitList) {
        	if(commit_count == 1) {
        		commitMap01.put("USER_ID", map.get("USER_ID"));
        		commitMap01.put("USER_NM", map.get("USER_NM"));
        		commitMap01.put("REGI_DATE", map.get("REGI_DATE"));
        	} else if(commit_count == 2) {
        		commitMap02.put("USER_ID", map.get("USER_ID"));
        		commitMap02.put("USER_NM", map.get("USER_NM"));
        		commitMap02.put("REGI_DATE", map.get("REGI_DATE"));
        	} else if(commit_count == 3) {
        		commitMap03.put("USER_ID", map.get("USER_ID"));
        		commitMap03.put("USER_NM", map.get("USER_NM"));
        		commitMap03.put("REGI_DATE", map.get("REGI_DATE"));
        	} 
        	
        	commit_count++;
        }
        
        for(Map map : detailPlanList) {
        	
        	String detailStageCode = (String)map.get("EVALU_DETAIL_STAGE");
        	
        	if(detailStageCode.equals("DS01")) {
        		planMap01.putAll(map);
        	} else if(detailStageCode.equals("DS02")) {
        		planMap02.putAll(map);
        	} else if(detailStageCode.equals("DS03")) {
        		planMap03.putAll(map);
        	} else if(detailStageCode.equals("DS04")) {
        		planMap04.putAll(map);
        	} else if(detailStageCode.equals("DS05")) {
        		planMap05.putAll(map);
        	}
        }
        
        
        List areaFileList = null;
        List areaFormList = null;
        
        //----------------------
        // 파일 리스트 조회
        //----------------------
        Map fpMap = new HashMap();
        fpMap.put("rootNo", paramMap.get("evaluBusiNo"));
        
        // [사업대상지 정보] 부분 첨부파일 리스트 조회.
        fpMap.put("docuType", evaluBusiMgmtService.FL_DOCU_TYPE_AREA);
        areaFileList = evaluBusiMgmtService.listTodeFile(fpMap);
        
        System.out.println("areaFileList : " + areaFileList);
        
        // 사업 대상지 정보 form을 구성하는 list
        areaFormList = new ArrayList();
        Map a01Map = new HashMap();
        Map a02Map = new HashMap();
        Map a03Map = new HashMap();
        Map a04Map = new HashMap();
        Map a05Map = new HashMap();
        Map a06Map = new HashMap();
        a01Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_01);
        a02Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_02);
        a03Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_03);
        a04Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_04);
        a05Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_05);
        a06Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_06);
        a01Map.put("title"   , "조감도");
        a02Map.put("title"   , "위치도(교통현황도)");
        a03Map.put("title"   , "토지이용계획도");
        a04Map.put("title"   , "시설배치도");
        a05Map.put("title"   , "위성사진(개발현황도)");
        a06Map.put("title"   , "현장사진");
        areaFormList.add(a01Map);
        areaFormList.add(a02Map);
        areaFormList.add(a03Map);
        areaFormList.add(a04Map);
        areaFormList.add(a05Map);
        areaFormList.add(a06Map);
        
        // 사업 정보
        Map mastMap = evaluBusiMgmtService.viewTodeMgmtMast(paramMap);
        
        System.out.println("오나요22222222222222222222");
        
        Map rtnMap = null;
        
        //rtnMap = evaluMgmtService.viewAllEvaluInfo(paramMap);
        
        System.out.println("오나요33333333333333333333");
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("mastMap",  mastMap);
        model.addAttribute("evaluInfo",  evaluInfo);
        model.addAttribute("checkStagekHist",  checkStagekHist);
        model.addAttribute("areaFileList" ,  areaFileList);
        model.addAttribute("areaFormList" ,  areaFormList);
        //model.addAttribute("rtnMap", rtnMap);
        model.addAttribute("commitMap01" ,  commitMap01);
        model.addAttribute("commitMap02" ,  commitMap02);
        model.addAttribute("commitMap03" ,  commitMap03);
        model.addAttribute("planMap01" ,  planMap01);
        model.addAttribute("planMap02" ,  planMap02);
        model.addAttribute("planMap03" ,  planMap03);
        model.addAttribute("planMap04" ,  planMap04);
        model.addAttribute("planMap05" ,  planMap05);
        //model.addAttribute("busiInfo",  busiInfo); 
        //model.addAttribute("evaluBusiHistList",  evaluBusiHistList);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        //setEvaluRtnSessionFg(request, model);
        
        return "mng/viewEvaluBusiPlan";
    }
    
    /**
     * [관리자] 평가위원 등록 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/regiEvaluCommit.do")
    public ModelAndView regiEvaluCommit(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
    	String checkResult = evaluBusiMgmtService.regiEvaluCommit(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	//return new ModelAndView(ajaxView, returnMap);
        return new ModelAndView(ajaxView,paramMap);
    }
    
    /**
     * [관리자] 평가위원 삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/deltEvaluCommit.do")
    public ModelAndView deltEvaluCommit(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiMgmtService.deltEvaluCommit(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
        return new ModelAndView(ajaxView,paramMap);
    }
    
    /**
     * [관리자] 실행계획 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/updtEvaluPlanState.do")
    public ModelAndView updtEvaluPlanState(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiMgmtService.updtEvaluPlanState(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가일정 저장 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/getEvaluDetailPlan.do")
    public ModelAndView getEvaluDetailPlan(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	//int checkResult = evaluBusiMgmtService.updtEvaluGuideState(paramMap);
        
        int deltResult = evaluBusiMgmtService.deltEvaluDetailPlan(paramMap);
        
        String ds01_stt = (String)paramMap.get("ds01_stt_date");
        String ds01_end = (String)paramMap.get("ds01_end_date");
        String ds02_stt = (String)paramMap.get("ds02_stt_date");
        String ds02_end = (String)paramMap.get("ds02_end_date");
        String ds03_stt = (String)paramMap.get("ds03_stt_date");
        String ds04_stt = (String)paramMap.get("ds04_stt_date");
        String ds05_stt = (String)paramMap.get("ds05_stt_date");
        
        if(!ds01_stt.isEmpty())  {
        	paramMap.put("evaluDetailStage", "DS01");
        	paramMap.put("evaluDetailSttDate", ds01_stt);
        	paramMap.put("evaluDetailEndDate", ds01_end);
        	
        	evaluBusiMgmtService.regiEvaluDetailPlan(paramMap);
        }
        if(!ds02_stt.isEmpty())  {
        	paramMap.put("evaluDetailStage", "DS02");
        	paramMap.put("evaluDetailSttDate", ds02_stt);
        	paramMap.put("evaluDetailEndDate", ds02_end);
        	
        	evaluBusiMgmtService.regiEvaluDetailPlan(paramMap);
        }
        if(!ds03_stt.isEmpty())  {
        	paramMap.put("evaluDetailStage", "DS03");
        	paramMap.put("evaluDetailSttDate", ds03_stt);
        	paramMap.put("evaluDetailEndDate", null);
        	
        	evaluBusiMgmtService.regiEvaluDetailPlan(paramMap);
        }
        if(!ds04_stt.isEmpty())  {
        	paramMap.put("evaluDetailStage", "DS04");
        	paramMap.put("evaluDetailSttDate", ds04_stt);
        	paramMap.put("evaluDetailEndDate", null);
        	
        	evaluBusiMgmtService.regiEvaluDetailPlan(paramMap);
        }
        if(!ds05_stt.isEmpty())  {
        	paramMap.put("evaluDetailStage", "DS05");
        	paramMap.put("evaluDetailSttDate", ds05_stt);
        	paramMap.put("evaluDetailEndDate", null);
        	
        	evaluBusiMgmtService.regiEvaluDetailPlan(paramMap);
        }
    	
    	Map returnMap   = new HashMap();
        //returnMap.put("checkResult", checkResult);
    	
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
        // 화면별 설정.
        //---------------------------------------------------
        
        // 관리 list화면
        if (method.equalsIgnoreCase("listEvaluMgmt") ) {
        }
        // 조회 list화면
        else if (method.equalsIgnoreCase("listEvaluMgmtSrch") ) {
        }
        // [사업개요] 탭 저장시 설정
        else if (method.equalsIgnoreCase("saveEvaluMgmtSumm") ) {
            // 등록시 로그인 SESSION에서 자동으로 설정. (신규 등록시에만 사용되는 항목)
//            paramMap.put("uscmNo"       , paramMap.get("gsUscmNo"    ));
//            paramMap.put("reqUserNm"    , paramMap.get("gsUserNm"    ));
//            paramMap.put("reqDeptNm"    , paramMap.get("gsDeptNm"    ));
//            paramMap.put("reqTelNo"     , paramMap.get("gsTelNo"     ));
//            paramMap.put("reqEmail"     , paramMap.get("gsEmail"     ));
            
            String reqCityauthCd = (String)paramMap.get("cityauth1");
            
            //코드가 3자리일 경우 앞에 0을 붙임
            if(reqCityauthCd.length()==3) {
            	reqCityauthCd = "0"+reqCityauthCd;
            }
            
            paramMap.put("reqCityauthCd", reqCityauthCd);
        }
        // [사업개요] 탭 열기시 설정.
        else if (method.equalsIgnoreCase("openRegiEvaluMgmtSumm") || method.equalsIgnoreCase("openUpdtEvaluMgmtSumm")) {
            
        }
        
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
        if(CommUtils.empty(reqReferer)) {
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
        paramMap.put("bsCode", BS_CODE);
        // 리스트화면 구성 관련 
        if (method.equalsIgnoreCase("listEvaluBusiMgmt") || method.equalsIgnoreCase("listEvaluStgMgmt") || method.equalsIgnoreCase("listEvaluBudtMgmt")) {
            
            // [사업상태] 항목 콤보 객체
            paramMap.put("parentCode", "APPR_STAT");
            List apprStatComboList = commService.listCode(paramMap);
            request.setAttribute("apprStatComboList", apprStatComboList);
            
            // 평가단계
            paramMap.put("parentCode", "EVALU_ITEM");
            List busiStageComboList = commService.listEvaluCode(paramMap);
            request.setAttribute("busiStageComboList", busiStageComboList);
            
            // [소분류구분] 항목 콤보 객체
            paramMap.put("startParentCode", "BUSI_TYPE");
            paramMap.put("level"     , "1");
            List busiTypeComboList = commService.listCode(paramMap);
            request.setAttribute("busiTypeComboList", busiTypeComboList);
            // [세부시설유형] 항목 콤보 객체
            paramMap.put("startParentCode", "BUSI_TYPE");
            paramMap.put("level"     , "2");
            List busiCateComboList = commService.listCode(paramMap);
            request.setAttribute("busiCateComboList", busiCateComboList);
            
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
            
        }
        // [사업개요(Summ)] 탭 화면 구성 관련
        else if (method.equalsIgnoreCase("openRegiEvaluMgmtSumm") || method.equalsIgnoreCase("openUpdtEvaluMgmtSumm")) {
            
            // [정부부처] 항목 콤보 객체
            paramMap.put("parentCode", "GOV_DEPT_CD");
            List govDeptCdComboList = commService.listCode(paramMap);
            request.setAttribute("govDeptCdComboList", FormTagManager.listToMapCombo(govDeptCdComboList, "govDeptCdComboList", ""));

            // [사업이 추진단계] 항목 콤보 객체
            paramMap.put("parentCode", "BUSI_STAH_STAGE");
            List busiStahStageComboList = commService.listCode(paramMap);
            request.setAttribute("busiStahStageComboList", FormTagManager.listToMapCombo(busiStahStageComboList, "busiStahStageComboList", ""));
            
            //지자체코드 콤보 객체
            paramMap.put("parentCode", "COMM.CITYAUTH");
            List cityauth1List = commService.listComboCode(paramMap);
            request.setAttribute("cityauth1List", cityauth1List);
            
            // [사업구분] 항목 콤보 객체
            paramMap.put("startParentCode", "BUSI_TYPE");
            paramMap.put("level"     , "1");
            List busiTypeComboList = commService.listCode(paramMap);
            request.setAttribute("busiTypeComboList", busiTypeComboList);
            // [사업유형] 항목 콤보 객체
            paramMap.put("startParentCode", "BUSI_TYPE");
            paramMap.put("level"     , "2");
            List busiCateComboList = commService.listCode(paramMap);
            request.setAttribute("busiCateComboList", busiCateComboList);
            
            // [사업유형] 항목 콤보 객체
            paramMap.put("startParentCode", "ATTH_TYPE");
            paramMap.put("level"     , "1");
            List atthTypeComboList = commService.listCode(paramMap);
            request.setAttribute("atthTypeComboList", atthTypeComboList);
            
            // [사업구분] 항목 콤보 객체	㎡, ㎢, m
            List totSiteUnit = new ArrayList ();
            Map srchType1Map = new HashMap();
            srchType1Map.put("code"  , "㎡");
            srchType1Map.put("codeNm", "㎡");
            totSiteUnit.add(srchType1Map);
            Map srchType2Map = new HashMap();
            srchType2Map.put("code"  , "㎢");
            srchType2Map.put("codeNm", "㎢");
            totSiteUnit.add(srchType2Map);
            Map srchType3Map = new HashMap();
            srchType3Map.put("code"  , "m");
            srchType3Map.put("codeNm", "m");
            totSiteUnit.add(srchType3Map);
            Map srchType4Map = new HashMap();
            srchType4Map.put("code"  , "㎞");
            srchType4Map.put("codeNm", "㎞");
            totSiteUnit.add(srchType4Map); 
            request.setAttribute("totSiteUnit", FormTagManager.listToMapCombo(totSiteUnit, "totSiteUnit", "NULL"));
            request.setAttribute("totFcltUnit", FormTagManager.listToMapCombo(totSiteUnit, "totFcltUnit", "NULL"));
           
        }
        //평가계획 수립화면
        else if(method.equalsIgnoreCase("regiEvaluStgMgmt")) {
        	
            // [정부부처] 항목 콤보 객체
            paramMap.put("parentCode", "EVALU_ITEM");
            List evaluItemCdComboList = commService.listEvaluCode(paramMap);
            request.setAttribute("evaluItemCdComboList", evaluItemCdComboList);

            // 사전평가대상 콤보
            List evaluAssment = new ArrayList ();
            Map srchType1Map = new HashMap();
            srchType1Map.put("code"  , "Y");
            srchType1Map.put("codeNm", "사전평가대상");
            evaluAssment.add(srchType1Map);
            Map srchType2Map = new HashMap();
            srchType2Map.put("code"  , "N");
            srchType2Map.put("codeNm", "비사전평가대상");
            evaluAssment.add(srchType2Map);
            request.setAttribute("evaluAssmentComboList", evaluAssment);
        }
        
        else if(method.equalsIgnoreCase("viewEvaluBudtMgmt2")) {
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
            if(request.getParameter("evaluStage").equals("EVALU_CENT")) {
            	Map srchType4Map = new HashMap();
                srchType4Map.put("code"  , "R");
                srchType4Map.put("codeNm", "재검토");
                finlRestlSel.add(srchType4Map);
            }
            request.setAttribute("finlRestlSelComboList", finlRestlSel);
        }
        
        // 평가이력 화면
        else if(method.equalsIgnoreCase("viewEvaluBusiHist")) {
        	
        	// 평가단계 조회
        	paramMap.put("useYn", "Y");
        	List evaluStageList = evaluEnvService.listEvaluEnvStep(paramMap);
        	
        	request.setAttribute("evaluStageList", evaluStageList);
        	
        }
        // 2023.11.10 LHB [관리자] 평가사업관리 > 평가이력
        else if(method.equalsIgnoreCase("viewEvaluBusiMgmtHist")) {
        	
        	// 평가단계 조회
        	paramMap.put("parentCode", "EVALU_STAGE");
        	paramMap.put("useYn", "Y");
            List evaluStageList = commService.listCode(paramMap);
        	
        	request.setAttribute("evaluStageList", evaluStageList);
        	
        }
        
    }
    
    //################################################################
    //SUNDOSOFT 평가사업관리 > 평가사업등록
    //################################################################

    /**
     * [관리자] 평가사업관리 > 평가사업등록 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
    */		
    @RequestMapping(value="/mng/regiEvaluBusiMgmt.do")
    public String regiEvaluBusiMgmt(HttpServletRequest request, ModelMap model) throws Exception {
    	//---------------------------------------------
    	// Default Value Setting
    	String method	= getMethodName(new Throwable());
    	Map paramMap	= setMappingValues(request, method);
		// default domain setting
		EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain();
		BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
		//---------------------------------------------
		
		paramMap.put("parentCode",	"NONE");
		paramMap.put("addCol01",	"BUSI_TYPE_LEVEL1");
        List busiTypeLevel1ComboList = commService.listCode(paramMap);
		
		model.addAttribute("model"   ,  evaluBusiMgmtDomain);
		model.addAttribute("paramMap",  paramMap);
		model.addAttribute("busiTypeLevel1ComboList",  busiTypeLevel1ComboList);
		
		return "mng/regiEvaluBusiMgmt";
    }
    
    /**
     *  [관리자] 평가사업관리 > 평가사업목록 호출
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/getListEvaluBusiMgmt.do")
    public ModelAndView getListEvaluBusiMgmt(HttpServletRequest request, ModelMap model) throws Exception {
    	
        //---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method );
        // default domain setting
       
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain(); 
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));
        
        PaginatedArrayList list = null;
        list = evaluBusiMgmtService.listEvaluBusiMgmt(paramMap, CURR_PAGE, PAGE_SIZE);
        
        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가사업관리 > 평가사업등록 등록 처리
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/saveEvaluBusiMgmt.do")
    public String saveEvaluBusiMgmt(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain();
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
        int result = 0;
        try {
        	result = evaluBusiMgmtService.regiEvaluBusiMgmt(paramMap);
        } catch (UncategorizedSQLException ue) {
        	logger.error("error :: ", ue);
        	result = 0;
        } catch (Exception e) {
        	logger.error("error :: ", e);
        	result = 0;
        }
        
        if (result > 0) {
        	resultFlag("평가사업 등록이 완료되었습니다.");
        } else {
        	resultFlag("평가사업 등록에 실패했습니다. 입력 값을 확인해주세요.");
        	return "redirect:/mng/regiEvaluBusiMgmt.do";
        }
        
        model.addAttribute("model"   ,  evaluBusiMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        return "redirect:/mng/listEvaluBusiMgmt.do";
    }
    
    /**
     * [관리자] 평가사업관리 > 평가사업이력 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/viewEvaluBusiMgmtHist.do")
    public String viewEvaluBusiMgmtHist(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain();
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가사업 정보
        Map busiInfo = evaluBusiMgmtService.viewEvaluBusiMgmt(paramMap);
        
        // 평가이력 조회
        List evaluBusiMgmtHistList = evaluBusiMgmtService.listEvaluBusiMgmtHist(paramMap);
        
        // 평가진행이력 체크
        Map checkStagekHist = evaluBusiMgmtService.checkEvaluStageHist(paramMap);
        
        model.addAttribute("model"   ,  evaluBusiMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("busiInfo",  busiInfo); 
        model.addAttribute("evaluBusiMgmtHistList",  evaluBusiMgmtHistList);
        model.addAttribute("checkStagekHist",  checkStagekHist);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        //setEvaluRtnSessionFg(request, model);
        
        return "mng/viewEvaluBusiMgmtHist";
    }
    
    /**
     * [관리자] 평가사업관리 > 평가사업이력 확인
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mng/chckEvaluBusiMgmtHist.do")
    public ModelAndView chckEvaluBusiMgmtHist(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
       
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain(); 
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int result = evaluBusiMgmtService.chckEvaluBusiMgmtHist(paramMap);
    	
    	Map returnMap = new HashMap();
    	returnMap.put("code", result);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가사업관리 > 평가사업등록 등록 처리
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/regiEvaluBusiMgmtHist.do")
    public ModelAndView regiEvaluBusiMgmtHist(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain();
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
        int result = 0;
        try {
        	result = evaluBusiMgmtService.regiEvaluBusiMgmtHist(paramMap);
        } catch (UncategorizedSQLException ue) {
        	logger.error("error :: ", ue);
        	result = 0;
        } catch (Exception e) {
        	logger.error("error :: ", e);
        	result = 0;
        }
        
        Map returnMap = new HashMap();
        
        if (result > 0) {
        	returnMap.put("code",	"1");
        	returnMap.put("msg",	"평가사업 등록이 완료되었습니다.");
        } else {
        	returnMap.put("code",	"-1");
        	returnMap.put("msg",	"평가사업 등록에 실패했습니다. 관리자에게 문의해주세요.");
        }
        
        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [관리자] 평가사업관리 > 평가사업상세 > 사업관리 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/viewEvaluBusiMgmtGuide.do")
    public String viewEvaluBusiMgmtGuide(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain();
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
        
        // 평가사업 정보 (평가이력 일련번호 번호로 조회)
        Map evaluInfo = evaluBusiMgmtService.viewEvaluBusiMgmtByHist(paramMap);
        BeanUtils.copyProperties(evaluBusiMgmtDomain, evaluInfo);
        
        // 평가사업 이력 상세조회
        Map evaluBusiMgmtHistInfo = evaluBusiMgmtService.viewEvaluBusiMgmtHist(paramMap);
        BeanUtils.copyProperties(evaluBusiMgmtDomain, evaluBusiMgmtHistInfo);
        
        // 제출이력 조회
        List listEvaluBusiMgmtHistLog = evaluBusiMgmtService.listEvaluBusiMgmtHistLog(paramMap);
        
        // 평가지침서 조회
        Map evaluDocA = evaluBusiMgmtService.viewEvaluAFile(paramMap);
        // 서면검토서 조회
        Map evaluDocB = evaluBusiMgmtService.viewEvaluBFile(paramMap);
        // 평가의견서 조회
        Map evaluDocC = evaluBusiMgmtService.viewEvaluCFile(paramMap);
        
        // 평가진행이력 체크
        Map checkStagekHist = evaluBusiMgmtService.checkEvaluStageHist(paramMap);
        
        List areaFileList = null;
        List areaFormList = null;
        
        //----------------------
        // 파일 리스트 조회
        //----------------------
        Map fpMap = new HashMap();
        fpMap.put("rootNo", paramMap.get("evaluBusiNo"));
        
        // [사업대상지 정보] 부분 첨부파일 리스트 조회.
        fpMap.put("docuType", evaluBusiMgmtService.FL_DOCU_TYPE_AREA);
        areaFileList = evaluBusiMgmtService.listTodeFile(fpMap);
        
        System.out.println("areaFileList : " + areaFileList);
        
        // 사업 대상지 정보 form을 구성하는 list
        areaFormList = new ArrayList();
        Map a01Map = new HashMap();
        Map a02Map = new HashMap();
        Map a03Map = new HashMap();
        Map a04Map = new HashMap();
        Map a05Map = new HashMap();
        Map a06Map = new HashMap();
        a01Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_01);
        a02Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_02);
        a03Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_03);
        a04Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_04);
        a05Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_05);
        a06Map.put("atthType", evaluBusiMgmtService.FL_AREA_ATTH_TYPE_06);
        a01Map.put("title"   , "조감도");
        a02Map.put("title"   , "위치도(교통현황도)");
        a03Map.put("title"   , "토지이용계획도");
        a04Map.put("title"   , "시설배치도");
        a05Map.put("title"   , "위성사진(개발현황도)");
        a06Map.put("title"   , "현장사진");
        areaFormList.add(a01Map);
        areaFormList.add(a02Map);
        areaFormList.add(a03Map);
        areaFormList.add(a04Map);
        areaFormList.add(a05Map);
        areaFormList.add(a06Map);
        
        // 사업 정보
        Map mastMap = evaluBusiMgmtService.viewTodeMgmtMast(paramMap);
        
        model.addAttribute("model",					evaluBusiMgmtDomain);
        model.addAttribute("paramMap",				paramMap);
        model.addAttribute("mastMap",				mastMap);
        model.addAttribute("evaluInfo",				evaluInfo);
        model.addAttribute("listEvaluBusiMgmtHistLog",	listEvaluBusiMgmtHistLog);
        model.addAttribute("areaFileList",			areaFileList);
        model.addAttribute("areaFormList",			areaFormList);
        model.addAttribute("evaluDocA",				evaluDocA);
        model.addAttribute("evaluDocB",				evaluDocB);
        model.addAttribute("evaluDocC",				evaluDocC);
        model.addAttribute("checkStagekHist",		checkStagekHist);
        
        return "mng/viewEvaluBusiMgmtGuide";
    }
    
    /**
     * [관리자] 평가사업관리 > 평가사업상세 > 사업관리 개발사업 개요 수정
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/mng/saveEvaluBusiMgmtGuide.do")
    public ModelAndView saveEvaluBusiMgmtGuide(HttpServletRequest request, ModelMap model) throws Exception {
    	
    	//---------------------------------------------
        // Default Value Setting
    	String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        // default domain setting
        EvaluBusiMgmtDomain evaluBusiMgmtDomain = new EvaluBusiMgmtDomain();
        BeanUtils.copyProperties(evaluBusiMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluBusiSn = (String) paramMap.get("evaluBusiSn");
        String evaluHistSn = (String) paramMap.get("evaluHistSn");
        
        // 평가사업 정보
        Map busiInfo = evaluBusiMgmtService.viewEvaluBusiMgmt(paramMap);
        
        // 평가사업 이력 상세조회
        Map evaluBusiMgmtHistInfo = evaluBusiMgmtService.viewEvaluBusiMgmtHist(paramMap);
        
        int result = 0;
        try {
        	result = evaluBusiMgmtService.saveEvaluBusiMgmtGuide(paramMap);
        } catch (UncategorizedSQLException ue) {
        	logger.error("error :: ", ue);
        	result = 0;
        } catch (Exception e) {
        	logger.error("error :: ", e);
        	result = 0;
        }
        
        Map returnMap = new HashMap();
        
        if (result > 0) {
        	returnMap.put("code",	"1");
        	returnMap.put("msg",	"저장이 완료되었습니다.");
        } else {
        	returnMap.put("code",	"-1");
        	returnMap.put("msg",	"저장에 실패했습니다. 관리자에게 문의해주세요.");
        }
        
        return new ModelAndView(ajaxView, returnMap);
    }
}