package business.biz.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import business.biz.FormTagManager;
import business.biz.additionals.AddtnlsService;
import business.biz.bbs.BbsService;
import business.biz.comm.CommService;
import business.biz.main.domain.MainDomain;
import common.base.BaseController;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;
import common.util.properties.ApplicationProperty;

/**
 *  Main Controller Class
 * @author ntarget
 * @since 2014.10.23
 * @version 1.0
 * @see
 *
 * <pre>
 * << Modification Information >>
 *    Date	         Name          	       Desc
 * ----------      --------    ---------------------------
 *  2014.10.23      ntarget      Init.
 *
 * </pre>
 */

@Controller
@SuppressWarnings({ "rawtypes", "unused"})
public class MainController extends BaseController {

    @Autowired
    private CommService  commService;
    
    @Autowired
    private MainService  mainService;
    
	@Autowired
    private BbsService  bbsService;
	
	@Autowired
	private AddtnlsService  addtnlsService;
	
    
    /**
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/main.do")
    public String main(HttpServletRequest request, ModelMap model)
    throws Exception {
		 String method       = getMethodName(new Throwable());
	     // Request Parameter Values Setting
		 Map paramMap = setMappingValues(request, method );
		// default domain setting
		 MainDomain mainDomain	= new MainDomain();
		 setPropertyUtilsBean(paramMap, userInfo);
		
		BeanUtils.copyProperties(mainDomain, paramMap);
		
		String gsRoleId = (String)paramMap.get("gsRoleId");
		String gsUserId = (String)paramMap.get("gsUserId");
		
		System.out.println("gsUserId : " + gsUserId);
		
		
		paramMap.put("roleId", gsRoleId);
		paramMap.put("userId", gsUserId);
		
		
		//공지사항, 자료실, 주요일정
        String[] bbs_types = new String[] {
        		"B01","B02","B04"
        };
           
        
        for (int i = 0; i < bbs_types.length; i++) {
        	paramMap.put("bbs_type", bbs_types[i]);
        	//각 게시판 조회
        	PaginatedArrayList bbs = bbsService.listBbs(paramMap, 1, 5);

            logger.info(bbs_types[i] +" " +bbs.toString());

            model.addAttribute("custBbs" + bbs_types[i] + "List", bbs);

        }
        
        PaginatedArrayList list = addtnlsService.listExcelntCase(paramMap, 1, 5);
        
        model.addAttribute("addtnlsList", list);
        
        //평가단계별 통계현황
        //List listEvaluMainStat = mainService.listEvaluMainStat(paramMap);
        List listEvaluMainStat = mainService.listEvaluMainStat02(paramMap);
        //평가완료 사업 조회
        List listEvaluFinalBusi = mainService.listEvaluFinalBusi(paramMap);
        //평가위원 분야별 통계
        List listEvaluCommitStat = mainService.listEvaluCommitStat(paramMap);
        
        model.addAttribute("listEvaluMainStat", listEvaluMainStat);
        model.addAttribute("listEvaluFinalBusi", listEvaluFinalBusi);
        model.addAttribute("listEvaluCommitStat", listEvaluCommitStat);
        
		
		// -------------------- Default Setting End -----------------------//
        

		//Return Values
		model.addAttribute("model", mainDomain);
		model.addAttribute("map",   paramMap);
		
		
		if(gsUserId == null) {
			return "login";
		} else {
			return "main/main"; 
		}

		//return "main/main"; 
    }
	
    //++++++++++++++++++++++++++++++++++++++++++++++
    // Data Management Zone
    //++++++++++++++++++++++++++++++++++++++++++++++
    /**
     * Data Management
     * @param paramMap
     * @param method
     */
    private Map setMappingValues(HttpServletRequest request, String method) throws Exception {
        logger.debug("************ method:" + method);
        
        //---------------------------------------------------
        // 기본 설정
        //---------------------------------------------------
        
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

}

