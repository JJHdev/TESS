package common.base;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import commf.message.Message;
import common.user.UserInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @author ntarget
 * Create date 		: 2011-06-09
 * @version $Revision : 1.3 $ $Date: 2014/06/09 02:25:01 $
 *
 * Modify date 		: 2014-06-24
 * 2.5 -> 3.0 변경으로 AbstractServiceImpl > EgovAbstractServiceImpl 로변경
 *
 */
public class BaseService extends EgovAbstractServiceImpl  {

	// egovLogger(EgovAbstractServiceImpl) 로 사용해도됨.
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	public BaseService() {
	}

	@Autowired
	protected UserInfo userInfo;

	@Resource(name="message")
	protected Message message;

}
