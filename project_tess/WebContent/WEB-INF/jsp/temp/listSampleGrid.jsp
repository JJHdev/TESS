<%
 /****************************************************************************************
***	ID			: listSampleGrid.jsp
***	Title		: Template Screen
***	Description	: Template Screen
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date					author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-06-09					ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>


<title><spring:message code="title.sysname"/></title>

<meta http-equiv="Cache-Control" content="no-cache" />
<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

<script type="text/javascript">
// Grid Caption Name.
var caption	= "<font color=green>샘플] 그리드 리스트</font>";

// Grid Column Names.
var colNames = [
				 'Seq',
				 '아이디',
				 '이름',
				 '제목',
				 '날짜',
				 '시간',
				 '수량',
				 '사용자구분',
				 '사용자구분코드'
				];
</script>

<!-- Header Title 길이만큼 높이가 늘어남. -->
<!--<style type="text/css" media="screen">     th.ui-th-column div{         white-space:normal !important;         height:auto !important;         padding:2px;     } </style> -->
</head>

<body>
<app:layout mode="header" /><!-- header layout -->

<!-- +++++++++++++++++++++++ Body Contents Start. +++++++++++++++++++++++ -->
<form:form commandName="model" name="form1" method="post" action="${pageContext.request.contextPath}/temp/listSampleGrid.do">
<input type="hidden" name="gridValues">

<div style="margin:0px 0 0px 0px;">
	ID : <input type="text" name="schUserId" id="schUserId" onkeydown="doSearch(arguments[0]||event)" class="input_M" title="ID"/>&nbsp;
	Name : <input type="text" name="schUserNm" id="schUserNm" onkeydown="doSearch(arguments[0]||event)" class="input_M" title="Name"/>&nbsp;
	<ul class="btns" style="margin:0px 0 10px 0px;">
	<app:button id="search" jsFunction="onClickButton"/>
	<!--app:button id="save" jsFunction="onClickButton"/-->
	<app:button id="multisave" jsFunction="onClickButton" name="저장"/>
	<app:button id="delete" jsFunction="onClickButton"/>
	</ul>
</div>

<div id="rsperror" title="Server Error Message...." style="color:red;"></div>

<div id="jqgrid" style="margin:0 0 0px 0px;">
	<table id="grid" class="grid"></table>
	<div id="pager"></div>
</div>

<div id="dialog" title="Message" style="display:none">
	<p><spring:message code="title.grid.dialog"/></p>
</div>

<div id="dialogSelectRow" title="Message" style="display:none">
	<p><spring:message code="title.grid.dialog.selectrow"/></p>
</div>

</form:form>
<!-- +++++++++++++++++++++++ Body Contents End. +++++++++++++++++++++++ -->


<app:layout mode="footer" /><!-- footer layout -->

</body>
</html>