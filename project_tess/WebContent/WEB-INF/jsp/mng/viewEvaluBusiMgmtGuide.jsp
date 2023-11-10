<%--
*******************************************************************************
***    명칭: viewEvaluBusiMgmtGuide.jsp
***    설명: [관리자] 평가사업관리 > 평가지침 화면
***
***    -----------------------------    Modified Log   ---------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0    2023.11.10        LHB       First Coding.
*******************************************************************************
--%>
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
	<!-- <script type="text/javascript" src="/jquery/jstree/jquery.jstree.js"></script> -->
	<!-- <script type="text/javascript" src="/jquery/jstree/jquery.hotkeys.js"></script> -->
	<script type="text/javascript" src="/jquery/jstree/jquery.cookie.js"></script>
	
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
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>
    <form:hidden path="evaluHistSn" />	<%-- 평가사업 이력 일련번호 --%>
    <form:hidden path="evaluBusiSn" />	<%-- 평가사업 일련번호 --%>
    
    <form:hidden path="evaluBusiNo" id="evaluBusiNo" />
    <form:hidden path="evaluStage" id="evaluStage" />
    
    <input type="hidden" name="userId" id="userId" value='<c:out value="${paramMap.gsUserId}"/>'>
    <input type="hidden" name="docuType" id="docuType" value="">
    <input type="hidden" name="atthType" id="atthType" value="">

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
	                    <li>관리자</li>
	                    <li>평가사업관리</li>
	                    <li>${evaluInfo.PLANEVAL_BUSI_NAME}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가사업관리</h3>
	                </div>
	            </div>
	
	            <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	                <div class="shade"></div>
	                <div class="project-title">
	                    <h2><c:out value="${evaluInfo.evaluBusiNm}" /></h2>
	                    <p><c:out value="${evaluInfo.busiAddr}" /> / <c:out value="${evaluBusiMgmtHistInfo.evaluStageNm}" /></p>
	                </div>
	                <div class="local-menu th3">
	                    <ul>
	                        <li class=""><a onclick="goTab('hist')" title="평가이력">평가이력</a></li>
	                        <li class="active"><a onclick="goTab('guide')"title="평가지침">평가지침</a></li>
	                        <li class=""><a onclick="goTab('plan')" title="실행계획">실행계획</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/mng/listEvaluBusiMgmt.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">평가지침</h4>
								<a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	                        <!-- Contents -->
	                        <p class="section-title">
	                            관광개발사업 개요<small class="silent">해당 평가 당시의 사업내용은 상기 사업계획서를 참조하시기 바랍니다</small>
	                            <button type="button" class="collapsable-btn" onClick="$.collapsable('.collapsable', 'hide')" title="접기">접기</button>
	                        </p>
	                        <button class="collapsable-showMe silent" onClick="$.collapsable('.collapsable', 'show')" title="내용 펼쳐보기">내용 펼쳐보기</button>
	                        <div class="collapsable">
	                            <table class="evtdss-form-table">
	                            	<colgroup>
		                            	<col style="width: 180px;">
										<col style="width: *;">
										<col style="width: 180px;">
										<col style="width: *;">
	                            	</colgroup>
	                                <tr>
	                                    <td class="labeler">사업명</td>
	                                    <td>
	                                    	<c:out value="${evaluInfo.evaluBusiNm}"/>
	                                    </td>
	                                    <td class="labeler">사업유형</td>
	                                	<td>
	                                		<select class="input-sm wd-40p"></select>
	                                		<select class="input-sm wd-40p"></select>
	                                	</td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">시행주체</td>
	                                    <td colspan="3">
	                                    	<select class="input-sm wd-20p">></select>
	                                    	<select class="input-sm wd-20p">></select>
	                                    	<input class="g-search-input-txt wd-80p" />
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">총 사업기간</td>
	                                    <td colspan="3">
	                                    	<form:input path="busiSttDate" /> ~ <form:input path="busiEndDate" />
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">사업 목적</td>
	                                    <td colspan="3">
	                                    	<form:textarea path="busiNote" class="g-search-input-txt" style="height: 60px;" maxLength="4000"/>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">주요 시설</td>
	                                    <td colspan="3">
	                                    	<form:textarea path="mainFclt" class="g-search-input-txt" style="height: 60px;" maxLength="1000" />
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">사업비</td>
	                                    <td colspan="3">
	                                    	<form:input path="totBusiExps" type="number" class="g-search-input-txt w-120px"/><span>원</span>
	                                    </td>
	                                </tr>
	                            </table>
	                        </div>
	
	                        <p class="section-title">첨부파일<small class="silent">평가지침 및 참조 파일을 등록합니다.</small></p>
	                        <table class="evtdss-form-table">
	                        	<colgroup>
	                        		<col style="width: 15%;">
	                        		<col style="width: 70%;">
	                        		<col style="width: 15%;">
	                        	</colgroup>
	                            <tr>
	                                <th>구분</th>
	                                <th>서류등록</th>
	                                <th>등록일시</th>
	                            </tr>
	                            <tr>
	                            	<td class="fix-width title">사업설명서 샘플</td>
	                                <td>
	                                    <input type="file" name="upload" class="regi-file-input">
	                                    <div class="regi-file" rel="N">등록파일 없음</div>
                                    	<div class="incell-btn button-set hor">
                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
	                                    </div>
	                                </td>
	                                <td class="fix-width date">-</td>
	                            </tr>
	                            <tr>
	                            	<td class="fix-width title">기본계획보고서 샘플</td>
	                                <td>
	                                    <input type="file" name="upload" class="regi-file-input">
	                                    <div class="regi-file" rel="N">등록파일 없음</div>
                                    	<div class="incell-btn button-set hor">
                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
	                                    </div>
	                                </td>
	                                <td class="fix-width date">-</td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가지침서</td>
	                                <td>
	                                    <c:if test="${evaluDocA == null}">
	                                    	<input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT06" id="AT06">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>	
	                                    	<div class="incell-btn button-set hor">
		                                    	<button type="button" class="inline-button green"><a onclick="doc_save('AT06');" title="선택파일 추가">저장</a></button>
		                                    </div>
	                                    </c:if>
	                                    <c:if test="${evaluDocA != null}">
	                                    	<input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT06" id="AT06">
	                                    	<div class="regi-file" rel="Y">${evaluDocA.FILE_ORG_NM}</div>
	                                    	<div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocA.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                    </div>	
	                                    </c:if>
	                               </td>
	                               <c:if test="${evaluDocA == null}">
                                    	<td class="fix-width date">-</td>	
                                    </c:if>
                                    <c:if test="${evaluDocA != null}">
                                    	<td class="fix-width date">${evaluDocA.REGI_DATE}</td>	
                                    </c:if>
	                            </tr>
	                            <tr>
                            		<input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>
                            		<%-- 허용된 첨부파일 확장명 --%>
								    <input type="hidden" name="allowedFileExts"    id="allowedFileExts"     value='<c:out value="${paramMap.allowedFileExts}"/>'/>
								    <input type="hidden" name="allowedImgFileExts" id="allowedImgFileExts"  value='<c:out value="${paramMap.allowedImgFileExts}"/>'/>
                            	
	                                <td class="fix-width title">서면검토서 샘플</td>
	                                <td>
	                                    <input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT07" id="AT07">
	                                    
	                                    <c:if test="${evaluDocB == null}">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>
	                                    	<div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
		                                    </div>	
	                                    </c:if>
	                                    <c:if test="${evaluDocB != null}">
	                                    	<div class="regi-file" rel="Y">${evaluDocB.FILE_ORG_NM}</div>
	                                    	<div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocB.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                    </div>		
	                                    </c:if>
	                                </td>
	                                <c:if test="${evaluDocB == null}">
                                    	<td class="fix-width date">-</td>	
                                    </c:if>
                                    <c:if test="${evaluDocB != null}">
                                    	<td class="fix-width date">${evaluDocB.REGI_DATE}</td>	
                                    </c:if>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가의견서 샘플</td>
	                                <td>
	                                    <input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT08" id="AT08">
	                                    
	                                    <c:if test="${evaluDocC == null}">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>	
	                                    	<div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT08');" title="선택파일 추가">저장</a></button>
		                                    </div>	
	                                    </c:if>
	                                    <c:if test="${evaluDocC != null}">
	                                    	<div class="regi-file" rel="Y">${evaluDocC.FILE_ORG_NM}</div>	
	                                    	<div class="incell-btn button-set hor">
	                                   			<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocC.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                    </div>
	                                    </c:if>
	                                </td>
	                                <c:if test="${evaluDocC == null}">
                                    	<td class="fix-width date">-</td>	
                                    </c:if>
                                    <c:if test="${evaluDocC != null}">
                                    	<td class="fix-width date">${evaluDocC.REGI_DATE}</td>	
                                    </c:if>
	                            </tr>
	
	                        </table>

	                        <!-- 조회 모드에서는 제공되지 않습니다. -->
	                        <div class="body-descriptions">
	                        	첨부파일을 등록하지 않으면 기본으로 등록된 첨부파일이 표출됩니다.<br>
	                            <strong>평가진행 이력이 존재할 경우 제출취소가 불가</strong>하오니 내용이 정확한지 확인하신 후 제출하시기 바랍니다.<br>
	                        </div>
	
	                        <div class="submit-set">
	                        
	                        	<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        		<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        			<button type="button" class="evtdss-submit-cancel"><a href="#" onclick="submission_btn('N');" title="제출취소">제출취소</a></button>
	                        		</c:if>
	                        		<c:if test="${checkStagekHist.AGREE_CHECK != 0}">
	                        		
	                        		</c:if>
	                        		<!-- <button type="button" class="evtdss-submit-cancel"><a onclick="submission_btn('N');" title="제출취소">제출취소</a></button> -->
	                        	</c:if>
	                        	<c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a onclick="submission_btn('Y');" title="저장">저장</a></button>
	                        	</c:if>
	                            <!-- 제출이력이 있을 경우 표시 -->
	                            <!-- <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div> -->
	                            <!-- /제출이력이 있을 경우 표시 -->
	                        </div>
	
							<!-- 
	                        <p class="section-title">평가사업 등록상태<small>평가지침과 실행계획이 모두 제출된 후 공개됩니다</small></p>
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>평가연도</th>
	                                <th>평가단계</th>
	                                <th>평가지침</th>
	                                <th>실행계획</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width status">${evaluInfo.EVALU_GUBUN}</td>
	                                <td>${evaluInfo.EVALU_STAGE_NM}</td>
	                                <c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                                	<td class="fix-width status">제출</td>
	                                </c:if>
	                                <c:if test="${evaluInfo.EVALU_GUIDE_YN == 'N' || evaluInfo.EVALU_GUIDE_YN == null}">
	                                	<td class="fix-width status">미제출</td>
	                                </c:if>
	                                <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                                	<td class="fix-width status">제출</td>
	                                </c:if>
	                                <c:if test="${evaluInfo.EVALU_PLAN_YN == 'N' || evaluInfo.EVALU_PLAN_YN == null}">
	                                	<td class="fix-width status">미제출</td>
	                                </c:if>
	                            </tr>
	                        </table>
	                        -->
	
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