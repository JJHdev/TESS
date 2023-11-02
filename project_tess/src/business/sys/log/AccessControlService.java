package business.sys.log;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;

/**
 * AcessControlService
 * ntarget :
 * 20110-03-31 : registration access log
 */
@Service
@SuppressWarnings({"rawtypes"})
public class AccessControlService {

	@Autowired
	private CommonDAOImpl dao;

	public int regiAccessLog(Map map){
		return dao.update("AccessControl.regiAccessLog", map);
	}

	public void regiLoginInfo(Map map) {
		dao.update("AccessControl.regiLoginInfo", map);
	}

}
