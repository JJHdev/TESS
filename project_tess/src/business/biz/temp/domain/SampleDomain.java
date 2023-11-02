package business.biz.temp.domain;

import common.base.BaseModel;

public class SampleDomain extends BaseModel {

	private String   seq	 			= null;
	private String   userId 			= null;
	private String   userNm 			= null;
	private String   loginDttm 			= null;
	private String   regiDttm 			= null;
	private String   updtDttm 			= null;
	private String   title 				= null;
	private String   content 			= null;

	private String   comboAdrr	 		= null;
	private String   chkAddr	 		= null;
	private String   rdoAddr	 		= null;

	private String   chk	 			= null;
	private String   rdo	 			= null;
	private String   cmb	 			= null;

	private String   arrChkAddr[]		= null;

	private String   fromDate 			= null;
	private String	 toDate				= null;



	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public String[] getArrChkAddr() {
		return arrChkAddr;
	}
	public void setArrChkAddr(String[] arrChkAddr) {
		this.arrChkAddr = arrChkAddr;
	}

	public String getUpdtDttm() {
		return updtDttm;
	}
	public void setUpdtDttm(String updtDttm) {
		this.updtDttm = updtDttm;
	}
	public String getRegiDttm() {
		return regiDttm;
	}
	public void setRegiDttm(String regiDttm) {
		this.regiDttm = regiDttm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getChk() {
		return chk;
	}
	public void setChk(String chk) {
		this.chk = chk;
	}
	public String getRdo() {
		return rdo;
	}
	public void setRdo(String rdo) {
		this.rdo = rdo;
	}
	public String getCmb() {
		return cmb;
	}
	public void setCmb(String cmb) {
		this.cmb = cmb;
	}

	public String getComboAdrr() {
		return comboAdrr;
	}
	public void setComboAdrr(String comboAdrr) {
		this.comboAdrr = comboAdrr;
	}
	public String getChkAddr() {
		return chkAddr;
	}
	public void setChkAddr(String chkAddr) {
		this.chkAddr = chkAddr;
	}
	public String getRdoAddr() {
		return rdoAddr;
	}
	public void setRdoAddr(String rdoAddr) {
		this.rdoAddr = rdoAddr;
	}

	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
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
	public String getLoginDttm() {
		return loginDttm;
	}
	public void setLoginDttm(String loginDttm) {
		this.loginDttm = loginDttm;
	}



}