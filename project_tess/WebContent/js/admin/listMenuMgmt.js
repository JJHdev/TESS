var GRID_NAME   = "#grid";
var SEARCH_URL  = "/sys/menu/getMenuList.do";
var SAVE_URL    = "/sys/menu/saveMenuMgmt.do";

$(function() {
    
    // [20141120 LCS] 버튼클릭이벤트 연결
    $("#prcBtnSrch").click(function(){
        onClickButton($(this).attr("mode"));
    });
    
	/***********************    GRID    *******************/
	$(GRID_NAME).jqGrid({
	    autoencode: false,
		url:SEARCH_URL+'?mode=Y',
		datatype: 'json',
		mtype: 'GET',
		caption: caption,
		colNames: colnames,
		colModel:[
				{name:'lvl', index:'lvl', width:0, editable:false, hidden:true},
				{name:'menuId', index:'menu_id', width:100, sortable:false, editable:true, editrules:{required:true}, /*editoptions is Add, Edit to create. */ formoptions:{elmsuffix:suffix}, align:"center"},
				//{name:'menuNmOrg', index:'menu_nm', width:200, sortable:false, hidden:true},
				{name:'menuNmView', index:'menu_nm', width:200, sortable:false, editable:false},
				{name:'menuNm', index:'menu_nm', width:250, sortable:false, editable:true, hidden:true, editrules:{required:true}, editoptions:{size:30, maxlength:100}, formoptions:{elmsuffix:suffix}},
				{name:'menuLvl', index:'menu_lvl', width:40, sortable:false, editable:true, editrules:{required:true, integer:true}, editoptions:{size:2, maxlength:2},  formoptions:{elmsuffix:suffix}, formatter:'integer', align:"center"},
				{name:'menuOdr', index:'menu_odr', width:40, sortable:false, editable:true, editrules:{integer:true}, editoptions:{size:2, maxlength:2}, formatter:'integer', align:"center"},
				//{name:'refProgId', index:'ref_prog_id', width:100, editable:true, sortable:false, editrules:{}, editoptions:{size:22, maxlength:20}, align:"center"},
				{name:'tagtUrl', index:'tagt_url', width:220, editable:true, sortable:false, editrules:{}, editoptions:{size:50, maxlength:150}},
				{name:'parentMenuId', index:'parent_menu_id', width:100, editable:true, sortable:false, editrules:{}, align:"center"},
				{name:'useYn', index:'use_yn', width:30, editable:true, sortable:false,  align:"center",
						edittype:"select",
						editoptions:{required:true, value:"Y:Y;N:N"}},
				{name:'popupYn', index:'popup_yn', width:30, editable:true, sortable:false,  align:"center",
						edittype:"select",
						editoptions:{required:true, value:"Y:Y;N:N", defaultValue:"N"}}
		],
		rowNum:0,
		rowList:[],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager',
		sortname: '',
		sortorder: '',
		multiselect: true,
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
		ondblClickRow: function (rowid) {
			editRow();
		},
		afterInsertRow: function(rowid, data) {
			fn_afterInsertRow(rowid, data);
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:false} );

	$(GRID_NAME).navButtonAdd('#pager', {
        caption:'',
        buttonicon:"ui-icon-refresh",
        onClickButton: fn_search,
        position: "last",
        title:GRID_BTN_REFRESH,
        cursor: "pointer"
    });
	
	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-plus",
		onClickButton: addRow,
		position: "last",
		title:GRID_BTN_ADD,
		cursor: "pointer"
	});

	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-pencil",
		onClickButton: editRow,
		position: "last",
		title:GRID_BTN_EDIT,
		cursor: "pointer"
	});

	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-trash",
		onClickButton: deleteRow,
		position: "last",
		title:GRID_BTN_DEL,
		cursor: "pointer"
	});
    
});


/********************    Grid Action  ********************/
// Grid Add
function addRow() {
	
	// 입력form 설정
	fn_setFormStyle({isRegi:true});

	submitAddRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:550,
			rtnFunc:'fn_setGridStyle'
	});
}
// Grid Edit
function editRow() {
    
	var row = $(GRID_NAME).getGridParam('selrow');
	var rowdata = $(GRID_NAME).getRowData(row);

	if (rowdata != undefined) {
		//$(GRID_NAME).setRowData(row, {menuNm:rowdata.menuNmOrg});   // 현재 row의 특정 col의 값 변경:'setRowData'
		//$(GRID_NAME).setCell(row,"menuNm", rowdata.menuNmOrg);
	}

	// 입력form 설정
	fn_setFormStyle({isRegi:false});

	submitEditRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:550,
            rtnFunc:'fn_setGridStyle'
	});
}
// Grid Delete
function deleteRow() {
	var row = $(GRID_NAME).getGridParam('selrow');
	var rowdata = $(GRID_NAME).getRowData(row);

	var menuId	= rowdata.menuId;	// delete key.

	submitDeleteRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			userData:'{"menuId":'+'"'+menuId+'"}'
	});
}



/********************    General  ********************/

// 입력form일 때 속성 설정
function fn_setFormStyle(stat){
    
    var isRegi     = stat.isRegi;
    
    $(GRID_NAME).setColProp('menuNm',       { hidden:false });
    $(GRID_NAME).setColProp('menuNmView',   { hidden:true });
    $(GRID_NAME).setColProp('parentMenuId', { editoptions: {size:14, maxlength:11 }  });
    
    // menuId항목은 '신규등록'일 때만 활성화
    $(GRID_NAME).setColProp('menuId'      , { editoptions: {size:14, maxlength:11, disabled:(!isRegi), readonly:(!isRegi) }  });
}

// Grid의 속성 설정.
function fn_setGridStyle(){
    $(GRID_NAME).setColProp('menuNm',     { hidden:true });
    $(GRID_NAME).setColProp('menuNmView', { hidden:false });
}

function fn_afterInsertRow(row, rowdata) {
//	switch (rowdata.lvl) {
//		case 0:
//			$(GRID_NAME).setRowData(row, {menuNm:rowdata.menuNmOrg});
//		break;
//		case 1:
//			$(GRID_NAME).setRowData(row, {menuNm:'&nbsp;&nbsp;  ┕ '+ rowdata.menuNmOrg});
//		break;
//	};
	
	switch (rowdata.lvl) {
        case 0:
            $(GRID_NAME).setRowData(row, {menuNmView:rowdata.menuNm});
        break;
        case 1:
            $(GRID_NAME).setRowData(row, {menuNmView:'&nbsp;&nbsp;  ┕ '+ rowdata.menuNm});
        break;
    };
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
	var searchParentMenuId = $("select[name$=parentMenuId]").val();
	var searchMenuNm       = $("input[name$=menuNm]").val();

	var postData	= {
			parentMenuId: searchParentMenuId,
			menuNm      : searchMenuNm
	}

	// Grid의 기본 속성 재설정.
	fn_setGridStyle();
	
	$(GRID_NAME).jqGrid('setGridParam',{postData:postData}).trigger("reloadGrid");
}
