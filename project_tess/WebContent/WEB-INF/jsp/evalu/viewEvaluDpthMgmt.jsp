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
    
    <%-- reporting --%>
	<input type="hidden" name="evaluBusiNm" id="evaluBusiNm" value="${stgMap.evaluBusiNm}" />
	<input type="hidden" name="evaluStage" id="evaluStage" value="${stgMap.evaluStage}" />
	
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
		<strong>계획평가 상세화면2</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상</a></li>
			<li><a href="#">계획평가</a></li>
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
				<div style="position:relative; margin-top:-28px; height:28px;">
					<div style=" position:absolute; top:0px; right:0px;">
						<span id="prcBtnReport"><a class="btn btn-smBlue _dyFileBtnAddCls" onclick="reporting();"><i class="fa fa-file-excel-o">&nbsp;</i>Report</a></span>
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
					<c:if test="${ idx.count mod 5 eq 1 }">
						<tr <c:if test="${idx.count eq 1 }">class="top2"</c:if>>
							<th rowspan="6" class="leftNoLine whiteBg" ><input type="checkbox" name="evaluIdChk" value="${item.commitUserId }|${item.evaluProcStep}|${item.commitUserNm }" ></th>
							<th>평가위원</th>
							<td class="rightNoLine">
								<a href="#">${item.commitUserNm }</a>
								<c:if test="${item.evaluProcStep ne 'AS10'  }">
									<span class="btn btn-smBlue" style="float: right;" onclick="goView('${item.commitUserId }|${item.evaluProcStep}');"><i class="icon-arrow_right">&nbsp;</i>상세화면 이동</span>
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
									${item.evaluFndValue }
								</c:when>
								<c:when test="${item.convEvaluFndValue ne null}">
									${item.convEvaluFndValue }
								</c:when>								
							</c:choose>	
							</td>
						</tr>				
					</c:forEach>
					</tbody>
				</table><!-- //Table--> 
				
				<div class="text-center" style="margin:55px 0;">
					<a class="btn btn-green marginRright12" id="prcBtnRegi"><i class="icon-ic_create">&nbsp;</i>평가정보 입력</a>
					<a class="btn btn-grassGreen marginRright12" href="#" data-toggle="modal" data-target="#myModal" id="prcBtnModal"><i class="icon-ic_border_color">&nbsp;</i>최종결과 입력</a>
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
					<table>
						<colgroup>
							<col style="width: 70px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
							<tr>
								<td class="titleIcon"><i class="icon-ic_user"> </i></td>
								<td class="subject"><strong class="textRed">최종 승인 하시겠습니까?</strong></td>
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