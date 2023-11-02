package business.biz.committee.domain;

import common.base.BaseModel;

/**
 * Program Name    : TodeMgmtDomain
 * Description     : 관리/운영 개발사업관리 Domain.
 * Programmer Name : LCS
 * Creation Date   : 2014-09-29
 * Used Table(주요) : TB_Evalu_BUSI     (관광사업정보)
 *                    TB_Evalu_BUSIEXPS (사업비현황)
 *                    TB_Evalu_BUSIFCLT (세부시설)
 *                    TB_Evalu_BUSIPFMS (운영성과)
 *                    TB_Evalu_BUSISTAH (사업추진경위)
 *                    TB_Evalu_BUSISTAT (운영현황)
 * 
 * @author LCS
 *
 */
public class EvaluMbrMgmtDomain extends BaseModel {
	private String evaluBusiNo;
	private String evaluUserId;
    private String userId;  
    private String useYn;  
    private String passwd;
    private String passwdCfrm;
    private String email;
    private String email1;
    private String email2;
    private String telphoneNo;
    private String telphoneNo1;
    private String telphoneNo2;
    private String telphoneNo3;
    private String cellphoneNo;
    private String cellphoneNo1;
    private String cellphoneNo2;
    private String cellphoneNo3;
    private String roadPostNo;
    private String roadAddr1;
    private String roadAddr2;
    private String roadAddr3;
    private String roadAddr4;
    private String roadAddr5;
    private String roadAddress1;
    private String roadAddr12;
    private String userNm;
    private String attach;
    private String occupa;
    private String fieldList;
    private String fieldDetail;
    private String field;
    private String occuNm;
    private String deptNm;
    
	public String getEvaluBusiNo() {
		return evaluBusiNo;
	}

	public void setEvaluBusiNo(String evaluBusiNo) {
		this.evaluBusiNo = evaluBusiNo;
	}

	public String getEvaluUserId() {
		return evaluUserId;
	}

	public void setEvaluUserId(String evaluUserId) {
		this.evaluUserId = evaluUserId;
	}

	public String getUserId() {
		return userId;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getCellphoneNo() {
		return cellphoneNo;
	}

	public void setCellphoneNo(String cellphoneNo) {
		this.cellphoneNo = cellphoneNo;
	}

	public String getCellphoneNo1() {
		return cellphoneNo1;
	}

	public void setCellphoneNo1(String cellphoneNo1) {
		this.cellphoneNo1 = cellphoneNo1;
	}

	public String getCellphoneNo2() {
		return cellphoneNo2;
	}

	public void setCellphoneNo2(String cellphoneNo2) {
		this.cellphoneNo2 = cellphoneNo2;
	}

	public String getCellphoneNo3() {
		return cellphoneNo3;
	}

	public void setCellphoneNo3(String cellphoneNo3) {
		this.cellphoneNo3 = cellphoneNo3;
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

	public String getRoadAddr5() {
		return roadAddr5;
	}

	public void setRoadAddr5(String roadAddr5) {
		this.roadAddr5 = roadAddr5;
	}

	public String getRoadAddress1() {
		return roadAddress1;
	}

	public void setRoadAddress1(String roadAddress1) {
		this.roadAddress1 = roadAddress1;
	}

	public String getRoadAddr12() {
		return roadAddr12;
	}

	public void setRoadAddr12(String roadAddr12) {
		this.roadAddr12 = roadAddr12;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getAttach() {
		return attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}

	public String getOccupa() {
		return occupa;
	}

	public void setOccupa(String occupa) {
		this.occupa = occupa;
	}

	public String getFieldList() {
		return fieldList;
	}

	public void setFieldList(String fieldList) {
		this.fieldList = fieldList;
	}

	public String getFieldDetail() {
		return fieldDetail;
	}

	public void setFieldDetail(String fieldDetail) {
		this.fieldDetail = fieldDetail;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getTelphoneNo() {
		return telphoneNo;
	}

	public void setTelphoneNo(String telphoneNo) {
		this.telphoneNo = telphoneNo;
	}

	public String getTelphoneNo1() {
		return telphoneNo1;
	}

	public void setTelphoneNo1(String telphoneNo1) {
		this.telphoneNo1 = telphoneNo1;
	}

	public String getTelphoneNo2() {
		return telphoneNo2;
	}

	public void setTelphoneNo2(String telphoneNo2) {
		this.telphoneNo2 = telphoneNo2;
	}

	public String getTelphoneNo3() {
		return telphoneNo3;
	}

	public void setTelphoneNo3(String telphoneNo3) {
		this.telphoneNo3 = telphoneNo3;
	}

	public String getOccuNm() {
		return occuNm;
	}

	public void setOccuNm(String occuNm) {
		this.occuNm = occuNm;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	
	
	


    
    //++++++++++++++++++++++++++++++
    // getter / setter
    //++++++++++++++++++++++++++++++
    
}