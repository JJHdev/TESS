var GRID_NAME	= "#grid";
var SEARCH_URL	= "/sys/log/getAccHist.do";
var BORDER_BOTTOM_VAL = "";

$j(function() {

	var _schFromYear	= $j("select[name$=schFromYear]").val();
	var _schFromMonth	= $j("select[name$=schFromMonth]").val();
	var _schToYear		= $j("select[name$=schToYear]").val();
	var _schToMonth		= $j("select[name$=schToMonth]").val();

	/***********************    GRID    *******************/
	$j(GRID_NAME).jqGrid({
		url:SEARCH_URL+'?mode=Y',
		datatype: 'json',
		mtype: 'GET',
		caption: caption,
		colNames: colnames,
		autoencode: false,
		postData:{	schFromYear:_schFromYear,
					schFromMonth:_schFromMonth,
					schToYear:_schToYear,
					schToMonth:_schToMonth},
		colModel:[
					{name:'parentNm',	index:'parentNm', 	width:95, editable:true, sortable:true},
					{name:'menuDesc',	index:'menuDesc', 	width:180, sortable:false, editrules:{required:true}, align:"left"},
					{name:'btnRate',	index:'btnRate', 	width:125, editable:true, align:"left"},
					{name:'accRate',	index:'accRate', 	width:60, editable:true, align:"right", formatter:'currency', formatoptions:{suffix:"%"}},
					{name:'cnt',		index:'cnt',        width:60, sortable:false,editoptions:{readonly:true,size:10}, formatter:'integer', align:"right"},
					{name:'accDate',	index:'accDate', 	width:50, editable:true, align:"center", sortable:true},
					{name:"parentId",   index:'parentId', 	hidden:true}
		],
		rowNum:0,
		rowList:[],
		height: 276,
		rownumbers: true,
		autowidth: true,
		pager: '#pager',
		sortname: '',
		sortorder: '',
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
		afterInsertRow: function(rowid, data) {
			//fn_afterInsertRow(rowid, data);
			// set rowspan style
	        if(rowid != 1) {
	            var preRowData = $j(GRID_NAME).getRowData(rowid-1);

	            if(preRowData.parentId == data.parentId) {
	                var cellFavoNms = ["parentNm"];
	                for(var i=0;i<cellFavoNms.length;i++){
	                    $j(GRID_NAME).setCell(rowid-1, cellFavoNms[i], "", {"border-bottom":BORDER_BOTTOM_VAL});
	                    $j(GRID_NAME).setCell(rowid  , cellFavoNms[i], " ");
	                }
	            }
	        }

		},
		loadComplete: function(data) {
			var filetable = document.getElementById("grid");
        	var ids = filetable.rows.length-1;
            for(var i = 1; i <= ids; i++) {
                var rowData = jQuery('#grid').getRowData(i);
                var accRate = rowData["accRate"];

                // 수정 버튼 처리
                var btnModify = "";
                btnModify = "<ul style='float:left;width:180px;'><li style='margin: 2px 2px 1px 0;width:" + accRate + "%;height:20px;background-color:#FFFF00;'><span ><a href='#' ></a></span></li></ul>";
               	$j(GRID_NAME).setRowData(i, {"btnRate":btnModify});

            }
		},
        loadError : function(xhr,st,err) {
        	$j("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$j(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:true} );


});


/********************    General  ********************/
function fn_afterInsertRow(row, rowdata) {
	switch (rowdata.lvl) {
		case 0:
			$j(GRID_NAME).setRowData(row, {menuDesc:rowdata.menuDescOrg});
		break;
		case 1:
			$j(GRID_NAME).setRowData(row, {menuDesc:'&nbsp;&nbsp;  ┕ '+ rowdata.menuDescOrg});
		break;
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
	var searchParentId	= $j("select[name$=parentId]");
	var searchMenuDesc	= $j("input[name$=menuDesc]");
	var _schFromYear	= $j("select[name$=schFromYear]");
	var _schFromMonth	= $j("select[name$=schFromMonth]");
	var _schToYear		= $j("select[name$=schToYear]");
	var _schToMonth		= $j("select[name$=schToMonth]");

	//From Year
	if (!isEmpty(_schFromMonth.val())&&_schFromMonth.val() !='all'){
		if (isEmpty(_schFromYear.val())||_schFromYear.val()=='all'){
			alert(MSG_RELT_1001);
			_schFromYear.focus();
			return false;
		}
	}
	//To Year
	if (!isEmpty(_schToMonth.val())&&_schToMonth.val() !='all'){
		if (isEmpty(_schToYear.val())||_schToYear.val()=='all'){
			alert(MSG_RELT_1001);
			_schToYear.focus();
			return false;
		}
	}

	var postData	= {
			parentId:searchParentId.val(),
			menuDesc:searchMenuDesc.val(),
			schFromYear:_schFromYear.val(),
			schFromMonth:_schFromMonth.val(),
			schToYear:_schToYear.val(),
			schToMonth:_schToMonth.val()
	}

	$j(GRID_NAME).jqGrid('setGridParam',{postData:postData}).trigger("reloadGrid");
}
