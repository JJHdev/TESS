/**
 * 평가이력 화면
 *
 * @author LSZ
 * @version 1.0 2018-12-04
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL 		= ROOT_PATH+"/busi/listEvaluBusi.do" ;
var EVALU_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var UPLOAD_URL		= ROOT_PATH+"/busi/evaluFileUpload.do" ;
var REMOVE_URL		= ROOT_PATH+"/busi/evaluFileDelete.do" ;
var UPDTHIST_URL	= ROOT_PATH+"/busi/updtEvaluHist.do" ;
var PAGE_STEP		= "info" ;
var EVALU_STAGE		= "PG10" ;


var VIEW_URL 		= ROOT_PATH+"/busi/viewEvaluBusi.do" ;
var UPDT_URL		= ROOT_PATH+"/busi/updtEvaluCommitAgree.do" ;
var CHCK_URL		= ROOT_PATH+"/busi/viewEvaluCommitStatus.do" ;

function loadInitPage(){
	// 이벤트를 바인딩한다.
    bindEvent();
}
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
};

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
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

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

//목록으로 이동 
function goList(){
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}
function fn_goEvaluInfo() {
    // 일반 객체 생성
    let dataObject = {};
    let userParam = {};

    // Hidden 필드 데이터 추가
    let hiddenInputs = document.querySelectorAll('#model input[type="hidden"], #fileContentArea input[type="hidden"]');
    hiddenInputs.forEach(input => {
        dataObject[input.name] = input.value;
    });

    userParam['evaluHistSnHist'] = dataObject['evaluHistSnHist'];
    userParam['evaluStageHist']  = dataObject['evaluStageHist'];

    // BIZComm.submit 호출
    BIZComm.submit({
        url: EVALU_URL,
        userParam: userParam
    });
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//기능 버튼 클릭이벤트 연결
function bindFuncBtnEvent(){
    // ID가 'prcBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=prcBtn]").click(function(){
        onClickButton($(this).attr("id"));
    });
}

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
            case 'prcBtnFileSave':       
                fileUpload(UPLOAD_URL);
                break
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

function fileUpload(URL) {

    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
        if(isConfirm){
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
                console.log(input.name + '의 값은 = ' + input.value);
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
                    alert("사업설명서 등록이 완료 되었습니다.");
                    window.location.reload();
                },
                error: function(xhr, status, error) {
                    // 오류 시 처리
                    alert("사업설명서 등록이 실패 되었습니다.");
                }
            });
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

            // FormData 객체 생성
            let formData = new FormData();

            formData.append('gsUserId'          , $("input[name=gsUserId]").val());
            formData.append('evaluHistSnHist'   , $("input[name=evaluHistSnHist]").val());

            formData.append('busiAddr1Hist'     , $("#updtBusiAddr1Hist").val());
            formData.append('busiAddr2Hist'     , $("#updtBusiAddr2Hist").val());
            formData.append('busiAddr3Hist'     , $("input[name=updtBusiAddr3Hist]").val());
            formData.append('totBusiExps1Hist'  , $("input[name=updtTotBusiExps1Hist]").val());
            formData.append('totBusiExps2Hist'  , $("input[name=updtTotBusiExps2Hist]").val());
            formData.append('totBusiExps3Hist'  , $("input[name=updtTotBusiExps3Hist]").val());

            formData.append('busiNoteHist'      , $("input[name=updtBusiNoteHist]").val());
            formData.append('mainFcltHist'      , $("input[name=updtMainFcltHist]").val());
            formData.append('busiSttDateHist'   , $("input[name=updtBusiSttDateHist]").val());
            formData.append('busiEndDateHist'   , $("input[name=updtBusiEndDateHist]").val());


            // AJAX 요청
            $.ajax({
                url: UPDTHIST_URL,
                type: 'POST',
                data: formData,
                processData: false,  // 추가
                contentType: false,  // 추가
                success: function(response) {
                    // 성공 시 처리
                    alert("사업설명서 등록이 완료 되었습니다.");
                    window.location.reload();
                },
                error: function(xhr, status, error) {
                    // 오류 시 처리
                    alert("사업설명서 등록이 실패 되었습니다.");
                }
            });
        }
    });

}

/*
$(document).ready(function() {
    $('#addRow').click(function(event) {
		event.preventDefault();
        var $tableBody = $('#tableBody');
        if ($tableBody.find('tr').length < 5) { // 최대 2개의 추가 행을 허용
            var fileConut = 'upfile' + ($('.regi-file-input').length + 1 );
            
            $tableBody.append(`
                <tr>
                    <td>기타</td>
                    <td><input type="file" class="regi-file-input" id="${fileConut}"></td>
                    <td class="fix-width file"><a href="#" class="기타"></td>
                    <td><div class="submit-set"><button type="button" class="evtdss-submit" onclick="onClickButton('${fileConut}')" ><a title="파일삭제">삭제</a></button></div></td>
                </tr>
            `);
        }else{
			alert('추가 서류는 최대 3개까지 가능합니다.');
		}
    });

    $('#removeRow').click(function(event) {
		event.preventDefault
        var $tableBody = $('#tableBody');
        if ($tableBody.find('tr').length > 3) {
            $tableBody.find('tr:last').remove(); // 마지막 행 삭제

        }
    });
});

*/

// 지역 검색조건 combo loading
function loadBusiAddrCombo() {
	//시도 선택시 지자체(구군) 검색
	comutils.changeCityBjd({
		loading : true,
		citysido: "updtBusiAddr1Hist",
		cityauth: "updtBusiAddr2Hist",
		//citySidoI: "busiAddr1",
		//cityAuthI: "busiAddr2",
		callback: function() {
		},
		init    : function() {
		}
	});
}

$(document).ready(function(){
    loadBusiAddrCombo();
    $("#busiSttDate").toCalendarField( false );
    $("#busiEndDate").toCalendarField( false );
});


