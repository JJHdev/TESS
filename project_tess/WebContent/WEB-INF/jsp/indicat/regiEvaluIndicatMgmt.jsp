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
	
	<div class="contentsTilte">
		<strong>평가지표 등록</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가관리</a></li>
			<li>평가지표 등록</li>
		</ol>
	</div>
						

	<!-- Table -->
	<table class="table tableNormal small">
		<colgroup>
			<col style="width: 116px;">
			<col style="width: *;">
			<col style="width: 116px;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr class="top2">
				<th class="leftNoLine">평가지표</th>
				<td class="rightNoLine" colspan="3"><input type="text" class="form-control input-sm" id=""  /></td>
			</tr>
			<tr>
				<th class="leftNoLine">평가단계</th>
				<td class="rightNoLine" colspan="3">
					<select class="form-control input-sm" style="width: 200px;"  id="evaluItemCd" name="evaluItemCd">
						<option value="">::전체::</option>	
						<c:forEach items="${evaluIndicatComboList1 }"  var="item" varStatus="idx">
							 <option value='<c:out value="${item.code }"/>' ${(paramMap.srchBusiCate == item.code)? "selected":"" }>
							          <c:out value="${item.codeNm }"/>
                                </option>
						</c:forEach>
					</select>
				</td>
			</tr>	
			<tr>
				<th class="leftNoLine">평가항목</th>
				<td class="rightNoLine" colspan="3">
					<table class="noLine">
						<tr>
							<td>
								<select class="form-control input-sm marginRright12" style="width: 200px;" id="pareEvaluIndicatCd" name="pareEvaluIndicatCd">
								</select>
							</td>
							<td>
								<select class="form-control input-sm" style="width: 200px;" id="evaluIndicatCd" name="evaluIndicatCd">
								</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>	
			<tr>
				<th class="leftNoLine">순서</th>
				<td><input type="text" class="form-control input-sm" id="codeOrd"  name="codeOrd" /></td>
				<th>사용여부</th>
				<td class="rightNoLine">
					<select class="form-control input-sm" style="width: 200px;" id="evaluIndicatCd" name="evaluIndicatCd">
						<option value="">::전체::</option>	
						<option value="Y">사용</option>		
						<option value="N">미사용</option>		
					</select>			
				</td>
			</tr>						
			<tr> 
				<th class="leftNoLine">평가내용</th>
				<td class="rightNoLine" colspan="3"><input type="text" class="form-control input-sm" id="evaluContent"  name="evaluContent"/></td>
			</tr>						
		</tbody>
	</table><!-- //Table-->

	<div class="text-center" style="margin:50px 0;">
		<a class="btn btn-green marginRright12" href="#" ><i class="icon-ic_save">&nbsp;</i>저장</a>
		<a class="btn btn-red" ><i class="icon-ic_refresh">&nbsp;</i>취소</a>
	</div>
	
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