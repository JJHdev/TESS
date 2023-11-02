package business.sys.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.user.UserInfo;


@Service
@SuppressWarnings({ "rawtypes" })
public class UserInfoService extends BaseService {

	@Autowired
	private CommonDAOImpl dao;

	/* USERINFO GET */
	public UserInfo getUserInfo(Map user) {
		UserInfo userInfo = (UserInfo)dao.view("UserInfo.getUserInfo", user);
		return userInfo;
	}

}