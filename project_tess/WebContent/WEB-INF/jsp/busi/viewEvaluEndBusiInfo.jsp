<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
	<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
	
	<!-- jstree 추가 js -->
	<script type="text/javascript" src="/jquery/jstree/jquery.jstree.js"></script>
	<script type="text/javascript" src="/jquery/jstree/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="/jquery/jstree/jquery.cookie.js"></script>
	
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

    <%-- pk --%>
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>

    <%-- pk --%>
    <form:hidden path="evaluBusiNo" />
    <form:hidden path="evaluStage" />
    <form:hidden path="evaluGubun" />
    
    <input type="hidden" name="userId" id="userId" value="<c:out value="${paramMap.gsUserId}"/>">

    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
        <input type="hidden" name="srchBusiStage"  id="srchBusiStage"  value='<c:out value="${paramMap.srchBusiStage}"/>'/>
        <input type="hidden" name="srchEvaluDate"  id="srchEvaluDate"  value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
    </div>
    
    <input type="hidden" name="regiEvaluCommId"     id="regiEvaluCommId"/>

	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>평가사업조회</li>
	                    <li>평가완료사업</li>
	                    <li>${evaluInfo.PLANEVAL_BUSI_NAME}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가완료사업</h3>
	                </div>
	            </div>
	
	            <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	                <div class="shade"></div>
	                <div class="project-title">
	                    <h2>${evaluInfo.PLANEVAL_BUSI_NAME}</h2>
	                    <p>${evaluInfo.busiAddress1} / ${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</p>
	                </div>
	                <div class="local-menu">
	                    <ul>
	                        <li class="active"><a href="./evalProjectInfo.html" title="사업정보">사업정보</a></li>
	                        <li class=""><a onclick="fn_goEvaluInfo();" title="평가정보">평가정보</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/busi/listEvaluEndBusi.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">사업정보</h4>
								<a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	                        <!-- Contents -->
	
	                        <p class="section-title">첨부 파일<small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table" summary="지자체에서 추가등록한 첨부파일입니다. 최종 개정내역을 포함하므로 화면과 다를 수 있습니다.">
								<caption class="sr-only">첨부파일</caption>
								<colgroup><col /><col /><col /></colgroup>
								<thead>
	                        	<tr>
	                                <th scope="col">구분</th>
	                                <th scope="col">첨부파일</th>
	                                <th scope="col">등록일시</th>
	                            </tr>
								</thead>
								<tbody>
	                        	<c:forEach items="${fileList }" varStatus="status" var="flist">
	                        		<tr>
		                                <td><c:out value="${flist.CODE_NM}"/></td>
		                                <td class="fix-width file">
		                                    <a href="#" title="<c:out value="${flist.CODE_NM}"/>">
												<label class="sr-only"><c:out value="${flist.CODE_NM}"/></label>
		                                    	<!-- <img src="../../../images/icon_file_hwp.jpg"> -->
		                                    	<c:out value="${flist.FILE_ORG_NM}"/>
		                                    </a>
		                                </td>
		                                <td class="fix-width date"><c:out value="${flist.REGI_DATE}"/></td>
		                            </tr>
	                        	</c:forEach>
								</tbody>
	                            <!-- <tr>
	                                <th>구분</th>
	                                <th class="fix-width file">첨부파일</th>
	                                <th class="fix-width date">등록일시</th>
	                            </tr>
	                            <tr>
	                                <td>보조금 교부신청서</td>
	                                <td class="fix-width file">
	                                    <a href="#" class="보조금 교부신청서"><img src="../../../images/icon_file_hwp.jpg"></a>
	                                </td>
	                                <td class="fix-width date">2018-09-13 23:14:11</td>
	                            </tr>
	                            <tr>
	                                <td>사업설명서</td>
	                                <td class="fix-width file">
	                                    <a href="#" class="사업설명서"><img src="../../../images/icon_file_pdf.jpg"></a>
	                                </td>
	                                <td class="fix-width date">2018-09-13 23:14:11</td>
	                            </tr>
	                            <tr>
	                                <td>기본계획 수립용역 보고서</td>
	                                <td class="fix-width file">
	                                    <a href="#" class="기본계획 수립용역 보고서"><img src="../../../images/icon_file_hwp.jpg"></a>
	                                </td>
	                                <td class="fix-width date">2018-09-13 23:14:11</td>
	                            </tr>
	                            <tr>
	                                <td>추가 첨부파일</td>
	                                <td class="fix-width file">
	                                    <a href="#" class="기본계획 수립용역 보고서"><img src="../../../images/icon_file_zip.jpg"></a>
	                                </td>
	                                <td class="fix-width date">2018-09-13 23:14:11</td>
	                            </tr> -->
	                        </table>
	
	                        <p class="section-title">관광개발사업 개요<small>최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <td class="labeler">사업명</td>
	                                <td><c:out value="${mastMap.planEvalBusiName}"/></td>
	                                <%-- <td class="labeler">사업지유형</td>
	                                <td><c:out value="${mastMap.busiFigureType}"/></td> --%>
	                                <td class="labeler">사업유형</td>
	                                <td><c:out value="${mastMap.busiCateNm}"/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">위치</td>
	                                <td colspan="3"><c:out value="${mastMap.busiAddr12}"/> <c:out value="${mastMap.busiAddr5}"/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">총 사업기간</td>
	                                <td colspan="3"><c:out value="${mastMap.convBusiSttDate}"/> ~ <c:out value="${mastMap.convBusiEndDate}"/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업개발주체</td>
	                                <td><c:out value="${mastMap.busiDevEnty}"/></td>
                                    <td class="labeler">사업운영주체</td>
                                    <td><c:out value="${mastMap.busiMgtEnty}"/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">개발사업 법적근거</td>
                                    <td><c:out value="${mastMap.busiLeglBass}"/></td>
                                    <td class="labeler">계획수립일자</td>
                                    <td><c:out value="${mastMap.convBusiPlanDate}"/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업 내용</td>
	                                <td colspan="3"><c:out value="${mastMap.busiNote}"/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">부지면적</td>
	                                <td>
                                    	<c:if test="${not empty mastMap.totSiteArea }">
											<fmt:formatNumber value="${mastMap.totSiteArea}" type="number"/>㎡
										</c:if>
                                    </td>
                                    <td class="labeler">전체시설면적</td>
                                    <td>
                                    	<c:if test="${not empty mastMap.totSiteArea }">
											<fmt:formatNumber value="${mastMap.totFcltArea}" type="number"/>㎡
										</c:if>
                                    </td>
	                            </tr>
	                        </table>
	
	                        <%-- <p class="section-title">사업대상지 정보<small class="silent">최종본이 아닐 수 있으므로 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table noMargin">
	                            <c:forEach items="${areaFormList }" varStatus="status" var="areaForm">
									<tr>
										<td class="labeler"><c:out value="${areaForm.title }"/></td>
										<td colspan="3">
								            <c:forEach items="${areaFileList }" varStatus="idx" var="areaF">
								                <c:if test="${areaF.atthType == areaForm.atthType }">
							                        이미지 부분을 이미지가 표시되게 한 부분
							                        <a href="#down" _todeFileNo='<c:out value="${areaF.todeFileNo }"/>'>
							                        	<img class="ev-thumb" src='<c:url value="https://tdss.kr/tode/todeFileDownload.do?todeFileNo="/><c:out value="${areaF.todeFileNo }"/>' width="200" alt='<c:out value="${areaF.fileOrgNm }"/>' title='<c:out value="${areaF.fileOrgNm }"/>'>
							                        </a>
								                </c:if>
								            </c:forEach>
								            </div>
										</td>
									</tr>
							    </c:forEach>
	                        </table> --%>
	                        <!-- /Contents -->
	                    </div>
	                </div>
	            </div> <!-- /.container -->
	
	        </div>
	    </div>
	
	</div> <!-- /contents-wrap -->
	
	
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