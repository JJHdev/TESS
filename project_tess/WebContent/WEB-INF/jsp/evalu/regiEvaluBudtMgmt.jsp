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
    <input type="hidden" name="curtEvaluCode" id ="curtEvaluCode" value='<c:out value="${evaluStageLvl2.code}"/>'/>
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluInptCulm"  id="evaluInptCulm"/>
    <input type="hidden" name="evaluFndSeq"  id="evaluFndSeq"/>      
    <input type="hidden" name="evaluProcStep"  id="evaluProcStep" value="${paramMap.evaluProcStep }"/>      
    <input type="hidden" name="mode"  id="mode" value="${paramMap.mode }"/>    
    <input type="hidden" name="evaluGubun" id="evaluGubun" value="${paramMap.evaluGubun}" />  
    
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
	    <li <c:if test= "${evaluStageLvl2.parentCode eq item.code}">class="active"</c:if> <c:if test="${fn:length(item.codeNm) >13 }">style="width:200px;"</c:if>><a href="#href"  <c:if test="${ paramMap.mode eq 'updt'}">onclick="tabChage('${item.code}' , 'tab1' )"</c:if>>${item.codeNm }</a></li>
	  </c:forEach>
	  </ul>
	  
		<div class="progressTable" >
			<ul class="nav nav-justified">
				<c:set var="liCls" value=""/>
				<c:forEach items="${evaluStageLvl3 }" var="item" varStatus="idx">
				<c:if test="${evaluStageLvl2.code eq item.code }">
					<c:set var="liCls" value="active"/>
				</c:if>
				<c:if test="${evaluStageLvl2.code ne item.code and liCls eq 'active'}">
					<c:set var="liCls" value=""/>
				</c:if>
				<c:if test="${evaluStageLvl2.code ne item.code and liCls eq ''}">
					<c:set var="liCls" value="visited"/>
				</c:if>
				<c:if test="${fn:length(evaluStageLvl3) ne idx.count }">
					<c:set var="divCls" value="col-sm-11"/>
				</c:if>
				<c:if test="${fn:length(evaluStageLvl3) eq idx.count }">
					<c:set var="divCls" value="col-sm-12"/>
				</c:if>
				<li class="${liCls }" <c:if test="${ paramMap.mode eq 'updt' or paramMap.mode eq 'view'}">onclick="tabChage('${item.code}' , 'tab2' )"</c:if>><!-- *** [visited] 클래스 사용 **** -->
					<div class="${divCls }"><div class="value">${idx.count }. ${ item.codeNm}</div></div>
					<c:if test="${fn:length(evaluStageLvl3) ne idx.count }">
						<div class="col-sm-1"><div class="value"> </div></div>
					</c:if>
				</li>
				</c:forEach>
			</ul>
		</div>		
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div class="tab-pane active">

				<h4>${evaluStageLvl2.codeNm }</h4>
				
			<c:if test="${evaluStageLvl2.codeType ne 'EX'}">
				<c:forEach items="${evaluInptItem }" var="item" varStatus="idx">	
					<c:if test="${item.code ne 'IP30'}">
						<h5>${item.codeNm }</h5>
						<div class="alert">
							<textarea rows="10" cols="119" id="${item.code }" title="${item.codeNm }" name="${item.code }">${fndList[idx.count-1].evaluFndVal }</textarea>
							<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[idx.count-1].evaluFndSeq }"/>
						</div>
					</c:if>
				</c:forEach>	
			</c:if>
			<c:if test="${evaluStageLvl2.codeType eq 'EX'}">
				<c:forEach items="${evaluInptItem }" var="item" varStatus="idx">	
					<c:if test="${item.code eq 'IP30'}">
						<h5>${item.codeNm }</h5>
						<div class="alert">
							<textarea rows="10" cols="119" id="${item.code }" title="${item.codeNm }" name="${item.code }">${fndList[0].evaluFndVal }</textarea>
							<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[0].evaluFndSeq }"/>
						</div>
					</c:if>
				</c:forEach>	
			</c:if>
				
				<div class="text-center" style="margin:55px 0;">
					<a class="btn btn-green marginRright12" id="prcBtnSave" ><i class="icon-ic_keyboard_arrow_right">&nbsp;</i>다음</a>
					<a class="btn btn-red" id="prcBtnList"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
				</div>

		</div><!-- //tab-pane-->
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