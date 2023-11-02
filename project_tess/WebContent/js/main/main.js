/**
 *  메인화면
 *
 * @author SYM
 * @version 1.0 2015-02-12
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

//초기화면 로딩
$(document).ready(function(){
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
    
    // 평가 슬라이드
    $("#stage_slide").slick({
		autoplay: true,
		autoplaySpeed: 7000,
		dots: false,
		infinite: true,
		arrows: false,
		speed: 800,
		slidesToShow: 4,
		adaptiveHeight: true
	});
    
    $("#stage_prev").click(function(){
	  $("#stage_slide").slick('slickPrev');
	});

	$("#stage_next").click(function(){
	  $("#stage_slide").slick('slickNext');
	});
    
    // 자료실 슬라이드
	// 평가 슬라이드
    $("#reference_slide").slick({
		autoplay: false,
		autoplaySpeed: 7000,
		dots: false,
		infinite: true,
		arrows: false,
		speed: 800,
		slidesToShow: 4,
		adaptiveHeight: true
	});
    
    $("#reference_prev").click(function(){
	  $("#reference_slide").slick('slickPrev');
	});

	$("#reference_next").click(function(){
	  $("#reference_slide").slick('slickNext');
	});
	
	
});;
	

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var SEARCH_URL      = ROOT_PATH+"/evalu/getEvaluBudtMgmt.do" ;

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    
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

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
    
    // 조회조건 입력항목에서 엔터를 했을 때 조회수행되는 이벤트연결
    bindSrchEnterEvent();
}


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////


// 지역 검색조건 combo loading
function loadBusiAddrCombo(){
	
    //시도 선택시 지자체(구군) 검색
    comutils.changeCityAuth({
        loading : true,
        citysido: "srchBusiAddr1Temp",
        cityauth: "srchBusiAddr2Temp",
        initcity: "srchBusiAddrVal",
        init    : function(){ 
            
            // hidden 검색조건에 동기화
            setSearchCond();
            
            var srchBusiAddrVal = $("#srchBusiAddr2").val();
            if(isEmpty(srchBusiAddrVal)){
                srchBusiAddrVal = $("#srchBusiAddr1").val();
            }

            if(!isEmpty(srchBusiAddrVal) && srchBusiAddrVal.substring(2,4) == "00"){
                $("#srchBusiAddr2Temp option:eq(1)").attr("selected", "selected");
                $("#srchBusiAddr2Temp").val("");
            }
            
        }
    });
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    switch( id ) {
        case 'prcBtnSrch':            // 검색
            doSearch();
            break;
    }
}

//기능 버튼 클릭이벤트 연결
function bindFuncBtnEvent(){
    
    // ID가 'prcBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=prcBtn]").click(function(){
        onClickButton($(this).attr("id"))
    });
}


// 조회조건 입력항목에서 엔터를 했을 때 조회수행되는 이벤트연결
function bindSrchEnterEvent(){
    $('#srchEvaluBusiNmTemp').keypress(function(e){
        if (e.keyCode == 13) {
            doSearch();
            return false;       // jAlert와 keyCode 사용시 return false 해줘야함.
        }
    });
}


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

// 검색 수행
function doSearch(){
    
    fn_search(1);
}

//hidden 검색조건에 동기화
function setSearchCond(){
    
	$("#evaluStage" ).val($("#srchEvaluStageTemp" ).val());
    $("#srchBusiAddr1" ).val($("#srchBusiAddr1Temp" ).val());
    $("#srchBusiAddr2" ).val($("#srchBusiAddr2Temp" ).val());
    $("#srchEvaluBusiNm").val($("#srchEvaluBusiNmTemp").val());
    $("#srchFinalEvaluFnd").val($("#srchFinalEvaluFndTemp").val());
    
    var srchBusiAddrVal = $("#srchBusiAddr2").val();
    if(isEmpty(srchBusiAddrVal)){
        srchBusiAddrVal = $("#srchBusiAddr1").val();
    }
    $("#srchBusiAddrVal").val(srchBusiAddrVal);
}

function fn_search(page) {
	
	
	var evaluStageObj = $("#srchEvaluStageTemp");
	var evaluBusiNmObj = $("#srchEvaluBusiNmTemp");
	
		
	if(evaluStageObj.attr("id") == "srchEvaluStageTemp"){
		if( isEmpty(evaluStageObj.val())){
			msgAlert("평가단계를 선택해주세요", evaluStageObj);
			return false;
		}
	}
	
//	if(evaluBusiNmObj.attr("id") == "srchEvaluBusiNmTemp"){
//		if( isEmpty(evaluBusiNmObj.val())){
//			msgAlert("사업명을 입력해주세요", evaluBusiNmObj);
//			return false;
//		}
//	} 
	
    //hidden 검색조건에 동기화
    setSearchCond();
	
    // submit
    BIZComm.submit({
        url    : ROOT_PATH+"/evalu/listEvaluBudtMgmt.do",
    });
	
}


/**
 * 게시물을 조회한다.
 * 
 * @param bbsType {String} 게시물 구분
 * @param bbsNo {String} 게시물 번호
 */
function viewCustBbs(bbsType, bbsNo) {
    var url = "";
    
    switch (bbsType) {
        case "B01":
            url = "/bbs/viewBbsNotice.do";
            break;
        case "B02":
            url = "/bbs/viewBbsQna.do";
            break;
        case "B03":
            url = "/bbs/listBbsFaq.do"; 
            break;
        default: 
        var bbsId = $(bbsType).parent().find(".active ").attr("id");
 
        switch (bbsId) {
        case "B01":
            url = "/bbs/listBbsNotice.do";
            break;
        case "B02":
            url = "/bbs/listBbsQna.do";
            break;
        case "B03":
            url = "/bbs/listBbsFaq.do"; 
            break;
        }
           
        window.location.href = ROOT_PATH + url;
    }
    
    if (url) {
        var param = "?bbs_type=" + bbsType + "&bbs_no=" + bbsNo;
        
        window.location.href = ROOT_PATH + url + param;
    }
}

/**
 * 게시물을 조회한다.
 * 
 * @param bbsType {String} 게시물 구분
 * @param bbsNo {String} 게시물 번호
 */
function viewEvaluData(evaluStage, evaluNo) {
    var url = "";
    
    
    if(evaluStage){
    	url = "/evalu/viewEvaluBudtMgmt2.do";
    	var param = "?evaluStage=" + evaluStage + "&evaluBusiNo=" + evaluNo;
    }else{
    	url = "/additionals/viewCase.do";
    	var param = "?case_no=" + evaluNo;
    }
    
    if (url) {
        window.location.href = ROOT_PATH + url + param;
    }
}

function btnPlus(){
	var url = "/additionals/listExcelntCase.do";

	if($("#evaleBoard1").attr("class") == "active") {
		url = "/evalu/listEvaluBudtMgmt.do";
	}
    
    window.location.href = ROOT_PATH + url;
}

function login_check() {
	jAlert("로그인 후 이용가능합니다.");
}

function busi_search() {
	
	var frm = $("#mainForm");
	
	// submit
    BIZComm.submit({
        url    : ROOT_PATH+"/busi/listEvaluBusi.do",
        userParam: {
        	srchBusiAddr1 : $("#srchBusiAddr1Temp option:selected").val(),
        	srchBusiAddr2 : $("#srchBusiAddr2Temp option:selected").val(),
        	srchEvaluGubun : $("#newEvalYear option:selected").val(),
        	srchEvaluStage : $("#srchEvaluStageTemp option:selected").val(),
        	srchEvaluBusiNm : $("#srchEvaluBusiNmTemp").val(),
        	srchEvaluCommitNm : $("#srchEvaluCommitNmTemp").val()
        }
    });
	
	
};





