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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibatis.sqlmap.engine.mapping.sql.dynamic.elements.IsEmptyTagHandler;

import business.biz.CommConst;
import business.biz.FileController;
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
 * 평가지표 관련 클래스
 * 
 * @class   : EvaluIxController
 * @author  : LHB
 * @since   : 2023.11.19
 * @version : 1.0
 *
 *   수정일       수정자                수정내용
 *  --------   --------    ---------------------------
 *  23.11.19     LHB           지표 관련 컨트롤러 생성
 */
@Controller
@SuppressWarnings({ "all" })
public class EvaluIxController extends BaseController {
    
	@Autowired
    private EvaluIxService evaluIxService;
	
    @Autowired
    private CommService commService;
    
    @Resource(name="fileManager")
    FileManager fileManager;
    
    /**
     * [사업관리] 평가지표 목록 호출
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/ix/listEvlIxList.do")
    public ModelAndView listEvaluIndicatMgmt(HttpServletRequest request, ModelMap model) throws Exception {
    	
        //-------------------------------------------------
        // Default Value Setting
        String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        //-------------------------------------------------
        
        Map returnMap = new HashMap();
        List evlListList = new ArrayList();
        
        String mode			= (String) paramMap.get("mode");
        String evaluHistSn	= paramMap.get("evaluHistSn") == null ? null : (String) paramMap.get("evaluHistSn");
        
        if (mode.equals(CommConst.MODE_VIEW) && evaluHistSn == null) {
        	// 전달받은 평가단계, 연도에 해당하는 지표값이 없음
        	returnMap.put("code", -3);
        	returnMap.put("msg", "평가사업 일련번호가 정의되지 않았습니다.");
        }
        
        Map evlIxMap = evaluIxService.getEvlIxSn(paramMap);
        
        if (evlIxMap != null) {
        	evlListList = (List) evaluIxService.listEvlIx(evlIxMap);
        	if (evlListList == null || evlListList.size() < 1) {
        		// 지표 항목 목록이 없음
        		returnMap.put("code", -2);
        		returnMap.put("msg", "조회된 지표 항목이 없습니다.");
        	} else {
        		returnMap.put("code", 1);
        		returnMap.put("data", evlListList);
        	}
        } else {
        	// 전달받은 평가단계, 연도에 해당하는 지표값이 없음
        	returnMap.put("code", -1);
        	returnMap.put("msg", "해당하는 평가단계, 연도에 해당하는 지표가 없습니다.");
        }
        
        return new ModelAndView(ajaxView, returnMap);
    }
    
    /**
     * [사업관리] 평가지표 목록 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/ix/saveEvlIxList.do")
    public ModelAndView saveEvlIxList(HttpServletRequest request, ModelMap model) throws Exception {
        //-------------------------------------------------
        // Default Value Setting
        String method	= getMethodName(new Throwable());
        Map paramMap	= setMappingValues(request, method);
        //-------------------------------------------------
        
        Map returnMap = evaluIxService.saveEvlIxList(paramMap);
        
        return new ModelAndView(ajaxView, returnMap);
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
        if (method.equalsIgnoreCase("listEvaluIndicatMgmt")) {
            
            // 평가단계
            paramMap.put("parentCode", "EVALU_ITEM");
            List evaluStageComboList = commService.listEvaluCode(paramMap);
            request.setAttribute("evaluStageComboList", evaluStageComboList);
        }
    }
}