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
	<form:hidden path="search_busi" id="search_busi" />
	<form:hidden path="docu_kind" id="docu_kind" />
	<!-- 등록, 수정, 삭제 구분값 -->
	
	<!-- 사업명 타겟 -->
	<input type="hidden" name="targetId"     id="targetId"/>

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
		<table class="table tableNormal">
			<colgroup>
				<col style="width: 12%;">
				<col style="width: 45%;">
				<col style="width: 12%;">
				<col style="width: *;">
			</colgroup>
			<tbody>
			<tr class="top2">
				<th class="leftNoLine">제목</th>
				<td colspan="3" class="rightNoLine">
					<form:input path="caseSubject" type="text" class="form-control input-sm" id="caseSubject" _required="true"  placeholder=""  title="제목"/>
				</td>
			</tr>
			<tr class="bottom">
				<th class="leftNoLine">사업명</th>
				<td class="rightNoLine">
					<form:input path="evaluBusiNm" type="text" name="evaluBusiNm" id="evaluBusiNm" class="form-control input-sm pull-left marginRright12 _objBusiNm"  placeholder="" style="width: 250px;" readonly="true"/>
					<!--<form:input path="busiNm" type="text" class="form-control input-sm" id="busiNm" _required="true"  placeholder=""  title="사업명" />-->
					<!-- <a class="btn btn-smSearch" href="#" id="srchBtn"><i class="icon-ic_search">&nbsp;</i>조회</a>-->
					<span class="btn btn-smSearch" id=selBtnCommit ><a href="#link"  data-toggle="modal" data-target="#myModal">사업선택</a></span>
					<input type="hidden" name="evaluBusiId" id="evaluBusiId" class="_objBusiId"/>
				</td>
				<th>등록자</th>
				<td class="rightNoLine"><input type="text" id="userNm" class="form-control input-sm" value="${modelMap.gsUserNm}"  disabled /></td>
			</tr>
			<tr class="bottom">
				<td colspan="4" class="leftNoLine rightNoLine" style="padding:20px 0;">
					<textarea id="caseDesc" name="caseDesc" style="width:96%; height:150px;" title="내용"></textarea>
				</td>
			</tr>
			<tr>
			<th rowspan="2" class="leftNoLine">첨부파일</th>
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
									<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button btn btn-smOrange" />
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
			<a class="btn btn-green marginRright12" id="cnfmBtn" href="#" ><i class="icon-ic_create">&nbsp;</i>등록</a>
			<a class="btn btn-red" id="cncleBtn"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
		</div>
		<!--//관리자-->
	</div>
</form:form>

<!--  네이버 에디터 스크립트 -->
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "caseDesc",
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


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 650px;">
      <div class="modal-header">
      	<div class="pull-left"><i class="icon-ic_account_circle"></i></div>
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
        	<h4>평가사업 목록</h4>
      </div>
      <div class="modal-body">
      
      <form name="frm" id="frm" method="post" >
      
	          <%-- pk --%>
	    <input type="hidden" name="mode"     id="mode"     />
	    <input type="hidden" name="subMode"  id="subMode"  />
	     <input type="hidden" name="page"       id="page"      value='<c:out value="${paramMap.page }"/>'/>
	     
	     <%-- 검색조건 --%>
	    <div id="srchCondArea">
	        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
	        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
	        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
	    </div>
	    
	    <%-- 평가사업 타켓 --%>
	    <input type="hidden" name="targetId"  id="targetId"  value='<c:out value="${paramMap.targetId}"/>'/>

			<table class="table table2Way marginBottom40"><!-- 검색-->
				<colgroup>
					<col style="width: 105px">
					<col style="width: 150px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<!-- 
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>지역</th>
						<td>
						    <select class="form-control input-sm" name="srchBusiAddr1Temp" id="srchBusiAddr1Temp">
								<option value="">::전체::</option>
							</select>
						</td>
						<td>
						    <select class="form-control input-sm" style="width: 142px;" name="srchBusiAddr2Temp" id="srchBusiAddr2Temp">
								<option value="">::전체::</option>
							</select>
						</td>
					</tr>
					-->
					<tr class="topPadding">
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업단계</th>
						<td colspan="2">
						    <select class="form-control input-sm" style="width: 142px;"  name="busiStg" id="busiStg" >
		                        <option value="">::전체::</option>
		                        <c:forEach items="${evaluStgList }" varStatus="idx" var="stg">
		                        	<option value="${stg.code}" label="${stg.codeNm}">${stg.codeNm}</option>
		                        </c:forEach>
							</select>
						</td>
					</tr>
					<tr class="bottomPadding">
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업명</th>
						<td colspan="2">
						    <input type="text" class="form-control input-sm" name="srchBusiNm" id="srchBusiNm" style="width: 290px;" title="사업명" />
						</td>
					</tr>
				</tbody>
				<tfoot>	
					<tr>
						<td colspan="3">
							<a class="btn btn-search marginRright12" id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a><!-- 20160203 : 전체변경1 -->
							<!--  
							<a class="btn btn-grassGreen" href="#" data-toggle="modal" data-target="#myModal"><i class="icon-ic_border_color">&nbsp;</i>평가대상 선정</a><!-- 20160203 : 전체변경2 
							-->
						</td>
					</tr>	
				</tfoot>					
			</table><!-- //검색-->
			
		</form>	
			
		<%-- 그리드 표시 영역 --%>
		   <div class="round_top_01">
		        <div class="round_bottom_01" >
		            <div id="rsperror" title="Server Error Message...." style="color:red;"></div>
		    
		            <!-- Grid -->
		            <div id="jqgrid" style="margin:0 0 6px 0px;">
		                    <table style="vertical-align: top; width:100%;">
		                    <tr>
		                        <td style="vertical-align: top; ">
		                            <table id="grid" class="grid"></table>
		                            <div id="pager"></div>
		                        </td>
		                    </tr>
		                    </table>
		            </div>
		    
		            <div id="dialog" title="Feature not supported" style="display:none">
		            <p><spring:message code="title.grid.dialog"/></p>
		            </div>
		    
		            <div id="dialogSelectRow" title="Warning" style="display:none">
		            <p><spring:message code="title.grid.dialog.selectrow"/></p>
		            </div>
		    
		        </div>
		   </div>
			
			<div class="text-center" style="margin: 40px 0;">
				<button type="button" class="btn btn-green marginRright12" id="prcBtnSect"><i class="icon-ic_check"> </i>선택완료</button>
				<button type="button" class="btn btn-red" data-dismiss="modal" id="prcBtnCnle"><i class="icon-ic_refresh"> </i>취소</button>
        	</div>
        	
      </div><!-- //modal-body-->
    </div><!-- //modal-content -->
  </div><!-- //modal-dialog -->
</div><!-- //Modal -->
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- center contents end                                                    													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- bottom footer layout                                                   													  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<app:layout mode="footer" />
</body>
</html>
