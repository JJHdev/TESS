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

	// 검색버튼
	function doSearch(page) {
		var form = jQuery('#model');
		var keyName = jQuery('#search_name');
		var keyWord = jQuery('#search_word');
		if(keyName.val() == "" && keyWord.val() != "" ){
			msgAlert(MSG_BBS_B001,keyName);
//			nAlert('검색조건을 선택해주시기바랍니다.');
//			keyName.focus(); 
			return false;
		}
		jQuery('#page').val(page);
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

	// 상세보기
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

	//게시글 등록
	function doRegi(){
		var form = jQuery('#model');
		var bbs_type = jQuery('#bbs_type').val();
		if(bbs_type == 'B01'){
			form.attr("action","/bbs/openRegiBbsNotice.do");
		}else if(bbs_type == 'B02'){
			form.attr("action","/bbs/openRegiBbsQna.do");
		}else if(bbs_type == 'B03'){
			form.attr("action","/bbs/openRegiBbsFaq.do");
		}
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
            		nAlert('비밀글 입니다.');
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