package business.sys.menu.domain;

import common.base.BaseModel;

public class MenuDomain extends BaseModel {
    
	private String menuId;
	private String menuNm;
	private String menuLvl;
	private String menuOdr;
	private String parentMenuId;
	private String refProgId;
	private String tagtUrl;
	private String popupYn;
	private String useYn;
	private String scrnType;
	private String regiId;
	private String regiDate;
	private String updtId;
	private String updtDate;
	
	
    public String getMenuId() {
        return menuId;
    }
    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }
    public String getMenuNm() {
        return menuNm;
    }
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }
    public String getMenuLvl() {
        return menuLvl;
    }
    public void setMenuLvl(String menuLvl) {
        this.menuLvl = menuLvl;
    }
    public String getMenuOdr() {
        return menuOdr;
    }
    public void setMenuOdr(String menuOdr) {
        this.menuOdr = menuOdr;
    }
    public String getParentMenuId() {
        return parentMenuId;
    }
    public void setParentMenuId(String parentMenuId) {
        this.parentMenuId = parentMenuId;
    }
    public String getRefProgId() {
        return refProgId;
    }
    public void setRefProgId(String refProgId) {
        this.refProgId = refProgId;
    }
    public String getTagtUrl() {
        return tagtUrl;
    }
    public void setTagtUrl(String tagtUrl) {
        this.tagtUrl = tagtUrl;
    }
    public String getPopupYn() {
        return popupYn;
    }
    public void setPopupYn(String popupYn) {
        this.popupYn = popupYn;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getScrnType() {
        return scrnType;
    }
    public void setScrnType(String scrnType) {
        this.scrnType = scrnType;
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


}