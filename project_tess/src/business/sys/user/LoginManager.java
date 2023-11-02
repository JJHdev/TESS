/**
 * @ClassName	: LoginManager
 * @FirstWriter	: 2010. 12.	21 ntarget
 * @Changer 	: 2010. 12. 21 ntarget
 * @Desc. 		: Session information manager
 */
package business.sys.user;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import common.util.CommUtils;

@SuppressWarnings({"rawtypes","unchecked"})
public class LoginManager implements HttpSessionBindingListener {
    private static LoginManager loginManager 	= null;
    private static Hashtable loginUsers 		= new Hashtable();
    private static List listUser				= new ArrayList();

	private LoginManager(){
    	super();
	}

	public static synchronized LoginManager getInstance(){
		if(loginManager == null){
			loginManager = new LoginManager();
		}
		return loginManager;
	}

	// Already login check
	public boolean isLogin(String sessionId){
		boolean isLogin = false;
		Enumeration e = loginUsers.keys();
		String key = "";

		while(e.hasMoreElements()){
			key = (String)e.nextElement();

			if(sessionId.equals(key)){
				isLogin = true;
			}
		}
		return isLogin;
	}

	// Duplicate Login Check
	public boolean isUsing(String userId){
		boolean isUsing = false;
		Enumeration e = loginUsers.keys();
		String key = "";

		while(e.hasMoreElements()){
			key = (String)e.nextElement();
			Map userMap = (HashMap)loginUsers.get(key);

			if(userId.equals(CommUtils.nvlTrim((String)userMap.get("userId")))) {
				isUsing = true;
			}
		}
		return isUsing;
	}

	// Login User List
	public List listUser(){
		Enumeration e = loginUsers.keys();
		String key = "";

		listUser = new ArrayList();

		while(e.hasMoreElements()){
			key = (String)e.nextElement();
			Map userMap = (HashMap)loginUsers.get(key);
			userMap.put("sessionId", key);
			userMap.put("createTimeName", CommUtils.formatDateTime((String)userMap.get("createTime")));
			listUser.add(userMap);
		}
		return listUser;
	}

	// Session Create.
	@SuppressWarnings("static-access")
	public void setSession(HttpSession session, Map<String, String> userMap){
		System.out.println("★★★★★  - LOG IN ["+userMap.get("userId")+", "+session.getId()+"]");
		loginUsers.put(session.getId(), userMap);
        session.setAttribute("LOGININFO", this.getInstance());
	}

	// Session Event Handle (Registration)(
	public void valueBound(HttpSessionBindingEvent event){
		System.out.println("★★★★★  - LOG IN ["+event.getName()+"]");
		listUser();
	}

	// Session Event Handle (Remove)
	public void valueUnbound(HttpSessionBindingEvent event){
		System.out.println("▶▶▶▶▶ - LOG OUT [USER ID = "+getUserID(event.getSession().getId())+"]["+event.getSession().getId()+"]");
		loginUsers.remove(event.getSession().getId());
		listUser();
	}

	// Last Time Update
	public void setLastTime(String sessionId, String lastTime){
		Map userMap = (HashMap)loginUsers.get(sessionId);

		if (userMap != null) {
			userMap.put("lastTime", lastTime);

			loginUsers.put(sessionId, userMap);
		}
	}

	// User ID Search
	public String getUserID(String sessionId){
		Map userMap = (HashMap)loginUsers.get(sessionId);

		if (userMap == null) {
			return null;
		}
	    return (String)userMap.get("userId");
	}

	// User Information Search
	public Map getUserInfo(String sessionId){
		Map userMap = (HashMap)loginUsers.get(sessionId);

		if (userMap == null) {
			return null;
		}
	    return userMap;
	}


	// Current Session User Count
	public int getUserCount(){
	    return loginUsers.size();
	}

	// Current User Count
	public int getOnlyUserCount(){
		String str = "";
		int cnt = 0;

		Enumeration e = loginUsers.keys();
		String key = "";

		while(e.hasMoreElements()){
			key = (String)e.nextElement();
			Map userMap = (HashMap)loginUsers.get(key);
			String cStr = (String)userMap.get("userId");

			if (str.indexOf(cStr) < 0) {
				str += cStr+"|";
				cnt++;
			}
		}

		return cnt;
	}
}

