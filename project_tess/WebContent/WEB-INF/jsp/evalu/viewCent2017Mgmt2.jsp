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
		<strong>중앙투자심사 상세화면</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상 2017년</a></li>
			<li><a href="#">중앙투자심사</a></li>
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
					<col style="width: 115px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<c:forEach items="${mapList }" var="item" varStatus="idx">
						<tr>
							<th colspan="2">
							<input type="checkbox" name="evaluIdChk" value="${item.commitUserId }|AS10|${item.commitUserNm }" >평가위원</th>
							<td>${item.USER_NM }</td>
						</tr>
						<tr>
							<th rowspan="2">사업 영향도</th><th>관광객 유치 및 지역주민 수혜도</th>
							<td>${item.CT750 }</td>
						</tr>
						<tr>
							<th>해당 지역 및 지자체에 미치는 영향</th>
							<td>${item.CT740 }</td>
						</tr>
						<tr>
							<th rowspan="4">사업 타당성</th><th>사업규모 적정성</th>
							<td>${item.CT610 }</td>
						</tr>
						<tr>
							<th>경제적 타당성</th>
							<td>${item.CT620 }</td>
						</tr>
						<tr>
							<th>사업의 시급성</th>
							<td>${item.CT630 }</td>
						</tr>
						<tr>
							<th>사업의 중복성</th>
							<td>${item.CT640 }</td>
						</tr>
						<tr>
							<th rowspan="3">종합 의견</th><th>사업추진의 필요성 및 당위성에 관한 의견</th>
							<td>${item.CT210 }</td>
						</tr>
						<tr>
							<th>개선 의견</th>
							<td>${item.CT220 }</td>
						</tr>
						<tr>
							<th>권고(자문) 사항</th>
							<td>${item.CT230 }</td>
						</tr>
						<tr>
							<th>첨부 파일</th><th>검토의견서</th>
							<td><a href="javascript:;" onclick="javascript:evaluFileDownload2017('${item.commitUserId }');">${item.CT410 }</a></td>
						</tr>
						<tr>
							<th>판정 의견</th><th>판정의견 결과</th>
							<td>${item.CT310 }</td>
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