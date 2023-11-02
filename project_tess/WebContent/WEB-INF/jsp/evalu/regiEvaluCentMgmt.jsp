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
		<strong>중앙투자심사 평가정보 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상 2016년</a></li>
			<li><a href="#">중앙투자심사</a></li>
			<li>평가정보 입력</li>
		</ol>
	</div>
	
	<div class="tab-content">
	    <div class="tab-pane active">
			<c:forEach items="${listSelEvaluCentCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'CT410'}">
					<h4>첨부파일</h4>
					<h5>검토의견서</h5>
					<div style="display: inline;" class="_dyFileAreaCls">
						<div style="display: inline;" class="_dynamicGroup">
							<ul class="file_input" style="position:relative; float:left; cursor:pointer;">
								<li class="fileName" style="padding: 1px;">
									<input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" disabled="disabled" readonly="readonly" value="${CT410Map.FILE_ORG_NM}">
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
			
			<c:forEach items="${listSelEvaluCentCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'CT310'}">
					<h4>판정 의견</h4>
					<h5>판정 의견 결과</h5>
					<table class="table tableNormal thCenter tdCenter" id="finlTab">
						<colgroup>
							<col style="width: 150px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
							<tr>
<%-- 								<th><label class="radio-inline"><input type="radio" name="CT310" value="FN31"  title="적정"  <c:if test="${CT310Map.EVALU_FND_VALUE eq 'FN31' }">checked="checked"</c:if> >적정</label></th> --%>
								<th><label class="radio-inline"><input type="radio" name="CT310" value="적정"  title="적정"  <c:if test="${CT310Map.EVALU_FND_VALUE eq '적정' }">checked="checked"</c:if> >적정</label></th>
								<td align="left">사업의 타당성이 인정되고 정상적인 사업 추진 가능</td>
							</tr>
							<tr>
<%-- 								<th><label class="radio-inline"><input type="radio" name="CT310" value="FN32"  title="조건부"  <c:if test="${CT310Map.EVALU_FND_VALUE eq 'FN32' }">checked="checked"</c:if> >조건부</label></th> --%>
								<th><label class="radio-inline"><input type="radio" name="CT310" value="조건부"  title="조건부"  <c:if test="${CT310Map.EVALU_FND_VALUE eq '조건부' }">checked="checked"</c:if> >조건부</label></th>
								<td align="left">사업의 타당성은 인정되나 필요조건이 충족되어야 사업 추진 가능</td>
							</tr>
							<tr>
<%-- 								<th><label class="radio-inline"><input type="radio" name="CT310" value="FN33"  title="재검토"  <c:if test="${CT310Map.EVALU_FND_VALUE eq 'FN33' }">checked="checked"</c:if> >재검토</label></th> --%>
								<th><label class="radio-inline"><input type="radio" name="CT310" value="재검토"  title="재검토"  <c:if test="${CT310Map.EVALU_FND_VALUE eq '재검토' }">checked="checked"</c:if> >재검토</label></th>
								<td align="left">사업 규모, 시기, 재원조달대책 등 종합적인 재검토 필요</td>
							</tr>
							<tr>
<%-- 								<th><label class="radio-inline"><input type="radio" name="CT310" value="FN34"  title="부적정"  <c:if test="${CT310Map.EVALU_FND_VALUE eq 'FN34' }">checked="checked"</c:if> >부적정</label></th> --%>
								<th><label class="radio-inline"><input type="radio" name="CT310" value="부적정"  title="부적정"  <c:if test="${CT310Map.EVALU_FND_VALUE eq '부적정' }">checked="checked"</c:if> >부적정</label></th>
								<td align="left">사업의 타당성 결여로 사업추진이 불합리한 경우</td>
							</tr>
						</tbody>
					</table>
					<br><br>
				</c:if>	
			</c:forEach>
			
			<c:forEach items="${listSelEvaluCentCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'CT210'}">
					<h4>종합의견</h4>

					<h5>사업추진의 필요성 및 당위성에 관한 의견</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="CT210" title="CT210" name="CT210">${CT210Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${listSelEvaluCentCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'CT220'}">
					<h5>개선 의견</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="CT220" title="CT220" name="CT220">${CT220Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${listSelEvaluCentCode }" var="item" varStatus="idx">	
				<c:if test="${item.EVALU_INDICAT_CD eq 'CT230'}">
					<h5>권고(자문) 사항</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="CT230" title="CT230" name="CT230">${CT230Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>	
			</c:forEach>
			
			<c:forEach items="${listSelEvaluCentCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'CT110'}">
					<h4>종합의견</h4>

					<h5>종합의견(판정결과 근거중심 기술)</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="CT110" title="CT110" name="CT110">${CT110Map.EVALU_FND_VALUE}</textarea>
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