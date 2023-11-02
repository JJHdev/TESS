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

<div class="contents login">
	<div class="contentsTilte">
		<strong>사이트맵</strong>
		
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#" title="HOME">HOME</a></li>
			<li>사이트맵</li>
		</ol>
	</div>
	
	<img src="/img/tdssSystem/infoImage01.png" class="img-responsive infoImage"/>
							
	<div class="row">
		<div class="col-sm-3">
	
			<div class="titleTable">평가시스템소개</div>
			<ul class="infoUl">
				<li><a href="#" title="시스템 소개">시스템 소개</a>
					<ul>
						<li><a href="#" title="지역관광기획평가센터 소개">지역관광기획평가센터 소개</a></li>
					</ul>
				</li>
				<li><a href="#" title="운영 및 담당자 소개">운영 및 담당자 소개</a></li>
				<li><a href="#" title="약관 및 방침">약관 및 방침</a></li>
			</ul>
	
		</div>
		<div class="col-sm-3">
			
			<div class="titleTable">관광개발사업</div>
			<ul class="infoUl">
				<li><a href="#" title="사업관리">사업관리</a></a>
					<ul>
						<li><a href="#" title="사업등록">사업등록</a></li>
						<li><a href="#" title="사업평가관리">사업평가관리</a></li>
					</ul>
				</li>
				<li><a href="#" title="평가대상">평가대상</a>
					<ul>
						<li><a href="#" title="예산요구사업">예산요구사업</a></li>
						<li><a href="#" title="신규사">신규사업</a></li>
						<li><a href="#" title="중간평가">중간평가</a></li>
						<li><a href="#" title="사후평가">사후평가</a></li>
						<li><a href="#" title="심층평가">심층평가</a></li>
					</ul>
				</li>
				<li><a href="#" title="평가지표관리">평가지표관리</a></li>
				<li><a href="#" title="평가위원관리">평가위원관리</a></li>
			</ul>
			
		</div>
		<div class="col-sm-3">
			
			<div class="titleTable">부가서비스</div>
			<ul class="infoUl">
				<li><a href="#" title="우수평가사례">우수평가사례</a></li>
			</ul>
			
		</div>
		<div class="col-sm-3">

			<div class="titleTable">알림방</div>
			<ul class="infoUl">
				<li><a href="#" title="공지사항">공지사항</a></li>
				<li><a href="#" title="Q&A">Q&amp;A</a></li>
				<li><a href="#" title="FAQ">FAQ</a></li>
			</ul>
			
		</div>
	</div>
	
	
</div><!--//contents -->
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
