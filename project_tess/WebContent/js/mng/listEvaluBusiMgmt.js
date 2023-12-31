/**
*******************************************************************************
***    명칭: listEvaluBusiMgmt.js
***    설명: [관리자] 평가사업관리 > 평가이력 화면 스크립트
***
***    -----------------------------    Modified Log   ------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0      2023.11.10      LHB     First Coding.
*******************************************************************************
**/

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME = "#grid";
var GRID_PAGER_NAME = "#pager";
var SEARCH_URL = ROOT_PATH + "/mng/getListEvaluBusiMgmt.do";
var VIEW_URL = ROOT_PATH + "/mng/viewEvaluBusiMgmtHist.do";
var REGI_URL = ROOT_PATH + "/mng/regiEvaluBusiMgmt.do";

/* 그리드 객체 생성 */
var projectGrid = new ax5.ui.grid();
var list = [];

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



$(document).ready(function () {
    grid();
    // 그리드 조회
    grid_data(0, null);
    // 연도 생성
    //getYearList();
    // 시군구 데이터 조회
    getSidoGunguList('i-search-sido1');
	getSidoGunguList('i-search-sido2');

    // 조회조건 입력항목에서 엔터를 했을 때 조회수행되는 이벤트연결
    $('#search-busiName, #search-busiCode').keypress(function(e){
        if (e.keyCode == 13) {
            search_btn(0);
            return false;       // jAlert와 keyCode 사용시 return false 해줘야함.
        }
    });
});


var $mobileFlag;
var $lnbFlag = false;

$(document).ready(function () {
    var resizeTimer;
    $(window).on('resize', function (e) {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function () {
            // Run code here, resizing has "stopped"
            //$(document).load($(window).bind("resize", lnbScroll));
            if ($mobileFlag) {
                lnbScroll();
            }
        }, 250);
    });
    // JQuery init
});

function lnbScroll() {
    //alert($lnbFlag);
    if ($(window).width() < 767) {
        $mobileFlag = true;
        if (!$lnbFlag) {
            $(document).find('.lnb .evtdss-localmenu li').css('display', 'block');
            $(document).find('.lnb .evtdss-localmenu li.active a').css('background-color', '#15a498');
            $lnbFlag = true;
        } else {
            $(document).find('.lnb .evtdss-localmenu li').css('display', 'none');
            $(document).find('.lnb .evtdss-localmenu li.active').css('display', 'block');
            $(document).find('.lnb .evtdss-localmenu li.active a').css('background-color', 'transparent');
            $lnbFlag = false;
        }
    } else {
        $mobileFlag = false;
        $(document).find('.lnb .evtdss-localmenu li').removeAttr("style");
        $(document).find('.lnb .evtdss-localmenu li.active').removeAttr("style");
        $(document).find('.lnb .evtdss-localmenu li.active a').removeAttr("style");
        $lnbFlag = false;
    }
}

var nowArgs;
$.searchSlider = function (args) {

    switch (args) {
        case 'headingOne'    :
            if (args == nowArgs) {
                $(document).find('#headingOne').removeClass('active');
                nowArgs = '';
            } else {
                $(document).find('.o-search-col').removeClass('active');
                $(document).find('#headingOne').addClass('active');
                nowArgs = 'headingOne';
            }
            break;
        case 'headingTwo'   :
            if (args == nowArgs) {
                $(document).find('#headingTwo').removeClass('active');
                nowArgs = '';
            } else {
                $(document).find('.o-search-col').removeClass('active');
                $(document).find('#headingTwo').addClass('active');
                nowArgs = 'headingTwo';
            }
            break;
        case 'headingThree'  :
            if (args == nowArgs) {
                $(document).find('#headingThree').removeClass('active');
                nowArgs = '';
            } else {
                $(document).find('.o-search-col').removeClass('active');
                $(document).find('#headingThree').addClass('active');
                nowArgs = 'headingThree';
            }
            break;
        case 'headingFour'  :
            if (args == nowArgs) {
                $(document).find('#headingFour').removeClass('active');
                nowArgs = '';
            } else {
                $(document).find('.o-search-col').removeClass('active');
                $(document).find('#headingFour').addClass('active');
                nowArgs = 'headingFour';
            }
            break;
        default    :
            //document.write('해당 숫자가 없습니다.<br />');
            nowArgs = '';
            break;
    }
}

var collapsable_flag = true;
$.collapsable = function (trg, cmd) {
    switch (cmd) {
        case 'show' :
            if (!collapsable_flag) {
                //$(document).find(trg).removeClass( 'noHight' );
                $(document).find(trg).slideDown("fast");
                $(document).find('.collapsable-showMe').addClass('silent');
                $(document).find('.collapsable-btn').removeClass('silent');
                collapsable_flag = true;
            }
            break;
        case 'hide' :
            if (collapsable_flag) {
                //$(document).find(trg).addClass('noHight');
                $(document).find(trg).slideUp("fast");
                $(document).find('.collapsable-showMe').removeClass('silent');
                $(document).find('.collapsable-btn').addClass('silent');
                collapsable_flag = false;
            }
            break;
        default     :
            console.log('noway to target');
            break;

    }
}

// 검색조건 저장변수(한글)

var searchStartYear = "전체";   // 시작연도
var searchEndYear   = "전체";     // 종료연도
var searchSido      = "전체";        // 시도
var searchGungu     = "전체";       // 구군구
var searchBusiType  = "전체";    // 사업구분
var searchBusiCate  = "전체";    // 사업유형
var searchBusiCode  = "전체";    // 사업코드
var searchBusiName  = "전체";    // 사업명

// 검색조건 저장변수(코드)
var paramStartYear = "";   // 시작연도
var paramEndYear = "";     // 종료연도
var paramSido = "";        // 시도
var paramGungu = "";       // 구군구
var paramBusiType = "";    // 사업구분
var paramBusiCate = "";    // 사업유형
var paramBusiCode = "";    // 사업코드
var paramBusiName = "";    // 사업명


// 시작연도 범위
var sYear1 = 2006;
var sYear2 = 2018;

// 종료연도 범위
var eYear1 = 2013;
var eYear2 = 2024;

// 연도 생성
function getYearList() {

    // 시작연도
    $("#i-search-sYear").empty();
    $("#i-search-eYear").empty();

    // 전체 선택 추가
    $("#i-search-sYear").append('<div class="i-search-item selected"><a title="전체" onclick="selectStartYear(this, \'\', \'전체\')">시작연도 전체</a></div>');
    $("#i-search-eYear").append('<div class="i-search-item selected"><a title="전체" onclick="selectEndYear(this, \'\', \'전체\')">종료연도 전체</a></div>');

    // 시작연도
    for (var i = sYear1; i <= sYear2; i++) {
        $("#i-search-sYear").append('<div class="i-search-item"><a title="전체" onclick="selectStartYear(this, \'' + i + '\', \'' + i + '\')">' + i + '</a></div>');
    }

    // 종료연도
    for (var i = eYear1; i <= eYear2; i++) {
        $("#i-search-eYear").append('<div class="i-search-item"><a title="전체" onclick="selectEndYear(this, \'' + i + '\', \'' + i + '\')">' + i + '</a></div>');
    }

}

function searchConditionUpdate(){

    if( searchStartYear != '전체' || searchEndYear != '전체') {
        $("#search_year").empty();
        $("#search_year").append('[연도] &nbsp;' + searchStartYear + '-' + searchEndYear);
    } else if ( searchStartYear == '전체' || searchStartYear == '전체'){
        $("#search_year").empty();
        $("#search_year").append('[연도] &nbsp;전체');
    }
    if( searchSido == '전체') {
        $("#search_area").empty();
        $("#search_area").append('[지역] &nbsp;전체');
    }else {
        $("#search_area").empty();
        $("#search_area").append('[지역] &nbsp;' + searchSido + '>' + searchGungu);
    }
    if( searchBusiType == '전체') {
        $("#search_type").empty();
        $("#search_type").append('[유형] &nbsp;전체');
    } else {
        $("#search_type").empty();
        $("#search_type").append('[유형] &nbsp;' + searchBusiType + '>' + searchBusiCate);
    }

}


// (단일)선택 처리
function singleSelected(view, className) {
    $(view).parent().parent().find('.i-search-item').removeClass(className)
    $(view).parent().addClass(className)
}

// (다중)선택멀티
function multiSelected(view, className) {
    $(view).parent().parent().find('.i-search-item').removeClass(className)
    $(view).parent().addClass(className)
}

// 시작 연도선택
function selectStartYear(view, code, name) {
    console.log('selectStartYear');
    paramStartYear = code;
    searchStartYear = name;
    singleSelected(view, 'selected');
    searchConditionUpdate();
}

// 종료 연도선택
function selectEndYear(view, code, name) {
    console.log('selectEndYear');
    paramEndYear = code;
    searchEndYear = name;
    singleSelected(view, 'selected');
    searchConditionUpdate();
}


// 시도 선택 이벤트
function selectSido(view, code, name){
    // 변수에 저장
    paramSido = code
    searchSido = name;
    // view 선택처리
    singleSelected(view, 'active')
    // 전체 선택이 아닌 경우만 조회한다.
    if (code != null && code != '') {
        // 선택한 시도를 기준으로 시군구 리스트 조회
        getSidoGunguList('i-search-gungu', code);
    } else{
        // 전체선택인 경우 전체하나만 추가
        $('#i-search-gungu').empty();
        $('#i-search-gungu').append('<div class="i-search-item selected"><a onclick="selectGungu( this, \'\', \'전체\')"  title="전체">전체</a></div>')
    }
    // 검색조건 업데이트
    searchConditionUpdate()
}
// 시군구 선택 이벤트
function selectGungu(view, code, name){
    // 변수에 저장
    paramGungu = code;
    searchGungu = name;
    // view 선택처리
    singleSelected(view, 'selected')
    // 검색조건 업데이트
    searchConditionUpdate()
}

/**
 * 시도/시군구 코드 조회
 *
 * @param viewId 생성되는 뷰
 * @param paramCode 조회되는 데이터 코드
 * @param selectCode 선택되는 상위 코드
 * @param paramName
 */
function getSidoGunguList(viewId, selectCode) {

    var view = $("#"+ viewId);
    // 초기화
    view.empty();
    //함수명
    var fnName = 'selectSido';
    // select Class
    var sClass = 'active';

    var params = {parentCode: "COMM.CITYAUTH"}
    if (selectCode != null && selectCode != '') {
        params = {parentCode: "COMM.CITYAUTH", addCol1: selectCode};
        fnName = 'selectGungu';
        sClass = 'selected';
        // 선택 초기화
        searchGungu = '전체';
        paramGungu = '';
    }

    //공통코드 AJAX
    bizutils.findCode({
        params: params,
        fn: function (result) {
            if (result != null) {
                // 전체 선택 추가
                view.append('<div class="i-search-item ' + sClass + '"><a onclick="' + fnName + '( this,\'\' ,\'전체\')"  title="전체">전체</a></div>')
                // 선택리스트 추가
                if( result.length > 1) {
                    $.each(result, function () {
                        var code = this.code
                        var name = this.codeNm;
                        view.append('<div class="i-search-item"><a onclick="' + fnName + '( this, \'' + code + '\', \'' + name + '\' )" title="' + name + '">' + name + '</a></div>')
                    })
                }
            }
        }
    });

}


function getBusiCateList(viewId, selectCode){

    var view = $("#"+ viewId);
    // 초기화
    view.empty();
    //함수명
    var fnName = 'selectBusiCate';
    // select Class
    var sClass = 'selected';
    // 선택 초기화
    searchBusiCate = '전체';
    paramBusiCate = '';
    // 사업유형 데이터 조회
    bizutils.findCode({
        params: {parentCode: selectCode},
        fn: function (result) {
            view.append('<div class="i-search-item ' + sClass + '"><a onclick="' + fnName + '( this,\'\' ,\'전체\')"  title="전체">전체</a></div>')
            // 선택리스트 추가
            if( result != null && result.length > 1) {
                $.each(result, function () {
                    var code = this.code
                    var name = this.codeNm;
                    view.append('<div class="i-search-item"><a onclick="' + fnName + '( this, \'' + code + '\', \'' + name + '\' )" title="' + name + '">' + name + '</a></div>')
                })
            }
        }
    });
}



// 회계구분 선택
function selectBusiType(view, code, name){
    // 변수에 저장
    paramBusiType = code;
    searchBusiType = name;
    // view 선택처리
    singleSelected(view, 'active');
    if ( code != null && code != '') {
        getBusiCateList("i-search-busiCate", code)
    }
    //검색조건 업데이트
    searchConditionUpdate()
}

// 사업유형선택
function selectBusiCate(view, code, name){
    // 변수에 저장
    paramBusiCate = code;
    searchBusiCate = name;
    // view 선택처리
    singleSelected(view, 'selected');
    // 검색조건 업데이트
    searchConditionUpdate()
}


/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {

    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();

    //사업의 구분 콤보 change 이벤트 연결.
    bindChangeBusiType();
}


////////////////////////////////////////////////////////////////////////////////
// Grid 관련
////////////////////////////////////////////////////////////////////////////////

function grid() {

    /* dash(-)로 구분되는 날짜 포맷터 */
    ax5.ui.grid.formatter["date"] = function () {
        var date = this.value;
        if (date.length == 8) {
            return date.substr(0, 4) + "-" + date.substr(4, 2) + "-" + date.substr(6);
        } else {
            return date;
        }
    };
    
    ax5.ui.grid.tmpl.page_status = function(){
        return '<span>{{{progress}}} {{fromRowIndex}} - {{toRowIndex}} of {{dataRowCount}} {{#dataRealRowCount}}  현재페이지 {{.}}{{/dataRealRowCount}} {{#totalElements}}  전체갯수 {{.}}{{/totalElements}}</span>';
    };

    /* 그리드 설정 지정 */
    projectGrid.setConfig({
        target: $('[data-ax5grid="project-grid"]'),
        //frozenColumnIndex: 1,
        //frozenRowIndex: 1,
        showLineNumber: false,
        showRowSelector: true,
        multipleSelect: true,
        lineNumberColumnWidth: 40,
        rowSelectorColumnWidth: 27,
        sortable: true, // 모든 컬럼에 정렬 아이콘 표시
        multiSort: false, // 다중 정렬 여부
        header: {
            align: "center",
            columnHeight: 40
        },
        body: {
            trStyleClass: function () {
                return this.item.amount > 100 ? "gray" : "";
            },
            mergeCells: true,
            align: "center",
            columnHeight: 28,
            onClick: function () {
				// 2023.11.07 LHB 클릭 번호 EVALU_BUSI_SN 컬럼으로 변경
                goView(this.item.evaluBusiSn);
            },
            onDBLClick: function () {
            }
        },
        page: {
            navigationItemCount: 9,
            height: 30,
            display: true,
            firstIcon: '<i class="fa fa-step-backward" aria-hidden="true"></i>',
            prevIcon: '<i class="fa fa-caret-left" aria-hidden="true"></i>',
            nextIcon: '<i class="fa fa-caret-right" aria-hidden="true"></i>',
            lastIcon: '<i class="fa fa-step-forward" aria-hidden="true"></i>',
            onChange: function () {
            	search_btn(this.page.selectPage);
            }
        },
        columns: [
			{key: "idx", label: "번호", align: "center", width: 60},
			{key: "busiMbyAddr", label: "시행주체", align: "left", width: 170},
			{key: "busiAddr", label: "대상지역", align: "left", width: 170},
			{key: "evaluBusiNm", label: "사업명", align: "left", width: 530},
			{key: "regiDate", label: "등록일", align: "left", width: 100},
            //{key: "money", label: "사업비(백만원)", formatter: "money", align: "right", width: 123},
            //{key: "startYear", label: "시작연도", align: "center", width: 80},
            //{key: "endYear", label: "종료연도", align: "center", width: 80}
        ]
    });

}


////////////////////////////////////////////////////////////////////////////////
// 그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

function grid_data(page, params) {
	
    if(params == null) {
        params = {"page": page+1, "rows": 10};
    } else {
    	params = {
    		"page": page+1, "rows": 10, "srchBusiAddr1": params.srchBusiAddr1, "srchBusiAddr2": params.srchBusiAddr2, 
	   	    "srchBusiCate": params.srchBusiCate, "srchBusiCode": params.srchBusiCode, "srchBusiEndDate": params.srchBusiEndDate,
      		"srchBusiSttDate": params.srchBusiSttDate, "srchBusiType": params.srchBusiType, "srchTodeBusiNm": params.srchTodeBusiNm
      	};
    }

    list = [];

    $.ajax({
        url: SEARCH_URL,
        type: "POST",
        data: params,
        dataType: "json",
//	            contentType:"application/json; text/html; charset=utf-8",
        success: function (result) {
        	
        	console.log("result : " + result);
        	
            var maxLen = result.pagesize;
            
            // 카운트 출력
            $("#girdCnt").text(result.records);

            console.log(result);
            console.log(result.rows.length);

            for (var i=0; i<result.rows.length; i++) {
            	
            	//var index = (1+i)+(page*10);
            	var index = (result.records-i)-(page*10);
            	
            	var sttYear = "";
            	var endYear = "";
            	
            	if(result.rows[i].convBusiSttDate == null || result.rows[i].convBusiSttDate == "") {
            		sttYear = "";
            	} else {
            		sttYear = result.rows[i].convBusiSttDate.substring(0,5);
            	}
            	
            	if(result.rows[i].convBusiEndDate == null || result.rows[i].convBusiEndDate == "") {
            		endYear = "";
            	} else {
            		endYear = result.rows[i].convBusiEndDate.substring(0,5);
            	}
            	
                list.push({
                    idx: index,									// 번호
					evaluBusiSn: result.rows[i].evaluBusiSn,	// 키값
					evaluBusiNm: result.rows[i].evaluBusiNm,	// 사업명
                    busiMbyAddr: result.rows[i].busiMbyAddr,	// 시행주체
					busiAddr: result.rows[i].busiAddr,			// 대상지역
					regiDate: result.rows[i].regiDate,			// 등록일
                });
            }

            //그리드에 데이터 설정 
            projectGrid.setData({
            	list: list,
            	page: {
            		currentPage: page,
                    pageSize: result.pageSize,
                    totalElements: result.records,
                    totalPages: result.total
            	}
            });
            
            // grid control button
            $('[data-grid-control]').click(function () {
                switch (this.getAttribute("data-grid-control")) {
                    case "excel-export":
                        projectGrid.exportExcel("grid-to-excel.xls");
                        break;
                    case "excel-string":
                        console.log(projectGrid.exportExcel());
                        break;
                }
            });
        }
    });
}


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

function search_btn(page) {

    var param = new Object();

    param.srchBusiSttDate = paramStartYear;
    param.srchBusiEndDate = paramEndYear;
    param.srchBusiAddr1 = paramSido;
    param.srchBusiAddr2 = paramGungu;
    param.srchBusiType = paramBusiType;
    param.srchBusiCate = paramBusiCate;

    // param 추가

    param.srchBusiCode = $("#search-busiCode").val();
    param.srchTodeBusiNm = $("#search-busiName").val();

    grid_data(page, param);
}


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

//상세페이지 화면으로 이동
function goView(evaluBusiSn) {
    BIZComm.submit({
        url: VIEW_URL,
        userParam: {
            evaluBusiSn: evaluBusiSn
        }
    });
}

////////////////////////////////////////////////////////////////////////////////
$(function() {
    $('[data-grid-control="open-mgtn"]').click(function(event) {
        event.preventDefault();
        regMgtn();
    });
});

function regMgtn() {
    let f = document.createElement('form');
    f.setAttribute('method', 'post');
    f.setAttribute('action', REGI_URL);
    document.body.appendChild(f);
    f.submit();
    return false;
}