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
						<li>이메일무단수집거부</li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h3 class="page-title">이메일무단수집거부</h3>
						<!-- Contents -->
						<ul class="page-tabs">
							<li class="page-tab w33"><a href="/info/viewAccessTerms.do" title="이용약관">이용약관</a></li>
							<li class="page-tab w33"><a href="/info/viewPrivacy.do" title="개인정보처리방침">개인정보처리방침</a></li>
							<li class="page-tab w33 active"><a href="/info/viewUnauthEmail.do" title="이메일무단수집거부">이메일무단수집거부</a></li>
						</ul>

						<p class="clearfix br"></p>

						<p class="section-title">개인정보처리방침<small class="silent">개인정보처리방침</small></p>
						<div class="doc-form-section">
							<div class="doc-form-wrap">

								<div class="bkst_s4 ti20">
									<p>본 웹사이트에 게시된 이메일 주소가 전자우편 수집 프로그램이나 그밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다.</p>

									<p class="clearfix br"></p>

									<h4>정보통신망이용척진 및 정보 보호등에 관한 법률</h4>
									<p class="doc-form-title">제 50조의 2 (전자우편주소의 무단 수집행위 등 금지)</p>
									<ul>
										<li>누구든지 인터넷 홈페이지 운영자 또는 관리자의 사전 동의 없이 인터넷 홈페이지에서 자동으로 전자우편주소를 수집하는 프로그램이나 그 밖의 기술적 장치를 이용하여 전자우편주소를 수집하여서는 아니 된다.</li>
										<li>누구든지 제1항을 위반하여 수집된 전자우편주소를 판매·유통하여서는 아니 된다.</li>
										<li>누구든지 제1항과 제2항에 따라 수집·판매 및 유통이 금지된 전자우편주소임을 알면서 이를 정보 전송에 이용하여서는 아니 된다.</li>
									</ul>
								</div>

							</div>
						</div>

						<!-- /Contents -->
					</div>
				</div>
			</div>
		</div>

	</div>


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
