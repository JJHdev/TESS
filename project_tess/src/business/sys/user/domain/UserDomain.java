package business.sys.user.domain;

import java.util.List;

import common.base.BaseModel;

@SuppressWarnings("rawtypes")
public class UserDomain extends BaseModel {
	private String custType		= null;
	private String custCode		= null;
	private String userId		= null;
	private String userName		= null;
	private String createTime	= null;
	private String lastTime		= null;
	private String createTimeName	= null;
	private String ip			= null;
	private String localName			= null;
	private String locale		= null;

	private List listUser 		= null;
	private int userSize 		= 0;

	private String sessionId 		= null;

	private String resultMsg 		= null;
	private String resultCode 		= null;

	private String saleManCd 		= null;
	private String saleManNm 		= null;

	private String oldPwd 		= null;
	private String pwd 			= null;
	private String pwd2 		= null;
	private String dealerCd 		= null;

	private String resetErrCnt 		= null;
	private String pswdQues 		= null;
	private String hpHone 		= null;

	private String resetType 		= null;



	public String getHpHone() {
		return hpHone;
	}
	public void setHpHone(String hpHone) {
		this.hpHone = hpHone;
	}
	public String getResetErrCnt() {
		return resetErrCnt;
	}
	public void setResetErrCnt(String resetErrCnt) {
		this.resetErrCnt = resetErrCnt;
	}
	public String getPswdQues() {
		return pswdQues;
	}
	public void setPswdQues(String pswdQues) {
		this.pswdQues = pswdQues;
	}
	public String getSaleManNm() {
		return saleManNm;
	}
	public void setSaleManNm(String saleManNm) {
		this.saleManNm = saleManNm;
	}
	public String getResetType() {
		return resetType;
	}
	public void setResetType(String resetType) {
		this.resetType = resetType;
	}
	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getDealerCd() {
		return dealerCd;
	}
	public void setDealerCd(String dealerCd) {
		this.dealerCd = dealerCd;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public String getSaleManCd() {
		return saleManCd;
	}
	public void setSaleManCd(String saleManCd) {
		this.saleManCd = saleManCd;
	}
	public String getOldPwd() {
		return oldPwd;
	}
	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPwd2() {
		return pwd2;
	}
	public void setPwd2(String pwd2) {
		this.pwd2 = pwd2;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getCustType() {
		return custType;
	}
	public void setCustType(String custType) {
		this.custType = custType;
	}
	public String getCustCode() {
		return custCode;
	}
	public void setCustCode(String custCode) {
		this.custCode = custCode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getLastTime() {
		return lastTime;
	}
	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}
	public String getCreateTimeName() {
		return createTimeName;
	}
	public void setCreateTimeName(String createTimeName) {
		this.createTimeName = createTimeName;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getLocalName() {
		return localName;
	}
	public void setLocalName(String localName) {
		this.localName = localName;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public List getListUser() {
		return listUser;
	}
	public void setListUser(List listUser) {
		this.listUser = listUser;
	}
	public int getUserSize() {
		return userSize;
	}
	public void setUserSize(int userSize) {
		this.userSize = userSize;
	}


}