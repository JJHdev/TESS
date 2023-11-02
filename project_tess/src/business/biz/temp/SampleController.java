package business.biz.temp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.map.LinkedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import business.biz.FileService;
import business.biz.FormTagManager;
import business.biz.comm.CommService;
import business.biz.temp.domain.SampleDomain;

import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;

/**
 *  Sample Controller Class
 * @author ntarget
 * @since 2014.06.15
 * @version 1.0
 * @see
 *
 * <pre>
 * << Modification Information >>
 *    Date	         Name          	       Desc
 * ----------      --------    ---------------------------
 *  2014.06.15      ntarget      Init.
 *
 * </pre>
 */

@Controller
@SuppressWarnings({ "rawtypes", "static-access", "unchecked"})
public class SampleController extends BaseController {

	@Autowired
    private SampleService  sampleService;

    @Autowired
    private CommService  commService;

	@Autowired
	private FileService fileService;

	@Resource(name="fileManager")
	FileManager fileManager;

    /**
     * 샘플 리스트 조회 - Paging
	 * 예제 샘플)
	 * 1. 리스트 조회
	 * 2. 파라메터 Map 으로 받기
	 * 3. Logging 처리 방법
	 * 4. Return Result 방법(ModelMap 으로)
	 * 5. Message 사용법 getMessage("");
     * 6. Paging 처리
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/temp/listSample.do")
    public String listSample(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		//Map paramMap = getParameterMap(request, true);
		setPropertyUtilsBean(paramMap, userInfo);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

		logger.info("admin123   = "+CommUtils.getPasswordEncodingString("admin123"));
		logger.debug("##### tode1234! 암호" + CommUtils.getPasswordEncodingString("tode1234!"));

		//Controller 에서 Exception 처리
    	//if (1 == 1)
    	//	throw new EgovBizException("값이 없습니다.");

		CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);

    	PaginatedArrayList list	= null;
    	list = sampleService.listSample(paramMap, CURR_PAGE, PAGE_SIZE);

    	logger.info("Message =============== "+message.getMessage("title.tmp.hed.calendar"));
    	logger.info("request.getServerName() =============== "+request.getServerName());		// 125.140.104.206
    	logger.info("request.getLocalAddr() =============== "+request.getLocalAddr());			// 125.140.104.206
    	logger.info("request.getLocalName() =============== "+request.getLocalName());			// 125.140.104.206
    	logger.info("request.getRemoteAddr() =============== "+request.getRemoteAddr());		// 125.140.104.227
    	logger.info("request.getRemoteHost() =============== "+request.getRemoteHost());		// 125.140.104.227
    	logger.info("request.getRequestURI() =============== "+request.getRequestURI());		// /temp/listSample.do
    	logger.info("request.getRequestURL() =============== "+request.getRequestURL()+"");		// http://125.140.104.206:8088/temp/listSample.do


    	/* 게시판 내용 문자바이트 자르기 */
    	String content = "가나다라마바사아자카타파하 가나다라마바사아자카타파하 가나다라마바사아자카타파하 가나다라마바사아자카타파하";
    	System.out.println("TEST7 = "+content.getBytes().length);
    	System.out.println("TEST7 = "+content.getBytes("MS949").length);		// UTF-8은 3byte 이기때문에.. MS949 사용함.
    	int cutCount	= 35;
    	StringBuffer sumStr	= new StringBuffer();

    	for (int m = 0; m < (int)Math.ceil(content.getBytes().length/(double)cutCount); m++) {
    		sumStr.append(CommUtils.substringByte(content, m * cutCount, m * cutCount + cutCount));
    		System.out.println("TEST8 = "+sumStr.toString());
    	}

    	System.out.println("TEST9 = "+sumStr.toString());
    	/* 게시판 내용 문자바이트 자르기 */



		// 테스트
		paramMap.put("cdType", "COMP_STAT");
		List listCode1 = commService.listCode(paramMap);
		model.addAttribute("cmbCompStat", FormTagManager.listToMapCombo(listCode1, "codeList", "Y"));

		// 입력구분
		paramMap.put("cdType", "INST_TYPE");
		List listCode2 = commService.listCode(paramMap);
		model.addAttribute("chkInstType", FormTagManager.listToMapCombo(listCode2, "codeList", "N"));


		//Return Values
		model.addAttribute("model", sampleDomain);
		model.addAttribute("map",   paramMap);
		model.addAttribute("pageList", list);
		model.addAttribute("startNo",  list.getStartNo());

		return "temp/listSample";
    }


    /**
     * 샘플 등록 페이지 오픈
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/openRegiSample.do")
    public String openRegiSample(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	// 상세조회
    	Map viewMap = sampleService.viewSample(paramMap);
    	if (viewMap != null) {
    		BeanUtils.copyProperties(sampleDomain, viewMap);
    	}

    	paramMap.put("rootNo",	paramMap.get("seq"));

    	// 첨부파일 조회
    	List listFile	= null;
    	listFile = fileService.listFile(paramMap);

    	paramMap.put("pageTitle", "Regi Test");					 	// Result Case 1

    	//sampleDomain.setLoginDttm(CommUtils.getToday(""));	// Result Case 2

    	model.addAttribute("model", 	sampleDomain);
    	model.addAttribute("map", 		paramMap);
    	model.addAttribute("listFile", 	listFile);

    	return "temp/regiSample";
    }


    /**
     * 샘플 등록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/regiSample.do")
    public String regiSample(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	// 파일 첨부
    	List listNewFile 	= fileManager.multiFileUpload(request);

		String  keyNo 		= sampleService.regiSample2(paramMap);

		// 첨부파일 DB 처리
		if (!CommUtils.nvlTrim(keyNo).equals("")) {
			paramMap.put("rootNo", 	keyNo);	// Key
			paramMap.put("subDir", 	ApplicationProperty.get("upload.sub.dir1"));	// bbs -- 여기부부은 좀더 고려..

			// optional service
			paramMap.put("compNo",    "");

			fileService.fileManagement(paramMap, listNewFile);

			resultFlag(message.getMessage("prompt.success"));
		} else {
			resultFlag("0");
		}

    	return "redirect:/temp/listSample.do";
    }

    /**
     * 샘플 수정
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/updtSample.do")
    public String updtSample(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	// 파일 첨부
    	List listNewFile 	= fileManager.multiFileUpload(request);

    	int  cnt = sampleService.updtSample(paramMap);

    	// 첨부파일 DB 처리
    	if (!CommUtils.nvlTrim((String)paramMap.get("seq")).equals("") && cnt > 0) {
    		paramMap.put("rootNo", 	(String)paramMap.get("seq"));	// Key
    		paramMap.put("subDir", 	ApplicationProperty.get("upload.sub.dir1"));

			// optional service
			paramMap.put("compNo",    "");

    		fileService.fileManagement(paramMap, listNewFile);

    		resultFlag(message.getMessage("prompt.success"));
    	} else {
    		resultFlag("0");
    	}

    	return "redirect:/temp/listSample.do";
    }

    /**
     * 샘플 삭제
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/deltSample.do")
    public String deltSample(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	int  cnt = sampleService.deltSample(paramMap);

    	// 첨부파일 DB 처리
    	if (!CommUtils.nvlTrim((String)paramMap.get("seq")).equals("") && cnt > 0) {
    		paramMap.put("rootNo", 	(String)paramMap.get("seq"));	// Key
    		paramMap.put("subDir", 	ApplicationProperty.get("upload.sub.dir1"));

    		paramMap.put("status", 	"D");		// 첨부파일 삭제상태

    		fileService.fileManagement(paramMap, null);

    		resultFlag(message.getMessage("prompt.success"));
    	} else {
    		resultFlag("0");
    	}

    	return "redirect:/temp/listSample.do";
    }




    /**
     * 샘플 리스트 조회 페이지 오픈- GRID
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/listSampleGrid.do")
    public String listSampleGrid(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//


    	return "temp/listSampleGrid";
    }

    /**
	 * 샘플 리스트 조회 - GRID
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/temp/getSampleGrid.do")
    public ModelAndView getSampleGrid(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

		CURR_PAGE = CommUtils.strToInt((String)paramMap.get("page"), CURR_PAGE);
		PAGE_SIZE = CommUtils.toInt(CommUtils.nvlTrim((String)paramMap.get("rows"), String.valueOf(PAGE_SIZE)));

    	PaginatedArrayList list	= null;
    	list = sampleService.listSample(paramMap, CURR_PAGE, PAGE_SIZE);


    	Map returnMap	= new HashMap();
    	returnMap.put("pageGridList", list);


        return new ModelAndView(ajaxView, returnMap);
    }

    /**
     * Sample Grid Save - GRID
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/saveSampleGrid.do")
    public ModelAndView saveSampleGrid(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
    		msg = sampleService.saveSampleGrid(paramMap);
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
     * Multi Sample Grid Save - GRID
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/saveMultiSampleGrid.do")
    public ModelAndView saveMultiSampleGrid(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	int cnt = 0;

    	String submitType	= CommUtils.nvlTrim((String)paramMap.get("submitType"));

    	Map rtnmap	= new HashMap();
    	String msg = "";

    	try {
        	if (submitType.equals("inline")) {
        		msg = sampleService.saveMultiSampleGrid(paramMap);
        	} else {
        		msg = sampleService.saveSampleGrid(paramMap);
        	}
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
	 * 샘플 Chart
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/temp/listSampleChart.do")
    public String listSampleChart(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//


    	return "temp/listSampleChart";
    }

	/**
	 * 샘플 Chart 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/temp/getSampleChart.do")
    public ModelAndView getSampleChart(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	List list = sampleService.listSampleChart(paramMap);

    	Map returnMap	= new HashMap();
    	returnMap.put("gridList", list);

        return new ModelAndView(ajaxView, returnMap);
    }




    /**
     * 샘플 팝업
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/viewSamplePopup.do")
    public String viewSamplePopup(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		SampleDomain sampleDomain	= new SampleDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(sampleDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	model.addAttribute("model", 	sampleDomain);

    	return "temp/viewSamplePopup";
    }


    /**
     * 샘플 엑셀 다운
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/temp/exclSample.do")
    public String exclSample(HttpServletRequest request, ModelMap model)
    throws Exception {
    	String method 				= getMethodName(new Throwable());
    	SampleDomain sampleDomain	= new SampleDomain();

    	// Request Parameter Values Setting
    	Map paramMap = getParameterMap(request, true);

    	// Default Value Setting
    	SetMappingValues(paramMap, method);

    	BeanUtils.copyProperties(sampleDomain, paramMap);
    	//-------------------- Default Setting End -----------------------//

    	List resultList	= sampleService.listSample(paramMap);

    	List titleList	= new ArrayList();
    	LinkedMap titleMap	= new LinkedMap();
    	titleMap.put("seq", 				"순서");
    	titleMap.put("userId", 				"사용자ID");
    	titleMap.put("userNm", 				"사용자명");
    	titleMap.put("title", 				"제목");
    	titleMap.put("userType", 			"사용자구분");
    	titleMap.put("userTypeNm", 			"사용자구분명");
    	titleMap.put("regiDttm", 			"등록일시");
    	titleMap.put("regiDate", 			"등록일자");
    	titleMap.put("amt", 				"금액");
    	titleList.add(titleMap);

    	model.addAttribute("titleList",  	titleList);			// Download Title Name
    	model.addAttribute("excelList",  	resultList);		// Excel Data
		model.addAttribute("filename",  	"listSample");		// Download Excel Name

		return "excelView";		// Excel Down View Name (=excelView)
    }




	// ******************************************************************************************************//
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    Default Values Setting     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
	// ******************************************************************************************************//
	private void SetMappingValues(Map paramMap, String method) {
		//paramMap.put("gsUserId",	CommUtils.nvlTrim((String)paramMap.get("gsUserId"), 	"ntarget"));

		if (method.equalsIgnoreCase("regiSample") || method.equalsIgnoreCase("regiSampleModel")) {
			paramMap.put("userId",	CommUtils.nvlTrim((String)paramMap.get("userId"), 	"ntarget"));
			paramMap.put("userNm",	CommUtils.nvlTrim((String)paramMap.get("userNm"), 	"엔타겟"));
			paramMap.put("title",	CommUtils.nvlTrim((String)paramMap.get("title"), 	"none"));
			paramMap.put("content",	CommUtils.nvlTrim((String)paramMap.get("content"),	""));

		}
		if (method.equalsIgnoreCase("updtSample") ) {
			paramMap.put("userId",	CommUtils.nvlTrim((String)paramMap.get("userId"), 	"ntarget"));
			paramMap.put("userNm",	CommUtils.nvlTrim((String)paramMap.get("userNm"), 	"엔타겟"));
			paramMap.put("title",	CommUtils.nvlTrim((String)paramMap.get("title"), 	"none"));
			paramMap.put("content",	CommUtils.nvlTrim((String)paramMap.get("content"),	""));
		}
		if (method.equalsIgnoreCase("saveSampleGrid") ) {
			paramMap.put("userId",	CommUtils.nvlTrim((String)paramMap.get("userId"), 	"ntarget"));
			paramMap.put("userNm",	CommUtils.nvlTrim((String)paramMap.get("userNm"), 	"엔타겟"));
			paramMap.put("title",	CommUtils.nvlTrim((String)paramMap.get("title"), 	"none"));
			paramMap.put("content",	CommUtils.nvlTrim((String)paramMap.get("content"),	""));
			paramMap.put("userType",CommUtils.nvlTrim((String)paramMap.get("userTypeNm"),	""));
		}

		if (method.equalsIgnoreCase("listSample") ) {
			paramMap.put("fromDate", CommUtils.getToday("-"));
			//paramMap.put("comboAdrr", "80");
			paramMap.put("chkAddr", "0");

			String[] arrChkAddr = {"0", "1"};
			paramMap.put("arrChkAddr", arrChkAddr);

		}
	}
}

