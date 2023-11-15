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
	.date-picker, .date-picker-month	{ background-image: url('/img/icons/icon-calendar.svg'); background-repeat: no-repeat; background-size: 22px; background-position: right 5px center; }
	#popup_message			{ padding: 0; }
	/*table.ui-datepicker-calendar { display: none !important; }*/
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
<form:form commandName="model" name="model" id="model" action="/mng/saveEvaluBusiMgmtGuide.do">
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
	                <div class="local-menu th2">
	                    <ul>
	                        <li class=""><a onclick="goTab('hist')" title="사업등록">사업등록</a></li>
	                        <li class="active"><a onclick="goTab('guide')"title="사업관리">사업관리</a></li>
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
	                            개발사업 개요<small class="silent">해당 평가 당시의 사업내용은 상기 사업계획서를 참조하시기 바랍니다</small>
	                            <button type="button" class="collapsable-btn" data-clapsid="info1" title="접기">접기</button>
	                        </p>
	                        <div class="collapsable" data-clapsid="info1-trgt">
	                            <table class="evtdss-form-table">
	                            	<colgroup>
		                            	<col style="width: 180px;">
										<col style="width: *;">
										<col style="width: 180px;">
										<col style="width: 60px;">
										<col style="width: *;">
	                            	</colgroup>
	                                <tr>
	                                    <td class="labeler">사업코드</td>
	                                    <td colspan="4">
	                                    	<c:out value="${model.evaluHistNo}"/>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">사업유형</td>
	                                	<td colspan="4">
	                                		<c:out value="${evaluInfo.busiTypeLevel1Nm}"/> > <c:if test="${evaluInfo.busiTypeLevel2Nm ne null and evaluInfo.busiTypeLevel1Nm != ''}"> <c:out value="${evaluInfo.busiTypeLevel2Nm}" /> > </c:if> <c:out value="${evaluInfo.busiCateNm}"/> 
	                                	</td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">사업명</td>
	                                    <td colspan="4">
	                                    	<c:out value="${evaluInfo.evaluBusiNm}"/>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">사업 목적</td>
	                                    <td colspan="4">
	                                    	<form:textarea path="busiNote" class="g-search-input-txt" style="height: 60px;" maxLength="4000"/>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">위치</td>
	                                    <td colspan="4">
	                                    	<form:hidden path="busiAddr1" />
	                                    	<form:hidden path="busiAddr2" />
	                                    	<select id="busiAddr1Sd"  class="input-sm wd-20p" data-value="<c:out value='${model.busiAddr1}'/>"><option value="">선택</option></select>
	                                    	<select id="busiAddr2Sgg" class="input-sm wd-20p" data-value="<c:out value='${model.busiAddr2}'/>"><option value="000">본청</option></select>
	                                    	<form:input path="busiAddr3" class="g-search-input-txt" />
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler">주요 시설</td>
	                                    <td colspan="4">
	                                    	<form:textarea path="mainFclt" class="g-search-input-txt" style="height: 60px;" maxLength="1000" />
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <td class="labeler" rowspan="4">사업기간</td>
	                                    <td rowspan="4">
	                                    	<form:input path="busiSttDate" class="g-search-input-txt date-picker-month w-120px"/> ~ <form:input path="busiEndDate" class="g-search-input-txt date-picker-month w-120px"/>
	                                    </td>
	                                    <td class="labeler" rowspan="4">사업비</td>
	                                    <td class="ta-center">총합</td>
	                                    <td>
	                                    	<input id="totBusiExps" type="number" class="g-search-input-txt w-120px" readonly="readonly"/><span class="ml-5px">백만원</span>
	                                    </td>
	                                </tr>
	                                <tr>
	                                	<td class="ta-center">국비</td>
	                                	<td><form:input path="totBusiExps1" type="number" class="g-search-input-txt w-120px"/><span class="ml-5px">백만원</span></td>
	                                </tr>
	                                <tr>
	                                	<td class="ta-center">지방비</td>
	                                	<td><form:input path="totBusiExps2" type="number" class="g-search-input-txt w-120px"/><span class="ml-5px">백만원</span></td>
	                                </tr>
	                                <tr>
	                                	<td class="ta-center">민자</td>
	                                	<td><form:input path="totBusiExps3" type="number" class="g-search-input-txt w-120px"/><span class="ml-5px">백만원</span></td>
	                                </tr>
	                            </table>
	                            
	                            <div class="submit-set">
		                        	<button type="button" class="evtdss-submit"><a onclick="saveInfo();">저장</a></button>
		                        </div>
	                        </div>
	                        
	                        <p class="section-title">
	                        	제출 이력<small class="">지자체 제출 및 관리자 수정 이력입니다. (최대 10건 까지만 노출됩니다.)</small>
	                        	<button type="button" class="collapsable-btn" data-clapsid="info2" title="접기">접기</button>
	                        </p>
	                        <div class="collapsable" data-clapsid="info2-trgt">
		                        <table class="evtdss-form-table">
		                        	<colgroup>
		                        		<col style="width: 20%;">
		                        		<col style="width: 40%;">
		                        		<col style="width: 40%;">
		                        	</colgroup>
		                            <tr>
		                            	<th>번호</th>
		                                <th>제출(수정)일시</th>
		                                <th>제출자</th>
		                            </tr>
		                            <c:if test="${fn:length(listEvaluBusiMgmtHistLog) == 0}">
		                            	<tr>
			                                <td class="noData" colspan="3">
												데이터가 존재하지 않습니다.
			                                </td>
			                            </tr>
		                            </c:if>
		                            <c:if test="${fn:length(listEvaluBusiMgmtHistLog) > 0}">
		                            	<c:forEach items="${listEvaluBusiMgmtHistLog}" var="list" varStatus="idx">
		                            		<tr>
		                            			<td class="fix-width status">
				                                	<c:out value="${idx.count}" />
				                                </td>
				                                <td class="fix-width status">
				                                	<c:out value="${list.updtDate}" />
				                                </td>
				                                <td class="fix-width date">
				                                	<c:out value="${list.userNm}" /> (<c:out value="${list.updtId}" /> / <c:out value="${list.uscmNm}" /> <c:out value="${list.deptNm}" />)
				                                </td>
				                            </tr>
		                            	</c:forEach>
		                            </c:if>
		                        </table>
	                        </div>
	
	                        <p class="section-title">
	                        	참조 첨부파일<small class="">첨부파일을 등록하지 않으면 관리자 기능의 첨부파일 관리에 등록된 첨부파일이 표출됩니다.</small>
	                        	<button type="button" class="collapsable-btn" data-clapsid="info3" title="접기">접기</button>
	                        </p>
	                        <div class="collapsable" data-clapsid="info3-trgt">
		                        <table class="evtdss-form-table">
		                        	<colgroup>
		                        		<col style="width: 15%;">
		                        		<col style="width: 19%;">
		                        		<col style="width: 33%;">
		                        		<col style="width: 33%;">
		                        	</colgroup>
		                            <tr>
		                            	<th>공개대상</th>
		                                <th>서류명</th>
		                                <th>양식</th>
		                                <th>샘플</th>
		                            </tr>
		                            <tr>
		                            <tr>
		                            	<td class="fix-width title">지자체</td>
		                            	<td class="fix-width title">사업설명서</td>
		                                <td>
		                                    <input type="file" name="upload" class="regi-file-input">
		                                    <div class="regi-file" rel="N">등록파일 없음</div>
	                                    	<div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
		                                    </div>
		                                </td>
		                                <td>
		                                    <input type="file" name="upload" class="regi-file-input">
		                                    <div class="regi-file" rel="N">등록파일 없음</div>
	                                    	<div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
		                                    </div>
		                                </td>
		                            </tr>
		                            <tr>
		                            	<td class="fix-width title" rowspan="3">평가위원</td>
		                            	<td class="fix-width title">서면검토서</td>
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
		                            </tr>
		                            <tr>
		                                <td class="fix-width title">평가의견서</td>
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
		                            </tr>
		                        </table>
	                        </div>
	                        
	                        <p class="section-title">
	                        	평가위원 배정<small class="">배정된 평가위원은 <strong>등록 즉시 평가사업 정보의 열람이 바로 가능</strong>합니다.<br></small>
	                        	<button type="button" class="collapsable-btn" data-clapsid="info4" title="접기">접기</button>
	                        </p>
	                        <div class="collapsable" data-clapsid="info4-trgt">
		                        <table class="evtdss-form-table">
		                            <tr>
		                                <th>구분</th>
		                                <th>평가위원</th>
		                                <th>등록일시</th>
		                            </tr>
		                            <tr>
		                                <td class="fix-width title">평가위원</td>
		                                <td>
		                                	<c:if test="${empty commitMap01}">
		                                		<input type="text" class="regi-file-input" name="evaluCommNm1" id ="evaluCommNm1" placeholder="평가위원 검색" readonly>
		                                		<div class="block-btn button-set hor">
			                                        <button type="button" class="inline-button green" id="selBtnCommit"><a href="#link" title="평가위원 등록" onclick="modal_open();"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
			                                    </div>
			                                    <div class="incell-btn button-set hor">
		                        					<button type="button" class="inline-button green"><a onclick="commit_save(1);" title="평가위원 등록">저장</a></button>
			                                    </div>
			                                    <input type="hidden" name="evaluCommId1" id="evaluCommId1" class="_objCommId"/>
		                                	</c:if>
		                                	<c:if test="${not empty commitMap01}">
		                                		<input type="text" class="regi-file-input" name="evaluCommNm1" id ="evaluCommNm1" placeholder="평가위원 검색" value="${commitMap01.USER_NM}" readonly>
		                                		<div class="incell-btn button-set hor">
		                        					<button type="button" class="inline-button green"><a onclick="commit_delt(1);" title="등록파일 삭제">삭제</a></button>
			                                    </div>
			                                    <input type="hidden" name="evaluCommId1" id="evaluCommId1" class="_objCommId" value="${commitMap01.USER_ID}" />
		                                	</c:if>
		                                </td>
		                                <c:if test="${empty commitMap01}">
		                                	<td class="fix-width date">-</td>
		                                </c:if>
		                                <c:if test="${not empty commitMap01}">
		                                	<td class="fix-width date">${commitMap01.REGI_DATE}</td>
		                                </c:if>
		                            </tr>
		                            
		                            <tr>
		                                <td class="fix-width title">평가위원</td>
		                                <td>
		                                	<c:if test="${empty commitMap02}">
		                                		<input type="text" class="regi-file-input" name="evaluCommNm2" id ="evaluCommNm2" placeholder="평가위원 검색" readonly>
		                                		<div class="block-btn button-set hor">
			                                        <button type="button" class="inline-button green" id="selBtnCommit"><a href="#link" title="평가위원 등록" onclick="modal_open();"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
			                                    </div>
			                                    <div class="incell-btn button-set hor">
			                                        <button type="button" class="inline-button green"><a onclick="commit_save(2);" title="평가위원 등록">저장</a></button>
			                                    </div>
			                                    <input type="hidden" name="evaluCommId2" id="evaluCommId2" class="_objCommId"/>
		                                	</c:if>
		                                	<c:if test="${not empty commitMap02}">
		                                		<input type="text" class="regi-file-input" name="evaluCommNm2" id ="evaluCommNm2" placeholder="평가위원 검색" value="${commitMap02.USER_NM}" readonly>
		                                		<div class="incell-btn button-set hor">
		                        					<button type="button" class="inline-button green"><a onclick="commit_delt(2);" title="등록파일 삭제">삭제</a></button>
			                                    </div>
			                                    <input type="hidden" name="evaluCommId2" id="evaluCommId2" class="_objCommId" value="${commitMap02.USER_ID}" />
		                                	</c:if>
		                                </td>
		                                <c:if test="${empty commitMap02}">
		                                	<td class="fix-width date">-</td>
		                                </c:if>
		                                <c:if test="${not empty commitMap02}">
		                                	<td class="fix-width date">${commitMap02.REGI_DATE}</td>
		                                </c:if>
		                            </tr>
		                            
		                            <tr>
		                                <td class="fix-width title">평가위원</td>
		                                <td>
		                                	<c:if test="${empty commitMap03}">
		                                		<input type="text" class="regi-file-input" name="evaluCommNm3" id ="evaluCommNm3" placeholder="평가위원 검색" readonly>
		                                		<div class="block-btn button-set hor">
			                                        <button type="button" class="inline-button green" id="selBtnCommit"><a href="#link" title="평가위원 등록" onclick="modal_open();"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
			                                    </div>
			                                    <div class="incell-btn button-set hor">
		                        					<button type="button" class="inline-button green"><a onclick="commit_save(3);" title="평가위원 등록">저장</a></button>
			                                    </div>
			                                    <input type="hidden" name="evaluCommId3" id="evaluCommId3" class="_objCommId"/>
		                                	</c:if>
		                                	<c:if test="${not empty commitMap03}">
		                                		<input type="text" class="regi-file-input" name="evaluCommNm3" id ="evaluCommNm3" placeholder="평가위원 검색" value="${commitMap03.USER_NM}" readonly>
		                                		<div class="incell-btn button-set hor">
		                        					<button type="button" class="inline-button green"><a onclick="commit_delt(3);" title="등록파일 삭제">삭제</a></button>
			                                    </div>
			                                    <input type="hidden" name="evaluCommId3" id="evaluCommId3" class="_objCommId" value="${commitMap03.USER_ID}" />
		                                	</c:if>
		                                </td>
		                                <c:if test="${empty commitMap03}">
		                                	<td class="fix-width date">-</td>
		                                </c:if>
		                                <c:if test="${not empty commitMap03}">
		                                	<td class="fix-width date">${commitMap03.REGI_DATE}</td>
		                                </c:if>
		                            </tr>
		                        </table>
							</div>
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

<!-- Modal -->
<!-- <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 650px;">
      <div class="modal-header">
      	<div class="pull-left"><i class="icon-ic_account_circle"></i></div>
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
        	<h4>평가위원 목록</h4>
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
	        <input type="hidden" name="srchEvaluCommNm"  id="srchEvaluCommNm"  value='<c:out value="${paramMap.srchEvaluCommNm}"/>'/>
	    </div>
	    
	        <%-- 평가위원 타켓 --%>
	    <input type="hidden" name="targetId"  id="targetId"  value='<c:out value="${paramMap.targetId}"/>'/>
	    <input type="hidden" name="paramEvaluItem" id="paramEvaluItem"/>
	    <input type="hidden" name="preEvaluItem" id="preEvaluItem" value="${rtnMap.stgMap.evaluStage }"/>
	    <input type="hidden" name="arrIndi" id="arrIndi" value="${rtnMap.arrIndi }"/>
	    <input type="hidden" name="deltEvaluCommId" id="deltEvaluCommId" />

			<table class="table table2Way marginBottom40"><!-- 검색-->
				<colgroup>
					<col style="width: 105px">
					<col style="width: 150px;">
					<col style="width: *;">
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
						    <select class="form-control input-sm" style="width: 142px;" name="srchBusiAddr2Temp" id="srchBusiAddr2Temp">
								<option value="">::전체::</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가분야</th>
						<td colspan="2">
						    <select class="form-control input-sm" style="width: 142px;"  name="srchBusiTypeTemp" id="srchBusiTypeTemp" >
		                        <option value="">::전체::</option>
		                        <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
		                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
		                                <c:out value="${type.codeNm }"/>
		                            </option>
		                        </c:forEach>
							</select>
						</td>
					</tr>
					<tr class="bottomPadding">
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가위원</th>
						<td colspan="2">
						    <input type="text" class="form-control input-sm" id="srchEvaluCommNmTemp" name="srchEvaluCommNmTemp" style="width: 292px;" value='<c:out value="${paramMap.srchEvaluCommNm }"/>' >
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

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>