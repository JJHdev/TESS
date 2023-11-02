package business.biz.busi;

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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import business.biz.FileController;
import business.biz.FileService;
import business.biz.FormTagManager;
import business.biz.additionals.AddtnlsService;
import business.biz.bbs.BbsService;
import business.biz.busi.domain.EvaluBusiDomain;
import business.biz.comm.CommService;
import business.biz.evalu.EvaluCommService;
import business.biz.evalu.EvaluMgmtService;
import business.biz.evalu.domain.EvaluMgmtDomain;
import business.biz.main.domain.MainDomain;
import business.biz.mng.EvaluBusiMgmtService;
import commf.message.Message;
import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.FileUtil;
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
 *    Date            Name                    Desc
 * ----------      --------    ---------------------------
 *  2018.11.26      lsz         Init.
 *
 * </pre>
 */

@Controller
@SuppressWarnings({ "rawtypes", "unused"})
public class EvaluBusiController extends BaseController {

    @Autowired
    private CommService  commService;

    @Autowired
    private FileService  fileService;

    @Autowired
    private EvaluBusiService  evaluBusiService;
    
    @Autowired
    private EvaluBusiMgmtService  evaluBusiMgmtService;
    
	@Autowired
    private EvaluMgmtService evaluMgmtService;

    @Resource(name="fileManager")
    FileManager fileManager;

    @Autowired
    private FileController fileController;

    //################################################################
    //   평가사업조회
    //################################################################

    /**
     * [평가사업조회] 2018 평가사업 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/busi/listEvaluBusi.do")
    public String listEvaluBusi(HttpServletRequest request, ModelMap model)
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

        return "busi/listEvaluBusi";
    }

    /**
     *  [평가사업조회] 2018 평가사업 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/getEvaluBusi.do")
    public ModelAndView getEvaluBusi(HttpServletRequest request, ModelMap model)
            throws Exception {

        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting

        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------

        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));
        
        PaginatedArrayList list = null;
        list = evaluBusiService.listEvaluBusi(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 2018 평가사업 상세 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/busi/viewEvaluBusi.do")
    public String viewEvaluBefore(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluBusiDomain evaluBusiDomain = new EvaluBusiDomain();
        BeanUtils.copyProperties(evaluBusiDomain, paramMap);
        //---------------------------------------------
        
        String url = "";
        
        Map commitMap01 = new HashMap();
        Map commitMap02 = new HashMap();
        Map commitMap03 = new HashMap();
    	
    	List areaFileList = null;
        List areaFormList = null;
        
        System.out.println("paramMap : " + paramMap);
        
        url = "busi/viewEvaluBusiInfo";
        
        if(String.valueOf(paramMap.get("gsRoleId")).equals("ROLE_AUTH_SYS")) {
        	
        	List commitAgreeList = evaluBusiService.listEvaluStageAgreeCommitList(paramMap);
        	List commitReviewList = evaluBusiService.listEvaluStageReviewCommitList(paramMap);
        	List commitOpinionList = evaluBusiService.listEvaluStageOpinionCommitList(paramMap);
        	
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
            
            Map rtnMap = null;
            
            rtnMap = evaluBusiService.viewAllEvaluInfo(paramMap);
            
            model.addAttribute("model"   ,  evaluBusiDomain);
            model.addAttribute("paramMap",  paramMap);
            model.addAttribute("mastMap",  mastMap);
            model.addAttribute("areaFileList" ,  areaFileList);
            model.addAttribute("areaFormList" ,  areaFormList);
            model.addAttribute("rtnMap", rtnMap);
            model.addAttribute("commitMap01" ,  commitMap01);
            model.addAttribute("commitMap02" ,  commitMap02);
            model.addAttribute("commitMap03" ,  commitMap03);
            
            model.addAttribute("commitAgreeList" ,  commitAgreeList);
            model.addAttribute("commitReviewList" ,  commitReviewList);
            model.addAttribute("commitOpinionList" ,  commitOpinionList);
        	
        	url = "busi/viewEvaluBusiInfo";
        	
        } else {
        	
        	Map viewCommitStatus = evaluBusiService.viewEvaluCommitStatus(paramMap);
        	
        	System.out.println("viewCommitStatus : " + viewCommitStatus);
        	
        	if(viewCommitStatus.get("AGREE_YN") != null && viewCommitStatus.get("AGREE_YN").equals("Y")) {
        		//model.addAttribute("viewCommitStatus",  viewCommitStatus);
        		paramMap.put("agreeYn", viewCommitStatus.get("AGREE_YN"));
        		paramMap.put("reviewYn", viewCommitStatus.get("REVIEW_YN"));
        		paramMap.put("opinionYn", viewCommitStatus.get("OPINION_YN"));
        		paramMap.put("agreeDate", viewCommitStatus.get("AGREE_DATE"));
        		paramMap.put("reviewApvYn", viewCommitStatus.get("REVIEW_APV_YN"));
        		paramMap.put("opinionApvYn", viewCommitStatus.get("OPINION_APV_YN"));
        		paramMap.put("reviewApvDate", viewCommitStatus.get("REVIEW_APV_DATE"));
        		paramMap.put("opinionApvDate", viewCommitStatus.get("OPINION_APV_DATE"));
        		
        		
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
                
                Map rtnMap = null;
                
                rtnMap = evaluBusiService.viewAllEvaluInfo(paramMap);
                
                model.addAttribute("model"   ,  evaluBusiDomain);
                model.addAttribute("paramMap",  paramMap);
                model.addAttribute("mastMap",  mastMap);
                model.addAttribute("areaFileList" ,  areaFileList);
                model.addAttribute("areaFormList" ,  areaFormList);
                model.addAttribute("rtnMap", rtnMap);
                model.addAttribute("commitMap01" ,  commitMap01);
                model.addAttribute("commitMap02" ,  commitMap02);
                model.addAttribute("commitMap03" ,  commitMap03);
        		
        		url = "busi/viewEvaluBusiInfo";
        	} else {
        		url = "busi/viewEvaluBefore";
        	}
        }
        
        System.out.println("url : " + url);
        
        // 평가정보 조회
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);
        
        // 첨부파일 조회
        List fileList = evaluBusiService.listEvaluBusiAtthFile(paramMap);
        
        model.addAttribute("model"   ,  evaluBusiDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("fileList", fileList);
        model.addAttribute("evaluInfo", evaluInfo);

        return url;
    }
    
    
    /**
     * [평가사업조회] 평가위원 평가진행현황 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/viewEvaluCommitStatus.do")
    public ModelAndView viewEvaluCommitStatus(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	Map resultMap = evaluBusiService.viewEvaluCommitStatus(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("resultMap", resultMap);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가위원 이용 동의서 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluCommitAgree.do")
    public ModelAndView updtEvaluCommitAgree(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiService.updtEvaluCommitAgree(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가위원 평가의견서 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluCommitOpinion.do")
    public ModelAndView updtEvaluCommitOpinion(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        System.out.println("paramMap ::::" + paramMap);
    	
    	int checkResult = evaluBusiService.updtEvaluCommitOpinion(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가위원 서면검토서 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluCommitReview.do")
    public ModelAndView updtEvaluCommitReview(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiService.updtEvaluCommitReview(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 2018 평가사업 평가정보 서면검토 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/busi/viewEvaluInfoStep01.do")
    public String viewEvaluInfoStep01(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluBusiDomain evaluBusiDomain = new EvaluBusiDomain();
        BeanUtils.copyProperties(evaluBusiDomain, paramMap);
        //---------------------------------------------
        
        // --- 참조파일
        // 평가지침서 샘플 조회
        Map evaluDocA = evaluBusiMgmtService.viewEvaluAFile(paramMap);
        // 서면검토서 샘플 조회
        Map evaluDocB = evaluBusiMgmtService.viewEvaluBFile(paramMap);
        
        
        // 평가정보 조회
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);
        
        if(String.valueOf(paramMap.get("gsRoleId")).equals("ROLE_AUTH_SYS")) {
        	
        	paramMap.put("atthType", "AT11");
        	List commitList = evaluBusiService.listEvaluCommitList(paramMap);
        	
        	System.out.println("commitList : " + commitList);
        	
        	model.addAttribute("commitList",  commitList);
        } else {
        	// 서류 상태
        	Map viewCommitStatus = evaluBusiService.viewEvaluCommitStatus(paramMap);
        	
        	// 첨부파일 정보
        	paramMap.put("atthType", "AT11");
        	Map fileInfo = evaluBusiService.getEvaluBusiAtthFile(paramMap);
        	
        	System.out.println("fileInfo : " + fileInfo);
        	
        	model.addAttribute("viewCommitStatus",  viewCommitStatus);
        	model.addAttribute("fileInfo",  fileInfo);
        }
        	
    	model.addAttribute("model"   ,  evaluBusiDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("evaluInfo",  evaluInfo);
        model.addAttribute("evaluDocA",  evaluDocA);
        model.addAttribute("evaluDocB",  evaluDocB);
        
        return "busi/viewEvaluInfoStep01";
    }

    /**
     * [평가사업조회] 평가위원 서면검토서 승인 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluCommitReviewApv.do")
    public ModelAndView updtEvaluCommitReviewApv(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiService.updtEvaluCommitReviewApv(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가위원 평가의견서 승인 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluCommitOpinionApv.do")
    public ModelAndView updtEvaluCommitOpinionApv(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiService.updtEvaluCommitOpinionApv(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
	    
    /**
     * [평가사업조회] 2018 평가사업 평가정보 평가의견 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/busi/viewEvaluInfoStep02.do")
    public String viewEvaluInfoStep02(HttpServletRequest request, ModelMap model)
            throws Exception {

    	//---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluBusiDomain evaluBusiDomain = new EvaluBusiDomain();
        BeanUtils.copyProperties(evaluBusiDomain, paramMap);
        //---------------------------------------------
        
        // --- 참조파일
        // 평가지침서 샘플 조회
        Map evaluDocA = evaluBusiMgmtService.viewEvaluAFile(paramMap);
        // 평가의견서 조회
        Map evaluDocC = evaluBusiMgmtService.viewEvaluCFile(paramMap);

        // 평가정보 조회
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);
        
        if(String.valueOf(paramMap.get("gsRoleId")).equals("ROLE_AUTH_SYS")) {
        	
        	paramMap.put("atthType", "AT12");
        	List commitList = evaluBusiService.listEvaluCommitList(paramMap);
        	
        	System.out.println("commitList : " + commitList);
        	
        	model.addAttribute("commitList",  commitList);
        	
        } else {
        	
        	// 서류 상태
        	Map viewCommitStatus = evaluBusiService.viewEvaluCommitStatus(paramMap);
        	
        	// 첨부파일 정보
        	paramMap.put("atthType", "AT12");
        	Map fileInfo = evaluBusiService.getEvaluBusiAtthFile(paramMap);
        	
        	System.out.println("fileInfo : " + fileInfo);
        	
        	model.addAttribute("viewCommitStatus",  viewCommitStatus);
        	model.addAttribute("fileInfo",  fileInfo);
        }
        
        model.addAttribute("model"   ,  evaluBusiDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("evaluInfo",  evaluInfo);
        model.addAttribute("evaluDocA",  evaluDocA);
        model.addAttribute("evaluDocC",  evaluDocC);

        return "busi/viewEvaluInfoStep02";
    }
    
    /**
     * [평가사업조회] 2018 평가사업 평가정보 종합결과 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/busi/viewEvaluInfoStep03.do")
    public String viewEvaluInfoStep03(HttpServletRequest request, ModelMap model)
            throws Exception {

    	//---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluBusiDomain evaluBusiDomain = new EvaluBusiDomain();
        BeanUtils.copyProperties(evaluBusiDomain, paramMap);
        //---------------------------------------------
        
        // 평가정보 조회
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);
        
        // 종합결과서 제출 여부 조회
        Map totalResultMap = evaluBusiService.getEvaluTotalResult(paramMap);
        
    	// 서류 상태
    	Map viewCommitStatus = evaluBusiService.viewEvaluCommitStatus(paramMap);
    	
    	// 첨부파일 정보
    	paramMap.put("atthType", "AT13");
    	paramMap.put("userId", "admin");
    	Map fileInfo = evaluBusiService.getEvaluBusiAtthFile(paramMap);
    	
    	System.out.println("fileInfo : " + fileInfo);
    	
    	model.addAttribute("viewCommitStatus",  viewCommitStatus);
    	model.addAttribute("fileInfo",  fileInfo);

        model.addAttribute("model"   ,  evaluBusiDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("evaluInfo",  evaluInfo);
        model.addAttribute("totalResultMap",  totalResultMap);

        return "busi/viewEvaluInfoStep03";
    }
    
    /**
     * [평가사업조회] 평가대상 종합결과서 상태 변경 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluTotalResult.do")
    public ModelAndView updtEvaluTotalResult(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
    	
    	int checkResult = evaluBusiService.updtEvaluTotalResult(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", checkResult);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 2018 평가사업 평가정보 평가종료 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/busi/viewEvaluInfoStep04.do")
    public String viewEvaluInfoStep04(HttpServletRequest request, ModelMap model)
            throws Exception {

    	//---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluBusiDomain evaluBusiDomain = new EvaluBusiDomain();
        BeanUtils.copyProperties(evaluBusiDomain, paramMap);
        //---------------------------------------------
        
        // 평가정보 조회
        Map evaluInfo = evaluBusiMgmtService.viewEvaluStageInfo(paramMap);

        model.addAttribute("model"   ,  evaluBusiDomain);
        model.addAttribute("paramMap",  paramMap);
        model.addAttribute("evaluInfo",  evaluInfo);

        return "busi/viewEvaluInfoStep04";
    }
    
    /**
     * [평가사업조회] 평가위원 종합의견 등록/삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/getEvaluOpinionNote.do")
    public ModelAndView getEvaluOpinionNote(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String type = (String)paramMap.get("opType");
        
        int result = 0;
        
        if(type.equals("I")) {
        	result = evaluBusiService.regiEvaluOpinionNote(paramMap);
        } else if(type.equals("D")) {
        	result = evaluBusiService.deltEvaluOpinionNote(paramMap);
        }
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", result);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가위원 개선사항 등록/삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/getEvaluIpmNote.do")
    public ModelAndView getEvaluIpmNote(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String type = (String)paramMap.get("ipmType");
        
        int result = 0;
        
        if(type.equals("I")) {
        	result = evaluBusiService.regiEvaluIpmNote(paramMap);
        } else if(type.equals("D")) {
        	result = evaluBusiService.deltEvaluIpmNote(paramMap);
        }
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", result);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가단계 종합의견 등록/삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/getEvaluFinalOpinionNote.do")
    public ModelAndView getEvaluFinalOpinionNote(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String type = (String)paramMap.get("opType");
        
        int result = 0;
        
        if(type.equals("I")) {
        	result = evaluBusiService.regiEvaluFinalOpinionNote(paramMap);
        } else if(type.equals("D")) {
        	result = evaluBusiService.deltEvaluFinalOpinionNote(paramMap);
        }
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", result);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가단계 개선사항 등록/삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/getEvaluFinalIpmNote.do")
    public ModelAndView getEvaluFinalIpmNote(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String type = (String)paramMap.get("ipmType");
        
        int result = 0;
        
        if(type.equals("I")) {
        	result = evaluBusiService.regiEvaluFinalIpmNote(paramMap);
        } else if(type.equals("D")) {
        	result = evaluBusiService.deltEvaluFinalIpmNote(paramMap);
        }
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", result);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [평가사업조회] 평가종료 승인 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/updtEvaluFinalApv.do")
    public ModelAndView updtEvaluFinalApv(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        int result = 0;
        
       	result = evaluBusiService.updtEvaluFinalApv(paramMap);
    	
    	Map returnMap   = new HashMap();
        returnMap.put("checkResult", result);
    	
    	return new ModelAndView(ajaxView, returnMap);
    }
    
    
    
    
    
    
    /**
     * [평가사업조회] 평가사업 파일업로드 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/evaluFileUpload.do")
    public ModelAndView evaluFileUpload(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
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
        
        String url = "";
        
        System.out.println("paramMap ::" + paramMap);
        
        if(paramMap.get("atthType").equals("AT11")) {
        	url = "redirect:/busi/viewEvaluInfoStep01.do";
        } else if(paramMap.get("atthType").equals("AT12")) {
        	url = "redirect:/busi/viewEvaluInfoStep02.do";
        } else if(paramMap.get("atthType").equals("AT13")) {
        	url = "redirect:/busi/viewEvaluInfoStep03.do";
        }
        

        List<Map> upfileInfoList = fileManager.multiFileUploadEvalu02(request);
        
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
    	return new ModelAndView(url,paramMap);
    }
    
    
    /**
     * [평가사업조회] 평가사업 파일 삭제 ajax.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/busi/evaluFileDelete.do")
    public ModelAndView evaluFileDelete(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
    	//---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        Map fileInfo = evaluBusiService.getDeleteAtthFile(paramMap);
        
        String serverFileName 	= CommUtils.nvlTrim((String)fileInfo.get("FILE_SVR_NM"));
		String path 			= CommUtils.nvlTrim((String)fileInfo.get("FILE_PATH"));
		
		// Server File Delete
		FileUtil.deleteFile(path + "/" + serverFileName);
		
		evaluBusiService.deptEvaluAtthFile(paramMap);
     
        return new ModelAndView(ajaxView,paramMap);
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
                || method.equalsIgnoreCase("listEvaluStgMgmt")       // 사업평가관리 리스트
                || method.equalsIgnoreCase("regiEvaluStgMgmt")       // 사업평가관리 등록
                || method.equalsIgnoreCase("listEvaluBudtMgmt")       // 사업평가관리 등록
                || method.equalsIgnoreCase("regiEvaluFinlBudtMgmt")       // 사업평가관리 등록
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
            if(reqCityauthCd.length()==3){
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
        if (method.equalsIgnoreCase("listEvaluBusi") || method.equalsIgnoreCase("listEvaluStgMgmt") || method.equalsIgnoreCase("listEvaluBudtMgmt")) {

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

            // [사업구분] 항목 콤보 객체   ㎡, ㎢, m
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
        else if(method.equalsIgnoreCase("regiEvaluStgMgmt")){

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

        else if(method.equalsIgnoreCase("viewEvaluBudtMgmt2")){
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
            if(request.getParameter("evaluStage").equals("EVALU_CENT")){
                Map srchType4Map = new HashMap();
                srchType4Map.put("code"  , "R");
                srchType4Map.put("codeNm", "재검토");
                finlRestlSel.add(srchType4Map);
            }
            request.setAttribute("finlRestlSelComboList", finlRestlSel);
        }

    }

}
