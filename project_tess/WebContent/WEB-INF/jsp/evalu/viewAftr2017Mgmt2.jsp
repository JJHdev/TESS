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
		<strong>사후평가 상세화면</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상 2017년</a></li>
			<li><a href="#">사후평가</a></li>
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
					<col style="width: 150px;">
					<col style="width: 180px;">
					<col style="width: 220px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<c:forEach items="${mapList }" var="item" varStatus="idx">
						<tr>
							<th colspan="3">
							<input type="checkbox" name="evaluIdChk" value="${item.commitUserId }|AS10|${item.commitUserNm }" >평가위원</th>
							<td>${item.USER_NM }</td>
						</tr>
						<tr>
							<th rowspan="7">계획 이행도(30)</th>
							<th rowspan="3">사전점검요인(10)</th>
							<th>사업기간 준수 여부(2)</th>
							<td>${item.AFT111 }</td>
						</tr>
						<tr>
							<th>총사업비 집행률(2)</th>
							<td>${item.AFT112 }</td>
						</tr>
						<tr>
							<th>운영관리 계획 수립 및 내용 충실성(6)</th>
							<td>${item.AFT113 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT110 }</td>
						</tr>
						<tr>
							<th rowspan="2">사전 충실도(20)</th>
							<th>사업내용 정합성(10)</th>
							<td>${item.AFT121 }</td>
						</tr>
						<tr>
							<th>목표대비 실적(10)</th>
							<td>${item.AFT122 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT120 }</td>
						</tr>
						
						<tr>
							<th rowspan="12">운영·관리 효율성(30)</th>
							<th rowspan="3">운영관리체계 적절성(10)</th>
							<th>운영관리주체 구성(3)</th>
							<td>${item.AFT211 }</td>
						</tr>
						<tr>
							<th>민관협력 및 주민 참여도(3)</th>
							<td>${item.AFT212 }</td>
						</tr>
						<tr>
							<th>프로그램 운영관리 전문성(4)</th>
							<td>${item.AFT213 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT210 }</td>
						</tr>
						<tr>
							<th rowspan="3">운영관리 및 고용(10)</th>
							<th>운영관리비 중 고정지출 비중(3)</th>
							<td>${item.AFT221 }</td>
						</tr>
						<tr>
							<th>운영관리비 중 수익금 비중(4)</th>
							<td>${item.AFT222 }</td>
						</tr>
						<tr>
							<th>지역주민 고용 비율(3)</th>
							<td>${item.AFT223 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT220 }</td>
						</tr>
						<tr>
							<th rowspan="3">환대서비스 및 안전관리(10)</th>
							<th>노후시설 및 환경정비사업 실적(3)</th>
							<td>${item.AFT231 }</td>
						</tr>
						<tr>
							<th>안내해설체계 운영 여부(3)</th>
							<td>${item.AFT232 }</td>
						</tr>
						<tr>
							<th>안전관리 및 불만접수 처리 노력(4)</th>
							<td>${item.AFT233 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT230 }</td>
						</tr>
						
						<tr>
							<th rowspan="9">지속발전 가능성(40)</th>
							<th rowspan="3">홍보마케팅(15)</th>
							<th>홍보마케팅 전담부서 및 예산 확보(5)</th>
							<td>${item.AFT311 }</td>
						</tr>
						<tr>
							<th>홍보사업 추진 실적(5)</th>
							<td>${item.AFT312 }</td>
						</tr>
						<tr>
							<th>축제 및 이벤트 운영 실적(5)</th>
							<td>${item.AFT313 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT310 }</td>
						</tr>
						<tr>
							<th rowspan="4">지역발전 기여도(25)</th>
							<th>특산품기념품 개발 및 판매 실적(7)</th>
							<td>${item.AFT321 }</td>
						</tr>
						<tr>
							<th>주변 관광자원과 연계운영 실적(7)</th>
							<td>${item.AFT322 }</td>
						</tr>
						<tr>
							<th>관광수용태세 지속적 개선 실적(5)</th>
							<td>${item.AFT323 }</td>
						</tr>
						<tr>
							<th>자체평가 및 컨설팅 실적(6)</th>
							<td>${item.AFT324 }</td>
						</tr>
						<tr>
							<td colspan="3">${item.AFT320 }</td>
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