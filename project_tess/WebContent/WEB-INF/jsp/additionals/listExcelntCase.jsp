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
<body>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- top header layout                                                      --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="header" />

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents begin                                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<form:form commandName="model" name="model" id="model" method="post" >
		<!-- 검색 조건 -->
		<form:hidden path="page" id="page"/>
		<!-- 게시물 No -->
		<input type="hidden" name="case_no" id="case_no"/>

	<div class="contents">
		<div class="contentsTilte">
			<strong>우수평가사례</strong>
			
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">부가서비스</a></li>
				<li>우수평가사례</li>
			</ol>
		</div>
		
						
		<table class="table table1Way marginBottom30"><!-- 검색-->
		<!--관리자-->
		<!-- 공지사항, Q&A  -->
		<colgroup>
			<col style="width: 95px">
			<col style="width: 100px;">
			<col style="width: 100px;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>등록일자</th>
				<td>
					<table class="noLine">
						<tr>
							<td>
								<div class="input-group">
			                		<form:input path="dateRegiSt" id="dateRegiSt" type="text" class="date-picker form-control input-sm" style="width: 90px;" />
			                		<label for="dateRegiSt" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
			            		</div>
							</td>
							<td>&nbsp;~&nbsp;</td>
							<td>
								<div class="input-group">
			                		<form:input path="dateRegiEnd" id="dateRegiEnd" type="text" class="date-picker form-control input-sm" style="width: 90px;" />
			                		<label for="dateRegiEnd" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
			            		</div>
							</td>
						</tr>
					</table>
				</td>
				
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업명</th>
				<td>
					<form:input id="search_busi" path="search_busi" class="form-control input-sm pull-left marginRright12"  style="width: 200px;" placeholder="검색어를 입력하세요." />
					<!-- <input type="text" class="form-control input-sm pull-left marginRright12" id="" style="width: 250px;" />-->
					<a class="btn btn-smSearch" href="#" id="srchBtn"><i class="icon-ic_search">&nbsp;</i>조회</a>
				</td>
			</tr>
		</tbody>
	</table>
		
	<h6>ㆍ총 <strong style="color:#7ba920;">${totalSize }건</strong>이 검색 되었습니다.</h6>
	<!-- Table -->
		<table class="table tableDefault">
		<colgroup>
			<col style="width: 70px;">
			<col style="width: *;">
			<col style="width: 170px;">
			<col style="width: 70px;">
			<col style="width: 100px;">
			<col style="width: 100px;">
			<col style="width: 100px;">
		</colgroup>	
			
		<thead>
			<tr>
				<th class="leftNoLine">순번</th>
	            <th>제목</th>
	            <th>사업명</th>
	            <th>파일</th>
	            <th>작성자</th>
	            <th>등록일</th>
	            <th class="rightNoLine">조회수</th>
			</tr>
		</thead>
		<tbody>
			  <c:if test="${empty pageList}">
		        <tr onMouseOver="this.style.background='#fafafa';" onMouseOut="this.style.background='#ffffff'" bgcolor="#ffffff">
		        	<td colspan="7" class="leftNoLine rightNoLine">데이터가 없습니다.</td>
		        </tr>
		      </c:if>
		      <c:forEach items="${pageList}" varStatus="idx" var="item">
		      	<tr onMouseOver="this.style.background='#fafafa';" onMouseOut="this.style.background='#ffffff'" bgcolor="#ffffff">
		      		<td class="leftNoLine"><c:out value="${item.rNum }"/></td>
		      		<td style="text-align:center; padding-left:5px;"><a href="#" onclick="javascript:doView('${item.caseNo}')"><c:out value="${item.caseSubject }"/></a></td>
		      		<td><c:out value="${item.busiNm }"/></td>
		      		<td>
			      		<c:if test="${item.flChk eq 'Y'}">
			      			<span class="notice_icon disk_icon"><img alt="파일" src="../img/btns/down_icon.gif" alt="파일"></span>
			      		</c:if>
			      		<c:if test="${item.flChk eq 'N'}">
			      			-
			      		</c:if>
		      		</td>
		      		<td><c:out value="${item.userNm }"/></td>
		      		<td><c:out value="${item.regiDate }"/></td>
		      		<td class="rightNoLine"><c:out value="${item.viewCnt }"/></td>
		      	</tr>
		      </c:forEach>
			</tbody>
	</table>
	
	
	<div id="nav" class="text-center" style="position: relative;">
	 	<!-- 페이징 -->
		<div class="pagenum_01">
	        <app:paging name="pageList" jsFunction="fn_search" />
		</div>
		<!--//페이징 -->
	  <a class="btn btn-green pull-right" id="openRegiBtn" style="position:absolute; top:18px; right:0;"><i class="icon-ic_create">&nbsp;</i>신규등록</a>
	</div>
	</div><!--//contents -->
</form:form>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents end                                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer" />
</body>
</html>
