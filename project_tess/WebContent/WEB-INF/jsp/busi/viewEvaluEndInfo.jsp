<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
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
	                        <li class=""><a onclick="fn_goBusiInfo();" title="사업정보">사업정보</a></li>
	                        <li class="active"><a title="평가정보">평가정보</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/busi/listEvaluEndBusi.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">평가정보</h4>
	                            <a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	                        <!-- Contents -->
	
	                        <p class="section-title">평가의견서<small class="silent">평가진행현황입니다.</small></p>
	                        <!-- 관리자 전용 -->
	                        <div class="select-committee">
	                            <ul>
	                            	<c:forEach items="${evaluCommitList}" varStatus="status" var="comlist">
	                            		<c:if test="${status.first}">
	                            			<li class="active"><a href="#" title="평가위원 A">평가위원 (<c:out value="${comlist.USER_NM}"/>)</a></li>
	                            		</c:if>
	                            		<c:if test="${!status.first}">
	                            			<li><a href="#" title="평가위원 A">평가위원 (<c:out value="${comlist.USER_NM}"/>)</a></li>
	                            		</c:if>
	                            	</c:forEach>
	                                <!-- <li class="active"><a href="#" title="평가위원 A">평가위원 A (홍길동)</a></li> 이름은 관리자만 표시됨
	                                <li class=""><a href="#" title="평가위원 B">평가위원 B (강감찬)</a></li>
	                                <li class=""><a href="#" title="평가위원 C">평가위원 C (유관순)</a></li> -->
	                            </ul>
	                        </div>
	                        <!-- /관리자 전용 -->
	                        <div id="commit_table_list">
	                        
	                        	<c:forEach items="${evaluCommitList}" varStatus="status" var="comlist">
	                        	
	                        		<c:if test="${status.first}">
	                        			<table class="evtdss-form-table">
	                        		</c:if>
	                        		<c:if test="${!status.first}">
	                        			<table class="evtdss-form-table" style="display:none;">
	                        		</c:if>
			                            <tr>
			                                <th>구분</th>
			                                <th>내용</th>
			                            </tr>
			                            <tr>
			                                <td class="fix-width title">
			                                    	서면검토서
			                                </td>
			                                <td>
			                                	<c:if test="${comlist.REVIEW_FILE_NO != null}">
			                                		<c:forTokens var="token" items="${comlist.REVIEW_FILE_NM}" delims="." varStatus="status">
			                                			<c:if test="${status.last}">
			                                				<c:choose>
			                                					<c:when test="${token eq 'hwp'}">
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.REVIEW_FILE_NO}" title="서면검토서"><img src="../../../images/icon_file_hwp.jpg"> <div class="regi-file-inline">${comlist.REVIEW_FILE_NM}</div></a>
			                                					</c:when>
			                                					<c:when test="${token eq 'pdf'}">
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.REVIEW_FILE_NO}" title="서면검토서"><img src="../../../images/icon_file_pdf.jpg"> <div class="regi-file-inline">${comlist.REVIEW_FILE_NM}</div></a>
			                                					</c:when>
			                                					<c:when test="${token eq 'zip'}">
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.REVIEW_FILE_NO}" title="서면검토서"><img src="../../../images/icon_file_zip.jpg"> <div class="regi-file-inline">${comlist.REVIEW_FILE_NM}</div></a>
			                                					</c:when>
			                                					<c:otherwise>
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.REVIEW_FILE_NO}" title="서면검토서"><img src="../../../images/icon_file_hwp.jpg"> <div class="regi-file-inline">${comlist.REVIEW_FILE_NM}</div></a>
			                                					</c:otherwise>
			                                				</c:choose>
			                                			</c:if>
			                                		</c:forTokens>
			                                	</c:if>
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="fix-width title">
			                                   	 	평가의견서
			                                </td>
			                                <td>
			                                	<c:if test="${comlist.OPINION_FILE_NO != null}">
			                                		<c:forTokens var="token" items="${comlist.OPINION_FILE_NM}" delims="." varStatus="status">
			                                			<c:if test="${status.last}">
			                                				<c:choose>
			                                					<c:when test="${token eq 'hwp'}">
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.OPINION_FILE_NO}" title="평가의견서"><img src="../../../images/icon_file_hwp.jpg"> <div class="regi-file-inline">${comlist.OPINION_FILE_NM}</div></a>
			                                					</c:when>
			                                					<c:when test="${token eq 'pdf'}">
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.OPINION_FILE_NO}" title="평가의견서"><img src="../../../images/icon_file_pdf.jpg"> <div class="regi-file-inline">${comlist.OPINION_FILE_NM}</div></a>
			                                					</c:when>
			                                					<c:when test="${token eq 'zip'}">
			                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.OPINION_FILE_NO}" title="평가의견서"><img src="../../../images/icon_file_zip.jpg"> <div class="regi-file-inline">${comlist.OPINION_FILE_NM}</div></a>
			                                					</c:when>
			                                					<c:otherwise>
					                                				<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${comlist.OPINION_FILE_NO}" title="평가의견서"><img src="../../../images/icon_file_hwp.jpg"> <div class="regi-file-inline">${comlist.OPINION_FILE_NM}</div></a>
			                                					</c:otherwise>
			                                				</c:choose>
			                                			</c:if>
			                                		</c:forTokens>
			                                	</c:if>
			                                </td>
			                            </tr>
			                        </table>
	                        	
	                        	</c:forEach>
	                        
	                        </div>
	
	                        <p class="section-title">종합결과<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table" summary="평가의견을 취합한 평가결과의 종합의견서 첨부파일입니다.">
								<caption class="sr-only">종합결과서</caption>
								<colgroup><col /><col /></colgroup>
								<thead>
	                            <tr>
	                                <th scope="col">구분</th>
	                                <th scope="col">내용</th>
	                            </tr>
								</thead>
								<tbody>
								<tr>
									<td class="fix-width title">
                                    	종합의견
                                	</td>
									<td>
										<div class="incell-text">
                                        	${evaluInfo.FINAL_EVALU_FND_NOTE}
                                    	</div>
                                	</td>
								</tr>
								<tr>
									<td class="fix-width title">
                                    	평가결과
                                	</td>
									<td>
	                                    <!-- <strong class="txt-heightlight">[사전평가]</strong> 해당 평가단계 -->
	                                    <c:if test="${evaluInfo.FINAL_EVALU_FND == 'P'}">
	                                    	적합
	                                    </c:if>
	                                    <c:if test="${evaluInfo.FINAL_EVALU_FND == 'C'}">
	                                    	조건부적합
	                                    </c:if>
	                                    <c:if test="${evaluInfo.FINAL_EVALU_FND == 'F'}">
	                                    	부적합
	                                    </c:if>
	                                </td>
								</tr>
	                            <tr>
	                                <td class="fix-width title">종합결과서</td>
	                                <td>
	                                	<c:if test="${totaResultMap.EVALU_FILE_NO != null}">
	                                		<c:forTokens var="token" items="${totaResultMap.FILE_ORG_NM}" delims="." varStatus="status">
	                                			<c:if test="${status.last}">
	                                				<c:choose>
	                                					<c:when test="${token eq 'hwp'}">
	                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${totaResultMap.EVALU_FILE_NO}" title="종합결과서"><img alt="종합결과서" src="../../../images/icon_file_hwp.jpg"> <div class="regi-file-inline">${totaResultMap.FILE_ORG_NM}</div></a>
	                                					</c:when>
	                                					<c:when test="${token eq 'pdf'}">
	                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${totaResultMap.EVALU_FILE_NO}" title="종합결과서"><img alt="종합결과서" src="../../../images/icon_file_pdf.jpg"> <div class="regi-file-inline">${totaResultMap.FILE_ORG_NM}</div></a>
	                                					</c:when>
	                                					<c:when test="${token eq 'zip'}">
	                                						<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${totaResultMap.EVALU_FILE_NO}" title="종합결과서"><img alt="종합결과서" src="../../../images/icon_file_zip.jpg"> <div class="regi-file-inline">${totaResultMap.FILE_ORG_NM}</div></a>
	                                					</c:when>
	                                					<c:otherwise>
			                                				<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${totaResultMap.EVALU_FILE_NO}" title="종합결과서"><img alt="종합결과서" src="../../../images/icon_file_hwp.jpg"> <div class="regi-file-inline">${totaResultMap.FILE_ORG_NM}</div></a>
	                                					</c:otherwise>
	                                				</c:choose>
	                                			</c:if>
			                                </c:forTokens>
	                                	</c:if>
	                                </td>
	                            </tr>
								</tbody>
	                        </table>
	
	                        <p class="section-title">첨부파일<small class="silent">평가진행현황입니다.</small></p>
	                        <table class="evtdss-form-table noMargin" summary="현재 평가단계 참고자료입니다.">
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
	                            <tr>
	                                <td>${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM} 평가지침서</td>
	                                <td class="fix-width file">
	                                	<c:if test="${evaluDocA != null}">
	                                		<a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocA.EVALU_FILE_NO}"><img alt="${evaluDocA.FILE_ORG_NM}" src="../../../images/icon_file_hwp.jpg"></a>
	                                	</c:if>
	                                </td>
	                                <td class="fix-width date"></td>
	                            </tr>
								</tbody>
	                        </table>
	
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