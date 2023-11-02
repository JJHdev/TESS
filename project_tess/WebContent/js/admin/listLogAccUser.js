/**
 * [관리자-사용자별접속통계] 리스트 화면 스크립트 .
 *
 * @author LCS
 * @version 1.0 2014/11/19
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

$(function() {

    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
});


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var SEARCH_URL      = ROOT_PATH+"/sys/log/getLogAccUser.do";

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
* 컴포넌트를 초기화한다.
*/
function initComp() {
  
    loadComp();
    
    // 그리드 load
    loadGrid();
}

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
    
//    //'검색조건' 콤보 change 이벤트 연결 함수.
//    bindChangeSrchTypeEvent();
}

////////////////////////////////////////////////////////////////////////////////
//Grid 관련
////////////////////////////////////////////////////////////////////////////////

function loadGrid() {
    $(GRID_NAME).jqGrid({
        url          : SEARCH_URL,
        datatype     : 'json',
        mtype        : 'GET',
        caption      : "사용자별접속통계",
        colNames     : ["사용자구분","아이디","성명","접속횟수","마지막 접속일","가입일"],
        postData     : getSearchPostData(),
        colModel:[
            {name:'userType', index:'user_type' , width:110, editable:false, sortable:false, align:"center"},
            {name:'userId',   index:'user_id' ,   width:110, editable:false, sortable:false, align:"center"},
            {name:'userNm',   index:'user_nm' ,   width:190, editable:false, sortable:false, align:"left"},
            {name:'cnt',      index:'cnt' ,       width: 70, editable:false, formatter:"integer",  sortable:false, align:"right"},
            {name:'lastDate', index:'last_date' , width:110, editable:false, sortable:false, align:"center"},
            {name:'joinDate', index:'join_date' , width: 70, editable:false, sortable:false, align:"center"}
        ],
        rowNum:10,
        rowList:[5,10,15],
        height: 276,
        rownumbers: true,
        autowidth: true,
        pager: '#pager',
        //sortname: 'join_date',
        //sortorder: 'DESC',
        viewrecords : true,
        multiselect : false,
        multiboxonly: false,
        shrinkToFit : true,
        jsonReader      : {
            root        : "rows",
            page        : "page",
            total       : "total",
            records     : "records",
            repeatitems : false,
            cell        : "cell",
            id          : "id"
        },
        onSelectRow: function(rowid, status) {
        },
        ondblClickRow: function (rowid) {
        },
        loadComplete: function(data) {
        },
        loadError : function(xhr,st,err) {
            $("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
    });

}

//그리등 paramter 구성.
function getSearchPostData(){
    var postData = {
            srchDateType   : $("#srchDateType" ).val(),
            srchFromDate   : $("#srchFromDate" ).val(),
            srchToDate     : $("#srchToDate"   ).val(),
            srchUserId     : $("#srchUserId"   ).val(),
            srchUscmType   : $("#srchUscmType" ).val()
    }
    
    return postData;
}

////////////////////////////////////////////////////////////////////////////////
//그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

function loadComp(){
 // 달력 객체 구성
    $("._calendar").css({
                        width : "80px",
                    }).datepicker({             // 달력 버튼 연결.
                        dateFormat : 'yy-mm-dd' 
                    }).prop({
                        readonly:true           // readonly 속성을 설정
                    }).toCalendarField();       // yyyy-mm-dd 포멧설정 및 입력 설정.
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


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

//검색 수행
function doSearch(){
  
    $("#srchDateType"  ).val($("#srchDateTypeTemp"  ).val());
    $("#srchFromDate"  ).val($("#srchFromDateTemp"  ).val());
    $("#srchToDate"    ).val($("#srchToDateTemp"    ).val());
    $("#srchUserId"    ).val($("#srchUserIdTemp"    ).val());
    $("#srchUscmType"  ).val($("#srchUscmTypeTemp").val());
    
    fn_search(1);
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

////////////////////////////////////////////////////////////////////////////////
//콘트롤 함수
////////////////////////////////////////////////////////////////////////////////

