<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% pageContext.setAttribute("newLine", "\n"); %>
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
	
	<%-- reporting --%>
	<input type="hidden" name="evaluBusiNm" id="evaluBusiNm" value="${stgMap.evaluBusiNm}" />
	<input type="hidden" name="evaluStage" id="evaluStage" value="${stgMap.evaluStage}" />
	<input type="hidden" name="rtnList" id="rtnList" value="${rtnList}" />

	<input type="hidden" name="evaluGubun" id="evaluGubun" value="${stgMap.evaluGubun}" />
	
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
    </div>

	<%-- 파일다운로드 --%>
	<input type="hidden" name="evaluBusiNo"   id="evaluBusiNo"   value='<c:out value="${paramMap.evaluBusiNo}"/>'/>
	<input type="hidden" name="evaluId"   id="evaluId"   value='<c:out value="${paramMap.evaluId}"/>'/>

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
	

	  <!-- Nav tabs -->
	  <ul class="nav nav-tabs" role="tablist">
	      <li role="presentation"><a href="#" onclick="tab1()" aria-controls="tab1" role="tab" data-toggle="tab">사업정보</a></li>
	      <li role="presentation" class="active"><a href="#" onclick="tab2()" aria-controls="tab2" role="tab" data-toggle="tab">평가정보 확인</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="tab2">
			<h5>평가위원별 사업평가 정보</h5>
			<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 100px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
				<c:forEach items="${mapList }" var="item" varStatus="idx">
					<tr>
						<th>평가위원</th>
						<td>${item.USER_NM }</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><a href="javascript:;" onclick="javascript:evaluFileDownload2017('${item.commitUserId }');">${item.PR110 }</a></td>
					</tr>
					<tr>
						<th>사업준비도</th>
						<td>${item.PR400 }</td>
					</tr>
					<tr>
						<th>사전점검요인</th>
						<td>${item.PR410 }</td>
					</tr>
					<tr>
						<th>입지적합성</th>
						<td>${item.PR420 }</td>
					</tr>
					<tr>
						<th>사업 추진 및 내용 적정성</th>
						<td>${item.PR500 }</td>
					</tr>
					<tr>
						<th>사업 진척률</th>
						<td>${item.PR510 }</td>
					</tr>
					<tr>
						<th>사업 특화성</th>
						<td>${item.PR520 }</td>
					</tr>
					<tr>
						<th>사업내용 부합성</th>
						<td>${item.PR530 }</td>
					</tr>
					<tr>
						<th>운영가능성</th>
						<td>${item.PR600 }</td>
					</tr>
					<tr>
						<th>관리운영 적절성</th>
						<td>${item.PR610 }</td>
					</tr>
					<tr>
						<th>사업실현 가능성</th>
						<td>${item.PR620 }</td>
					</tr>
					<tr>
						<th>종합의견</th>
						<td>${item.PR200 }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table><!-- //Table--> 
				
			<div class="text-center" style="margin:55px 0;">
<!-- 				<a class="btn btn-green marginRright12" id="prcBtnRegi"><i class="icon-ic_create">&nbsp;</i>평가정보 입력</a> -->
<!-- 				<a class="btn btn-grassGreen marginRright12" href="#" data-toggle="modal" data-target="#myModal" id="prcBtnModal"><i class="icon-ic_border_color">&nbsp;</i>최종결과 입력</a> -->
				<a class="btn btn-red" id="prcBtnList" ><i class="icon-ic_refresh">&nbsp;</i>취소</a>
			</div>
				
		</div><!-- //tab2-->
		
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<div class="pull-left"><i class="icon-ic_assignment"></i></div>
		        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
		        	<h4>계획단계 평가대상 세부내용</h4>
		      </div>
		      <div class="modal-body">
		
					<!-- Table --><!-- 20160201 수정 -->
					<table class="table tableNormal small">
						<colgroup>
							<col style="width: 115px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
							<tr class="top">
								<th class="leftNoLine">최종평가결과</th>
								<td class="rightNoLine">
									<select class="form-control input-sm" style="width: 240px;" id="finalEvaluFnd" name="finalEvaluFnd">
									  <option value="">::전체::</option>
				                        <c:forEach items="${finlRestlSelComboList }" varStatus="idx" var="type">
				                            <option value='<c:out value="${type.code }"/>' <c:if test="${stgMap.finalEvaluFndCd eq type.code}">selected="selected"</c:if>>
				                                <c:out value="${type.codeNm }"/>
				                            </option>
				                        </c:forEach>
									</select>
								</td>
							</tr>
							<tr class="bottom">
								<th class="leftNoLine">최종평가결과내용</th>
								<td class="rightNoLine">
									<textarea class="form-control" rows="3" name="finalEvaluFndNote" id="finalEvaluFndNote" title="평가일">${stgMap.finalEvaluFndNote }</textarea>
								</td>
							</tr>	
						</tbody>
					</table><!-- //Table-->
					
					<div class="text-center" style="margin: 40px 0;">
						<button type="button" class="btn btn-green marginRright12"  id="prcBtnAppr" ><i class="icon-ic_check "> </i>확인</button>
						<button type="button" class="btn btn-red" data-dismiss="modal"><i class="icon-ic_refresh"> </i>취소</button>
		        	</div>
		        	
		      </div><!-- //modal-body-->
		    </div><!-- //modal-content -->
		  </div><!-- //modal-dialog -->
		</div><!-- //Modal -->		
	    
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