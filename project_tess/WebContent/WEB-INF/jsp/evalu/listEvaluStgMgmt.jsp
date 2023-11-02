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
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
        <input type="hidden" name="srchBusiStage"  id="srchBusiStage"  value='<c:out value="${paramMap.srchBusiStage}"/>'/>
        <input type="hidden" name="srchBusiSttDate"  id="srchBusiSttDate"  value='<c:out value="${paramMap.srchBusiSttDate}"/>'/>
    </div>

	<div class="contentsTilte">
		<strong>사업평가관리 리스트</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">사업관리</a></li>
			<li><a href="#">사업평가관리</a></li>
			<li>사업평가관리 리스트</li>
		</ol>
	</div>
						
	<table class="table table2Way marginBottom40"><!-- 검색-->
		<colgroup>
			<col style="width: 105px;">
			<col style="width: 150px;">
			<col style="width: 150px;">
			<col style="width: 105px;">
			<col style="width: 300px;">
		</colgroup>
		<tbody>
			<tr class="topPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>지역</th>
				<td>
				    <select name="srchBusiAddr1Temp" id="srchBusiAddr1Temp" class="form-control input-sm">
					  <option value="">::전체::</option>
					</select>
				</td>
				<td>
				    <select name="srchBusiAddr2Temp" id="srchBusiAddr2Temp" class="form-control input-sm">
					  <option value="">::전체::</option>
					</select>
				</td>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>시작연도</th>
				<td class="rightPadding">
					<input type="text" class="form-control input-sm" id="srchBusiSttDateTemp" placeholder="2016">
				</td>
			</tr>
			<tr>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>회계구분</th>
				<td>
				    <select name="srchBusiTypeTemp" id="srchBusiTypeTemp" class="form-control input-sm">
					  <option value="">::전체::</option>
		                       <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
		                          	 <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
		                       <c:out value="${type.codeNm }"/>
                          </option>
                  </c:forEach>
					</select>
				</td>
				<td>
				    <select name="srchBusiCateTemp" id="srchBusiCateTemp" class="form-control input-sm">
					<option value="">::전체::</option>
		                        <c:forEach items="${busiCateComboList }" varStatus="idx" var="cate">
			                            <c:if test="${paramMap.srchBusiType == cate.parentCode }">
				                                <option value='<c:out value="${cate.code }"/>' ${(paramMap.srchBusiCate == cate.code)? "selected":"" }>
				                                    <c:out value="${cate.codeNm }"/>
				                                </option>
			                            </c:if>
		                        </c:forEach>
					</select>
				</td>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>단계</th>
				<td class="rightPadding">
				    <select name="srchBusiStageTemp" id="srchBusiStageTemp" class="form-control input-sm">
					  <option value="">::전체::</option>
		                        <c:forEach items="${busiStageComboList }" varStatus="idx" var="busiStage">
				                        <option value='<c:out value="${busiStage.code }"/>' ${(paramMap.srchBusiCate == busiStage.code)? "selected":"" }>
				                            <c:out value="${busiStage.codeNm }"/>
				                        </option>
		                        </c:forEach>
					</select>
				</td>
			</tr>
			<tr class="bottomPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업명</th>
				<td colspan="4"  class="rightPadding"><input type="text" class="form-control input-sm" id="srchEvaluBusiNmTemp" name="srchEvaluBusiNmTemp" placeholder=""  value='<c:out value="${paramMap.srchEvaluBusiNm }"/>'></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5">
					<a class="btn btn-search marginRright12" id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a><!-- 20160203 : 전체변경1 -->
					<!--  
					<a class="btn btn-grassGreen" href="#" data-toggle="modal" data-target="#myModal"><i class="icon-ic_border_color">&nbsp;</i>평가대상 선정</a><!-- 20160203 : 전체변경2 
					-->
				</td>
			</tr>
		</tfoot>
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