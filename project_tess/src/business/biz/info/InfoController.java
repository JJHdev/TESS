package business.biz.info;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import common.base.BaseController;

/**
 * Program Name    : InfoController
 * Description     : 평가시스템소개 Controller
 * Programmer Name : LCS
 * Creation Date   : 2016-03-29
 * Used Table(주요) :
 * 
 * @author LCS
 *
 */
@Controller
@SuppressWarnings({ "rawtypes", "unchecked" })
public class InfoController extends BaseController {

	/**
	 * 지역관광기획평가센터 소개
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/viewAreaTourPlanEvalCenter.do")
	public String viewAreaTourPlanEvalCenter(HttpServletRequest request, ModelMap model) throws Exception {

		return "/info/viewAreaTourPlanEvalCenter";

	}

	/**
	 * 평가 및 방법
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/viewHowto.do")
	public String howto(HttpServletRequest request, ModelMap model) throws Exception {

		return "/info/viewHowto";

	}


	/**
	 * 이용약관 및 방침 - 이용약관
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/viewAccessTerms.do")
	public String viewAccessTerms(HttpServletRequest request, ModelMap model) throws Exception {
		return "/info/viewAccessTerms";
	}


	/**
	 * 이용약관 및 방침 - 개인정보처리방침
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/viewPrivacy.do")
	public String viewPrivacy(HttpServletRequest request, ModelMap model) throws Exception {
		return "/info/viewPrivacy";
	}



	/**
	 * 이용약관 및 방침 - 이메일
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/viewUnauthEmail.do")
	public String viewUnauthEmail(HttpServletRequest request, ModelMap model) throws Exception {
		return "/info/viewUnauthEmail";
	}

	/**
	 * 사이트맵
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/info/viewSiteMap.do")
	public String viewSiteMap(HttpServletRequest request, ModelMap model) throws Exception {
		
		return "/info/viewSiteMap";
		
	}
	
}
