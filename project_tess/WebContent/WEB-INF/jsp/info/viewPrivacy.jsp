<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<html lang="ko">
<head>

<%@ include file ="../header.jsp" %>
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
<app:layout mode="stylescript" type="normal" />
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ========================= -->
<!-- ======================================================= -->

	<div class="contents-wrap">
		<div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
			<div class="container">
				<div class="evtdss-breadcrumb">
					<ul>
						<li>홈</li>
						<li>지역관광개발사업</li>
						<li>약관 및 방침</li>
						<li>개인정보처리방침</li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h3 class="page-title">개인정보처리방침</h3>
						<!-- Contents -->
						<ul class="page-tabs">
							<li class="page-tab w50"><a href="/info/viewAccessTerms.do" title="이용약관">이용약관</a></li>
							<li class="page-tab w50 active"><a href="/info/viewPrivacy.do" title="개인정보처리방침">개인정보처리방침</a></li>
							<!-- <li class="page-tab w33"><a href="/info/viewUnauthEmail.do" title="이메일무단수집거부">이메일무단수집거부</a></li> -->
						</ul>

						<p class="clearfix br"></p>

						<p class="section-title">개인정보처리방침<small class="silent">개인정보처리방침</small></p>
						<div class="doc-form-section">
							<div class="doc-form-wrap">

							</div>
						</div>
						<!-- /Contents -->
					</div>
				</div>
			</div>
		</div>

	</div> <!-- /contents-wrap -->


<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents end                                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>
