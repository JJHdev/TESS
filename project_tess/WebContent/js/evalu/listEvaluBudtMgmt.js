/**
 *  평가입력 리스트 화면
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
var SEARCH_URL      = ROOT_PATH+"/evalu/getEvaluBudtMgmt.do" ;
var SAVE_DELT_URL   = ROOT_PATH+"/evalu/saveEvaluMgmtDelt.do";
var VIEW_URL 			= ROOT_PATH+"/evalu/viewEvaluBudtMgmt.do"

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

var colNames = null;
var colModel = null;
var captionTitle = "";

function loadGrid() {
	
    
    // 메뉴 구분에 따라 col정보 설정.
    setGridInfoByMenu();
    
    $(GRID_NAME).jqGrid({
        url          : SEARCH_URL,
        datatype     : 'json',
        mtype        : 'POST',
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
        multiselect : true,
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
        ondblClickRow: function (rowid) {
        },
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
     
        colNames = ["지역", "사업명", "사업의 유형", "평가단계", "최종평가결과", "평가일", "관광개발사업번호", "사업상태코드", "사업유형코드", "평가단계 코드", "평가진행단계"];
        colModel = [
                    {name:'cityauthNm',     index:'cityauth_nm' ,     width:150, editable:false, sortable:false, align:"center"},
                    {name:'evaluBusiNm',     index:'evalu_busi_nm',     width:210, editable:false, align:"left"},
                    {name:'busiCateNm',     index:'busiCateNm',       width: 150, editable:false, align:"center"}, 
                    {name:'evaluStageNm',    index:'evalu_stage',    width: 90, editable:false, align:"center"},
                    {name:'convFinalEvaluFnd',     index:'convFinalEvaluFnd',       width: 120, editable:false, align:"center"}, 
                    {name:'convEvaluDate',    index:'evalu_date',    width: 120, editable:false, align:"center"},
                    {name:'evaluBusiNo',     index:'evalu_busi_no',     width: 50, editable:false, align:"right" , hidden:true},
                    {name:'apprStat'  ,     index:'appr_stat'   ,     width: 50, editable:false, align:"center", hidden:true},
                    {name:'busiCate'  ,     index:'busi_cate'   ,     width: 50, editable:false, align:"center", hidden:true},
                    {name:'evaluStage'  ,     index:'evalu_stage'   ,     width: 50, editable:false, align:"center", hidden:true},
                    {name:'evaluProcStep',    index:'evalu_proc_step',    width: 90, editable:false, align:"right", hidden:true},
                    ];
        captionTitle = "평가대상입력사업 리스트";

}

// 그리등 paramter 구성.
function getSearchPostData(){
    var postData = {
    		evaluStage : $("#evaluStage").val(),
            srchBusiAddr1  : $("#srchBusiAddr1" ).val(),
            srchBusiAddr2  : $("#srchBusiAddr2" ).val(),
            srchBusiType   : $("#srchBusiType"  ).val(),
            srchBusiCate   : $("#srchBusiCate"  ).val(),
            srchEvaluBusiNm : $("#srchEvaluBusiNm").val(),
            srchEvaluDate : $("#srchEvaluDate").val(),
            srchFinalEvaluFnd : $("#srchFinalEvaluFnd").val()
    }
    
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
    var evaluBusiNo = rowdata.evaluBusiNo;
    var evaluStage = rowdata.evaluStage;
    var evaluProcStep = rowdata.evaluProcStep;
    
    var args={
    		evaluBusiNo : evaluBusiNo,
    		evaluStage : evaluStage
    }
    
    // checkbox 이후 col을 클릭 했을 때 처리.
    if(iCol >= 2) {
        // 상세화면 이동.
        goView(args);
    }
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

//사업의 구분 콤보 change 이벤트 연결.
function bindChangeBusiType(){
    
    EVALUComm.bindChangeBusiType({
        busiTypeId : "srchBusiTypeTemp",
        busiCateId : "srchBusiCateTemp"
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
    
    $("#srchBusiAddr1" ).val($("#srchBusiAddr1Temp" ).val());
    $("#srchBusiAddr2" ).val($("#srchBusiAddr2Temp" ).val());
    $("#srchBusiType"  ).val($("#srchBusiTypeTemp"  ).val());
    $("#srchBusiCate"  ).val($("#srchBusiCateTemp"  ).val());
    $("#srchEvaluBusiNm").val($("#srchEvaluBusiNmTemp").val());
    $("#srchEvaluDate").val($("#srchEvaluDateTemp").val());
    $("#srchFinalEvaluFnd").val($("#srchFinalEvaluFndTemp").val());
    
    var srchBusiAddrVal = $("#srchBusiAddr2").val();
    if(isEmpty(srchBusiAddrVal)){
        srchBusiAddrVal = $("#srchBusiAddr1").val();
    }
    $("#srchBusiAddrVal").val(srchBusiAddrVal);
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

// 상세화면으로 이동
function goView(args){
	
    BIZComm.submit({
        url : VIEW_URL,
        userParam : {
            evaluBusiNo : args.evaluBusiNo,
            evaluStage : args.evaluStage
        }
    });
}
