package business.biz.memb;

import java.util.HashMap;
import java.util.Map;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.MailManager;
import commf.dao.CommonDAOImpl;
import commf.message.Message;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.properties.ApplicationProperty;


/**
 * Program Name    : MembService
 * Description     : 회원정보 Service
 * Programmer Name : SYM
 * Creation Date   : 2014-10-01
 * Used Table(주요) :
 * 
 * @author SYM
 *
 */
@Service
public class MembService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    // 사용자유형 (USCM_TYPE)
    public static String _USER_TYPE_U1 = "U1"; //일반사용자             	 	ROLE : ROLE_USER
    public static String _USER_TYPE_U2 = "U2"; //민간투자자              		ROLE : ROLE_COMP
    public static String _USER_TYPE_U3 = "U3"; //시군구                   		ROLE : ROLE_SIGG
    public static String _USER_TYPE_U4 = "U4"; //시도						   	ROLE : ROLE_SIDO
    //사용자정보 추가 2015-12-02
    public static String _USER_TYPE_U5 = "U5"; //관광공사						ROLE : ROLE_KRTO
    public static String _USER_TYPE_U6 = "U6"; //학자/연구기관				ROLE : ROLE_SCHL
    public static String _USER_TYPE_U10 = "U10"; //해외 및 기타기관			ROLE : ROLE_FETC
    
    // 권한 상수.
    public static String _ROLE_USER 		= "ROLE_USER";
    public static String _ROLE_COMP 		= "ROLE_COMP";
    public static String _ROLE_SIGG 			= "ROLE_SIGG";
    public static String _ROLE_SIDO 			= "ROLE_SIDO";
  //사용자정보 추가 2015-12-02
    public static String _ROLE_KRTO 		= "ROLE_KRTO";
    public static String _ROLE_SCHL 			= "ROLE_SCHL";
    public static String _ROLE_FETC 			= "ROLE_FETC";
    
    /**
     * 회원정보 입력 부분 등록/수정 처리.
     * @param paramMap
     * @param listFileInfo
     */
	public void saveMembUserInfo(Map paramMap, String procType) throws Exception {

    	int cnt = 0;
    	
        try {
	            //------------------
	            // 기본 항목값 설정.
	            //------------------
	            Map initMap = new HashMap();
//	            String procType  = (String)paramMap.get("procType");
	            String reqUserNo = (String)paramMap.get("reqUserNo");
	            String cityauthCd1 = (String)paramMap.get("cityauthCd1");
	            String cityauthCd = (String)paramMap.get("cityauthCd");
	            
	            // 평가위원
	            paramMap.put("uscmType", "U11");
	            
	            // 업체상태(USE_STAT)는 '승인완료(90)'으로 설정.  <-- 차후 변경될 수 있음
	            // 일반사용자일 경우 업체상태(USE_STAT) 90
	            if(paramMap.get("uscmType").equals("U1") ){
	            	paramMap.put("useStat"   , "90");
	            }
	            // 그 외 나머지일 경우 업체상태(USE_STAT) 10
	            else{
	            	paramMap.put("useStat"   , "10");
	            }
	            // 사용여부(USE_YN)는 'Y'으로 설정.
	            paramMap.put("useYn"  , "Y");
	            // 테스트 사용여부(TEST_USE_YN)는 'N'으로 설정.
	            paramMap.put("testUseYn"  , "N");
	            //지자체코드 시군구 미선택시 시도코드로 입력되도록 설정
	            if(paramMap.get("uscmType").equals("U3") && CommUtils.empty(cityauthCd)){
	            	cityauthCd = cityauthCd1;
	            	paramMap.put("cityauthCd", cityauthCd);
	            }
	            
	            // 비밀번호가 전달되었을 때 converting 처리.
	            String passwd = (String)paramMap.get("passwd");
	            if(CommUtils.empty(passwd) == false) {
	                String encPasswd = CommUtils.getPasswordEncodingString(passwd);
	                paramMap.put("passwd", encPasswd);
	            }
	            
	            //저장
	            if(procType.equals("I")){
	                //-------------------------
	                // TB_USCM 저장
	                //-------------------------
	                String uscmNo = (String) dao.insert("Memb.regiMembUscm", paramMap);
	                if(CommUtils.empty(uscmNo) == false){
	                    cnt ++;
	                }
		            
		            //------------------
		            // TB_USER 등록
		            //------------------
		            cnt += dao.save("Memb.regiMembUser", paramMap);
		            
	            }
	            //수정
	            else {
	                //-------------------------
	                // TB_USCM 수정
	                //-------------------------
	            	cnt += dao.save("Memb.updtMembUscm", paramMap);
	            
		            //------------------
		            // TB_USER 등록
		            //------------------
	            	cnt += dao.save("Memb.updtMembUser", paramMap);
		            
	            }
	            
                // 일반사용자일 경우에만 저장
	            if( paramMap.get("uscmType").equals("U1") || procType.equals("U") ){
		            //-------------------------
		            // SYS_ROLE_USER 저장
		            //-------------------------
		            	
		            cnt += updtMembUserRoles(paramMap);
	            }

                //-------------------------
                // 오류 검사.
                //-------------------------
                if(cnt == 0 ) {
                    // msg : 저장된 내역이 없습니다.
                    throw processException("exception.user.notExistSaveResult");
                }

        }catch(Exception ex){
            ex.printStackTrace();
            throw processException(ex.getMessage() );
        }
    }
       
    
    /**
     * 사용자 ID 중복 검사
     * @param paramMap
     * @return
     */
    public int viewMembCheckDuplUserId(Map paramMap) throws Exception {
        return (Integer)dao.view("Memb.viewMembCheckDuplUserId", paramMap);
    }
    
    /**
     * ID 찾기
     * @param paramMap
     * @return
     */
    public String getMembFindId(Map paramMap) throws Exception {
        return (String)dao.view("Memb.getMembFindId", paramMap);
    }
    
    /**
     * PWD 찾기
     * @param paramMap
     * @return
     */
    public Map getMembFindPwd(Map paramMap) throws Exception {
    	
    	Map returnMap = new HashMap();
    	HashMap<String, String> mailMap = new HashMap<String, String>();
    	String rtnStat = null;
    	
    	//입력된 정보와 맞는 내용이 있는지 체크
    	String userId = (String)dao.view("Memb.getMembFindPwd", paramMap);
    	
    	if(CommUtils.empty(userId)){
    		//입력된 정보가 없을 경우
    		rtnStat = "EMPTY";
    	}else{
    		
    		String randomPwd = CommUtils.getRandomString(9);
    		//랜덤으로 9자리 비밀번호를 만들어냄
            String encPasswd = CommUtils.getPasswordEncodingString(randomPwd);
            paramMap.put("passwd", encPasswd);
            //비밀번호를 임시 비밀번호로 변경
            int uptNum = dao.update("Memb.updtMembPwd", paramMap);
            
            /*
            if(uptNum>0){
            	
            	//메일로 보내는 Map에 내용 추가
            	mailMap.put("tempPwd", randomPwd);
            	mailMap.put("receiverEmail", (String)paramMap.get("email"));
            	mailMap.put("receiverNm", (String)paramMap.get("userNm"));
            	mailMap.put("receiverNm", (String)paramMap.get("userNm"));
            	mailMap.put("subject", Message.getMessage("email.findPwd.subject"));
            	

            	mailMap.put("contents", Message.getMessage( "email.findPwd.content", new String[] { randomPwd} ));
            	
            	MailManager mm = new MailManager();
            	
            	if(mm.sendHtmlEmail(mailMap).equals("OK")){
            		//메일이 정상적으로 보내질 경우
            		rtnStat = "EXIST";
            	}else{
            		//메일이 보내지지 않을 경우
            		rtnStat = "ERROR";
            	}
            	
            }else{
            	//변경이 안됬을 경우
            	rtnStat = "ERROR";
            }
            */
            rtnStat = "EXIST";
            returnMap.put("tempPwd", randomPwd);
    	}
    	
    	returnMap.put("rtnStat", rtnStat);
    	
    	
    	return returnMap;
    }
    
    /**
     * 회원가입 및 수정시 권한정보 등록
     * @param paramMap
     * @return
     */
    public int updtMembUserRoles(Map paramMap) throws Exception {
        
        int rtnCnt = 0;

        //----------------------------------
        // 사용자(업체)기본 정보를 조회.
        //----------------------------------
        
       String uscmType = (String)paramMap.get("uscmType");
        if(CommUtils.empty(uscmType)){
                // message : 사용자권한 변경중 사용자 기본정보 조회를 하지 못했습니다.
                throw processException("exception.base.notExistUserInfoInUpdtRole");
        }
        
        //----------------------------------
        // userID가 존재하는지 확인.
        //----------------------------------
        // 해당 사용자에 등록되어 있는 기존 모든 권한을 제거한다.
        dao.save("Memb.deltMembAllUserRole", paramMap);


        String userRoleStr     = "";
        String permUserTypeStr = "";

        // 신고허가사용자구분(PERM_USER_TYPE)에 해당하는 권한 구성.
        if(_USER_TYPE_U1.equals(uscmType) == true) {
            userRoleStr =  _ROLE_USER;
        }else if(_USER_TYPE_U2.equals(uscmType) == true) {
            userRoleStr = _ROLE_COMP;
        }else if(_USER_TYPE_U3.equals(uscmType) == true) {
        	userRoleStr = _ROLE_SIDO;
        }else if(_USER_TYPE_U4.equals(uscmType) == true) {
        	userRoleStr = _ROLE_SIGG;
        }
      //사용자정보 추가 2015-12-02
        else if(_USER_TYPE_U5.equals(uscmType) == true) {
        	userRoleStr = _ROLE_KRTO;
        }else if(_USER_TYPE_U6.equals(uscmType) == true) {
        	userRoleStr = _ROLE_SCHL;
        }else if(_USER_TYPE_U10.equals(uscmType) == true) {
        	userRoleStr = _ROLE_FETC;
        }  

        // 권한 등록을 위한 기본 data 구성.
        Map roleMap = new HashMap();
        roleMap.put("userId", paramMap.get("userId"));
        roleMap.put("regiId", paramMap.get("regiId"));

        // roleId 설정.
        roleMap.put("roleId", userRoleStr);
        rtnCnt += dao.save("Memb.regiMembUserRole", roleMap);


        logger.debug("[END : updtBaseCommUserRoles]");
        logger.debug("#############################################################");
        return rtnCnt;
    }
    
    /**
     * 사용자 탈퇴처리
     * @param paramMap
     * @return
     * @throws Exception
    */ 
    public String updtWithdrawStep2(Map paramMap)throws Exception{
    	
    	String rtnStr = "";
    	int cnt = 0;
    	
    	//비밀번호 암호화처리
        paramMap.put("passwd", encryptPasswd(paramMap));
    	
        //비밀번호 확인
    	String rtnId = (String)dao.view("Memb.cnfmUserPasswd", paramMap);
    	
    	if(CommUtils.empty(rtnId)){
    		//조건에 맞는 회원정보 값이 없음
    		rtnStr =  "EMPTY";
    	}else{
    		//SYS_ROLE_USER 값 삭제
//    			cnt += dao.save("Memb.deltMembAllUserRole", paramMap);
    			
    		//TB_USER의 USE_YN컬럼 Y처리
    			cnt += dao.update("Memb.updtWithdrawUser", paramMap);
    			
            //-------------------------
            // 오류 검사.
            //-------------------------
            if(cnt == 0 ) {
            	//처리가 안됨
            	rtnStr = "ERROR";
            }
            //정상처리
            rtnStr = "EXIST";
    	}
    	return rtnStr;
    }
    
    /**
     * 사용자 기본정보 조회
     * @param paramMap
     * @return
     * @throws Exception
     */
    public Map viewMembUserInfo(Map paramMap)  throws Exception {
        return (Map)dao.view("Memb.viewMembUserInfo", paramMap);
    }
    
    /**
     * 비밀번호 변경 처리.
     * @param paramMap
     * @throws Exception
     */
    public void updtMembInfoModifyPwd(Map paramMap) throws Exception {
        
        try {
            
            String passwd = (String)paramMap.get("passwd");
            String encodingPasswd = CommUtils.getPasswordEncodingString(passwd);
            
            // 비밀번호 암호화.
            paramMap.put("passwd", encodingPasswd);
            
            int cnt = dao.save("Memb.updtMembInfoModifyPwd", paramMap);
            if(cnt == 0){
                // msg : 비밀번호 변경중 저장된 내역이 없습니다.
                throw processException("exception.base.notExistResultModifyPasswd");
            }
        }catch(Exception ex){
            ex.printStackTrace();
            throw processException(ex.getMessage() );
        }
    }
      
   /**
     * 비밀번호 암호화처리
     * @param paramMap
     * @return
     * @throws Exception
    */ 
    public String encryptPasswd(Map paramMap) throws Exception{
        // 비밀번호가 전달되었을 때 converting 처리.
        String passwd = (String)paramMap.get("passwd");
        String encPasswd = "";
        if(CommUtils.empty(passwd) == false) {
            encPasswd = CommUtils.getPasswordEncodingString(passwd);
        }
        return encPasswd;
    }
    
}