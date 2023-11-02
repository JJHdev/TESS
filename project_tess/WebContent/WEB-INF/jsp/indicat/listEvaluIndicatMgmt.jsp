<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
		<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
	
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ========================= -->
<!-- ======================================================= -->

<div class="contents" >

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model">

    <%-- 공통 필수 --%>
    <input type="hidden" name="mode"       id="mode"      />
    <input type="hidden" name="page"       id="page"      value='<c:out value="${paramMap.page }"/>'/>
    
    <%-- pk --%>
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo"/>
    
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchEvaluStage"   id="srchEvaluStage"   value='<c:out value="${paramMap.srchEvaluStage}"/>'/>
        <input type="hidden" name="srchEvaluIndicat"   id="srchEvaluIndicat"   value='<c:out value="${paramMap.srchEvaluIndicat}"/>'/>
        <input type="hidden" name="srchEvaluIndicatNm"  id="srchEvaluIndicatNm"  value='<c:out value="${paramMap.srchEvaluIndicatNm}"/>'/>
    </div>
	
	<div class="contentsTilte">
		<strong>평가지표관리 리스트</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가지표관리</a></li>
			<li>평가지표관리 리스트</li>
		</ol>
	</div>
						
	<table class="table table2Way marginBottom40"><!-- 검색-->
		<colgroup>
			<col style="width: 105px">
			<col style="width: 150px;">
			<col style="width: 150px">
			<col style="width: 120px;">
			<col style="width: 300px;">
		</colgroup>
		<tbody>
			<tr class="topPadding bottomPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가단계</th> 
				<td>
					<select name="srchEvaluStageTemp" id="srchEvaluStageTemp" class="form-control input-sm">
 						<option value="">::전체::</option>
                        <c:forEach items="${evaluStageComboList }" varStatus="idx" var="type">
                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
                                <c:out value="${type.codeNm }"/>
                            </option>
                        </c:forEach> 	 						
					</select>
				</td>
				<td>
					<select name="srchEvaluIndicatTemp" id="srchEvaluIndicatTemp" class="form-control input-sm">
 						<option value="">::전체::</option>
					</select>	
				</td>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가지표명</th>
				<td> 
					<input type="text" class="form-control input-sm" id="srchEvaluIndicatNmTemp" name="srchEvaluIndicatNmTemp" style="width: 270px;">
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5">
					<a class="btn btn-search marginRright12" href="#"  id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a><!-- 20160203 : 전체변경1 -->
				</td>
			</tr>
		</tfoot>
	</table><!-- //검색-->

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
	
</form:form>
	
</div><!-- /contents -->
						
<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->		

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>