/****************************************************************
 *
 * File Name		: board.js
 * Description	: Function JavaScript
 *
 *    Date				author		Version        Function Name
 * ---------------    -----------   -----------  ----------------------------
 * 2012.03.05	      hschoi        1.0           First Coding.
 *
 *
 * **************************************************************/
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

    // 저장버튼 처리
    $("#cnfmBtn").click(function(e){
//    	doRegi();
    	_onSubmit();
    });

    // 취소버튼 처리
    $("#cncleBtn").click(function(){
    	doList();
    });

});

//리스트로 이동
function doList(){
	var form = jQuery('#model');
//	form.action= "/cust/listCustBbs.do";
	form.attr("action","/bbs/viewBbsQna.do");
	form.submit();
}


//등록처리
function doRegi(){
	var form = jQuery('#model');

	if(jQuery('#bbsSubject').val()==""){
		nAlert(MSG_BBS_B004);
		jQuery('#bbsSubject').focus();
		return;
	}else if(jQuery('#bbsDesc').val()==""){
		nAlert(MSG_BBS_B005);
		jQuery('#bbsDesc').focus();
		return;
	}


    form.attr({
        "method" :"post"
       ,"action" :"/bbs/regiBbs.do"
       ,"enctype":"multipart/form-data"
    });

    jQuery('#docuKind').attr("disabled",false);

   form.submit();

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

//파일 첨부시 - onChangeFileObj()을 미사용했을 때의 메소드 2015-03-13 sym
function fn_checkFileObjValid(obj){
	
	var fileObj = $(obj);
	var fullFileNm = fileObj.val();
	
	//inputBox 위치
	var fileTextObj = fileObj.parent().parent().find("input[name=upfilePath]"); 
	alert(fullFileNm);
	// 허용된 파일 타입
	alert(_ALLOWED_FILE_EXTS);
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


/**
 * 자료첨부를 다운로드 한다.
 *
 * @param fileSn String - 파일 일련번호
 * @param fileId String - 파일 아이디
 */
//File Download
function download(filePath, fileName, orgFileName) {
 document.location.href = ROOT_PATH +"/comm/fileDownload.do?orgFileName="+orgFileName+"&filePath="+filePath+"&fileName="+fileName;
}

//스마트 에디터에서 값을 textarea 넣어줌
function _onSubmit(elClicked){
	 oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용된다
	  // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	  try{
		  doRegi();;  //폼검사 메소드 호출
	 }catch(e){}
}
