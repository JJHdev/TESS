<%
 /****************************************************************************************
***	ID					: listAccHist.jsp
***	Title				:
***	Description	:
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2013-08-05				jsw					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>
<title><spring:message code="title.sysname"/></title>

<app:layout mode="stylescript" type="normal" />

<script type="text/javascript">
// Grid Caption Name.
var caption	= '<spring:message code="title.adm.header.menu"/>';

// Grid Column Names.
var colnames = [
					 '<spring:message code="title.adm.menu.parentMenu"/>',
					 '<spring:message code="title.adm.menuDesc"/>',
					 '',
					 '<spring:message code="title.adm.accessRate"/>',
					 '<spring:message code="title.adm.accessCnt"/>',
					 '<spring:message code="title.adm.accessDate"/>',
					 ''

				];
</script>
</head>

<body>
<app:layout mode="header" /><!-- header layout -->

<!-- +++++++++++++++++++++++ Body Contents Start. +++++++++++++++++++++++ -->
<form:form commandName="model" name="form1" method="post" onsubmit="return false;">

<!-- Search -->
<div style="margin:0 0 6px 0px;">
	<table class="table_type_01">
		<caption><spring:message code="title.adm.menu.title"/></caption>
		<colgroup>
			<col width="200px" />
			<col width="" />
			<col width="200px" />
			<col width="" />
		</colgroup>
		<tr>
			<th scope="row"><label for="parentId"><spring:message code="title.adm.menu.parentMenu"/></label></th>
			<td>
				 <form:select path="parentId" items="${menuTopList}"  multiple="false" cssClass="down_menu" onchange="fn_search();" />
			</td>
			<th scope="row"><label for="menuDesc"><spring:message code="title.adm.menuDesc"/></label></th>
			<td>
				<form:input path="menuDesc" size="30" maxlength="50" cssClass="input_M" onkeydown="doSearch(arguments[0]||event)"/>
			</td>
		</tr>
		<tr>
			<th scope="col"><label for="option_001"><spring:message code="title.date"/></label></th>
			<td colspan="3">
				<form:select path="schFromYear" 	items="${cmbYear}"   multiple="false" cssClass="select_M" cssStyle="width:70px"/>
				<form:select path="schFromMonth" 	items="${cmbMonth}"  multiple="false" cssClass="select_M" cssStyle="width:50px"/>
				~
				<form:select path="schToYear" 	items="${cmbYear}"   multiple="false" cssClass="select_M" cssStyle="width:70px"/>
				<form:select path="schToMonth" 	items="${cmbMonth}"  multiple="false" cssClass="select_M" cssStyle="width:50px"/>
			</td>
		</tr>
	</table>
</div>

<!-- Buttons -->
	<ul class="btns" style="margin:0px 0 6px 0px;">
		<app:button id="inquire" jsFunction="onClickButton"/>
	</ul>


<div class="round_top_01">
	<div class="round_bottom_01">
		<div id="rsperror" title="Server Error Message...." style="color:red;"></div>

		<!-- Grid -->
		<div id="jqgrid" style="margin:0 0 6px 0px;">
			<table style="vertical-align: top; width:100%;">
			<tr>
				<td style="vertical-align: top; width:100%;">
					<table id="grid" class="grid"></table>
					<div id="pager"></div>
				</td>
			</tr>
			</table>
		</div>

		<div id="dialog" title="Feature not supported" style="display:none">
		<p><spring:message code="title.grid.dialog"/></p>
		</div>

		<div id="dialogSelectRow" title="Warning" style="display:none">
		<p><spring:message code="title.grid.dialog.selectrow"/></p>
		</div>

	</div>
</div>

</form:form>
<!-- +++++++++++++++++++++++ Body Contents End. +++++++++++++++++++++++ -->


<app:layout mode="footer" /><!-- footer layout -->

</body>
</html>