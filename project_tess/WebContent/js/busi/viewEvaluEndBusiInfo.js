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
	
	//load_check();
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL 		= ROOT_PATH+"/busi/listEvaluBusi.do" ;
var VIEW_URL 		= ROOT_PATH+"/busi/viewEvaluBusiInfo.do" ;
var UPDT_URL		= ROOT_PATH+"/busi/updtEvaluCommitAgree.do" ;
var CHCK_URL		= ROOT_PATH+"/busi/viewEvaluCommitStatus.do" ;
var EVALU_URL		= ROOT_PATH+"/busi/viewEvaluEndInfo.do" ;

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
//그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
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


//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    switch( id ) {
        case 'prcBtnSave':            //저장
            doSave();
            break;
        case 'prcBtnCancle':          //취소
            goList();
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

// 지역 검색조건 combo loading
function loadBusiAddrCombo() {
	//시도 선택시 지자체(구군) 검색
	comutils.changeCityBjd({
		loading : true,
		citysido: "busiAddr1Hist",
		cityauth: "busiAddr2Hist",

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

