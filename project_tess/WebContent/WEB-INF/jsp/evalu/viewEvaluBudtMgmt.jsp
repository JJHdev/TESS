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
    
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
    </div>
    
<%-- 	<c:if test="${paramMap.evaluStage ne 'EVALU_CENT' && --%>
<%-- 				 paramMap.evaluStage ne 'EVALU_PROG' && --%>
<%-- 				 paramMap.evaluStage ne 'EVALU_PREV' && --%>
<%-- 				 paramMap.evaluStage ne 'PREV_2017' && --%>
<%-- 				 paramMap.evaluStage ne 'CENT_2017' && --%>
<%-- 				 paramMap.evaluStage ne 'AFTR_2017' && --%>
<%-- 				 paramMap.evaluStage ne 'MNTR_2017'} "> --%>
<!-- 		<div class="contentsTilteLine"> -->
<!-- 			<strong>계획평가 상세화면2</strong> -->
<!-- 			<ol class="breadcrumb pull-right"> -->
<!-- 	        	<strong>현재 페이지 :&nbsp;</strong> -->
<!-- 				<li><a href="#">HOME</a></li> -->
<!-- 				<li><a href="#">평가대상</a></li> -->
<!-- 				<li><a href="#">계획평가</a></li> -->
<!-- 				<li>상세화면</li> -->
<!-- 			</ol> -->
<!-- 		</div> -->
<%--     </c:if> --%>
    <c:if test="${paramMap.evaluStage eq 'EVALU_CENT' }">
		<div class="contentsTilteLine">
			<strong>중앙투자심사 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2016년</a></li>
				<li><a href="#">중앙투자심사</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
    <c:if test="${paramMap.evaluStage eq 'EVALU_PROG' }">
		<div class="contentsTilteLine">
			<strong>집행평가 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2016년</a></li>
				<li><a href="#">집행평가</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
    <c:if test="${paramMap.evaluStage eq 'EVALU_PREV' }">
		<div class="contentsTilteLine">
			<strong>사전평가 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2016년</a></li>
				<li><a href="#">사전평가</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
    <c:if test="${paramMap.evaluStage eq 'PREV_2017' }">
		<div class="contentsTilteLine">
			<strong>사전평가 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">사전평가</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
    <c:if test="${paramMap.evaluStage eq 'CENT_2017' }">
		<div class="contentsTilteLine">
			<strong>중앙투자심사 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">중앙투자심사</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
    <c:if test="${paramMap.evaluStage eq 'AFTR_2017' }">
		<div class="contentsTilteLine">
			<strong>사후평가 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">사후평가</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
    <c:if test="${paramMap.evaluStage eq 'MNTR_2017' }">
		<div class="contentsTilteLine">
			<strong>모니터링 상세화면</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">모니터링</a></li>
				<li>상세화면</li>
			</ol>
		</div>
    </c:if>
	

	  <!-- Nav tabs -->
	  <ul class="nav nav-tabs" role="tablist">
	      <li role="presentation" class="active"><a href="#" onclick="tab1()" aria-controls="tab1" role="tab" data-toggle="tab">사업정보</a></li>
	      <li role="presentation"><a href="#" onclick="tab2()" aria-controls="tab2" role="tab" data-toggle="tab">평가정보 확인</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="tab1">

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
							<td class="rightNoLine"><c:out value="${rtnMap.evaluBusiNm}"/></td>
						</tr>
						<tr>
							<th class="leftNoLine">위치</th>
							<td class="rightNoLine"><c:out value="${rtnMap.busiAddr12}"/> <c:out value="${rtnMap.busiAddr5}"/></td>
						</tr>	
						<tr>
							<th class="leftNoLine">개발면적</th>
							<td class="rightNoLine"><fmt:formatNumber value="${rtnMap.totSiteArea}" type="number"/>${ rtnMap.totSiteUnit}</td>
						</tr>	
						<tr>
							<th class="leftNoLine">사업기간</th>
							<td class="rightNoLine"><c:out value="${rtnMap.convBusiSttDate}"/> ~ <c:out value="${rtnMap.convBusiEndDate}"/></td>	
						</tr>	
						<tr>
							<th class="leftNoLine">사업운영주체</th>
							<td class="rightNoLine"><c:out value="${rtnMap.busiDevEnty}"/></td>
						</tr>	
						<tr>
							<th class="leftNoLine">계획수립일자</th>
							<td class="rightNoLine"><c:out value="${rtnMap.convBusiPlanDate}"/></td>
						</tr>	
						<tr>
							<th class="leftNoLine">사업의 구분</th>
							<td class="rightNoLine"><c:out value="${rtnMap.busiTypeNm}"/></td>
						</tr>	
						<tr>
							<th class="leftNoLine">사업의 유형</th>
							<td class="rightNoLine"><c:out value="${rtnMap.busiCateNm}"/></td>
						</tr>	
						<tr class="bottom">
							<th class="leftNoLine">총사업비</th>
							<td class="rightNoLine"><fmt:formatNumber value="${rtnMap.totBusiExps}" type="number"/></td>
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


				<h5>평가계획 수립정보 입력</h5>
				<!-- Table -->
				<table class="table tableNormal">
					<colgroup>
						<col style="width: 115px;">
						<col style="width: 290px;">
						<col style="width: 115px;">
						<col style="width: *;">
					</colgroup>
					<tbody>
						<tr class="top2">
							<th class="leftNoLine">평가대상항목</th>
							<td class="rightNoLine"><c:out value="${rtnMap.evaluStageNm}"/></td>
							<th>사전평가대상</th>
							<td class="rightNoLine"><c:out value="${rtnMap.convEvaluBefoTrgt}"/></td>
						</tr>
						<tr class="bottom">
							<th class="leftNoLine">평가일</th>
							<td class="rightNoLine"> <c:out value="${rtnMap.conEvaluDate}"/></td>
							<th>평가위원 매칭</th>
							<td class="rightNoLine"><c:out value="${rtnMap.evaluUserNm}"/></td>
						</tr>	
					</tbody>
				</table><!-- //Table-->
				
				
				<div class="text-center" style="margin:55px 0;">
				<!-- 
					<a class="btn btn-green marginRright12" href="#" ><i class="icon-ic_create">&nbsp;</i>평가정보 입력</a>
				 -->	
					<a class="btn btn-red" id="prcBtnList" ><i class="icon-ic_refresh">&nbsp;</i>취소</a>
				</div>

		</div><!-- //tab1-->
	  </div><!-- //tab-content-->
</form:form>

</div> <!-- /contents -->

<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->


<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>