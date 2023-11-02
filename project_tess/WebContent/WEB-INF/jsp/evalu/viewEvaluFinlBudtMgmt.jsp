<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
		<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
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
	
<div class="contents" >.

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model"  enctype="multipart/form-data">

    <%-- pk --%>
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>
    
    <%-- pk --%>
    <form:hidden path="evaluBusiNo" />
    <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}" />
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluInptCulm"  id="evaluInptCulm"/>     
    <input type="hidden" name="evaluFndSeq"  id="evaluFndSeq"/>
    <input type="hidden" name="evaluProcStep"  id="evaluProcStep" value="${paramMap.evaluProcStep }"/>       
    <input type="hidden" name="evaluGubun"  id="evaluGubun" value="${paramMap.evaluGubun}"/>       
	
	<div class="contentsTilte">
		<strong>계획평가 평가결과 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상</a></li>
			<li><a href="#">계획평가</a></li>
			<li>계획평가 입력</li>
		</ol>
	</div>
						
	<table class="table table1Way marginBottom40"><!-- 검색-->
		<colgroup>
			<col style="width: 90px">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업명</th>
				<td>
					<input type="text" class="form-control input-sm" value="${evaluStgMap.evaluBusiNm }"  readonly="readonly">
				</td>
			</tr>
	</table><!-- //검색-->

	
	<h5>계획평가 최종 의견서</h5>

	<c:choose>
		<c:when test="${paramMap.evaluGubun eq 'AFTER'}">
			<!-- Table -->
			<table class="table tableNormal thCenter tdCenter" id="finlTab">
				<colgroup>
					<col style="width: 120px;">
					<col style="width: 130px;">
					<col style="width: 220px;">
					<col style="width: *;"><col style="width: *;"><col style="width: *;"><col style="width: *;"><col style="width: *;">
					<col style="width: 200px;">
				</colgroup>
				<thead>
					<tr>
						<th class="leftNoLine">평가요소</th>
						<th>평가항목</th>
						<th>평가지표</th>
						<th colspan="5">배점(해당항목에 체크)</th>
						<th class="rightNoLine">특이사항</th>
					</tr>
				</thead>
				<tbody>
				<c:set var="listCnt" value="${fn:length(evlauItemLvl1)-1}"/>
				<c:forEach items="${evlauItemLvl1 }" var="item" varStatus="idx">
					<tr>
						<th class="leftNoLine">${item.grandCodeNm }</th>
						<th>${item.parentCodeNm}</th>
						<th>${item.codeNm}</th>
						<c:forEach items="${item.evaluItemSpan}" var="itemSpan" varStatus="state">
							<td colspan="${itemSpan.colspanSize}"><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${state.count}_1" value="${itemSpan.evaluItemCd}"  title="${item.codeNm}"  <c:if test="${fndList[idx.count-1].evaluFndVal eq itemSpan.evaluItemCd }">checked="checked"</c:if>>${itemSpan.evaluItemNm}</label></td>
						</c:forEach>
<%-- 						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_1" value="S"  title="${item.codeNm}"  <c:if test="${fndList[idx.count-1].evaluFndVal eq 'S' }">checked="checked"</c:if>>S</label></td> --%>
<%-- 						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_2" value="A"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'A' }">checked="checked"</c:if>>A</label></td> --%>
<%-- 						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_3" value="B"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'B' }">checked="checked"</c:if>>B</label></td> --%>
<%-- 						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_4" value="C"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'C' }">checked="checked"</c:if>>C</label></td> --%>
<%-- 						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_5" value="D"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'D' }">checked="checked"</c:if>>D</label></td> --%>
						<td class="rightNoLine"><input type="text" class="form-control input-sm"  id="inlineText${idx.count}"  name="txt${item.code }" value="${fndList[idx.count-1].evaluEtcVal }"></td>
						<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[idx.count-1].evaluFndSeq }"/>
					</tr>		
				</c:forEach>
				<c:forEach items="${evlauItemLvl2 }" var="item" varStatus="idx">
					<tr>
					<c:if test="${item.code ne 'FN30' and item.code ne 'FN40' }">
						<th class="leftNoLine">${item.parentCodeNm }<br /> ${item.codeNm }</th>
						<td colspan="9" class="rightNoLine"><textarea class="form-control" rows="3"  name="${item.code }" id="${item.code }" _required="true"  title="${item.parentCodeNm } ${item.codeNm }">${fndList[listCnt+idx.count].evaluFndVal}</textarea></td>
					</c:if>
					<c:if test="${item.code eq 'FN30' }"> 
						<th class="leftNoLine">${item.codeNm }</th>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" value="FN31"  title="${item.codeNm}"  <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN31' }">checked="checked"</c:if> >적합</label></td>
						<td colspan="6" ><label class="radio-inline"><input type="radio" name="${item.code }" value="FN32"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN32' }">checked="checked"</c:if>>조건부적합</label></td>
						<td colspan="2" class="rightNoLine"><label class="radio-inline"><input type="radio" name="${item.code }"  value="FN33"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN33' }">checked="checked"</c:if>>부적합</label></td>
					</c:if>
					<c:if test="${item.code eq 'FN40' }">
						<th class="leftNoLine">${item.codeNm }</th>
						<td colspan="3" ><label class="radio-inline"><input type="radio" name="${item.code }" value="FN41"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN41' }">checked="checked"</c:if>>경미한 수정 보완후 사업시행</label></td>
						<td colspan="6" class="rightNoLine"><label class="radio-inline"><input type="radio" name="${item.code }"  value="FN42"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN42' }">checked="checked"</c:if>>심층컨설팅 후 사업시행</label></td>
					</c:if>			
					<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[listCnt+idx.count].evaluFndSeq }"/>
					</tr>
				</c:forEach>	
					<tr class="bottom">
						<th class="leftNoLine">첨부파일</th>
						<td colspan="9" class="rightNoLine">
							<input type="text" id="fileName1" class="file_input_textbox2 form-control input-sm" disabled="disabled" readonly="readonly">
							<div class="file_input_div2">
								<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button2 btn btn-smOrange" /><!-- 사파리 해결 : &#xe91b; => &#xf0c6; 로 변경 (FontAwesome) -->
								<input type="file" class="file_input_hidden2" onchange="javascript: document.getElementById('fileName1').value = this.value" /> 
							</div>
								<input type="file" class="file_input_hidden2" onchange="javascript: document.getElementById('fileName1').value = this.value" /> 
						</td> 
					</tr>					
				</tbody>
			</table>
		</c:when>
		<c:otherwise>
			<!-- Table -->
			<table class="table tableNormal thCenter tdCenter" id="finlTab">
				<colgroup>
					<col style="width: 260px;">
					<col style="width: 220px;">
					<col style="width: *;"><col style="width: *;"><col style="width: *;"><col style="width: *;"><col style="width: *;"><col style="width: *;"><col style="width: *;">
					<col style="width: 300px;">
				</colgroup>
				<thead>
					<tr>
						<th class="leftNoLine">평가지표</th>
						<th>평가항목</th>
						<th colspan="7">평가(해당항목에 체크)</th>
						<th class="rightNoLine">특이사항</th>
					</tr>
				</thead>
				<tbody>
				<c:set var="listCnt" value="${fn:length(evlauItemLvl1)-1}"/>
				<c:forEach items="${evlauItemLvl1 }" var="item" varStatus="idx">
					<tr>
						<th class="leftNoLine">${item.parentCodeNm }</th>
						<th>${item.codeNm}</th>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_1" value="S"  title="${item.codeNm}"  <c:if test="${fndList[idx.count-1].evaluFndVal eq 'S' }">checked="checked"</c:if>>S</label></td>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_2" value="A"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'A' }">checked="checked"</c:if>>A</label></td>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_3" value="B"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'B' }">checked="checked"</c:if>>B</label></td>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_4" value="C"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'C' }">checked="checked"</c:if>>C</label></td>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_5" value="D"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'D' }">checked="checked"</c:if>>D</label></td>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_6" value="E"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'E' }">checked="checked"</c:if>>E</label></td>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" id="inlineRadio${idx.count}_7" value="F"  title="${item.codeNm}" <c:if test="${fndList[idx.count-1].evaluFndVal eq 'F' }">checked="checked"</c:if>>F</label></td>
						<td class="rightNoLine"><input type="text" class="form-control input-sm"  id="inlineText${idx.count}"  name="txt${item.code }" value="${fndList[idx.count-1].evaluEtcVal }"></td>
						<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[idx.count-1].evaluFndSeq }"/>
					</tr>		
				</c:forEach>
				<c:forEach items="${evlauItemLvl2 }" var="item" varStatus="idx">
					<tr>
					<c:if test="${item.code ne 'FN30' and item.code ne 'FN40' }">
						<th class="leftNoLine">${item.parentCodeNm }<br /> ${item.codeNm }</th>
						<td colspan="9" class="rightNoLine"><textarea class="form-control" rows="3"  name="${item.code }" id="${item.code }" _required="true"  title="${item.parentCodeNm } ${item.codeNm }">${fndList[listCnt+idx.count].evaluFndVal}</textarea></td>
					</c:if>
					<c:if test="${item.code eq 'FN30' }"> 
						<th class="leftNoLine">${item.codeNm }</th>
						<td><label class="radio-inline"><input type="radio" name="${item.code }" value="FN31"  title="${item.codeNm}"  <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN31' }">checked="checked"</c:if> >적합</label></td>
						<td colspan="6" ><label class="radio-inline"><input type="radio" name="${item.code }" value="FN32"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN32' }">checked="checked"</c:if>>조건부적합</label></td>
						<td colspan="2" class="rightNoLine"><label class="radio-inline"><input type="radio" name="${item.code }"  value="FN33"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN33' }">checked="checked"</c:if>>부적합</label></td>
					</c:if>
					<c:if test="${item.code eq 'FN40' }">
						<th class="leftNoLine">${item.codeNm }</th>
						<td colspan="3" ><label class="radio-inline"><input type="radio" name="${item.code }" value="FN41"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN41' }">checked="checked"</c:if>>경미한 수정 보완후 사업시행</label></td>
						<td colspan="6" class="rightNoLine"><label class="radio-inline"><input type="radio" name="${item.code }"  value="FN42"  title="${item.codeNm}" <c:if test="${fndList[listCnt+idx.count].evaluFndVal eq 'FN42' }">checked="checked"</c:if>>심층컨설팅 후 사업시행</label></td>
					</c:if>			
					<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[listCnt+idx.count].evaluFndSeq }"/>
					</tr>
				</c:forEach>	
					<tr class="bottom">
						<th class="leftNoLine">첨부파일</th>
						<td colspan="9" class="rightNoLine">
							<input type="text" id="fileName1" class="file_input_textbox2 form-control input-sm" disabled="disabled" readonly="readonly">
							<div class="file_input_div2">
								<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button2 btn btn-smOrange" /><!-- 사파리 해결 : &#xe91b; => &#xf0c6; 로 변경 (FontAwesome) -->
								<input type="file" class="file_input_hidden2" onchange="javascript: document.getElementById('fileName1').value = this.value" /> 
							</div>
								<input type="file" class="file_input_hidden2" onchange="javascript: document.getElementById('fileName1').value = this.value" /> 
						</td> 
					</tr>					
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>

	<div class="text-center" style="margin:50px 0;">
		<a class="btn btn-green marginRright12"  id="prcBtnUpdt"><i class="icon-ic_done_all">&nbsp;</i>수정</a>
<!-- 		<a class="btn btn-red marginRright12" ><i class="icon-ic_print">&nbsp;</i>문서출력</a> -->
		<a class="btn btn-red"  id="prcBtnList" ><i class="icon-ic_print">&nbsp;</i>취소</a>
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
