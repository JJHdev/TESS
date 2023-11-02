package business.sys.code.domain;

import common.base.BaseModel;

public class CodeDomain extends BaseModel {

	private String parentCode;
	private String parentCodeNm;
	private String code;
	private String codeNm;
	private String addCol01;
	private String addCol02;
	private String addCol03;
	private String codeOdr;
	private String useFlag;

	private String schParentCode;
	

    public String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public String getParentCodeNm() {
        return parentCodeNm;
    }

    public void setParentCodeNm(String parentCodeNm) {
        this.parentCodeNm = parentCodeNm;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCodeNm() {
        return codeNm;
    }

    public void setCodeNm(String codeNm) {
        this.codeNm = codeNm;
    }

    public String getAddCol01() {
        return addCol01;
    }

    public void setAddCol01(String addCol01) {
        this.addCol01 = addCol01;
    }

    public String getAddCol02() {
        return addCol02;
    }

    public void setAddCol02(String addCol02) {
        this.addCol02 = addCol02;
    }

    public String getAddCol03() {
        return addCol03;
    }

    public void setAddCol03(String addCol03) {
        this.addCol03 = addCol03;
    }

    public String getCodeOdr() {
        return codeOdr;
    }

    public void setCodeOdr(String codeOdr) {
        this.codeOdr = codeOdr;
    }

    public String getUseFlag() {
        return useFlag;
    }

    public void setUseFlag(String useFlag) {
        this.useFlag = useFlag;
    }

    public String getSchParentCode() {
        return schParentCode;
    }

    public void setSchParentCode(String schParentCode) {
        this.schParentCode = schParentCode;
    }







}