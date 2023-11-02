
//--------------------------------------
// 상수 정의
//--------------------------------------
var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var SEARCH_URL      = "/sys/role/getRoleList.do";
var SAVE_URL        = "/sys/role/saveRole.do";
var COMBO_URL       = "/sys/role/listComboRole.do";

//--------------------------------------
//그리드 속성 정의
// [20140915 LCS] 덧 : "key:true" 라는 속성이 정의 되어 있지 않아서 tree가 접히지 않았음.
//                     => <parent>에 대한 기준이 되는 id를 정의하는 속성.
//--------------------------------------
$(function() {
	/***********************    Master GRID    *******************/
	$(GRID_NAME).jqGrid({
	    treeGrid     : true,
	    treeGridModel: 'adjacency',
		url          : SEARCH_URL+'?mode=Y',
		datatype     : 'json',
		mtype        : 'GET',
		caption      : caption,
		colNames     : colnames,
		ExpandColumn : 'roleNm',
		colModel:[
			{name:'roleNm',       index:'role_nm',        width:150, editable:true, sortable:false, editrules:{required:true}, editoptions:{size:60, maxlength:100},  formoptions:{elmsuffix:suffix}},
			{name:'roleId',       index:'role_id',        width:150, editable:true, sortable:false, editrules:{required:true}, /*editoptions is Add, Edit to create. */ formoptions:{elmsuffix:suffix}, key:true},
			{name:'parentRoleId', index:'parent_role_id', width:150, editable:true, edittype:"select", sortable:false, editrules:{required:true}, hidden:true, formoptions:{elmsuffix:suffix}}
		],
		rowNum:-1,
		rowList:[],
		height: 276,
		//rownumbers: true,
		autowidth: true,
		pager: GRID_PAGER_NAME,
		//multiselect: false,
		//multiboxonly: false,
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
		onSelectRow: function(rowid, status) {
			fn_buildCombo(rowid);
		},
		//ondblClickRow: function (rowid) {
		//	editRowMaster();
		//},
		loadComplete: function(data) {
		    //[20140915 LCS] load가 끝나고 바로 모든 role을 combo로 조회하는 것으로 변경.
		    fn_buildCombo();
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid',GRID_PAGER_NAME,{ edit:false,add:false,del:false,view:false,search:false,refresh:false} );

	$(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
	    caption:'',
	    buttonicon:"ui-icon-refresh",
	    onClickButton: fn_refresh,
	    position: "last",
	    title:GRID_BTN_REFRESH,
	    cursor: "pointer"
	});

	$(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
		caption:'',
		buttonicon:"ui-icon-plus",
		onClickButton: addRowMaster,
		position: "last",
		title:GRID_BTN_ADD,
		cursor: "pointer"
	});

	$(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
		caption:'',
		buttonicon:"ui-icon-pencil",
		onClickButton: editRowMaster,
		position: "last",
		title:GRID_BTN_EDIT,
		cursor: "pointer"
	});
	/*
	$(GRID_NAME).navButtonAdd(GRID_PAGER_NAME, {
		caption:'',
		buttonicon:"ui-icon-trash",
		onClickButton: deleteRowMaster,
		position: "last",
		title:GRID_BTN_DEL,
		cursor: "pointer"
	});
	*/

});


/********************    Grid Action  ********************/
// Grid Add
function addRowMaster() {
	$(GRID_NAME).setColProp('roleId', { editoptions: {size:25, maxlength:50 } });
	$(GRID_NAME).setColProp('parentRoleId', {hidden:false});

	submitAddRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:550,
			rtnFunc:'fn_setGridInitStyle'
	});
}
// Grid Edit
function editRowMaster() {
	$(GRID_NAME).setColProp('roleId', { editoptions: {readonly:true, size:25, maxlength:50, disabled:true} });
	$(GRID_NAME).setColProp('parentRoleId', {hidden:false});

	submitEditRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:550,
            rtnFunc:'fn_setGridInitStyle'
	});
}
// Grid Delete
function deleteRowMaster() {
	var row = $(GRID_NAME).getGridParam('selrow');
	var rowdata = $(GRID_NAME).getRowData(row);

	var roleId	= rowdata.roleId;	// delete key.

	submitDeleteRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			userData:'{"roleId":'+'"'+roleId+'"}',
			rtnFunc:'fn_setGridInitStyle'
	});
}


/********************    General  ********************/

//Grid의 기본속성 설정.
function fn_setGridInitStyle(){

    // 부모롤 항목을 보이제 않게 처리.
    $(GRID_NAME).setColProp('parentRoleId', {hidden:true});

    //[20140916 LCS] TreeGrid에서 'refresh'할 경우 기존 선택된 대상이 해제되지 않고 selection이 그대로 남아 있다.
    //  => 다음 행위로 간제 해제할 수 있다.
    $(GRID_NAME).jqGrid('resetSelection');
}

function fn_refresh() {

    // REFRESH 처리
    $(GRID_NAME).trigger('reloadGrid');

    // Grid 기본값 설정
    fn_setGridInitStyle()
}

function fn_buildCombo(rowid) {
	var rowdata = $.jgrid.getRowExtData(GRID_NAME, rowid);

    var params		= {roleId:rowdata.roleId};		// 자신 role_id는 선택항목에서 제외
	var usertypes	= $.jgrid.gridComboObject(COMBO_URL, params);

	$(GRID_NAME).setColProp('parentRoleId', { editoptions: { value: usertypes} });
}

