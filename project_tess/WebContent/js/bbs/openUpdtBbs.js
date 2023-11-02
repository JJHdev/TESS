/*
 * @(#)openUpdtBbs.js 1.0 2014/11/07
 * 
 * COPYRIGHT (C) 2006 CUBES CO., INC.
 * ALL RIGHTS RESERVED.
 */

/**
 * 공통 게시판 수정
 *
 * @author SYM
 * @version 1.0 2014/11/07
 */

//---------------------------------
// Global 변수
//---------------------------------

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
    $("#cnfmBtn").click(function(e){
//    	doUpdt();
    	_onSubmit(e);
    });

    // 취소버튼 처리
    $("#cncleBtn").click(function(){
    	doView();
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
//action 로직
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//상세보기로 이동
function doView(){
	var form = jQuery('#model');
	var bbs_type = jQuery('#bbs_type').val();
	if(bbs_type == 'B01'){
		form.attr("action","/bbs/viewBbsNotice.do");
	}else if(bbs_type == 'B02'){
		form.attr("action","/bbs/viewBbsQna.do");
	}else if(bbs_type == 'B03'){
		form.attr("action","/bbs/viewBbsFaq.do");
	}
	
	form.submit();
}

//수정처리
function doUpdt(){
	
	var form = jQuery('#model');

	if(jQuery('#bbsSubject').val()==""){
		nAlert(MSG_BBS_B004);
		jQuery('#bbsSubject').focus();
		return;
	}else if(jQuery('#docuKind').val()==""){
		if(jQuery('#bbs_type').val()=='B11'){
			nAlert('공지구분을 선택해주시기 바랍니다.');
		}else if(jQuery('#bbs_type').val()=='B02'){
			nAlert('업무구분을 선택해주시기 바랍니다.');
		}else if(jQuery('#bbs_type').val()=='B03'){
			nAlert('관련사례를 선택해주시기 바랍니다.');
		}
		jQuery('#docuKind').focus();
		return;
	}else if(jQuery('#bbsDesc').val()==""){
		nAlert(MSG_BBS_B005);
		jQuery('#bbsDesc').focus();
		return;
	} 

	//자기 내용만 검색가능하도록 변경
//	if(jQuery('#bbs_type').val()=='B02'){
//		if(jQuery("input[name='openYn']:checked").val()==null){
//			nAlert(MSG_BBS_B003);
//			jQuery('#openYn').focus();
//			return;                        
//		}  
//	}
	
    // submit 처리하기 전에 file 객체 form name 정리 (순차적으로 정리, upfile0, upfile1...)
    initFileFormNm();

    form.attr({
        "method" :"post"
       ,"action" :"/bbs/updtBbs.do"
       ,"enctype":"multipart/form-data"
    });

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
	    success: function(result) {
	    	$("#progress").hide();
	    	if(result.flag=='true'){
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
//  var fullFileNm = fileObj.val();
////  var fileAreaObj = fileObj.parent();
//  
//  // 허용된 파일 타입
//  if(isAtthAllowedFileType(fullFileNm, allowedExtNms) == true){
//      // 허용
//      return true;
//  }
//  // 허용되지 않은 파일 타입.
//  else{
//      //  : "첨부한 파일이 허용된 파일 유형이 아닙니다."
//  	nAlert(MSG_COMM_2012);     
//      return false;
//  }
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
	       addDeltDatasInfo("ArrdelFileNo", delGrp.find("input[name=delChk]").val() );
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

//File Download
function download(fileNoVal) {
// document.location.href = ROOT_PATH +"/comm/fileDownload.do?orgFileName="+orgFileName+"&filePath="+filePath+"&fileName="+fileName;
    comutils.fileDownload({"fileNo":fileNoVal});
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//네이버 스마트 에디터
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//스마트 에디터에서 값을 textarea 넣어줌
function _onSubmit(elClicked){
	 oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);    // 에디터의 내용이 textarea에 적용된다
	  // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	  try{
		  doUpdt();;  //폼검사 메소드 호출
	 }catch(e){}
}


