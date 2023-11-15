/**
 * 평가지침 화면
 *
 * @author LSZ
 * @version 1.0 2018-12-04
 */

const SAVE_URL = ROOT_PATH + "/mng/saveEvaluBusiMgmtGuide.do";

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////


/**
 * evaluComm.js에서 자동 호출하는 함수 (페이지 초기 설정 관련 수행)
 * 
 */
function loadInitPage() {

}


$(document).ready(function() {
	
	changeTotBusiExps();
	loadBusiAddrCombo();
	comutils.enableCollapse();
	
	$("#AT06").click(function() {
		
		var rel = $(this).parent().find(".regi-file").attr("rel");
		
		if(rel == "N") {
			return true;
		} else {
			nAlert("이미 등록되어 있습니다.");
			return false;
		}
	});
	
	$("#AT07").click(function() {
			
		var rel = $(this).parent().find(".regi-file").attr("rel");
		
		if(rel == "N") {
			return true;
		} else {
			nAlert("이미 등록되어 있습니다.");
			return false;
		}
	});
	
	$("#AT08").click(function() {
		
		var rel = $(this).parent().find(".regi-file").attr("rel");
		
		if(rel == "N") {
			return true;
		} else {
			nAlert("이미 등록되어 있습니다.");
			return false;
		}
	});
 
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL 		= ROOT_PATH+"/mng/listEvaluBusiMgmt.do" ;
var VIEW_URL 		= ROOT_PATH+"/mng/viewEvaluBusiGuide.do" ;
var REGI_URL		= ROOT_PATH+"/mng/regiEvaluBusi.do";
var CHECK_URL		= ROOT_PATH+"/mng/checkEvaluStage.do";
var ULD_FILE_URL	= ROOT_PATH+"/mng/evaluFileUpload.do";
var UPDT_URL		= ROOT_PATH+"/mng/updtEvaluGuideState.do";
var FILE_DELETE_URL = ROOT_PATH+"/busi/evaluFileDelete.do" ;

var GUIDE_URL		= ROOT_PATH+"/mng/viewEvaluBusiGuide.do" ;
var HIST_URL 		= ROOT_PATH+"/mng/viewEvaluBusiHist.do" ;
var PLAN_URL		= ROOT_PATH+"/mng/viewEvaluBusiPlan.do" ;


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
function goView(evaluBusiNo, evaluStage, evaluUserId) {
    
    BIZComm.submit({
        url : ROOT_PATH+ REGI_URL,
        userParam : {
            evaluBusiNo : evaluBusiNo,
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

function doc_save(type) {
	
	// 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm) {
    	if(isConfirm) {
    		
    		$("#docuType").val("PLYY");
    		$("#atthType").val(type);
        	
            // 시도/시군구 콤보박스 text 값을 db 매핑 객체에 적용.
            //setCityauthForms();
            
            if(isFileUpload) {
                // file 객체 명 일괄 변경 및 필요한 파일정보 parameter 신규 생성.
                EVALUComm.buildUpfilePropObjs02(type);
                
                //<년도별 사업계획서>의 atthType 값을 선택된 년도로 일괄 설정.
                //setPlyyAtthTypes();
            }
            
            // submit
            BIZComm.submit({
                isFile : isFileUpload ,                        // 파일첨부 form으로 설정.
                url    : ROOT_PATH + ULD_FILE_URL
            });
        }
    });
}


/*
function submission_btn(val) {
	
	var evaluBusiNo = $("#evaluBusiNo").val();
	var evaluStage = $("#evaluStage").val();
	var evaluGubun = $("#evaluGubun").val();
	
	var check = $("#AT06").parents().find(".regi-file").attr("rel");
	
	if(val == "Y") {
		if(check == "N") {
			nAlert("평가지침서를 등록하세요.");
		} else {
			nConfirm("정말 제출 하시겠습니까?", null, function(isConfirm) {
		    	if(isConfirm) {
		    		var params = {"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "useYN" : val};
				
					$.ajax({
				        url: UPDT_URL,
				        type: "POST",
				        data:params, 
				        dataType:"json", 
		//			            contentType:"application/json; text/html; charset=utf-8",
				        success:function(result) {
				        	
				        	//window.location.href = LIST_URL;
				        	
				        	BIZComm.submit({
						        url: HIST_URL,
						        userParam: {
						            evaluBusiNo: evaluBusiNo,
						            evaluStage: evaluStage,
						            evaluGubun: evaluGubun
						        }
						    });
				        }
					});
			    }
			});
		}
	} else {
		nConfirm("정말 제출 취소 하시겠습니까?", null, function(isConfirm) {
	    	if(isConfirm) {
	    		var params = {"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "useYN" : val};
	    		
	    		$.ajax({
			        url: UPDT_URL,
			        type: "POST",
			        data:params, 
			        dataType:"json", 
	//				            contentType:"application/json; text/html; charset=utf-8",
			        success:function(result) {
			        	
			        	//window.location.href = LIST_URL;
			        	
			        	BIZComm.submit({
					        url: HIST_URL,
					        userParam: {
					            evaluBusiNo: evaluBusiNo,
					            evaluStage: evaluStage,
					            evaluGubun: evaluGubun
					        }
					    });
			        }
				});
	    	}
		});
	}
}
*/

//파일삭제
function doFileDelete(fileNo) {
	
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	var userId = $("input[name=userId]").val();
	
	nConfirm("삭제하시겠습니까?", null, function(isConfirm) {
		if(isConfirm) {
			//var fileNo = $(".regi-file").attr("fileNo");
			
			var params = {"fileNo": fileNo};
			
			$.ajax({
		        url: FILE_DELETE_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//					            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	console.log(result);
		        	
	        		BIZComm.submit({
				        url: VIEW_URL,
				        userParam: {
				            evaluBusiNo: evaluBusiNo,
				            evaluStage: evaluStage,
				            evaluGubun: evaluGubun,
				            userId: userId
				        }
				    });
		        }
			});
		}
	});
	
}

// 탭 함수
function goTab(page) {
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	
	var page_url = "";
	
	if(page == "hist") {
		page_url = HIST_URL;
	} else if(page == "guide") {
		page_url = GUIDE_URL;
	} else if(page == "plan") {
		page_url = PLAN_URL;
	}
	
	BIZComm.submit({
        url: page_url,
        userParam: {
            evaluBusiNo: evaluBusiNo,
            evaluStage: evaluStage,
            evaluGubun: evaluGubun
        }
    });
}

// 지역 검색조건 combo loading
function loadBusiAddrCombo() {
	//시도 선택시 지자체(구군) 검색
	comutils.changeCityBjd({
		loading : true,
		citysido: "busiAddr1Sd",
		cityauth: "busiAddr2Sgg",
		initcity: "busiAddr1",
		//citySidoI: "busiAddr1",
		//cityAuthI: "busiAddr2",
		callback: function() {
		},
		init    : function() {
		}
	});
}

// 사업비 계산
function changeTotBusiExps() {
	var totInputId	= "totBusiExps";
	var inputIdList	= ["totBusiExps1", "totBusiExps2", "totBusiExps3"];
	
	var selector = '';
	inputIdList.forEach(function(e, i) {
		selector += ("#" + e + (i == inputIdList.length-1 ? '' : ', '));
	});
	
	$(selector).change(function() {
		var value = 0;
		inputIdList.forEach(function(e, i) {
			if (!isNaN($("#" + e).val())) {
				value += Number($("#" + e).val());
			}
		});
		$("#" + totInputId).val(value);
	});
	
	$(selector).change();
}

// 개발사업 개요 저장
function saveInfo() {
	nConfirm("개발사업 개요를 저장하시겠습니까?\n입력한 값에 따라 사업코드가 변경될 수 있습니다.", null, function(isConfirm) {
    	if(isConfirm) {
			$("#busiAddr1").val($("#busiAddr1Sd").val());
			$("#busiAddr2").val($("#busiAddr2Sgg").val());
			
			var params = $("#model").serialize();
	
			$.ajax({
		        url: SAVE_URL,
		        type: "POST",
		        data: params, 
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
	});
}

// 평가위원 모달 오픈
function modal_open() {
	$("#myModal").bPopup({
		modalClose: false
	});
}