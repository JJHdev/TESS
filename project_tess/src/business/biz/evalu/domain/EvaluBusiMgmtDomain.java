package business.biz.evalu.domain;

import common.base.BaseModel;

/**
 * Program Name		: EvaluMgmtBusiDomain.java
 * Description		: 평가사업관리 도메인
 * Programmer Name	: LHB
 * Creation Date	: 2023-11-08
 * Used Table(주요)	: TB_EVALU_DESTI_BUSI_INFO (평가사업관리)
 * 					  TB_EVALU_DESTI_BUSI_HIST (평가사업이력)
 *                   
 * 
 * @author LCS
 *
 */
public class EvaluBusiMgmtDomain extends BaseModel {
    
	// TB_EVALU_DESTI_BUSI_INFO
	private long evaluBusiSn;		// 평가대상 사업 일련번호
	private String evaluBusiNo;		// 평가대상사업번호 (사용안함)
    private String evaluBusiNm;		// 평가대상사업명
    private String busiMbyAddr1;	// 시행주체 시도 주소
    private String busiMbyAddr2;	// 시행주체 시군구 주소
    private String busiAddr;		// 대상지역 주소 (1+2+3)
    private String busiAddr1;		// 대상지역 시도 주소
    private String busiAddr2;		// 대상지역 시군구 주소
    private String busiAddr3;		// 대상지역 상세 주소
    private String gpsX;			// GPS_X
    private String gpsY;			// GPS_Y
    private String busiTypeLevel1;	// 사업 구분 1단계
    private String busiTypeLevel1Nm;
    private String busiTypeLevel2;	// 사업 구분 2단계
    private String busiTypeLevel2Nm;
    private String busiCate;		// 사업코드 (4자리)
    private String busiCateNm;
    private String busiNote;		// 사업내용(목적)
    private String regiId;			// 등록자
    private String regiDate;		// 등록일자
    private String updtId;			// 수정자
    private String updtDate;		// 수정일자
    
    // TB_EVALU_DESTI_BUSI_HIST
    private long evaluHistSn;		// 평가대상사업 이력 일련번호
    private String evaluHistNo;		// 평가대상 이력 사업코드
    private String evaluYear;		// 평가대상사업 이력 연도
    private String evaluStage;		// 평가대상사업 이력 단계
    private String busiSttDate;		// 사업시작일자
    private String busiEndDate;		// 사업종료일자
    private String mainFclt;		// 주요시설
    private String totBusiExps1;	// 사업비(국비)
    private String totBusiExps2;	// 사업비(지방비)
    private String totBusiExps3;	// 사업비(민자)
    
    
    // GETTER SETTER
	public long getEvaluBusiSn() {
		return evaluBusiSn;
	}
	public void setEvaluBusiSn(long evaluBusiSn) {
		this.evaluBusiSn = evaluBusiSn;
	}
	public String getEvaluBusiNo() {
		return evaluBusiNo;
	}
	public void setEvaluBusiNo(String evaluBusiNo) {
		this.evaluBusiNo = evaluBusiNo;
	}
	public String getEvaluHistNo() {
		return evaluHistNo;
	}
	public void setEvaluHistNo(String evaluHistNo) {
		this.evaluHistNo = evaluHistNo;
	}
	public String getEvaluBusiNm() {
		return evaluBusiNm;
	}
	public void setEvaluBusiNm(String evaluBusiNm) {
		this.evaluBusiNm = evaluBusiNm;
	}
	public String getBusiMbyAddr1() {
		return busiMbyAddr1;
	}
	public void setBusiMbyAddr1(String busiMbyAddr1) {
		this.busiMbyAddr1 = busiMbyAddr1;
	}
	public String getBusiMbyAddr2() {
		return busiMbyAddr2;
	}
	public void setBusiMbyAddr2(String busiMbyAddr2) {
		this.busiMbyAddr2 = busiMbyAddr2;
	}
	public String getBusiAddr() {
		return busiAddr;
	}
	public void setBusiAddr(String busiAddr) {
		this.busiAddr = busiAddr;
	}
	public String getBusiAddr1() {
		return busiAddr1;
	}
	public void setBusiAddr1(String busiAddr1) {
		this.busiAddr1 = busiAddr1;
	}
	public String getBusiAddr2() {
		return busiAddr2;
	}
	public void setBusiAddr2(String busiAddr2) {
		this.busiAddr2 = busiAddr2;
	}
	public String getBusiAddr3() {
		return busiAddr3;
	}
	public void setBusiAddr3(String busiAddr3) {
		this.busiAddr3 = busiAddr3;
	}
	public String getGpsX() {
		return gpsX;
	}
	public void setGpsX(String gpsX) {
		this.gpsX = gpsX;
	}
	public String getGpsY() {
		return gpsY;
	}
	public void setGpsY(String gpsY) {
		this.gpsY = gpsY;
	}
	public String getBusiTypeLevel1() {
		return busiTypeLevel1;
	}
	public void setBusiTypeLevel1(String busiTypeLevel1) {
		this.busiTypeLevel1 = busiTypeLevel1;
	}
	public String getBusiTypeLevel1Nm() {
		return busiTypeLevel1Nm;
	}
	public void setBusiTypeLevel1Nm(String busiTypeLevel1Nm) {
		this.busiTypeLevel1Nm = busiTypeLevel1Nm;
	}
	public String getBusiTypeLevel2() {
		return busiTypeLevel2;
	}
	public void setBusiTypeLevel2(String busiTypeLevel2) {
		this.busiTypeLevel2 = busiTypeLevel2;
	}
	public String getBusiTypeLevel2Nm() {
		return busiTypeLevel2Nm;
	}
	public void setBusiTypeLevel2Nm(String busiTypeLevel2Nm) {
		this.busiTypeLevel2Nm = busiTypeLevel2Nm;
	}
	public String getBusiCate() {
		return busiCate;
	}
	public void setBusiCate(String busiCate) {
		this.busiCate = busiCate;
	}
	public String getBusiCateNm() {
		return busiCateNm;
	}
	public void setBusiCateNm(String busiCateNm) {
		this.busiCateNm = busiCateNm;
	}
	public String getBusiNote() {
		return busiNote;
	}
	public void setBusiNote(String busiNote) {
		this.busiNote = busiNote;
	}
	public String getRegiId() {
		return regiId;
	}
	public void setRegiId(String regiId) {
		this.regiId = regiId;
	}
	public String getRegiDate() {
		return regiDate;
	}
	public void setRegiDate(String regiDate) {
		this.regiDate = regiDate;
	}
	public String getUpdtId() {
		return updtId;
	}
	public void setUpdtId(String updtId) {
		this.updtId = updtId;
	}
	public String getUpdtDate() {
		return updtDate;
	}
	public void setUpdtDate(String updtDate) {
		this.updtDate = updtDate;
	}
	public long getEvaluHistSn() {
		return evaluHistSn;
	}
	public void setEvaluHistSn(long evaluHistSn) {
		this.evaluHistSn = evaluHistSn;
	}
	public String getEvaluYear() {
		return evaluYear;
	}
	public void setEvaluYear(String evaluYear) {
		this.evaluYear = evaluYear;
	}
	public String getEvaluStage() {
		return evaluStage;
	}
	public void setEvaluStage(String evaluStage) {
		this.evaluStage = evaluStage;
	}
	public String getBusiSttDate() {
		return busiSttDate;
	}
	public void setBusiSttDate(String busiSttDate) {
		this.busiSttDate = busiSttDate;
	}
	public String getBusiEndDate() {
		return busiEndDate;
	}
	public void setBusiEndDate(String busiEndDate) {
		this.busiEndDate = busiEndDate;
	}
	public String getMainFclt() {
		return mainFclt;
	}
	public void setMainFclt(String mainFclt) {
		this.mainFclt = mainFclt;
	}
	public String getTotBusiExps1() {
		return totBusiExps1;
	}
	public void setTotBusiExps1(String totBusiExps1) {
		this.totBusiExps1 = totBusiExps1;
	}
	public String getTotBusiExps2() {
		return totBusiExps2;
	}
	public void setTotBusiExps2(String totBusiExps2) {
		this.totBusiExps2 = totBusiExps2;
	}
	public String getTotBusiExps3() {
		return totBusiExps3;
	}
	public void setTotBusiExps3(String totBusiExps3) {
		this.totBusiExps3 = totBusiExps3;
	}
	
}