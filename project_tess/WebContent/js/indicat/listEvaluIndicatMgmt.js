/**
 * 사업등록 리스트 스크립트
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
var SEARCH_URL      = ROOT_PATH+"/indicat/getEvaluIndicatMgmt.do" ;
var SAVE_URL        = "/indicat/saveEvaluIndicatMgmt.do";
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
        treeGrid     : true,
        treeGridModel: 'adjacency',
        url          :  SEARCH_URL,
        datatype     : 'json',
        mtype        : 'POST',
        caption      : captionTitle,
        colNames     : colNames,
        ExpandColumn : 'code',
        postData     : getSearchPostData(),
        colModel     :colModel,
        rowNum:-1,
        rowList:[],
        height: 276,
        autowidth: true,
        pager: GRID_PAGER_NAME,
        //sortname: 'join_date',
        //sortorder: 'DESC',
        viewrecords : true,
//        multiselect : true,
//        multiboxonly: true,
//        shrinkToFit : false,
        jsonReader      : {
            root        : "rows",
            page        : "page",
            total       : "total",
            records     : "records",
            repeatitems : false,
            cell        : "cell",
            id          : "id"
        },
        treeIcons: {leaf:'ui-icon-document-b'},
        afterInsertRow : function(rowid, rowdata, rowelem) {
        	 $(GRID_NAME).setRowData(rowid, false, { background : '#ff0000' });
        },
        ondblClickRow: function (rowid) {
        },
        loadComplete: function(data) {
        },
        //multiselect : true 시 헤더 체크박스를 눌렀을 경우 동작하는 함수
        onSelectAll: function(rowid,status){
        },
        loadError : function(xhr,st,err) {
          $("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
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

}

// 메뉴 구분에 따라 col정보 설정.
function setGridInfoByMenu(){
     
        colNames = ["코드", "코드명", "추가컬럼", "추가컬럼2", "추가컬럼3", "순서", "사용여부", "부모코드"];
        colModel = [
                    {name:'code'       ,index:'code'     , width:140, editable:true, editrules:{required:true, custom:true, custom_func:chkCodeCell }, key:true, sortable:false},
                    {name:'codeNm'     ,index:'code_nm'  , width:140, editable:true, editrules:{required:true }, editoptions:{size:40, maxlength:100}, align:"left", sortable:false},
                    {name:'addCol1'    ,index:'add_col1' , width:80,  editable:true, editoptions:{size:50, maxlength:100}, align:"left", sortable:false},
                    {name:'addCol2'    ,index:'add_col2' , width:80,  editable:true, editoptions:{size:50, maxlength:100},align:"left", sortable:false},
                    {name:'addCol3'    ,index:'add_col3' , width:80,  editable:true, editoptions:{size:50, maxlength:100},align:"left", sortable:false},
                    {name:'codeOdr'    ,index:'code_odr' , width:40,  editable:true, editoptions:{size:2, maxlength:2},  formatter:'integer',align:"right", sortable:false},
                    {name:'useYn'      ,index:'use_yn'   , width:40,  editable:true
                                                                   ,  edittype:"select"
                                                                   ,  editoptions:{required:true, value:"Y:Y;N:N"}
                                                                   ,  align:"center", sortable:false},
                    {name:'parentCode'   ,index:'parent_code', width:80, editable:true, editoptions:{readonly:true,size:10},sortable:false, hidden:true}
                    ];
        captionTitle = "평가대상입력사업 리스트";

}

// 그리등 paramter 구성.
function getSearchPostData(){
    var postData = {
    		srchEvaluStage  : $("#srchEvaluStage" ).val(),
    		srchEvaluIndicat  : $("#srchEvaluIndicat" ).val(),
    		srchEvaluIndicatNm : $("#srchEvaluIndicatNm").val(),
    }
    
    return postData;
}


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////



// 지역 검색조건 combo loading
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

// 검색 수행
function doSearch(){
    
    //hidden 검색조건에 동기화
    setSearchCond();
    
    fn_search(1);
}

//hidden 검색조건에 동기화
function setSearchCond(){
    
    $("#srchEvaluStage" ).val($("#srchEvaluStageTemp" ).val());
    $("#srchEvaluIndicat" ).val($("#srchEvaluIndicatTemp" ).val());
    $("#srchEvaluIndicatNm").val($("#srchEvaluIndicatNmTemp").val());
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

function fn_refresh() {

    // REFRESH 처리
    $(GRID_NAME).trigger('reloadGrid');

    // refresh처리하기 전에 부모코드 항목을 hidden으로 설정한다.
    //  -> 입력항목 열때 hidden속성을 해제하기 때문.
    fn_setGridInitStyle();

}

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

//그리드 속성 설정.
function fn_setGridInitStyle(){

    $(GRID_NAME).setColProp('parentCode', { hidden:true });
    $(GRID_NAME).setColProp('addCol1',  { hidden:false });
    $(GRID_NAME).setColProp('addCol2',  { hidden:false });
    $(GRID_NAME).setColProp('addCol3',  { hidden:false });

    //[20140916 LCS] TreeGrid에서 'refresh'할 경우 기존 선택된 대상이 해제되지 않고 selection이 그대로 남아 있다.
    //  => 다음 행위로 간제 해제할 수 있다.
    $(GRID_NAME).jqGrid('resetSelection');
}

//입력화면 style 설정.
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

//코드 항목 검사
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