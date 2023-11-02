<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)listBbs.jsp 1.0  2014.11.17                               												      		  --%>
<%--                                                                        														  --%>
<%-- COPYRIGHT (C) 2014 SUNDOSOFT CO., INC.                                     											  --%>
<%-- ALL RIGHTS RESERVED.                                                                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>

	<%@ include file="../header.jsp" %>
	<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	<%-- 자료실 상세조회 화면이다.                             												  			  --%>
	<%--                                                                        													      --%>
	<%-- @author 민대원                                                        									    			  --%>
	<%-- @version 1.0  2018.12.07                                               												  --%>
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

<form:form commandName="model" id="model" method="post">

<!-- 검색 조건 -->
<form:hidden path="page" id="page"/>
<form:hidden path="search_name" id="search_name"/>
<form:hidden path="search_word" id="search_word"/>
<form:hidden path="docu_kind" id="docu_kind"/>
<!-- 게시판 타입 -->
<form:hidden path="bbs_type" id="bbs_type"/>
<!-- 게시판 No -->
<input type="hidden" name="bbs_no" id="bbs_no" value="${resultView.bbsNo }"/>

<div class="contents-wrap">
	<div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
		<div class="container">
			<div class="evtdss-breadcrumb">
				<ul>
					<li>홈</li>
					<li>알림방</li>
					<li>자료실</li>
				</ul>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h3 class="page-title">자료실 보기</h3>
					<!-- Contents -->
					<table class="evtdss-form-table noMargin">
						<tr>
							<td class="labeler">제목</td>
							<td colspan="3"><strong><c:out value="${resultView.bbsSubject }"/></strong></td>
						</tr>
						<tr>
							<td class="labeler">작성자</td>
							<td><c:out value="${resultView.userNm }"/></td>
							<td class="labeler">작성일</td>
							<td class="fix-width date"><c:out value="${resultView.regiDate }"/></td>
						</tr>
						<tr>
							<td class="labeler">첨부파일</td>
							<td colspan="3">
								<c:forEach items="${resultView.fileList }" var="item" varStatus="idx">
									<a href="javascript:download('${item.fileNo}');"><c:out
											value="${item.fileOrgNm }"></c:out></a></br>
								</c:forEach>
							</td>
						</tr>
					</table>

					<div class="bbs-body-view">
                        <pre>
								${resultView.bbsDesc }
						</pre>
					</div>
					</form:form>


					<div class="grid-head">
						<button type="button" class="grid-list" onClick="doList();"><i class="glyphicon glyphicon glyphicon-chevron-left"></i> 목록</button>
						<c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS'}">
						<button type="button" class="grid-print"  id="_delBtn"><i class="glyphicon glyphicon-trash"></i>삭제</button>
						<button type="button" class="grid-print green" id="_openUpdtBtn"><i class="glyphicon glyphicon-pencil"></i> 수정</button>
						<%--<button class="grid-print green" onClick="modBbs();"><i class="glyphicon glyphicon-plus"></i> 새글</button>--%>
						</c:if>
					</div>

					<p class="clearfix br"></p>

					<table class="evtdss-form-table">
						<tr>
							<td class="labeler">이전글</td>
							<td>
								<c:if test="${not empty resultView.preTitle }">
									<a href="#link" onclick="javascript:doView('${resultView.preSeq}')"><c:out
											value="${resultView.preTitle }"/></a>
								</c:if>
								<c:if test="${empty resultView.preTitle }">
									이전글이 없습니다.
								</c:if>
							</td>
						</tr>
						<tr>
							<td class="labeler">다음글</td>
							<td>
								<c:if test="${not empty resultView.nextTitle }">
									<a href="#link" onclick="javascript:doView('${resultView.nextSeq}')"><c:out
											value="${resultView.nextTitle }"/></a>
								</c:if>
								<c:if test="${empty resultView.nextTitle }">
									다음글이 없습니다.
								</c:if>
							</td>
						</tr>
					</table>
					<!-- /Contents -->
				</div>
			</div>
		</div>

	</div>
</div>
<!-- /contents-wrap -->




<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents end                                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer"/>
</body>
</html>