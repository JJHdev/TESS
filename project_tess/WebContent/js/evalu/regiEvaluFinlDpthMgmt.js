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

//저장처리
function doSave(){
	
    // 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    var isValid = true;
    var evaluFndSeq = "";
    var arrEvaluInpt = "";
    
    _onSubmit();
    
    if($("#dpthFinalTxt").val() == ""){
    	
    	msgAlert($("#dpthFinalTxt").attr("title") + MSG_COMM_2001, this);
    	
    	return false;
    }
    
    if($("#dpthFinalDesc").val() == ""){
    	
    	msgAlert("컨설팅 내용" + MSG_COMM_2001, this);
    	
    	return false;
    }
    
    arrEvaluInpt = $("#dpthFinalDesc").attr("name");
    
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
   }else{
	   $("#regiMode").val("nor");
   }
   
   
   
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
        
        if(isConfirm){
            // submit
            BIZComm.submit({
                url    : ROOT_PATH+"/evalu/saveEvaluFinlDpthMgmt.do",
            });
        }
    });
}

//저장처리
function doAddSave(){
	
    // 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    var isValid = true;
    var evaluFndSeq = "";
    var arrEvaluInpt = "";
    
    _onSubmit();
    
    if($("#dpthFinalTxt").val() == ""){
    	
    	msgAlert($("#dpthFinalTxt").attr("title") + MSG_COMM_2001, this);
    	
    	return false;
    }
    
    if($("#dpthFinalDesc").val() == ""){
    	
    	msgAlert("컨설팅 내용" + MSG_COMM_2001, this);
    	
    	return false;
    }
    
    arrEvaluInpt = $("#dpthFinalDesc").attr("name");
    
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
   
   $("#regiMode").val("add");
	
	// msg : "저장하겠습니까?"
	nConfirm(MSG_EVALU_M008, null, function(isConfirm){
		
		if(isConfirm){
			// submit
			BIZComm.submit({
				url    : ROOT_PATH+"/evalu/saveEvaluFinlDpthMgmt.do",
			});
		}
	});
}

//목록으로 이동	신규 추가 2015.01.21 
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + "/evalu/listEvaluBudtMgmt.do"
    });
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//네이버 스마트 에디터
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//스마트 에디터에서 값을 textarea 넣어줌
function _onSubmit(elClicked){
	 oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용된다
	  // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	  try{
//		  doSave();  //폼검사 메소드 호출
	 }catch(e){}
}
