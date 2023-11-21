package business.biz;

public class CommConst {

    private CommConst() {};

    // COMBO ALL Value
    public static final String comboValueAll = "all";
    
    // ROLE_ID 상수
    public static final String  ROLE_AUTH_SYS   = "ROLE_AUTH_SYS";      // 시스템관리자
    public static final String  ROLE_USER       = "ROLE_USER";          // 일반사용자
    public static final String  ROLE_COMP       = "ROLE_COMP";          // 민간투자자
    public static final String  ROLE_SIGG       = "ROLE_SIGG";          // 시군구사용자
    public static final String  ROLE_SIDO       = "ROLE_SIDO";          // 시도사용자
    public static final String  ROLE_AUTH_E1    = "ROLE_AUTH_E1";       // 문체부
    public static final String  ROLE_AUTH_E2    = "ROLE_AUTH_E2";       // 문광연
    public static final String	ROLE_SCHL		= "ROLE_SCHL";			// 평가위원
    public static final String  ROLE_RESTRICTED = "ROLE_RESTRICTED";    // 제한된 사용자
    
    // 평가단계
    public static final String	ES		= "EVALU_STAGE";	
    public static final String	ES_PREV	= "EVALU_PREV";		// 사전평가
    public static final String	ES_PROG	= "EVALU_PROG";		// 집행평가
    public static final String	ES_AFTR	= "EVALU_AFTR";		// 사후평가
    
    // 참조파일
    public static final String	FT		= "FILE_TYPE";
    
    // 여부
    public static final String	YES		= "Y";
    public static final String	NO		= "N";
    
    // 모드
    public static final String	MODE_VIEW	= "VIEW";
    public static final String	MODE_REGI	= "REGI";
    public static final String	MODE_UPDT	= "UPDT";
    

}
