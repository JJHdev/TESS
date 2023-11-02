var GRID_NAME		= "#grid";
var SEARCH_URL		= "/temp/getSampleChart.do";

$(function() {
	$(GRID_NAME).jqGrid({
		url:SEARCH_URL,
		datatype: 'json',
		mtype: 'GET',
		caption:caption,
		colNames:colNames,
		colModel:[
				{name:'menuNm',index:'menu_nm', width:200},
				{name:'cnt',index:'cnt', width:100, align:"right"},
				{name:'rate',index:'rate', width:100, align:"right"},
				{name:'lastDay',index:'regi_date', width:100, sorttype:"date", align:"center"}
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
		loadComplete: function(data) {
			// Chart 생성 (챠트종류, 챠트ID, 챠트데이터)
	        chartDraw('BAR', 'chart1', makeChartData(data));
		},
        loadError : function(xhr,st,err) {
        	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
	});

	$(GRID_NAME).jqGrid('navGrid','#pager',{ edit:false,add:false,del:false,view:false,search:false,refresh:true} );

});



/*
 * Chart 데이터 생성
*/
function makeChartData(data) {
	/*
    var datas 	= [[10,5,15,20], [20,30,10,5]];
    var ticks 	= ['1월', '2월', '3월', '4월'];
    var labels 	= [{label:'ntarget'},{label:'otamot'}];

    return {dataArr:datas, labelArr:labels, ticks:ticks};
	 */

	var datas 	= [];
    var ticks 	= [];
    var labels 	= [];

    var datarows = data.rows;
    var data	= new Array();

    // Data 만들기.
    for(var i =0; i < datarows.length; i++) {
    	if (1 == Number(datarows[i].chartSeq)) {
    		ticks.push(datarows[i].chartNm);
    	}

		if (i < Number(datarows[i].chartSeq)) {
			labels.push({label:datarows[i].chartLabel});
		}

        if ((i+1) == datarows[i].chartSeq) {
            data[datarows[i].chartSeq-1] = [];
        }

		data[datarows[i].chartSeq-1].push(Number(datarows[i].chartVal));
    }

    for (var n = 0; n < data.length; n++) {
    	datas.push(data[n]);
    }

    return {dataArr:datas, labelArr:labels, ticks:ticks};
}

function chartDraw(chartType, chartId, data) {
	// BAR Chart
	if (chartType == 'BAR') {
		$.jqplot(chartId, data.dataArr , {
			title: '',
			seriesDefaults: {
				renderer:$.jqplot.BarRenderer,
				pointLabels: {
					show: false,
					formatString:'%s'
				},
				rendererOptions: {
					  varyBarColor: false
					, barWidth: 8
					, barPadding: 3
				}
			},
			series: data.labelArr ,
			legend: {
				show: true,
				location: 'e',
				placement: 'outside'
			},
			axes: {
				xaxis: {
					renderer: $.jqplot.CategoryAxisRenderer,
					ticks: data.ticks
				}
			}
		});
	}

	// PIE Chart
	if (chartType == 'PIE') {

	}
}