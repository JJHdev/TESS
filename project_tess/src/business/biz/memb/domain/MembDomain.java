package business.biz.memb.domain;

public class MembDomain {
	
	//약관동의
	String termsAgreeYn1;		//서비스 이용약관
	String termsAgreeYn2;		//개인정보 제공 처리방침
	String termsAgreeYn3;		//위치정보 이용 또는 제3자 제공 처리방침
	
	//TB_USER
	String userId;				//사용자 ID
	String userNm;				//사용자명
	String passwd;				//비밀번호
	String email;					//이메일
	String telNo;					//전화번호
	String cellphoneNo;			//핸드폰번호
	String deptNm;				//부서명
	String deptCd;				//부서코드
	String passwdCfrm;			
	
	//TB_USCM
	String uscmNo;				//기관업체번호
	String uscmNm;				//기관업체명
	String uscmRole;			//기관업체담당업무
	String uscmType;			//기관업체구분
	String ownerNm;			//대표자명
	String busiRegnNo;			//사업자등록번호
	String cityAuthCd;			//지자체코드
	String roadPostNo;			//도로명주소 우편번호		
	String roadAddr1;			//도로명주소1		
	String roadAddr2;			//도로명주소2
	String roadAddr3;			//도로명주소3
	String roadAddr4;			//도로명주소4
	String roadAddr5;			//도로명주소5
	String roadAddress1; 		//전체주소
	
	public String getTermsAgreeYn1() {
		return termsAgreeYn1;
	}
	public void setTermsAgreeYn1(String termsAgreeYn1) {
		this.termsAgreeYn1 = termsAgreeYn1;
	}
	public String getTermsAgreeYn2() {
		return termsAgreeYn2;
	}
	public void setTermsAgreeYn2(String termsAgreeYn2) {
		this.termsAgreeYn2 = termsAgreeYn2;
	}
	public String getTermsAgreeYn3() {
		return termsAgreeYn3;
	}
	public void setTermsAgreeYn3(String termsAgreeYn3) {
		this.termsAgreeYn3 = termsAgreeYn3;
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
	public String getOwnerNm() {
		return ownerNm;
	}
	public void setOwnerNm(String ownerNm) {
		this.ownerNm = ownerNm;
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
	public String getRoadAddr5() {
		return roadAddr5;
	}
	public void setRoadAddr5(String roadAddr5) {
		this.roadAddr5 = roadAddr5;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getPasswdCfrm() {
		return passwdCfrm;
	}
	public void setPasswdCfrm(String passwdCfrm) {
		this.passwdCfrm = passwdCfrm;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getCellphoneNo() {
		return cellphoneNo;
	}
	public void setCellphoneNo(String cellphoneNo) {
		this.cellphoneNo = cellphoneNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRoadPostNo() {
		return roadPostNo;
	}
	public void setRoadPostNo(String roadPostNo) {
		this.roadPostNo = roadPostNo;
	}
	public String getRoadAddr1() {
		return roadAddr1;
	}
	public void setRoadAddr1(String roadAddr1) {
		this.roadAddr1 = roadAddr1;
	}
	public String getRoadAddr2() {
		return roadAddr2;
	}
	public void setRoadAddr2(String roadAddr2) {
		this.roadAddr2 = roadAddr2;
	}
	public String getRoadAddr3() {
		return roadAddr3;
	}
	public void setRoadAddr3(String roadAddr3) {
		this.roadAddr3 = roadAddr3;
	}
	public String getRoadAddr4() {
		return roadAddr4;
	}
	public void setRoadAddr4(String roadAddr4) {
		this.roadAddr4 = roadAddr4;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getDeptCd() {
		return deptCd;
	}
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}
	public String getUscmRole() {
		return uscmRole;
	}
	public void setUscmRole(String uscmRole) {
		this.uscmRole = uscmRole;
	}
	public String getUscmType() {
		return uscmType;
	}
	public void setUscmType(String uscmType) {
		this.uscmType = uscmType;
	}
	public String getRoadAddress1() {
		return roadAddress1;
	}
	public void setRoadAddress1(String roadAddress1) {
		this.roadAddress1 = roadAddress1;
	}
	public String getBusiRegnNo() {
		return busiRegnNo;
	}
	public void setBusiRegnNo(String busiRegnNo) {
		this.busiRegnNo = busiRegnNo;
	}
	public String getCityAuthCd() {
		return cityAuthCd;
	}
	public void setCityAuthCd(String cityAuthCd) {
		this.cityAuthCd = cityAuthCd;
	}
	
}
