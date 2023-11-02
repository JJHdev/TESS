/*
 * @(#)openRegiBbs.js 1.0 2014/11/07
 * 
 * COPYRIGHT (C) 2006 CUBES CO., INC.
 * ALL RIGHTS RESERVED.
 */

/**
 * 공통 게시판 상세화면
 *
 * @author SYM
 * @version 1.0 2014/11/07
 */


	$(document).ready(function (){
		
	    //---------------------------------
	    // event
	    //---------------------------------

	    // 수정버튼 처리
	    $("#_openUpdtBtn").click(function(){
	    	doOpenUpdt();
	    });

	    // 저장버튼 처리
	    $("#_delBtn").click(function(){
	    	doDel();
	    });

	    // 취소버튼 처리
	    $("#cncleBtn").click(function(){
	    	doList();
	    });

	    // 답글 페이지로 이동
	    $("#_openRegiRepyBtn").click(function(){
	    	doOpenRegiReply();
	    });

	    // 답글 수정페이지로 이동
	    $("#_openUpdtRepyBtn").click(function(){
	    	doOpenUpdtReply();
	    });

	});
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//화면 처리 관련 및 이벤트
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// action 로직
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

	function doList(){
		var form = jQuery('#model');
		form.attr("action","/additionals/listExcelntCase.do");
		form.submit();
	}

	//수정화면이동
	function doOpenUpdt(){
		var form = jQuery('#model');
		form.attr("action","/additionals/openUpdtCase.do");
		form.submit();
	}

	//삭제처리
	function doDel(){
		var form = jQuery('#model');
		nConfirm(MSG_BBS_B002, null, function(isConfirm){
			if(isConfirm){
				jQuery('#mode').val('delt');
				form.attr("action","/additionals/deltCase.do");
				form.submit();
			} 
		}); 
	}

	// 상세보기로 이동
	function doView(case_no){
		var form = jQuery('#model');
		jQuery('#case_no').val(case_no);
		form.attr("action","/additionals/viewCase.do");
		
		form.submit();
	}
	
	
	/*
	 *  비밀글인지 검사하는 모듈 추가
	 */
	function ajaxOpenYnChk(bbs_no){
		
		var obj = null;
		
		jQuery('#case_no').val(case_no);
		var params = jQuery('#model').serialize();	// 폼 에 있는 값들
		
    	jQuery.ajax({ 
            url: "/case/ajaxOpenYnChk.do", 
            type: "POST",
            data:params, 
            dataType:"json", 
//		            contentType:"application/json; text/html; charset=utf-8",
            success:function(result) {
            	if(result.chk == 'Y'){
            		nAlert('비밀글을 입니다.');
            		return false;
            	}else if(result.chk == 'N'){
            		doView(case_no);
            	}
            }
            ,error:function(request, status, error) {
                alert("ERROR");
                alert(request.responseText);
            }
        });
	}


	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// 기타
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	
	//File Download
	function download(fileNoVal) {
	// document.location.href = ROOT_PATH +"/comm/fileDownload.do?orgFileName="+orgFileName+"&filePath="+filePath+"&fileName="+fileName;
	    comutils.fileDownload({"fileNo":fileNoVal});
	}
