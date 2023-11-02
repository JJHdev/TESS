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
    <form:hidden path="evaluBusiNo" />

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
	                    <h2>${busiInfo.planEvalBusiName}</h2>
	                    <p>${busiInfo.busiAddress1} <%-- / ${busiInfo.EVALU_GUBUN} ${busiInfo.EVALU_STAGE_NM} --%><!--  / 서면검토 단계 --></p>
	                </div>
	                <div class="local-menu th3">
	                    <ul>
	                        <li class="active"><a href="./projectHistory.html" title="평가이력">평가이력</a></li>
	                        <li class="unabled"><a href="./projectInfo.html" title="평가지침">평가지침</a></li>
	                        <li class="unabled"><a href="./projectPlan.html" title="실행계획">실행계획</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/mng/listEvaluBusiMgmt.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">평가이력조회</h4>
	                            <!-- <a href="#" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a> -->
	                        </div>
	                        <!-- Contents -->
	                        <div class="body-descriptions">
	                            아래 목록을 통해 선택한 사업의 평가이력을 확인하십시오. <strong>평가가 진행중이거나 완료된 항목은 수정할 수 없으며 조회만 가능</strong>합니다.<br>
	                            <strong>설정 중인 평가사업을 수정</strong>하거나, 하단에서 <strong>신규 평가사업을 등록</strong>한 후 설정을 시작할 수 있습니다. <br>
	                            본 메뉴는 평가설정이력만 제공하며 평가내용은 평가사업조회 메뉴에서 확인하시기 바랍니다.
	                        </div>
	
	                        <p class="section-title">평가사업관리이력<small class="silent">해당 평가 당시의 사업내용은 상기 사업계획서를 참조하시기 바랍니다</small></p>
	                        <!-- order : 생성일 기준으로 최신이력이 상단에 노출 -->
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>평가연도</th>
	                                <th>평가단계</th>
	                                <th>평가지침</th>
	                                <th>실행계획</th>
	                                <th>생성일시</th>
	                                <th>진행상황</th>
	                                <th>관리</th>
	                            </tr>
	                            <c:if test="${fn:length(evaluBusiHistList) == 0}">
	                            	<tr>
		                                <td class="noData" colspan="7">
		                                    	데이터가 존재하지 않습니다.
		                                </td>
		                            </tr>
	                            </c:if>
	                            <c:if test="${fn:length(evaluBusiHistList) > 0}">
	                            	<c:forEach items="${evaluBusiHistList}" var="list"  varStatus="idx">
	                            		<tr>
			                                <td class="fix-width status">
			                                	<%-- <c:if test="${list.EVALU_GUBUN == 'PREV'}">2014</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == 'AFTER'}">2015</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == 'AFTER2016'}">2016</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2017'}">2017</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2018'}">2018</c:if> --%>
			                                	
			                                	<%-- <c:if test="${list.EVALU_GUBUN == '2014'}">2014</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2015'}">2015</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2016'}">2016</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2017'}">2017</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2018'}">2018</c:if>
			                                	<c:if test="${list.EVALU_GUBUN == '2019'}">2019</c:if> --%>
			                                	
			                                	${list.EVALU_GUBUN}
			                                </td>
			                                <td>${list.EVALU_STAGE_NM}</td>
			                                <td class="fix-width status">
												<c:if test="${list.EVALU_GUIDE_YN == 'Y'}">등록</c:if>			                                
												<c:if test="${list.EVALU_GUIDE_YN == 'N' || empty list.EVALU_GUIDE_YN}">미등록</c:if>
			                                </td>
			                                <td class="fix-width status">
			                                	<c:if test="${list.EVALU_PLAN_YN == 'Y'}">등록</c:if>
												<c:if test="${list.EVALU_PLAN_YN == 'N' || empty list.EVALU_PLAN_YN}">미등록</c:if>
			                                </td>
			                                <td class="fix-width date">${list.REGI_DATE}</td>
			                                <td class="fix-width status">
			                                    <c:if test="${list.EVALU_FINAL_YN == 'Y'}">
			                                    	평가완료
			                                    </c:if>
			                                    <c:if test="${list.EVALU_FINAL_YN == 'N' && AGREE_COUNT != 0}">
			                                    	평가중
			                                    </c:if>
			                                    <%-- <c:if test="${list.EVALU_GUIDE_YN == 'N' || empty list.EVALU_GUIDE_YN || list.EVALU_PLAN_YN == 'N' || empty list.EVALU_PLAN_YN}"> --%>
			                                    <c:if test="${list.EVALU_FINAL_YN == 'N' && AGREE_COUNT == 0}">
			                                    	대기
			                                    </c:if>
			                                </td>
			                                <td class="fix-width status">
			                                    <div class="button-set hor">
			                                    	<%-- <c:if test="${list.EVALU_GUIDE_YN == 'N' || empty list.EVALU_GUIDE_YN || list.EVALU_PLAN_YN == 'N' || empty list.EVALU_PLAN_YN}">
			                                    		<button type="button" class="inline-button confirm"><a onclick="goModfy('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="수정">수정</a></button>
			                                        	<button type="button" class="inline-button black"><a onclick="goDelete('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="삭제">삭제</a></button>
			                                    	</c:if>
			                                        <c:if test="${list.EVALU_FINAL_YN == 'Y' || list.EVALU_FINAL_YN == 'N' && list.EVALU_GUIDE_YN == 'Y' && list.EVALU_PLAN_YN == 'Y'}">
			                                        	<button type="button" class="inline-button green"><a href="./projectInfo.html" title="조회">조회</a></button>
			                                        </c:if> --%>
			                                        
			                                        <c:if test="${list.AGREE_COUNT == 0}">
			                                        	<button type="button" class="inline-button confirm"><a onclick="goModfy('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="수정">수정</a></button>
			                                        	<button type="button" class="inline-button black"><a onclick="goDelete('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="삭제">삭제</a></button>
			                                        </c:if>
			                                        <c:if test="${list.AGREE_COUNT != 0}">
			                                        	<button type="button" class="inline-button green"><a onclick="goModfy('${list.EVALU_GUBUN}', '${list.EVALU_STAGE}');" title="조회">조회</a></button>
			                                        </c:if>
			                                    </div>
			                                </td>
			                            </tr>
	                            	</c:forEach>
	                            </c:if>
	                        </table>
	
	                        <p class="section-title">평가사업 신규등록<small>아래 설정은 실행계획 설정화면에서 변경할 수 있습니다.</small></p>
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
	                                        <option value="2019" selected>2019</option>
	                                        <option value="2020">2020</option>
	                                        <option value="2021">2021</option>
	                                        <option value="2022">2022</option>
	                                    </select>
	                                </td>
	                                <td>
	                                    <!-- 연도 선택 전 -->
	                                    <!--
	                                    <select id="newEvalLevel" disabled>
	                                        <option value="">-</option>
	                                    </select>
	                                    -->
	                                    <!-- /연도 선택 전 -->
	                                    <select id="regiEvaluStage">
	                                    	<c:forEach items="${evaluStageList}" var="list"  varStatus="idx">
	                                    		<option value="${list.evaluIndicatCd}">${list.evaluIndicatNm}</option>
	                                    	</c:forEach>
	                                    
	                                        <!-- <option value="재정평가심사">재정평가심사</option>
	                                        <option value="사전평가">사전평가</option>
	                                        <option value="집행평가">집행평가</option>
	                                        <option value="사후평가">사후평가</option>
	                                        <option value="컨설팅">컨설팅</option> -->
	                                    </select>
	                                </td>
	                                <td class="fix-width status">
	                                    <div class="button-set hor">
	                                        <button type="button" class="inline-button confirm"><a onclick="save_btn()"  title="등록">등록</a></button>
	                                    </div>
	                                </td>
	                            </tr>
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