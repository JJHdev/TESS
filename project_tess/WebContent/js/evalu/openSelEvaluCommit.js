/**
 * 사업평가관리 평가위원 선택 팝업화면
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
var SEARCH_URL      = ROOT_PATH+"/evalu/getEvaluCommit.do" ;

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
var params;

function loadGrid() {
	
    // 메뉴 구분에 따라 col정보 설정.
    setGridInfoByMenu();
    
    $(GRID_NAME).jqGrid({
        url          : SEARCH_URL,
        datatype     : 'json',
        mtype        : 'POST',
        caption      : captionTitle,
        colNames     : colNames,
        postData     : getSearchPostData(),
        colModel     :colModel,
        rowNum:10,
        rowList:[5,10,15],
        height: 276,
        rownumbers: true,
        rownumWidth:40,
        autowidth: true,
        pager: '#pager',
        //sortname: 'join_date',
        //sortorder: 'DESC',
        viewrecords : true,
        multiselect : true,
        multiboxonly: false,
        shrinkToFit : false,
        jsonReader      : {
            root        : "rows",
            page        : "page",
            total       : "total",
            records     : "records",
            repeatitems : false,
            cell        : "cell",
            id          : "id"
        },
        afterInsertRow : function(rowid, rowdata, rowelem) {
        },
        onSelectRow: function(rowid, status) {
        	params = fn_onSelectRow(rowid,status);
        },
        ondblClickRow: function (rowid) {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
            grid_onCellSelect(rowid, iCol, cellcontent, e)
        },
        loadComplete: function(data) {
        },
        //multiselect : true 시 헤더 체크박스를 눌렀을 경우 동작하는 함수
        onSelectAll: function(rowid,status){
        },
        loadError : function(xhr,st,err) {
          $("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
        }
    });

}

// 메뉴 구분에 따라 col정보 설정.
function setGridInfoByMenu(){
     
        colNames = ["평가위원명", "지역", "분야", "소속", "평가위원 아이디"];
        colModel = [
                    {name:'userNm',     index:'user_nm' ,     width:150, editable:false, sortable:false, align:"center"},
                    {name:'busiAddr12',     index:'evalu_busi_nm',     width:210, editable:false, align:"left"},
                    {name:'attach', index:'attach', width:150, editable:false, align:"center"},
                    {name:'occupa',     index:'occupa',       width: 120, editable:false, align:"center"}, 
                    {name:'userId',     index:'user_id',       width: 120, editable:false, align:"center", hidden:true}, 
                    ];
        captionTitle = "평가위원 리스트"; 

}

// 그리등 paramter 구성.
function getSearchPostData(){
    var postData = {
            srchBusiAddr1  : $("#srchBusiAddr1" ).val(),
            srchBusiAddr2  : $("#srchBusiAddr2" ).val(),
            srchBusiType   : $("#srchBusiType"  ).val(),
            srchEvaluCommNm : $("#srchEvaluCommNm").val(),
    }
    
    return postData;
}

////////////////////////////////////////////////////////////////////////////////
// 그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

// row 클릭 이벤트 함수
function grid_onCellSelect(rowid, iCol, cellcontent, e){
	
}


////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////



// 지역 검색조건 combo loading
function loadBusiAddrCombo(){
    
    //시도 선택시 지자체(구군) 검색
    comutils.changeCityAuth({
        loading : true,
        citysido: "srchBusiAddr1Temp",
        cityauth: "srchBusiAddr2Temp",
        initcity: "srchBusiAddrVal",
        init    : function(){
            
            // hidden 검색조건에 동기화
            setSearchCond();
            
            var srchBusiAddrVal = $("#srchBusiAddr2").val();
            if(isEmpty(srchBusiAddrVal)){
                srchBusiAddrVal = $("#srchBusiAddr1").val();
            }

            if(!isEmpty(srchBusiAddrVal) && srchBusiAddrVal.substring(2,4) == "00"){
                $("#srchBusiAddr2Temp option:eq(1)").attr("selected", "selected");
                $("#srchBusiAddr2Temp").val("");
            }
            
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
        case 'prcBtnSect':            // 평가위원 선택
            goSelect();
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
    $('#srchEvaluBusiNmTemp').keypress(function(e){
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
    
    $("#srchBusiAddr1" ).val($("#srchBusiAddr1Temp" ).val());
    $("#srchBusiAddr2" ).val($("#srchBusiAddr2Temp" ).val());
    $("#srchBusiType"  ).val($("#srchBusiTypeTemp"  ).val());
    $("#srchEvaluCommNm").val($("#srchEvaluCommNmTemp").val());
    
    var srchBusiAddrVal = $("#srchBusiAddr2").val();
    if(isEmpty(srchBusiAddrVal)){
        srchBusiAddrVal = $("#srchBusiAddr1").val();
    }
    $("#srchBusiAddrVal").val(srchBusiAddrVal);
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

//평가위원 선택
function goSelect(){
	
	var objParams = params;
	var objCommId = $("#targetId").val();
	var objCommNm = objCommId.replace("Id", "Nm");
	
	if(params != null){

		var flag =  objParams.flag;

		var rowData = params.rowdata;
		
		
		if(flag){
			nAlert("평가위원을 한명씩 선택해 주세요");
		    // REFRESH 처리
		    $(GRID_NAME).trigger('reloadGrid');
		    params = null;
		}else{
			
			var commitNm = rowData.userNm;
			var commitId = rowData.userId;
			
			var arrEvaluComm = "";
			$(opener.document).find("._objCommId").each(function(){
				var evaluComm  = this.value;
				if(!isEmpty(evaluComm)){
					arrEvaluComm +=(isEmpty(arrEvaluComm))? evaluComm : ","+evaluComm;
				}	
			});
			
//			var arrEvaluComm = $(opener.document).find("#evaluCommId1").val()+","+$(opener.document).find("#evaluCommId2").val()+","+$(opener.document).find("#evaluCommId3").val();
			var isCnfm = false;
			
			if(arrEvaluComm.length < 1){
				arrEvaluComm = commitId;
				isCnfm = true;
			}else{
				
				if(arrEvaluComm.indexOf(commitId)<0){
					isCnfm = true;
				}else{
					nAlert("중복된 평가위원을 선택 할 수 없습니다.")
					isCnfm = false;
				    $(GRID_NAME).trigger('reloadGrid');
				    params = null;
				}
			}
			
			if(isCnfm){
				$(opener.document).find("#"+objCommNm).val(commitNm);
				$(opener.document).find("#"+objCommId).val(commitId);
				$(opener.document).find("#arrEvaluComm").val(arrEvaluComm);
				window.close();
			}
		}
	}else {
		nAlert("평가위원을 선택해 주세요");
	}
}

////////////////////////////////////////////////////////////////////////////////
//콘트롤 함수
////////////////////////////////////////////////////////////////////////////////

function fn_onSelectRow(rowid) {

	var flag = null;
	var arrData = new Array();
	var rowdata = null;

	//체크박스를 선택한 rowid를 구함
	var arrRowId = $(GRID_NAME).getGridParam('selarrrow');
	
	if(arrRowId.length==1){
		rowdata = $.jgrid.getRowExtData(GRID_NAME, arrRowId);
		params = {
				rowdata: rowdata,				//Rowdata
				flag: false		//1개 TRUE, 1개이상 FALSE
		    };
	}else if(arrRowId.length>1){
		params = {
				rowdata: rowdata,				//Rowdata
				flag: true		//1개 TRUE, 1개이상 FALSE
		    };
	}else{
		params = null;
	}

	return params;
}

