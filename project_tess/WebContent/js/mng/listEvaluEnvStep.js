/**
 * 평가사업관리 리스트 스크립트
 *
 * @author lsz
 * @version 1.0 2018-11-26
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

$(document).ready(function(){
	
});


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var LIST_URL      	= ROOT_PATH+"/mng/listEvaluEnvStep.do" ;
var REGI_URL 	   	= ROOT_PATH+"/mng/regiEvaluEnvStep.do";
var UPDT_URL		= ROOT_PATH+"/mng/updtEvaluEnvStep.do";
var DELT_URL		= ROOT_PATH+"/mng/deltEvaluEnvStep.do";


////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
    // 그리드 로드
    loadGrid();
    
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    
    // 지역1만 선택했을 때 지역2콤보가 0번째에 오도록 처리
    //  => 뒤로가기 눌렀을 때 지역 콤보가 초기화되는 문제해결을 위해 추가
    var srchBusiAddrVal = $("#srchBusiAddr2").val();
    if(isEmpty(srchBusiAddrVal)){
        srchBusiAddrVal = $("#srchBusiAddr1").val();
    }
    $("#srchBusiAddrVal").val(srchBusiAddrVal);
    
    
    
    // 지역 검색조건 combo loading
    loadBusiAddrCombo();
}


////////////////////////////////////////////////////////////////////////////////
// Grid 관련
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// 그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

// 평가 등록
function regi_btn() {
	
	var regiIndicatCd = $("input[name=regiIndicatCd]").val();
	var regiIndicatNm = $("input[name=regiIndicatNm]").val();
	var regiIndicatUseYn = $("input:radio[name=regiIndicatUseYn]:checked").val();
	var regiMainOpenYn = $("input:radio[name=regiMainOpenYn]:checked").val();
	
	console.log("regiIndicatCd : " + regiIndicatCd);
	console.log("regiIndicatNm : " + regiIndicatNm);
	console.log("regiIndicatUseYn : " + regiIndicatUseYn);
	
	var params = {"evaluIndicatCd" : regiIndicatCd, "evaluIndicatNm" : regiIndicatNm, "evaluIndicatUseYn" : regiIndicatUseYn, "mainOpenYn" : regiMainOpenYn};
	
	nConfirm("저장하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			$.ajax({  
		        url: REGI_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//			            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	window.location.href = LIST_URL;
		        }
			});
		}
	});
}


//평가 수정
function updt_btn(tag) {
	
	var updtIndicatCd = $(tag).parents("tr").find("input[name=updtIndicatCd]").val();
	var updtIndicatNm = $(tag).parents("tr").find("input[name=updtIndicatNm]").val();
	var updtIndicatUseYn = $(tag).parents("tr").find("select[name=updtIndicatUseYn] option:selected").val();
	var updtMainOpenYn = $(tag).parents("tr").find("select[name=updtMainOpenYn] option:selected").val();
	var updtMainOpenOrd = $(tag).parents("tr").find("input[name=updtMainOpenOrd]").val();
	
	var params = {"evaluIndicatCd" : updtIndicatCd, "evaluIndicatNm" : updtIndicatNm, "evaluIndicatUseYn" : updtIndicatUseYn, "mainOpenYn" : updtMainOpenYn, "mainOpenOrd" : updtMainOpenOrd};
	
	nConfirm("정말 수정하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			$.ajax({
		        url: UPDT_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//			            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	window.location.href = LIST_URL;
		        }
			});
		}
	});
}


//평가 삭제
function delt_btn(indicatCd) {
	
	var params = {"evaluIndicatCd" : indicatCd};
	
	nConfirm("정말 삭제하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			$.ajax({
		        url: DELT_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//			            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	alert("삭제되었습니다.");
		        	
		        	window.location.href = LIST_URL;
		        }
			});
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

