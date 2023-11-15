<%--
*******************************************************************************
***    명칭: viewEvaluBusiMgmtHist.jsp
***    설명: [관리자] 평가사업관리 > 평가이력 화면
***
***    -----------------------------    Modified Log   ---------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0    2023.11.07        LHB       First Coding.
*******************************************************************************
--%>
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
	
	<!-- jstree 추가 js -->
	<script type="text/javascript" src="/jquery/jstree/jquery.jstree.js"></script>
	<script type="text/javascript" src="/jquery/jstree/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="/jquery/jstree/jquery.cookie.js"></script>

	<style>
		.body-descriptions { margin-top: 30px !important; }
	</style>

</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
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
    <form:hidden path="evaluBusiSn" />

    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
        <input type="hidden" name="srchBusiStage"  id="srchBusiStage"  value='<c:out value="${paramMap.srchBusiStage}"/>'/>
        <input type="hidden" name="srchEvaluDate"  id="srchEvaluDate"  value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
    </div>
    
    <input type="hidden" name="regiEvaluCommId"     id="regiEvaluCommId"/>

	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>관리자</li>
	                    <li>평가사업관리</li>
	                    <li>${busiInfo.planEvalBusiName}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가사업관리</h3>
	                </div>
	            </div>
	
	            <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	                <div class="shade"></div>
	                <div class="project-title">
	                    <h2>${busiInfo.evaluBusiNm}</h2>
	                    <p>${busiInfo.busiAddr} <%-- / ${busiInfo.EVALU_GUBUN} ${busiInfo.EVALU_STAGE_NM} --%><!--  / 서면검토 단계 --></p>
	                </div>
	                <div class="local-menu th2">
	                    <ul>
	                        <li class="active"><a href="./projectHistory.html" title="사업등록">사업등록</a></li>
	                        <li class="unabled"><a href="./projectInfo.html" title="사업관리">사업관리</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/mng/listEvaluBusiMgmt.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">사업등록</h4>
	                            <!-- <a href="#" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a> -->
	                        </div>
	                        
	                        <p class="section-title">평가사업 신규등록</p>
	                        <table class="evtdss-form-table noMargin">
	                            <tr>
	                                <th>평가연도</th>
	                                <th>평가단계</th>
	                                <th>관리</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">
	                                    <select id="regiEvaluGubun">
	                                        <!-- <option value="">연도선택</option> -->
	                                        <jsp:useBean id="now" class="java.util.Date" />
											<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart" /> 
											<c:forEach begin="0" end="5" var="result" step="1">
												<option value="<c:out value="${yearStart - result}" />" <c:if test="${step eq 1}">selected</c:if>><c:out value="${yearStart - result}" /></option>
											</c:forEach>
	                                    </select>
	                                </td>
	                                <td>
	                                    <!-- /연도 선택 전 -->
	                                    <select id="regiEvaluStage">
	                                    	<c:forEach items="${evaluStageList}" var="list"  varStatus="idx">
	                                    		<option value="${list.code}">${list.codeNm}</option>
	                                    	</c:forEach>
	                                    </select>
	                                </td>
	                                <td class="fix-width status">
	                                    <div class="button-set hor">
	                                        <button type="button" class="inline-button confirm"><a onclick="save_btn()"  title="등록">등록</a></button>
	                                    </div>
	                                </td>
	                            </tr>
	                        </table>
	
							<div class="body-descriptions">
	                            아래 목록을 통해 선택한 사업의 평가이력을 확인하십시오. <strong>평가가 진행중이거나 완료된 항목은 수정할 수 없으며 조회만 가능</strong>합니다.<br>
	                            <strong>설정 중인 평가사업을 수정</strong>하거나, 상단에서 <strong>신규 평가사업을 등록</strong>한 후 사업관리를 시작할 수 있습니다. <br>
	                            본 메뉴는 평가등록 및 평가관리 기능만 제공하며 상세한 평가내용은 평가사업조회 메뉴에서 확인하시기 바랍니다.
	                        </div>
	                        <p class="section-title">평가사업이력<small class="silent">해당 평가 당시의 사업내용은 상기 사업계획서를 참조하시기 바랍니다</small></p>
	                        <!-- order : 생성일 기준으로 최신이력이 상단에 노출 -->
	                        <table class="evtdss-form-table">
	                        	<colgroup>
	                        		<col style="width: 20%;">
	                        		<col style="width: 10%;">
	                        		<col style="width: 30%;">
	                        		<col style="width: 15%;">
	                        		<col style="width: 15%;">
	                        		<col style="width: 20%;">
	                        	</colgroup>
	                            <tr>
	                            	<th>사업코드</th>
	                                <th>평가연도</th>
	                                <th>평가단계</th>
	                                <th>생성일시</th>
	                                <th>진행상황</th>
	                                <th>관리</th>
	                            </tr>
	                            <c:if test="${fn:length(evaluBusiMgmtHistList) == 0}">
	                            	<tr>
		                                <td class="noData" colspan="7">
											데이터가 존재하지 않습니다.
		                                </td>
		                            </tr>
	                            </c:if>
	                            <c:if test="${fn:length(evaluBusiMgmtHistList) > 0}">
	                            	<c:forEach items="${evaluBusiMgmtHistList}" var="list" varStatus="idx">
	                            		<tr>
	                            			<td class="fix-width ft-code status">
			                                	<c:out value="${list.evaluHistNo}" />
			                                </td>
			                                <td class="fix-width status">
			                                	<c:out value="${list.evaluYear}" />
			                                </td>
			                                <td>
			                                	<c:out value="${list.evaluStageNm}" />
			                                </td>
			                                <td class="fix-width date">
			                                	<c:out value="${list.regiDate}" />
			                                </td>
			                                <td class="fix-width status">
			                                    <c:out value="${list.prgrGubunNm}" />
			                                </td>
			                                <td class="fix-width status">
			                                    <div class="button-set hor">
			                                        <c:if test="${list.AGREE_COUNT == 0}">
			                                        	<button type="button" class="inline-button confirm"><a onclick="goModfy('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="수정">수정</a></button>
			                                        	<button type="button" class="inline-button black"><a onclick="goDelete('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="삭제">삭제</a></button>
			                                        </c:if>
			                                        <c:if test="${list.AGREE_COUNT != 0}">
			                                        	<button type="button" class="inline-button green"><a onclick="goModfy('<c:out value="${list.evaluHistSn}"/>');" title="조회">조회</a></button>
			                                        </c:if>
			                                    </div>
			                                </td>
			                            </tr>
	                            	</c:forEach>
	                            </c:if>
	                        </table>
	                        <!-- /Contents -->
	                    </div>
	                </div>
	            </div> <!-- /.container -->
	
	        </div>
	    </div>
	
	</div> <!-- /contents-wrap -->
	
	
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