package business.biz.comm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import business.sys.log.AccessControlService;
import business.sys.user.UserInfoService;

import common.base.BaseController;
import common.user.UserInfo;
import common.util.CommUtils;
import common.util.properties.ApplicationProperty;

/**
 * Program Name    : LoginController
 * Description     : Login, Logout
 * 					 Login 로그 등록
 *
 * Programmer Name : ntarget
 * Creation Date   : 2014-06-12
 * Used Table      :
 */
@Controller
@SuppressWarnings({"unchecked","rawtypes", "unused" })
public class LoginController extends BaseController {

    protected static final String FORM_USERNAME 		= "j_userid";
    protected static final String FORM_PASSWORD 		= "j_password";
    protected static final String LOGIN_SUCC_URL		= "/loginSuccess.do";
    protected static final String LOGIN_SUCC_PAGE		= "loginSuccess";
    protected static final String LOGIN_URL				= "/login.do";
    protected static final String LOGIN_URL_PAGE		= "login";
    protected static final String LOGOUT_URL_PAGE		= "logout";

    protected static final String ERROR_FLAG_E1 		= "E1";		// 사용자 정보가 없음.
    protected static final String ERROR_FLAG_E2 		= "E2";		// 패스워드 틀림.
    protected static final String ERROR_FLAG_E3 		= "E3";		// 사용하지 않는 ID
    protected static final String ERROR_FLAG_E4 		= "E4";		// 승인되지 않은 ID
    protected static final String ERROR_FLAG_E8 		= "E8";		// 해당 업체는 사용상태가 아님.
    protected static final String ERROR_FLAG_EA 		= "EA";		// 가입 승인중인 아이디 입니다.
    protected static final String ERROR_FLAG_EB 		= "EB";		// 등록된 권한정보가 없습니다. 관리자에게 문의 바랍니다.

    protected static final String LOGIN_CERT_TYPE		= "cert";	// "cert" 인증서.
    protected static final String CERT_RETURN 			= "CERT_RETURN";

    @Autowired
    private UserInfoService userInfoService;

    @Autowired
    private AccessControlService accessControlService;

    @RequestMapping("/login.do")
    public String login(HttpServletRequest request, ModelMap model)
            throws Exception {

        return LOGIN_URL_PAGE;
    }

    @RequestMapping("/loginSuccess.do")
    public String loginSuccess(HttpServletRequest request, ModelMap model)
    throws Exception {

    	return LOGIN_SUCC_PAGE;
    }

    /**
     * 로그인 처리. (일반, 인증서)
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping("/j_login_check.do")
    public ModelAndView j_login_check(HttpServletRequest request, HttpServletResponse response, ModelMap model)
            throws Exception {

		String logUserNm 	= "";
		String failFlag		= "";
		String returnUrl	= LOGIN_SUCC_URL;

		String userId 	= "";
		String password = "";
		
		if(request.getParameter("ev_userId") == null) {
			
			userId 	= CommUtils.nvlTrim(request.getParameter(FORM_USERNAME));
			password = CommUtils.nvlTrim(request.getParameter(FORM_PASSWORD));
			
			//SHA256 암호화
			password = CommUtils.getPasswordEncodingString(password);
		} else {
			
			userId 	= CommUtils.nvlTrim(request.getParameter("ev_userId"));
			password = CommUtils.nvlTrim(request.getParameter("ev_passWd"));
		}
		
		System.out.println("userId :: " + userId);
		System.out.println("password :: " + password);

		Map reqUserMap	= new HashMap();
		reqUserMap.put("userId", 		userId);
		reqUserMap.put("loginType", 	"");

		UserInfo user = (UserInfo)userInfoService.getUserInfo(reqUserMap);
		
		System.out.println("user :: " + user);

		// 로그인 검증.
        if(user == null) {
        	failFlag = ERROR_FLAG_E1;	// 사용자정보가 없음.
        } else {
            if("N".equals(CommUtils.nvlTrim(user.getUseYn()))) {
	        	failFlag = ERROR_FLAG_E3;	// 사용하지 않는 id입니다.
			} else if(password.equals(CommUtils.nvlTrim(user.getPasswd())) == false) {
            	failFlag = ERROR_FLAG_E2;	// 패스워드 틀림 (일반)
			} else if("80".equals(CommUtils.nvlTrim(user.getUseStat())) ) {	//승인거부 상태로 변경
				failFlag = ERROR_FLAG_E8;	// 해당 사용자는 사용가능 상태가 아닙니다.
			} else if("10".equals(CommUtils.nvlTrim(user.getUseStat()))){	    // 승인대기중인 상태
	        	failFlag = ERROR_FLAG_EA;	// 가입 승인중인 아이디 입니다.
	        } else if("".equals(CommUtils.nvlTrim(user.getRoleId()))){	    // 권한정보 유무
	        	failFlag = ERROR_FLAG_EB;	// 등록된 권한정보가 없습니다.
	        }
        }
        
        System.out.println("failFlag :: " + failFlag);

        // 로그인 실패시
        if (CommUtils.nvlTrim(failFlag).equals("") == false) {
        	Map returnMap = new HashMap();
        	returnMap.put("returnFlag"  , failFlag);

        	request.getSession().setAttribute(CERT_RETURN, returnMap);
        	returnUrl = LOGIN_URL;

        // 로그인 성공시
        } else {
			clearSessionInformation(request);
            // UserInfo Bean Session
            BeanUtils.copyProperties(user, userInfo);
        }

        // 로그인시 무조건 기존 메뉴정보는 삭제처리.
        request.getSession().removeAttribute(ApplicationProperty.get("SESS.MENUINFO"));

        /**
         * Login Log Registration  - Start
         */
        Map logMap = new HashMap();
		logMap.put("userId", 		CommUtils.nvlTrim(userId, "guest") );
        logMap.put("userIp",    	request.getRemoteAddr());
        logMap.put("serverNm", 		request.getServerName()+"_"+request.getLocalName()+"_"+request.getLocale().toString());

        // When failure
        if(CommUtils.nvlTrim(failFlag).equals("") == false) {
			logMap.put("loginStat", "X");
			logMap.put("loginReas", failFlag);
        // When success
        }else{
			logMap.put("loginStat", "O");
			logMap.put("loginReas", "");
        }

        accessControlService.regiLoginInfo(logMap);
        /**
         * Login Log Registration  - End
         */

        //return returnUrl;
        return new ModelAndView("redirect:"+returnUrl);
    }

    /**
     * 로그아웃 처리.
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/j_logout_check.do")
    public String j_logout_check(HttpServletRequest request, HttpServletResponse response, ModelMap model)
            throws Exception {
    	clearSessionInformation(request);
		request.getSession().invalidate();

        return LOGOUT_URL_PAGE;
    }

 	// Session Remove
	private void clearSessionInformation(HttpServletRequest request) {
		request.getSession().removeAttribute(ApplicationProperty.get("SESS.USERINFO"));
		request.getSession().removeAttribute(ApplicationProperty.get("SESS.PAGEINFO"));
		request.getSession().removeAttribute(ApplicationProperty.get("SESS.MENUINFO"));
		request.getSession().removeAttribute(ApplicationProperty.get("SESS.PROCFLAG"));
		//request.getSession().removeAttribute(ApplicationProperty.get("SESS.CERTINFO"));
	}


}
