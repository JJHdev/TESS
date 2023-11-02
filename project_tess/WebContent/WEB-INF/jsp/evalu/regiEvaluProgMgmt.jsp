<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
	<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
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
<form:form commandName="model" name="model" id="model" enctype="multipart/form-data">

    <%-- pk --%>
    <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}" />
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluGubun" id="evaluGubun" value="${paramMap.evaluGubun}" />  
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo" value="${paramMap.evaluBusiNo}" />  
    
	<div class="contentsTilteLine">
		<strong>집행평가 평가정보 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상 2016년</a></li>
			<li><a href="#">집행평가</a></li>
			<li>평가정보 입력</li>
		</ol>
	</div>
	
	<div class="tab-content">
	    <div class="tab-pane active">
			<c:forEach items="${listSelEvaluProgCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PR110'}">
					<h4>첨부파일</h4>
					<h5>검토의견서</h5>
					<div style="display: inline;" class="_dyFileAreaCls">
						<div style="display: inline;" class="_dynamicGroup">
							<ul class="file_input" style="position:relative; float:left; cursor:pointer;">
								<li class="fileName" style="padding: 1px;">
									<input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" disabled="disabled" readonly="readonly" value="${PR110Map.FILE_ORG_NM}">
									<div class="file_input_div">
										<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button btn btn-smOrange" />
										<input type="file"  name="upfile0"class="file_input_hidden" onchange="javascript:fn_checkFileObjValid(this)"  title="파일첨부"/> 
									</div>
								</li>
							</ul>
						</div>
					</div>
					<br><br><br>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${listSelEvaluProgCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PR310'}">
					<h4>판정 의견</h4>
					<h5>판정 의견 결과</h5>
					<table class="table tableNormal thCenter tdCenter" id="finlTab">
						<colgroup>
							<col style="width: 150px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
							<tr>
								<th><label class="radio-inline"><input type="radio" name="PR310" value="적합"  title="적합"  <c:if test="${PR310Map.EVALU_FND_VALUE eq '적합' }">checked="checked"</c:if> >적합</label></th>
								<td align="left">평가 및 자문의견 반영하여 사업 추진</td>
							</tr>
							<tr>
								<th><label class="radio-inline"><input type="radio" name="PR310" value="조건부 적합"  title="조건부 적합"  <c:if test="${PR310Map.EVALU_FND_VALUE eq '조건부 적합' }">checked="checked"</c:if> >조건부 적합</label></th>
								<td align="left">제기된 문제의 해결 및 보완 후 사업 추진</td>
							</tr>
							<tr>
								<th><label class="radio-inline"><input type="radio" name="PR310" value="부적합"  title="부적합"  <c:if test="${PR310Map.EVALU_FND_VALUE eq '부적합' }">checked="checked"</c:if> >부적합</label></th>
								<td align="left">행·재정적 및 내용적 지적사항 개선 후 재평가</td>
							</tr>
						</tbody>
					</table>
					<br><br>
				</c:if>	
			</c:forEach>
			
			<c:forEach items="${listSelEvaluProgCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PR210'}">
					<h4>종합의견</h4>

					<h5>개선의견</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PR210" title="PR210" name="PR210">${PR210Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${listSelEvaluProgCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PR220'}">
					<h5>권고(자문)사항</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PR220" title="PR220" name="PR220">${PR220Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
			</c:forEach>
			
			<div class="text-center" style="margin:55px 0;">
				<a class="btn btn-green marginRright12" id="prcBtnSave" ><i class="icon-ic_done_all">&nbsp;</i>저장</a>
				<a class="btn btn-red" id="prcBtnList"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
			</div>
			
		</div>
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