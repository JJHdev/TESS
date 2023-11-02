<%
 /****************************************************************************************
***	ID					: listRoleByMenuMgmt.jsp
***	Title				: Role By Menu Management Screen
***	Description	: Role By Menu Management Screen
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2011-09-30				ntarget					First Coding.
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
							 '<spring:message code="title.adm.menuId"/>',
							 '<spring:message code="title.adm.menuDesc"/>'
						];


// Grid Caption Name.
var caption_detail	= '<spring:message code="title.adm.header.roleMenu"/>';

// Grid Column Names.
var colnames_detail = [
							 '<spring:message code="title.adm.roleId"/>',
							 '<spring:message code="title.adm.menuId"/>',
							 '<spring:message code="title.adm.menuDesc"/>'
						];
</script>
</head>

<body>
<app:layout mode="header" /><!-- header layout -->

<!-- +++++++++++++++++++++++ Body Contents Start. +++++++++++++++++++++++ -->
<form:form commandName="model" name="form1" method="post" onsubmit="return false;">

<%--
<!-- Search -->
<div style="margin:0 0 6px 0px;">
	<table class="table_type_01">
		<caption><spring:message code="title.adm.roleProg.title"/></caption>
		<colgroup>
			<col width="200px" />
			<col width="" />
		</colgroup>
		<tr>
			<th scope="row"><label for="input_001"><spring:message code="title.adm.schRole"/></label></th>
			<td>
				 <form:select path="roleId" items="${roleList}"  multiple="false" cssClass="down_menu" onchange="fn_search();" />
			</td>
		</tr>
	</table>
</div>
--%>

<%-- [20141120 LCS] 디자인 작업 --%>
<div class="group_wrap_02">
    <div style="width:90%; padding:0 0 0 10px;">
        <table class="style_search_01">
            <colgroup>
                <col width="120" />
                <col width="" />
            </colgroup>
            <tr>
                <th><label for="roleId"><spring:message code="title.adm.schRole"/></label></th>
                <td>
                    <form:select path="roleId" items="${roleList}"  multiple="false" cssClass="down_menu" onchange="fn_search();" />
                </td>
            </tr>

        </table>

    </div>
</div>
<div style="border-top:1px solid #ededed;"></div>

<div style="height:20px;"></div>

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
					<td style="text-align:center; vertical-align: middle; width:33px;">
						<a href="#" onclick="doAction('right')"><img src="<c:url value='/images/right_btn.gif'/>" alt="right" style="margin:0px 0px 6px 3px; vertical-align:middle;" /></a><br>
						<a href="#" onclick="doAction('left')"><img src="<c:url value='/images/left_btn.gif'/>" alt="left" style="margin:0px 0px 6px 3px; vertical-align:middle;" /></a>
					</td>
					<td style="vertical-align: top; width:56%;">
						<table id="grid_detail" class="grid"></table>
						<div id="pager_detail"></div>
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