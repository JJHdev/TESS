<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

	<!-- Evalu공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
<!-- ======================================================= -->

<div class="contents" >

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model">

    <%-- 공통 필수 --%>
    <input type="hidden" name="mode"       id="mode"      />
    <input type="hidden" name="page"       id="page"      value='<c:out value="${paramMap.page }"/>'/>
    
    <%-- pk --%>
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo"/>
    
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchFieldType"   id="srchFieldType"   value='<c:out value="${paramMap.srchFieldType}"/>'/>
        <input type="hidden" name="srchFieldDetail"   id="srchFieldDetail"   value='<c:out value="${paramMap.srchFieldDetail}"/>'/>
        <input type="hidden" name="srchFieldVal"   id="srchFieldVal"   value='<c:out value="${paramMap.srchFieldVal}"/>'/>
    </div>

	<div class="contentsTilte">
		<strong>사업평가위원관리</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가관리</a></li>
			<li><a href="#">사업평가위원관리</a></li>
			<li>평가위원 리스트</li>
		</ol>
	</div>
	<table class="table table2Way marginBottom40"><!-- 검색-->
		<colgroup>
			<col style="width: 140px;">
			<col style="width: *;">
			<col style="width: 120px;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr class="topPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>가입일자</th>
				<td>
					<table class="noLine">
						<tr>
							<td>
								<div class="input-group">
			                		<input id="date-picker-1" type="text" class="date-picker form-control input-sm" style="width: 92px;" />
			                		<label for="date-picker-1" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
			            		</div>
							</td>
							<td>&nbsp;~&nbsp;</td>
							<td>
								<div class="input-group">
			                		<input id="date-picker-2" type="text" class="date-picker form-control input-sm" style="width: 92px;" />
			                		<label for="date-picker-2" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
			            		</div>
							</td>
						</tr>
					</table>
				</td>
				
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>직업종류</th>
				<td class="rightPadding">
					<table class="noLine">
						<tr>
							<td>
								<select class="form-control input-sm marginRright12" id="srchOccupation" style="width: 250px;">
									<option value="">::전체::</option>
								<c:forEach items="${occupaList}" var="item" varStatus="idx">
									<option value="${item.code}" label="${item.codeNm}">${item.code}</option>
								</c:forEach>
								</select>
							</td>
						
						</tr>
					</table>
				</td>
			</tr>
			<tr class="rightPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>소&nbsp;속</th>
					<td>
						<input type="text" class="form-control input-sm" id="srchAttach" style="width: 260px;"/>
					</td>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>전문분야</th>
				<td class="rightPadding">
					<table class="noLine">
						<tr>
							<td>
								<select class="form-control input-sm marginRright12" name="srchFieldTypeTemp" id="srchFieldTypeTemp" style="width: 90px;">
									 <option value="">::전체::</option>
									 <c:forEach items="${fieldTypeList}" var="item" varStatus="idx">
										<option value="${item.code }" label="${item.codeNm }">${item.code }</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select class="form-control input-sm marginRright12" name="srchFieldDetailTemp" id="srchFieldDetailTemp" style="width: 150px;">
									<option value="">::전체::</option>
								</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="rightPadding" >
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>아이디/성명</th>
					<td class = "rightPadding" colspan = "4">
						<input type="text" class="form-control input-sm" id="srchCommit" style="width: 260px;"/>
					</td>
			</tr>
		</tbody>
	</table><!-- //검색-->

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
   <div class="text-center" style="margin:50px 0;">
		<a class="btn btn-red marginRright12" href="#"  id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a>
		<a class="btn btn-green" href="/committee/regiEvaluMbrCommit.do"><i class="icon-ic_note_add">&nbsp;</i>신규등록</a>
	</div>
	
	
</form:form>
</div><!-- /contents -->
 

<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->		

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>