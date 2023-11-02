/**
 * 평가사업관리 리스트 스크립트
 *
 * @author lsz
 * @version 1.0 2018-11-26
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

$(document).ready(function(){
	
	grid();
	
	grid_data(0);
	
	$(".g-search-col input").keydown(function(key) {
		if (key.keyCode == 13) {
			onClickButton('prcBtnSrch');
        }
	});
});


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       	= "#grid";
var GRID_PAGER_NAME 	= "#pager";
var SEARCH_URL      	= ROOT_PATH+"/mng/getEvaluMbrMgmt.do";
var VIEW_URL	  		= ROOT_PATH+"/mng/viewEvaluMbrCommit.do";
var REGI_URL 	   		= ROOT_PATH+"/evalu/openRegiEvaluMgmtSumm.do";
var USE_STAT_MOD_URL 	= ROOT_PATH+"/mng/updateCommUseStat.do";

var END_EVALU_LIST_URL	= ROOT_PATH+"/busi/listEvaluEndBusi.do";

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
    
    //사업의 구분 콤보 change 이벤트 연결.
    bindChangeBusiType();
    
    // 조회조건 입력항목에서 엔터를 했을 때 조회수행되는 이벤트연결
    bindSrchEnterEvent();
}


////////////////////////////////////////////////////////////////////////////////
// Grid 관련
////////////////////////////////////////////////////////////////////////////////

function grid() {
	
	/* dash(-)로 구분되는 날짜 포맷터 */
    ax5.ui.grid.formatter["date"] = function() {
        var date = this.value;
        if(date.length == 8) {
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
        target: $('[data-ax5grid="committee-grid"]'),
        //frozenColumnIndex: 1,
        //frozenRowIndex: 1,
        showLineNumber: false,
        showRowSelector: false,
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
            onClick: function (row) {
            	//console.log(this);
            	//console.log(this.dindex);
            	//console.log(this.item.id);
                //location.href=VIEW_URL;
            	
            	if(row.column.key == "name" || row.column.key == "id") {
            		goView(this.item.id);
            	} else if(row.column.key == "count") {
            		goEndEvaluList(this.item.id);
            	}
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
            	//gridView.setData(this.page.selectPage);
            	grid_data(this.page.selectPage);
            }
        },
        columns: [
	          {key: "idx", label: "번호", align: "center", width: 60},
	          {key: "name", label: "이름", align: "center", width: 80},
	          {key: "id", label: "아이디", align: "center", width: 120},
	          {key: "cate1", label: "분야", align: "left", width: 148},
	          {key: "cate2", label: "세부분야", align: "left", width: 255},
	          {key: "date", label: "등록일", align: "center", width: 100},
	          {key: "phone", label: "연락처", align: "center", width: 120},
	          {key: "count", label: "평가횟수", align: "center", width: 75},
	          {
	        	  key: "stat", label: "승인상태", align: "center", width: 100,
	        	  formatter: function(){
	        		  var rValue = "";
	        		  if(this.value == '10') {
	        			  rValue = "<a onclick='fn_useState(\""+ this.item.id +"\");' style='padding:2px 13px; background:#38b6ab; color:#fff;'>승인대기</a>";
	        		  } else {
	        			  rValue = this.value;
	        		  }
	        		  return rValue;
	        	  }
	          }
	      ]
    });

}



////////////////////////////////////////////////////////////////////////////////
// 그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

function grid_data(page) {
	
	var srchUserId = $("#srchUserId").val();
	//var srchCommit = $("#srchCommit").val();
	var srchUserNm = $("#srchUserNm").val();
	var srchTelNo = $("#srchTelNo").val();
	var srchField = $("#srchField").val();
	
	//params = {"page": page+1, "rows": 10, "srchUserId": srchUserId, "srchCommit": srchCommit, "srchTelNo": srchTelNo};
	params = {"page": page+1, "rows": 10, "srchUserId": srchUserId, "srchUserNm": srchUserNm, "srchTelNo": srchTelNo, "srchField": srchField};
	list = [];
	
	$.ajax({
        url: SEARCH_URL,
        type: "POST",
        data:params, 
        dataType:"json", 
//	            contentType:"application/json; text/html; charset=utf-8",
        success:function(result) {
        	
        	var maxLen = result.pagesize;
        	
        	// 카운트 출력
            $("#girdCnt").text(result.records);
        	
        	//console.log(result.rows.length);
        	
        	for (var i=0; i<result.rows.length; i++) {
        		
        		console.log(result.rows[i]);
        		
        		
        		var index = (1+i)+(page*10);
        		var useStat = result.rows[i].useStat;
        		
        		if(result.rows[i].useStat == '90') {
        			useStat = "승인완료";
        		}
        		
        		list.push({
        			idx: index,
                    name: result.rows[i].userNm,
                    id: result.rows[i].userId,
                    cate1: result.rows[i].fieldNm,
                    cate2: result.rows[i].detailFieldNm,
                    date: result.rows[i].regiDate,
                    count: result.rows[i].evaluCount,
                    phone: result.rows[i].cellNo,
                    stat: useStat,
                });
        	}
        	
        	/* 그리드에 데이터 설정 */
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
                        projectGrid.exportExcel("평가위원 목록.xls");
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

//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    switch( id ) {
        case 'prcBtnSrch':            // 검색
            doSearch();
            break;
        case 'prcBtnRegi':            // 등록
            goRegi();
            break;
    }
}


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

function doSearch(){

	grid_data(0);
}

function goRegi() {
	
	location.href = "/mng/regiEvaluMbrCommit.do";
}

//입력/수정 화면으로 이동
function goView(evaluUserId){
    BIZComm.submit({
        url : VIEW_URL,
        userParam : {
        	evaluUserId : evaluUserId
        }
    });
}

// 승인하기
function fn_useState(user_id) {
	
	var params = {"userId" : user_id, "useStat" : "90"};
	
	// msg : "승인하겠습니까?"
    nConfirm(MSG_EVALU_M023, null, function(isConfirm){
    	if(isConfirm){
    		$.ajax({
    	        url: USE_STAT_MOD_URL,
    	        type: "POST",
    	        data:params,
    	        dataType:"json",
//    		            contentType:"application/json; text/html; charset=utf-8",
    	        success:function(result) {
    	        	
    	        	if(result.result == 1) {
    	        		location.href = "/mng/listEvaluMbrMgmt.do";
    	        	}
    	        }
    		});
    	}
    });
}


// 평가완료사업 화면으로 이동
function goEndEvaluList(evaluUserId){
    BIZComm.submit({
        url : END_EVALU_LIST_URL,
        userParam : {
        	srchEvaluCommit : evaluUserId
        }
    });
}