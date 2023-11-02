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
		var bbs_type = jQuery('#bbs_type').val();

		if(bbs_type == 'B01'){
			form.attr("action","/bbs/listBbsNotice.do");
		}else if(bbs_type == 'B02'){
			form.attr("action","/bbs/listBbsQna.do");
		}else if(bbs_type == 'B03'){
			form.attr("action","/bbs/listBbsFaq.do");
		}
		
		form.submit();
	}

	//수정화면이동
	function doOpenUpdt(){
		var form = jQuery('#model');
		var bbs_type = jQuery('#bbs_type').val();

		if(bbs_type == 'B01'){
			form.attr("action","/bbs/openUpdtBbsNotice.do");
		}else if(bbs_type == 'B02'){
			form.attr("action","/bbs/openUpdtBbsQna.do");
		}else if(bbs_type == 'B03'){
			form.attr("action","/bbs/openUpdtBbsFaq.do");
		}

		form.submit();
	}

	//삭제처리
	function doDel(){
		var form = jQuery('#model');
		nConfirm(MSG_BBS_B002, null, function(isConfirm){
			if(isConfirm){
				jQuery('#mode').val('delt');
				form.attr("action","/bbs/deltBbs.do");
				form.submit();
			} 
		}); 
	}

	// 상세보기로 이동
	function doView(bbs_no){
		var form = jQuery('#model');
		jQuery('#bbs_no').val(bbs_no);
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
	
	
	/*
	 *  비밀글인지 검사하는 모듈 추가
	 */
	function ajaxOpenYnChk(bbs_no){
		
		var obj = null;
		
		jQuery('#bbs_no').val(bbs_no);
		var params = jQuery('#model').serialize();	// 폼 에 있는 값들
		
    	jQuery.ajax({ 
            url: "/bbs/ajaxOpenYnChk.do", 
            type: "POST",
            data:params, 
            dataType:"json", 
//		            contentType:"application/json; text/html; charset=utf-8",
            success:function(result) {
            	if(result.chk == 'Y'){
            		nAlert('비밀글을 입니다.');
            		return false;
            	}else if(result.chk == 'N'){
            		doView(bbs_no);
            	}
            }
            ,error:function(request, status, error) {
                alert("ERROR");
                alert(request.responseText);
            }
        });
	}

	//답글작성
	function doOpenRegiReply(){
		var form = jQuery('#model');
		form.attr("action","/bbs/openRegiReplyBbs.do");
		form.submit();

	}

	//답글수정
	function doOpenUpdtReply(){
		var form = jQuery('#model');
		form.attr("action","/bbs/openUpdtReplyBbs.do");
		form.submit();

	}
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// 기타
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	
	//File Download
	function download(fileNoVal) {
	// document.location.href = ROOT_PATH +"/comm/fileDownload.do?orgFileName="+orgFileName+"&filePath="+filePath+"&fileName="+fileName;
	    comutils.fileDownload({"fileNo":fileNoVal});
	}
