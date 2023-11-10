<%--
*******************************************************************************
***    명칭: regiEvaluBusiMgmt.jsp
***    설명: [관리자] 평가사업관리 > 평가사업등록 화면
***
***    -----------------------------    Modified Log   ---------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0    2023.11.01        LHB       First Coding.
*******************************************************************************
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<html lang="ko">
<head>
    <%@ include file="../header.jsp" %>
    <title><spring:message code="title.sysname"/></title>
    <app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
    
    <!-- tode공통 추가 js -->
    <script language="javascript" type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
    <script language="javascript" type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
    
    <!-- jquery.serializeObject -->
    <script language="javascript" type="text/javascript" src='<c:url value="/jquery/jquery.serializeObject.js"/>'></script>

</head>

<style>
	input, textarea			{ border: 1px solid #333333 !important; }
	select					{ border: 1px solid #333333 !important; border-radius: 0 !important; }
    input[type=file]		{ background: none !important; }
	table					{ table-layout: fixed; }
	.submit-set > button	{ font-size: 13px; color: white; }
	.date-picker			{ background-image: url('/img/icons/icon-calendar.svg'); background-repeat: no-repeat; background-size: 22px; background-position: right 5px center; }
</style>

<body id="top">
	<div class="wrap">
	
	    <!-- header layout -->
	    <app:layout mode="header"/>

		<div class="contents">
			<form:form commandName="model" onsubmit="return validation();" action="/mng/saveEvaluBusiMgmt.do">
				<div class="contents-wrap">
					<div class="wrapper sub">
						<div class="container">
							<div class="evtdss-breadcrumb">
	                            <ul>
	                                <li>홈</li>
	                                <li>관리자</li>
	                                <li>평가사업관리</li>
	                            </ul>
	                        </div>
						
							<div class="container a-section">
								<div class="row">
									<div class="col-md-12">
										<h3 class="page-title">평가사업관리</h3>
										
										<p class="section-title">
				                            관광개발사업 개요
				                            <!--<button type="button" class="collapsable-btn" onClick="$.collapsable('.collapsable', 'hide')" title="접기">접기</button>-->
				                        </p>
				                        <!--<button class="collapsable-showMe silent" onClick="$.collapsable('.collapsable', 'show')" title="내용 펼쳐보기">내용 펼쳐보기</button>-->
				                        <div class="collapsable">
				                            <table class="evtdss-form-table">
				                            	<colgroup>
					                            	<col style="width: 180px;">
													<col style="width: *;">
													<col style="width: 180px;">
													<col style="width: *;">
				                            	</colgroup>
				                                <tr>
				                                    <td class="labeler">사업명<span class="special-dot">*</span></td>
				                                    <td>
				                                    	<form:input path="evaluBusiNm" class="g-search-input-txt" maxLength="200"/>
				                                    </td>
				                                    <td class="labeler">사업유형<span class="special-dot">*</span></td>
				                                	<td>
				                                		<form:select path="busiType" class="input-sm wd-40p">
				                                			<option value="">선택</option>
				                                			<c:forEach items="${busiTypeComboList}" varStatus="idx" var="item">
				                                				<option value="<c:out value='${item.code}'/>"><c:out value='${item.codeNm}'/></option>
				                                			</c:forEach>
				                                		</form:select>
				                                		<form:select path="busiCate" class="input-sm wd-40p">
				                                			<option value="">선택</option>
				                                		</form:select>
				                                	</td>
				                                </tr>
				                                <tr>
				                                    <td class="labeler">시행주체<span class="special-dot">*</span></td>
				                                    <td colspan="3">
				                                    	<form:select path="busiAddr1" class="input-sm wd-20p"><option value="">선택</option></form:select>
				                                    	<form:select path="busiAddr2" class="input-sm wd-20p"><option value="000">본청</option></form:select>
				                                    	<form:input path="busiAddr5" class="g-search-input-txt wd-80p" maxLength="80"/>
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <td class="labeler">총 사업기간</td>
				                                    <td colspan="3"><form:input path="busiSttDate" class="g-search-input-txt date-picker w-120px"/> ~ <form:input path="busiEndDate" class="g-search-input-txt date-picker w-120px"/></td>
				                                </tr>
				                                <!--  
				                                <tr>
				                                    <td class="labeler">사업개발주체</td>
				                                    <td colspan="3"><form:input path="busiDevEnty" class="g-search-input-txt" maxLength="100"/></td>
				                                </tr>
				                                
				                                <tr>
				                                    <td class="labeler">계획수립일자</td>
				                                    <td colspan="3"><form:input path="busiPlanDate" class="g-search-input-txt date-picker w-120px"/></td>
				                                </tr>
				                                -->
				                                <tr>
				                                    <td class="labeler">사업 목적</td>
				                                    <td colspan="3"><form:textarea path="busiNote" class="g-search-input-txt" style="height: 60px;" maxLength="4000"/></td>
				                                </tr>
				                                <tr>
				                                    <td class="labeler">주요 시설</td>
				                                    <td colspan="3"><form:textarea path="mainFclt" class="g-search-input-txt" style="height: 60px;" maxLength="1000"/></td>
				                                </tr>
				                                <tr>
				                                    <td class="labeler">사업비</td>
				                                    <td colspan="3">
				                                    	<form:input path="totBusiExps" type="number" class="g-search-input-txt w-120px"/><span>원</span>
				                                    </td>
				                                </tr>
				                            </table>
				                        </div>
									
										<div class="submit-set">
											<form:button type="submit" class="evtdss-submit" title="저장">저장</form:button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	
	    <!-- footer layout -->
	    <app:layout mode="footer" type="main"/>
	</div><!--/#wrap-->



</body>

</html>