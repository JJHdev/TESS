/**
*******************************************************************************
***    명칭: listEvaluEnvStep.js
***    설명: [관리자] 평가환경설정 > 평가단계관리 화면 스크립트
***
***    -----------------------------    Modified Log   ------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0      2023.11.17      LHB     First Coding.
*******************************************************************************
**/

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

function loadInitPage() {}

$(document).ready(function() {});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var LIST_URL      	= ROOT_PATH+"/mng/listEvaluEnvStep.do" ;
var REGI_URL 	   	= ROOT_PATH+"/mng/regiEvaluEnvStage.do";
var UPDT_URL		= ROOT_PATH+"/mng/updtEvaluEnvStage.do";
var DELT_URL		= ROOT_PATH+"/mng/deltEvaluEnvStage.do";


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
    if(isEmpty(srchBusiAddrVal)) {
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

// 평가단계 등록
function regi_btn() {
	var code	= $("table.evtdss-form-table input[name='code']").val();
	var codeNm	= $("table.evtdss-form-table input[name='codeNm']").val();
	var useYn	= $("table.evtdss-form-table input[name='useYn']:checked").val();
	
	var params = {
		code: code,
		codeNm: codeNm,
		useYn: useYn
	};
	
	nConfirm("등록하시겠습니까?\n평가단계는 시스템에 영향을 미칠 수 있습니다.", null, function(isConfirm) {
		if(isConfirm) {
			$.ajax({  
		        url: REGI_URL,
		        type: "POST",
		        data: params, 
		        dataType:"json", 
		        success: function(result) {
		        	const code = result.code;
					if (code && code > 0) {
						window.location.reload();
					} else {
						alert('등록에 실패했습니다. 관리자에게 문의해주세요.');
					}
		        }
			});
		}
	});
}


// 평가단계 수정
function updt_btn(tag) {
	var code	= $(tag).closest("tr").find("input[name='code']"   ).val();
	var codeNm	= $(tag).closest("tr").find("input[name='codeNm']" ).val();
	var useYn	= $(tag).closest("tr").find("select[name='useYn']" ).val();
	var codeOdr	= $(tag).closest("tr").find("input[name='codeOdr']").val();
	
	var params = {
		code: code,
		codeNm: codeNm,
		useYn: useYn,
		codeOdr: codeOdr
	}; 
	
	nConfirm("정말 수정하시겠습니까?\n평가단계는 시스템에 영향을 미칠 수 있습니다.", null, function(isConfirm) {
		if(isConfirm) {
			$.ajax({
		        url: UPDT_URL,
		        type: "POST",
		        data:params,
		        dataType:"json",
		        success:function(result) {
					const code = result.code;
					if (code && code > 0) {
						window.location.reload();
					} else {
						alert('수정에 실패했습니다. 관리자에게 문의해주세요.');
					}
		        }
			});
		}
	});
}


// 평가단계 삭제
function delt_btn(code) {
	var params = {
		code: code
	};
	
	nConfirm("정말 삭제하시겠습니까?\n평가단계는 시스템에 영향을 미칠 수 있습니다.", null, function(isConfirm) {
		if(isConfirm) {
			$.ajax({
		        url: DELT_URL,
		        type: "POST",
		        data: params, 
		        dataType: "json", 
		        success:function(result) {
		        	alert("삭제되었습니다.");
		        	window.location.href = LIST_URL;
		        }
			});
		}
	});
}