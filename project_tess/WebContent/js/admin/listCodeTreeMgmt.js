
//--------------------------------------
// 상수 정의
//--------------------------------------
var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var SEARCH_URL      = "/sys/code/getCodeTreeList.do";
var GRID_OBJ        = $(GRID_NAME);
var SAVE_URL        = "/sys/code/saveCodeTree.do";

//--------------------------------------
//그리드 속성 정의
//--------------------------------------
$(function(){
    
    // [20141120 LCS] 버튼클릭이벤트 연결
    $("#prcBtnSrch").click(function(){
        onClickButton($(this).attr("mode"));
    });

    $(GRID_NAME).jqGrid({
        treeGrid     : true,
        treeGridModel: 'adjacency',
        url          : SEARCH_URL+'?mode=Y',
        datatype     : 'json',
        mtype        : "GET",
        caption      : caption,
        colNames     : colnames,
        ExpandColumn : 'code',
        colModel     :[
             {name:'code'       ,index:'code'     , width:140, editable:true, editrules:{required:true, custom:true, custom_func:chkCodeCell}, key:true, sortable:false},
             {name:'codeNm'     ,index:'code_nm'  , width:140, editable:true, editrules:{required:true}, editoptions:{size:40, maxlength:100}, align:"left", sortable:false},
             {name:'addCol1'    ,index:'add_col1' , width:80,  editable:true, editoptions:{size:50, maxlength:100}, align:"left", sortable:false},
             {name:'addCol2'    ,index:'add_col2' , width:80,  editable:true, editoptions:{size:50, maxlength:100},align:"left", sortable:false},
             {name:'addCol3'    ,index:'add_col3' , width:80,  editable:true, editoptions:{size:50, maxlength:100},align:"left", sortable:false},
             {name:'codeOdr'    ,index:'code_odr' , width:40,  editable:true, editoptions:{size:2, maxlength:2},  formatter:'integer',align:"right", sortable:false},
             {name:'useYn'      ,index:'use_yn'   , width:40,  editable:true
                                                            ,  edittype:"select"
                                                            ,  editoptions:{required:true, value:"Y:Y;N:N"}
                                                            ,  align:"center", sortable:false},
             {name:'parentCode'   ,index:'parent_code', width:80, editable:true, editoptions:{readonly:true,size:10},sortable:false, hidden:true}

        ],
        rowNum:-1,
        rowList:[],
        height: 276,
        //rownumbers: false,
        autowidth: true,
        pager: GRID_PAGER_NAME,
        //sortname: 'parent_code',
        //sortorder: 'asc',
        //multiselect: true,
        //multiboxonly: true,
        //shrinkToFit:true,
        //pginput:false,
        //pgbuttons:false,
        viewrecords: true,
        jsonReader : {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: false,
            cell: "cell",
            id: "id"
        },
        treeIcons: {leaf:'ui-icon-document-b'},
        //gridview : false,
        loadComplete: function(data) {
        },
        afterInsertRow: function(rowid, data) {
            // * 'afterInsertRow' 이벤트가 수행되지 않고 있음.
            $(GRID_NAME).setRowData(rowid, false, { background : '#ff0000' });
        },
        ondblClickRow: function (rowid) {
            editRow();
        },
        loadError : function(xhr,st,err) {
            $j("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
    }).navGrid(GRID_PAGER_NAME, {edit:false,add:false,del:false,view:false,search:false,refresh:false} );

    $(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
        caption:'', //GRID_BTN_ADD,
        buttonicon:"ui-icon-refresh",
        onClickButton: fn_refresh,
        position: "last",
        title:GRID_BTN_REFRESH,
        cursor: "pointer"}
    );

    $(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
        caption:'', //GRID_BTN_ADD,
        buttonicon:"ui-icon-plus",
        onClickButton: addRow,
        position: "last",
        title:GRID_BTN_ADD,
        cursor: "pointer"}
    );

    $(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
        caption:'', //GRID_BTN_EDIT,
        buttonicon:"ui-icon-pencil",
        onClickButton: editRow,
        position: "last",
        title:GRID_BTN_EDIT,
        cursor: "pointer"}
    );

    $(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
        caption:'', //GRID_BTN_DEL,
        buttonicon:"ui-icon-trash",
        onClickButton: deleteRow,
        position: "last",
        title:GRID_BTN_DEL,
        cursor: "pointer"}
    );

});

//-------------------------------------------------
// navBtn 이벤트 함수 정의
//-------------------------------------------------

//add row
function addRow() {

    //선택된 row정보
    var row = $(GRID_NAME).getGridParam('selrow');
    var rowdata = $(GRID_NAME).getRowData(row);
    var isRegi = true;

    // 선택된 row가 없을 때 (최상위 코드 그룹을 등록할 때...)
    if (rowdata.code == undefined || isEmpty(rowdata.code)  ) {
        fn_setInputFormStyle({isRegi:isRegi, isType:true, dfSortSeq:'0', dfCodeType:"NONE"});
    }
    // 선택된 row가 있을 때 (하위 코드를 등록할 때...)
    else{

        // [20140912 LCS] 완전계층형을 할 수 없어서 2단계 계층으로만 제한.
        var dfCodeTypeVal = rowdata.code;
        if(rowdata.parentCode != 'NONE') dfCodeTypeVal = rowdata.parentCode;

        fn_setInputFormStyle({isRegi:isRegi, isType:false, dfSortSeq:'', dfCodeType:dfCodeTypeVal});
    }

    submitAddRow({
            gridName:GRID_NAME,
            url:SAVE_URL,
            width:400,
            rtnFunc : "fn_setGridInitStyle"
    });

    setImeKeyStyle("code");

}

//Grid Edit
function editRow() {

    //선택된 row정보
    var row = $(GRID_NAME).getGridParam('selrow');
    var rowdata = $(GRID_NAME).getRowData(row);
    var isReig = false;

    // 선택된 row가 parentCode이면 순서를 수정할 수 없음
    if(rowdata.parentCode == 'NONE'){
        fn_setInputFormStyle({isRegi:isReig, isType:true});
    }
    // 선택된 row가 code일때
    else{
        fn_setInputFormStyle({isRegi:isReig, isType:false});
    }

    submitEditRow({
            gridName:GRID_NAME,
            url:SAVE_URL,
            width:400,
            rtnFunc : "fn_setGridInitStyle"
    });
}

//Grid Delete
function deleteRow() {

    var row = $(GRID_NAME).getGridParam('selrow');
    var rowdata = $(GRID_NAME).getRowData(row);

    var parentCodeVal = '';
    var codeVal     = '';

    if(row){
         codeVal     = rowdata.code;
         parentCodeVal = rowdata.parentCode;
    }

    var submitDelArgs = {
            gridName:GRID_NAME,
            url:SAVE_URL,
            width:400,
            userData:'{"parentCode":"'+parentCodeVal+'", "code":"'+codeVal+'"}',
            rtnFunc : "fn_setGridInitStyle"
        };

    // 코드 타입을 삭제할 때 MSG 추가.
    // [20140911 LCS] : MESSAGE가 제대로 적용되지 않음. --;
    if(parentCodeVal == 'NONE'){
        submitDelArgs.msg = MSG_ADMN_1001;
    }else{
        submitDelArgs.msg = MSG_ADMN_1003;
    }

    submitDeleteRow(submitDelArgs);
}

// 그리드 속성 설정.
function fn_setGridInitStyle(){

    $(GRID_NAME).setColProp('parentCode', { hidden:true });
    $(GRID_NAME).setColProp('addCol1',  { hidden:false });
    $(GRID_NAME).setColProp('addCol2',  { hidden:false });
    $(GRID_NAME).setColProp('addCol3',  { hidden:false });

    //[20140916 LCS] TreeGrid에서 'refresh'할 경우 기존 선택된 대상이 해제되지 않고 selection이 그대로 남아 있다.
    //  => 다음 행위로 간제 해제할 수 있다.
    $(GRID_NAME).jqGrid('resetSelection');
}

// 입력화면 style 설정.
function fn_setInputFormStyle(stat){

    var isRegi     = stat.isRegi;
    var isType     = stat.isType;
    var dfSortSeq  = stat.dfSortSeq;
    var dfCodeType = stat.dfCodeType;

    //------------------------
    // FORM STYLE 설정
    //------------------------
    // 코드항목 설정
    $(GRID_NAME).setColProp('code', { editoptions: {readonly:(!isRegi), size:20, maxlength:25, disabled:(!isRegi) } });

    // 추가항목 설정
    $(GRID_NAME).setColProp('addCol1', { hidden:isType });
    $(GRID_NAME).setColProp('addCol2', { hidden:isType });
    $(GRID_NAME).setColProp('addCol3', { hidden:isType });

    // 순위 항목 설정.
    var codeOdrEditOptions = {readonly : isType, disabled : isType };
    if(dfSortSeq != undefined) {
        codeOdrEditOptions.defaultValue = dfSortSeq;
    }
    $(GRID_NAME).setColProp('codeOdr', { editoptions:codeOdrEditOptions });

    // 코드타입 항목 설정
    var parentCodeEditOptions = {readonly:true}
    if(dfCodeType != undefined) {
        parentCodeEditOptions.defaultValue = dfCodeType;
    }
    $(GRID_NAME).setColProp('parentCode', { editoptions:parentCodeEditOptions, hidden:false});

    //------------------------
    // FORM editrrules 설정
    //------------------------
    // codeOdr 항목의 editrules 항목 설정.
    // editrules:{required:true, custom:true, custom_func:chkCodeCell}
    var codeOdrEditRules = {};
    if(!isType){
        codeOdrEditRules = {custom:true, custom_func:chkSortSeqCell};
    }
    else{
        codeOdrEditRules = {custom:false};
    }
    $(GRID_NAME).setColProp('codeOdr',  { editrules:codeOdrEditRules });
}

//-------------------------------------------------
// validation
//-------------------------------------------------

// 코드 항목 검사
function chkCodeCell(val, colName, colIndex ){

    if (val == 'NONE')
           return [false, MSG_ADMN_1004];   // msg : "코드 항목에 'NONE'은 입력 불가입니다."
        else
           return [true,""];
}

// 코드를 입력할 때 '순위' 항목에 '0'을 입려할 수 없음.
function chkSortSeqCell(val, colName, colIndex ){

    if (val == '0')
        return [false, MSG_ADMN_1005];      // msg : "코드정보 일 때 순서 항목에 '0'은 입력 불가입니다."
    else
        return [true,""];
}

//-------------------------------------------------
// 일반 함수 정의
//-------------------------------------------------

//Button Action
function onClickButton(mode) {
    switch(mode.toUpperCase()) {
        case "INQUIRE":
            fn_search();
            break;
    }
}

//Search
function doSearch(ev) {
    if (ev.keyCode != 13) {
        return false;
    }
    fn_search();
}

function fn_search() {
    var searchParentCode = $("input[name$=schParentCode]").val();

//    $(GRID_NAME).jqGrid('setGridParam',{postData:{parentCode:searchParentCode}}).trigger("reloadGrid");
    $(GRID_NAME).jqGrid('setGridParam',{postData:{parentCode:searchParentCode}});
//    fn_refresh();

//    // 코드 그리드 초기화
//    $(DETAIL_GRID_NAME).jqGrid('setGridParam',{url:SEARCH_URL});
//    $(DETAIL_GRID_NAME).jqGrid('setGridParam',{postData:{mode:'N', page:1}});
//    $(DETAIL_GRID_NAME).jqGrid('setCaption',caption);

    fn_refresh();
}

function fn_refresh() {

    // REFRESH 처리
    $(GRID_NAME).trigger('reloadGrid');

    // refresh처리하기 전에 부모코드 항목을 hidden으로 설정한다.
    //  -> 입력항목 열때 hidden속성을 해제하기 때문.
    fn_setGridInitStyle();

}

//code/parentCode 부분에서 영문,숫자만 가능하게 제한
//IE는 완벽, CHROME/FIREFOX는 숫자의 특수문자 입력 막지 못했음.
function setImeKeyStyle(inObjId) {

    var imeTarObj = $("#"+inObjId);

    // IME 모드 적용 : IE/FIREFOX만 적용됨 (CHROME 안됨)
    imeTarObj.css("imeMode","disabled");

    // 붙여넣기 방지.
    imeTarObj.bind("paste", function(){
        return false;
    });

    var eventNm = "keypress";

    // IE/FIREFOX는 keypress 적용
    // CHRME은 keydown적용
    if(navigator.userAgent.indexOf("Chrome") !=-1){// if Chrome
        eventNm = "keydown";
    }else if(navigator.userAgent.indexOf("Safari") !=-1){// if Safari
        eventNm = "keydown";
    }else if(navigator.userAgent.indexOf("Firefox") !=-1){// if Firefox
        eventNm = "keydown";
        // firefox때문에 focus를 옮겼다가 다시 해당 obj로 focus줌. => 이렇게 해야 IME-MODE가 적용됨 ??)
        $(":input:not(:hidden):eq(2)").focus();
        imeTarObj.focus();
    }else{
        eventNm = "keypress";
    }

    imeTarObj.unbind(eventNm);
    imeTarObj.bind(eventNm,function(evt){
        var isValid = true;
        var filter = "[0-9a-zA-Z_]";

        var evtType = evt.type;

        var validKeyCodes = "";
        var keyCode = (evt.keyCode)? evt.keyCode.toString():evt.which.toString();

        var isKeyCheck = true;

        if(evt.type == "keypress") {
            //isKeyCheck = true;
        } else if(evt.type == "keydown") {

            // keydown일 경우 'delete/backspace/insert/...'등의 버튼키를 허용하게 한다.
            if("|36|38|33|37|39|35|40|34|45|46|".indexOf(keyCode) >= 0 ){
                isKeyCheck = false;
            }
        }

        if(isKeyCheck == true && isValid == true && validKeyCodes.indexOf("|"+keyCode) < 0){
            var sKey = String.fromCharCode(keyCode);

            if(evtType == "keypress") {
                // 숫자키의 특수기호 키 제한 (keypress에서만 적용)
                if("|126|33|64|35|36|37|94|38|42|40|41|".indexOf("|"+keyCode)>=0) {
                    isValid = false;
                }
            }

            if(isValid == true) {
                var re = new RegExp(filter);
                if(!re.test(sKey)) isValid = false;
            }
        }

        if(isValid == false) event.returnValue = false;
    });

}