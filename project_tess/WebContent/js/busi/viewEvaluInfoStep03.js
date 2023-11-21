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
	
	$("#AT13").click(function(){
		
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
var PAGE_STEP		= "STEP3" ;
var EVALU_STAGE		= "PG30" ;

var LIST_URL 		= ROOT_PATH+"/busi/listEvaluBusi.do" ;
var VIEW_URL 		= ROOT_PATH+"/busi/viewEvaluInfoStep03.do" ;
var UPDT_URL		= ROOT_PATH+"/busi/updtEvaluTotalResult.do" ;
var CHCK_URL		= ROOT_PATH+"/busi/viewEvaluCommitStatus.do" ;
var EVALU_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var FILE_DELETE_URL = ROOT_PATH+"/busi/evaluFileDelete.do" ;
var APV_URL			= ROOT_PATH+"/busi/updtEvaluCommitReviewApv.do" ;

var STEP01_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var STEP02_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep02.do" ;
var STEP03_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep03.do" ;
var STEP04_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep04.do" ;
var STEP05_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep05.do" ;

var FINAL_NOTE_SAVE_URL	= ROOT_PATH+"/busi/getEvaluFinalOpinionNote.do" ;
var FINAL_IPM_SAVE_URL	= ROOT_PATH+"/busi/getEvaluFinalIpmNote.do" ;

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
//페이지 이동함수
////////////////////////////////////////////////////////////////////////////////

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
//목록으로 이동 
function goList(){
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}
function goBusiInfo() {
	var evaluBusiNo = $("input[name=evaluHistNoHist]").val();
	var evaluStage = $("input[name=evaluStageHist]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	var userId = $("input[name=userId]").val()
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
//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    if (id.startsWith('upfile')) {
        fileRemove(REMOVE_URL, id);
    } else {
        switch( id ) {
            case 'prcBtnSave':            //저장
                doSave();
                break;
            case 'prcBtnCancle':          //취소
                goList();
                break;
        }
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

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
function doSave() {

	nConfirm("제출하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			fileUpload(UPLOAD_URL);
		}
	})

};

function fileUpload(URL) {

	// FormData 객체 생성
	let formData = new FormData();

	let fileInputs = document.querySelectorAll('.regi-file-input');

	fileInputs.forEach(input => {
		if (input.files.length) {
			// 'upfile' 문자열을 제거하고 나머지 ID를 키로 사용
			let key = input.id.replace('upfile', '');
			formData.append(key, input.files[0]);
		}
	});

	// Hidden 필드 데이터 추가
	let hiddenInputs = document.querySelectorAll('#model input[type="hidden"], #fileContentArea input[type="hidden"]');
	hiddenInputs.forEach(input => {
		formData.append(input.name, input.value);
	});

	// 추가 파라미터 추가
	formData.delete('pageStep');
	formData.append('pageStep', PAGE_STEP);

	// AJAX 요청
	$.ajax({
		url: URL,
		type: 'POST',
		data: formData,
		processData: false,  // FormData와 함께 사용하기 위해 필수
		contentType: false,  // FormData와 함께 사용하기 위해 필수
		success: function(response) {
			// 성공 시 처리
			alert("종합결과서가 등록 되었습니다.");
			window.location.reload();
		},
		error: function(xhr, status, error) {
			// 오류 시 처리
			alert("종합결과서가 등록이 실패하였습니다.");
		}
	});
}

//파일 삭제
function fileRemove(URL, id) {
	debugger;
    nConfirm("파일을 삭제하시겠습니까?", null, function(isConfirm) {
        if (isConfirm) {
            // FormData 객체 생성
            let formData = new FormData();

            // Hidden 필드 데이터 추가
            let hiddenInputs = document.querySelectorAll('#model input[type="hidden"], #fileContentArea input[type="hidden"]');
            hiddenInputs.forEach(input => {
                formData.append(input.name, input.value);
            });

            // 추가 파라미터 추가
			formData.delete('evaluStage');
            formData.append('evaluStage', EVALU_STAGE);
			formData.delete('atthType');
            formData.append('atthType', id.replace('upfile', ''));

            // AJAX 요청
            $.ajax({
                url: URL,
                type: 'POST',
                data: formData,
                processData: false,  // FormData와 함께 사용하기 위해 필수
                contentType: false,  // FormData와 함께 사용하기 위해 필수
                success: function(response) {
                    // 성공 시 처리
                    alert("파일이 성공적으로 삭제되었습니다.");
                    window.location.reload();
                },
                error: function(xhr, status, error) {
                    // 오류 시 처리
                    alert("파일 삭제에 실패했습니다.");
                }
            });
        }
    });
};

/*
// 제출
function doSave() {
	
	var check = $(".regi-file").attr("rel");
	
	if(check == "Y") {
		nConfirm("제출하시겠습니까?", null, function(isConfirm){
			if(isConfirm){
				var evaluBusiNo = $("input[name=evaluBusiNo]").val();
				var evaluStage = $("input[name=evaluStage]").val();
				var evaluGubun = $("input[name=evaluGubun]").val();
				var totalRYn = "Y";
				var finalFnd = $("input[name=finalFnd]:checked").val();
				
				var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, 
							  "totalRYn": totalRYn, "finalFnd": finalFnd};
				
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
*/
// 제출취소
function doCancle() {
	nConfirm("제출 취소하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var totalRYn = "N";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "totalRYn": totalRYn};
			
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

//종합의견 등록
function saveNote() {
	
	var note = $("#finalFndNote").val();
	
	nConfirm("저장하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var type = "I";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, 
							"finalFndNote": note, "opType": type};
			
			$.ajax({
		        url: FINAL_NOTE_SAVE_URL,
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

//종합의견 삭제
function deltNote() {
	nConfirm("삭제하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var type = "D";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, 
							"opType": type};
			
			$.ajax({
		        url: FINAL_NOTE_SAVE_URL,
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

//개선사항 등록
function saveIpm() {
	
	var note = $("#finalIpmNote").val();
	
	nConfirm("저장하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var type = "I";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, 
							"finalIpmNote": note, "ipmType": type};
			
			$.ajax({
		        url: FINAL_IPM_SAVE_URL,
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

//개선사항 삭제
function deltIpm() {
	nConfirm("삭제하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var type = "D";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, 
							"ipmType": type};
			
			$.ajax({
		        url: FINAL_IPM_SAVE_URL,
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

$(document).ready(function() {
    // 모달창 가져오기
    var modal = document.getElementById("pdfModal");
    
    // 모달창을 여는 버튼 가져오기
    var btn = document.getElementById("preview-pdf-btn");
    
    // 모달창에서 닫기 버튼 가져오기
    var span = document.getElementsByClassName("close")[0];
    
    // 사용자가 버튼을 클릭하면 모달창 열기
    btn.onclick = function(event) {
        event.preventDefault(); // 폼의 기본 제출 이벤트를 방지
        modal.style.display = "block";
    }
    
    // 사용자가 (x) 버튼을 클릭하면 모달창 닫기
    span.onclick = function() {
        modal.style.display = "none";
    }
    
    // 사용자가 모달창 외부를 클릭하면 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});