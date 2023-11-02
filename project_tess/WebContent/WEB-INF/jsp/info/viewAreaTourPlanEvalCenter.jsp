<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<html lang="ko">
<head>

<%@ include file ="../header.jsp" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공통게시판 리스트를 검색하는 화면이다.                               					--%>
<%--                                                                        --%>
<%-- @author 신영민                                                        									    --%>
<%-- @version 1.0  2014.11.17                                               --%>
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
						<li>시스템 소개</li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h3 class="page-title">시스템 소개</h3>
						<!-- Contents -->
						<div class="container">
							<div class="row">
								<div class="col-md-12">

									<p class="view-passage">
										TDSS 평가지원시스템은 광역ㆍ기초 지자체의 국고보조금 지원 관광자원개발 사업의 메타정보를 기반으로 추진단계별 효과적 평가를 지원하기 위해
										문화체육관광부 산하 정책연구기관인 한국문화관광연구원 통계․평가센터가 구축한 DB시스템입니다.
									</p>

									<p class="section-title">시스템 설립배경 및 비전<small class="silent">설립배경 및 비전을 소개합니다.</small></p>

									<div class="view-image">
										<img src="../../../images/introduction_01.png" alt="시스템 설립배경 및 비전">
									</div>

								</div>
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
