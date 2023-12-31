/**
 * 평가이력 화면
 *
 * @author LSZ
 * @version 1.0 2018-12-04
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////


/**
 * evaluComm.js에서 자동 호출하는 함수 (페이지 초기 설정 관련 수행)
 * 
 */
function loadInitPage(){

	// 이벤트를 바인딩한다.
    bindEvent();
    
    //
}


$(document).ready(function(){
	
	$("#AT11").click(function(){
		
		var rel = $(this).parent().find(".regi-file").attr("rel");
		
		if(rel == "N") {
			return true;
		} else {
			nAlert("이미 등록되어 있습니다.");
			return false;
		}
	});
	
	$(".select-committee li").click(function(){
		var index = $(this).index();
		
		$(".select-committee li").removeClass("active");
		$(".select-committee li").eq(index).addClass("active");
		
		$("#commit_table_list table").css("display", "none");
		$("#commit_table_list table").eq(index).css("display", "inline-table;");
	});
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var UPLOAD_URL		= ROOT_PATH+"/busi/evaluFileUpload.do" ;
var REMOVE_URL		= ROOT_PATH+"/busi/evaluFileDelete.do" ;
var PAGE_STEP		= "STEP4" ;
var EVALU_STAGE		= "PG90" ;

var LIST_URL 		= ROOT_PATH+"/busi/listEvaluBusi.do" ;
var VIEW_URL 		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var UPDT_URL		= ROOT_PATH+"/busi/updtEvaluCommitReview.do" ;
var CHCK_URL		= ROOT_PATH+"/busi/viewEvaluCommitStatus.do" ;
var EVALU_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var FILE_DELETE_URL = ROOT_PATH+"/busi/evaluFileDelete.do" ;
var APV_URL			= ROOT_PATH+"/busi/updtEvaluCommitReviewApv.do" ;


var STEP01_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var STEP02_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep02.do" ;
var STEP03_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep03.do" ;
var STEP04_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep04.do" ;
var STEP05_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep05.do" ;

var FINAL_APV_URL	= ROOT_PATH+"/busi/updtEvaluFinalApv.do" ;
var END_URL 		= ROOT_PATH+"/busi/listEvaluEndBusi.do" ;

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
}


function load_check() {
	
	var uscmType = $("#uscmType").val();
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	var userId = $("input[name=userId]").val();
	
	if(uscmType == "U9") {
		
		BIZComm.submit({
	        url: VIEW_URL,
	        userParam: {
	            evaluBusiNo: evaluBusiNo,
	            evaluStage: evaluStage,
	            evaluGubun: evaluGubun
	        }
	    });
	} else {
		
		var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId};

		$.ajax({
	        url: CHCK_URL,
	        type: "POST",
	        data:params, 
	        dataType:"json", 
	//		            contentType:"application/json; text/html; charset=utf-8",
	        success:function(result) {
	        	
	        	console.log(result);
	        	
	        	if(result.resultMap.AGREE_YN == 'Y') {
	        		BIZComm.submit({
				        url: VIEW_URL,
				        userParam: {
				            evaluBusiNo: evaluBusiNo,
				            evaluStage: evaluStage,
				            evaluGubun: evaluGubun,
				            userId: userId,
				            agreeYn: result.resultMap.AGREE_YN,
				            reviewYn: result.resultMap.REVIEW_YN,
				            opinionYn: result.resultMap.OPINION_YN
				        }
				    });
	        	}
	        }
		});
	}
	
}
////////////////////////////////////////////////////////////////////////////////
//페이지 이동 함수
////////////////////////////////////////////////////////////////////////////////
//목록으로 이동 
function goList(){
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}
// 평가 대상 화면으로 이동
function goView(evaluBusiNo, evaluStage, evaluUserId){
    BIZComm.submit({
        url : ROOT_PATH+ REGI_URL,
        userParam : {
            evaluBusiNo : evaluBusiNo,
            evaluStage : evaluStage,
            evaluUserId : evaluUserId
        }
    });
}
function goBusiInfo() {
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	var userId = $("input[name=userId]").val();
	
	BIZComm.submit({
        url: ROOT_PATH + "/busi/viewEvaluBusi.do",
        userParam: {
            evaluBusiNo: evaluBusiNo,
            evaluStage: evaluStage,
            evaluGubun: evaluGubun,
            userId: userId
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
        case 'prcBtnCancle':          //취소
            doCancle();
            break;
    }
}
//기능 버튼 클릭이벤트 연결
function bindFuncBtnEvent(){
    // ID가 'prcBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=prcBtn]").click(function(){    	
        onClickButton($(this).attr("id"));
    });
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

// 첨부파일 저장
function doc_save(type) {
	
	// 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
    	if(isConfirm){
    		
    		$("#docuType").val("PLYY");
    		$("#atthType").val(type);
        	
            // 시도/시군구 콤보박스 text 값을 db 매핑 객체에 적용.
            //setCityauthForms();
            
            if(isFileUpload){
                // file 객체 명 일괄 변경 및 필요한 파일정보 parameter 신규 생성.
                EVALUComm.buildUpfilePropObjs02(type);
                
                //<년도별 사업계획서>의 atthType 값을 선택된 년도로 일괄 설정.
                //setPlyyAtthTypes();
            }
            
            // submit
            BIZComm.submit({
                isFile : isFileUpload ,                        // 파일첨부 form으로 설정.
                url    : ROOT_PATH + UPLOAD_URL
            });
        }
    });
}


// 제출
function doSave() {
	
	var check = $(".regi-file").attr("rel");
	
	if(check == "Y") {
		nConfirm("제출하시겠습니까?", null, function(isConfirm){
			if(isConfirm){
				var evaluBusiNo = $("input[name=evaluBusiNo]").val();
				var evaluStage = $("input[name=evaluStage]").val();
				var evaluGubun = $("input[name=evaluGubun]").val();
				var userId = $("input[name=userId]").val();
				var reviewYn = "Y";
				
				var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, "reviewYn": reviewYn};
				
				$.ajax({
			        url: UPDT_URL,
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
	} else {
		jAlert("서류를 등록하세요.");
	}
}

// 제출취소
function doCancle() {
	nConfirm("제출 취소하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var reviewYn = "N";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, "reviewYn": reviewYn};
			
			$.ajax({
		        url: UPDT_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//				            contentType:"application/json; text/html; charset=utf-8",
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

//파일삭제
function doFileDelete(status) {
	
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	var userId = $("input[name=userId]").val();
	
	if(status != "Y") {
		nConfirm("삭제하시겠습니까?", null, function(isConfirm){
			if(isConfirm){
				var fileNo = $(".regi-file").attr("fileNo");
				
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
	} else {
		jAlert("제출상태입니다.");
	}
	
}

// 완료 승인
function fn_finalApv() {
	
	nConfirm("승인하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage};
			
			$.ajax({
		        url: FINAL_APV_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//				            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	console.log(result);
		        	
	        		BIZComm.submit({
				        url: END_URL,
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





function goStep(index) {
	
    // 일반 객체 생성
    let dataObject = {};
    let userParam = {};

    // Hidden 필드 데이터 추가
    let hiddenInputs = document.querySelectorAll('#model input[type="hidden"], #fileContentArea input[type="hidden"]');
    hiddenInputs.forEach(input => {
        dataObject[input.name] = input.value;
    });

    userParam['evaluHistNoHist'] = dataObject['evaluHistNoHist'];
    userParam['evaluStageHist']  = dataObject['evaluStageHist'];
	
	var step_url = "";
	
	if(index == 1) {
		step_url = STEP01_URL;
	} else if(index == 2) {
		step_url = STEP02_URL;
	} else if(index == 3) {
		step_url = STEP03_URL;
	} else if(index == 4) {
		step_url = STEP04_URL;
	} else if(index == 5) {
		step_url = STEP05_URL;
	}
	
	BIZComm.submit({
        url: step_url,
        userParam: {
            evaluBusiNo: evaluBusiNo,
            evaluStage: evaluStage,
            evaluGubun: evaluGubun,
            userId: userId
        }
    });
}