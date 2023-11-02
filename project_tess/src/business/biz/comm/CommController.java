/**
 * Program Name    : CommController
 * Description     : Common Process
 * Programmer Name : ntarget
 * svn ID          :
 * Creation Date   : 2014-06-09
 * Used Table      :
 */

package business.biz.comm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import business.biz.CommConst;
import business.biz.FormTagManager;
import business.biz.MailManager;
import business.biz.comm.domain.ComboDomain;
import business.biz.comm.domain.CommDomain;
import business.biz.temp.domain.SampleDomain;
import commf.message.Message;
import common.base.BaseController;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;

@Controller
@SuppressWarnings( {"rawtypes", "unused", "unchecked" })
public class CommController extends BaseController {

	@Autowired
	private CommService commService;


	/**
	 * Common Code List for GRID ComboBox, 2014.06.09 ntarget
	 *
	 * @return
	 */
	@RequestMapping("/comm/listComboCode.do")
    public ModelAndView listComboCode(HttpServletRequest request, ModelMap model)
    throws Exception {
		String method = getMethodName(new Throwable());
		CommDomain commDomain	= new CommDomain();

		// Request Parameter Values Setting
		Map paramMap = getParameterMap(request, true);

		// Default Value Setting
		SetMappingValues(paramMap, method);

		BeanUtils.copyProperties(commDomain, paramMap);
		// -------------------- Default Setting End -----------------------//

    	String searchNotIn = (String)paramMap.get("searchNotIn");
    	if(CommUtils.empty(searchNotIn) == false) {
        	String[] searchNotInArr = searchNotIn.split("[,]");
        	paramMap.put("searchNotIn", searchNotInArr);
    	}

		// [Combo]
		List listCombo = commService.listComboCode(paramMap);

		ComboDomain comboDomain = new ComboDomain();

		String allFlag = CommUtils.nvlTrim((String)paramMap.get("allFlag"));

		if (listCombo != null) {
			// All Flag Display
			if (allFlag.equals("Y")) {
				comboDomain.setComboValue(CommConst.comboValueAll);
				comboDomain.setComboText(Message.getMessage("prompt.comboTextAll"));
				listCombo.add(0, comboDomain );
			} else if (allFlag.equals("S")) {
				comboDomain.setComboValue(CommConst.comboValueAll);
				comboDomain.setComboText(Message.getMessage("prompt.comboTextSel"));
				listCombo.add(0, comboDomain );
			} else if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("Y_V_NULL")) {
				comboDomain.setComboValue("");
				comboDomain.setComboText(Message.getMessage("prompt.comboTextAll"));
				listCombo.add(0, comboDomain );
			} else if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("Y_ALL_NULL")) {
				listCombo.add(0, comboDomain );
			}
		}

    	Map returnMap	= new HashMap();
    	returnMap.put("combo", listCombo);


    	return new ModelAndView(ajaxView, returnMap);
    }
	
    /**
     * 공통코드 목록을 AJAX로 반환한다.
     *
     * @param request HTTP 요청
     * @param model 모델맵
     * @return 모델뷰
     * @throws Exception 발생오류
     */
    @RequestMapping("/comm/findCodeAjax.do")
    @SuppressWarnings({ "rawtypes" })
    public ModelAndView findCodeAjax(HttpServletRequest request, ModelMap model) throws Exception {

		// Request Parameter Values Setting
		Map paramMap  = getParameterMap(request, true);

		List list = commService.listComboCode(paramMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject("AJAX_MODEL", list);
		mav.setViewName(ajaxView);

		return mav;
	}






	// ******************************************************************************************************//
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Default Values Setting
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
	// ******************************************************************************************************//
	private void SetMappingValues(Map reqMap, String method) {
		if (method.equalsIgnoreCase("listComboCode")) {
		}
	}
}
