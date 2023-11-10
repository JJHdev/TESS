/**
*******************************************************************************
***    명칭: viewEvaluBusiMgmtHist.js
***    설명: [관리자] 평가사업관리 > 평가이력 화면
***
***    -----------------------------    Modified Log   ------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0      2023.11.10      LHB     First Coding.
*******************************************************************************
**/

function loadInitPage() {

}


$(document).ready(function() {
//  // Set disable 'back' event at next page
//  window.history.forward(0);
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL 		= ROOT_PATH+"/mng/listEvaluBusiMgmt.do" ;
var VIEW_URL 		= ROOT_PATH+"/mng/viewEvaluBusiMgmtGuide.do" ;
var REGI_URL		= ROOT_PATH+"/mng/regiEvaluBusiMgmtHist.do";
var CHECK_URL		= ROOT_PATH+"/mng/chckEvaluBusiMgmtHist.do";
var DELT_URL		= ROOT_PATH+"/mng/deltEvaluStage.do";

var HIST_URL		= ROOT_PATH+"/mng/viewEvaluBusiHist.do";


////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
 // 그리드 로드
    loadGrid();
    
    // 공통 이벤트 설정
    //fn_uscm_setEvent();
    
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	fn_uscm_setFullCellphoneNo();
}



////////////////////////////////////////////////////////////////////////////////
//그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

// 평가 대상 화면으로 이동
function goView(evaluBusiSn, evaluStage, evaluUserId) {
    
    BIZComm.submit({
        url : ROOT_PATH+ REGI_URL,
        userParam : {
            evaluBusiSn : evaluBusiSn,
            evaluStage : evaluStage,
            evaluUserId : evaluUserId
        }
    });
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    switch( id ) {
        case 'prcBtnSave':            //저장
            doSave();
            break;
        case 'prcBtnList':            //리스트
            goList();
            break;
        case 'ctlBtnAdd':             //추가
            addStahRow();
            break;
        case 'ctlBtnRemv':            //삭제
            removeStahRow();
            break;
    }
}



////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

//목록으로 이동 
function goList() {
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}


function save_btn() {
	
	const evaluBusiSn	= $("#evaluBusiSn").val();
	var evaluYear		= $("#regiEvaluGubun option:selected").val();
	var evaluStage		= $("#regiEvaluStage option:selected").val();
	
	nConfirm(MSG_EVALU_M008, null, function(isConfirm) {
		if(isConfirm) {
			check_stage(evaluBusiSn, evaluYear, evaluStage);
		}
	});
}

function save_ajax(evaluBusiSn, evaluYear, evaluStage) {
	var params = {evaluBusiSn: evaluBusiSn, "evaluYear": evaluYear, "evaluStage": evaluStage};
	
	$.ajax({
        url: REGI_URL,
        type: "POST",
        data:params, 
        dataType:"json",
        success:function(result) {
			const code = result.code;
			const msg = result.msg;
        	if (code > 0) {
				nAlert(msg, null, function() {
					window.location.reload();	
				});
			} else {
				nAlert(msg, null, null);
				return false;
			}
        }
	});
}


function check_stage(evaluBusiSn, evaluYear, evaluStage) {
	
	var params = {"evaluBusiSn": evaluBusiSn, "evaluYear": evaluYear, "evaluStage": evaluStage};
	
	$.ajax({
        url: CHECK_URL,
        type: "POST",
        data:params,
        async: true,
        dataType:"json", 
        success:function(result) {
			const code = result.code;
        	if(code > 0) {
				nAlert("이미 등록되어 있습니다.", null, null);
        	} else {
        		save_ajax(evaluBusiSn, evaluYear, evaluStage);
        	}
        }
	});
}

//수정 페이지 이동 
function goModfy(evaluHistSn) {
    BIZComm.submit({
        url : ROOT_PATH + VIEW_URL,
        userParam: {
        	type: "MOD",
            evaluHistSn: evaluHistSn
        }
    });
}


//삭제 
function goDelete(gubun, stage) {
	
	var evaluBusiNo = $("#evaluBusiNo").val();
	var evaluBusiStage = stage;
	var evaluBusiGubun = gubun;
	
	var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluBusiGubun, "evaluStage": evaluBusiStage};
	
	nConfirm("정말 삭제 하시겠습니까?", null, function(isConfirm) {
    	if(isConfirm) {
    		$.ajax({
    	        url: DELT_URL,
    	        type: "POST",
    	        data:params,
    	        async: true,
    	        dataType:"json", 
//    		            contentType:"application/json; text/html; charset=utf-8",
    	        success:function(result) {
    	        	
    	        	BIZComm.submit({
    	                url : HIST_URL,
    	                userParam: {
    	                    evaluBusiNo: evaluBusiNo
    	                }
    	            });
    	        }
    		});
    	}
	});	
	
}

