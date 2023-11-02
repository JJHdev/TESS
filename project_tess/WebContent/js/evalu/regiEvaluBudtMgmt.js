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
    var isFileUpload = true;
    var isValid = true;
    var arrEvaluInpt = "";
    var evaluFndSeq = "";
    
    //입력대상 검사
   $(".tab-content").find(":input:not(input:hidden)").each(function(){
//	 if(isEmpty(this.value)){
//		 var title = this.title;
//		 msgAlert(title + MSG_COMM_2002, this);
//		 isValid = false;
//	 }else{
		 arrEvaluInpt = (isEmpty(arrEvaluInpt)) ? this.id : arrEvaluInpt + "," + this.id;
//	 }
	 
//	 if(!isValid) return false; 
   });
    
  
 //입력 컬럼들 저장
  $("#evaluInptCulm").val(arrEvaluInpt);
  
  if($("#mode").val() == "updt"){
	   var evaluFndVal;
	   
	  $("input[name='arrEvaluFndSeq']").each(function(){
		  
		  evaluFndVal = this.value;
		  
		  evaluFndSeq = isEmpty(evaluFndSeq) ? evaluFndVal : evaluFndSeq + "," +  evaluFndVal;
	  });
	  
	  //수정할 seq 정보 저장
	  $("#evaluFndSeq").val(evaluFndSeq);
  }
  
   // 정합성 검사.
   if(!isValid) return;
    
	    // msg : "저장하겠습니까?"
	    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
	        
	        if(isConfirm){
	            // submit
	            BIZComm.submit({
	                url    : ROOT_PATH+"/evalu/saveEvaluBudtMgmt.do",
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
 
