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
		if(mode=='updt'){
			form.attr("action","/additionals/viewCase.do");
		}else{
			form.attr("action","/additionals/listExcelntCase.do");
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
	<input type="hidden" name="case_no" id="case_no" value="${modelMap.case_no }"/>
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