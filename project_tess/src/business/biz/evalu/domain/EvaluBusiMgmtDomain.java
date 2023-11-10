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
    
	private long evaluBusiSn;		// 평가대상 사업 일련번호
    private String evaluBusiNo;		// 평가대상사업번호
    private String evaluBusiNm;		// 평가대상사업명
    private String uscmNo;			// 기관업체(개인)번호
    private String reqUserNm;		// 신청담당자 이름
    private String reqDeptNm;		// 신청담당자 부서명
    private String reqTelNo;		// 신청담당자 전화번호
    private String reqEmail;  // 신청담당자 이메일
    private String reqCityauthCd;  // 신청담당자 지자체코드
    private String reqDate;  // 신청일자
    private String busiPostNo;  // 사업위치 우편번호
    private String busiAddr;  // 사업위치 주소1
    private String busiAddr1;  // 사업위치 주소1
    private String busiAddr2;  // 사업위치 주소2
    private String busiAddr3;  // 사업위치 주소3
    private String busiAddr4;  // 사업위치 주소4
    private String busiAddr5;  // 사업위치 주소5
    private String gpsX;  // GPS_X
    private String gpsY;  // GPS_Y
    private String busiSttDate;  // 사업시작일
    private String busiEndDate;  // 사업종료일
    private String busiDevEnty;  // 사업개발주체
    private String busiPlanDate;  // 계획수립일자
    private String totSiteArea;  // 전체부지면적
    private String busiType;  // 사업의구분
    private String busiCate;  // 사업의유형
    private String busiNote; // 사업내용(목적)
    private String mainFclt;	// 주요시설
    private String regiId;  // 등록자
    private String regiDate;  // 등록일자
    private String updtId;  // 수정자
    private String updtDate;  // 수정일자
    private String totBusiExps;	//총사업비
    private String totSiteUnit;		//부지면적 단위
    
    private long evaluHistSn;	// 평가대상사업 이력 일련번호
    private String evaluYear;	// 평가대상사업 이력 연도
    private String evaluStage;	// 평가대상사업 이력 단계
    
    //++++++++++++++++++++++++++++++
    // db항목에 없음
    //++++++++++++++++++++++++++++++
    private String busiAddress1 ;  // 주소 1 (주소1+2+3+4)
    
    
    //++++++++++++++++++++++++++++++
    // getter / setter
    //++++++++++++++++++++++++++++++
    public String getEvaluBusiNo() {
        return evaluBusiNo;
    }
    public long getEvaluBusiSn() {
		return evaluBusiSn;
	}
	public void setEvaluBusiSn(long evaluBusiSn) {
		this.evaluBusiSn = evaluBusiSn;
	}
	public long getEvaluHistSn() {
		return evaluHistSn;
	}
	public void setEvaluHistSn(long evaluHistSn) {
		this.evaluHistSn = evaluHistSn;
	}
	public void setEvaluBusiNo(String evaluBusiNo) {
        this.evaluBusiNo = evaluBusiNo;
    }
    public String getEvaluBusiNm() {
        return evaluBusiNm;
    }
    public void setEvaluBusiNm(String evaluBusiNm) {
        this.evaluBusiNm = evaluBusiNm;
    }
    public String getUscmNo() {
        return uscmNo;
    }
    public void setUscmNo(String uscmNo) {
        this.uscmNo = uscmNo;
    }
    public String getReqUserNm() {
        return reqUserNm;
    }
    public void setReqUserNm(String reqUserNm) {
        this.reqUserNm = reqUserNm;
    }
    public String getReqDeptNm() {
        return reqDeptNm;
    }
    public void setReqDeptNm(String reqDeptNm) {
        this.reqDeptNm = reqDeptNm;
    }
    public String getReqTelNo() {
        return reqTelNo;
    }
    public void setReqTelNo(String reqTelNo) {
        this.reqTelNo = reqTelNo;
    }
    public String getReqEmail() {
        return reqEmail;
    }
    public void setReqEmail(String reqEmail) {
        this.reqEmail = reqEmail;
    }
    public String getReqCityauthCd() {
        return reqCityauthCd;
    }
    public void setReqCityauthCd(String reqCityauthCd) {
        this.reqCityauthCd = reqCityauthCd;
    }
    public String getReqDate() {
        return reqDate;
    }
    public void setReqDate(String reqDate) {
        this.reqDate = reqDate;
    }
    public String getBusiPostNo() {
        return busiPostNo;
    }
    public void setBusiPostNo(String busiPostNo) {
        this.busiPostNo = busiPostNo;
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
    public String getBusiAddr4() {
        return busiAddr4;
    }
    public void setBusiAddr4(String busiAddr4) {
        this.busiAddr4 = busiAddr4;
    }
    public String getBusiAddr5() {
        return busiAddr5;
    }
    public void setBusiAddr5(String busiAddr5) {
        this.busiAddr5 = busiAddr5;
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
    public String getBusiDevEnty() {
        return busiDevEnty;
    }
    public void setBusiDevEnty(String busiDevEnty) {
        this.busiDevEnty = busiDevEnty;
    }
    public String getBusiPlanDate() {
        return busiPlanDate;
    }
    public void setBusiPlanDate(String busiPlanDate) {
        this.busiPlanDate = busiPlanDate;
    }
    public String getTotSiteArea() {
        return totSiteArea;
    }
    public void setTotSiteArea(String totSiteArea) {
        this.totSiteArea = totSiteArea;
    }
    public String getBusiType() {
        return busiType;
    }
    public void setBusiType(String busiType) {
        this.busiType = busiType;
    }
    public String getBusiCate() {
        return busiCate;
    }
    public void setBusiCate(String busiCate) {
        this.busiCate = busiCate;
    }
    public String getBusiNote() {
        return busiNote;
    }
    public void setBusiNote(String busiNote) {
        this.busiNote = busiNote;
    }
    public String getMainFclt() {
    	return mainFclt;
    }
    public void setMainFclt(String mainFclt) {
    	this.mainFclt = mainFclt;
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
    public String getBusiAddress1() {
        return busiAddress1;
    }
    public void setBusiAddress1(String busiAddress1) {
        this.busiAddress1 = busiAddress1;
    }
	public String getTotSiteUnit() {
		return totSiteUnit;
	}
	public void setTotSiteUnit(String totSiteUnit) {
		this.totSiteUnit = totSiteUnit;
	}
	public String getTotBusiExps() {
		return totBusiExps;
	}
	public void setTotBusiExps(String totBusiExps) {
		this.totBusiExps = totBusiExps;
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
    
}