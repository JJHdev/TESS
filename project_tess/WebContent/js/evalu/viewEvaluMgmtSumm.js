/**
 *  사업등록 상세화면
 *
 * @author SYM
 * @version 1.0 2015-02-12
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

/**
 * todeComm.js에서 자동 호출하는 함수 (페이지 초기 설정 관련 수행)
 * 
 */
function loadInitPage(){

    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
}


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL        = ROOT_PATH+"/evalu/listEvaluMgmt.do" ;
var UPDT_URL 	   = ROOT_PATH+"/evalu/openUpdtEvaluMgmtSumm.do";

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
    
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    switch( id ) {
        case 'prcBtnList':            // 목록이동 버튼
            goList();
            break;
        case 'prcBtnUpdt':            // 수정버튼
            goUpdt();
            break;
    }
}

//기능 버튼 클릭이벤트 연결
function bindFuncBtnEvent(){
    // ID가 'prcBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=prcBtn]").click(function(){
        onClickButton($(this).attr("id"))
    });
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

// 목록으로 이동
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}

// 수정 화면으로 이동.
function goUpdt() {
    
    BIZComm.submit({
        url : ROOT_PATH + UPDT_URL,
    });
}
