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
 
<%@ include file ="../header.jsp" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공통 게시판 상세조회 화면이다.                             												  			  --%>
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

<form:form commandName="model" id="model" method="post"  >

	<!-- 검색 조건 -->
	<form:hidden path="page" id="page"/>
	<form:hidden path="search_busi" id="search_busi" />
	<!-- 게시판 No -->
	<input type="hidden" name="case_no" id="case_no" value="${resultView.caseNo }"/>
	
	<div class="contents" >
		<div class="contentsTilte">
			<strong>우수평가사례</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">부가서비스</a></li>
				<li>상세보기</li>
			</ol>
	
	<table class="table tableNormal">
		<colgroup>
			<col style="width: 160px;">
			<col style="width: *;">
			<col style="width: 160px;">
			<col style="width: 164px;">
		</colgroup>
		<tbody>
		<tr class="top2">
			<th class="leftNoLine">제목</th>
			<td colspan="3" class="rightNoLine"><c:out value="${resultView.caseSubject }"/> </td>
		</tr>
		<tr>
			<th class="leftNoLine">사업명</th>
			<td><c:out value="${resultView.busiNm }"/></td>
			<th>등록자</th>
			<td class="rightNoLine"><c:out value="${resultView.userNm }"/></td>
		</tr>
		<tr>
			<th class="leftNoLine">등록일</th>
			<td><c:out value="${resultView.regiDate }"/></td>
			<th>조회수</th>
			<td class="rightNoLine"><c:out value="${resultView.viewCnt }"/></td>
		</tr>
	
		<tr>
			<td class="rightNoLine" colspan="4" style="border-left:0; padding:20px;"><pre>${resultView.caseDesc }</pre></td>
		</tr>
		<tr>
			<th class="leftNoLine">첨부파일</th>
			<td class="rightNoLine" colspan="3">
				<c:forEach items="${resultView.fileList }" var="item" varStatus="idx">
					<a href="javascript:download('${item.fileNo}');"><img src="../img/btns/down_icon.gif" alt="첨부파일"> <c:out value="${item.fileOrgNm }"></c:out></a></br>
				</c:forEach>
			</td>
		</tr>
		</tbody>
	</table>

	<table class="table tableNormal">
		<colgroup>
			<col style="width: 160px;">
			<col style="width: *;">
			<col style="width: 160px;">
			<col style="width: 164px;">
		</colgroup>
		<tbody>
			<tr>
				<th class="leftNoLine">이전글 ▲</th>
				<td class="rightNoLine" colspan="3">
					<c:if test="${not empty resultView.preTitle }">
						<a href="#link" onclick="javascript:doView('${resultView.preSeq}')"><c:out value="${resultView.preTitle }"/></a>
					</c:if>
	   				<c:if test="${empty resultView.preTitle }">
	   					이전글이 없습니다.
	   				</c:if>
				</td>
			</tr>
			<tr class="bottom">
				<th class="leftNoLine">다음글 ▼</th>
				<td class="bottom rightNoLine" colspan="3">
					<c:if test="${not empty resultView.nextTitle }">
						<a href="#link" onclick="javascript:doView('${resultView.nextSeq}')"><c:out value="${resultView.nextTitle }"/></a>
					</c:if>
	   				<c:if test="${empty resultView.nextTitle }">
	   					다음글이 없습니다.
	   				</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	
	<c:if test="${resultView.userId eq modelMap.gsUserId or modelMap.gsRoleId eq 'ROLE_AUTH_SYS'  }">
		<div class="text-center" style="margin:50px 0 30px;">
			<a class="btn btn-green marginRright12" id="_openUpdtBtn" href="#" ><i class="icon-ic_sync">&nbsp;</i>수정</a>
			<a class="btn btn-red marginRright12"  id="_delBtn" href="#" ><i class="icon-ic_delete">&nbsp;</i>삭제</a>
			<a class="btn btn-red" id="cncleBtn" href="#link"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
		</div>
		<!--//관리자-->
	</c:if>
	</div>
</div>
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