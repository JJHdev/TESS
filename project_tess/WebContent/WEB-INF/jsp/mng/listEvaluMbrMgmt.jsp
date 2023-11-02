<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

	<!-- Evalu공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
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

    <%-- 공통 필수 --%>
    <input type="hidden" name="mode"       id="mode"      />
    <input type="hidden" name="page"       id="page"      value='<c:out value="${paramMap.page }"/>'/>
    
    <%-- pk --%>
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo"/>
    
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchFieldType"   id="srchFieldType"   value='<c:out value="${paramMap.srchFieldType}"/>'/>
        <input type="hidden" name="srchFieldDetail"   id="srchFieldDetail"   value='<c:out value="${paramMap.srchFieldDetail}"/>'/>
        <input type="hidden" name="srchFieldVal"   id="srchFieldVal"   value='<c:out value="${paramMap.srchFieldVal}"/>'/>
    </div>

	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>관리자</li>
	                    <li>평가위원관리</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가위원관리</h3>
	                    <!-- Contents -->
	                    <form>
	                        <div class="form-group search-form">
	                            <ul class="g-search">
	                                <li class="g-search-col w25"><input type="text" id="srchUserId" class="g-search-input-txt" title="평가위원ID" placeholder="평가위원ID"></li>
	                                <!-- <li class="g-search-col w50"><input type="text" id="srchCommit" class="g-search-input-txt" title="이름/소속/전문분야(대구분, 소구분)" placeholder="이름/소속/전문분야(대구분, 소구분)"></li> -->
	                                <li class="g-search-col w25"><input type="text" id="srchUserNm" class="g-search-input-txt" title="이름" placeholder="이름"></li>
	                                <li class="g-search-col w25"><input type="text" id="srchTelNo" class="g-search-input-txt" title="연락처(전화, 휴대전화)" placeholder="연락처(전화, 휴대전화)"></li>
	                                <li class="g-search-col w25"><input type="text" id="srchField" class="g-search-input-txt" title="전문분야" placeholder="전문분야"></li>
	                            </ul>
	                            <div class="g-search-btn">
	                                <a href="#" onclick="onClickButton('prcBtnSrch');" title="검색시작">검색</a>
	                            </div>
	                        </div>
	                    </form>
	
	                    <div class="grid-head">
	                        <div class="grid-count">총 <strong id="girdCnt">0</strong> 건</div>
	                        <button type="button" class="grid-print" data-grid-control="excel-export"><i class="glyphicon glyphicon-download-alt"></i> 엑셀저장</button>
	                        <button type="button" class="grid-print green" onclick="onClickButton('prcBtnRegi')"><i class="glyphicon glyphicon-plus"></i> 신규등록</button>
	
	                        <div class="grid-filter">
	                            <div class='col-sm-12 noPadding'>
	                                <div class="form-group-sm">
	                                    <!-- <select name="commCateFilter" class="form-control">
	                                        <option value="all" selected>분야 전체</option>
	                                        <option value="2019">문화</option>
	                                        <option value="2018">관광</option>
	                                        <option value="2017">콘텐츠</option>
	                                        <option value="2016">2016</option>
	                                        <option value="2015">2015</option>
	                                    </select> -->
	                                    <!--
	                                    <select id="commCateFilter">
	                                        <option value="all" selected>분야 전체</option>
	                                        <option value="2019">문화</option>
	                                        <option value="2018">관광</option>
	                                        <option value="2017">콘텐츠</option>
	                                        <option value="2016">2016</option>
	                                        <option value="2015">2015</option>
	                                    </select>
	                                    -->
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	
	                    <div class="grid-wrap" data-ax5grid="committee-grid" data-ax5grid-config="{}"></div>
	                    <!-- /Contents -->
	                </div>
	            </div>
	
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