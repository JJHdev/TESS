package business.biz.additionals;

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

import business.biz.FormTagManager;
import business.biz.additionals.domain.AdditionalsDomain;
import business.biz.bbs.domain.BbsDomain;
import business.biz.comm.CommService;
import business.biz.evalu.domain.EvaluMgmtDomain;
import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;

/**
 * Program Name    : BbsController
 * Description     : 게시판 Controller
 * Programmer Name : SYM
 * Creation Date   : 2014-11-05
 * Used Table(주요) :
 * 
 * @author SYM
 *
 */
@Controller
@SuppressWarnings({ "unchecked" , "static-access"})
public class AddtnlsController extends BaseController {

	@Autowired
    private AddtnlsService  addtnlsService;

	@Autowired
	private CommService  commService;


	@Resource(name="fileManager")
	FileManager fileManager;

	/**
	 * 평가관리로 이동
	*/
	@RequestMapping("/additionals/listExcelntCase.do")
    public String listExcelntCase(HttpServletRequest request, ModelMap model)
    throws Exception {
		if(listCase(request, model)){
			return "additionals/listExcelntCase";
		}else{
			return "redirect:/login.do";
		}
	}
	
	/**
	 * 평가관리 상세보기
	*/
	@RequestMapping("/additionals/viewCase.do")
    public String viewCase(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
		BeanUtils.copyProperties(additionalsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------

		// 데이터 조회
		//----------------------------------------------
		Map returnMap = new HashMap();
		Map replyMap = new HashMap();
		
		try {
			//조회수 증가
			addtnlsService.updtCaseCnt(paramMap);
			
			//상세내용 검색
			returnMap= addtnlsService.viewCase(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 데이터 조회 끝
		//----------------------------------------------

		//Return Values
		model.addAttribute("model", additionalsDomain);
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("resultView", returnMap);
		model.addAttribute("replyView", replyMap);

		return "additionals/viewCase";
	}
	
	
	/**
	 * 우수평가사례 작성페이지로 이동
	*/
	@RequestMapping("/additionals/openRegiCase.do")
    public String openRegiCase(HttpServletRequest request, ModelMap model)
    throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
		BeanUtils.copyProperties(additionalsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------
		Boolean flag=true;;
		String viewName;

		if(paramMap.get("gsUserId") == null){
			resultFlag(message.getMessage("fail.common.nologin"));
			flag = false;
		}else{
			flag = true;
		}

       //----------------------------------
       // 허용된 파일 TYPE 설정
       //----------------------------------
       String allowedFileExts = ApplicationProperty.get("file.base.allow.exts");
       paramMap.put("allowedFileExts", allowedFileExts);

		//Return Values
		model.addAttribute("model", additionalsDomain);
		model.addAttribute("modelMap", paramMap);
		
		if(flag){
			return "additionals/openRegiCase";
		} else {
			return "redirect:/additionals/listExcelntCase.do";
		}
	}

	
	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 등록처리
	 */
	@RequestMapping("/additionals/regiCase.do")
	public ModelAndView regiCase(HttpServletRequest request, ModelMap model)
	throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
		BeanUtils.copyProperties(additionalsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------
			
	      //입력 수정 구분
	      String procType = "I";	
	
		  try {
		  		//------------------
		  		// 파일 처리 부분
		  		//------------------
		  		List listFileInfo = fileManager.multiFileUpload(request);
		
		  		// 게시판 등록 처리
		  		//---------------------------------------------
		  		addtnlsService.saveCase(paramMap,listFileInfo,procType);
		  		resultFlag(message.getMessage("success.common.insert"));
				//등록처리 완료
				//---------------------------------------------
			} catch (Exception e) {
				e.printStackTrace();
			}
	
		//Return Values
		model.addAttribute("model", additionalsDomain);
		model.addAttribute("modelMap", paramMap);

		return new ModelAndView("additionals/caseHandlePage", paramMap);
		
	}
	
	/**
	 * 우수평가사례 수정페이지로 이동
	*/
	@RequestMapping("/additionals/openUpdtCase.do")
    public String openUpdtCase(HttpServletRequest request, ModelMap model)
    throws Exception {
		openUpdt(request, model);

		return "additionals/openUpdtCase";
	}
	
	
	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 수정페이지
	 */
	public String openUpdt(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
		BeanUtils.copyProperties(additionalsDomain, paramMap);
		
		//Default Setting End
		//---------------------------------------------

		// combo 데이터 조회
		//----------------------------------------------
		List codeList = commService.listCode(paramMap);

		// combo 데이터 조회 끝
		//----------------------------------------------
		String viewName = null;
		Map returnMap = new HashMap<String, Object>();
		
		try {
		   	// 데이터 조회
		   	//----------------------------------------------
			returnMap = addtnlsService.viewCase(paramMap);
		   	// 데이터 조회 끝
		   	//----------------------------------------------
			viewName = "additionals/openUpdtCase";

			BeanUtils.copyProperties(additionalsDomain, returnMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
       //----------------------------------
       // 허용된 파일 TYPE 설정
       //----------------------------------
       String allowedFileExts = ApplicationProperty.get("file.base.allow.exts");
       paramMap.put("allowedFileExts", allowedFileExts);

		//Return Values
		model.addAttribute("model", additionalsDomain);
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("resultView", returnMap);
		return viewName;
	}
	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 수정처리
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/additionals/updtCase.do")
	public ModelAndView updtCase(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
		BeanUtils.copyProperties(additionalsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------

      //입력 수정 구분
      String procType = "U";	
      
   try {
          //------------------
          // 파일 처리 부분
          //------------------
          List listFileInfo = fileManager.multiFileUpload(request);
          
   		// 게시판 등록 처리
   		//---------------------------------------------
          addtnlsService.saveCase(paramMap,listFileInfo,procType);

   		resultFlag(message.getMessage("success.common.update"));
   		//등록처리 완료
   		//---------------------------------------------
	} catch (Exception e) {
		e.printStackTrace();
	}

   	//Return Values
	model.addAttribute("model", additionalsDomain);
	model.addAttribute("modelMap", paramMap);

	return new ModelAndView("additionals/caseHandlePage", paramMap);

	}
	
	
    /**
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     *
     * 리스트
     */
    private boolean listCase(HttpServletRequest request, ModelMap model)
    throws Exception {
	    //---------------------------------------------
	    //Default Setting Start
        String method       = getMethodName(new Throwable());
        // mapping request parameters to map
    	Map paramMap = getParameterMap(request, true);
    	// Default Value Setting
    	boolean loginchk = setMappingValues(paramMap, method);
    	// mapping domain
    	AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
    	BeanUtils.copyProperties(additionalsDomain, paramMap);
    	
    	//----------------------------------------------

    	// 데이터 조회
    	//----------------------------------------------
    	int PAGE_NUM = 0;
    	PAGE_NUM = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
		PaginatedArrayList list	= null;
		
		try {
	    	list = addtnlsService.listExcelntCase(paramMap, PAGE_NUM, PAGE_BBS_SIZE);
		} catch (Exception e) {
			e.printStackTrace();
		}

    	// 데이터 조회 끝
    	//----------------------------------------------

		//Return Values
		model.addAttribute("model", additionalsDomain);
		model.addAttribute("pageList", list);
		model.addAttribute("startNo",  list.getStartNo());
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("totalSize", list.size());
		
		return loginchk;
    }
    
    /**
     * [사업관리] 사업평가관리 리스트 화면.
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/additionals/openFindBusi.do")
    public String openFindBusi(HttpServletRequest request, ModelMap model)
            throws Exception {
    	
        //---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = getParameterMap(request, true);
        setMappingValues(paramMap, method );
        
        // default domain setting
        AdditionalsDomain additionalsDomain = new AdditionalsDomain();
        BeanUtils.copyProperties(additionalsDomain, paramMap);
        //---------------------------------------------
        
        model.addAttribute("model"   ,  additionalsDomain);
        model.addAttribute("paramMap",  paramMap);
        
        return "/additionals/openFindBusi";
    }
    
    /**
     *  [사업관리] 사업등록 jqGrid로 리스트 ajax 조회 method
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/additionals/getBusinessList.do")
    public ModelAndView getEvaluCommit(HttpServletRequest request, ModelMap model)
            throws Exception {
        
    	//---------------------------------------------
        //Default Value Setting
        String method       = getMethodName(new Throwable());
        Map paramMap = getParameterMap(request, true);
        setMappingValues(paramMap, method );
       
        AdditionalsDomain additionalsDomain = new AdditionalsDomain(); 
        BeanUtils.copyProperties(additionalsDomain, paramMap);
        //---------------------------------------------
        
        
        CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
        PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));
        
        PaginatedArrayList list = null;
        list = addtnlsService.getBusiList(paramMap, CURR_PAGE, PAGE_SIZE);

        Map returnMap   = new HashMap();
        returnMap.put("pageGridList", list);
        returnMap.put("Total"       , list.getTotalSize());

        return new ModelAndView(ajaxView, returnMap);
    }
    
	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 삭제처리
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/additionals/deltCase.do")
	public ModelAndView deltCase(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		AdditionalsDomain additionalsDomain	= new AdditionalsDomain();
		BeanUtils.copyProperties(additionalsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------
		
      //입력 수정 구분
      String procType = "D";
      
      List listFileInfo = null;

		// 게시판 삭제 처리
		//---------------------------------------------

		try {
			addtnlsService.saveCase(paramMap,listFileInfo,procType);
			resultFlag(message.getMessage("success.common.delete"));
		} catch (Exception e) {
			e.printStackTrace();
		}


		//등록처리 완료
		//---------------------------------------------

		//Return Values
		model.addAttribute("model", additionalsDomain);
		model.addAttribute("modelMap", paramMap);

		return new ModelAndView("additionals/caseHandlePage", paramMap);

	}
    /**
	 * 메타데이터 시도검색 AJAX
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/additionals/ajaxOpenYnChk.do")
	public ModelAndView ajaxOpenYnChk(HttpServletRequest request, ModelMap modelMap) throws Exception {
		//-------------------- Default Setting Start ---------------------//
        String method           = getMethodName(new Throwable());

		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		// Default Value Setting
		setMappingValues(paramMap, method);
//        SetMappingValues(reqMap, method);

        //-------------------- Default Setting End -----------------------//

        ModelAndView mav = new ModelAndView();

        logger.info("reqMap >>>>>>>> " + paramMap);

        try {
    		// 데이터 조회
    		//----------------------------------------------
    		Map replyMap = new HashMap();
    		String viewName =null;	//이동할 url명

    		//게시판 구분코드
    		String bbs_type = (String) paramMap.get("bbs_type");

    		Map returnMap = new HashMap();
    		
    		/*
    		Map viewMap= bbsService.viewBbs(paramMap);	//공지글 검색

			String openYn = (String)viewMap.get("openYn");	//게시물 공개여부
			String regiId = (String)viewMap.get("regiId");		//등록자 아이디
			String sessId = (String)paramMap.get("gsUserId");			//세션의 사용자 아이디
			boolean flag = regiId.equals(sessId);
			
			if("Y".equals(openYn)){
				if(flag || "ROLE_AUTH_SYS".equals(paramMap.get("gsRoleId"))){
					returnMap.put("chk", "N");
				}else{
					returnMap.put("chk", "Y");
				}
			}else{
				returnMap.put("chk", "N");
			}

        	mav.addObject("AJAX_MODEL", returnMap);
        	mav.setViewName(ajaxView);
        */
    		
    		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

        return mav;
	}



	//++++++++++++++++++++++++++++++++++++++++++++++
    // Data Management Zone
	//++++++++++++++++++++++++++++++++++++++++++++++
	private boolean setMappingValues(Map paramMap, String method) throws Exception {
        //---------------------------------------------------
        // 기본 설정
        //---------------------------------------------------
        // 화면별 설정.
        //---------------------------------------------------
        if (method.equalsIgnoreCase("regiBbs") ) {
            // 등록자를 가입자 ID로 설정.
            paramMap.put("regiId"  , (String)paramMap.get("userId"));
        }else if(method.equalsIgnoreCase("updtBbs")){
            // 수정자를 가입자 ID로 설정.
            paramMap.put("updtId"  , (String)paramMap.get("userId"));
        }
        formObject(paramMap, method);
        
        return loginCheck(paramMap);
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
        if (method.equalsIgnoreCase("openRegiCase") || method.equalsIgnoreCase("openUpdt")) {
            paramMap.put("parentCode", "CITYAUTH");
            List sidoList = commService.listComboCode(paramMap);
            request.setAttribute("sidoList", sidoList);
            paramMap.put("parentCode", "EVALU_ITEM");
            List evaluStgList = commService.listEvaluCode(paramMap);
            request.setAttribute("evaluStgList", evaluStgList);
            
        }
    }
    
	//로그인여부 확인
	private boolean loginCheck(Map paramMap){
		
		boolean flag = true;
		
		String sessId = (String)paramMap.get("gsUserId");			//세션의 사용자 아이디
		if(sessId != null || "ROLE_AUTH_SYS".equals(paramMap.get("gsRoleId"))){
			flag =  true;
		}else{
			flag =  false;
			resultFlag(message.getMessage("fail.common.nologin"));
		}

		return flag;
	}

}

