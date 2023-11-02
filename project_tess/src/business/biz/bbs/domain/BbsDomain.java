package business.biz.bbs.domain;

public class BbsDomain {
	String page; //페이징 수
	String search_name; //검색조건
	String search_word; //검색어
	String docu_kind; //게시판 조건
	String bbs_type; //게시판 구분
	
	String docuKind; //등록 수정페이지 게시판조건
	String bbsSubject;
	String userNm;
	String bbsDesc;
	String openYn;
	String strDate;
	
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getSearch_name() {
		return search_name;
	}
	public void setSearch_name(String search_name) {
		this.search_name = search_name;
	}
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public String getDocu_kind() {
		return docu_kind;
	}
	public void setDocu_kind(String docu_kind) {
		this.docu_kind = docu_kind;
	}
	public String getBbs_type() {
		return bbs_type;
	}
	public void setBbs_type(String bbs_type) {
		this.bbs_type = bbs_type;
	}
	public String getDocuKind() {
		return docuKind;
	}
	public void setDocuKind(String docuKind) {
		this.docuKind = docuKind;
	}
	public String getBbsSubject() {
		return bbsSubject;
	}
	public void setBbsSubject(String bbsSubject) {
		this.bbsSubject = bbsSubject;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getBbsDesc() {
		return bbsDesc;
	}
	public void setBbsDesc(String bbsDesc) {
		this.bbsDesc = bbsDesc;
	}
	public String getOpenYn() {
		return openYn;
	}
	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}
	public String getStrDate() {
		return strDate;
	}
	public void setStrDate(String strDate) {
		this.strDate = strDate;
	}
	
	
	
	
}
