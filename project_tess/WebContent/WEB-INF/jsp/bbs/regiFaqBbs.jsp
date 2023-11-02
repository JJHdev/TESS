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
		.progress {
			position: relative;
			width: 400px;
			border: 1px solid #ddd;
			padding: 1px;
			border-radius: 3px;
			float: left;;
		}

		.bar {
			background-color: #B4F5B4;
			width: 0%;
			height: 20px;
			border-radius: 3px;
		}

		.percent {
			position: absolute;
			display: inline-block;
			top: 3px;
			left: 48%;
		}
	</style>

	<%@ include file="../header.jsp" %>
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
	<app:layout mode="stylescript" type="normal"/>
	<script type="text/javascript" src="/js/memb/commonBaseUscm.js"></script>
</head>
<body>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- top header layout
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="header"/>

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
	<form:hidden path="search_name" id="search_name"/>
	<form:hidden path="search_word" id="search_word"/>
	<form:hidden path="docu_kind" id="docu_kind"/>
	<!-- 게시판 타입 -->
	<form:hidden path="bbs_type" id="bbs_type"/>
	<!-- 등록, 수정, 삭제 구분값 -->
	<input type="hidden" name="mode" id="mode" value="regi"/>

	<div class="contents-wrap">
		<div class="wrapper sub">
			<div class="container">

				<div class="evtdss-breadcrumb">
					<ul>
						<li>홈</li>
						<li>알림방</li>
						<li>자주묻는질문 등록</li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">

						<h3 class="page-title">자주묻는질문 등록</h3>

						<!-- Contents -->
						<table class="evtdss-form-table noMargin">
							<tr>
								<td class="labeler">제목</td>
								<td>
									<div class="incell-textinput w100">
										<form:input path="bbsSubject" type="text" class="" id="bbsSubject"
													_required="true" placeholder="" title="제목"/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="labeler">옵션</td>
								<td>
									<form:select class="form-control" path="docuKind" id="docuKind" cssStyle="width: 250px">
										<c:forEach items="${docuKindCodeList }" var="item" varStatus="idx">
											<form:option value="${item.code }"
														 label="${item.codeNm }">${item.codeNm }</form:option>
										</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea id="bbsDesc" name="bbsDesc" style="width:96%; height:240px;"></textarea>
								</td>

							</tr>
						</table>




						<div class="grid-head">
							<button type="button" class="grid-print" id="cncleBtn"><i class="glyphicon glyphicon-remove"></i> 취소</button>
							<button type="button" class="grid-print green" id="cnfmBtn"><i class="glyphicon glyphicon-pencil"></i> 등록</button>
						</div>

					</div>
				</div>
			</div>
		</div>

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
		htParams:
				{
					fOnBeforeUnload: function () {
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
<app:layout mode="footer"/>
</body>
</html>
