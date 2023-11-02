<%
 /****************************************************************************************
***	ID					: viewSampleChart.jsp
***	Title				: Template List Screen
***	Description			: Template List Page
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-10-07				ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file ="../header.jsp" %>

<html lang="ko">
<head>
<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="chart" /><!-- style & javascript layout -->

<script type="text/javascript">
var caption	= "<font color=green>[샘플] 그리드 리스트 챠트</font>";
var colNames = [
				 '메뉴명',
				 '횟수',
				 '접속율',
				 '마지막접속일시'
				];
</script>
<script>
/*
function getChartDataAjax() {
	$.ajax({
	    url :'/temp/getSampleChart.do',
	    type:'POST',
	    data: {status:"D", deltRows: $.toJSON(list)},
	    success: function(data) {
	        var r = data.Result;
	        if (r.Code < 0)
	            jAlert(r.Message);

	        loadChart(data);
	    },
	    error:function(x,e) {
	        jAlert("Error", x.responseText);
	    }
	});
}

function loadChart(data) {
	jAlert(data);
}
*/
</script>
</head>

<body>
<!-- header layout -->
<app:layout mode="header" />

<!-- ==================== 중앙내용 시작 ==================== -->
<!--  CHART -->
<div class="title_02" style="margin:0 0 10px 0;">Chart</div>
<div class="round_top_01">
    <div class="round_bottom_01"><!-- BAR CHART 부분 -->
        <div id="chart1" style="width:400px; height:350px;"></div>
    </div>
</div>


<!--  GRID  -->
<div id="rsperror" title="Server Error Message...." style="color:red;"></div>

<div id="jqgrid" style="margin:0 0 0px 0px; display:none">
	<table id="grid" class="grid"></table>
	<div id="pager"></div>
</div>

<div id="dialog" title="Message" style="display:none">
	<p><spring:message code="title.grid.dialog"/></p>
</div>

<div id="dialogSelectRow" title="Message" style="display:none">
	<p><spring:message code="title.grid.dialog.selectrow"/></p>
</div>
<br></br>



<!-- ==================== 중앙내용 종료 ==================== -->

<!-- footer layout -->
<app:layout mode="footer" />

</body>
</html>
