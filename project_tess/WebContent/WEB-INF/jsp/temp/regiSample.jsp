<%
 /****************************************************************************************
***	ID					: regiSample.jsp
***	Title				: Template Registration Screen
***	Description			: Template Registration Page
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-06-16				ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file ="../header.jsp" %>

<html lang="ko">
<head>
<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
</head>

<body>
<!-- header layout -->
<app:layout mode="header" />

<!-- ==================== 중앙내용 시작 ==================== -->
<!-- Button List (버튼 처리) -->
<table width="100%" cellpadding="0" cellspacing="0" class="table-line" border="0">
<tr>
	<td width="15%"></td>
	<td width="" align="right">
		<app:button id="regi" jsFunction="onClickButton"/>
		<app:button id="delt" jsFunction="onClickButton"/>
		<app:button id="list" jsFunction="onClickButton"/>
	</td>
</tr>
</table>


<form:form commandName="model" id="form1" name="form1" method="post" enctype="multipart/form-data">
<form:hidden path="seq"/>
<input type="hidden" name="gsRoleId" value="${map.gsRoleId}"/>

<table width="100%" cellpadding="0" cellspacing="1" border="0" bgcolor="#8E8EFF">
<tr>
	<td width="15%" bgcolor="#AAD5FF"><spring:message code="title.name"/> : </td>
	<td bgcolor="#FFFFFF"><form:input path="userNm" size="50" maxlength="50" cssClass="default"/></td>
</tr>
<tr>
	<td width="15%" bgcolor="#AAD5FF"><spring:message code="title.title"/> : </td>
	<td bgcolor="#FFFFFF"><form:input path="title" size="80" maxlength="100" cssClass="default"/></td>
</tr>
<tr>
	<td width="15%" height="300" bgcolor="#AAD5FF"><spring:message code="title.content"/> : </td>
	<td bgcolor="#FFFFFF" height="100%" align="center"><form:textarea path="content" cssStyle="width:98%; line-height:22px; height:300px; margin-left:0px;padding:5px 5px 5px 5px; ime-mode:active;"></form:textarea></td>
</tr>
</table>

<p/>

<table width="100%" cellpadding="0" cellspacing="1" class="table-line" border="1">
<c:set var="seq" value="0"/>
<c:forEach var="data" items="${listFile}" varStatus="state">
	<tr>
		<td><input name="arrFileNo" type="checkbox" class="default" value="${data.fileNo}" title="파일선택"/></td>
		<td>☞ <a href="javascript:download('${data.fileNo}');"><c:out value="${data.fileOrgNm}"/></a></td>
	</tr>
	<c:set var="seq" value="${seq + 1}"/>
</c:forEach>

<!-- 첨부파일 -->
<c:if test="${seq < 3}">
	<c:forEach var="i" begin="0" end="${2 - seq}" step="1">
		<tr>
			<td>&nbsp;</td>
			<td><input type="file" name="upfile${i}" class="input1" style="padding-bottom:4;width:600;" title="파일"/></td>
		</tr>
	</c:forEach>
</c:if>
</table>

</form:form>
<!-- ==================== 중앙내용 종료 ==================== -->

<!-- footer layout -->
<app:layout mode="footer" />

</body>
</html>