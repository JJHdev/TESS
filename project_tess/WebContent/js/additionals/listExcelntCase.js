/*
 * @(#)listBbs.js 1.0 2014/11/07
 * 
 * COPYRIGHT (C) 2006 CUBES CO., INC.
 * ALL RIGHTS RESERVED.
 */

/**
 * 공통 게시판 리스트
 *
 * @author SYM
 * @version 1.0 2014/11/07
 */

	$(document).ready(function (){
		
	    //---------------------------------
	    // event
	    //---------------------------------
		
	    // 조회버튼 처리
	    $("#srchBtn").click(function(){
	    	doSearch(1);
	    });

	    // 등록버튼 처리
	    $("#openRegiBtn").click(function(){
	    	doRegi();
	    });
	    
	    //Faq 슬라이드
	    jQuery(function(){
	    	jQuery(".expand_title").click(function() {
	    		jQuery(this).toggleClass("clicked")
	    			.next()
	    			.slideToggle(200);
	    		jQuery(".expand_title").not(this)
	    			.removeClass("clicked")
	    			.next()
	    			.slideUp(200);
	    	});
	    });

	});

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//화면 처리 관련 및 이벤트
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// action 로직
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	// 페이지 이동
	function fn_search(page){
		var form = jQuery('#model');
		jQuery('#page').val(page);
		form.attr("action","/additionals/listExcelntCase.do");
		form.submit();
	}

	// 검색버튼
	function doSearch(page) {
		var form = jQuery('#model');
		jQuery('#page').val(page);
		form.attr("action","/additionals/listExcelntCase.do");
		form.submit();
	}

	// 상세보기
	function doView(case_no){
		var form = jQuery('#model');
		jQuery('#case_no').val(case_no);
		form.attr("action","/additionals/viewCase.do");
		form.submit();
	}

	//게시글 등록
	function doRegi(){
		var form = jQuery('#model');
		form.attr("action","/additionals/openRegiCase.do");
		form.submit();
	}

		
	
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// 기타 로직
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
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
            		nAlert('비밀글 입니다.');
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

	/**
	 * 자료첨부를 다운로드 한다.
	 *
	 * @param fileSn String - 파일 일련번호 
	 * @param fileId String - 파일 아이디
	 */
	function fn_downMaterialAtt(seq) {
	    // 자료첨부를 다운로드 한다.
	    var url = ROOT_PATH + "/comm/fileDownload.do" + "?seq=" + seq +"&f_gubun=notice";
	    document.location.href = url;
	}