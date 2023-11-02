package business.sys.intercept;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import business.sys.authority.AuthorityService;
import business.sys.log.AccessControlService;
import business.sys.menu.MenuService;
import business.sys.program.ProgService;
import common.user.UserInfo;
import common.util.CommUtils;
import common.util.properties.ApplicationProperty;

/**
 * @Class Name : SecurityInterceptor.java
 * @Description :
 * @Modification Information
 * @author ntarget
 * @since 2014. 09. 23
 * @version
 * @see
 */
@SuppressWarnings({"unchecked","rawtypes"})
public class SecurityInterceptor extends HandlerInterceptorAdapter {

    protected final Log logger = LogFactory.getLog(getClass());

    protected static final String MAIN_URL				= "main.do";
    protected static final String CHECK_PIX				= ".do";
    protected static final String LOGIN_URL				= "/login.do";
    protected static final String ACCESS_DENIED_URL		= "/error/accessDenied.jsp";
    protected static final String ERROR_FLAG_EF 		= "EF";		// URL 강제접속 방지.

    @Autowired
    UserInfo userInfo;

    @Autowired
	private AccessControlService accessControlService;

    @Autowired
    private AuthorityService authorityService;

    @Autowired
	private ProgService progService;

    @Autowired
    private MenuService menuService;

	/**
	 * Filter processing page when accessing
	 *
	 * @param HttpServletRequest request, HttpServletResponse response, Object handler
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		
		String matchUrl		= getRequestURL(request);

		Map map = new HashMap();
		map.put("url", 		matchUrl);
		map.put("userId", 	CommUtils.nvlTrim(userInfo.getUserId()) );

		Map authMap = authorityService.getAuthorityUser(map);

		// non authority check
		if (authMap == null) {

		// authority check
		} else {
			if (CommUtils.empty(userInfo.getUserId()) ) {
	        	Map returnMap = new HashMap();
	        	returnMap.put("returnFlag"  , ERROR_FLAG_EF);

	        	request.getSession().setAttribute("CERT_RETURN", returnMap);

				response.sendRedirect(request.getContextPath() + LOGIN_URL);
				return false;
			}
			if (CommUtils.nvlTrim((String)authMap.get("auth")).equals("X") ) {
				response.sendRedirect(request.getContextPath() + ACCESS_DENIED_URL);
				return false;
			}
		}

		// Access Log
		insertLog(request, userInfo, "");

		// Page 정보 세션정의
		setPageInfo(request, userInfo);

		// Menu 정보 세션정의
		setMenuInfo(request, userInfo);

		logger.info("PAGEINFO:" + request.getSession().getAttribute("PAGEINFO"));
		logger.info("MENUINFO:" + request.getSession().getAttribute("MENUINFO"));

		return true;

	}


	// 프로그램정보 세션정의
	private void setPageInfo(HttpServletRequest request, UserInfo user) throws Exception {
		// Page Information
		Map pageMap	= new HashMap();
		pageMap.put("url", request.getRequestURI());

		if (getCurrPage(request).endsWith(CHECK_PIX)) {
			String excludeProg = CommUtils.nvlTrim(ApplicationProperty.get("exclude.acc.prog"));
			if (excludeProg.indexOf(getCurrPage(request)) < 0 ) {
				pageMap = progService.getProgInfo(pageMap);
				if (pageMap == null) pageMap = new HashMap();

				setPropertyUtilsBean(pageMap, userInfo);

				request.getSession().setAttribute(ApplicationProperty.get("SESS.PAGEINFO") , pageMap );
			}
		}
	}

	// 메뉴정보 세션정의
	private void setMenuInfo(HttpServletRequest request, UserInfo user) throws Exception {
		// Page Information
		Map pageMap	= new HashMap();
		pageMap.put("url", request.getRequestURI());

		// main.do 접속시 무조건 다시 메뉴조회 가능하게 메뉴정보를 초기화
		if (getCurrPage(request).endsWith(MAIN_URL))
			request.getSession().removeAttribute(ApplicationProperty.get("SESS.MENUINFO"));

		//if (getCurrPage(request).endsWith(CHECK_PIX)) {
	        List menuInfo = (List)request.getSession().getAttribute(ApplicationProperty.get("SESS.MENUINFO"));

	        if (menuInfo == null) {
				Map menuMap = new HashMap();
				menuMap.put("gsRoleId", userInfo.getRoleId());

	        	List menuList = menuService.listMainMenu(menuMap);
	        	request.getSession().setAttribute(ApplicationProperty.get("SESS.MENUINFO"), menuList);
	        }
		//}
	}

	// Log - Access
	private void insertLog(HttpServletRequest request, UserInfo user, String flag) {
		String userId 	= "";
		String userNm = "";
		if (user != null) {
			userId 		= CommUtils.nvlTrim(user.getUserId());
			userNm 		= CommUtils.nvlTrim(user.getUserNm());
		}

		// 빠른메뉴에서 파라메터 넘겨줌.
		String acchistType = CommUtils.nvlTrim((String)request.getParameter("acchistType"));

    	// Access Log Registration
		Map logMap = new HashMap();
		logMap.put("userId", 		CommUtils.nvlTrim(userId, "guest") );
		logMap.put("userNm", 		CommUtils.nvlTrim(userNm, "guest") );
		logMap.put("userIp", 		request.getRemoteAddr());
		logMap.put("progNm", 		request.getRequestURI());
		logMap.put("acchistType", 	acchistType);
		logMap.put("serverNm", 		request.getServerName()+"__"+request.getLocalName()+"__"+request.getLocale().toString());

		String currPage 	= request.getRequestURI();
		currPage			= currPage.substring(currPage.lastIndexOf("/")+1);

		// Access logging insert
		accessControlService.regiAccessLog(logMap);
	}

	private String getRequestURL(HttpServletRequest request) {
		String requestURL = request.getRequestURI();
		requestURL 		= requestURL.substring(request.getContextPath().length());
		String pathInfo = request.getPathInfo();

		if ("/".equals(requestURL) && pathInfo != null) {
			requestURL = pathInfo;
		}
		return requestURL;
	}

	private String getCurrPage(HttpServletRequest request) {
		String currPage 	= request.getRequestURI();
		currPage			= currPage.substring(currPage.lastIndexOf("/")+1);
		return currPage;
	}

	protected void setPropertyUtilsBean(Map map, UserInfo user) {
		try {

			Map userMap = new HashMap();
			userMap = PropertyUtils.describe(user);
			// Serializable Object excluded.
			userMap.remove("advisors");
			userMap.remove("class");
			userMap.remove("callbacks");
			userMap.remove("exposeProxy");
			userMap.remove("frozen");
			userMap.remove("preFiltered");
			userMap.remove("proxiedInterfaces");
			userMap.remove("proxyTargetClass");
			userMap.remove("targetClass");
			userMap.remove("targetObject");
			userMap.remove("targetSource");

			Iterator k = userMap.keySet().iterator();
			String key = "";
			while (k.hasNext()) {
				key = (String) k.next();
				map.put("gs"+CommUtils.toUpper(CommUtils.substring(key, 0, 1))+CommUtils.substring(key, 1)
						, userMap.get(key));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
