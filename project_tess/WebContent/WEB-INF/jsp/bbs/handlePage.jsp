<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file ="../header.jsp" %>
<script language="javascript"  type="text/javascript" src="/jquery/jquery-1.11.0.min.js"></script>
<script language="javascript"  type="text/javascript" src="/js/common.js"></script>
<title>관광개발지원시스템 </title>
</head>
<script>

function goPage(mode,rep){
		var form = jQuery('#model');
		var bbs_type = jQuery('#bbs_type').val();
		if(mode=='updt'){
			if(bbs_type == 'B01'){
				form.attr("action","/bbs/viewBbsNotice.do");
			}else if(bbs_type == 'B02'){
				if(rep=="repupdt"){
					var tmpSeq = jQuery('#parent_bbs_no').val();
					jQuery('#bbs_no').val(tmpSeq);
				}
				form.attr("action","/bbs/viewBbsFile.do");
			}else if(bbs_type == 'B03'){
				form.attr("action","/bbs/listBbsFaq.do");
			}else if(bbs_type == 'B04'){
				form.attr("action","/bbs/viewBbsSchedule.do");
			}
		}else{
			if(bbs_type == 'B01'){
				form.attr("action","/bbs/listBbsNotice.do");
			}else if(bbs_type == 'B02'){
				form.attr("action","/bbs/listBbsFile.do");
			}else if(bbs_type == 'B03'){
				form.attr("action","/bbs/listBbsFaq.do");
			}else if(bbs_type == 'B04'){
				form.attr("action","/bbs/listBbsSchedule.do");
			}
		}
		//-------------------------------
		//메시지 출력
		//-------------------------------
		resultMessage(); 
		
		form.submit();
	}
</script>
<body>
<form:form commandName="model" name="model" id="model" method="post">
	<form:hidden path="page" id="page"/>
	<form:hidden path="bbs_type" id="bbs_type" />
	<form:hidden path="search_name" id="search_name" />
	<form:hidden path="search_word" id="search_word" />
	<form:hidden path="docu_kind" id="docu_kind" />
	<input type="hidden" name="bbs_no" id="bbs_no" value="${modelMap.bbs_no }"/>
	<input type="hidden" name="parent_bbs_no" id="parent_bbs_no" value="${modelMap.parent_bbs_no }"/>
</form:form>
<c:if test="${modelMap.mode eq 'regi' }">
<script>goPage('regi');</script>
</c:if>
<c:if test="${modelMap.mode eq 'updt' }">
<script>goPage('updt','');</script>
</c:if>
<c:if test="${modelMap.mode eq 'delt' }">
<script>goPage('delt');</script>
</c:if>
<c:if test="${modelMap.mode eq 'repupdt' }">
<script>goPage('updt','${modelMap.mode}');</script>
</c:if>
<c:if test="${empty modelMap.mode }">
<script>goPage('delt');</script>
</c:if>
</body>
</html>