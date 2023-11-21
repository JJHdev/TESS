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
    
	// 테스트 생성
	comutils.makeEvlIxList({
	    id: 'test',
	    evaluYear: 2023,
	    evaluStage: 'EVALU_PREV',
		mode: 'REGI'
	});

	// 테스트 생성
	comutils.makeEvlIxList({
		id: 'test2',
		evaluYear: 2023,
		evaluStage: 'EVALU_PREV',
		mode: 'REGI'
	});
}


$(document).ready(function(){
	
	//load_check();
	
	$(".select-committee li").click(function(){
		var index = $(this).index();
		
		$(".select-committee li").removeClass("active");
		$(".select-committee li").eq(index).addClass("active");
		
		$("#commit_table_list table").css("display", "none");
		$("#commit_table_list table").eq(index).css("display", "inline-table;");
	});

});

function openTab(evt, tabName) {
	// 기본 동작 방지 및 이벤트 버블링 중지
	evt.preventDefault();
	evt.stopPropagation();
  
	// 모든 탭 내용 숨기기
	var i, tabcontent, tablinks;
	tabcontent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabcontent.length; i++) {
	  tabcontent[i].style.display = "none";
	}
  
	// 모든 탭 링크 비활성화
	tablinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tablinks.length; i++) {
	  tablinks[i].className = tablinks[i].className.replace(" active", "");
	}
  
	// 클릭된 탭의 내용을 보여주고 탭 링크를 활성화
	document.getElementById(tabName).style.display = "block";
	evt.currentTarget.className += " active";
  }

  window.onload = function() {
    // 탭 A의 내용을 자동으로 표시
    document.getElementById("TabA").style.display = "block";
    // 탭 A 링크에 'active' 클래스 추가
    var tabAButton = document.querySelector('.tablinks');
    if (tabAButton) {
        tabAButton.classList.add('active');
    }
};
////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL 		= ROOT_PATH+"/busi/listEvaluBusi.do" ;
var VIEW_URL 		= ROOT_PATH+"/busi/viewEvaluBusiInfo.do" ;
var UPDT_URL		= ROOT_PATH+"/busi/updtEvaluCommitAgree.do" ;
var CHCK_URL		= ROOT_PATH+"/busi/viewEvaluCommitStatus.do" ;
var EVALU_URL		= ROOT_PATH+"/busi/viewEvaluInfoStep01.do" ;
var BUSI_URL		= ROOT_PATH+"/busi/viewEvaluEndBusiInfo.do" ;

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

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

//목록으로 이동 
function goList(){
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}

//사업정보 이동
function fn_goBusiInfo() {
	
	BIZComm.submit({
        url : BUSI_URL
        /*userParam : {
            evaluBusiNo : evaluBusiNo,
            evaluStage : evaluStage,
            evaluUserId : evaluUserId
        }*/
    });
}

