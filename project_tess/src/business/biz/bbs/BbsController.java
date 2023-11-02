package business.biz.bbs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import business.biz.evalu.domain.EvaluMgmtDomain;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import business.biz.FormTagManager;
import business.biz.bbs.domain.BbsDomain;
import business.biz.comm.CommService;
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
public class BbsController extends BaseController {

	Log log = LogFactory.getLog(BbsController.class);

	@Autowired
    private BbsService  bbsService;

	@Autowired
	private CommService  commService;


	@Resource(name="fileManager")
	FileManager fileManager;

	// 공지사항
	protected static final String BBS_LIST_PAGE 		= "bbs/listNoticeBbs";
	protected static final String BBS_VIEW_PAGE 		= "bbs/viewNoticeBbs";
	protected static final String BBS_REGI_PAGE 		= "bbs/regiNoticeBbs";
	protected static final String BBS_UPDT_PAGE 		= "bbs/updtNoticeBbs";

	// FAQ
	protected static final String FAQ_LIST_PAGE 		= "bbs/listFaqBbs";
	protected static final String FAQ_VIEW_PAGE 		= "bbs/viewFaqBbs";
	protected static final String FAQ_REGI_PAGE 		= "bbs/regiFaqBbs";
	protected static final String FAQ_UPDT_PAGE 		= "bbs/updtFaqBbs";

	// 주요일정
	protected static final String SCHDL_LIST_PAGE 		= "bbs/listScheduleBbs";
	protected static final String SCHDL_VIEW_PAGE 		= "bbs/viewScheduleBbs";
	protected static final String SCHDL_REGI_PAGE 		= "bbs/regiScheduleBbs";
	protected static final String SCHDL_UPDT_PAGE 		= "bbs/updtScheduleBbs";

	// 자료실
	protected static final String FILE_LIST_PAGE 		= "bbs/listFileBbs";
	protected static final String FILE_VIEW_PAGE 		= "bbs/viewFileBbs";
	protected static final String FILE_REGI_PAGE 		= "bbs/regiFileBbs";
	protected static final String FILE_UPDT_PAGE 		= "bbs/updtFileBbs";



	protected static final String REDIRECT_PAGE 		= "redirect:/login.do";
	protected static final String HANDLE_PAGE 			= "bbs/handlePage";


	
	protected static final String BBS_TYPE_B01			= "B01";		// 공지사항
	protected static final String BBS_TYPE_B02			= "B02";		// Q&A
	protected static final String BBS_TYPE_B03			= "B03";		// FAQ
	protected static final String BBS_TYPE_B04			= "B04";		// 자료실

	/**
	 * 공지사항으로 이동
	*/
	@RequestMapping("/bbs/listBbsNotice.do")
    public String listBbsNotice(HttpServletRequest request, ModelMap model)
    throws Exception {
		logger.info("공지사항 페이지");
		if(listBbs(request, model, BBS_TYPE_B01)){
			return BBS_LIST_PAGE;
		}else{
			return REDIRECT_PAGE;
		}
	}
	
	/**
	 * FAQ으로 이동
	*/
	@RequestMapping("/bbs/listBbsFaq.do")
	public String listBbsFaq(HttpServletRequest request, ModelMap model)
	throws Exception {
		if(listBbs(request, model, BBS_TYPE_B03)){
			return FAQ_LIST_PAGE;
		}else{
			return REDIRECT_PAGE;
		}
	}
	
	/**
	 * 자료실로 이동
	*/
	@RequestMapping("/bbs/listBbsFile.do")
	public String listBbsRef(HttpServletRequest request, ModelMap model)
	throws Exception {
		if(listBbs(request, model, BBS_TYPE_B02)){
			return FILE_LIST_PAGE;
		}else{
			return REDIRECT_PAGE;
		}
	}

	/**
	 * 주요일정 이동
	*/
	@RequestMapping("/bbs/listBbsSchedule.do")
	public String listSchedule(HttpServletRequest request, ModelMap model)
	throws Exception {
		if(listBbs(request, model, BBS_TYPE_B04)){
			return SCHDL_LIST_PAGE;
		}else{
			return REDIRECT_PAGE;
		}
	}

	/**
	 * 공지사항 상세보기
	*/
	@RequestMapping("/bbs/viewBbsNotice.do")
    public String viewBbsNotice(HttpServletRequest request, ModelMap model)
    throws Exception {

		viewBbs(request, model);

		return BBS_VIEW_PAGE;
	}
	
	/**
	 * FAQ 상세보기
	*/
	@RequestMapping("/bbs/viewBbsFaq.do")
	public String viewBbsFaq(HttpServletRequest request, ModelMap model)
	throws Exception {

		viewBbs(request, model);

		return FAQ_VIEW_PAGE;
	}
	
	/**
	 * 자료실 상세보기
	*/
	@RequestMapping("/bbs/viewBbsFile.do")
	public String viewBbsFile(HttpServletRequest request, ModelMap model)
	throws Exception {

		viewBbs(request, model);

		return FILE_VIEW_PAGE;
	}

	/**
	 * 주요일정 상세보기
	*/
	@RequestMapping("/bbs/viewBbsSchedule.do")
	public String viewBbsSchedule(HttpServletRequest request, ModelMap model)
	throws Exception {
		viewBbs(request, model);
		return SCHDL_VIEW_PAGE;
	}

	/**
	 * 공지사항 작성페이지로 이동
	*/
	@RequestMapping("/bbs/openRegiBbsNotice.do")
    public String openRegiBbsNotice(HttpServletRequest request, ModelMap model)
    throws Exception {

        boolean flag = openRegiBbs(request, model);

        if (flag) return BBS_REGI_PAGE;
        else return REDIRECT_PAGE;
    }
	
	/**
	 * FAQ 작성페이지로 이동
	*/
	@RequestMapping("/bbs/openRegiBbsFaq.do")
	public String openRegiBbsFaq(HttpServletRequest request, ModelMap model)
	throws Exception {
		boolean flag = openRegiBbs(request, model);
		if(flag) return FAQ_REGI_PAGE;
		else return REDIRECT_PAGE;
	}
	
	/**
	 * 자료실 작성페이지로 이동
	*/
	@RequestMapping("/bbs/openRegiBbsFile.do")
	public String openRegiBbsFile(HttpServletRequest request, ModelMap model)
	throws Exception {
		openRegiBbs(request, model);
        boolean flag = openRegiBbs(request, model);
        if(flag) return FILE_REGI_PAGE;
        else return REDIRECT_PAGE;
	}
    /**
	 * 주요일정 작성페이지로 이동
	*/
	@RequestMapping("/bbs/openRegiBbsSchedule.do")
	public String openRegiBbsSchedule(HttpServletRequest request, ModelMap model)
	throws Exception {
		openRegiBbs(request, model);
        boolean flag = openRegiBbs(request, model);
        if(flag) return SCHDL_REGI_PAGE;
        else return REDIRECT_PAGE;
	}


	/**
	 * 공지사항 수정페이지로 이동
	*/
	@RequestMapping("/bbs/openUpdtBbsNotice.do")
    public String openUpdtBbsNotice(HttpServletRequest request, ModelMap model)
    throws Exception {
		openUpdtBbs(request, model);
        boolean flag = openUpdtBbs(request, model);
        if(flag) return BBS_UPDT_PAGE;
        else return HANDLE_PAGE;
	}

	/**
	 * FAQ 수정페이지로 이동
	*/
	@RequestMapping("/bbs/openUpdtBbsFaq.do")
	public String openUpdtBbsFaq(HttpServletRequest request, ModelMap model)
	throws Exception {
		openUpdtBbs(request, model);
        boolean flag = openUpdtBbs(request, model);
        if(flag) return FAQ_UPDT_PAGE;
        else return HANDLE_PAGE;
	}
	
	/**
	 * 자료실 수정페이지로 이동
	*/
	@RequestMapping("/bbs/openUpdtBbsFile.do")
	public String openUpdtBbsFile(HttpServletRequest request, ModelMap model)
	throws Exception {
		openUpdtBbs(request, model);
        boolean flag = openUpdtBbs(request, model);
        if(flag) return FILE_UPDT_PAGE;
        else return HANDLE_PAGE;

	}

	/**
	 * 주요일정 수정페이지로 이동
	*/
	@RequestMapping("/bbs/openUpdtBbsSchedule.do")
	public String openUpdtBbsSchedule(HttpServletRequest request, ModelMap model)
	throws Exception {
		openUpdtBbs(request, model);
        boolean flag = openUpdtBbs(request, model);
        if(flag) return SCHDL_UPDT_PAGE;
        else return HANDLE_PAGE;
	}

	/**
	 * 메인 주요일정 조회
	 * @param date
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/daySchedule.do")
	public ModelAndView getDaySchedule(@RequestParam("date") String date)
			throws Exception {
		Map returnMap   = new HashMap();
		List<Map> list = bbsService.getDayScheduleList(date);
		returnMap.put("list", list);
		return new ModelAndView(ajaxView, returnMap);
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
    private boolean listBbs(HttpServletRequest request, ModelMap model, String bbs_type)
    throws Exception {


	    //---------------------------------------------
	    //Default Setting Start
        String method       = getMethodName(new Throwable());
        // mapping request parameters to map
    	Map paramMap = getParameterMap(request, true);
    	//게시판 구분코드
    	logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
    	paramMap.put("bbs_type", bbs_type); //게시판 구분코드 맵에 등록
    	// Default Value Setting
    	boolean loginchk = setMappingValues(paramMap, method);
    	// mapping domain
    	BbsDomain bbsDomain	= new BbsDomain();
    	BeanUtils.copyProperties(bbsDomain, paramMap);
    	//Default Setting End
    	//---------------------------------------------

    	// combo 데이터 조회
    	//----------------------------------------------
    	paramMap.put("parentCode", paramMap.get("bbs_type"));
    	List codeList = commService.listCode(paramMap);

    	model.addAttribute("docuKindCodeList",FormTagManager.listToListCombo(codeList, "A")) ;
    	// combo 데이터 조회 끝
    	//----------------------------------------------

    	// 데이터 조회
    	//----------------------------------------------
    	int PAGE_NUM = 0;
    	PAGE_NUM = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
		PaginatedArrayList list	= null;
		
		try {
	    	list = bbsService.listBbs(paramMap, PAGE_NUM, PAGE_BBS_SIZE);
		} catch (Exception e) {
			e.printStackTrace();
		}

    	// 데이터 조회 끝
    	//----------------------------------------------

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("pageList", list);
		model.addAttribute("startNo",  list.getStartNo());
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("totalSize", list.getTotalSize());
		
		return loginchk;
    }

	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 등록페이지
	 */
	public boolean openRegiBbs(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------
		
		Boolean flag = true;

		// combo 데이터 조회
		//----------------------------------------------
		paramMap.put("parentCode", paramMap.get("bbs_type"));
		List codeList = commService.listCode(paramMap);

		model.addAttribute("docuKindCodeList",FormTagManager.listToListCombo(codeList, "S")) ;
		// combo 데이터 조회 끝
		//----------------------------------------------
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
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);

		return flag;
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
	@RequestMapping("/bbs/regiBbs.do")
	public ModelAndView regiBbs(HttpServletRequest request, ModelMap model)
	throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);
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
   		bbsService.saveBbs(paramMap,listFileInfo,procType);
   		resultFlag(message.getMessage("success.common.insert"));
		//등록처리 완료
		//---------------------------------------------
	} catch (Exception e) {
		e.printStackTrace();
	}

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);

		return new ModelAndView("bbs/handlePage", paramMap);

	}

    /**
    *
    * @param request
    * @param model
    * @return
    * @throws Exception
    *
    * 상세페이지
    */
	public void viewBbs(HttpServletRequest request, ModelMap model)
	throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------

		// 데이터 조회
		//----------------------------------------------
		Map returnMap = new HashMap();
		Map replyMap = new HashMap();
		
		try {
			//조회수 증가
			bbsService.updtBbsCnt(paramMap);
			
			//상세내용 검색
			returnMap= bbsService.viewBbs(paramMap);
			
			if("B02".equals(paramMap.get("bbs_type"))){
				//답글 조회
				replyMap = bbsService.viewReplyBbs(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 데이터 조회 끝
		//----------------------------------------------

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("resultView", returnMap);
		model.addAttribute("replyView", replyMap);

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
	public boolean openUpdtBbs(HttpServletRequest request, ModelMap model)
			throws Exception {

		boolean flag = true;

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------

		// combo 데이터 조회
		//----------------------------------------------
		paramMap.put("parentCode", paramMap.get("bbs_type"));
		List codeList = commService.listCode(paramMap);

		model.addAttribute("docuKindCodeList",FormTagManager.listToListCombo(codeList, "S")) ;
		// combo 데이터 조회 끝
		//----------------------------------------------
//		String viewName = null;
		Map returnMap = new HashMap<String, Object>();
		
		try {
		   	// 데이터 조회
		   	//----------------------------------------------
			returnMap = bbsService.viewBbs(paramMap);
		   	// 데이터 조회 끝
		   	//----------------------------------------------

			if(bbs_type.equals("B02")){
				String regiId = (String)returnMap.get("regiId");		//등록자 아이디
				String sessId = (String)paramMap.get("gsUserId");			//세션의 사용자 아이디
				boolean flag2 = regiId.equals(sessId);
				if(flag2 || "ROLE_AUTH_SYS".equals(paramMap.get("gsRoleId"))){
					flag = true;
				}else{
					resultFlag(message.getMessage("exception.bbs.failIdChk"));
					flag = false;
				}
			}else{
				flag = true;
			}

			BeanUtils.copyProperties(bbsDomain, returnMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        //----------------------------------
        // 허용된 파일 TYPE 설정
        //----------------------------------
        String allowedFileExts = ApplicationProperty.get("file.base.allow.exts");
        paramMap.put("allowedFileExts", allowedFileExts);

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("resultView", returnMap);

		return flag;
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
	@RequestMapping("/bbs/updtBbs.do")
	public ModelAndView updtBbs(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);
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
    		bbsService.saveBbs(paramMap,listFileInfo,procType);

    		resultFlag(message.getMessage("success.common.update"));
    		//등록처리 완료
    		//---------------------------------------------
	} catch (Exception e) {
		e.printStackTrace();
	}

    	//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);

		return new ModelAndView("bbs/handlePage", paramMap);

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
	@RequestMapping("/bbs/deltBbs.do")
	public ModelAndView deltBbs(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);
		//Default Setting End
		//---------------------------------------------
		
       //입력 수정 구분
       String procType = "D";
       
       List listFileInfo = null;

		// 게시판 삭제 처리
		//---------------------------------------------

		try {
			bbsService.saveBbs(paramMap,listFileInfo,procType);
			resultFlag(message.getMessage("success.common.delete"));
		} catch (Exception e) {
			e.printStackTrace();
		}


		//등록처리 완료
		//---------------------------------------------

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);

		return new ModelAndView("bbs/handlePage", paramMap);

	}

	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 답글페이지
	 */
	@RequestMapping("/bbs/openRegiReplyBbs.do")
	public String openRegiReplyBbs(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);

		//Default Setting End
		//---------------------------------------------

		// combo 데이터 조회
		//----------------------------------------------
		paramMap.put("parentCode", paramMap.get("bbs_type"));
		List codeList = commService.listCode(paramMap);

		model.addAttribute("docuKindCodeList",FormTagManager.listToListCombo(codeList, "S")) ;
		// combo 데이터 조회 끝
		//----------------------------------------------

	   	// 데이터 조회
	   	//----------------------------------------------
			
	   	Map returnMap= bbsService.viewBbs(paramMap);
	   	// 데이터 조회 끝
	   	//----------------------------------------------
	    //----------------------------------
        // 허용된 파일 TYPE 설정
        //----------------------------------
        String allowedFileExts = ApplicationProperty.get("file.base.allow.exts");
        paramMap.put("allowedFileExts", allowedFileExts);

		BeanUtils.copyProperties(bbsDomain, returnMap);

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("resultView", returnMap);

		return "bbs/openRegiReplyBbs";
	}


	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *
	 * 답글페이지
	 */
	@RequestMapping("/bbs/openUpdtReplyBbs.do")
	public String openUpdtReplyBbs(HttpServletRequest request, ModelMap model)
			throws Exception {

		//---------------------------------------------
		//Default Setting Start
		String method       = getMethodName(new Throwable());
		// mapping request parameters to map
		Map paramMap = getParameterMap(request, true);
		//게시판 구분코드
		String bbs_type = (String) paramMap.get("bbs_type");
		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);
		// Default Value Setting
		setMappingValues(paramMap, method);
		// mapping domain
		BbsDomain bbsDomain	= new BbsDomain();
		BeanUtils.copyProperties(bbsDomain, paramMap);

		//Default Setting End
		//---------------------------------------------

		// combo 데이터 조회
		//----------------------------------------------
		paramMap.put("parentCode", paramMap.get("bbs_type"));
		List codeList = commService.listCode(paramMap);

		model.addAttribute("docuKindCodeList",FormTagManager.listToListCombo(codeList, "S")) ;
		// combo 데이터 조회 끝
		//----------------------------------------------

	   	// 데이터 조회
	   	//----------------------------------------------

	   	Map returnMap= bbsService.viewBbs(paramMap);

	   	Map replyMap = bbsService.viewReplyBbs(paramMap);
	   	// 데이터 조회 끝
	   	//----------------------------------------------

		BeanUtils.copyProperties(bbsDomain, replyMap);

		//Return Values
		model.addAttribute("model", bbsDomain);
		model.addAttribute("modelMap", paramMap);
		model.addAttribute("resultView", returnMap);
		model.addAttribute("replyView", replyMap);

		return "bbs/openUpdtReplyBbs";
	}

    /**
	 * 메타데이터 시도검색 AJAX
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/ajaxOpenYnChk.do")
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
    		logger.debug("BBS_TYPE:::::::::::::::::::::"+bbs_type);

    		Map returnMap = new HashMap();
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
        paramMap.put("userId", userInfo.getUserId());
        paramMap.put("userNm", userInfo.getUserNm());
        paramMap.put("roleId", userInfo.getRoleId());
        
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
        
        return loginCheck(paramMap);
    }
	
	//로그인여부 확인
	private boolean loginCheck(Map paramMap){
		
		String bbs_type = (String)paramMap.get("bbs_type");
		boolean flag = true;
		
		if(bbs_type.equals("B02")){
			//TODO:: 자료실 페이지가 운영자만 확인가능?
//			String sessId = (String)paramMap.get("gsUserId");			//세션의 사용자 아이디
//			if(sessId != null || "ROLE_AUTH_SYS".equals(paramMap.get("gsRoleId"))){
//				flag =  true;
//			}else{
//				flag =  false;
//				resultFlag(message.getMessage("fail.common.nologin"));
//			}
		}
		return flag;
	}

}

