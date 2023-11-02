<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
	<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
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
<form:form commandName="model" name="model" id="model">
	
	<%-- 공통 필수 --%>
    <input type="hidden" name="mode"       id="mode"      />
    <input type="hidden" name="page"       id="page"      value='<c:out value="${paramMap.page }"/>'/>
    
    <%-- pk --%>
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo"/>
    <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}" />
    
    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
        <input type="hidden" name="srchEvaluDate"  id="srchEvaluDate"  value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
        <input type="hidden" name="srchFinalEvaluFnd"  id="srchFinalEvaluFnd"  value='<c:out value="${paramMap.srchFinalEvaluFnd}"/>'/>
    </div>
					
	<div class="contentsTilte">
		<c:if test="${paramMap.evaluStage eq 'EVALU_BUDT'}">
			<strong>예산요구사업 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상</a></li>
				<li><a href="#">예산요구사업</a></li>
				<li>예산요구사업 리스트</li>
			</ol>
		</c:if>

		<c:if test="${paramMap.evaluStage eq 'EVALU_NEWS'}">
			<strong>신규사업 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상</a></li>
				<li><a href="#">신규사업</a></li>
				<li>신규사업 리스트</li>
			</ol>
		</c:if>

		<c:if test="${paramMap.evaluStage eq 'EVALU_INTR'}">
			<strong>중간평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상</a></li>
				<li><a href="#">중간평가</a></li>
				<li>중간평가 리스트</li>
			</ol>
		</c:if>

		<c:if test="${paramMap.evaluStage eq 'EVALU_AFTR'}">
			<strong>사후평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상</a></li>
				<li><a href="#">사후평가</a></li>
				<li>사후평가 리스트</li>
			</ol>
		</c:if>

		<c:if test="${paramMap.evaluStage eq 'EVALU_DPTH'}">
			<strong>심층평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상</a></li>
				<li><a href="#">심층평가</a></li>
				<li>심층평가 리스트</li>
			</ol>
		</c:if>

		<c:if test="${paramMap.evaluStage eq 'EVALU_NEWS2'}">
			<strong>사전평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2016년</a></li>
				<li><a href="#">사전평가</a></li>
				<li>사전평가 리스트</li>
			</ol>
		</c:if>
		
		<c:if test="${paramMap.evaluStage eq 'EVALU_PROG'}">
			<strong>집행평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2016년</a></li>
				<li><a href="#">집행평가</a></li>
				<li>집행평가 리스트</li>
			</ol>
		</c:if>
		
		<c:if test="${paramMap.evaluStage eq 'EVALU_CENT'}">
			<strong>중앙투자심사 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2016년</a></li>
				<li><a href="#">중앙투자심사</a></li>
				<li>중앙투자심사 리스트</li>
			</ol>
		</c:if>
		
		<c:if test="${paramMap.evaluStage eq 'CENT_2017'}">
			<strong>중앙투자심사 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">중앙투자심사</a></li>
				<li>중앙투자심사 리스트</li>
			</ol>
		</c:if>
		
		<c:if test="${paramMap.evaluStage eq 'PREV_2017'}">
			<strong>사전평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">사전평가</a></li>
				<li>사전평가 리스트</li>
			</ol>
		</c:if>
		
		<c:if test="${paramMap.evaluStage eq 'AFTR_2017'}">
			<strong>사후평가 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">사후평가</a></li>
				<li>사후평가 리스트</li>
			</ol>
		</c:if>
		
		<c:if test="${paramMap.evaluStage eq 'MNTR_2017'}">
			<strong>모니터링 리스트</strong>
			<ol class="breadcrumb pull-right">
	        	<strong>현재 페이지 :&nbsp;</strong>
				<li><a href="#">HOME</a></li>
				<li><a href="#">평가대상 2017년</a></li>
				<li><a href="#">모니터링</a></li>
				<li>모니터링 리스트</li>
			</ol>
		</c:if>
		
	</div>
												
	<table class="table table2Way marginBottom40"><!-- 검색-->
		<colgroup>
			<col style="width: 105px">
			<col style="width: 150px;">
			<col style="width: 150px;">
			<col style="width: 105px;">
			<col style="width: 300px;">
		</colgroup>
		<tbody>
			<tr class="topPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>지역</th>
				<td>
				    <select class="form-control input-sm" name="srchBusiAddr1Temp" id="srchBusiAddr1Temp">
						<option value="">::전체::</option>
					</select>
				</td>
				<td>
				    <select class="form-control input-sm" name="srchBusiAddr2Temp" id="srchBusiAddr2Temp">
						<option value="">::전체::</option>
					</select>
				</td>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>연도</th>
				<td class="rightPadding">
					<input type="text" class="form-control input-sm" id="" placeholder="">
				</td>
			</tr>
			<tr>
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>회계구분</th>
				<td>
				    <select class="form-control input-sm" name="srchBusiTypeTemp" id="srchBusiTypeTemp" title="회계구분 조건">
					  <option value="">::전체::</option>
                        <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
                                <c:out value="${type.codeNm }"/>
                            </option>
                        </c:forEach>
					</select>
				</td>
				<td>
				    <select class="form-control input-sm" name="srchBusiCateTemp" id="srchBusiCateTemp" title="사업유형 조건">
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
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가결과</th>
				<td class="rightPadding">
					<select class="form-control input-sm" name="srchFinalEvaluFndTemp" id="srchFinalEvaluFndTemp" title="평가결과">
                        <option value="">::전체::</option>
                        <c:forEach items="${finlRestlSelComboList }" varStatus="idx" var="finlRestlSel">
		                        <option value='<c:out value="${finlRestlSel.code }"/>' ${(paramMap.srchFinalEvaluFnd == finlRestlSel.code)? "selected":"" }>
		                            <c:out value="${finlRestlSel.codeNm }"/>
		                        </option>
                        </c:forEach>
					</select>
				</td>
			</tr>
			<tr class="bottomPadding">
				<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>사업명</th>
				<td colspan="4"  class="rightPadding">
					<input type="text" id="srchEvaluBusiNmTemp" name="srchEvaluBusiNmTemp"  class="form-control input-sm"  placeholder=""  value="${paramMap.srchEvaluBusiNm }"/>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5">
					<a class="btn btn-search marginRright12" href="#"  id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a>
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
</div>

<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->		

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>