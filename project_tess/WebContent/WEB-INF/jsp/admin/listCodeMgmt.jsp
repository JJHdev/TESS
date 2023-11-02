<%
 /****************************************************************************************
***	ID					: listCodeMgmt.jsp
***	Title				: Code Management Screen
***	Description	: Code Management Screen
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
var caption	= '<spring:message code="title.adm.header.codeType"/>';

// Grid Column Names.
var colnames = [
							 '<spring:message code="title.adm.codeType"/>',
							 '<spring:message code="title.adm.codeTypeNm"/>',
							 '<spring:message code="title.adm.useYn"/>'
						];

// Grid Caption Name.
var caption_detail	= '<spring:message code="title.adm.header.code"/>';

// Grid Column Names.
var colnames_detail = [
							 '<spring:message code="title.adm.codeType"/>',
							 '<spring:message code="title.adm.code"/>',
							 '<spring:message code="title.adm.codeNm"/>',
							 '<spring:message code="title.adm.addCol" arguments="1"/>',
							 '<spring:message code="title.adm.addCol" arguments="2"/>',
							 '<spring:message code="title.adm.addCol" arguments="3"/>',
							 '<spring:message code="title.adm.sort"/>',
							 '<spring:message code="title.adm.useYn"/>'
						];
</script>
</head>

<body>

<!-- header layout -->
<app:layout mode="header" />

<!-- +++++++++++++++++++++++ Body Contents Start. +++++++++++++++++++++++ -->
<form:form commandName="model" name="form1" method="post" onsubmit="return false;">

<%--
<!-- Search -->
<div style="margin:0 0 6px 0px;">
	<table class="table_type_01">
		<caption><spring:message code="title.adm.code.title"/></caption>
		<colgroup>
			<col width="250px" />
			<col width="" />
		</colgroup>
		<tr>
			<th scope="row"><label for="input_001"><spring:message code="title.adm.code.schCodeType"/></label></th>
			<td>
				<form:input path="schParentCode" size="30" maxlength="50" cssClass="input_M" onkeydown="doSearch(arguments[0]||event)"/>
			</td>
		</tr>
	</table>
</div>

<!-- Buttons -->
<ul class="btns" style="margin:0px 0 6px 0px;">
	<app:button id="inquire" jsFunction="onClickButton"/>
</ul>
--%>

<%-- [20141120 LCS] 디자인 작업 --%>
<!-- Search -->
<div class="group_wrap_02">
    <div style="width:90%; padding:0 0 0 10px;">
        <table class="style_search_01">
            <colgroup>
                <col width="170" />
                <col width="" />
            </colgroup>
            <tr>
                <th><label for="schParentCode"><spring:message code="title.adm.code.schCodeType"/></label></th>
                <td>
                    <form:input path="schParentCode" size="30" maxlength="50" cssClass="input_M" onkeydown="doSearch(arguments[0]||event)"/>
                </td>
            </tr>
        </table>

    </div>
</div>
<div style="border-top:1px solid #ededed;"></div>
<div style="height:20px;"></div>

<!-- Buttons -->
<div style="position:relative; margin:0; height:28px;">

    <div style=" position:absolute; top:0px; right:0px;">
        <span class="small_btn_01 small_color_03" id="prcBtnSrch" mode="inquire">
            <a href="#link"><img src='<c:url value="/images/btns/icon_01.png"/>' alt=""><strong><spring:message code="btn.inquire"/></strong></a></span>
    </div>

</div>
<div style="height:10px;"></div>


<div class="round_top_01">
	<div class="round_bottom_01">

			<div id="rsperror" title="Server Error Message...." style="color:red;"></div>

			<!-- Grid -->
			<div id="jqgrid" style="margin:0 0 0px 0px;">
				<table style="vertical-align: top; width:100%;">
				<tr>
					<td style="vertical-align: top; ">
						<table id="grid" class="grid"></table>
						<div id="pager"></div>
					</td>
					<td style="">&nbsp;</td>
					<td style="vertical-align: top; width:60%;">
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


<!-- footer layout -->
<app:layout mode="footer" />

</body>
</html>