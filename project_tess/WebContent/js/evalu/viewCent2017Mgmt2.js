/**
 * 평가등록 상세화면 (평가정보 확인)
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
    
    //평가정보 입력되지 않은 컬럼 합쳐주는 이벤트
    // evaluInfoTabChk();
    
}

////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

function initScenEvent(){
	
	var flag = true;
	
	var flag2 = true;
	
	$("input[name='evaluProcStep']").each(function(){
		var evaluProcStep = this.value;
		if(evaluProcStep != "AS30" && evaluProcStep != "AS90"){
			flag = false;
			return false;
		};
	});
	

	if(!flag) {
		if($("#evaluStage").val() != 'EVALU_PREV' && $("#evaluStage").val() != 'EVALU_CENT' && $("#evaluStage").val() != 'EVALU_PROG'){
			$("#prcBtnModal").hide();
		}
	}
	
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
        case 'prcBtnRegi':            // 수정버튼
            goRegi();
            break;
        case 'prcBtnAppr':
        	goAppr();
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

function evaluInfoTabChk(){
	
    BIZComm.tableRowSpanning({
    	table  			: "#evaluInfoTab",
    	spanning_row_index	: 0,		
    	attrTag      	: "td",
    	repTxt			: "평가가 아직 진행되지 않았습니다." 
    });
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

// 목록으로 이동
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + "/evalu/listEvaluBudtMgmt.do"
    });
}

// 수정 화면으로 이동.
function goRegi() {
	
	var chkObj = $('input[name="evaluIdChk"]:checked');
	
	if( chkObj.length ==0){
		msgAlert("입력할 평가정보를 체크해주시기 바랍니다.", $('input[name="evaluIdChk"]') ); 
		return false;
	}
	
	if( chkObj.length!=1){
		msgAlert("입력할 평가정보를 한개만 체크해주시기 바랍니다.", $('input[name="evaluIdChk"]') ); 
		return false; 
	}
	
	var chkVal = chkObj.val();
	var arrChkVal = chkVal.split("|");
	var evaluId = arrChkVal[0];
	var evaluProcStep = arrChkVal[1];
	
	if(evaluProcStep != "AS10"){
		msgAlert("입력된 평가정보는 다시 입력할 수는 없습니다.\n");
		$('input[name="evaluIdChk"]').attr("checked", false);
		return false;
	}
	
    var userParam = {
            mode       : EVALUComm.mode.regi,
            evaluBusiNo : $("#evaluBusiNo").val(),
            evaluStage : $("#evaluStage").val(),
            evaluId : arrChkVal[0],
            evaluProcStep : arrChkVal[1],
            evaluGubun : $("#evaluGubun").val()
        };
    
    // submit
    BIZComm.dySubmit({
        url : ROOT_PATH+"/evalu/regi2017Mgmt.do",
//        url : ROOT_PATH+"/evalu/regiEvaluBudtMgmt.do",
        userParam      : userParam
    });
}

//수정 화면으로 이동.
function goView(arrParam) {
	
	var arrChkVal = arrParam.split("|");
	
	var evaluProcStep = arrChkVal[1];
	
	if(evaluProcStep == 'AS10'){
		msgAlert("평가정보를 먼저 입력해주세요", $("input[name='evaluIdChk']"));
		return false;
	} 
	
    var userParam = {
            mode       : EVALUComm.mode.regi,
            evaluBusiNo : $("#evaluBusiNo").val(),
            evaluStage : $("#evaluStage").val(),
            evaluId : arrChkVal[0],
            evaluProcStep : arrChkVal[1],
            evaluGubun : $("#evaluGubun").val()
        };
    
    // submit
    BIZComm.dySubmit({
        url : ROOT_PATH+"/evalu/viewEvaluInptBudtMgmt.do",
        userParam      : userParam
    });
}

function goAppr(){
	
	var finalEvaluFnd = $("#finalEvaluFnd").val();
	if(finalEvaluFnd == ""){
		msgAlert("최종평가결과를 선택해 주세요", $("#finalEvaluFnd"));
		return false;
	}
	
    var userParam = {
            mode       : EVALUComm.mode.regi,
            evaluBusiNo : $("#evaluBusiNo").val(),
            evaluStage : $("#evaluStage").val(),
            finalEvaluFnd : finalEvaluFnd,
            finalEvaluFndNote : $("#finalEvaluFndNote").val()
        };
    
    // submit
    BIZComm.dySubmit({
        url : ROOT_PATH+"/evalu/updtEvaluFinalAppr.do",
        userParam      : userParam
    });
	
}

function tab1(){
	var form = document.model;
	form.action="/evalu/viewEvaluBudtMgmt.do";
	form.submit();
}

function tab2(){
	var form = document.model;
	form.action="/evalu/viewEvaluBudtMgmt2.do";
	form.submit();
}

function evaluFileDownload2017(commitUserId){
	var form = document.model;
	alert(": commitUserId : " + commitUserId);
	$("#evaluId").val(commitUserId);
	form.action="/evalu/evaluCommitFileDownload2017.do";
	form.submit();
}


////////////////////////////////////////////////////////////////////////////////
//REPORTING  함수
////////////////////////////////////////////////////////////////////////////////
function reporting(){
	// 파라메터 값이 NULL인 경우 쿼리에서 임의 문자 escape로 받아 처리.  
	 var repParam_evaluBusiNo = $("#evaluBusiNo").val();
	 var repParam_evaluBusiNm = $("#evaluBusiNm").val();
	 repParam_evaluBusiNm = encodeURIComponent(repParam_evaluBusiNm);
	 var repParam_evaluStage = $("#evaluStage").val();
	 var reParam_evaluGubun = $("#evaluGubun").val();
	 var userCheckboxes = document.getElementsByName('evaluIdChk');
	 var userIdSelected=[];
	 var userNmSelected=[];
	 for(var i=0; i < userCheckboxes.length; i++) {
		 if(userCheckboxes[i].checked){
			 var userId = userCheckboxes[i].value.split('|');
			 userIdSelected.push(userId[0]);
			 userNmSelected.push(userId[2]);
		 }
	 }

	 if(userIdSelected.length==0){
		 msgAlert("평가위원 사업평가정보를 선택해주세요.\n");
	 }
	 // 예산요구사업 리포팅 폼
	 for(var i=0; i < userIdSelected.length; i++){
		 if(repParam_evaluStage=="EVALU_BUDT") {
			 var newWindow = window.open("");
			 if(reParam_evaluGubun=="PREV"){
				 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_BudgetReq_2014.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
				 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];	 
			 } else {
				 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_BudgetReq_2015.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
				 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];	 
			 }
		 } else if(repParam_evaluStage=="EVALU_NEWS") {
			 var newWindow = window.open("");
			 if(reParam_evaluGubun=="PREV"){
				 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_NewBusiness_2014.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
				 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];
			 } else {
				 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_NewBusiness_2015.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
				 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];
			 }
		 } else if(repParam_evaluStage=="EVALU_INTR") {
			 var newWindow = window.open("");
			 if(reParam_evaluGubun=="PREV"){
				 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_IntrEvalu_2014.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
				 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];
			 } else {
				 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_IntrEvalu_2015.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
				 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];
			 }
		 } else if(repParam_evaluStage=="EVALU_AFTR") {
			 var newWindow = window.open("");
			 newWindow.location.href="http://125.7.243.212:8888/AIViewer55/reporttest/TESS/OP_AfterEvalu_2014.jsp?busiNo="+repParam_evaluBusiNo+"&busiNm="+repParam_evaluBusiNm
			 +"&commitId="+userIdSelected[i]+"&commitNm="+userNmSelected[i];
		 }   
	 } 
	
}