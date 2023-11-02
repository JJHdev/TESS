/**
 * @ClassName	: ProgAuth
 * @FirstWriter	: 2011. 01.	21 ntarget
 * @Changer 	: 2011. 01. 21 ntarget
 * @Desc. 		: 관리자 - 프로그램 권한 관리
 */
package business.sys.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import business.sys.user.domain.UserDomain;

import commf.exception.BusinessException;
import common.base.BaseController;
import common.util.CommUtils;

@Controller
@SuppressWarnings({"rawtypes","unchecked","unused"})
public class UserInfoController extends BaseController {

    private LoginManager loginManager = LoginManager.getInstance();

    @Autowired
    private UserInfoService  userInfoService;

    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Current user information.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
	/**
     * Access user information.
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	@RequestMapping("/sys/user/listCurrUser.do")
	public ModelAndView listCurrUser(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		// Business Define
		String methodName = getMethodName(new Throwable());
		UserDomain model = new UserDomain();

		// Request Parameter Values Setting
		Map reqMap = getParameterMap(request, true);

		BeanUtils.copyProperties(model, reqMap);
		//-------------------- Default Setting End -----------------------//

		if (!CommUtils.nvlTrim((String)reqMap.get("gsRole")).equalsIgnoreCase("SA000")) {
			throw new BusinessException("Can not access.");
		}

		List list = loginManager.listUser();
		if (list != null) {
			model.setUserSize(list.size());
			model.setListUser(list);
		}

		model.setSessionId(request.getSession().getId());

   		return new ModelAndView("/admin/listCurrUser", "UserDomain", model);
	}

	/**
	 * Access user information - Ajax
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sys/user/listCurrUserAjax.do")
	public ModelAndView listCurrUserAjax(HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		List list = loginManager.listUser();

    	// Param
    	Map resMap = new HashMap();
    	resMap.put("userList", 		list);

		return new ModelAndView(ajaxView, "AJAX_MODEL", resMap);
	}


    /*##################################   Data Management Zone   ##################################*/
	/**
	 * Default Values Setting
	 * @param model
	 * @param userInfo
	 */
	private void setSearchValues(Map reqMap, String method) {

		// Form Tag Default Setting
		formObject(reqMap, method);
	}

	/**
	 * Form Search Values Setting
	 * @param Map reqMap
	 */
	public void formObject(Map map, String method) {
		if (method.equalsIgnoreCase("")) {
		}
	}
}