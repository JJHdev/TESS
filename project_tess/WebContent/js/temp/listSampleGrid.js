var GRID_NAME		= "#grid";
var SEARCH_URL		= "/temp/getSampleGrid.do";
var SAVE_URL		= "/temp/saveSampleGrid.do";
var MULTI_SAVE_URL	= "/temp/saveMultiSampleGrid.do";

$(function() {
	$(GRID_NAME).jqGrid({
		url:SEARCH_URL,
		datatype: 'json',
		mtype: 'GET',
		caption:caption,
		colNames:colNames,
		colModel:[
				{name:'seq',index:'seq', width:55,editable:true,editoptions:{readonly:true,size:10},hidden:true},		// Key Hidden
				{name:'userId',index:'user_id', width:80,editable:true, editrules:{required:true, custom:true, custom_func:testFunction}, editoptions:{size:10, maxlength:10},hidden:true},
				{name:'userNm',index:'user_nm', width:100,editable:true, editrules:{required:true}, editoptions:{size:20, maxlength:20}},
				{name:'title',index:'title', width:340,editable:true, editrules:{required:true}, editoptions:{size:80, maxlength:100}},
				{name:'regiDate',index:'regi_dt', width:100, editable:true, editoptions:{size:10, maxlength:10}, sorttype:"date", align:"center"},
				{name:'regiDttm',index:'regi_dt', width:100, formatter:'date', sortable:false, align:"center"},	// formatoptions:{masks:"ISO8601Long"},
				{name:'amt',index:'amt', width:80, formatter:'currency', sortable:false,  align:"right"},
				{name:'userTypeNm',index:'user_type', width:100, sortable:false,  align:"right",
						editable:true,
						edittype:"select"},
				{name:"userType"   ,index:"user_type"    , hidden:true}
		],
		rowNum:15,
		rowList:[20,50,100],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager',
		sortname: 'SEQ',
		sortorder: 'DESC',
		viewrecords: true,
		multiselect: true,
		multiboxonly: false,
		shrinkToFit:false,
		loadComplete: function(data) {
			fn_buildCombo();

		    //$(GRID_NAME).hideCol("userNm");
		    //$(GRID_NAME).showCol("userNm");
		},
		jsonReader : {
			root: "rows",
			page: "page",
			total: "total",
			records: "records",
			repeatitems: false,
			cell: "cell",
			id: "id"
		},
		afterInsertRow: function(rowid, data) {
		    if (data.userNm == '엔타겟') {
		        $(GRID_NAME).setCell(rowid, 'userId', 'ntarget', {color:"red"});
		    }
		},
		ondblClickRow: function (rowid) {
			//var rowdata = $(GRID_NAME).getRowData(rowid);
			var rowdata = $.jgrid.getRowExtData(GRID_NAME, rowid);

			$(GRID_NAME).jqGrid('restoreRow',rowid);
		},
		onSelectRow: function(rowid, status) {
			fn_onSelectRow(rowid);
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:true} );

	// Multiple Header
	$(GRID_NAME).jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		groupHeaders:[
			{startColumnName: 'regiDate', numberOfColumns: 2, titleText: 'Date Line'}
		]
	});

	$(GRID_NAME).navButtonAdd('#pager', {
		caption:'',
		buttonicon:"ui-icon-plus",
		onClickButton: addRowMaster,
		position: "last",
		title:GRID_BTN_ADD,
		cursor: "pointer"
	});
});


function pickdates(id){
	$("#"+id+"_regiDate","#grid").datepicker({dateFormat:"yy-mm-dd"});
}

// Grid Add
function addRowMaster() {
	$(GRID_NAME).setColProp('userId', { editoptions: {size:25, maxlength:50}, hidden:false});	// hidden 숨겨진 컬럼을 edit 가능하게 한다.

	submitAddRow({
			gridName:GRID_NAME,
			url:SAVE_URL,
			width:600
	});
}

function fn_onSelectRow(rowid) {
	if (rowid){
		$(GRID_NAME).jqGrid('editRow', rowid, true, pickdates);
	}
}

function fn_buildCombo() {
	var url				= "/comm/listComboCode.do";
    var params		= {parentCode:"USER_TYPE"};
	var usertypes	= $.jgrid.gridComboObject(url, params);

	$(GRID_NAME).setColProp('userTypeNm', { editoptions: { value: usertypes} });
}

function onClickButton(mode) {
	switch(mode.toUpperCase()) {
		case "SEARCH":
			fn_search();
			break;
		case "SAVE":
			submitSave({
					gridName:GRID_NAME,
					url:MULTI_SAVE_URL,
					rtnFunc:'successReturn'
			});
			break;
		case "MULTISAVE":
			submitSave({
					gridName:GRID_NAME,
					url:MULTI_SAVE_URL,
					submitType:'inline',
					rtnFunc:'successReturn'
			});
			break;
		case "DELETE":
			submitDeleteRow({
					gridName:GRID_NAME,
					url:SAVE_URL
			});
			break;
	}
}

function fn_search() {
	var _userId = $("input[name$=schUserId]").val();
	var _userNm = $("input[name$=schUserNm]").val();

	//var currPage = $(GRID_NAME).getGridParam('page');
	//alert(currPage);

	$(GRID_NAME).jqGrid('setGridParam',{postData:{schUserId:_userId, schUserNm:_userNm,page:1}}).trigger("reloadGrid");
}

function doSearch(ev) {
	if (ev.keyCode != 13) {
		return false;
	}

	fn_search();
}

function successReturn(result) {
	if (result != undefined && result.testAlert != undefined ) {
		alert(result.testAlert);
	}

	fn_search();
}

function testFunction(val, col) {
	if (val == 'NONE')
		   return [false,"'NONE'는 입력 불가입니다."];
		else
		   return [true,""];
}