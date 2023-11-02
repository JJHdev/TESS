package common.user;

import java.io.Serializable;


@SuppressWarnings({"serial"})
public class UserInfo implements Serializable {
	private String userId		= null;
	private String userNm		= null;
	private String passwd		= null;
	private String email		= null;
	private String telNo		= null;
	private String cellNo		= null;
	private String certNo		= null;
	private String smsAgreYn	= null;
	private String roleId		= null;	// 권한ID
	private String ipAddr		= null;
	private String useYn		= null;
	private String useStat		= null;
	private String deptCd		= null;
	private String deptNm		= null;
	private String testUseYn	= null;
	private String uscmNo		= null;
	private String uscmNm		= null;
	private String uscmRole		= null;	// 기간담당업무
	private String uscmType		= null;	// 기관, 업체, 개인 구분
	private String cityauthCd	= null;	// 지자체코드




	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getCellNo() {
		return cellNo;
	}

	public void setCellNo(String cellNo) {
		this.cellNo = cellNo;
	}

	public String getCertNo() {
		return certNo;
	}

	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}

	public String getSmsAgreYn() {
		return smsAgreYn;
	}

	public void setSmsAgreYn(String smsAgreYn) {
		this.smsAgreYn = smsAgreYn;
	}

	public String getUscmRole() {
		return uscmRole;
	}

	public void setUscmRole(String uscmRole) {
		this.uscmRole = uscmRole;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getUseStat() {
		return useStat;
	}

	public void setUseStat(String useStat) {
		this.useStat = useStat;
	}

	public String getDeptCd() {
		return deptCd;
	}

	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	public String getTestUseYn() {
		return testUseYn;
	}

	public void setTestUseYn(String testUseYn) {
		this.testUseYn = testUseYn;
	}

	public String getUscmNo() {
		return uscmNo;
	}

	public void setUscmNo(String uscmNo) {
		this.uscmNo = uscmNo;
	}

	public String getUscmNm() {
		return uscmNm;
	}

	public void setUscmNm(String uscmNm) {
		this.uscmNm = uscmNm;
	}

	public String getUscmType() {
		return uscmType;
	}

	public void setUscmType(String uscmType) {
		this.uscmType = uscmType;
	}

	public String getCityauthCd() {
		return cityauthCd;
	}

	public void setCityauthCd(String cityauthCd) {
		this.cityauthCd = cityauthCd;
	}


	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getIpAddr() {
		return ipAddr;
	}

	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}




}

