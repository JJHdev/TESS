<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
		<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ========================= -->
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
        <input type="hidden" name="srchBusiArea"  id="srchBusiArea"  value='<c:out value="${paramMap.srchBusiArea}"/>'/>
        <input type="hidden" name="srchBusiExps"  id="srchBusiExps"  value='<c:out value="${paramMap.srchBusiExps}"/>'/>
    </div>
	
	<div class="contentsTilte">
		<strong>사업등록 리스트</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">사업관리</a></li>
			<li><a href="#">사업등록</a></li>
			<li>사업등록 리스트</li>
		</ol>
	</div>
						
	<table class="table table2Way marginBottom40"><!-- 검색-->
		<colgroup>
			<col style="width: 105px">
			<col style="width: 150px;">
			<col style="width: 150px">
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
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>시설면적</th>
				<td> 
					<input type="text" class="form-control input-sm" id="srchBusiAreaTemp" placeholder="2016" style="width: 275px;">
				</td>
			</tr>
			<tr>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>회계구분</th>
				<td>
					<select name="srchBusiTypeTemp" id="srchBusiTypeTemp" class="form-control input-sm" title="회계구분 조건">
 						<option value="">::전체::</option>
                        <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
                                <c:out value="${type.codeNm }"/>
                            </option>
                        </c:forEach> 						
					</select>	
				</td>
				<td>
					<select name="srchBusiCateTemp" id="srchBusiCateTemp" class="form-control input-sm" title="사업유형 조건">
 						<option value="">::전체::</option>
                        <c:forEach items="${busiCateComboList }" varStatus="idx" var="type">
                            <c:if test="${paramMap.srchBusiType == cate.parentCode }">
                                <option value='<c:out value="${cate.code }"/>' ${(paramMap.srchBusiCate == cate.code)? "selected":"" }>
                                    <c:out value="${cate.codeNm }"/>
                                </option>
                            </c:if>
                        </c:forEach> 						
					</select>	
				</td>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업금액</th>
				<td> 
					<input type="text" class="form-control input-sm" id="srchBusiExpsTemp" style="width: 275px;">
				</td> 
			</tr>
			<tr class="bottomPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업명</th>
				<td colspan="4"  class="rightPadding"><input type="text" class="form-control input-sm" id="srchEvaluBusiNmTemp" name="srchEvaluBusiNmTemp" value='<c:out value="${paramMap.srchEvaluBusiNm }"/>' ></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5">
					<a class="btn btn-search marginRright12" href="#"  id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a><!-- 20160203 : 전체변경1 -->
					<a class="btn btn-search marginRright12" href="#"  id="prcBtnRegi"><i class="icon-ic_search">&nbsp;</i>등록</a><!-- 20160203 : 전체변경1 -->
				</td>
			</tr>
		</tfoot>
	</table><!-- //검색-->

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