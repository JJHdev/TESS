var GRID_NAME	= "#grid";
var SEARCH_URL	= "/sys/code/getCodeTypeList.do";
var SAVE_URL		= "/sys/code/saveCodeType.do";

var DETAIL_GRID_NAME	= "#grid_detail";
var DETAIL_SEARCH_URL	= "/sys/code/getCodeList.do";
var DETAIL_SAVE_URL		= "/sys/code/saveCode.do";

$(function() {
    
    // [20141120 LCS] 버튼클릭이벤트 연결
    $("#prcBtnSrch").click(function(){
        onClickButton($(this).attr("mode"));
    });
    
	/***********************    Master GRID    *******************/
	$(GRID_NAME).jqGrid({
		url:SEARCH_URL+'?mode=Y',
		datatype: 'json',
		mtype: 'GET',
		caption: caption,
		colNames: colnames,
		colModel:[
				{name:'parentCode', index:'code', width:100, editable:true, editrules:{required:true}, /*editoptions is Add, Edit create. */ formoptions:{elmsuffix:suffix}},
				{name:'parentCodeNm', index:'code_nm', width:160, editable:true, editrules:{required:true}, editoptions:{size:40, maxlength:100},  formoptions:{elmsuffix:suffix}},
				{name:'useYn', index:'use_yn', width:30, editable:true, sortable:false,  align:"center",
						edittype:"select",
						editoptions:{required:true, value:"Y:Y;N:N"}}
		],
		rowNum:0,
		rowList:[],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager',
		sortname: 'parent_code',
		sortorder: 'asc',
		multiselect: false,
		multiboxonly: true,
		shrinkToFit:true,
		pginput:false,
		pgbuttons:false,
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
		onSelectRow: function(rowid, status) {
			searchDetailData(rowid);
		},
		ondblClickRow: function (rowid) {
			editRowMaster();
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:true} );

	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-plus",
		onClickButton: addRowMaster,
		position: "last",
		title:GRID_BTN_ADD,
		cursor: "pointer"
	});

	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-pencil",
		onClickButton: editRowMaster,
		position: "last",
		title:GRID_BTN_EDIT,
		cursor: "pointer"
	});

	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-trash",
		onClickButton: deleteRowMaster,
		position: "last",
		title:GRID_BTN_DEL,
		cursor: "pointer"
	});

	/***********************    Detail GRID    *******************/
	$(DETAIL_GRID_NAME).jqGrid({
		url:DETAIL_SEARCH_URL+'?mode=N',
		datatype: 'json',
		mtype: 'GET',
		caption : caption_detail,
		colNames: colnames_detail,
		colModel:[
				{name:'parentCode', index:'parent_code', width:50, editable:true, editoptions:{readonly:true,size:10},hidden:true},		// Key Hidden
				{name:'code', index:'code', width:50, editable:true, editrules:{required:true},  /*editoptions is Add, Edit to create. */ align:"center", formoptions:{elmsuffix:suffix}},
				{name:'codeNm', index:'code_nm', width:150, editable:true, editrules:{required:true}, editoptions:{size:40, maxlength:100}, formoptions:{elmsuffix:suffix}},
				{name:'addCol1', index:'add_col1', width:80, editable:true, editoptions:{size:50, maxlength:100}, sortable:false},
				{name:'addCol2', index:'add_col2', width:80, editable:true, editoptions:{size:50, maxlength:100}, sortable:false},
				{name:'addCol3', index:'add_col3', width:80, editable:true, editoptions:{size:50, maxlength:100}, sortable:false},
				{name:'codeOdr', index:'code_odr', width:50, editable:true, editoptions:{size:2, maxlength:2}, sortable:false,  formatter:'integer', align:"center"},
				{name:'useYn', index:'use_yn', width:30, editable:true, sortable:false,  align:"center",
						edittype:"select",
						editoptions:{required:true, value:"Y:Y;N:N"}}
		],
		rowNum:500,
		rowList:[],
		height: 276,
		rownumbers: false,
		autowidth: true,
		pager: '#pager_detail',
		sortname: 'code',
		sortorder: 'asc',
		multiselect: true,
		multiboxonly: true,
		viewrecords: true,
		shrinkToFit:true,
		jsonReader : {
			root: "rows",
			page: "page",
			total: "total",
			records: "records",
			repeatitems: false,
			cell: "cell",
			id: "id"
		},
		ondblClickRow: function (rowid) {
			editRowDetail();
		},
		loadError : function(xhr,st,err) {
			$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
		}
	}).navGrid('#pager_detail', {edit:false,add:false,del:false,view:false,search:false,refresh:true} );

	$(DETAIL_GRID_NAME).navButtonAdd('#pager_detail', {
		caption:'', //GRID_BTN_ADD,
		buttonicon:"ui-icon-plus",
		onClickButton: addRowDetail,
		position: "last",
		title:GRID_BTN_ADD,
		cursor: "pointer"}
	);

	$(DETAIL_GRID_NAME).navButtonAdd('#pager_detail', {
		caption:'', //GRID_BTN_EDIT,
		buttonicon:"ui-icon-pencil",
		onClickButton: editRowDetail,
		position: "last",
		title:GRID_BTN_EDIT,
		cursor: "pointer"}
	);

	$(DETAIL_GRID_NAME).navButtonAdd('#pager_detail', {
		caption:'', //GRID_BTN_DEL,
		buttonicon:"ui-icon-trash",
		onClickButton: deleteRowDetail,
		position: "last",
		title:GRID_BTN_DEL,
		cursor: "pointer"}
	);
});


/********************    Master Grid Action  ********************/
// Master Grid Add
function addRowMaster() {
	//var propsName = $(GRID_NAME).jqGrid('getColProp','parentCode');
	//var readonly	 = propsName.editoptions.readonly;

	//if (readonly != undefined) {
		$(GRID_NAME).setColProp('parentCode', { editoptions: {size:25, maxlength:25 } });
	//}

	submitAddRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:400
	});

	setImeKeyStyle("parentCode");
}
// Master Grid Edit
function editRowMaster() {
	//var propsName = $(GRID_NAME).jqGrid('getColProp','parentCode');
	//var readonly	 = propsName.editoptions.readonly;

	//if (readonly == undefined) {
		$(GRID_NAME).setColProp('parentCode', { editoptions: {readonly:true, size:25, maxlength:25, disabled:true} });
	//}

	submitEditRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:400
	});
}
// Master Grid Delete
function deleteRowMaster() {
	var row = $(GRID_NAME).getGridParam('selrow');
	var rowdata = $(GRID_NAME).getRowData(row);

	var parentCode	= rowdata.parentCode;	// delete key.

	submitDeleteRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:400,
			userData:'{"parentCode":'+'"'+parentCode+'"}',
			msg:MSG_ADMN_1001,
			rtnFunc:'returnDeleteMaster'
	});
}

function returnDeleteMaster() {
	searchDetailData(null);
}

/********************    Detail Grid Action  ********************/
// Detail Grid Add
function addRowDetail() {
	var userdata = $(DETAIL_GRID_NAME).getGridParam('postData');

	if (userdata.parentCode == undefined || isEmpty(userdata.parentCode)  ) {
		alert(" '코드타입' " +MSG_ADMN_1002);
		return;
	}

	$(DETAIL_GRID_NAME).setColProp('code', { editoptions: {size:10, maxlength:25 } });

	submitAddRow({
			gridName:DETAIL_GRID_NAME,
			url:DETAIL_SAVE_URL,
			width:400,
			userData:'{"parentCode":'+'"'+userdata.parentCode+'"}'
	});

	//$("#code").css("ime-mode","disabled");
	setImeKeyStyle("code");
}

// Detail Grid Edit
function editRowDetail() {
	$(DETAIL_GRID_NAME).setColProp('code', { editoptions: {readonly:true, size:10, maxlength:25, disabled:true } });

	submitEditRow({
			gridName:DETAIL_GRID_NAME,
			url:DETAIL_SAVE_URL,
			width:400
	});
}
// Detail Grid Delete
function deleteRowDetail() {
	submitDeleteRow({
			gridName:DETAIL_GRID_NAME,
			url:DETAIL_SAVE_URL,
			width:400
	});
}


/********************    General  ********************/
// Search Code List
function searchDetailData(ids) {
	var rowdata = $(GRID_NAME).getRowData(ids);
	var parentCode	= rowdata.parentCode;

	if (ids == null) {
			$(DETAIL_GRID_NAME).jqGrid('setGridParam',{url:DETAIL_SEARCH_URL});
			$(DETAIL_GRID_NAME).jqGrid('setGridParam',{postData:{mode:'N', page:1}});
			$(DETAIL_GRID_NAME).jqGrid('setCaption',caption_detail).trigger('reloadGrid');
	} else {
			$(DETAIL_GRID_NAME).jqGrid('setGridParam',{url:DETAIL_SEARCH_URL});
			$(DETAIL_GRID_NAME).jqGrid('setGridParam',{postData:{mode:'Y', parentCode:parentCode, page:1}});
			$(DETAIL_GRID_NAME).jqGrid('setCaption',caption_detail+" &nbsp; [선택 코드타입 : <font color=#D56A00>"+parentCode+"</font>]").trigger('reloadGrid');
	}
}

// Button Action
function onClickButton(mode) {
	switch(mode.toUpperCase()) {
		case "INQUIRE":
			fn_search();
			break;
	}
}

// Search
function doSearch(ev) {
	if (ev.keyCode != 13) {
		return false;
	}
	fn_search();
}

function fn_search() {
	var searchParentCode = $("input[name$=schParentCode]").val();

	$(GRID_NAME).jqGrid('setGridParam',{postData:{parentCode:searchParentCode}}).trigger("reloadGrid");

	// 코드 그리드 초기화
	$(DETAIL_GRID_NAME).jqGrid('setGridParam',{url:DETAIL_SEARCH_URL});
	$(DETAIL_GRID_NAME).jqGrid('setGridParam',{postData:{mode:'N', page:1}});
	$(DETAIL_GRID_NAME).jqGrid('setCaption',caption_detail).trigger('reloadGrid');
}

// code/parentCode 부분에서 영문,숫자만 가능하게 제한
// IE는 완벽, CHROME/FIREFOX는 숫자의 특수문자 입력 막지 못했음.
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
