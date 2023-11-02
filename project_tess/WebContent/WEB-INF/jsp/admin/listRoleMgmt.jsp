<%
 /****************************************************************************************
***	ID					: listRoleMgmt.jsp
***	Title				: Role Management Screen
***	Description	: Role Management Screen
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-06-20				ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="ko">
<head>

<%@ include file ="../header.jsp" %>

<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

<script type="text/javascript">
// Grid Caption Name.
var caption	= '<spring:message code="title.adm.header.role"/>관리';

// Grid Column Names.
var colnames = [
				 '<spring:message code="title.adm.roleNm"/>',
				 '<spring:message code="title.adm.roleId"/>',
				 '<spring:message code="title.adm.parentRoleId"/>'
			];

</script>
</head>

<body>

<!-- header layout -->
<app:layout mode="header" />

<!-- +++++++++++++++++++++++ Body Contents Start. +++++++++++++++++++++++ -->
<form:form commandName="model" name="form1" method="post" onsubmit="return false;">

<div class="round_top_01">
	<div class="round_bottom_01">
		<div id="rsperror" title="Server Error Message...." style="color:red;"></div>

		<!-- Grid -->
		<div id="jqgrid" style="margin:0 0 6px 0px;">
				<table style="vertical-align: top; width:100%;">
				<tr>
					<td style="vertical-align: top; ">
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