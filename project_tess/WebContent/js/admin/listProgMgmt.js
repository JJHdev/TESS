var GRID_NAME		= "#grid";
var SEARCH_URL		= "/sys/prog/getProgList.do";
var SAVE_URL			= "/sys/prog/saveProgMgmt.do";
var COMBO_URL      = "/sys/prog/listComboMenu.do";

$(function() {
    
    // [20141120 LCS] 버튼클릭이벤트 연결
    $("#prcBtnSrch").click(function(){
        onClickButton($(this).attr("mode"));
    });
    
	/***********************    GRID    *******************/
	$(GRID_NAME).jqGrid({
		url:SEARCH_URL+'?mode=Y',
		datatype: 'json',
		mtype: 'GET',
		caption: caption,
		colNames: colnames,
		colModel:[
				{name:'progId', index:'prog_id', width:100
						, editable:true, editrules:{required:true}/*, editoptions is Add, Edit to create. */ 
						, formoptions:{elmsuffix:suffix}},
				{name:'progNm', index:'prog_nm', width:180
						, editable:true, editrules:{required:true}, editoptions:{size:50, maxlength:100}
						, formoptions:{elmsuffix:suffix}},
				{name:'progPattern', index:'prog_pattern', width:180
						, editable:true, editrules:{required:true}, editoptions:{size:60, maxlength:150}
						, formoptions:{elmsuffix:suffix}},
				{name:'progType', index:'prog_type', width:40
						, sortable:false, align:"center"
						, editable:false, editrules:{}, editoptions:{readonly:true, disabled:true, size:10, maxlength:10}},
				{name:'menuId', index:'menu_id', width:160, editable:true, edittype:"select", sortable:false, editrules:{required:true}},
				{name:'secuLvl', index:'secu_lvl', width:50
						, align:"center", editable:true, editrules:{required:true}, editoptions:{size:2, maxlength:2}
						, formoptions:{elmsuffix:suffix}},
				{name:'progOdr', index:'prog_odr', width:40
						, sortable:false, align:"center"
						, editable:true, editrules:{integer:true, required:true}, editoptions:{size:2, maxlength:2}
						, formatter:'integer'
						, formoptions:{elmsuffix:suffix}}
		],
		rowNum:0,
		rowList:[],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager',
		sortname: 'prog_id',
		prog_odr: 'asc',
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
		loadComplete: function(data) {
		    fn_buildCombo();
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:true} );

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
	$(GRID_NAME).setColProp('progId', { editoptions: {readonly:false, size:20, maxlength:20, disabled:false} });
	$(GRID_NAME).setColProp('menuId', {hidden:false});

	submitAddRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:600
	});
}
// Grid Edit
function editRow() {
	$(GRID_NAME).setColProp('progId', { editoptions: {readonly:true, size:20, maxlength:20, disabled:true} });
	$(GRID_NAME).setColProp('menuId', {hidden:false});

	submitEditRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:600
	});
}
// Grid Delete
function deleteRow() {
	var row = $(GRID_NAME).getGridParam('selrow');
	var rowdata = $(GRID_NAME).getRowData(row);

	var progId	= rowdata.progId;	// delete key.

	submitDeleteRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			userData:'{"progId":'+'"'+progId+'"}'
	});
}



/********************    General  ********************/
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
	var searchProgNm	= $("input[name$=progNm]").val();

	var postData	= {
			progNm:searchProgNm
	}

	$(GRID_NAME).jqGrid('setGridParam',{postData:postData}).trigger("reloadGrid");
}

function fn_buildCombo() {
    var params		= '';
	var usertypes	= $.jgrid.gridComboObject(COMBO_URL, params);

	$(GRID_NAME).setColProp('menuId', { editoptions: { value: usertypes} });
}
