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
	chkDisabled();
	
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
    
    if($("#evaluGubun").val() == "AFTER"){
    	tableRowSpanning("#finlTab", 1);
    }
    
    tableRowSpanning("#finlTab", 0);
    
}

////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

function chkDisabled(){
	$(":input:not(:hidden)").attr("Disabled", true);
}


function initScenEvent(){
	
	var evaluProcStep = $("#evaluProcStep").val();
	
	/*if(evaluProcStep == "AS90"){
		$("#prcBtnUpdt").hide();
	}*/
	
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id , targetId) {
    switch( id ) {
        case 'prcBtnUpdt':            //수정화면
        	goUpdt();
            break;
//      case 'prcBtnRset':            //초기화
        case 'prcBtnList':            //리스트
//          doReset();
            goList();
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
        url : ROOT_PATH + "/evalu/viewEvaluBudtMgmt2.do"
    });
}


function goUpdt(){
	
	$("#mode").val("updt");
	
    BIZComm.submit({
        url : ROOT_PATH + "/evalu/regiEvaluFinlBudtMgmt.do"
    });
}

//테이블 ROW 합치는 함수
function tableRowSpanning(Table, spanning_row_index) {
    var RowspanTd = false;
    var RowspanText = false;
    var RowspanCount = 0;
    var Rows = $('tr', Table);

    $.each(Rows, function () {
        var This = $('th', this)[spanning_row_index];
        var text = $(This).text();
 
        if (RowspanTd == false) {
            RowspanTd = This;
            RowspanText = text;
            RowspanCount = 1;
        }
        else if (RowspanText != text) {
            $(RowspanTd).attr('rowSpan', RowspanCount);

            RowspanTd = This;
            RowspanText = text;
            RowspanCount = 1;
        }
        else {
            $(This).remove();
            RowspanCount++;
        }
    });


    // 반복 종료 후 마지막 rowspan 적용
    $(RowspanTd).attr('rowSpan', RowspanCount);
}


