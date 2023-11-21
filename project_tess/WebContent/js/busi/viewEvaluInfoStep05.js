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

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var UPLOAD_URL		= ROOT_PATH+"/busi/evaluFileUpload.do" ;
var REMOVE_URL		= ROOT_PATH+"/busi/evaluFileDelete.do" ;
var PAGE_STEP		= "STEP5" ;
var EVALU_STAGE		= "PG60" ;

var LIST_URL 		= ROOT_PATH+"/busi/listEvaluBusi.do" ;
var VIEW_URL 		= ROOT_PATH+"/busi/viewEvaluInfoStep02.do" ;
var UPDT_URL		= ROOT_PATH+"/busi/updtEvaluCommitOpinion.do" ;
var CHCK_URL		= ROOT_PATH+"/busi/viewEvaluCommitStatus.do" ;
var EVALU_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var FILE_DELETE_URL = ROOT_PATH+"/busi/evaluFileDelete.do" ;
var APV_URL			= ROOT_PATH+"/busi/updtEvaluCommitOpinionApv.do" ;

var STEP01_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var STEP02_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep02.do" ;
var STEP03_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep03.do" ;
var STEP04_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep04.do" ;
var STEP05_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep05.do" ;

var NOTE_SAVE_URL	= ROOT_PATH+"/busi/getEvaluOpinionNote.do" ;
var IPM_SAVE_URL	= ROOT_PATH+"/busi/getEvaluIpmNote.do" ;

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
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

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
			alert("이행계획서 등록이 완료 되었습니다.");
			window.location.reload();
		},
		error: function(xhr, status, error) {
			// 오류 시 처리
			alert("이행계획서 등록이 실패 되었습니다.");
		}
	});
}


//파일 삭제
function fileRemove(URL, id) {
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


// 제출
function doSave() {

	nConfirm("제출하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			fileUpload(UPLOAD_URL);
		}
	})

};

/*
				var check = $(".regi-file").attr("rel");
				var evaluBusiNo = $("input[name=evaluBusiNo]").val();
				var evaluStage = $("input[name=evaluStage]").val();
				var evaluGubun = $("input[name=evaluGubun]").val();
				var userId = $("input[name=userId]").val();
				var opinionYn = "Y";
				var opinionFnd = $("input[name=opinionFnd]:checked").val();
				
				var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, 
							  "userId": userId, "opinionYn": opinionYn, "opinionFnd": opinionFnd};
				
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
			var userId = $("input[name=userId]").val();
			var reviewYn = "N";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, 
						  "userId": userId, "reviewYn": reviewYn, "opinionFnd": null};
			
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


//승인처리
function fn_opinionApv(userId_v, status) {
	
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	var userId = userId_v;
	var opinionApvYn = "";
	
	if(status == "Y") {
		opinionApvYn = "Y";
		message = "승인하시겠습니까?";
	} else {
		opinionApvYn = "N";
		message = "취소하시겠습니까?";
	}
	
	nConfirm(message, null, function(isConfirm){
		if(isConfirm){
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, 
						  "userId": userId, "opinionApvYn": opinionApvYn};
			
			$.ajax({
		        url: APV_URL,
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

//종합의견 등록
function saveNote() {
	
	var note = $("#opinionNote").val();
	
	nConfirm("저장하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var type = "I";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, 
							"opinionNote": note, "opType": type};
			
			$.ajax({
		        url: NOTE_SAVE_URL,
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
		        url: NOTE_SAVE_URL,
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
	
	var note = $("#ipmNote").val();
	
	nConfirm("저장하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			
			var evaluBusiNo = $("input[name=evaluBusiNo]").val();
			var evaluStage = $("input[name=evaluStage]").val();
			var evaluGubun = $("input[name=evaluGubun]").val();
			var userId = $("input[name=userId]").val();
			var type = "I";
			
			var params = {"evaluBusiNo": evaluBusiNo, "evaluGubun": evaluGubun, "evaluStage": evaluStage, "userId": userId, 
							"ipmNote": note, "ipmType": type};
			
			$.ajax({
		        url: IPM_SAVE_URL,
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
		        url: IPM_SAVE_URL,
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
	
    // BIZComm.submit 호출
	BIZComm.submit({
        url: step_url,
        userParam: userParam
    });
}

