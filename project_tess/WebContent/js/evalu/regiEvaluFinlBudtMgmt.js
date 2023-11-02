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
    
    
    tableRowSpanning("#finlTab", 0);
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
//        case 'prcBtnRset':            //초기화
//        	doRset();
//        	break;
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

//저장처리
function doSave(){
	
    // 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    var isValid = true;
    var evaluInptCulm = "";
    var evaluFndSeq = "";
    
   //입력대상 검사
    BIZComm.getCheckObjects($("#model")).each(function(){
        
        var chkObj = $(this);
        var chkObjNm = chkObj.attr("name");
        var chkObjTitle = chkObj.attr("title");
        
        
        //라디오 박스값 체크
        if(chkObj.attr("type") == "radio"){  
        	
        	var chkObVal = $(':radio[name="'+chkObjNm+'"]:checked').val();
        	
//        	if( isEmpty(chkObVal)){
//        		jAlert(chkObjTitle + '을 선택해주세요');
//        		chkObj.focus();
//        		isValid = false;
//        		return false;
//        	}else{
        		
        		evaluInptCulm = isEmpty(evaluInptCulm) ? chkObjNm :  (evaluInptCulm.indexOf(chkObjNm) < 0 ?  evaluInptCulm + "," +  chkObjNm : evaluInptCulm );
//        	}
        	 
        }
        
        // 입력필수이 대상 검사.
        if(chkObj.attr("_required") == "true" && chkObj.attr("name").indexOf("arr") < 0){
//            if( !fn_checkRequired(chkObj) ) { 
//            	isValid = false; 
//            	return false; 
//            } else {
            	 evaluInptCulm = isEmpty(evaluInptCulm) ? chkObjNm : evaluInptCulm + "," +  chkObjNm;
//            }
        }
    });
    
   // 정합성 검사.
   if(!isValid) return;
   
   //입력 컬럼들 저장
   $("#evaluInptCulm").val(evaluInptCulm);
   
   if($("#mode").val() == "updt"){
	   var evaluFndVal;
	   
	  $("input[name='arrEvaluFndSeq']").each(function(){
		  
		  evaluFndVal = this.value;
		  
		  evaluFndSeq = isEmpty(evaluFndSeq) ? evaluFndVal : evaluFndSeq + "," +  evaluFndVal;
	  });
	  
	  //수정할 seq 정보 저장
	  $("#evaluFndSeq").val(evaluFndSeq);
   }
   
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
        
        if(isConfirm){
            // submit
            BIZComm.submit({
                url    : ROOT_PATH+"/evalu/saveEvaluFinlBudtMgmt.do",
            });
        }
    });
}

//라디오버튼 초기화
function radioRset(title){
	
	$("input:radio[title='"+title+"']").removeAttr("checked");
	
}

//목록으로 이동	신규 추가 2015.01.21 
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + "/evalu/listEvaluBudtMgmt.do"
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


