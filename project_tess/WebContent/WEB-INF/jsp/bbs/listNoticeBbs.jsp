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
    <%-- @version 1.0  2014.11.17                                               												  --%>
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
                        <li>공지사항</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="page-title">공지사항</h3>
                        <!-- Contents -->
                        <div class="grid-head">
                            <div class="grid-count">총 <strong>${totalSize }</strong> 건</div>
                            <!-- 관리자 전용 -->
                            <c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS'}">
                            <button type="button" class="grid-print green" title="새글작성" id="openRegiBtn"><i
                                    class="glyphicon glyphicon-plus"></i> 새글
                            </button>
                            </c:if>
                            <button type="button" class="grid-print green" title="검색" id="srchBtn"><i
                                    class="glyphicon glyphicon-search"></i> 검색
                            </button>
                            <!-- /관리자 전용 -->
                            <div class="grid-filter">
                                <div class='col-sm-12 noPadding'>
                                    <form:input id="search_word" title="검색어" path="search_word" type="text" label="검색어"
                                                class="inline-input-text"
                                                placeholder="검색어를 입력하세요."/>
                                </div>
                            </div>

                            <div class="grid-filter" style="margin-left: 5px;">
                                <div class='col-sm-12 noPadding'>
                                    <div class="form-group-sm">
                                        <form:select path="search_name" title="검색범위" class="form-control input-sm" id="search_name"
                                                     style="width:60px;">
                                            <form:option value="" label="">전체</form:option>
                                            <form:option value="title" label="title">제목</form:option>
                                            <form:option value="content" label="content">내용</form:option>
                                        </form:select>
                                    </div>
                                </div>
                            </div>


                            <div class="grid-filter">
                                <div class='col-sm-12 noPadding'>
                                    <div class="form-group-sm">
                                        <form:select path="docu_kind" title="검색조건" class="form-control input-sm" id="docu_kind">
                                            <c:forEach items="${docuKindCodeList }" var="item" varStatus="idx">
                                                <form:option value="${item.code }"
                                                             label="${item.codeNm }">${item.codeNm }</form:option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                            </div>

                        </div> <!-- /.grid-head -->

                        <div class="table-wrap">
                            <table summery="공지사항 게시판입니다. 제목을 클릭하여 상세내용을 볼 수 있습니다.">
                            <caption class="sr-only">공지사항</caption>
                            <colgroup>
                            	<col />
                            	<col />
                            	<col />
                            	<col />
                            	<col />
                            	<col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">구분 </th>
                                    <th scope="col">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">작성일</th>
                                    <th scope="col">조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pageList }" varStatus="idx" var="item">
                                    <tr class="notice">
                                        <td class="fix-width num"><c:out value="${ (totalSize + 1)- item.rNum }"/></td>
                                        <td class="fix-width num"><c:out value="${item.bbsKindNm }"/></td>
                                        <td class="">
                                            <a href="javascript:void(0);" onclick="javascript:doView('${item.bbsNo}')"><c:out
                                                    value="${item.bbsSubject }"/>
                                                    <%--<div class="bbs-stat new"></div>--%>
                                                <c:if test="${item.flChk eq 'Y'}">
                                                    <div class="bbs-stat file"></div>
                                                </c:if>
                                            </a>
                                        </td>
                                        <td class="fix-width title"><c:out value="${item.userNm }"/></td>
                                        <td class="fix-width date"><c:out value="${item.regiDate }"/></td>
                                        <td class="fix-width num"><c:out value="${item.viewCnt }"/></td>
                                    </tr>
                                </c:forEach>                                
							</tbody>                                
                            </table>
                            <div class="pagination-wrap">
                                <form class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-2">
                                            <%-- 10개 고정--%>
                                            <%--<select name="evalPageRows" class="form-control">--%>
                                                <%--<option value="v10">10개씩 보기</option>--%>
                                                <%--<option value="v25">25개씩 보기</option>--%>
                                                <%--<option value="v50">50개씩 보기</option>--%>
                                                <%--<option value="v100">100개씩 보기</option>--%>
                                            <%--</select>--%>
                                        </div>
                                        <div class="col-sm-10">
                                            <app:paging name="pageList" jsFunction="fn_search" />
                                        </div>
                                    </div> <!-- /.form-group -->
                                </form> <!-- /.form-horizontal -->
                            </div> <!-- /.pagination-wrap-group -->
                        </div>
                        <!-- /Contents -->
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- /contents-wrap -->


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
