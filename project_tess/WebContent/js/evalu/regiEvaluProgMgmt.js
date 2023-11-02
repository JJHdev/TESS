/**
 * [관리/운영 개발사업 관리] 리스트 화면 스크립트 .
 *
 * @author LCS
 * @version 1.0 2014/10/13
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

var _ALLOWED_FILE_EXTS = ""; //그냥 추가

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


////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id , targetId) {
    switch( id ) {
        case 'prcBtnSave':            //임시저장
            doSave();
            break;
//      case 'prcBtnRset':            //초기화
        case 'prcBtnList':            //리스트
//          doReset();
            goView();
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

//저장처리
function doSave(){
	
    // 파일첨부 submit 할지 여부.
//	var form = jQuery('#model');
	var isFileUpload = true;
    var isValid = true;
  
   // 정합성 검사.
   if(!isValid) return;
    
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
        
        if(isConfirm){
        	
//        	form.attr({
//    	        "method" :"post"
//    	       ,"action" :"/evalu/saveEvaluCentMgmt.do" 
//    	       ,"enctype":"multipart/form-data"
//    	    });

//        	form.submit(); 
        	
            // submit
            BIZComm.submit({
            	isFile : "true",
                url    : ROOT_PATH+"/evalu/saveEvaluProgMgmt.do"
            });
        }
    });
}

//목록으로 이동	신규 추가 2015.01.21 
function goView(){
    
    BIZComm.submit({
        url : ROOT_PATH + "/evalu/viewEvaluBudtMgmt2.do"
    });
}

function tabChage(code, tab){
	
	var upperEvaluDetailCode = null;
	var evaluDetailCode = null;
	var userParam;
	
	if(tab == "tab1"){
	    userParam = {
	            mode       : EVALUComm.mode.view,
	            evaluBusiNo : $("#evaluBusiNo").val(),
	            evaluStage : $("#evaluStage").val(),
	            evaluProcStep : $("#evaluProcStep").val(),
	            evaluId : $("#evaluId").val(),
	            upperEvaluDetailCode		:  code,
	            evaluGubun : $("#evaluGubun").val()
	    };		 
		 
	}else{
	    userParam = {
	            mode       : EVALUComm.mode.view,
	            evaluBusiNo : $("#evaluBusiNo").val(),
	            evaluStage : $("#evaluStage").val(),
	            evaluProcStep : $("#evaluProcStep").val(),
	            evaluId : $("#evaluId").val(),
	            evaluDetailCode		:  code,
	            evaluGubun : $("#evaluGubun").val()
	    };		
	}
	
	nConfirm("입력 중인 내용이 사라질수 있습니다. \n탭을 이동하시겠습니까?", null, function(isConfirm){
		
		if(isConfirm){
			
		    // submit
		    BIZComm.dySubmit({
		        url : ROOT_PATH+"/evalu/viewEvaluInptBudtMgmt.do",
		        userParam      : userParam
		    });
		}
	});
}

//파일 첨부시 - onChangeFileObj()을 미사용했을 때의 메소드 2015-03-13 sym // 2016-12-26 추가
function fn_checkFileObjValid(obj){
	
	var fileObj = $(obj);
	var fullFileNm = fileObj.val();
	var fileTextObj = fileObj.parent().parent().find("input[name=upfilePath]");
	fileTextObj.val(fileObj.val());
}
