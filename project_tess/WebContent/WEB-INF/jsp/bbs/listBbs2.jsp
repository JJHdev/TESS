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
		<!-- 게시판 타입 -->
		<form:hidden path="bbs_type" id="bbs_type"/>
		<!-- 게시물 No -->
		<input type="hidden" name="bbs_no" id="bbs_no"/>

	<div class="contents">
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
				<li><a href="javascript:void(0);">HOME</a></li>
				<li><a href="javascript:void(0);">알림방</a></li>
				<c:if test="${model.bbs_type eq 'B01'}">
					<li>공지사항</li>
				</c:if>
				<c:if test="${model.bbs_type eq 'B02'}">
					<li>Q&amp;A</li>
				</c:if>
				<c:if test="${model.bbs_type eq 'B03'}">
					<li>FAQ</li>
				</c:if>
			</ol>
		</div>
		
						
		<table class="table table1Way marginBottom30"><!-- 검색-->
		<!--관리자-->
		<!-- 공지사항, Q&A  -->
		<c:if test="${model.bbs_type ne 'B03' }">
			<colgroup>
				<col style="width: 95px">
				<col style="width: 100px;">
				<col style="width: 100px;">
				<col style="width: *;">
			</colgroup>
			<tbody>
				<tr>
					<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>검색조건</th>
					<td>
						<form:select path="search_name" title="검색범위" class="form-control input-sm" id="search_name" style="width:130px;">
							<form:option value="" label="">:::선택하세요.:::</form:option>
							<form:option value="title" label="title">제목</form:option>
							<form:option value="content" label="content">내용</form:option>
						</form:select>
					</td>
					<td>
							<form:select path="docu_kind" title="검색조건설정"  class="form-control input-sm" id="docu_kind" style="width:130px;">
			             		<c:forEach items="${docuKindCodeList }" var="item" varStatus="idx">
									<form:option value="${item.code }" label="${item.codeNm }">${item.codeNm }</form:option>
								</c:forEach>
							</form:select>
						
					</td>
					<td>
						<form:input id="search_word" title="검색어" path="search_word" class="form-control input-sm pull-left marginRright12"  style="width: 250px;" placeholder="검색어를 입력하세요." />
						<!-- <input type="text" class="form-control input-sm pull-left marginRright12" id="" style="width: 250px;" />-->
						<a class="btn btn-smSearch" href="javascript:void(0);" title="검색하기" id="srchBtn"><i class="icon-ic_search">&nbsp;</i>조회</a>
					</td>
				</tr>
			</tbody>
		</c:if>	
		<!--// 공지사항, Q&A  -->
		<!-- FAQ  -->
		<c:if test="${model.bbs_type eq 'B03' }">
			<colgroup>
				<col style="width: 100px">
				<col style="width: 164px;">
				<col style="width: *;">
			</colgroup>
			<tbody>
				<tr>
					<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>검색조건</th>
					<td>
						<form:select path="search_name" title="검색범위" class="form-control input-sm" id="search_name" style="width:130px;">
							<form:option value="" label="">:::선택하세요.:::</form:option>
							<form:option value="title" label="title">제목</form:option>
							<form:option value="content" label="content">내용</form:option>
						</form:select>
					</td>
					<td>
						<form:input id="search_word" path="search_word" title="검색어" class="form-control input-sm pull-left marginRright12"  style="width: 410px;" placeholder="검색어를 입력하세요." />
						<!-- <input type="text" class="form-control input-sm pull-left marginRright12" id="" style="width: 250px;" />-->
						<a class="btn btn-smSearch" href="javascript:void(0);" title="검색하기" id="srchBtn"><i class="icon-ic_search">&nbsp;</i>조회</a>
					</td>
				</tr>
			</tbody>
		</c:if>	
		</table>
		<!--//관리자-->
	
	
	<%--  
	<c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS' or ( model.bbs_type eq 'B02' and not empty modelMap.gsUserId)}">
	--%>	
		<!-- 
		<div style="height:20px;"></div>
		<div style="position:relative;">
			관리자
			<div style="position:absolute; top:-1px; right:0px;">
				<span class="small_btn_01 small_color_01" id="openRegiBtn"><a href="#link"><img src="../images/btns/b_icon_01.png" alt="신규등록"><strong>신규등록</strong></a></span>
			</div>
			관리자
		</div>
		-->
	<%--
	</c:if>
	--%>
	<c:if test="${model.bbs_type eq 'B01' or  model.bbs_type eq 'B02' }">
	<h6>ㆍ총 <strong style="color:#7ba920;">${totalSize }건</strong>이 검색 되었습니다.</h6>
	<!-- Table -->
		<table class="table tableDefault" summary="게시판 목록입니다. 제목을 클릭하여 상세내용을 확인할 수 있습니다.">
		<caption>게시판 목록</caption>
			<c:if test="${model.bbs_type eq 'B01' }">
			<colgroup>
				<col style="width: 70px;">
				<col style="width: *;">
				<col style="width: 170px;">
				<col style="width: 70px;">
				<col style="width: 100px;">
				<col style="width: 100px;">
				<col style="width: 100px;">
			</colgroup>	
			</c:if>
			<c:if test="${model.bbs_type eq 'B02' }">
			<colgroup>
				<col style="width: 70px;">
				<col style="width: *;">
				<col style="width: 170px;">
				<col style="width: 100px;">
				<col style="width: 100px;">
				<col style="width: 100px;">
			</colgroup>	
			</c:if>
			<c:if test="${model.bbs_type eq 'B03' }">
			<colgroup>
				<col style="width: 23%;">
				<col style="width: *;">
				<col style="width: 10%;">
				<col style="width: 7%;">
			</colgroup>
			</c:if>
			
			<thead>
				<tr>
				 <c:if test="${model.bbs_type eq 'B01'}">
					<th class="leftNoLine">순번</th>
		            <th scope="col">제목</th>
		            <th scope="col">구분</th>
		            <th scope="col">파일</th>
		            <th scope="col">작성자</th>
		            <th scope="col">등록일</th>
		            <th scope="col" class="rightNoLine">조회수</th>
		        </c:if>
		        <c:if test="${model.bbs_type eq 'B02' }">
		            <th class="leftNoLine">순번</th>
		            <th>제목</th>
		            <th>구분</th>
		            <th>작성자</th>
		            <th>등록일</th>
		            <th class="rightNoLine">조회수</th>
		        </c:if>
		        <c:if test="${model.bbs_type eq 'B03' }">
		            <th class="leftNoLine">관련사례</th>
		            <th>제목</th>
		            <th>등록일</th>
		            <th class="rightNoLine">조회수</th>
		        </c:if>
				</tr>
			</thead>
			<tbody>
			  <c:if test="${empty pageList}">
		        <tr onMouseOver="this.style.background='#fafafa';" onMouseOut="this.style.background='#ffffff'" bgcolor="#ffffff">
		        	<td colspan="7" class="leftNoLine rightNoLine">데이터가 없습니다.</td>
		        </tr>
		      </c:if>
		      <c:if test="${model.bbs_type eq 'B01' }">
		      <c:forEach items="${pageList }" varStatus="idx" var="item">
		      	<tr onMouseOver="this.style.background='#fafafa';" onMouseOut="this.style.background='#ffffff'" bgcolor="#ffffff">
		      		<td class="leftNoLine"><c:out value="${item.rNum }"/></td>
		      		<td style="text-align:center; padding-left:5px;"><a href="javascript:void(0);" onclick="javascript:doView('${item.bbsNo}')"><c:out value="${item.bbsSubject }"/></a></td>
		      		<td><c:out value="${item.bbsKindNm }"/></td>
		      		<td>
			      		<c:if test="${item.flChk eq 'Y'}">
			      			<span class="notice_icon disk_icon"><img src="../img/btns/down_icon.gif" alt="파일" ></span>
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
		      </c:if>
		      <c:if test="${model.bbs_type eq 'B02' }">
		      <c:forEach items="${pageList }" varStatus="idx" var="item">
		      	<tr>
		      		<td class="leftNoLine"><c:out value="${item.rNum }"/></td>
		      		<td style="text-align:left; padding-left:5px;">
		      			<a href="javascript:void(0);" onclick="javascript:doView('${item.bbsNo}')"><c:out value="${item.bbsSubject }"/></a>
		      		<c:if test="${not empty item.replyNo }">
		      			<span class="reply_ok"> [답변완료] </span><br>
		      			<div id="idx${idx.count }" style="display: none;"></div>
		      		</c:if>
		      		</td>
		      		<td><c:out value="${item.bbsKindNm }"/></td>
		      		<td><c:out value="${item.userNm }"/></td>
		      		<td><c:out value="${item.regiDate }"/></td>
		      		<td class="rightNoLine"><c:out value="${item.viewCnt }"/></td>
		      	</tr>
		      </c:forEach>
		      </c:if>
			</tbody>
	</table>
	</c:if>
	
	<div class="panel-group" id="faqAccordion">
	<c:if test="${model.bbs_type eq 'B03' }">
		<div style="height:20px;"></div>
			<c:if test="${empty pageList }">
				<div class="expand_title">
					<h4>검색된 내용이 없습니다.</h4>
				</div>
			</c:if>
			<c:if test="${not empty pageList }">
				<c:forEach items="${pageList }" varStatus="idx" var="item">
				<div class="panel top">
					<div class="expand_title panel-heading">
						<a href="javascript:void(0);" >${item.bbsSubject}</a>
					</div>
					<div class="panel-collapse collapse">
						<div class="expand_contents panel-body">
							<c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS'}">
							<ul class="text">
								<li><a href="javascript:void(0);" onclick="javascript:doView('${item.bbsNo}')">${fn:replace(item.bbsDesc, newLine, "<br/>")}</a></li>
							</ul>
							</c:if>
							<c:if test="${modelMap.gsRoleId ne 'ROLE_AUTH_SYS'}">
							<ul class="text">
								<li>${fn:replace(item.bbsDesc, newLine, "<br/>")}</li>
							</ul>
							</c:if>
						</div>
					</div>
					<span class="sentence_gab"></span>
				</div>
				<div style="height:5px;"></div>
				</c:forEach>
			</c:if>
		</c:if>
	</div>
	
	<%--  
	<c:if test="${modelMap.gsRoleId eq 'ROLE_AUTH_SYS' or ( model.bbs_type eq 'B02' and not empty modelMap.gsUserId)}">
	--%>	
		<!-- 
		<div style="height:20px;"></div>
		<div style="position:relative;">
			관리자
			<div style="position:absolute; top:-1px; right:0px;">
				<span class="small_btn_01 small_color_01" id="openRegiBtn"><a href="#link"><img src="../images/btns/b_icon_01.png" alt="신규등록"><strong>신규등록</strong></a></span>
			</div>
			관리자
		</div>
		-->
	<%--
	</c:if>
	--%>
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
