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
import business.biz.FileService;
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
public class EvaluMgmtController extends BaseController {
    
    @Autowired
    private EvaluMgmtService evaluMgmtService;
    
    @Autowired
    private CommService  commService;

    @Autowired
    private FileService  fileService;
    
    @Resource(name="fileManager")
    FileManager fileManager;
    
    @Autowired
    private FileController fileController;
    
//################################################################
//											사업정보입력
//################################################################
    
    /**
     * [사업관리] 사업등록 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/listEvaluMgmt.do")
    public String listEvaluMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
        return listEvaluMgmtDetail(request, model, getMethodName(new Throwable()));
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/getEvaluMgmt.do")
    public ModelAndView getEvaluMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        return getEvaluMgmtDetail(request, model, getMethodName(new Throwable()));
    }
    
    
    /**
     * 조회리스트화면에서 excel 다운로드 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/exclEvaluMgmt.do")
    public String exclEvaluMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, getMethodName(new Throwable()) );
        //---------------------------------------------
        
        // 대상 list 조회
        List list = evaluMgmtService.listEvaluMgmt(paramMap);
        
        // 엑셀 head 정보 설정.
        List titleList  = new ArrayList();
        LinkedMap titleMap  = new LinkedMap();
        titleMap.put("cityauthNm",     "지역");
        titleMap.put("busiCateNm",     "사업유형");
        titleMap.put("EvaluBusiNm",     "사업명");
        titleMap.put("convBusiPeriod", "사업기간");
        titleMap.put("apprStatNm",     "사업상태");
        titleMap.put("totSiteArea",    "부지면적(㎡)");
        titleMap.put("totFcltArea",    "전체시설면적(㎡)");
        titleMap.put("inputRate",      "입력율(%)");
        titleList.add(titleMap);
        
        model.addAttribute("titleList",  titleList);         // EXCEL TITLE
        model.addAttribute("filename",   "listEvaluMgmt");   // Template Excel File Name ( listSample_Template.xml )
        model.addAttribute("excelList",  list);             // Excel Data
        
        return "excelView";
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 화면이동 관련 공통 METHOD 사용 대상 METHODS
    // : 각 상세/등록/수정 화면은 공통 method (openDetailView ) 사용
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     *  [사업관리] 사업등록 상세화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/viewEvaluMgmtSumm.do")
    public String viewEvaluMgmtSumm(HttpServletRequest request, ModelMap model) throws Exception {
        openViewDetail(request,model, getMethodName(new Throwable()), EvaluCommService.TAB_SUMM);
        return "evalu/viewEvaluMgmtSumm";
    }
    
    /**
     *  [사업관리] 사업등록 신규등록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/openRegiEvaluMgmtSumm.do")
    public String openRegiEvaluMgmtSumm(HttpServletRequest request, ModelMap model) throws Exception {
        openViewDetail(request,model, getMethodName(new Throwable()), EvaluCommService.TAB_SUMM);
        return "evalu/regiEvaluMgmtSumm";
    }
    
    /**
     *  [사업관리] 사업등록 수정화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/openUpdtEvaluMgmtSumm.do")
    public String openUpdtEvaluMgmtSumm(HttpServletRequest request, ModelMap model) throws Exception {
        openViewDetail(request,model, getMethodName(new Throwable()), EvaluCommService.TAB_SUMM);
        return "evalu/regiEvaluMgmtSumm";
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 저장 :
    //
    // [사업개요] 탭    : saveEvaluMgmtSumm
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    
    /**
     *  [사업관리] 사업등록 저장 처리
     * @param request
     * @param model
     * @return
     * @throws Exception
     */   
    @RequestMapping("/evalu/saveEvaluMgmtSumm.do")
    public ModelAndView saveEvaluMgmtSumm(HttpServletRequest request, ModelMap model)
            throws Exception {
        Map rtnPMap = saveDetail(request, model, getMethodName(new Throwable()));
        return new ModelAndView("redirect:/evalu/openUpdtEvaluMgmtSumm.do",rtnPMap);
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 기타
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * [사업관리] 파일 다운로드
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/evalu/evaluFileDownload.do")
    public void EvaluFileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String EvaluFileNo = request.getParameter("EvaluFileNo");

        Map params = new HashMap();
        params.put("evaluFileNo", EvaluFileNo);

        Map fileInfo =  evaluMgmtService.viewEvaluFile(params);
        
        // 파일 컨트롤러 호출
        fileController.fileDownloadDetail(request, response, fileInfo);
    }
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // private controller method
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * [사업관리] 리스트 Ajax Method
     * @param request
     * @param model
     * @param method
     * @return
     * @throws Exception
     */
    private ModelAndView getEvaluMgmtDetail(HttpServletRequest request, ModelMap model, String method)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));

        PaginatedArrayList list = null;
        list = evaluMgmtService.listEvaluMgmt(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [사업관리] 리스트 Method
     * @param request
     * @param model
     * @param method
     * @return
     * @throws Exception
     */
    private String listEvaluMgmtDetail(HttpServletRequest request, ModelMap model, String method)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/listEvaluMgmt";
    }
    
    /**
     * [사업관리] 상세, 등록, 수정화면 Method
     * view (상세화면): viewEvaluMgmtSumm
     * regi (등록화면): regiEvaluMgmtSumm
     * updt (수정화면): regiEvaluMgmtSumm
     * 
     * @param request
     * @param model
     * @param method
     * @param tabFg
     * @return
     * @throws Exception
     */
    private void openViewDetail(HttpServletRequest request, ModelMap model, String method, String tabFg)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); ;
        //---------------------------------------------
        
        String mode     = (String)paramMap.get("mode");
        
        //-------------------------
        // Master 정보 조회: master정보는 모든 tab에서 참조할 수 있게 매번 조회
        //-------------------------
        // view 또는 updt이면 데이터 조회
        if(EvaluCommService.MODE_UPDT.equals(mode) || EvaluCommService.MODE_VIEW.equals(mode)){
            
            Map mastMap = evaluMgmtService.viewEvaluMgmtMast(paramMap);
            
            if(mastMap == null) {
                // msg : "대상 관광개발사업 정보를 조회하지 못했습니다."
                throw new EgovBizException(Message.getMessage("exception.Evalu.viewNotSrchEvaluInfo"));
            }
            
            // master domain 객체를 조회결과로 설정
            BeanUtils.copyProperties(evaluMgmtDomain, mastMap);
            model.addAttribute("mastMap"  ,  mastMap);
        }

        
        //-------------------------
        // [사업개요] 탭 화면 
        // - 관련tbl : BUSIMAST
        //-------------------------
        if(EvaluCommService.TAB_SUMM.equals(tabFg)){
            
            List plyyFileList = null;
            
            // view 또는 updt이면 데이터 조회
            if(EvaluCommService.MODE_REGI.equals(mode) == false){
                
                //----------------------
                // 파일 리스트 조회
                //----------------------
                Map fpMap = new HashMap<String, String>();
                
                fpMap.put("rootNo", paramMap.get("evaluBusiNo"));
                
                // [년도별 사업계획서] 부분 첨부파일 리스트 조회.
//                fpMap.put("docuType", EvaluCommService.FL_DOCU_TYPE_PLYY);
                fpMap.put("docuType", "PLYY");

                plyyFileList = evaluMgmtService.listEvaluFile(fpMap);
                
            }
            
            // 첨부파일 리스트 등록
            model.addAttribute("plyyFileList" ,  setEmptyRowInDyList(mode,plyyFileList) );
        }
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
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
     * [사업관리] 저장 처리 Method
     * @param request
     * @param model
     * @param method
     * @return
     * @throws Exception
     */
    private Map saveDetail(HttpServletRequest request, ModelMap model, String method)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        //---------------------------------------------
        
        String msg          = "";
        
        // 탭구분 값 설정.
        String tabFg = (String)paramMap.get("tabFg");
        // 년도별 입력화면 관련 구분값.
        String subMode = (String)paramMap.get("subMode");
        
        try {
            
            //------------------
            // 파일 처리 부분
            //------------------
        	
            List upfileInfoList = fileManager.multiFileUploadEvalu(request);
            
            //----------------------
            // 저장 처리.
            //----------------------
            
            // 메시지가 없으면 성공/있으면 실패.
            msg = evaluMgmtService.saveEvaluMgmt(paramMap, upfileInfoList);
            
            if( !CommUtils.empty(msg) ) {
                throw new EgovBizException(msg);
            }
            else {
                resultFlag(Message.getMessage("prompt.success"));
            }
            
        } catch (EgovBizException ebe) {
            throw ebe;
        } catch (Exception e) {
            throw e;
        }
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        Map rtnPMap = new HashMap();
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        
        // 저장후 검색조건 유지를 위해 parameter 추가
        String srchParamNms = "srchBusiAddr1,srchBusiAddr2,srchBusiAddrVal,srchBusiType,srchBusiCate,srchEvaluBusiNm,srchApprStat";
        String[] srchjParamArr = srchParamNms.split(",");
        for(int i=0;i<srchjParamArr.length;i++){
            String srchPmNm  = srchjParamArr[i];
            String srchPmVal = (String)paramMap.get(srchPmNm);
            if(!CommUtils.empty(srchPmVal)){
                rtnPMap.put(srchPmNm, srchPmVal);
            }
        }
        
        //-------------------------
        // 저장 성공 session값 설정.
        //-------------------------
        request.getSession().setAttribute(EvaluCommService.SESSKEY_EVALU_RTNFG, EvaluCommService.SESSVAL_EVALU_SUCC);
        
        return rtnPMap;
    }
    
 //################################################################
 //											사업평가관리
 //################################################################
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/listEvaluStgMgmt.do")
    public String listEvaluStgMgmt(HttpServletRequest request, ModelMap model)
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
        
        return "evalu/listEvaluStgMgmt";
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/getEvaluStgMgmt.do")
    public ModelAndView getEvaluStgMgmt(HttpServletRequest request, ModelMap model)
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
        list = evaluMgmtService.listEvaluStgMgmt(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/regiEvaluStgMgmt.do")
    public String regiEvaluStgMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String mode = (String)paramMap.get("mode");
        Map rtnMap = null;
        List	 evaluItemCdList = new ArrayList();
        
        if(mode.equals("updt")){
        	rtnMap = evaluMgmtService.viewAllEvaluInfo(paramMap);
        	
        	paramMap.put("startParentCode", paramMap.get("evaluStage"));
        	evaluItemCdList = commService.listEvaluCode(paramMap);
        }
        
        model.addAttribute("evaluItemCdList", evaluItemCdList);
        model.addAttribute("rtnMap", rtnMap);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/regiEvaluStgMgmt";
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/getBusiEvaluItem.do")
    public ModelAndView getEvaluItem(HttpServletRequest request, ModelMap model)
            throws Exception {
        
        //---------------------------------------------
        //Default Value Setting
    	String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
       
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain(); 
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluItem = (String)paramMap.get("evalu_item");
        
        // [정부부처] 항목 콤보 객체
        paramMap.put("startParentCode", evaluItem);
        List evaluItemCdComboList = commService.listEvaluCode(paramMap);

        Map returnMap   = new HashMap();
        returnMap.put("evaluItemCdComboList", evaluItemCdComboList);

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/openSelEvaluCommit.do")
    public String openSelEvaluCommit(HttpServletRequest request, ModelMap model)
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
        
        return "evalu/openSelEvaluCommit";
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/getEvaluCommit.do")
    public ModelAndView getEvaluCommit(HttpServletRequest request, ModelMap model)
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
        list = evaluMgmtService.listEvaluCommit(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluStgMgmt.do")
    public ModelAndView saveEvaluStgMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
        evaluMgmtService.saveEvaluStgMgmt(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        Map rtnPMap = new HashMap();
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        
        rtnPMap.put("mode",  (paramMap.get("mode").equals("regi")) ? "updt" : paramMap.get("mode"));
        
        // 저장후 검색조건 유지를 위해 parameter 추가
        String srchParamNms = "srchBusiAddr1,srchBusiAddr2,srchBusiAddrVal,srchBusiType,srchBusiCate,srchEvaluBusiNm,srchEvaluDate,";
        String[] srchjParamArr = srchParamNms.split(",");
        for(int i=0;i<srchjParamArr.length;i++){
            String srchPmNm  = srchjParamArr[i];
            String srchPmVal = (String)paramMap.get(srchPmNm);
            if(!CommUtils.empty(srchPmVal)){
                rtnPMap.put(srchPmNm, srchPmVal);
            }
        }
        
        return new ModelAndView("redirect:/evalu/regiEvaluStgMgmt.do",rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/listEvaluBudtMgmt.do")
    public String listEvaluBudtMgmt(HttpServletRequest request, ModelMap model)
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
        
        return "evalu/listEvaluBudtMgmt";
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/evalu/getEvaluBudtMgmt.do")
    public ModelAndView getEvaluBudtMgmt(HttpServletRequest request, ModelMap model)
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
        list = evaluMgmtService.listEvaluBudtMgmt(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluBudtMgmt.do")
    public String viewEvaluBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
        Map rtnMap = evaluMgmtService.viewEvaluBudtMgmt(paramMap);
        
        //----------------------
        // 파일 리스트 조회
        //----------------------
        Map fpMap = new HashMap();
        fpMap.put("rootNo", paramMap.get("evaluBusiNo"));
        
        List plyyFileList = null;
        
        // [년도별 사업계획서] 부분 첨부파일 리스트 조회.
        fpMap.put("docuType", "PLYY");
        plyyFileList = evaluMgmtService.listEvaluFile(fpMap);
        
    
        // 첨부파일 리스트 등록
        model.addAttribute("plyyFileList" ,  setEmptyRowInDyList("view",plyyFileList) );
        
        model.addAttribute("rtnMap"   ,  rtnMap);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/viewEvaluBudtMgmt";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluBudtMgmt2.do")
    public String viewEvaluBudtMgmt2(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        List rtnList = evaluMgmtService.viewEvaluBudtMgmt2(paramMap);
        
        Map stgMap = evaluMgmtService.viewEvaluStgMgmt(paramMap);
        
        // 평가항목 조회 (입력지 항목)
    	// paramMap.put("parentCode", "EVALU_FINL");
        // 2016년 중앙투자심사 추가
        if(paramMap.get("evaluStage").equals("EVALU_CENT")){
        	paramMap.put("parentCode", "EVALU_CENT");
        } else if(paramMap.get("evaluStage").equals("EVALU_PROG")){
        	paramMap.put("parentCode", "EVALU_PROG");
        } else if(paramMap.get("evaluStage").equals("EVALU_PREV")){
	    	paramMap.put("parentCode", "EVALU_PREV");
	    } else {
	    	paramMap.put("parentCode", "EVALU_FINL");
	    }
        paramMap.put("evaluGubun", "");	//평가항목양식구분 초기화
        List	 evaluFinl = commService.listSelEvaluEtcCode(paramMap);
        
        model.addAttribute("evaluFinlCnt" ,evaluFinl.size());
        
        model.addAttribute("rtnList"   ,  rtnList);
        model.addAttribute("stgMap"   ,  stgMap);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/viewEvaluBudtMgmt2";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/regiEvaluBudtMgmt.do")
    public String regiEvaluBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
        String evaluProcStep = (String)paramMap.get("evaluProcStep");  
        String evaluDetailCode =  (String)paramMap.get("evaluDetailCode");
      
//      if( !evaluProcStep.equals("AS10") && !evaluProcStep.equals("AS90") ){
//    	  evaluDetailCode = evaluProcStep;
//      }
        
        if(!paramMap.get("evaluStage").equals("EVALU_CENT") && !paramMap.get("evaluStage").equals("EVALU_PROG") && !paramMap.get("evaluStage").equals("EVALU_PREV")){
	        // 평가항목 조회 (탭)
	        paramMap.put("parentCode", paramMap.get("evaluStage"));
	        List evaluStageLvl1 = commService.listEvaluCode(paramMap);//판정의견, 종합의견양식1, 종합의견양식2
	        model.addAttribute("evaluStageLvl1", evaluStageLvl1);
	        
	        
	        if(CommUtils.empty(evaluDetailCode)){
	        	Map map = (Map)evaluStageLvl1.get(0);
	       	 	String upperEvaluDetailCode = (String)map.get("code");
	       	 	paramMap.put("upperEvaluDetailCode", upperEvaluDetailCode);
	        }
	        
	        // 평가세부항목 조회 (세부항목)
	        paramMap.put("evaluDetailCode", evaluDetailCode);
	        Map evaluStageLvl2 = commService.listSelEvaluCode(paramMap);//판정의견의 첫번째 항목인 "판정의견 내용"
	        model.addAttribute("evaluStageLvl2", evaluStageLvl2);   
	        
	        
	        paramMap.put("parentCode", evaluStageLvl2.get("parentCode"));
	        List evaluStageLvl3 = commService.listSelEvaluEtcCode(paramMap);
	        model.addAttribute("evaluStageLvl3", evaluStageLvl3);
	        
	        // 평가항목 조회 (입력지 항목)
	        if(paramMap.get("evaluStage").equals("EVALU_CENT")){
	        	paramMap.put("parentCode", "EVALU_CENT");
	        } else if(paramMap.get("evaluStage").equals("EVALU_PROG")){
	        	paramMap.put("parentCode", "EVALU_PROG");
	        } else if(paramMap.get("evaluStage").equals("EVALU_PREV")){
	        	paramMap.put("parentCode", "EVALU_PREV");
	        } else {
	        	paramMap.put("parentCode", "EVALU_INPT");
	        }
	        List	 evaluInptItem = commService.listSelEvaluEtcCode(paramMap);//dhksfy
	        model.addAttribute("evaluInptItem", evaluInptItem);
	        
	        List fndList = null;
	        
	        String mode = (String)paramMap.get("mode");
	        
	        if(mode.equals("updt")){
	        	
	        	paramMap.put("evaluInptItem",evaluInptItem);
	        	fndList =  evaluMgmtService.listEvaluFnd(paramMap);
	        	model.addAttribute("fndList", fndList);
	        }
	        	
	        model.addAttribute("model"   ,  evaluMgmtDomain);
	        model.addAttribute("paramMap",  paramMap);
	        
	        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
	        setEvaluRtnSessionFg(request, model);
	        
        } else if(paramMap.get("evaluStage").equals("EVALU_CENT")) {
        	//그냥 사업정보만 받고 넘기기
        	regiEvaluCentMgmt(request, model);
        	return "evalu/regiEvaluCentMgmt";
        } else if(paramMap.get("evaluStage").equals("EVALU_PROG")) {
	    	//그냥 사업정보만 받고 넘기기
	    	regiEvaluProgMgmt(request, model);
	    	return "evalu/regiEvaluProgMgmt";
	    } else if(paramMap.get("evaluStage").equals("EVALU_PREV")) {
	    	//그냥 사업정보만 받고 넘기기
	    	regiEvaluPrevMgmt(request, model);
	    	return "evalu/regiEvaluPrevMgmt";
	    }
        
        return "evalu/regiEvaluBudtMgmt";
    }
    
    /**
     * [사업관리] 중앙투자심사 파일 다운로드
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/evaluCommitFileDownload.do")
    public void evaluCommitFileDownload(HttpServletRequest request, HttpServletResponse response)
    		throws Exception {
    	//---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        Map CT410Map = new HashMap();
        CT410Map = commService.getCT410(paramMap);
    	
        String fileNo = (String) CT410Map.get("FILE_NO").toString();

        Map params = new HashMap();
        params.put("fileNo", fileNo);

        String saveFileName  = "";
        String serverDirPath = "";
        String orgFileName   = "";

        Map fileInfo = fileService.viewFile(params);
        
        FileController fc = new FileController();
        fc.fileDownloadDetail(request, response, fileInfo);
    }
    
    /**
     * [사업관리] 사업평가관리 중앙투자심사 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    public void regiEvaluCentMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        List listSelEvaluCentCode = (List) commService.listSelEvaluCentCode(paramMap);//선택한것만
        
        Map CT410Map = new HashMap();
        Map CT310Map = new HashMap();
        Map CT210Map = new HashMap();
        Map CT220Map = new HashMap();
        Map CT230Map = new HashMap();
        Map CT110Map = new HashMap();
        
        for (int i = 0; i < listSelEvaluCentCode.size(); i++) {
    		Map map = new HashMap();
    		map = (Map) listSelEvaluCentCode.get(i);
    		map.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    		map.put("evaluId", paramMap.get("evaluId"));
    		if(map.get("EVALU_INDICAT_CD").equals("CT410")){
    			CT410Map = commService.getCT410(map);
    			model.addAttribute("CT410Map",  CT410Map);
    		}
        	if(map.get("EVALU_INDICAT_CD").equals("CT310")){
        		CT310Map = commService.getCT310(map);
        		model.addAttribute("CT310Map",  CT310Map);
    		}
        	if(map.get("EVALU_INDICAT_CD").equals("CT210")){
        		CT210Map = commService.getCT210(map);
        		model.addAttribute("CT210Map",  CT210Map);
        	}
        	if(map.get("EVALU_INDICAT_CD").equals("CT220")){
        		CT220Map = commService.getCT220(map);
        		model.addAttribute("CT220Map",  CT220Map);
        	}
        	if(map.get("EVALU_INDICAT_CD").equals("CT230")){
        		CT230Map = commService.getCT230(map);
        		model.addAttribute("CT230Map",  CT230Map);
        	}
        	if(map.get("EVALU_INDICAT_CD").equals("CT110")){
        		CT110Map = commService.getCT110(map);
        		model.addAttribute("CT110Map",  CT110Map);
        	}
		}
        
        model.addAttribute("listSelEvaluCentCode",  listSelEvaluCentCode);
        model.addAttribute("paramMap",  paramMap);
    }
    
    /**
     * [사업관리] 사업평가관리 집행평가 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    public void regiEvaluProgMgmt(HttpServletRequest request, ModelMap model)
    		throws Exception {
    	
    	//---------------------------------------------
    	//Default Value Setting
    	String method       = getMethodName(new Throwable());
    	Map paramMap = setMappingValues(request, method );
    	// default domain setting
    	EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
    	BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
    	//---------------------------------------------
    	
    	List listSelEvaluProgCode = (List) commService.listSelEvaluProgCode(paramMap);//선택한것만
    	
    	Map PR310Map = new HashMap();
    	Map PR210Map = new HashMap();
    	Map PR220Map = new HashMap();
    	Map PR110Map = new HashMap();
    	
    	for (int i = 0; i < listSelEvaluProgCode.size(); i++) {
    		Map map = new HashMap();
    		map = (Map) listSelEvaluProgCode.get(i);
    		map.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    		map.put("evaluId", paramMap.get("evaluId"));
    		if(map.get("EVALU_INDICAT_CD").equals("PR310")){
    			PR310Map = commService.getPR310(map);
    			model.addAttribute("PR310Map",  PR310Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PR210")){
    			PR210Map = commService.getPR210(map);
    			model.addAttribute("PR210Map",  PR210Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PR220")){
    			PR220Map = commService.getPR220(map);
    			model.addAttribute("PR220Map",  PR220Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PR110")){
    			PR110Map = commService.getPR110(map);
    			model.addAttribute("PR110Map",  PR110Map);
    		}
    	}
    	
    	model.addAttribute("listSelEvaluProgCode",  listSelEvaluProgCode);
    	model.addAttribute("paramMap",  paramMap);
    }

    /**
     * [사업관리] 사업평가관리 사전평가 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    public void regiEvaluPrevMgmt(HttpServletRequest request, ModelMap model)
    		throws Exception {
    	
    	//---------------------------------------------
    	//Default Value Setting
    	String method       = getMethodName(new Throwable());
    	Map paramMap = setMappingValues(request, method );
    	// default domain setting
    	EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
    	BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
    	//---------------------------------------------
    	
    	List listSelEvaluPrevCode = (List) commService.listSelEvaluPrevCode(paramMap);//선택한것만
    	
    	Map PV110Map = new HashMap();
    	Map PV510Map = new HashMap();
    	Map PV520Map = new HashMap();
    	Map PV530Map = new HashMap();
    	Map PV610Map = new HashMap();
    	Map PV620Map = new HashMap();
    	Map PV630Map = new HashMap();
    	Map PV640Map = new HashMap();
    	Map PV650Map = new HashMap();
    	Map PV660Map = new HashMap();
    	Map PV710Map = new HashMap();
    	Map PV720Map = new HashMap();
    	Map PV730Map = new HashMap();
    	
    	//진단평가표
    	Map PV211Map = new HashMap();
    	Map PV212Map = new HashMap();
    	Map PV213Map = new HashMap();
    	Map PV221Map = new HashMap();
    	Map PV222Map = new HashMap();
    	Map PV223Map = new HashMap();
    	Map PV311Map = new HashMap();
    	Map PV312Map = new HashMap();
    	Map PV321Map = new HashMap();
    	Map PV322Map = new HashMap();
    	Map PV331Map = new HashMap();
    	Map PV332Map = new HashMap();
    	Map PV341Map = new HashMap();
    	Map PV342Map = new HashMap();
    	Map PV411Map = new HashMap();
    	Map PV412Map = new HashMap();
    	Map PV413Map = new HashMap();
    	Map PV421Map = new HashMap();
    	Map PV422Map = new HashMap();
    	Map PV423Map = new HashMap();
    	
    	
    	
    	for (int i = 0; i < listSelEvaluPrevCode.size(); i++) {
    		Map map = new HashMap();
    		map = (Map) listSelEvaluPrevCode.get(i);
    		map.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    		map.put("evaluId", paramMap.get("evaluId"));
    		if(map.get("EVALU_INDICAT_CD").equals("PV110")){
    			PV110Map = commService.getPvFile(map);
    			model.addAttribute("PV110Map",  PV110Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV510")){
    			PV510Map = commService.getPv(map);
    			model.addAttribute("PV510Map",  PV510Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV520")){
    			PV520Map = commService.getPv(map);
    			model.addAttribute("PV520Map",  PV520Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV530")){
    			PV530Map = commService.getPv(map);
    			model.addAttribute("PV530Map",  PV530Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV610")){
    			PV610Map = commService.getPv(map);
    			model.addAttribute("PV610Map",  PV610Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV620")){
    			PV620Map = commService.getPv(map);
    			model.addAttribute("PV620Map",  PV620Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV630")){
    			PV630Map = commService.getPv(map);
    			model.addAttribute("PV630Map",  PV630Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV640")){
    			PV640Map = commService.getPv(map);
    			model.addAttribute("PV640Map",  PV640Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV650")){
    			PV650Map = commService.getPv(map);
    			model.addAttribute("PV650Map",  PV650Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV660")){
    			PV660Map = commService.getPv(map);
    			model.addAttribute("PV660Map",  PV660Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV710")){
    			PV710Map = commService.getPv(map);
    			model.addAttribute("PV710Map",  PV710Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV211");
    			PV211Map = commService.getPv710(map);
    			model.addAttribute("PV211Map",  PV211Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV212");
    			PV212Map = commService.getPv710(map);
    			model.addAttribute("PV212Map",  PV212Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV213");
    			PV213Map = commService.getPv710(map);
    			model.addAttribute("PV213Map",  PV213Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV221");
    			PV221Map = commService.getPv710(map);
    			model.addAttribute("PV221Map",  PV221Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV222");
    			PV222Map = commService.getPv710(map);
    			model.addAttribute("PV222Map",  PV222Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV223");
    			PV223Map = commService.getPv710(map);
    			model.addAttribute("PV223Map",  PV223Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV311");
    			PV311Map = commService.getPv710(map);
    			model.addAttribute("PV311Map",  PV311Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV312");
    			PV312Map = commService.getPv710(map);
    			model.addAttribute("PV312Map",  PV312Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV321");
    			PV321Map = commService.getPv710(map);
    			model.addAttribute("PV321Map",  PV321Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV322");
    			PV322Map = commService.getPv710(map);
    			model.addAttribute("PV322Map",  PV322Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV331");
    			PV331Map = commService.getPv710(map);
    			model.addAttribute("PV331Map",  PV331Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV332");
    			PV332Map = commService.getPv710(map);
    			model.addAttribute("PV332Map",  PV332Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV341");
    			PV341Map = commService.getPv710(map);
    			model.addAttribute("PV341Map",  PV341Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV342");
    			PV342Map = commService.getPv710(map);
    			model.addAttribute("PV342Map",  PV342Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV411");
    			PV411Map = commService.getPv710(map);
    			model.addAttribute("PV411Map",  PV411Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV412");
    			PV412Map = commService.getPv710(map);
    			model.addAttribute("PV412Map",  PV412Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV413");
    			PV413Map = commService.getPv710(map);
    			model.addAttribute("PV413Map",  PV413Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV421");
    			PV421Map = commService.getPv710(map);
    			model.addAttribute("PV421Map",  PV421Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV422");
    			PV422Map = commService.getPv710(map);
    			model.addAttribute("PV422Map",  PV422Map);
    			
    			map.put("EVALU_INDICAT_CD", "PV423");
    			PV423Map = commService.getPv710(map);
    			model.addAttribute("PV423Map",  PV423Map);
    			
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV720")){
    			PV720Map = commService.getPv(map);
    			model.addAttribute("PV720Map",  PV720Map);
    		}
    		if(map.get("EVALU_INDICAT_CD").equals("PV730")){
    			PV730Map = commService.getPv(map);
    			model.addAttribute("PV730Map",  PV730Map);
    		}

    	}
    	
    	model.addAttribute("listSelEvaluPrevCode",  listSelEvaluPrevCode);
    	model.addAttribute("paramMap",  paramMap);
    }
    
    
    /**
     * [사업관리] 사업평가관리 중앙투자심사 저장.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluCentMgmt.do")
    public ModelAndView saveEvaluCentMgmt(HttpServletRequest request, ModelMap model)
    		throws Exception {
    	
    	//---------------------------------------------
    	//Default Value Setting
    	String method       = getMethodName(new Throwable());
    	Map paramMap = setMappingValues(request, method );
    	// default domain setting
    	EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
    	BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
    	//---------------------------------------------
    	
    	try {
			//------------------
	   		// 파일 처리 부분
	   		//------------------
	   		List listFileInfo = fileManager.multiFileUpload(request);
	   		Map map = new HashMap();
	   		List listInputFileInfo = new ArrayList();
	   		int fileNo = 0;
	   		
	   		for (int i = 0; i < listFileInfo.size(); i++) {
	   			map = (Map) listFileInfo.get(i);
	   			map.put("rootNo", paramMap.get("evaluBusiNo"));
	   			map.put("docuType", paramMap.get("evaluId"));
	   			map.put("filePath", ApplicationProperty.get("upload.temp.dir"));
	   			listInputFileInfo.add(map);
			}
	   		
	   		fileService.regiFiles(listInputFileInfo);//파일 디비에 등록
	   		fileNo = fileService.getMaxFileNo(paramMap);
	   		
	   		if(listInputFileInfo != null){
	   			Map fileMap = (Map) listInputFileInfo.get(0);
	   			paramMap.put("fileOrgNm", fileMap.get("fileOrgNm"));
	   			evaluMgmtService.regiEvaluCentMgmt410(paramMap);
	   		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("CT310") != null){
    			evaluMgmtService.regiEvaluCentMgmt310(paramMap);
    		}
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	try {
    		if(paramMap.get("CT210") != null){
    			evaluMgmtService.regiEvaluCentMgmt210(paramMap);
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	
		try {
    		if(paramMap.get("CT220") != null){
    			evaluMgmtService.regiEvaluCentMgmt220(paramMap);
    		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		try {
    		if(paramMap.get("CT230") != null){
    			evaluMgmtService.regiEvaluCentMgmt230(paramMap);
    		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		try {
    		if(paramMap.get("CT110") != null){
    			evaluMgmtService.regiEvaluCentMgmt110(paramMap);
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
//    	evaluMgmtService.saveEvaluBudtMgmt(paramMap);
    	
    	model.addAttribute("model"   ,  evaluMgmtDomain);
    	model.addAttribute("paramMap",  paramMap);
    	
    	// SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
    	setEvaluRtnSessionFg(request, model);
    	
    	//-------------------------
    	// 저장처리 후 다음 이동 시 전달할 param 설정
    	//-------------------------
    	
    	
    	Map rtnPMap = new HashMap();
    	String MoveUrl = null;

    	// 관광개발사업번호 parameter 추가
    	rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    	rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
    	rtnPMap.put("evaluId", paramMap.get("evaluId"));
    	rtnPMap.put("evaluGubun", paramMap.get("evaluGubun"));
    	
    	return new ModelAndView("redirect:/evalu/viewEvaluBudtMgmt2.do",rtnPMap);
//    	return new ModelAndView("evalu/regiEvaluCentMgmt",rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 집행평가 저장.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluProgMgmt.do")
    public ModelAndView saveEvaluProgMgmt(HttpServletRequest request, ModelMap model)
    		throws Exception {
    	
    	//---------------------------------------------
    	//Default Value Setting
    	String method       = getMethodName(new Throwable());
    	Map paramMap = setMappingValues(request, method );
    	// default domain setting
    	EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
    	BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
    	//---------------------------------------------
    	
    	try {
    		//------------------
    		// 파일 처리 부분
    		//------------------
    		List listFileInfo = fileManager.multiFileUpload(request);
    		Map map = new HashMap();
    		List listInputFileInfo = new ArrayList();
    		int fileNo = 0;
    		
    		for (int i = 0; i < listFileInfo.size(); i++) {
    			map = (Map) listFileInfo.get(i);
    			map.put("rootNo", paramMap.get("evaluBusiNo"));
    			map.put("docuType", paramMap.get("evaluId"));
    			map.put("filePath", ApplicationProperty.get("upload.temp.dir"));
    			listInputFileInfo.add(map);
    		}
    		
    		fileService.regiFiles(listInputFileInfo);//파일 디비에 등록
    		fileNo = fileService.getMaxFileNo(paramMap);
    		
    		if(listInputFileInfo != null){
    			Map fileMap = (Map) listInputFileInfo.get(0);
    			paramMap.put("fileOrgNm", fileMap.get("fileOrgNm"));
    			evaluMgmtService.regiEvaluProgMgmt110(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PR310") != null){
    			evaluMgmtService.regiEvaluProgMgmt310(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PR220") != null){
    			evaluMgmtService.regiEvaluProgMgmt220(paramMap);
    		}
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	try {
    		if(paramMap.get("PR210") != null){
    			evaluMgmtService.regiEvaluProgMgmt210(paramMap);
    		}
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PR110") != null){
    			evaluMgmtService.regiEvaluProgMgmt110(paramMap);
    		}
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	model.addAttribute("model"   ,  evaluMgmtDomain);
    	model.addAttribute("paramMap",  paramMap);
    	
    	// SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
    	setEvaluRtnSessionFg(request, model);
    	
    	//-------------------------
    	// 저장처리 후 다음 이동 시 전달할 param 설정
    	//-------------------------
    	
    	
    	Map rtnPMap = new HashMap();
    	String MoveUrl = null;
    	
    	// 관광개발사업번호 parameter 추가
    	rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    	rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
    	rtnPMap.put("evaluId", paramMap.get("evaluId"));
    	rtnPMap.put("evaluGubun", paramMap.get("evaluGubun"));
    	
    	return new ModelAndView("redirect:/evalu/viewEvaluBudtMgmt2.do",rtnPMap);
//    	return new ModelAndView("evalu/regiEvaluCentMgmt",rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 사전평가 저장.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluPrevMgmt.do")
    public ModelAndView saveEvaluPrevMgmt(HttpServletRequest request, ModelMap model)
    		throws Exception {
    	
    	//---------------------------------------------
    	//Default Value Setting
    	String method       = getMethodName(new Throwable());
    	Map paramMap = setMappingValues(request, method );
    	// default domain setting
    	EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
    	BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
    	//---------------------------------------------
    	
    	try {
    		//------------------
    		// 파일 처리 부분
    		//------------------
    		List listFileInfo = fileManager.multiFileUpload(request);
    		Map map = new HashMap();
    		List listInputFileInfo = new ArrayList();
    		int fileNo = 0;
    		
    		for (int i = 0; i < listFileInfo.size(); i++) {
    			map = (Map) listFileInfo.get(i);
    			map.put("rootNo", paramMap.get("evaluBusiNo"));
    			map.put("docuType", paramMap.get("evaluId"));
    			map.put("filePath", ApplicationProperty.get("upload.temp.dir"));
    			listInputFileInfo.add(map);
    		}
    		
    		fileService.regiFiles(listInputFileInfo);//파일 디비에 등록
    		fileNo = fileService.getMaxFileNo(paramMap);
    		
    		if(listInputFileInfo != null){
    			Map fileMap = (Map) listInputFileInfo.get(0);
    			paramMap.put("fileOrgNm", fileMap.get("fileOrgNm"));
    			evaluMgmtService.regiEvaluPrevMgmt110(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV510") != null){
    			evaluMgmtService.regiEvaluPrevMgmt510(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV520") != null){
    			evaluMgmtService.regiEvaluPrevMgmt520(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV530") != null){
    			evaluMgmtService.regiEvaluPrevMgmt530(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV610") != null){
    			evaluMgmtService.regiEvaluPrevMgmt610(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV620") != null){
    			evaluMgmtService.regiEvaluPrevMgmt620(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV630") != null){
    			evaluMgmtService.regiEvaluPrevMgmt630(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV640") != null){
    			evaluMgmtService.regiEvaluPrevMgmt640(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV650") != null){
    			evaluMgmtService.regiEvaluPrevMgmt650(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV660") != null){
    			evaluMgmtService.regiEvaluPrevMgmt660(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV710") != null){
    			evaluMgmtService.regiEvaluPrevMgmt710(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV720") != null){
    			evaluMgmtService.regiEvaluPrevMgmt720(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV730") != null){
    			evaluMgmtService.regiEvaluPrevMgmt730(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	//표
    	try {
    		if(paramMap.get("PV211") != null){
    			evaluMgmtService.regiEvaluPrevMgmt211(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV212") != null){
    			evaluMgmtService.regiEvaluPrevMgmt212(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV213") != null){
    			evaluMgmtService.regiEvaluPrevMgmt213(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV221") != null){
    			evaluMgmtService.regiEvaluPrevMgmt221(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV222") != null){
    			evaluMgmtService.regiEvaluPrevMgmt222(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV223") != null){
    			evaluMgmtService.regiEvaluPrevMgmt223(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV311") != null){
    			evaluMgmtService.regiEvaluPrevMgmt311(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV312") != null){
    			evaluMgmtService.regiEvaluPrevMgmt312(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV321") != null){
    			evaluMgmtService.regiEvaluPrevMgmt321(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV322") != null){
    			evaluMgmtService.regiEvaluPrevMgmt322(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV331") != null){
    			evaluMgmtService.regiEvaluPrevMgmt331(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV332") != null){
    			evaluMgmtService.regiEvaluPrevMgmt332(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV341") != null){
    			evaluMgmtService.regiEvaluPrevMgmt341(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV342") != null){
    			evaluMgmtService.regiEvaluPrevMgmt342(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV411") != null){
    			evaluMgmtService.regiEvaluPrevMgmt411(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV412") != null){
    			evaluMgmtService.regiEvaluPrevMgmt412(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV413") != null){
    			evaluMgmtService.regiEvaluPrevMgmt413(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV421") != null){
    			evaluMgmtService.regiEvaluPrevMgmt421(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV422") != null){
    			evaluMgmtService.regiEvaluPrevMgmt422(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	try {
    		if(paramMap.get("PV423") != null){
    			evaluMgmtService.regiEvaluPrevMgmt423(paramMap);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	model.addAttribute("model"   ,  evaluMgmtDomain);
    	model.addAttribute("paramMap",  paramMap);
    	
    	// SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
    	setEvaluRtnSessionFg(request, model);
    	
    	//-------------------------
    	// 저장처리 후 다음 이동 시 전달할 param 설정
    	//-------------------------
    	
    	
    	Map rtnPMap = new HashMap();
    	String MoveUrl = null;
    	
    	// 관광개발사업번호 parameter 추가
    	rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    	rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
    	rtnPMap.put("evaluId", paramMap.get("evaluId"));
    	rtnPMap.put("evaluGubun", paramMap.get("evaluGubun"));
    	
    	return new ModelAndView("redirect:/evalu/viewEvaluBudtMgmt2.do",rtnPMap);
//    	return new ModelAndView("evalu/regiEvaluCentMgmt",rtnPMap);
    }
    
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluBudtMgmt.do")
    public ModelAndView saveEvaluBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
        String evaluProcStep = (String)paramMap.get("evaluProcStep");
        String mode = (String)paramMap.get("mode");
        
        if(evaluProcStep.equals("AS10")){
        	paramMap.put("evaluProcStep", "AS20");
        } 
        
        evaluMgmtService.saveEvaluBudtMgmt(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        
        Map rtnPMap = new HashMap();
        String MoveUrl = null;
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
        rtnPMap.put("evaluId", paramMap.get("evaluId"));
        rtnPMap.put("mode", paramMap.get("mode"));
        rtnPMap.put("evaluProcStep", paramMap.get("evaluProcStep"));
        rtnPMap.put("evaluGubun", paramMap.get("evaluGubun"));
        
        if(mode.equals("regi")){
        	
        	if ( String.valueOf(paramMap.get("nextEvaluCode")).equals("AS30") ){ 
        		MoveUrl = "redirect:/evalu/regiEvaluFinlBudtMgmt.do";
        	}else if( ((String)paramMap.get("evaluProcStep")).equals("AS20") ){
        		rtnPMap.put("evaluDetailCode", paramMap.get("nextEvaluCode"));
        		MoveUrl = "redirect:/evalu/regiEvaluBudtMgmt.do";
        	}
        }else if(mode.equals("updt")){
        	rtnPMap.put("evaluDetailCode", paramMap.get("curtEvaluCode"));
        	MoveUrl = "redirect:/evalu/viewEvaluInptBudtMgmt.do";
        }
        
             
        return new ModelAndView(MoveUrl,rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluInptBudtMgmt.do")
    public String viewEvaluInptBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluDetailCode =  (String)paramMap.get("evaluDetailCode");
        String upperEvaluDetailCode =  (String)paramMap.get("upperEvaluDetailCode");
        
        // 평가항목 조회 (탭)
        paramMap.put("parentCode", paramMap.get("evaluStage"));
        List evaluStageLvl1 = commService.listEvaluCode(paramMap);
        model.addAttribute("evaluStageLvl1", evaluStageLvl1);
        
        if(CommUtils.empty(evaluDetailCode)){
        	
        	if(CommUtils.empty(upperEvaluDetailCode)){
           	 Map map = (Map)evaluStageLvl1.get(0);
           	 String code = (String)map.get("code");
           	 paramMap.put("upperEvaluDetailCode", code);
        	}

        }
        
        // 평가세부항목 조회 (세부항목)
        Map evaluStageLvl2 = commService.listSelEvaluCode(paramMap);
        model.addAttribute("evaluStageLvl2", evaluStageLvl2);   
        
        paramMap.put("parentCode", evaluStageLvl2.get("parentCode"));
        List evaluStageLvl3 = commService.listSelEvaluEtcCode(paramMap);
        model.addAttribute("evaluStageLvl3", evaluStageLvl3);
        
        // 평가항목 조회 (입력지 항목)
        paramMap.put("parentCode", "EVALU_INPT");
        List	 evaluInptItem = commService.listSelEvaluEtcCode(paramMap);
        model.addAttribute("evaluInptItem", evaluInptItem);
        
        if(CommUtils.empty(evaluDetailCode)){
        	paramMap.put("evaluDetailCode", evaluStageLvl2.get("code")) ;
        }
        
        List fndList =  evaluMgmtService.listEvaluFnd(paramMap);
        
        model.addAttribute("fndList"   ,  fndList);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/viewEvaluInptBudtMgmt";
    }
    
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/regiEvaluFinlBudtMgmt.do")
    public String regiEvaluFinlBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        //사업정보 및 평가단계 조회
        Map evaluStgMap = evaluMgmtService.viewEvaluStgMgmt(paramMap);
        
        // 평가항목 조회 (평가지표 부분)
//        paramMap.put("startParentCode", paramMap.get("evaluStage"));
//        paramMap.put("level", 3);
//        List evlauItemLvl1 = commService.listEvaluCode(paramMap);
        
        paramMap.put("parentCode", paramMap.get("evaluStage"));
        List	 evlauItemLvl1 = commService.listSelEvaluEtcCode(paramMap);
        String evaluGubun = (String)paramMap.get("evaluGubun");
        if(evaluGubun.equals("AFTER") && evlauItemLvl1 != null){
      	  for(int i=0 ; i<evlauItemLvl1.size() ; i++){
      		  Map evaluItemMap = (Map)evlauItemLvl1.get(i);
      		  //평가지표별 배점항목 조회
      		  evaluItemMap.put("evaluItemSpan", commService.listEvaluItemSpanCode(evaluItemMap));
      		  
      		  evlauItemLvl1.set(i, evaluItemMap);
      	  }
        }
        model.addAttribute("evlauItemLvl1", evlauItemLvl1);
        
        // 평가항목 조회 (최종결과정보)
//        paramMap.remove("startParentCode");
//        List evlauItemLvl2 = commService.listEvaluCode(paramMap);
        paramMap.put("parentCode", "EVALU_FINL");
        List evlauItemLvl2 = commService.listSelEvaluEtcCode(paramMap);
        model.addAttribute("evlauItemLvl2", evlauItemLvl2);
        
        
        String mode = (String)paramMap.get("mode");
        if(mode.equals(EvaluCommService.MODE_UPDT)){
        	
        	ArrayList evaluInptCulm = new ArrayList();
        	
        	for (int i = 0; i < evlauItemLvl1.size(); i++) {
        		evaluInptCulm.add(evlauItemLvl1.get(i));
			}
        	
        	for (int i = 0; i < evlauItemLvl2.size(); i++) {
        		evaluInptCulm.add(evlauItemLvl2.get(i));
        	}
        	
        	paramMap.put("evaluInptItem",evaluInptCulm);
        	
        	List fndList = evaluMgmtService.listEvaluFnd(paramMap);
        	model.addAttribute("fndList", fndList);
        }
        
        model.addAttribute("evaluStgMap"   ,  evaluStgMap);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/regiEvaluFinlBudtMgmt";
    }   
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluFinlBudtMgmt.do")
    public String viewEvaluFinlBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        //사업정보 및 평가단계 조회
        Map evaluStgMap = evaluMgmtService.viewEvaluStgMgmt(paramMap);
        
        // 평가항목 조회 (평가지표 부분)
//      paramMap.put("startParentCode", paramMap.get("evaluStage"));
//      paramMap.put("level", 3);
//      List evlauItemLvl1 = commService.listEvaluCode(paramMap);
      
      paramMap.put("parentCode", paramMap.get("evaluStage"));
      List	 evlauItemLvl1 = commService.listSelEvaluEtcCode(paramMap);
      String evaluGubun = (String)paramMap.get("evaluGubun");
      if(evaluGubun.equals("AFTER") && evlauItemLvl1 != null){
    	  for(int i=0 ; i<evlauItemLvl1.size() ; i++){
    		  Map evaluItemMap = (Map)evlauItemLvl1.get(i);
    		  //평가지표별 배점항목 조회
    		  evaluItemMap.put("evaluItemSpan", commService.listEvaluItemSpanCode(evaluItemMap));
    		  
    		  evlauItemLvl1.set(i, evaluItemMap);
    	  }
      }
      model.addAttribute("evlauItemLvl1", evlauItemLvl1);
      
      // 평가항목 조회 (최종결과정보)
//      paramMap.remove("startParentCode");
//      List evlauItemLvl2 = commService.listEvaluCode(paramMap);
      paramMap.put("parentCode", "EVALU_FINL");
      List evlauItemLvl2 = commService.listSelEvaluEtcCode(paramMap);
      model.addAttribute("evlauItemLvl2", evlauItemLvl2);
        
    	List fndList = evaluMgmtService.listEvaluFnd(paramMap);
    	model.addAttribute("fndList", fndList);
        
        model.addAttribute("evaluStgMap"   ,  evaluStgMap);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/viewEvaluFinlBudtMgmt";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluFinlBudtMgmt.do")
    public ModelAndView saveEvaluFinlBudtMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluProcStep = (String)paramMap.get("evaluProcStep");
        String mode = (String)paramMap.get("mode");
        
        if(evaluProcStep.equals("AS20")){
        	paramMap.put("evaluProcStep", "AS30");
        } 
        
        evaluMgmtService.saveEvaluBudtMgmt(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        
        Map rtnPMap = new HashMap();
        String MoveUrl = null;
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
        rtnPMap.put("evaluId", paramMap.get("evaluId"));
        rtnPMap.put("evaluProcStep", paramMap.get("evaluProcStep"));
        rtnPMap.put("evaluGubun", paramMap.get("evaluGubun"));
        
        MoveUrl = "redirect:/evalu/viewEvaluFinlBudtMgmt.do";

             
        return new ModelAndView(MoveUrl,rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/updtEvaluFinalAppr.do")
    public ModelAndView updtEvaluFinalAppr(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        evaluMgmtService.updtEvaluFinalAppr(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        
        Map rtnPMap = new HashMap();
        String MoveUrl = null;
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
        
        String evaluStage = (String)paramMap.get("evaluStage");
        
        if(evaluStage.equals("EVALU_DPTH")){
        	MoveUrl = "redirect:/evalu/viewEvaluDpthMgmt.do";
        }else{
        	MoveUrl = "redirect:/evalu/viewEvaluBudtMgmt2.do";
        }
        

             
        return new ModelAndView(MoveUrl,rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluDpthMgmt.do")
    public String viewEvaluDpthMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        List rtnList = evaluMgmtService.viewEvaluBudtMgmt2(paramMap);
        
        Map stgMap = evaluMgmtService.viewEvaluStgMgmt(paramMap);
        
        model.addAttribute("rtnList"   ,  rtnList);
        model.addAttribute("stgMap"   ,  stgMap);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/viewEvaluDpthMgmt";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/regiEvaluDpthMgmt.do")
    public String regiEvaluDpthMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
      String evaluProcStep = (String)paramMap.get("evaluProcStep");  
      String evaluDetailCode =  (String)paramMap.get("evaluDetailCode");
      
      	if(CommUtils.empty(evaluDetailCode)){
	    	 String upperEvaluDetailCode = (String)paramMap.get("evaluStage");
	    	 paramMap.put("upperEvaluDetailCode", upperEvaluDetailCode);
        }
      
        // 평가세부항목 조회 (세부항목)
        paramMap.put("evaluDetailCode", evaluDetailCode);
        paramMap.put("level", "2");
        Map evaluStageLvl2 = commService.listSelEvaluCode(paramMap);
        model.addAttribute("evaluStageLvl2", evaluStageLvl2);   
        
        // 평가항목 조회 (입력지 항목)
        paramMap.put("parentCode", "DP10");
        List	 evaluInptItem = commService.listSelEvaluEtcCode(paramMap);
        model.addAttribute("evaluInptItem", evaluInptItem);
        
        List fndList = null;
        
        fndList =  evaluMgmtService.listEvaluFnd(paramMap);
        
        model.addAttribute("fndList", fndList);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/regiEvaluDpthMgmt";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluDpthMgmt.do")
    public ModelAndView saveEvaluDpthMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        
        String evaluProcStep = (String)paramMap.get("evaluProcStep");
        String mode = (String)paramMap.get("mode");
        
        if(evaluProcStep.equals("AS10")){
        	paramMap.put("evaluProcStep", "AS20");
        } 
        
        evaluMgmtService.saveEvaluBudtMgmt(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        
        Map rtnPMap = new HashMap();
        String MoveUrl = null;
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
        rtnPMap.put("evaluId", paramMap.get("evaluId"));
        rtnPMap.put("mode", paramMap.get("mode"));
        rtnPMap.put("evaluProcStep", paramMap.get("evaluProcStep"));
        rtnPMap.put("evaluEtcSeq", paramMap.get("evaluEtcSeq"));
        
        if(mode.equals("regi")){
        	
        		rtnPMap.put("evaluDetailCode", paramMap.get("nextEvaluCode"));
        		MoveUrl = "redirect:/evalu/regiEvaluFinlDpthMgmt.do";
        		
        }else if(mode.equals("updt")){
        	rtnPMap.put("evaluDetailCode", paramMap.get("curtEvaluCode"));
        	MoveUrl = "redirect:/evalu/viewEvaluInptDpthMgmt.do";
        }
        
             
        return new ModelAndView(MoveUrl,rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/regiEvaluFinlDpthMgmt.do")
    public String regiEvaluFinlDpthMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluProcStep = (String)paramMap.get("evaluProcStep");  
        String evaluDetailCode =  (String)paramMap.get("evaluDetailCode");
        String evaluEtcSeq = (String)paramMap.get("evaluEtcSeq");
        
        if(CommUtils.empty(evaluEtcSeq)){
        	paramMap.put("evaluEtcSeq", 1);
        }
        
        
          // 평가세부항목 조회 (세부항목)
          paramMap.put("evaluDetailCode", evaluDetailCode);
          paramMap.put("level", "2");
          Map evaluStageLvl2 = commService.listSelEvaluCode(paramMap);
          model.addAttribute("evaluStageLvl2", evaluStageLvl2);   
          
          // 평가항목 조회 (입력지 항목)
          paramMap.put("parentCode", "DP20");
          List	 evaluInptItem = commService.listSelEvaluEtcCode(paramMap);
          paramMap.put("evaluInptItem", evaluInptItem);
          model.addAttribute("evaluInptItem", evaluInptItem);
          
          List fndList = null;
          
          fndList =  evaluMgmtService.listEvaluFnd(paramMap);
          
          model.addAttribute("fndList", fndList);
          model.addAttribute("model"   ,  evaluMgmtDomain);
          model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/regiEvaluFinlDpthMgmt";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/saveEvaluFinlDpthMgmt.do")
    public ModelAndView saveEvaluFinlDpthMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluProcStep = (String)paramMap.get("evaluProcStep");
        String mode = (String)paramMap.get("mode");
        
        if(evaluProcStep.equals("AS20")){
        	paramMap.put("evaluProcStep", "AS30");
        } 
        
        evaluMgmtService.saveEvaluBudtMgmt(paramMap);
        
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        //-------------------------
        // 저장처리 후 다음 이동 시 전달할 param 설정
        //-------------------------
        
        
        String regiMode = (String)paramMap.get("regiMode");
        
        Map rtnPMap = new HashMap();
        String MoveUrl = null;
        
        // 관광개발사업번호 parameter 추가
        rtnPMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
        rtnPMap.put("evaluStage", paramMap.get("evaluStage"));
        rtnPMap.put("evaluId", paramMap.get("evaluId"));
        rtnPMap.put("evaluProcStep", paramMap.get("evaluProcStep"));
        rtnPMap.put("evaluDetailCode", paramMap.get("curtEvaluCode"));
        rtnPMap.put("mode", paramMap.get("mode"));
        
        if(mode.equals("regi")){
            if(regiMode.equals("nor")){
            	rtnPMap.put("evaluEtcSeq", 1);
            	MoveUrl = "redirect:/evalu/viewEvaluFinlDpthMgmt.do";
            }else if(regiMode.equals("add")){
            	rtnPMap.put("evaluEtcSeq",  Integer.parseInt((String)paramMap.get("evaluEtcSeq")) +1);
            	MoveUrl = "redirect:/evalu/regiEvaluFinlDpthMgmt.do";
            }
        }else if(mode.equals("updt")){
        	rtnPMap.put("evaluEtcSeq", paramMap.get("evaluEtcSeq"));
        	MoveUrl = "redirect:/evalu/viewEvaluFinlDpthMgmt.do";
        }
        
        return new ModelAndView(MoveUrl,rtnPMap);
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluInptDpthMgmt.do")
    public String viewEvaluInptDpthMgmt(HttpServletRequest request, ModelMap model)
    		throws Exception {
    	
    	//---------------------------------------------
    	//Default Value Setting
    	String method       = getMethodName(new Throwable());
    	Map paramMap = setMappingValues(request, method );
    	// default domain setting
    	EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
    	BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
    	//---------------------------------------------
    	
        String evaluProcStep = (String)paramMap.get("evaluProcStep");  
        String evaluDetailCode =  (String)paramMap.get("evaluDetailCode");
        String evaluEtcSeq = (String)paramMap.get("evaluEtcSeq");
        
        if(CommUtils.empty(evaluEtcSeq)){
        	paramMap.put("evaluEtcSeq", 1);
        }
        
        
        // 평가세부항목 조회 (세부항목)
        paramMap.put("upperEvaluDetailCode", paramMap.get("evaluStage"));
        paramMap.put("level", "2");
        Map evaluStageLvl2 = commService.listSelEvaluCode(paramMap);
        model.addAttribute("evaluStageLvl2", evaluStageLvl2);   
          
        // 평가항목 조회 (입력지 항목)
        paramMap.put("parentCode", "DP10");
        List	 evaluInptItem = commService.listSelEvaluEtcCode(paramMap);
        model.addAttribute("evaluInptItem", evaluInptItem);
        
        
        if(CommUtils.empty(evaluDetailCode)){
        	paramMap.put("evaluDetailCode", evaluStageLvl2.get("code"));
        }
          
        List fndList = null;
          
        fndList =  evaluMgmtService.listEvaluFnd(paramMap);
    	
    	model.addAttribute("fndList"   ,  fndList);
    	model.addAttribute("model"   ,  evaluMgmtDomain);
    	model.addAttribute("paramMap",  paramMap);
    	
    	// SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
    	setEvaluRtnSessionFg(request, model);
    	
    	return "evalu/viewEvaluInptDpthMgmt";
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/evalu/viewEvaluFinlDpthMgmt.do")
    public String viewEvaluFinlDpthMgmt(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = setMappingValues(request, method );
        // default domain setting
        EvaluMgmtDomain evaluMgmtDomain = new EvaluMgmtDomain();
        BeanUtils.copyProperties(evaluMgmtDomain, paramMap);
        //---------------------------------------------
        
        String evaluEtcSeq = (String)paramMap.get("evaluEtcSeq");
        
        if(CommUtils.empty(evaluEtcSeq)){
        	paramMap.put("evaluEtcSeq", 1);
        }
        
        // 평가항목 조회 (입력지 항목)
        paramMap.put("parentCode", "DP20");
        paramMap.put("level", "2");
        List	 evaluInptItem = commService.listSelEvaluEtcCode(paramMap);
        paramMap.put("evaluInptItem", evaluInptItem);
        model.addAttribute("evaluInptItem", evaluInptItem);
        
        // 평가항목 조회 (탭)
        paramMap.put("parentCode", paramMap.get("evaluStage"));
        int lenEtcSeq = evaluMgmtService.getEvaluEtcSeq(paramMap);
        model.addAttribute("lenEtcSeq", lenEtcSeq);
        
        
//        if(CommUtils.empty(evaluDetailCode)){
//        	 Map map = (Map)evaluStageLvl1.get(0);
//        	 evaluDetailCode = (String)map.get("code");
//        }
        
        // 평가세부항목 조회 (세부항목)
        Map evaluStageLvl2 = commService.listSelEvaluCode(paramMap);
        model.addAttribute("evaluStageLvl2", evaluStageLvl2);   
        
        List fndList =  evaluMgmtService.listEvaluFnd(paramMap);
        
        model.addAttribute("fndList"   ,  fndList);
        model.addAttribute("model"   ,  evaluMgmtDomain);
        model.addAttribute("paramMap",  paramMap);
        
        // SESSEION 값 설정 : 만일 값이 존재할 때 해당 값을 이용해서 화면에서 처리 할 수 있음.
        setEvaluRtnSessionFg(request, model);
        
        return "evalu/viewEvaluFinlDpthMgmt";
    }
    
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 기타
    //++++++++++++++++++++++++++++++++++++++++++++++ 
    
    /**
     * Dynamic 처리를 위한 table에 매핑될 list경우 row가 비어 있을 때 비어있는 임시 row를 강제로 설정.
     * -> 등록/수정 화면일 때만.
     * @param mode
     * @param dyList
     * @return
     * @throws Exception
     */
    private List setEmptyRowInDyList(String mode, List dyList)  throws Exception {
        
        // 등록/수정 화면일 때만 empty row 정보를 강제 설정.
        if(EvaluCommService.MODE_REGI.equals(mode) || EvaluCommService.MODE_UPDT.equals(mode)){
            if(dyList == null || dyList.isEmpty()) {
                dyList = new ArrayList();
                dyList.add(new HashMap());
            }
        }
        
        return dyList;
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
     * 폼 객체 옵션 데이터를 추가한다.
     *
     * @param paramMap 파라메터
     * @param method 메소드
     * @throws Exception 발생오류
     */
    private void formObject(Map paramMap, String method) throws Exception {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        
        // 리스트화면 구성 관련 
        if (method.equalsIgnoreCase("listEvaluMgmt") || method.equalsIgnoreCase("listEvaluStgMgmt") || method.equalsIgnoreCase("listEvaluBudtMgmt")) {
            
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