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
		<strong>사전평가 평가정보 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상 2016년</a></li>
			<li><a href="#">사전평가</a></li>
			<li>평가정보 입력</li>
		</ol>
	</div>
	
	<div class="tab-content">
	    <div class="tab-pane active">
			<c:forEach items="${listSelEvaluPrevCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV110'}">
					<h4>첨부파일</h4>
					<h5>검토의견서</h5>
					<div style="display: inline;" class="_dyFileAreaCls">
						<div style="display: inline;" class="_dynamicGroup">
							<ul class="file_input" style="position:relative; float:left; cursor:pointer;">
								<li class="fileName" style="padding: 1px;">
									<input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" disabled="disabled" readonly="readonly" value="${PV110Map.FILE_ORG_NM}">
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
			
			<c:forEach items="${listSelEvaluPrevCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV660'}">
					<h4>판정 의견</h4>
					<h5>판정 의견 결과</h5>
					<table class="table tableNormal thCenter tdCenter" id="finlTab">
						<colgroup>
							<col style="width: 150px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
							<tr>
								<th><label class="radio-inline"><input type="radio" name="PV660" value="적합"  title="적합"  <c:if test="${PV660Map.EVALU_FND_VALUE eq '적합' }">checked="checked"</c:if> >적합</label></th>
								<td align="left">평가 및 자문의견 반영하여 사업 추진</td>
							</tr>
							<tr>
								<th><label class="radio-inline"><input type="radio" name="PV660" value="조건부 적합"  title="조건부 적합"  <c:if test="${PV660Map.EVALU_FND_VALUE eq '조건부 적합' }">checked="checked"</c:if> >조건부 적합</label></th>
								<td align="left">제기된 문제의 해결 및 보완 후 사업 추진</td>
							</tr>
							<tr>
								<th><label class="radio-inline"><input type="radio" name="PV660" value="부적합"  title="부적합"  <c:if test="${PV660Map.EVALU_FND_VALUE eq '부적합' }">checked="checked"</c:if> >부적합</label></th>
								<td align="left">행·재정적 및 내용적 지적사항 개선 후 재평가</td>
							</tr>
						</tbody>
					</table>
					<br><br>
				</c:if>	
			</c:forEach>
			
			<c:forEach items="${listSelEvaluPrevCode }" var="item" varStatus="idx">
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV510'}">
					<h4>개선 의견</h4>

					<h5>사업 준비도</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV510" title="PV510" name="PV510">${PV510Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV520'}">
					<h5>내용 적정성</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV520" title="PV520" name="PV520">${PV520Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV530'}">
					<h5>운영가능성 및 효과기대성</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV530" title="PV530" name="PV530">${PV530Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>

				<c:if test="${item.EVALU_INDICAT_CD eq 'PV610'}">
					<h4>종합 의견</h4>

					<h5>사업 내용 및 추진 현황의 우수성</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV610" title="PV610" name="PV610">${PV610Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV620'}">
					<h5>사업 내용 및 추진 현황의 미흡한 점</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV620" title="PV620" name="PV620">${PV620Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV630'}">
					<h5>기타의견(제안사항 등)</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV630" title="PV630" name="PV630">${PV630Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>

				<c:if test="${item.EVALU_INDICAT_CD eq 'PV640'}">
					<h4>종합 의견</h4>

					<h5>개선 의견</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV640" title="PV640" name="PV640">${PV640Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>
				<c:if test="${item.EVALU_INDICAT_CD eq 'PV650'}">
					<h5>권고(자문) 사항</h5>
					<div class="alert">
						<textarea rows="10" cols="119" id="PV650" title="PV650" name="PV650">${PV650Map.EVALU_FND_VALUE}</textarea>
					</div>
				</c:if>

<%-- 				<c:if test="${item.EVALU_INDICAT_CD eq 'PV720'}"> --%>
<!-- 					<h5>사전평가 결과 미흡한 점</h5> -->
<!-- 					<div class="alert"> -->
<%-- 						<textarea rows="10" cols="119" id="PV720" title="PV720" name="PV720">${PV720Map.EVALU_FND_VALUE}</textarea> --%>
<!-- 					</div> -->
<%-- 				</c:if> --%>
<%-- 				<c:if test="${item.EVALU_INDICAT_CD eq 'PV730'}"> --%>
<!-- 					<h5>사전평가 결과 우수한 점</h5> -->
<!-- 					<div class="alert"> -->
<%-- 						<textarea rows="10" cols="119" id="PV730" title="PV730" name="PV730">${PV730Map.EVALU_FND_VALUE}</textarea> --%>
<!-- 					</div> -->
<%-- 				</c:if> --%>
				
			</c:forEach>
			

					<c:forEach items="${listSelEvaluPrevCode }" var="item" varStatus="idx">
						<c:if test="${item.EVALU_INDICAT_CD eq 'PV720'}">
						<%-- 				<c:if test="${item.EVALU_INDICAT_CD eq 'PV710'}"> --%>
							<h4>사전평가 진단평가</h4>
							
							<h5>진단평가표</h5>
							<table class="table tableNormal thCenter tdCenter" id="finlTab">
								<colgroup>
									<col style="width: 100px;">
									<col style="width: 100px;">
									<col style="width: *;">
									<col style="width: 100px;">
									<col style="width: 100px;">
									<col style="width: 100px;">
									<col style="width: 100px;">
									<col style="width: 100px;">
								</colgroup>
								<tbody>
									<tr>
										<th>평가요소</th>
										<th>평가항목</th>
										<th>평가지표</th>
										<th>S</th>
										<th>A</th>
										<th>B</th>
										<th>C</th>
										<th>D/F</th>
									</tr>
									<tr>
										<td rowspan="6">사업준비도(40)</td>
										<td rowspan="3">사전점검요인(25)</td>
										<td>지역특별회계 및 기금대상 적합 여부</td>
										<td colspan="4"><label class="radio-inline"><input type="radio" name="PV211" value="5"  title="적합(5)" <c:if test="${PV211Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >적합(5)</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV211" value="0"  title="부적합(0)" <c:if test="${PV211Map.EVALU_FND_VALUE eq '0' }">checked="checked"</c:if> >부적합(0)</label></td>
									</tr>
									<tr>
										<td>사전행정 절차 이행 여부</td>
										<td><label class="radio-inline"><input type="radio" name="PV212" value="10"  title="이행(10)" <c:if test="${PV212Map.EVALU_FND_VALUE eq '10' }">checked="checked"</c:if> >이행(10)</label></td>
										<td colspan="2"><label class="radio-inline"><input type="radio" name="PV212" value="5"  title="이행가능(5)" <c:if test="${PV212Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >이행가능(5)</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV212" value="0"  title="불가능(0)" <c:if test="${PV212Map.EVALU_FND_VALUE eq '0' }">checked="checked"</c:if> >불가능(0)</label></td>
										<td>-</td>
									</tr>
									<tr>
										<td>사업추진의지</td>
										<td><label class="radio-inline"><input type="radio" name="PV213" value="10"  title="10" <c:if test="${PV213Map.EVALU_FND_VALUE eq '10' }">checked="checked"</c:if> >10</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV213" value="7.5"  title="7.5" <c:if test="${PV213Map.EVALU_FND_VALUE eq '7.5' }">checked="checked"</c:if> >7.5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV213" value="5"  title="5" <c:if test="${PV213Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV213" value="2.5"  title="2.5" <c:if test="${PV213Map.EVALU_FND_VALUE eq '2.5' }">checked="checked"</c:if> >2.5</label></td>
										<td>-</td>
									</tr>
									<tr>
										<td rowspan="3">입지적합성(15)</td>
										<td>사업대상지의 입지 적합성</td>
										<td><label class="radio-inline"><input type="radio" name="PV221" value="5"  title="5" <c:if test="${PV221Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV221" value="4"  title="4" <c:if test="${PV221Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV221" value="3"  title="3" <c:if test="${PV221Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV221" value="2"  title="2" <c:if test="${PV221Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV221" value="1"  title="1" <c:if test="${PV221Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>사업 대상지 내 시설물 입지 적절성</td>
										<td><label class="radio-inline"><input type="radio" name="PV222" value="5"  title="5" <c:if test="${PV222Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV222" value="4"  title="4" <c:if test="${PV222Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV222" value="3"  title="3" <c:if test="${PV222Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV222" value="2"  title="2" <c:if test="${PV222Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV222" value="1"  title="1" <c:if test="${PV222Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>사업부지 확보가능성</td>
										<td><label class="radio-inline"><input type="radio" name="PV223" value="5"  title="확보(5)" <c:if test="${PV223Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >확보(5)</label></td>
										<td colspan="2"><label class="radio-inline"><input type="radio" name="PV223" value="3"  title="확보가능(3)" <c:if test="${PV223Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >확보가능(3)</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV223" value="0"  title="미확보(0)" <c:if test="${PV223Map.EVALU_FND_VALUE eq '0' }">checked="checked"</c:if> >미확보(0)</label></td>
										<td>-</td>
									</tr>
									<tr>
										<td rowspan="8">내용적정성(30)</td>
										<td rowspan="2">사업목적 부합성(10)</td>
										<td>상위 또는 유관계획과 정합여부</td>
										<td><label class="radio-inline"><input type="radio" name="PV311" value="5"  title="5" <c:if test="${PV311Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV311" value="4"  title="4" <c:if test="${PV311Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV311" value="3"  title="3" <c:if test="${PV311Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV311" value="2"  title="2" <c:if test="${PV311Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV311" value="1"  title="1" <c:if test="${PV311Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>시설 및 프로그램 부합성</td>
										<td><label class="radio-inline"><input type="radio" name="PV312" value="5"  title="5" <c:if test="${PV312Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV312" value="4"  title="4" <c:if test="${PV312Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV312" value="3"  title="3" <c:if test="${PV312Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV312" value="2"  title="2" <c:if test="${PV312Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV312" value="1"  title="1" <c:if test="${PV312Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td rowspan="2">사업 규모 적정성(10)</td>
										<td>수요예측의 적정성</td>
										<td><label class="radio-inline"><input type="radio" name="PV321" value="5"  title="5" <c:if test="${PV321Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV321" value="4"  title="4" <c:if test="${PV321Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV321" value="3"  title="3" <c:if test="${PV321Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV321" value="2"  title="2" <c:if test="${PV321Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV321" value="1"  title="1" <c:if test="${PV321Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>수요대비 사업규모 적정성</td>
										<td><label class="radio-inline"><input type="radio" name="PV322" value="5"  title="5" <c:if test="${PV322Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV322" value="4"  title="4" <c:if test="${PV322Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV322" value="3"  title="3" <c:if test="${PV322Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV322" value="2"  title="2" <c:if test="${PV322Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV322" value="1"  title="1" <c:if test="${PV322Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td rowspan="2">사업 특화성(10)</td>
										<td>자원의 매력성</td>
										<td><label class="radio-inline"><input type="radio" name="PV331" value="5"  title="5" <c:if test="${PV331Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV331" value="4"  title="4" <c:if test="${PV331Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV331" value="3"  title="3" <c:if test="${PV331Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV331" value="2"  title="2" <c:if test="${PV331Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV331" value="1"  title="1" <c:if test="${PV331Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>사업의 독창성</td>
										<td><label class="radio-inline"><input type="radio" name="PV332" value="5"  title="5" <c:if test="${PV332Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV332" value="4"  title="4" <c:if test="${PV332Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV332" value="3"  title="3" <c:if test="${PV332Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV332" value="2"  title="2" <c:if test="${PV332Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV332" value="1"  title="1" <c:if test="${PV332Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td rowspan="2">사업 중복성(-10)</td>
										<td>중복 투자 및 유사 정책 여부</td>
										<td colspan="4"><label class="radio-inline"><input type="radio" name="PV341" value="0"  title="적합(0)" <c:if test="${PV341Map.EVALU_FND_VALUE eq '0' }">checked="checked"</c:if> >적합(0)</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV341" value="-5"  title="부적합(-5)" <c:if test="${PV341Map.EVALU_FND_VALUE eq '-5' }">checked="checked"</c:if> >부적합(-5)</label></td>
									</tr>
									<tr>
										<td>인근 지역 내 유사 사업 존재 여부</td>
										<td><label class="radio-inline"><input type="radio" name="PV342" value="0"  title="0" <c:if test="${PV342Map.EVALU_FND_VALUE eq '0' }">checked="checked"</c:if> >0</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV342" value="-1"  title="-1" <c:if test="${PV342Map.EVALU_FND_VALUE eq '-1' }">checked="checked"</c:if> >-1</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV342" value="-2"  title="-2" <c:if test="${PV342Map.EVALU_FND_VALUE eq '-2' }">checked="checked"</c:if> >-2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV342" value="-3"  title="-3" <c:if test="${PV342Map.EVALU_FND_VALUE eq '-3' }">checked="checked"</c:if> >-3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV342" value="-4/-5"  title="-4/-5" <c:if test="${PV342Map.EVALU_FND_VALUE eq '-4/-5' }">checked="checked"</c:if> >-4/-5</label></td>
									</tr>
									<tr>
										<td rowspan="6">집행가능성 및 효과기대성(30)</td>
										<td rowspan="3">운영가능성(15)</td>
										<td>사업 추진 인력 계획 수립 여부</td>
										<td><label class="radio-inline"><input type="radio" name="PV411" value="5"  title="5" <c:if test="${PV411Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV411" value="4"  title="4" <c:if test="${PV411Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV411" value="3"  title="3" <c:if test="${PV411Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV411" value="2"  title="2" <c:if test="${PV411Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV411" value="1"  title="1" <c:if test="${PV411Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>시설 및 프로그램 준비 여부</td>
										<td><label class="radio-inline"><input type="radio" name="PV412" value="5"  title="5" <c:if test="${PV412Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV412" value="4"  title="4" <c:if test="${PV412Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV412" value="3"  title="3" <c:if test="${PV412Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV412" value="2"  title="2" <c:if test="${PV412Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV412" value="1"  title="1" <c:if test="${PV412Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>지역주민 협력여부</td>
										<td><label class="radio-inline"><input type="radio" name="PV413" value="5"  title="5" <c:if test="${PV413Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV413" value="4"  title="4" <c:if test="${PV413Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV413" value="3"  title="3" <c:if test="${PV413Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV413" value="2"  title="2" <c:if test="${PV413Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV413" value="1"  title="1" <c:if test="${PV413Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td rowspan="3">사업의 실현 가능성(15)</td>
										<td>사업의 실현 가능성</td>
										<td><label class="radio-inline"><input type="radio" name="PV421" value="10"  title="10" <c:if test="${PV421Map.EVALU_FND_VALUE eq '10' }">checked="checked"</c:if> >10</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV421" value="8"  title="8" <c:if test="${PV421Map.EVALU_FND_VALUE eq '8' }">checked="checked"</c:if> >8</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV421" value="6"  title="6" <c:if test="${PV421Map.EVALU_FND_VALUE eq '6' }">checked="checked"</c:if> >6</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV421" value="4"  title="4" <c:if test="${PV421Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV421" value="2"  title="2" <c:if test="${PV421Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
									</tr>
									<tr>
										<td>미래 여건 대비 운영 가능성</td>
										<td><label class="radio-inline"><input type="radio" name="PV422" value="5"  title="5" <c:if test="${PV422Map.EVALU_FND_VALUE eq '5' }">checked="checked"</c:if> >5</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV422" value="4"  title="4" <c:if test="${PV422Map.EVALU_FND_VALUE eq '4' }">checked="checked"</c:if> >4</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV422" value="3"  title="3" <c:if test="${PV422Map.EVALU_FND_VALUE eq '3' }">checked="checked"</c:if> >3</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV422" value="2"  title="2" <c:if test="${PV422Map.EVALU_FND_VALUE eq '2' }">checked="checked"</c:if> >2</label></td>
										<td><label class="radio-inline"><input type="radio" name="PV422" value="1"  title="1" <c:if test="${PV422Map.EVALU_FND_VALUE eq '1' }">checked="checked"</c:if> >1</label></td>
									</tr>
									<tr>
										<td>민자유치 가능성*(민자유치 계획이 있는 경우)</td>
										<td><label class="radio-inline"><input type="radio" name="PV423" value="0"  title="민간투자확보(0)" <c:if test="${PV423Map.EVALU_FND_VALUE eq '0' }">checked="checked"</c:if> >민간투자확보(0)</label></td>
										<td colspan="2"><label class="radio-inline"><input type="radio" name="PV423" value="-3"  title="민간투자확보가능(-3)" <c:if test="${PV423Map.EVALU_FND_VALUE eq '-3' }">checked="checked"</c:if> >민간투자확보가능(-3)</label></td>
										<td colspan="2"><label class="radio-inline"><input type="radio" name="PV423" value="-5"  title="민간투자어려움(-5)" <c:if test="${PV423Map.EVALU_FND_VALUE eq '-5' }">checked="checked"</c:if> >민간투자어려움(-5)</label></td>
									</tr>
								</tbody>
							</table>
					
							<h5>사전평가 결과 우수한 점</h5>
							<div class="alert">
								<textarea rows="10" cols="119" id="PV720" title="PV720" name="PV720">${PV720Map.EVALU_FND_VALUE}</textarea>
							</div>
						</c:if>
						<c:if test="${item.EVALU_INDICAT_CD eq 'PV730'}">
							<h5>사전평가 결과 미흡한 점</h5>
							<div class="alert">
								<textarea rows="10" cols="119" id="PV730" title="PV730" name="PV730">${PV730Map.EVALU_FND_VALUE}</textarea>
							</div>
						</c:if>
					</c:forEach>
					
<%-- 				</c:if> --%>
			
			
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