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
						<li>평가소개</li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h3 class="page-title">평가소개</h3>
						<!-- Contents -->
						<div class="container">
							<div class="row">
								<div class="col-md-12">
									<p class="view-passage">
										한국문화관광연구원의 통계․평가센터는 지역관광개발사업의 추진 단계별 사업 진단 및 평가, 컨설팅을 통해 사업의 성공적 시행 지원 및 재정 건전성 강화에 이바지하고 있습니다.
									</p>
									<div class="view-image">
										<img src="../../../images/introduction_02.png" alt="시스템 설립배경 및 비전">
									</div>
									<p class="clearfix br"></p>
									<br>

									<%--TODO:: 추후 주석 해제--%>
									<%--<p class="section-title">평가 절차 및 방법<small class="silent">평가 절차 및 방법을 소개합니다.</small></p>--%>

									<div class="view-image">
										<!-- <img src="../../../images/introduction_02.png" alt="시스템 설립배경 및 비전"> -->
									</div>
									<p class="clearfix br"></p>
									<br>
									<%--TODO:: 추후 주석 해제--%>
									<%--<p class="section-title">평가현황<small class="silent">평가현황을 소개합니다.</small></p>--%>

									<div class="view-image">
										<!-- <img src="../../../images/introduction_02.png" alt="시스템 설립배경 및 비전"> -->
									</div>
									<p class="clearfix br"></p>
									<div class="view-image">
										<!-- <img src="../../../images/introduction_02.png" alt="시스템 설립배경 및 비전"> -->
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


<%--<div class="contents">--%>
	<%--<div class="contentsTilte">--%>
		<%--<strong>지역관광기획평가센터 소개</strong>--%>
		<%----%>
		<%--<ol class="breadcrumb pull-right">--%>
        	<%--<strong>현재 페이지 :&nbsp;</strong>--%>
			<%--<li><a href="javascript:void(0);">HOME</a></li>--%>
			<%--<li><a href="javascript:void(0);">평가시스템소개</a></li>--%>
			<%--<li><a href="javascript:void(0);">시스템 소개</a></li>--%>
			<%--<li>지역관광기획평가센터 소개</li>--%>
		<%--</ol>--%>
	<%--</div>--%>
	<%----%>
	<%--<img src="/img/tdssSystem/infoImage01.png" class="img-responsive infoImage"/>--%>
						<%----%>
	<%--<ul class="infoUl">--%>
		<%--<li>지역관광기획평가센터는 지역관광개발사업에 대한 평가 및 컨설팅 업무를 담당하는 한국문화관광연구원 내 설치된 관광개발 부문 전문평가기관입니다.</li>--%>
		<%--<li>지역관광기획평가센터는 문화체육관광부로부터 지역관광개발사업에 대한 평가 및 컨설팅 전문기관으로 지정되어 운영되고 있습니다.</li>--%>
		<%--<li>지역관광개발사업에 대한 정부의 예산 증가 및 정책적 중요성이 더욱 확대되어 예산의 효율적 활용 및 지자체 사업의 원활한 추진을 위해 ‘관광, 경제, 경영, 환경, 건축, 도시계획, 제도’ 등 각 분야의 전문가와 함께 평가 및 컨설팅을 추진합니다.</li>--%>
	<%--</ul>--%>
	<%----%>
	<%--<hr class="infoLine"/>--%>
	<%----%>
	<%--<h5>연구진</h5>--%>

	<%--<ul class="infoUl">--%>
		<%--<li><div>연구책임<span>김영준 연구위원, 오훈성 부연구위원</span></div></li>--%>
		<%--<li><div>연<em style="letter-spacing: 0.22em">&nbsp;</em>구<em style="letter-spacing: 0.21em">&nbsp;</em>진<span>이정섭 책임연구원, 조현민 전문연구원, 홍인영 전문연구원, 이윤구 연구원</span></div></li>--%>
	<%--</ul>--%>
	<%----%>
<%--</div><!--//contents -->--%>
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
