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
<!-- ==================== 중앙내용 시작 ========================= -->
<!-- ======================================================= -->

<div class="contents" >
<form:form commandName="model" name="model" id="model">

    <%-- pk --%>
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>
    
    <%-- pk --%>
    <form:hidden path="evaluBusiNo" />
    
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
    </div>
	
	<div class="contentsTilteLine">
		<strong>사업등록 상세화면</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">사업관리</a></li>
			<li><a href="#">사업등록</a></li>
			<li>사업등록 상세화면</li>
		</ol>
	</div>
						
	<h5>관광개발사업 개요</h5>
	<!-- Table -->
	<table class="table tableNormal">
		<colgroup>
			<col style="width: 115px;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr class="top2">
				<th class="leftNoLine">사업명</th>
				<td class="rightNoLine"><c:out value="${mastMap.evaluBusiNm}"/></td>
			</tr>
			<tr>
				<th class="leftNoLine">위치</th>
				<td class="rightNoLine"><c:out value="${mastMap.busiAddr12}"/> <c:out value="${mastMap.busiAddr5}"/></td>
			</tr>	
			<tr>
				<th class="leftNoLine">개발면적</th>
				<td class="rightNoLine"><fmt:formatNumber value="${mastMap.totSiteArea}" type="number"/>${ mastMap.totSiteUnit}</td>
			</tr>	
			<tr>
				<th class="leftNoLine">사업기간</th>
				<td class="rightNoLine"> <c:out value="${mastMap.convBusiSttDate}"/> ~ <c:out value="${mastMap.convBusiEndDate}"/></td>	
			</tr>	
			<tr>
				<th class="leftNoLine">개발사업주체</th>
				<td class="rightNoLine"><c:out value="${mastMap.busiDevEnty}"/></td>
			</tr>	
			<tr>
				<th class="leftNoLine">계획수립일자</th>
				<td class="rightNoLine"><c:out value="${mastMap.convBusiPlanDate}"/></td>
			</tr>	
			<tr>
				<th class="leftNoLine">사업의 구분</th>
				<td class="rightNoLine"><c:out value="${mastMap.busiTypeNm}"/></td>
			</tr>	
			<tr>
				<th class="leftNoLine">사업의 유형</th>
				<td class="rightNoLine"><c:out value="${mastMap.busiDevEnty}"/></td>
			</tr>	
			<tr class="bottom">
				<th class="leftNoLine">총사업비</th>
				<td class="rightNoLine"><fmt:formatNumber value="${mastMap.totBusiExps}" type="number"/></td>
			</tr>	
		</tbody>
	</table><!-- //Table-->


	<h5>사업관련파일</h5>
	<!-- Table -->
	<table class="table tableNormal">
		<colgroup>
			<col style="width: 150px;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr class="top2">
				<th colspan="2" class="leftNoLine rightNoLine bottom">첨부파일</th>
			</tr>
	<c:if test="${empty plyyFileList }">
			<tr>
				<td colspan="2" class="rightNoLine leftNoLine">첨부된 파일이 없습니다.</td>
			</tr>
	</c:if>
	<c:if test="${not empty plyyFileList }">
		<c:forEach items="${plyyFileList }" var="item"  varStatus="idx">
			<tr <c:if test="${fn:length(plyyFileList) eq idx.count }">class="bottom"</c:if>>	
				<td>${item.docuTypeNm }</td>
				<td class="rightNoLine"><a href="#"><i class="icon-ic_save font14 textRed">&nbsp;</i>${item.fileOrgNm }</a></td>
			</tr>		
		</c:forEach>
	</c:if>		
		</tbody>
	</table><!-- //Table-->

	<div class="text-center" style="margin:55px 0 145px;">
		<a class="btn btn-green marginRright12" href="#"  id="prcBtnUpdt"><i class="icon-ic_sync">&nbsp;</i>수정</a><!-- 20160203 : marginRright15 => marginRright12 이름변경 -->
		<a class="btn btn-red"  id="prcBtnList"><i class="icon-ic_refresh">&nbsp;</i>취소</a><!-- 20160203 : 모달링크 삭제, 하단 모달내용 삭제 -->
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