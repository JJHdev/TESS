/**
 * [관리/운영 개발사업 관리] 리스트 화면 스크립트 .
 *
 * @author LCS
 * @version 1.0 2014/10/13
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////


/**
 * evaluComm.js에서 자동 호출하는 함수 (페이지 초기 설정 관련 수행)
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



////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
	//버튼 처리 이벤트
	initScenEvent();
	
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
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

function initScenEvent(){
	
	var evaluProcStep = $("#evaluProcStep").val();
	
	if(evaluProcStep == "AS90"){
		$("#prcBtnUpdt").hide();
	}
	
}


////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id , targetId) {
    switch( id ) {
//      case 'prcBtnRset':            //초기화
        case 'prcBtnList':            //리스트
//          doReset();
            goList();
            break;
        case 'prcBtnUpdt':
        	goUpdt();
        	break;
        case 'prcBtnAddSave':            //리스트
//          doReset();
        	doAddSave();
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

//목록으로 이동	신규 추가 2015.01.21 
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + "/evalu/viewEvaluDpthMgmt.do"
    });
}

function goUpdt(){
	
    var isValid = true;
	
	
   // 정합성 검사.
   if(!isValid) return;
   
   $("#mode").val("updt");
    
        // submit
        BIZComm.submit({
            url    : ROOT_PATH+"/evalu/regiEvaluFinlDpthMgmt.do", 
        });
}

//다음 상세보기 화면으로 이동.
function tapChage(idx){

	$("#evaluEtcSeq").val(idx);
	
	var trgtUrl = "/evalu/viewEvaluFinlDpthMgmt.do";

    // submit
    BIZComm.submit({
        url : ROOT_PATH + trgtUrl,
    });
}

function doAddSave(){
	
	 $("#mode").val("regi");
	 
	var evaluEtcSeq =  Number($("#evaluEtcSeq").val()) + 1;
	
	$("#evaluEtcSeq").val(evaluEtcSeq);
	
	var trgtUrl = "/evalu/regiEvaluFinlDpthMgmt.do";

    // submit
    BIZComm.submit({
        url : ROOT_PATH + trgtUrl,
    });
}

