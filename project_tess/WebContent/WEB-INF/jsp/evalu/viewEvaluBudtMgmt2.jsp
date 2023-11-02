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

<%--     <c:if test="${paramMap.evaluStage ne 'EVALU_CENT' && --%>
<%--     			 paramMap.evaluStage ne 'EVALU_PROG' && --%>
<%--     			 paramMap.evaluStage ne 'EVALU_PREV' && --%>
<%--     			 paramMap.evaluStage ne 'PREV_2017' && --%>
<%--     			 paramMap.evaluStage ne 'CENT_2017' && --%>
<%--     			 paramMap.evaluStage ne 'AFTR_2017' && --%>
<%--     			 paramMap.evaluStage ne 'MNTR_2017'  }"> --%>
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
				<li><a href="#">평가대상 2017년</a></li>
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
	      <li role="presentation"><a href="#" onclick="tab1()" aria-controls="tab1" role="tab" data-toggle="tab">사업정보</a></li>
	      <li role="presentation" class="active"><a href="#" onclick="tab2()" aria-controls="tab2" role="tab" data-toggle="tab">평가정보 확인</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="tab2">
				<h5>평가위원별 사업평가 정보</h5>
				<div style="position:relative; margin-top:-28px; height:28px;">
					<div style=" position:absolute; top:0px; right:0px;">
						<c:if test="${paramMap.evaluStage ne 'EVALU_CENT' &&
									  paramMap.evaluStage ne 'EVALU_PROG' &&
									  paramMap.evaluStage ne 'EVALU_PREV' && 
									  paramMap.evaluStage ne 'PREV_2017' && 
									  paramMap.evaluStage ne 'CENT_2017' && 
									  paramMap.evaluStage ne 'AFTR_2017' && 
									  paramMap.evaluStage ne 'MNTR_2017'  }">
							<span id="prcBtnReport"><a class="btn btn-smBlue _dyFileBtnAddCls" onclick="reporting();"><i class="fa fa-file-excel-o">&nbsp;</i>Report</a></span>
						</c:if>
					</div>
				</div>
				<table class="table tableNormal" id="evaluInfoTab">
					<colgroup>
						<col style="width: 36px;">
						<col style="width: 115px;">
						<col style="width: *;">
					</colgroup>
					<tbody>
					<c:forEach items="${rtnList }" var="item" varStatus="idx">
						<c:if test="${ idx.count mod (evaluFinlCnt) eq 1 || evaluFinlCnt eq 1 }">
							<tr <c:if test="${idx.count eq 1 }">class="top2"</c:if>>
								<th rowspan="${evaluFinlCnt +1}" class="leftNoLine whiteBg" ><input type="checkbox" name="evaluIdChk" value="${item.commitUserId }|${item.evaluProcStep}|${item.commitUserNm }" ></th>
								<th>평가위원</th>
								<td class="rightNoLine">
								<c:if test="${paramMap.gsRoleId eq 'ROLE_AUTH_SYS' }">
									<a href="#">${item.commitUserNm }</a>
								</c:if>
								<c:if test="${paramMap.gsRoleId ne 'ROLE_AUTH_SYS' }">
									<a href="#">***</a>
								</c:if>							
								<c:if test="${item.evaluProcStep ne 'AS10'  }">
									<!--<span class="btn btn-smBlue" style="float: right;" onclick="goView('${item.commitUserId }|${item.evaluProcStep}');"><i class="icon-arrow_right">&nbsp;</i>상세화면 이동</span>-->
								</c:if>	
									<input type="hidden" name="evaluProcStep" value="${item.evaluProcStep}"/>
								</td> 
							</tr>	
						</c:if>
						<tr <c:if test="${idx.count eq fn:length(rtnList) }">class="bottom"</c:if>>
							<th>${item.evaluIndicatNm }</th>
							<td class="rightNoLine">
							<c:choose>
								<c:when test="${item.convEvaluFndValue eq null }">
<%-- 									${ fn:replace( item.evaluFndValue, newLine, '<br/>' ) } --%>
									<c:if test="${item.evaluIndicatNm eq '검토의견서'}">
										<a onclick="javascript:evaluFileDownload('${item.commitUserId}')">${item.evaluFndValue}</a>
									</c:if>
									<c:if test="${item.evaluIndicatNm ne '검토의견서'}">
										${item.evaluFndValue}
									</c:if>
								</c:when>
								<c:when test="${item.convEvaluFndValue ne null}">
<%-- 									${ fn:replace( item.convEvaluFndValue, newLine, '<br/>' ) } --%>
									${item.convEvaluFndValue}
								</c:when>							
							</c:choose>	
							</td>
						</tr>				
					</c:forEach>
					</tbody>
				</table><!-- //Table--> 
				
				<c:if test="${paramMap.evaluStage ne 'EVALU_CENT' ||
							 paramMap.evaluStage ne 'EVALU_PROG' ||
							 paramMap.evaluStage ne 'EVALU_PREV' ||
							 paramMap.evaluStage ne 'PREV_2017' ||
							 paramMap.evaluStage ne 'CENT_2017' ||
							 paramMap.evaluStage ne 'AFTR_2017' ||
							 paramMap.evaluStage ne 'MNTR_2017'	 }">
					<h5>사업 최종평가</h5>
					<table class="table tableNormal">
						<colgroup> 
							<col style="width: 150px;">
							<col style="width: *;">
						</colgroup>
							<tr class="top2">
								<th>최종평가결과</th> 
								<td>${stgMap.finalEvaluFnd }</td>
							</tr>
							<tr class="bottom">
								<th>최종평가결과내용</th>
								<td>${ fn:replace( stgMap.finalEvaluFndNote, newLine, '<br/>' ) }</td>
							</tr>
						</tbody>
					</table>				
				</c:if>
				
				<div class="text-center" style="margin:55px 0;">
<!-- 					<a class="btn btn-green marginRright12" id="prcBtnRegi"><i class="icon-ic_create">&nbsp;</i>평가정보 입력</a> -->
<!-- 					<a class="btn btn-grassGreen marginRright12" href="#" data-toggle="modal" data-target="#myModal" id="prcBtnModal"><i class="icon-ic_border_color">&nbsp;</i>최종결과 입력</a> -->
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