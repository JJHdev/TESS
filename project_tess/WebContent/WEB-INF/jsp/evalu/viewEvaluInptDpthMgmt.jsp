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

<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
<!-- ======================================================= -->
	
<div class="contents" >

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model">

    <%-- pk --%>
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>
    
    <%-- pk --%>
    <form:hidden path="evaluBusiNo" />
    <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}" />
    <input type="hidden" name="nextEvaluCode" id ="nextEvaluCode" value='<c:out value="${evaluStageLvl2.nextEvaluCode}"/>'/>
    <input type="hidden" name="evaluDetailCode" id ="evaluDetailCode" value='<c:out value="${evaluStageLvl2.code}"/>'/>
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluProcStep"  id="evaluProcStep" value="${paramMap.evaluProcStep }"/>      
    
	<div class="contentsTilteLine">
		<strong>계획평가 평가정보 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상</a></li>
			<li><a href="#">계획평가</a></li>
			<li>상세화면</li>
		</ol>
	</div>
	

	  <!-- Nav tabs -->
	  <ul class="nav nav-tabs noLink">
	  <c:forEach items="${evaluStageLvl1 }" var="item" varStatus="idx">
	    <li <c:if test= "${evaluStageLvl2.parentCode eq item.code}">class="active"</c:if> <c:if test="${fn:length(item.codeNm) >13 }">style="width:200px;"</c:if>><a href="#">${item.codeNm }</a></li>
	  </c:forEach>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="tab1">

				<h4>${evaluStageLvl2.codeNm }</h4>
				
			<!-- Table -->
			<table class="table tableNormal">
				<colgroup>
					<col style="width: 115px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr>
						<th class="leftNoLine">구분</th>
						<th class="rightNoLine">부분별 진단 내용</th>
					</tr>
				<c:forEach items="${evaluInptItem }" var="item" varStatus="idx">
					<tr class="${clsId }">
						<th class="leftNoLine">${item.codeNm }</th>
						<td class="rightNoLine"><c:out value="${fndList[idx.count-1].evaluFndVal }"/></td>
					</tr>
				</c:forEach>						
				</tbody>
			</table><!-- //Table-->				
				
				<div class="text-center" style="margin:55px 0;">
					<a class="btn btn-green marginRright12" href="#"  id="prcBtnUpdt"><i class="icon-ic_create">&nbsp;</i>평가정보 수정</a>	
					<a class="btn btn-green marginRright12" href="#"  id="prcBtnNextView"><i class="icon-ic_create">&nbsp;</i>다음</a>	
					<a class="btn btn-red" id="prcBtnList" ><i class="icon-ic_refresh">&nbsp;</i>취소</a>
				</div>

		</div><!-- //tab1-->
	  </div><!-- //tab-content-->
	
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