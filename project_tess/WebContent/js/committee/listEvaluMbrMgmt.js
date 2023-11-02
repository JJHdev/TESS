/**
 * 사업평가관리 리스트 화면
 *
 * @author SYM
 * @version 1.0 2015-02-12
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

/**
 * todeComm.js에서 자동 호출하는 함수 (페이지 초기 설정 관련 수행)
 * 
 */
function loadInitPage(){
	
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
}


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var SEARCH_URL    = ROOT_PATH + "/committee/getEvaluMbrMgmt.do" ;
var REGI_URL		= ROOT_PATH + "/committee/viewEvaluMbrCommit.do"; 

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
    
    var srchFieldVal = $("#srchFieldDetail").val();
    if(isEmpty(srchFieldVal)){
    	srchFieldVal = $("#srchFieldType").val();
    }
    $("#srchFieldVal").val(srchFieldVal);
 
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
    
    //사업의 구분 콤보 change 이벤트 연결.
    bindChangeBusiType();
    
    bindChangeFieldType();
    
    // 조회조건 입력항목에서 엔터를 했을 때 조회수행되는 이벤트연결
    bindSrchEnterEvent();
}


////////////////////////////////////////////////////////////////////////////////
// Grid 관련
////////////////////////////////////////////////////////////////////////////////

var colNames = null;
var colModel = null;
var captionTitle = "";

function loadGrid() {
	
    // 메뉴 구분에 따라 col정보 설정.
    setGridInfoByMenu();
    $(GRID_NAME).jqGrid({
        url            : SEARCH_URL,
        datatype     : 'json',
        mtype        : 'GET',
        caption      : captionTitle,
        colNames     : colNames,
        postData     : getSearchPostData(),
        colModel     :colModel,
        rowNum:10,
        rowList:[5,10,15],
        height: 276,
        rownumbers: true,
        rownumWidth:40,
        autowidth: true,
        pager: '#pager',
        //sortname: 'join_date',
        //sortorder: 'DESC',
        viewrecords : true,
        multiselect : false,
        multiboxonly: true,
        shrinkToFit : false,
        jsonReader      : {
            root        : "rows",
            page        : "page",
            total       : "total",
            records     : "records",
            repeatitems : false,
            cell        : "cell",
            id          : "id"
        },
        afterInsertRow : function(rowid, rowdata, rowelem) {
        },
        onSelectRow: function(rowid, status) {
        },
        //ondblClickRow: function (rowid,  iCol, cellcontent, e) {
		//	grid_onCellSelect(rowid, iCol, cellcontent, e)
        //},
        onCellSelect : function(rowid, iCol, cellcontent, e){
            grid_onCellSelect(rowid, iCol, cellcontent, e)
        },
        loadComplete: function(data) {
        },
        //multiselect : true 시 헤더 체크박스를 눌렀을 경우 동작하는 함수
        onSelectAll: function(rowid,status){
        },
        loadError : function(xhr,st,err) {
          $("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
    });

}

// 메뉴 구분에 따라 col정보 설정.
function setGridInfoByMenu(){
        colNames = ["아이디", "성명", "지역코드", "지역", "소속", "직종코드", "직종", "분야코드", '분야', "세부분야코드", "세부분야",  "가입일", "사용상태코드"];
  
        colModel = [
                    {name:'userId',     index:'userId',     width:100, editable:false, sortable:false, align:"center"},
                    {name:'userNm',     index:'userNm',       width: 100, editable:false, align:"center"}, 
                    {name:'cityauthCd', index:'cityauthCd', width:100, editable:false, align:"center", hidden:true},
                    {name:'cityauthNm', index:'cityauthNm', width:100, editable:false, align:"center"},
                    {name:'attach',    index:'attach',    width: 100, editable:false, align:"center"},
                    {name:'occupa',    index:'occupa',    width: 100, editable:false, align:"center", hidden:true},
                    {name:'occupaNm',    index:'occupaNm',    width: 180, editable:false, align:"left"},
                    {name:'field',    index:'field',    width: 100, editable:false, align:"center", hidden:true},
                    {name:'fieldNm',    index:'fieldNm',    width: 200, editable:false, align:"left"},
                    {name:'detailField',    index:'detailField',    width: 120, editable:false, align:"center", hidden:true},
                    {name:'detailFieldNm',    index:'detailFieldNm',    width: 200, editable:false, align:"left"},
                    {name:'joinDate',     index:'joinDate',     width: 50, editable:false, align:"right" , hidden:true},
                    {name:'useStat'  ,     index:'useStat'   ,     width: 50, editable:false, align:"center", hidden:true}
                    ];
        captionTitle = "평가위원 목록";
}

// 그리등 paramter 구성.
function getSearchPostData(){
	var postData = {
			srchDateBegin: $("#date-picker-1").val(),
			srchDateEnd: $("#date-picker-2").val(),
			srchAttach : $("#srchAttach").val(),
			srchOccupation : $("#srchOccupation").val(),
			srchFieldVal : $("#srchFieldVal").val(),
			srchFieldType: $("#srchFieldType").val(),
			srchFieldDetail: $("#srchFieldDetail").val(),
			srchCommit: $("#srchCommit").val()
    };
	
    return postData;
    
}

////////////////////////////////////////////////////////////////////////////////
// 그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

// row 클릭 이벤트 함수
function grid_onCellSelect(rowid, iCol, cellcontent, e){

    var colModel = $(GRID_NAME).jqGrid('getGridParam', 'colModel'); // 컬럼명을 배열형태로 가져온다.  
    var colName = colModel[iCol]['name'];
    
    var rowdata = $(GRID_NAME).getRowData(rowid);
    var evaluUserId = rowdata.userId;
    //var evaluStage = rowdata.evaluStage;
    // checkbox 이후 col을 클릭 했을 때 처리.
    if(iCol >= 2) {
        // 상세화면 이동.
        goView(evaluUserId);
    }
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

//사업의 구분 콤보 change 이벤트 연결.
function bindChangeBusiType(){
    
    EVALUComm.bindChangeBusiType({
        busiTypeId : "srchBusiTypeTemp",
        busiCateId : "srchBusiCateTemp"
    });
    
}

// 분야 구분 콤보 change 이벤트 연결.
function bindChangeFieldType(){
	
	EVALUComm.bindChangeFieldType({
		fieldTypeId : "srchFieldTypeTemp",
		fieldDetailId : "srchFieldDetailTemp"
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
    
    //hidden 검색조건에 동기화
    setSearchCond();

    fn_search(1);
}

//hidden 검색조건에 동기화

function setSearchCond(){
    
    $("#srchFieldType").val($("#srchFieldTypeTemp").val());
    $("#srchFieldDetail").val($("#srchFieldDetailTemp").val());
    
    var srchFieldVal = $("#srchFieldDetail").val();
    
    if(isEmpty(srchFieldVal)){
    	srchFieldVal = $("#srchFieldType").val();
    }
    $("#srchFieldVal").val(srchFieldVal);
}


function fn_search(page) {
    var optionData = {
		            postData:getSearchPostData(), 
         };
    
    if(page){
        optionData.page = page;
    }
    
    $(GRID_NAME).jqGrid( 'setGridParam'
            ,optionData
           ).trigger("reloadGrid");
}

// 입력/수정 화면으로 이동
function goView(evaluUserId){
    BIZComm.submit({
        url : ROOT_PATH+ REGI_URL,
        userParam : {
            evaluUserId : evaluUserId
        }
    });
}
