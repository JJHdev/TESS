<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)openRegiReplycustBbs.jsp 1.0 2013.10.15                            --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2014 SUNDOSOFT CO., INC.                                     --%>
<%-- ALL RIGHTS RESERVED.                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>

<%@ include file ="../header.jsp" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 답글을 등록하는 화면이다.                             					--%>
<%--                                                                        --%>
<%-- @author 신영민                                                         									--%>
<%-- @version 1.0 2013.10.15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<title><c:out value="${pageTitle}"/></title>
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

<script type="text/javascript">

_ALLOWED_FILE_EXTS = '<c:out value="${modelMap.allowedFileExts}"/>';

</script>
<!-- 	//네이버 에디터 -->
<script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/common-dyUtil.js" charset="utf-8"></script>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents begin                                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<form:form commandName="model" id="model" method="post" >

	<form:hidden path="page" id="page"/>
	<form:hidden path="bbs_type" id="bbs_type" />
	<input type="hidden" name="mode" id="mode" value="regi"/>
	<form:hidden path="search_name" id="search_name" />
	<form:hidden path="search_word" id="search_word" />
	<form:hidden path="docu_kind" id="docu_kind" />
	<input type="hidden" name="bbs_no" id="bbs_no" value="${modelMap.bbs_no }"/>
	<input type="hidden" name="parent_bbs_no" id="parent_bbs_no" value="${modelMap.bbs_no }"/>
	
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
		<table class="table tableNormal"  summary="글작성 양식입니다. 양식에 맞춰 내용을 작성하세요.">
		<caption>글작성 양식</caption>
			<colgroup>
				<col style="width: 15%;">
				<col style="width: 35%;">
				<col style="width: 15%;">
				<col style="width: *;">
			</colgroup>
			<tbody>
				<tr class="top2">
					<th class="leftNoLine">제목</th>
					<td colspan="3" class="rightNoLine"><c:out value="${resultView.bbsSubject }"/> </td>
				</tr>
				<tr>
					<th class="leftNoLine">구분</th>
					<td class="rightNoLine"><c:out value="${resultView.docuNm }"/></td>
					<th>등록자</th>
					<td class="rightNoLine"><c:out value="${resultView.userNm }"/></td>
				</tr>
				<tr>
					<th class="leftNoLine">등록일</th>
					<td><c:out value="${resultView.regiDate }"/></td>
					<th>조회수</th>
					<td class="rightNoLine"><c:out value="${resultView.viewCnt }"/></td>
				</tr>
			<c:if test="${model.bbs_type eq 'B02' }">
				<tr>
					<th class="leftNoLine">공개여부</th>
					<td class="rightNoLine" colspan="3">
						<input type="radio" class="mgr_5" disabled="disabled" title="공개" <c:if test="${resultView.openYn eq 'N' }">checked="checked"</c:if>/>&nbsp;공개
						<input type="radio" class="mgl_10 mgr_5" disabled="disabled"  title="비공개"<c:if test="${resultView.openYn eq 'Y' }">checked="checked"</c:if>/>&nbsp;비공개
					</td>
				</tr>
			</c:if>
				<tr>
					<td class="rightNoLine" colspan="4" style="border-left:0; padding:20px;"><pre>${resultView.bbsDesc }</pre></td>
				</tr>
				<tr>
					<th class="leftNoLine bottom">첨부파일</th>
					<td class="rightNoLine" colspan="3">
						<c:forEach items="${resultView.fileList }" var="item" varStatus="idx">
							<a href="javascript:download('${item.fileNo}');"><img src="../images/contents/list_file.gif" alt="첨부파일"> <c:out value="${item.fileOrgNm }"></c:out></a></br>
						</c:forEach>
					</td>
				</tr>
		</table>

	<div style="height:70px;"></div>

	<h4>답글</h4>

	<table class="table tableNormal" summary="글작성 양식입니다. 양식에 맞춰 내용을 작성하세요.">
	<caption>글작성 양식</caption>
		<colgroup>
			<col style="width: 15%;">
			<col style="width: 35%;">
			<col style="width: 15%;">
			<col style="width: *;">
		</colgroup>
		<tbody>
		<tr class="top2">
			<th scope="row" class="leftNoLine">제목</th>
			<td colspan="3" class="rightNoLine"><input type="text" title="제목" id="bbsSubject" name="bbsSubject" style="width:95%;"/></td>
		</tr>
		<tr class="bottom">
			<th scope="row" class="leftNoLine"></th>
			<td class="rightNoLine">
				<form:select class="form-control input-sm" title="분류" path="docuKind" id="docuKind">
               		<c:forEach items="${docuKindCodeList }" var="item" varStatus="idx">
					<form:option value="${item.code }" label="${item.codeNm }">${item.codeNm }</form:option>
					</c:forEach>
               	</form:select>
			</td>
			<th>등록자</th>
			<td class="rightNoLine"><input type="text" id="userNm" title="작성자" class="form-control input-sm" value="${modelMap.gsUserNm}" disabled /></td>
		</tr>
		<tr class="bottom">
			<td colspan="4" class="leftNoLine rightNoLine" style="padding:20px 0;">
				<textarea id="bbsDesc" title="내용" name="bbsDesc" style="width:96%; height:150px;" title="내용"></textarea>
			</td>
		</tr>
		</tbody>	
	</table>

	<div style="height:15px;"></div>

	<!--관리자-->
	<div class="text-center" style="margin:50px 0 30px;">
		<a class="btn btn-green marginRright12" title="등록" id="cnfmBtn" href="javascript:void(0);" ><i class="icon-ic_create">&nbsp;</i>등록</a>
		<a class="btn btn-red" title="취소" id="cncleBtn"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
	</div>
</div>
</form:form>

<!--  네이버 에에디터 스크립트 -->
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "bbsDesc",
	    sSkinURI: "../se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2",
           htParams :
           {
                     fOnBeforeUnload : function()
                     {
                     }
           }
	});
</script>


<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents end                                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer" />
</body>
</html>