var GRID_NAME	= "#grid";
var SEARCH_URL	= "/sys/role/getNotRoleByMenuList.do";
var SAVE_URL		= "/sys/role/saveRoleByMenuMgmt.do";

var DETAIL_GRID_NAME	= "#grid_detail";
var DETAIL_SEARCH_URL	= "/sys/role/getRoleByMenuList.do";
var DETAIL_SAVE_URL		= "/sys/role/saveRoleByMenuMgmt.do";

$(function() {
	var selRoleId	= $("select[name$=roleId]").val();

	/***********************    Master GRID    *******************/
	$(GRID_NAME).jqGrid({
		url:SEARCH_URL+'?mode=Y',
		datatype: 'json',
		mtype: 'GET',
		caption: caption,
		colNames: colnames,
		colModel:[
				{name:'menuId', index:'menu_id', width:100
						, sortable:false
						, editable:false},
				{name:'menuNm', index:'menu_nm', width:200
						, sortable:false
						, editable:false}
		],
		rowNum:0,
		rowList:[],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager',
		sortname: 'menu_id',
		sortorder: 'asc',
		multiselect: true,
		multiboxonly: true,
		shrinkToFit:true,
		pginput:false,
		pgbuttons:false,
		viewrecords: true,
		postData: { roleId: selRoleId},
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
			doAction('right');
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:true} );


	/***********************    Detail GRID    *******************/
	$(DETAIL_GRID_NAME).jqGrid({
		url:DETAIL_SEARCH_URL+'?mode=Y',
		datatype: 'json',
		mtype: 'GET',
		caption : caption_detail,
		colNames: colnames_detail,
		colModel:[
				{name:'roleId', index:'role_id', width:150
						, sortable:false
						, editable:false},
				{name:'menuId', index:'menu_id', width:120
						, sortable:false
						, editable:false},
				{name:'menuNm', index:'menu_nm', width:250
						, sortable:false
						, editable:false}
		],
		rowNum:0,
		rowList:[],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager_detail',
		sortname: 'menu_id',
		sortorder: 'asc',
		multiselect: true,
		multiboxonly: true,
		shrinkToFit:true,
		pginput:false,
		pgbuttons:false,
		viewrecords: true,
		postData: { roleId: selRoleId},
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
			doAction('left');
		},
		loadError : function(xhr,st,err) {
			$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
		}
	}).navGrid('#pager_detail', {edit:false,add:false,del:false,view:false,search:false,refresh:true} );

});


/********************    General  ********************/
function fn_search() {
	var roleId	= $("select[name$=roleId]").val();

	var postData	= {
			roleId:roleId
	}

	$(GRID_NAME).jqGrid('setGridParam',{postData:postData}).trigger("reloadGrid");
	$(DETAIL_GRID_NAME).jqGrid('setGridParam',{postData:postData}).trigger("reloadGrid");
}

function doAction(mode) {
	var roleId	= $("select[name$=roleId]").val();

	switch(mode.toUpperCase()) {
		case "RIGHT":
			submitSave({
					gridName:GRID_NAME,
					url:SAVE_URL,
					userData:'{"operMode":'+'"'+mode+'", "roleId":'+'"'+roleId+'"}',
					rtnFunc:'successReturn'
			});

			break;
		case "LEFT":
			submitSave({
					gridName:DETAIL_GRID_NAME,
					url:DETAIL_SAVE_URL,
					userData:'{"operMode":'+'"'+mode+'", "roleId":'+'"'+roleId+'"}',
					rtnFunc:'successReturn'
			});

			break;
	}
}

function successReturn() {
	fn_search();
}