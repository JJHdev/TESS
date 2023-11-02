<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)openRegiBbs.jsp 1.0  2014.11.17                               												      --%>
<%--                                                                        														  --%>
<%-- COPYRIGHT (C) 2014 SUNDOSOFT CO., INC.                                     											  --%>
<%-- ALL RIGHTS RESERVED.                                                                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>

<style>
	.progress { position:relative; width:400px; border: 1px solid #ddd; padding: 1px; border-radius: 3px;  float: left; ; }
	.bar { background-color: #B4F5B4; width:0%; height:20px; border-radius: 3px; }
	.percent { position:absolute; display:inline-block; top:3px; left:48%; }
</style>

<%@ include file ="../header.jsp" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공통 게시판 등록하는 화면이다.                              															  --%>
<%--                                                                        													      --%>
<%-- @author 신영민                                                        									    			  --%>
<%-- @version 1.0  2014.11.17                                               												  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<title><spring:message code="title.sysname"/></title>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- style & javascript layout                                              													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="stylescript" type="normal" />
<script type="text/javascript" src="/js/memb/commonBaseUscm.js"></script>
</head>
<body>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- top header layout
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="header" />

<script type="text/javascript">

_ALLOWED_FILE_EXTS = '<c:out value="${modelMap.allowedFileExts}"/>';

</script>
<!-- 네이버 에디터 -->
<script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- 네이버 에디터 -->
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/common-dyUtil.js" charset="utf-8"></script>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents begin                                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<form:form commandName="model" id="model" method="post" enctype="multipart/form-data">

	<!-- 검색 조건 -->
	<form:hidden path="page" id="page"/>
	<form:hidden path="search_name" id="search_name" />
	<form:hidden path="search_word" id="search_word" />
	<form:hidden path="docu_kind" id="docu_kind" />
	<!-- 게시판 타입 -->
	<form:hidden path="bbs_type" id="bbs_type" />
	<!-- 등록, 수정, 삭제 구분값 -->
	<input type="hidden" name="mode" id="mode" value="regi"/>

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
				<th class="leftNoLine" scope="row">제목</th>
				<td colspan="3" class="rightNoLine">
					<form:input path="bbsSubject" type="text" class="form-control input-sm" id="bbsSubject" _required="true"  placeholder=""  title="제목" />
				</td>
			</tr>
			<tr class="bottom">
				<th class="leftNoLine" scope="row">구분</th>
				<td class="rightNoLine">
					<form:select class="form-control input-sm" path="docuKind" title="분류" id="docuKind">
	               		<c:forEach items="${docuKindCodeList }" var="item" varStatus="idx">
						<form:option value="${item.code }" label="${item.codeNm }">${item.codeNm }</form:option>
						</c:forEach>
	               	</form:select>
				</td>
				<th scope="row">등록자</th>
				<td class="rightNoLine"><input type="text" id="userNm" title="작성자명" class="form-control input-sm" value="${modelMap.gsUserNm}"  disabled /></td>
			</tr>
		<%-- 	//자기 내용만 검색가능하도록 변경
		<c:if test="${model.bbs_type eq 'B02' }">
			<tr>
				<th class="right_line">비밀글 설정</th>
				<td colspan="3">
					<input type="radio" name="openYn" id="openYn" value="N" class="mgr_5" title="공개"/>공개
					<input type="radio" name="openYn" id="openYn" value="Y" class="mgl_10 mgr_5" title="비공개"/>비공개
					<span style="padding-left: 20px;">(입력하신 내용을 다른사용자가 확인하지 못하게 하시려면 체크를 표시해 주세요)</span>
				</td>
			</tr>
		</c:if>
		--%>
			<tr class="bottom">
				<td colspan="4" class="leftNoLine rightNoLine" style="padding:20px 0;">
					<textarea id="bbsDesc" name="bbsDesc" style="width:96%; height:150px;" title="내용"></textarea>
				</td>
			</tr>
			<tr>
				<th scope="row" rowspan="2" class="leftNoLine">첨부파일</th>
				<td colspan="3" align="right" class="rightNoLine">
						<span class="btn btn-smBlue _dyFileBtnAddCls"><i class="icon-ic_note_add">&nbsp;</i>파일추가</span>
						<span class="btn btn-smRed _dyFileBtnRemvCls"><i class="fa fa-trash">&nbsp;</i>파일삭제</span>
				</td>
			</tr>
			<tr class="bottom">	
				<td class="rightNoLine" colspan="3">
				<div style="display: inline;" class="_dyFileAreaCls">
					<div style="display: inline;" class="_dynamicGroup">
						<ul class="file_input" style="position:relative; float:left; cursor:pointer;">
							<li><input type="checkbox" name="delChk" title="파일삭제"></li>
							<li class="fileName" style="padding: 1px;">
								<input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" disabled="disabled" readonly="readonly">
								<div class="file_input_div">
									<input type="button" title="파일첨부" value="&#xe91b;&nbsp;파일첨부" class="file_input_button btn btn-smOrange" />
									<input type="file"  name="upfile0"class="file_input_hidden" onchange="fn_checkFileObjValid(this)"  title="파일첨부"/> 
								</div>
							</li>
						</ul>
					</div>
				</div>	
				</td>
			</tr>
			</tbody>	
		</table>
		<!--관리자-->
		<div class="text-center" style="margin:50px 0 30px;">
			<a class="btn btn-green marginRright12" id="cnfmBtn" title="등록" href="javascript:void(0);" ><i class="icon-ic_create">&nbsp;</i>등록</a>
			<a class="btn btn-red" title="취소" id="cncleBtn"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
		</div>
		<!--//관리자-->
	</div>
</form:form>

<!--  네이버 에디터 스크립트 -->
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
<%-- center contents end                                                    													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer" />
</body>
</html>
