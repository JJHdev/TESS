/**
 * 평가사업관리 리스트 스크립트
 *
 * @author lsz
 * @version 1.0 2018-11-26
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

function loadInitPage(){
	
	grid();
	
	grid_data();
    
    // 데이터를 로드한다.
    loadData();
}


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var LIST_URL      	= ROOT_PATH+"/mng/listEvaluEnvIndex.do" ;
var SEARCH_URL      = ROOT_PATH+"/mng/getEvaluEnvIndex.do" ;
var REGI_URL 	   	= ROOT_PATH+"/mng/regiEvaluEnvIndex.do";
var UPDT_URL		= ROOT_PATH+"/mng/updtEvaluEnvIndex.do";
var DELT_URL		= ROOT_PATH+"/mng/deltEvaluEnvIndex.do";

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

    /* 그리드 설정 지정 */
    projectGrid.setConfig({
        target: $('[data-ax5grid="committee-grid"]'),
        /*frozenColumnIndex: 3,
        frozenRowIndex: 2,*/
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
            columnHeight: 26,
            onDataChanged: function () {
                if (this.key == 'isChecked') {
                    this.self.updateChildRows(this.dindex, {isChecked: this.item.isChecked});
                }
                else if(this.key == '__selected__'){
                    this.self.updateChildRows(this.dindex, {__selected__: this.item.__selected__});
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

            }
        },
        columns: [
          {
              key: "code",
              label: "코드",
              width: 200,
              /*styleClass: function () {
                  return "ABC";
              },*/
              enableFilter: true,
              align: "left",
              treeControl: true
          },
          {key: "codeNm", label: "코드명", align: "left", width: 200},
          {key: "column1", label: "추가컬럼", align: "center"},
          {key: "column2", label: "추가컬럼2", align: "center"},
          {key: "column3", label: "추가컬럼3", align: "center"},
          {key: "codeOdr", label: "순서", align: "center", width: 80},
          {key: "useYn", label: "사용여부", align: "center", width: 80},
          {
        	  key: "modfy", label: "기능", align: "center", width: 150,
        	  formatter: function() {
        		  console.log(this.value);
        		  
        		  return this.value;
        	  }
          }
      ],
      tree: {
          use: true,
          indentWidth: 10,
          arrowWidth: 15,
          iconWidth: 18,
          icons: {
              openedArrow: '<i class="fa fa-caret-down" aria-hidden="true"></i>',
              collapsedArrow: '<i class="fa fa-caret-right" aria-hidden="true"></i>',
              groupIcon: '<i class="fa fa-folder-open" aria-hidden="true"></i>',
              collapsedGroupIcon: '<i class="fa fa-folder" aria-hidden="true"></i>',
              itemIcon: '<i class="fa fa-circle" aria-hidden="true"></i>'
          },
          columnKeys: {
              parentKey: "parentCode",
              selfKey: "code"
          }
      }
    });
    
    /*var sampleData = [
	      {id: 0, name: "Thomas Jang", price: 1000, amount: null, saleDt: "2016-08-29", customer: "장기영", saleType: "A", isChecked: "N"},
	      {pid: "0", id: "2", name: "Seowoo", price: 1100, amount: 11, saleDt: "2016-08-28", customer: "장서우", saleType: "B", isChecked: "N"},
	      {pid: "0", id: "3", name: "Mondo", price: 1200, amount: 10, saleDt: "2016-08-27", customer: "이영희", saleType: "A", isChecked: "N"},
	      {pid: "0", id: "4", name: "Brant", price: 1300, amount: 8, saleDt: "2016-08-25", customer: "황인서", saleType: "C", isChecked: "N"},
	      {pid: "4", id: "5", name: "Tiffany", price: 1500, amount: 2, saleDt: "2016-08-26", customer: "이서연", saleType: "A", isChecked: "N"},
	      {pid: "5", id: "6", name: "Edward", price: 1400, amount: 5, saleDt: "2016-08-29", customer: "황세진", saleType: "D", isChecked: "N"},
	      {pid: "6", id: "7", name: "Bill", price: 1400, amount: 5, saleDt: "2016-08-29", customer: "이하종", saleType: "B", isChecked: "N"},
	      {id: "8", name: "Aeei", price: 1400, amount: 5, saleDt: "2016-08-29", customer: "김혜미", saleType: "C", isChecked: "N"}
	  ];
    
    
    projectGrid.setData(sampleData);*/
}

////////////////////////////////////////////////////////////////////////////////
// 그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

function grid_data() {
	
	var srchEvaluStageTemp = $("#srchEvaluStageTemp").val();
	var srchEvaluIndicatTemp = $("#srchEvaluIndicatTemp").val();
	var srchEvaluIndicatNmTemp = $("#srchEvaluIndicatNmTemp").val();
	
	params = {"srchEvaluStage" : srchEvaluStageTemp, "srchEvaluIndicat" : srchEvaluIndicatTemp, "srchEvaluIndicatNm" : srchEvaluIndicatNmTemp};
	list = [];
	
	$.ajax({  
        url: SEARCH_URL,
        type: "POST",
        data:params, 
        dataType:"json", 
//	            contentType:"application/json; text/html; charset=utf-8",
        success:function(result) {
        	
        	var reusltList = result.evaluEnvIndexList;
        	var maxLen = reusltList.length;
        	
        	// 카운트 출력
            $(".grid-count strong").text(reusltList.length);
        	console.log(reusltList);
        	
        	for (var i=0; i<maxLen; i++) {
        		
        		if(reusltList[i].parentCode == "NONE") {
        			list.push({
        				code: reusltList[i].code,
        				codeNm: reusltList[i].codeNm,
        				column1: null,
        				column2: null,
        				column3: null,
        				codeOdr: reusltList[i].codeOdr,
        				useYn: reusltList[i].useYn,
        				collapse: true
                    });
        		} else {
        			list.push({
        				parentCode: reusltList[i].parentCode,
        				code: reusltList[i].code,
        				codeNm: reusltList[i].codeNm,
        				column1: null,
        				column2: null,
        				column3: null,
        				codeOdr: reusltList[i].codeOdr,
        				useYn: reusltList[i].useYn,
        				modfy: '<button onclick="goMod(\'' +reusltList[i].code+ '\',\'' +reusltList[i].codeNm+ '\',\'' +reusltList[i].parentCode+ '\',\'' +reusltList[i].useYn+ '\');" class="modfy_btn inline-button confirm">수정</button><button onclick="del_func(\'' +reusltList[i].code+ '\');" class="modfy_btn inline-button black">삭제</button>',
        				collapse: true
                    });
        		}
        	}
        	
        	// 그리드에 데이터 설정 
            projectGrid.setData(list);
        }
	});
}


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

//지역 검색조건 combo loading
function loadBusiAddrCombo(){
    
	var srchEvaluStageTempObj = $("#srchEvaluStageTemp");
	var srchEvaluIndicatTempObj = $("#srchEvaluIndicatTemp");
	
	srchEvaluStageTempObj.change(function(){
        
		srchEvaluIndicatTempObj.emptySelect();
        
        if(!isEmpty(srchEvaluStageTempObj.val())) {
            bizutils.findCode({
                params: {parentCode:srchEvaluStageTempObj.val(), mode: "evaluCd"},
                fn    : function(result){
                    
                    // '세부시설 유형' 콤보 구성.
                    if(result != null && srchEvaluIndicatTempObj.size() == 1) {
                    	srchEvaluIndicatTempObj.loadSelect(result);
                    }
                }
            });
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
        case 'prcBtnRegi':            // 등록
            goRegi();
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
    $('#srchEvaluIndicatNmTemp').keypress(function(e){
        if (e.keyCode == 13) {
            doSearch();
            return false;       // jAlert와 keyCode 사용시 return false 해줘야함.
        }
    });
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

function doSearch(){

	grid_data();
}

function goRegi() {
	$(".regi_popup").bPopup({
		modalClose: false
	});
}

function popup_close(class_name) {
	$("." + class_name).bPopup().close();
}

function regi_func() {
	
	var regi_code = $("#regiCode").val();
	var regi_codeNm = $("#regiCodeNm").val();
	var regi_useYn = $("#regiUseYn option:selected").val();
	var regi_parentCode = $("#regiParentCode").val();
	
	params = {"parentCode": regi_parentCode, "code": regi_code, "codeNm": regi_codeNm, "useYn": regi_useYn};
	
	$.ajax({  
        url: REGI_URL,
        type: "POST",
        data:params, 
        dataType:"json", 
//	            contentType:"application/json; text/html; charset=utf-8",
        success:function(result) {
        	
        	alert("등록되었습니다.");
        	
        	window.location.href = LIST_URL;
        }
	});
};

function goMod(code, codeNm, parentCode, useYn) {
	
	$("#modCode").val(code);
	$("#modCodeNm").val(codeNm);
	$("#modUseYn").val(useYn).prop("selected", true);
	$("#modParentCode").val(parentCode);
	
	$(".mod_popup").bPopup({
		modalClose: false
	});
};

function mod_func() {
	
	var mod_code = $("#modCode").val();
	var mod_codeNm = $("#modCodeNm").val();
	var mod_useYn = $("#modUseYn option:selected").val();
	var mod_parentCode = $("#modParentCode").val();
	
	params = {"parentCode": mod_parentCode, "code": mod_code, "codeNm": mod_codeNm, "useYn": mod_useYn};
	
	$.ajax({  
        url: UPDT_URL,
        type: "POST",
        data:params, 
        dataType:"json", 
//	            contentType:"application/json; text/html; charset=utf-8",
        success:function(result) {
        	
        	alert("수정되었습니다.");
        	
        	window.location.href = LIST_URL;
        }
	});
}

function del_func(code) {
	
	params = {"code" : code};
	
	var confirm_message = confirm("정말 삭제하시겠습니까?");
	if(confirm_message) {
		$.ajax({  
	        url: DELT_URL,
	        type: "POST",
	        data:params, 
	        dataType:"json", 
//		            contentType:"application/json; text/html; charset=utf-8",
	        success:function(result) {
	        	
	        	alert("삭제되었습니다.");
	        	
	        	window.location.href = LIST_URL;
	        }
		});
	}
};
