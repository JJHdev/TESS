<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)listBbs.jsp 1.0  2014.11.17                               												      		  --%>
<%--                                                                        														  --%>
<%-- COPYRIGHT (C) 2014 SUNDOSOFT CO., INC.                                     											  --%>
<%-- ALL RIGHTS RESERVED.                                                                                                   --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<html lang="ko">
<head>

    <%@ include file="../header.jsp" %>
    <%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
    <%-- 공통게시판 리스트를 검색하는 화면이다.                               												  --%>
    <%--                                                                        													      --%>
    <%-- @author 신영민                                                        									    			  --%>
    <%-- @version 1.0  2014.11.17                                                												  --%>
    <%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

    <title><spring:message code="title.sysname"/></title>
    <%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
    <%-- style & javascript layout                                              --%>
    <%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
    <app:layout mode="stylescript" type="normal"/>
</head>
<body>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- top header layout                                                      --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="header"/>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents begin                                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<form:form commandName="model" name="model" id="model" method="post">
    <!-- 검색 조건 -->
    <form:hidden path="page" id="page"/>
    <!-- 게시판 타입 -->
    <form:hidden path="bbs_type" id="bbs_type"/>
    <!-- 게시물 No -->
    <input type="hidden" name="bbs_no" id="bbs_no"/>

    <div class="contents-wrap">
        <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
            <div class="container">
                <div class="evtdss-breadcrumb">
                    <ul>
                        <li>홈</li>
                        <li>알림방</li>
                        <li>자주묻는질문</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="page-title">자주묻는질문</h3>
                        <!-- Contents -->
                        <div class="grid-head">
                                <%--<div class="grid-count">총 <strong>999</strong> 건</div>--%>
                            <!-- 관리자 전용 -->
                            <c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS'}">
                                <button type="button" class="grid-print green" title="새글작성" onClick="doRegi();"><i
                                        class="glyphicon glyphicon-plus"></i> 새글
                                </button>
                            </c:if>
                            <!-- /관리자 전용 -->
                            <button type="button" class="grid-print green" title="검색" id="srchBtn"><i
                                    class="glyphicon glyphicon-search"></i> 검색
                            </button>
                            <div class="grid-filter">
                                <div class='col-sm-12 noPadding'>
                                    <input type="text" value="" title="검색어" class="inline-input-text" placeholder="검색어 입력">
                                </div>
                            </div>
                            <div class="grid-filter">
                                <div class='col-sm-12 noPadding'>
                                    <div class="form-group-sm">
                                        <select name="commCateFilter" title="검색범위" class="form-control">
                                            <option value="제목" selected>제목</option>
                                            <option value="작성자">작성자</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- /.grid-head -->


                        <div class="table-wrap">

                            <div class="gallery-wrapper">
                                    <%-- panel-group Start --%>
                                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                    <c:if test="${empty pageList }">
                                        <div class="noData"><p>조회결과가 없습니다.</p></div>
                                    </c:if>
                                    <c:if test="${not empty pageList }">
                                        <c:forEach items="${pageList }" varStatus="idx" var="item">
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="heading${idx.index}">
                                                    <h4 class="panel-title">
                                                        <a role="button" data-toggle="collapse" data-parent="#accordion"
                                                           href="#collapse${idx.index}" aria-expanded="true"
                                                           aria-controls="collapseOne">
                                                                ${item.bbsSubject}
                                                        </a>
                                                    </h4>
                                                </div>
                                                <c:if test="${ idx.index eq 0}">
                                                    <div id="collapse${idx.index}" class="panel-collapse collapse in"
                                                </c:if>
                                                <c:if test="${ idx.index ne 0}">
                                                <div id="collapse${idx.index}" class="panel-collapse collapse"
                                                </c:if>
                                                     role="tabpanel"
                                                     aria-labelledby="heading${idx.index}">
                                                    <div class="panel-body">
                                                            ${fn:replace(item.bbsDesc, newLine, "<br/>")}
                                                        <c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS'}">
                                                            <!-- 관리자 표시됩니다. -->
                                                            <div class="grid-head">
                                                                <button type="button" class="grid-print green" onClick="doOpenUpdt(${item.bbsNo});"><i
                                                                        class="glyphicon glyphicon-pencil"></i> 수정
                                                                </button>
                                                            </div>
                                                            <!-- /관리자 표시됩니다. -->
                                                        </c:if>
                                                    </div>
                                                </div>

                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                    <%-- panel-group End --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents end                                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer"/>
</body>
</html>
