package business.biz.evalu;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.CommConst;
import commf.dao.CommonDAOImpl;
import commf.message.Message;
import common.base.BaseService;
import common.util.CommUtils;


@Service
@SuppressWarnings({"rawtypes","unchecked"})
public class EvaluCommService extends BaseService {
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    // EVALU에서 사용하는 공통 사용 상수
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //----------------------------
    // 처리 구분값 상수.
    //----------------------------
    public static final String PT_INSERT = "I";                   // process type insert
    public static final String PT_UPDATE = "U";                   // process type update
    public static final String PT_DELETE = "D";                   // process type delete
    
    //----------------------------
    // MODE 상수
    //----------------------------
    public static final String MODE_REGI = "regi";                // mode : reig
    public static final String MODE_UPDT = "updt";                // mode : updt
    public static final String MODE_DELT = "delt";                // mode : delt
    public static final String MODE_VIEW = "view";                // mode : view
    
    //----------------------------
    // SUBMODE 상수
    //----------------------------
    public static final String SUBMODE_REGI_YEAR = "regiYear";    // 사업비현황 년간 정보 등록
    public static final String SUBMODE_UPDT_YEAR = "updtYear";    // 사업비현황 년간 정보 수정
    public static final String SUBMODE_DELT_YEAR = "deltYear";    // 사업비현황 년간 정보 삭제
    
    //----------------------------
    // 화면 탭 구분
    //----------------------------
    public static final String TAB_SUMM = "summ";                 // 사업개요          
    
    //----------------------------
    // 메뉴구분 상수
    //----------------------------
    
    public static final String MENU_SRCH = "menuSrch";      // 조회 메뉴(관광개발사업조회-조회기능만)
    public static final String MENU_MGMT = "menuMgmt";      // 관리 메뉴(관리/운영 개발사업관리)
    
    //----------------------------
    // 기타
    //----------------------------
    public static final String SESSKEY_EVALU_RTNFG = "_sesskeyEVALURtnfg_";     // SESSION KEY
    public static final String SESSVAL_EVALU_SUCC  = "success";
    
    //----------------------------
    // 첨부파일관련
    //----------------------------
    
    public static final String FL_DOCU_TYPE_PLYY = "PLYY";    // 년도별 사업계획서
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    // 
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    // NUMBER 타입으로 변환 대상인 COLUMNS의 문자열.
    private String numConvColsStr;
    
    @Autowired
    private CommonDAOImpl dao;
    
    // 생성자.
    public EvaluCommService(){
        
        super();
        
        // NUMBER 타입으로 변환 대상인 COLUMNS의 문자열 구성
        StringBuffer numConvCols = new StringBuffer("");
        
        numConvCols.append("|"+"busiAmt"     );  //물량
        numConvCols.append("|"+"fileSize"    );  //파일사이즈
        numConvCols.append("|"+"seq"         );  //순번
        numConvCols.append("|"+"EVALUFileNo"  );  //관광개발사업 첨부파일번호
        numConvCols.append("|"+"totSiteArea" );  //전체부지면적
        numConvCols.append("|"+"totBusiExps");  //총사업비
        
        this.numConvColsStr = numConvCols.toString();
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    // 저장정보 list 구성 부분
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * Dynammic Grid 형태로 넘어온 array parameter 객체를 처리.
     * 
     * @param paramMap
     * @param dyGridFg
     */
    public void setDyGridSaveList(Map paramMap, String dyGridFg) {
        
        List dySaveList = new ArrayList();
        
        //-----------------------
        // 초기 정보 설정.
        //-----------------------
        
        Map initMap = new HashMap();
        // 관광사업정보 pk 설정
        initMap.put("EVALUBusiNo", paramMap.get("EVALUBusiNo"));
        
        // 등록/수정 사용자 id 설정
        initMap.put("regiId", paramMap.get("gsUserId"));
        initMap.put("updtId", paramMap.get("gsUserId"));
        
        //-----------------------
        // 삭제대상 추가
        //-----------------------
        dySaveList.addAll( getDeleteItemList(paramMap, initMap, dyGridFg) );
        
        // list 객체를 dyGridFg+"List" 이름으로 map에 담아줌.
        if(dySaveList.isEmpty() == false) {
            paramMap.put(dyGridFg+"List", dySaveList);
        }
        
    }
    
    /**
     * 설정된 column 값을 변경
     *    => MASTER정보를 수정할 때는 문제가 있을 수 있음.
     * @param paramMap
     */
    public Map setConvertMapData(Map paramMap) {
        
        Map map = null;
        
        // 이후 paramMap의 내용 유지를 위해 복제해서 사용하기로 함.
        if(paramMap != null) map = (HashMap)((HashMap)paramMap).clone();
        
        // map 객체 처리.
        Iterator it = map.entrySet().iterator();
        while (it.hasNext()) {
            
            Map.Entry pairs = (Map.Entry)it.next();
            String key      = (String)pairs.getKey();
            Object valueObj = pairs.getValue();
            
            if(valueObj instanceof String){
                
                String strVal = (String)valueObj;
                
                if(strVal != null) {
                    //---------------------------------------------------
                    //[*To Number 변환] DB 항목이 NUMBER로 설정된 데이터를 
                    //---------------------------------------------------
                    if(this.numConvColsStr.indexOf(key) >= 0  && CommUtils.empty(strVal) == false){
                        strVal = strVal.replaceAll(",", "");
                        map.put(key, new BigDecimal(strVal));
                    }
                    
                    //---------------------------------------------------
                    //[* date 형식의 항목값에서 '-'값을 제거]
                    //---------------------------------------------------
                    String dateTailStr = "Date";
                    if(key.indexOf(dateTailStr) == ( key.length() - dateTailStr.length())) {
                        map.put(key, strVal.replaceAll("-","") );
                    }
                }
                
            }
            
        }   // end of while
        
        return map;
        
    }
    
    //+++++++++++++++++++++++++++++++++++++++++++++++++++
    // check valid info-
    //+++++++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * 사업개발~번호 (관광개발신청번호/관광개발교부번호/관광개발사업번호) 검사.
     * @param EVALUNo
     * @param buzType
     * @return
     */
    public String checkValidEvaluNo(String EVALUNo){
        
        String msg = "";
        
        // 관광개발~번호가 없을 때
        if(CommUtils.empty(EVALUNo)) {
            //msg = "관광개발사업번호가 비어있습니다.";
            msg = Message.getMessage("exception.EVALU.busiNoEmpty");
        }
        // 형식에 맞는지 검사.
        else if(EVALUNo.length() != 12) {
            //msg = "관광개발사업번호가 형식에 맞지 않습니다.";
            msg = Message.getMessage("exception.EVALU.busiNoWrong");
        }
        
        return msg ;
    }
    
    /**
     * 특정 입력필수 항목값이 입력되었는지 확인.
     * @param saveMap
     * @param reqKey
     * @return 
     */
    public boolean checkRequiredItem(Map saveMap, String reqKey) {
        boolean isValid = false;
        
        if(saveMap != null && !saveMap.isEmpty() ) {
            Object val = saveMap.get(reqKey);
            if(val != null
                    && ( val instanceof String && !CommUtils.empty((String)val) )
              ) 
                isValid = true;
        }
        
        return isValid;
    }
    
    /**
     * 삭제 전 상태 겁사.
     * @param mastMap
     * @param paramMap
     * @return
     */
    public String checkPreDelt(Map mastMap, Map paramMap) {
        String msg = "";
        
        //[CHECK ERROR] 관광개발사업번호가 비어 있으면 오류
        msg = checkValidEvaluNo((String)paramMap.get("evaluBusiNo"));
        
        if(CommUtils.empty(msg)) {
            
            // 대상 관광사업정보가 없을 때 
            if(mastMap == null || mastMap.isEmpty()) {
                //msg = "삭제를 위한 개발사업정보를 조회하지 못했습니다.";
                msg = Message.getMessage("exception.EVALU.deltNotSrchEVALUInfo");
            }
            else{
                
                String curApprStat = (String)mastMap.get("apprStat");
                String roleId      = (String)mastMap.get("roleId");
                String uscmNo      = (String)mastMap.get("uscmNo");
                String gsRoleId    = (String)paramMap.get("gsRoleId");
                String gsUscmNo    = (String)paramMap.get("gsUscmNo");
                
                if(CommUtils.empty(curApprStat)) {
                    //msg = "삭제를 위한 현재 상태를 알 수 없습니다.";
                    msg = Message.getMessage("exception.EVALU.deltUnknowCurStat");
                }
                else {
                    // 관리자일 때
                    if(CommConst.ROLE_AUTH_SYS.equals(gsRoleId) ){
                    	
                    }
                    // 그외 사용자 일 때
                    else {
                        //msg = "삭제할 수 없는 사용자입니다.";
                        msg = Message.getMessage("exception.EVALU.deltNotUser");
                    }
                }
            }
        }
        
        return msg ;
    }
        
    /**
     * [관광개발사업] 운영현황 -  - 저장 리스트 객체 구성.
     * @param paramMap
     * @param initMap
     * @return
     */
    private List getSaveItemListStat(Map paramMap, Map initMap){
        
        List dySaveList = new ArrayList();
        
        String[] arrBusiStatSeq          = (String[])paramMap.get("arrBusiStatSeq");
        String[] arrBusiStatOperStatYear = (String[])paramMap.get("arrBusiStatOperStatYear");
        String[] arrBusiStatOperMgmtCnt  = (String[])paramMap.get("arrBusiStatOperMgmtCnt");
        String[] arrBusiStatOperFcltCnt  = (String[])paramMap.get("arrBusiStatOperFcltCnt");
        String[] arrBusiStatOperTourCnt  = (String[])paramMap.get("arrBusiStatOperTourCnt");
        String[] arrBusiStatOperRechCnt  = (String[])paramMap.get("arrBusiStatOperRechCnt");
        String[] arrBusiStatOperEtcCnt   = (String[])paramMap.get("arrBusiStatOperEtcCnt");
        
        for(int i=0;arrBusiStatSeq!=null && i<arrBusiStatSeq.length;i++){

            // seq 및 처리구분값 설정
            Map saveMap = getDyItemInitMap(arrBusiStatSeq[i], initMap);
            
            saveMap.put("operStatYear", arrBusiStatOperStatYear[i]);
            saveMap.put("operMgmtCnt" , arrBusiStatOperMgmtCnt [i]);
            saveMap.put("operFcltCnt" , arrBusiStatOperFcltCnt [i]);
            saveMap.put("operTourCnt" , arrBusiStatOperTourCnt [i]);
            saveMap.put("operRechCnt" , arrBusiStatOperRechCnt [i]);
            saveMap.put("operEtcCnt"  , arrBusiStatOperEtcCnt  [i]);

            saveMap = setConvertMapData(saveMap);
            
            // 입력 필수 항목값이 없으면 저장 대상으로 추가하지 않음.
            if(checkRequiredItem(saveMap, "operStatYear"))
                dySaveList.add(saveMap);
        }
        
        return dySaveList;
    }
    
    //+++++++++++++++++++++++++++++++++++++++++++++++++++
    // private common method
    //+++++++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * 삭제 대상을 dynamic 저장 list에서 추가.
     * @param paramMap
     * @param initMap
     * @param buldList
     * @param dyGridFg
     */
    private List getDeleteItemList(Map paramMap, Map initMap, String dyGridFg){
        
        String delStringKey = "";
        List dySaveList = new ArrayList();
        
        String deltDatas = (String)paramMap.get(delStringKey);
        if(!CommUtils.empty(deltDatas)) {
            
            String[] deltDataArray = deltDatas.split(",");
            for(int i=0;deltDataArray!=null && i<deltDataArray.length;i++) {
                
                if(CommUtils.empty(deltDataArray[i]) == false){
                    
                    // seq 및 처리구분값 설정
                    Map saveMap = getDyItemInitMap(deltDataArray[i], initMap,true);
                    
                    setConvertMapData(saveMap);
                    dySaveList.add(saveMap);
                }
            }
        }
        
        return dySaveList;
    }
    
    /**
     * pk 항목 (seq) 및 처리형태(_pt:I/U) 설정
     * @param pk
     * @return
     */
    private Map getDyItemInitMap(String pk, Map initMap){
        return getDyItemInitMap(pk, initMap, false);
    }
    private Map getDyItemInitMap(String pk, Map initMap, boolean isDelt){
        Map saveMap = new HashMap();
        
        // 등록/수정 여부
        if(CommUtils.empty(pk)){
            // insert 설정
            saveMap.put("_pt", PT_INSERT);
        }else{
            // update 설정
            if(isDelt == true)
                saveMap.put("_pt", PT_DELETE);
            else
                saveMap.put("_pt", PT_UPDATE);
            
            saveMap.put("seq", pk);
        }
        
        // 초기화 data 설정.
        if(initMap != null && !initMap.isEmpty()) {
            saveMap.putAll(initMap);
        }
        
        return saveMap;
    }
    
}