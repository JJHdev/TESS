<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)listBbs.jsp.back 1.0  2014.11.17                               												      		  --%>
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

<form:form commandName="model" id="model" method="post" >

	<!-- 검색 조건 -->
	<form:hidden path="page" id="page"/>
	<form:hidden path="search_name" id="search_name" />
	<form:hidden path="search_word" id="search_word" />
	<form:hidden path="docu_kind" id="docu_kind" />
	<!-- 게시판 타입 -->
	<form:hidden path="bbs_type" id="bbs_type" />
	<!-- 게시판 No -->
	<input type="hidden" name="bbs_no" id="bbs_no" value="${resultView.bbsNo }"/>
	
	<div class="contents" >
		<div class="contentsTilte">
			<c:if test="${model.bbs_type eq 'B01'}">
				<strong>공지사항</strong>
			</c:if>
			<c:if test="${model.bbs_type eq 'B02'}">
				<strong>Q&amp;A</strong>
			</c:if>
			<c:if test="${model.bbs_type eq 'B03'}">
				<strong>FAQ</strong>
			</c:if>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">알림방</a></li>
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
			<td colspan="3" class="rightNoLine"><c:out value="${resultView.bbsSubject }"/> </td>
		</tr>
		<tr>
			<th class="leftNoLine">구분</th>
			<td><c:out value="${resultView.docuNm }"/></td>
			<th>등록자</th>
			<td class="rightNoLine"><c:out value="${resultView.userNm }"/></td>
		</tr>
		<tr>
			<th class="leftNoLine">등록일</th>
			<td><c:out value="${resultView.regiDate }"/></td>
			<th>조회수</th>
			<td class="rightNoLine"><c:out value="${resultView.viewCnt }"/></td>
		</tr>
	<%-- 	//자기 내용만 검색가능하도록 변경
	<c:if test="${model.bbs_type eq 'B02' }">
		<tr>
			<th>공개여부</th>
			<td colspan="3">
				<input type="radio" class="mgr_5" disabled="disabled" title="공개"<c:if test="${resultView.openYn eq 'N' }">checked="checked"</c:if>/>공개
				<input type="radio" class="mgl_10 mgr_5" disabled="disabled"   title="비공개"<c:if test="${resultView.openYn eq 'Y' }">checked="checked"</c:if>/>비공개
			</td>
		</tr>
	</c:if>
	--%>
		<tr>
			<td class="rightNoLine" colspan="4" style="border-left:0; padding:20px;"><pre>${resultView.bbsDesc }</pre></td>
		</tr>
		<tr>
			<th class="leftNoLine">첨부파일</th>
			<td class="rightNoLine" colspan="3">
				<c:forEach items="${resultView.fileList }" var="item" varStatus="idx">
					<a href="javascript:download('${item.fileNo}');"><img src="../img/btns/down_icon.gif" alt="첨부파일" ></span> <c:out value="${item.fileOrgNm }"></c:out></a></br>
				</c:forEach>
			</td>
		</tr>
		</tbody>
	</table>


<c:if test="${not empty replyView}">
<div style="height:70px;"></div>
	<h4>답글</h2>
</c:if>
	<table class="table tableNormal">
		<colgroup>
			<col style="width: 160px;">
			<col style="width: *;">
			<col style="width: 160px;">
			<col style="width: 164px;">
		</colgroup>
		<tbody>
		<c:if test="${not empty replyView}">
			<tr class="top2">
				<th class="leftNoLine">제목</th>
				<td colspan="3" class="rightNoLine"><c:out value="${replyView.bbsSubject }"/> </td>
			</tr>
			<tr>
				<th class="leftNoLine">등록일</th>
				<td><c:out value="${replyView.regiDate }"/></td>
				<th>작성자</th>
				<td class="rightNoLine"><c:out value="${replyView.userNm }"/></td>
			</tr>
			<tr>
				<td class="rightNoLine" colspan="4" style="border-left:0; padding:20px;"><pre>${replyView.bbsDesc }</pre></td>
			</tr>.
		</c:if>
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
		<c:if test="${model.bbs_type eq 'B02' }">
			<c:if test="${empty replyView}">
				<a class="btn btn-green marginRright12" id="_openRegiRepyBtn" href="#" ><i class="icon-ic_sync">&nbsp;</i>답글</a>
			</c:if>
			<c:if test="${not empty replyView}">
				<a class="btn btn-green marginRright12" id="_openUpdtRepyBtn" href="#" ><i class="icon-ic_sync">&nbsp;</i>답글수정</a>
			</c:if>
		</c:if>
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