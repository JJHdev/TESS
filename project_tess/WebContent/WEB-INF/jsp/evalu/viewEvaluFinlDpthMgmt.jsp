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
    <input type="hidden" name="evaluDetailCode" id ="evaluDetailCode" value='<c:out value="${evaluStageLvl2.code}"/>'/>
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluProcStep"  id="evaluProcStep" value="${paramMap.evaluProcStep }"/>   
    <input type="hidden" name="evaluFndSeq"  id="evaluFndSeq" value="${fndList[0].evaluFndSeq }"/>   
    <input type="hidden" name="evaluEtcSeq"  id="evaluEtcSeq" value="${paramMap.evaluEtcSeq }"/>   
    
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
	  <ul class="nav nav-tabs">
	  <c:forEach varStatus="idx"  begin="1" end="${lenEtcSeq }">
	    <li role="presentation" style="width:120px;" onclick="tapChage('${idx.count}');"  <c:if test="${idx.count eq fndList[0].evaluEtcSeq }">class="active" </c:if>><a href="#">세부내용${idx.count }</a></li>
	  </c:forEach>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="tab1">

				<h5>${evaluStageLvl2.codeNm }</h5>
				<!-- Table -->
				<table class="table tableNormal thCenter tdCenter">
					<colgroup>
						<col style="width: 100px;">
						<col style="width: *;">
					</colgroup>
					<tbody>
						<tr class="top2">
							<th class="leftNoLine">제목</th>
							<th colspan="3" class="rightNoLine">컨설팅 제안 내용</th>
						</tr>
					<c:forEach items="${evaluInptItem }" var="item" varStatus="idx">
						<tr> 
							<td class="leftNoLine">${paramMap.evaluEtcSeq}</td>
							<td class="rightNoLine" style="text-align: left;">
								${fndList[0].evaluEtcVal }
							</td>
						</tr>
						<tr class="bottom">
							<td colspan="3" style="padding:10px 5px; text-align: left;" class="leftNoLine rightNoLine" > 
								${fndList[0].evaluFndVal}
							</td>
						</tr>							
					</c:forEach>	 
					</tbody>
				</table><!-- //Table-->	
				
				<div class="text-center" style="margin:55px 0;">
				<c:if test="${lenEtcSeq eq fndList[0].evaluEtcSeq}">
					<a class="btn btn-green marginRright12" id="prcBtnAddSave" ><i class="icon-ic_keyboard_arrow_right">&nbsp;</i>추가저장</a>
				</c:if>
					<a class="btn btn-green marginRright12" id="prcBtnUpdt"><i class="icon-ic_create">&nbsp;</i>평가정보 수정</a>	
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