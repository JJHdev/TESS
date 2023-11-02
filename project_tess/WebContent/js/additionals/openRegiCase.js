/*
 * @(#)openRegiBbs.js 1.0 2014/11/07
 * 
 * COPYRIGHT (C) 2006 CUBES CO., INC.
 * ALL RIGHTS RESERVED.
 */

/**
 * 공통 게시판 등록
 *
 * @author SYM
 * @version 1.0 2014/11/07
 */

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var GRID_URL      = ROOT_PATH+"/additionals/getBusinessList.do" ;
var POPUP_URL 	   = ROOT_PATH+"/additionals/openFindBusi.do";

// 첨부 허용 파일 확장명
var _ALLOWED_FILE_EXTS = "";

$(document).ready(function(){

    //---------------------------------
    // load init
    //---------------------------------

    // a 링크를 안되게 처리.
    $(".button").find("a").attr("href", "javascript:");

    //---------------------------------
    // event
    //---------------------------------
    
    $("#strDate").toCalendarField( false );

    // 저장버튼 처리
    $("#cnfmBtn").click(function(){
//    	doRegi();
    	_onSubmit();
    });

    // 취소버튼 처리
    $("#cncleBtn").click(function(){
    	doList();
    });
    
    //  사업 선택 버튼 처리
    $("#selBtnCommit").click(function(targetId){
    	loadGrid();
    });
    
    // 사업 검색 버튼 처리
    $("#prcBtnSrch").click(function(targetId){
    	fn_search(1);
    });
    	
    $("#prcBtnSect").click(function(targetId){
    	goSelect();
    });
    
    // 파일 영역 추가 삭제 버튼 이벤트 연결
    $("._dyFileBtnAddCls, ._dyFileBtnRemvCls").bind({
        click : function(){
            if($(this).hasClass("_dyFileBtnAddCls")){
                addFileObj($(this));
            }
            else{
                removeFileObj($(this));
            }
        }
    });
    
    $("#progress").hide();
}); 

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//화면 처리 관련 및 이벤트
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// action 로직
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


//리스트로 이동
function doList(){
	var form = jQuery('#model');
	
	form.attr("action","/additionals/listExcelntCase.do");
	
	form.submit();
}

//등록처리
function doRegi(){
	
	var form = jQuery('#model');
	
	 var addNotRequiredNmArry = null;
	 
	 addNotRequiredNmArry =  ["upfilePath","upfile0"];
	 
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// 기본정보 검사
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~        
	 	// 임시 주석처리
	    //isValid = fn_validationUscmArea("model", addNotRequiredNmArry);
	 	isValid = true;
		if(jQuery('#caseSubject').val()==""){
			nAlert(MSG_BBS_B004);
			jQuery('#caseSubject').focus();
			return;
		} else if(jQuery('#busiNm').val()==""){
			nAlert(MSG_ADDT_A001);
			jQuery('#busiNm').focus();
			return;
		} else if(jQuery('#caseDesc').val()==""){
			nAlert(MSG_BBS_B005);
			jQuery('#caseDesc').focus();
			return;
		}
	if(isValid){
	// submit 처리하기 전에 file 객체 form name 정리 (순차적으로 정리, upfile0, upfile1...)
		initFileFormNm();

	    form.attr({
	        "method" :"post"
	       ,"action" :"/additionals/regiCase.do" 
	       ,"enctype":"multipart/form-data"
	    });

    	form.submit(); 
	}

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
	var objBusiId = $("#targetId").val();
	var objBusiNm = objBusiId.replace("Id", "Nm");
	
	if(params != null){

		var flag =  objParams.flag;

		var rowData = params.rowdata;
		
		
		if(flag){
			nAlert("사업을 하나씩 선택해 주세요");
		    // REFRESH 처리
		    $(GRID_NAME).trigger('reloadGrid');
		    params = null;
		}else{
			var businessNm = rowData.busiNm;
			var businessNo = rowData.busiNo;
			
			$("#evaluBusiNm").val(businessNm);
			$("#evaluBusiId").val(businessNo);
			$("#prcBtnCnle").click();
		}
	}else {
		nAlert("사업을 선택해 주세요");
	}
}

////////////////////////////////////////////////////////////////////////////////
//Grid 관련
////////////////////////////////////////////////////////////////////////////////

var colNames = null;
var colModel = null;
var captionTitle = "";
var params;

function loadGrid() {
// 메뉴 구분에 따라 col정보 설정.
setGridInfoByMenu();

$(GRID_NAME).jqGrid({
   url          : GRID_URL,
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

//메뉴 구분에 따라 col정보 설정.
function setGridInfoByMenu(){

   colNames = ["사업번호", "사업명", "지역", "사업단계", "최종평가결과", "평가일"];
   colModel = [
               {name:'busiNo',     index:'busiNo' ,     width:100, editable:false, sortable:false, align:"center", hidden:true},
               {name:'busiNm',     index:'busiNm' ,     width:120, editable:false, sortable:false, align:"center"},
               {name:'addr12',     index:'addr12',     width:120, editable:false, align:"left"},
               {name:'evaluStage', index:'evaluStage', width:100, editable:false, align:"center"},
               {name:'convFinalEvaluFnd',     index:'convFinalEvaluFnd',       width: 70, editable:false, align:"center"}, 
               {name:'convEvaluDate',     index:'convEvaluDate',       width: 80, editable:false, align:"center"}, 
               ];
   captionTitle = "평가사업 리스트"; 

}

//그리등 paramter 구성.
function getSearchPostData(){
	var postData = {
	       //srchBusiAddr1  : $("#srchBusiAddr1" ).val(),
	       //srchBusiAddr2  : $("#srchBusiAddr2" ).val(),
	       srchBusiNm   : $("#srchBusiNm").val(),
	       busiStg : $("#busiStg").val(),
	}

	return postData;
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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//파일 사이즈 검사
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//파일 첨부 대화상자에서 값을 선택했을 때 이벤트 ( 파일 사이즈 체크) --- 익스 10이하는 안되서 메소드로 변경 2015.03.13 sym
function onChangeFileObj(obj){
	
	var fileObj = $(obj);
	var params = jQuery('#model').serialize();	// 폼 에 있는 값들
	var bar = $('.bar');
	var percent = $('.percent');
	var status = $('#status');
	
	$('#model').ajaxSubmit({
	        url: "/comm/fileSizeCheck.do", 
	        type: "POST",
	        data:params, 
	        dataType:"json",
	        contentType:"application/json; text/html; charset=utf-8",
	    beforeSubmit : function(){
	    	if(fn_checkFileObjValid(fileObj,_ALLOWED_FILE_EXTS)){	//서밋하기전에 파일 확장자 검사
	    		return true;
	    	}else{
	    		return false;
	    	}	
		},
	    uploadProgress: function(event, position, total, percentComplete) {
	    	$("#progress").show();
	        var percentVal = percentComplete + '%';
	        bar.width(percentVal)
	        percent.html(percentVal);
			//console.log(percentVal, position, total);
	    },
	    success: function(responseText, statusText, xhr, $form) {
	    	$("#progress").hide();
	    	if(responseText.flag=='true'){
		        var fileTextObj = fileObj.parent().parent().find("input[name=upfilePath]");
		        // file 객체의 값을 파일 input:text에 찍어준다.
		        fileTextObj.val(fileObj.val());
	    	}else{
	    		nAlert(MSG_COMM_C006); 
	    		return false; 
	    	} 
	    },
	    error:function(request, status, error) {
	     if(request.status=='404'){
	    	 alert(error); 
	    	 return false;
	     }else {
	    	 nAlert(MSG_COMM_1002); 
	    	 return false;
	     }
	    }
	}); 
}





//파일 첨부시 - onChangeFileObj()을 사용했을 때의 메소드 2015.03.13 sym
//function fn_checkFileObjValid(fileObj,allowedExtNms){
//    
//    var fullFileNm = fileObj.val();
////    var fileAreaObj = fileObj.parent();
//    
//    // 허용된 파일 타입
//    if(isAtthAllowedFileType(fullFileNm, allowedExtNms) == true){
//        // 허용
//        return true;
//    }
//    // 허용되지 않은 파일 타입.
//    else{
//        //  : "첨부한 파일이 허용된 파일 유형이 아닙니다."
//    	nAlert(MSG_COMM_2012);     
//        return false;
//    }
//}

//파일 첨부시 - onChangeFileObj()을 미사용했을 때의 메소드 2015-03-13 sym
function fn_checkFileObjValid(obj){
	
	var fileObj = $(obj);
	var fullFileNm = fileObj.val();
	
	//inputBox 위치
	var fileTextObj = fileObj.parent().parent().find("input[name=upfilePath]");
	
	// 허용된 파일 타입
	if(isAtthAllowedFileType(fullFileNm, _ALLOWED_FILE_EXTS) == true){
        // file 객체의 값을 파일 input:text에 찍어준다.
        fileTextObj.val(fileObj.val());
	}
	// 허용되지 않은 파일 타입.
	else{
		//  : "첨부한 파일이 허용된 파일 유형이 아닙니다."
		nAlert(MSG_COMM_2012);   
		
        // 파일 객체 재 생성.
        var newObj = DYCom.reCreateFileObj(fileObj);
        
        // file path  제거 : file 객체가 초기화 되기 때문에 제거 해야 함.
        fileTextObj.val("");
	}
}

//============================
//파일객체 컨트롤 버튼 함수
//============================

//파일 객체 추가 이벤트 함수
function addFileObj(fileBtnObj){
 
 var topWrapObj = fileBtnObj.parents("td").parents("tr").next("tr").children("td");
 
 // 객체 추가  
 DYUtils.actionDyUnit({
     unitType   :"group",
     procType   :"add",
     dyAreaObj  :topWrapObj.find("._dyFileAreaCls"),
     afterAdd   :function(preGrp, newGrp){
         
         // '추가'를 클릭했을 때 file form이 다음 라인으로 떨어지게 추가.
         //newGrp.before("<br/>");
     },
     // 파일 객체 change 이벤트
     changeFile : function(fileObj){
         changeFile(fileObj);
     }
 });
 
}

//파일객체 제거 이벤트 함수
function removeFileObj(fileBtnObj){
 
	 var topWrapObj = fileBtnObj.parents("td").parents("tr").next("tr").children("td");
 
 if(topWrapObj.find("input[name=delChk]:checked").size() == 0) {
     nAlert("삭제대상을 선택하세요.")
     return;
 } 
 
 // 첨부된 파일 객체 제거 로직
 DYUtils.actionDyUnit({
     unitType     :"group",
     procType     :"remove",
     dyAreaObj    :topWrapObj.find("._attachedFileArea"),
     dyGrpClassNm :"_dynamicFileGroup",
     isRemoveLastUnit : true,            // 마지막 unit을 제거하게 함.
     beforeRemove :function(delGrp){
         
         // 삭제되는 첨부된파일의 todeFileNo를 삭제대상 문자열에 추가
         addDeltDatasInfo("deltFileDatas", delGrp.find("input[name=delChk]").val() );
     }
 });
 // 신규 파일첨부 객체 제거 로직
 DYUtils.actionDyUnit({
     unitType     :"group",
     procType     :"remove",
     dyAreaObj    :topWrapObj.find("._dyFileAreaCls"),
     beforeRemove :function(delGrp){
         
     },
     // 파일 객체 change 이벤트
     changeFile : function(fileObj){
         changeFile(fileObj);
     }
 });
}

//삭제 대상의 pk 또는 고유 분값을 삭제 대상 문자열 form에 추가 처리
//-> 추후 대상을 일괄 삭제 함.
function addDeltDatasInfo(deltDatasId, addVal){
 var deltDatasObj = $("#"+deltDatasId);
 
 // 삭제될 row의 pk를 문자열로 저장.
 var pkDatasStr = deltDatasObj.val();
 if(!isEmpty(addVal)){
     deltDatasObj.val( pkDatasStr + ( isEmpty(pkDatasStr)? "":"," ) + addVal );
 }
}

//파일 객체 change 이벤트 
function changeFile(fileObj){
	//Nothing to do
}


//Arrange the file names
function initFileFormNm() {
    var fIdx = 0;
    $("input:file[name^=upfile]").each(function(){
        $(this).attr("name", "upfile"+fIdx);
        fIdx ++;
    });
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//네이버 스마트 에디터
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//스마트 에디터에서 값을 textarea 넣어줌
function _onSubmit(elClicked){
	 oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용된다
	  // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	  try{
		  doRegi();;  //폼검사 메소드 호출
	 }catch(e){}
}

