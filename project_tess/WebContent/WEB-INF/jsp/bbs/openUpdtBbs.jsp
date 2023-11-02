<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)openUpdtBbs.jsp 1.0  2014.11.17                               												      --%>
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
<%-- 공통 게시판 수정하는 화면이다.                              															  --%>
<%--                                                                        													      --%>
<%-- @author 신영민                                                        									    			  --%>
<%-- @version 1.0  2014.11.17                                               												  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<title><spring:message code="title.sysname"/></title>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- style & javascript layout                                              													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="stylescript" type="normal" />
</head>
<body>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- top header layout                                                      													  --%>
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
<%-- center contents begin                                                  													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<form:form commandName="model" id="model" method="post" enctype="multipart/form-data">

	<!-- 검색 조건 -->
	<form:hidden path="page" id="page"/>
	<form:hidden path="search_name" id="search_name" />
	<form:hidden path="search_word" id="search_word" />
	<form:hidden path="docu_kind" id="docu_kind" />
	<!-- 게시판 타입 -->
	<form:hidden path="bbs_type" id="bbs_type" />
	<!-- 게시판 No -->
	<input type="hidden" name="bbs_no" id="bbs_no" value="${resultView.bbsNo }"/>
	<!-- 등록, 수정, 삭제 구분값 -->
	<input type="hidden" name="mode" id="mode" value="updt"/>
	<!-- 삭제 파일 No-->
    <input type="hidden" name="ArrdelFileNo"  id="ArrdelFileNo"/>
	<input type="hidden" name="fileNo" id="fileNo" />

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
			<th scope="row" class="leftNoLine"><label for="bbsSubject">제목</label></th>
			<td colspan="3" class="rightNoLine">
				<form:input id="bbsSubject" path="bbsSubject" class="form-control input-sm" cssStyle="width: 95%" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="leftNoLine">구분</th>
			<td class="rightNoLine">
				<form:select path="docuKind" id="docuKind" class="form-control input-sm" cssStyle="width:50%">
               		<c:forEach items="${docuKindCodeList }" var="item" varStatus="idx">
					<form:option value="${item.code }" label="${item.codeNm }">${item.codeNm }</form:option>
					</c:forEach>
               	</form:select>
			</td>
			<th scope="row"><label for="userNm">등록자</label></th>
			<td class="rightNoLine">
				<form:input id="userNm" path="userNm" class="form-control input-sm" cssStyle="background:#f6f6f6; width:50%;"  disabled="disabled" />
			</td>
		</tr>
	<%-- //자기 내용만 검색가능하도록 변경
	<c:if test="${model.bbs_type eq 'B02' }">
		<tr>
			<th>공개여부</th>
			<td colspan="3">
				<form:radiobutton cssClass="mgr_5" path="openYn" id="openYn" value="N"/>공개
				<form:radiobutton cssClass="mgl_10 mgr_5" path="openYn" id="openYn" value="Y"/>비공개
				<span style="padding-left: 20px;">(입력하신 내용을 다른사용자가 확인하지 못하게 하시려면 체크를 표시해 주세요)</span>
			</td>
		</tr>
	</c:if>
	--%>
		<tr>
			<td colspan="4" class="leftNoLine rightNoLine" style="padding:20px 0;">
				<form:textarea id="bbsDesc" path="bbsDesc" cssStyle="width:96%; height:150px;"></form:textarea>
			</td>
		</tr>
		<tr class="top">
			<th scope="row" rowspan="3" class="leftNoLine">첨부파일</th>
			<td colspan="3" align="right" class="rightNoLine">
				<div class="progress" id="progress" align="left">
			        <div class="bar"></div >
			        <div class="percent">0%</div >
			    </div>
			    <div id="status"></div>
				<span class="btn btn-smBlue _dyFileBtnAddCls"><i class="icon-ic_note_add">&nbsp;</i>파일추가</span>
				<span class="btn btn-smRed _dyFileBtnRemvCls"><i class="fa fa-trash">&nbsp;</i>파일삭제</span>
			</td>
		</tr>
		<tr class="bottom">
			<td class="rightNoLine" colspan="3">
           <%-- 첨부된 파일 리스트 --%>
           <c:if test="${fn:length(resultView.fileList) > 0 }">
               <div  class="_attachedFileArea" style="margin-bottom: 5px;">
               <c:forEach items="${resultView.fileList }" varStatus="idx" var="pfcrF">
                   <div class="_dynamicFileGroup">
                       <input type="checkbox" name="delChk" value='<c:out value="${pfcrF.fileNo }"/>' title="파일삭제"/>
                       <a href="#down" title="이미지" class="_fileDownCls" _todeFileNo='<c:out value="${pfcrF.fileNo }"/>'>
                           <img src="../img/btns/down_icon.gif" alt='<c:out value="${pfcrF.fileNo }"/>'> <c:out value="${pfcrF.fileOrgNm }"/>
                       </a>
                   </div>
               </c:forEach>
               </div>
           </c:if>
				<div style="display: inline;" class="_dyFileAreaCls">
					<div style="display: inline;" class="_dynamicGroup">
						<ul class="file_input" style="position:relative; float:left; cursor:pointer;">
							<li><input type="checkbox" name="delChk" title="파일삭제"></li>
							<li class="fileName" style="padding: 1px;">
								<input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" disabled="disabled" readonly="readonly">
								<div class="file_input_div">
									<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button btn btn-smOrange" />
									<input type="file"  name="upfile0"class="file_input_hidden" onchange="fn_checkFileObjValid(this)"  title="파일첨부"/> 
								</div>
							</li>
						</ul>
					</div>
				</div>	
			</td>
		</tr>
	</table>
		<!--관리자-->
		<div class="text-center" style="margin:50px 0 30px;">
			<a class="btn btn-green marginRright12" title="수정" id="cnfmBtn" href="javascript:void(0);" ><i class="icon-ic_sync">&nbsp;</i>수정</a>
			<a class="btn btn-red marginRright12" title="삭제" id="_delBtn" href="javascript:void(0);" ><i class="icon-ic_delete">&nbsp;</i>삭제</a>
			<a class="btn btn-red" id="cncleBtn" title="취소" href="#link"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
		</div>
		<!--//관리자-->
	</div>
</form:form>

<!--   네이버 에디터 스크립트 -->

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
