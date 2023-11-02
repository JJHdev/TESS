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

<style>
	input[type=file] {
		background: none !important;
	}
	#myModal {
		right: inherit !important;
		bottom: inherit !important;
		height: 800px;
	}
	.modal-dialog {
		margin: auto;
		width: 100%;
		transform: inherit !important;
	}
</style>


<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
<!-- ======================================================= -->

<link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
<script src="/jquery/vendor/moment-with-locales.min.js"></script>
<script src="/jquery/vendor/bootstrap-datetimepicker.min.js"></script>

<div class="contents" >

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model">

    <%-- pk --%>
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>

    <%-- pk --%>
    <%-- <form:hidden path="evaluBusiNo" /> --%>
    
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo" value='<c:out value="${evaluInfo.EVALU_BUSI_NO}"/>'>
    <input type="hidden" name="evaluStage" id="evaluStage" value='<c:out value="${evaluInfo.EVALU_STAGE}"/>'>
    <input type="hidden" name="evaluGubun" id="evaluGubun" value='<c:out value="${evaluInfo.EVALU_GUBUN}"/>'>
    
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
    
    <%-- 평가위원 타켓 --%>
    <input type="hidden" name="targetId"     id="targetId"/>
    <input type="hidden" name="paramEvaluItem" id="paramEvaluItem"/>
    <input type="hidden" name="preEvaluItem" id="preEvaluItem" value="${rtnMap.stgMap.evaluStage }"/>
    <input type="hidden" name="arrIndi" id="arrIndi" value="${rtnMap.arrIndi }"/>
    <input type="hidden" name="deltEvaluCommId" id="deltEvaluCommId" />

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
	                    <h2>${evaluInfo.PLANEVAL_BUSI_NAME}</h2>
	                    <p>${evaluInfo.busiAddress1} / ${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</p>
	                </div>
	                <div class="local-menu th3">
	                    <ul>
	                        <li><a onclick="goTab('hist')" title="평가이력">평가이력</a></li>
	                        <li><a onclick="goTab('guide')" title="평가지침">평가지침</a></li>
	                        <li class="active"><a onclick="goTab('plan')" title="실행계획">실행계획</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/mng/listEvaluBusiMgmt.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">실행계획</h4>
								<a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	                        <!-- Contents -->
	                        <p class="section-title">
	                            관광개발사업 개요<small class="silent">해당 평가 당시의 사업내용은 상기 사업계획서를 참조하시기 바랍니다</small>
	                            <button class="collapsable-btn" onClick="$.collapsable('.collapsable', 'hide')" title="접기">접기</button>
	                        </p>
	                        <button class="collapsable-showMe silent" onClick="$.collapsable('.collapsable', 'show')" title="내용 펼쳐보기">내용 펼쳐보기</button>
	                        <div class="collapsable">
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
	                            <table class="evtdss-form-table">
	                                입력 form을 atthType의 리스트로 loop를 수행하면서 구성.
								    <c:forEach items="${areaFormList }" varStatus="status" var="areaForm">
										<tr>
											<td class="labeler"><c:out value="${areaForm.title }"/></th>
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
	                        </div>
	
	                        <p class="section-title">평가일정수립<small class="silent">평가일정계획수립</small></p>
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <td class="labeler">세부평가일정</td>
	                                <td colspan="3" class="noPadding">
	                                    <table class="evtdss-form-table-incell">
	                                        <tr>
	                                            <td class="labeler">서면검토</td>
	                                            <td>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds01_stt'>
	                                                            <input type='text' class="form-control" value="${planMap01.DETAIL_STAGE_STT_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <span class="inline-hypn">─</span>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds01_end'>
	                                                            <input type='text' class="form-control" value="${planMap01.DETAIL_STAGE_END_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="labeler">현장실사</td>
	                                            <td>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds02_stt'>
	                                                            <input type='text' class="form-control" value="${planMap02.DETAIL_STAGE_STT_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <span class="inline-hypn">─</span>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds02_end'>
	                                                            <input type='text' class="form-control" value="${planMap02.DETAIL_STAGE_END_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="labeler">평가의견</td>
	                                            <td>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds03_stt'>
	                                                            <input type='text' class="form-control" value="${planMap03.DETAIL_STAGE_STT_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="labeler">종합평가</td>
	                                            <td>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds04_stt'>
	                                                            <input type='text' class="form-control" value="${planMap04.DETAIL_STAGE_STT_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="labeler">평가완료</td>
	                                            <td>
	                                                <div class='col-sm-5 noPadding noMargin'>
	                                                    <div class="form-group noMargin noPadding dtpick">
	                                                        <div class='input-group date' id='datetimepicker_ds05_stt'>
	                                                            <input type='text' class="form-control" value="${planMap05.DETAIL_STAGE_STT_DATE}" />
	                                                            <span class="input-group-addon">
	                                                                <span class="glyphicon glyphicon-calendar"></span>
	                                                            </span>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </td>
	                            </tr>
	                        </table>
	                        <div class="submit-set">
	                            <button type="button" class="evtdss-submit"><a onclick="savePlan();" title="저장">저장</a></button>
	                            <button type="button" class="evtdss-submit-cancel"><a onclick="planReset();" title="초기화">초기화</a></button>
	                            <!-- 제출이력이 있을 경우 표시
	                            <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 저장</span> 되었습니다.</div>
	                            /제출이력이 있을 경우 표시 -->
	                        </div>
	
	                        <p class="section-title">기획평가단 구성<small class="silent">평가위원을 지정합니다.</small></p>
	                        <div class="body-descriptions">
	                            배정된 평가위원은 <strong>등록 즉시 평가사업 정보의 열람이 바로 가능</strong>합니다.<br>
	                        </div>
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
		                                    	<%-- <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        							<button type="button" class="inline-button green"><a onclick="commit_save(1);" title="평가위원 등록">저장</a></button>
	                        						</c:if>
	                        					</c:if>
	                        					<c:if test="${evaluInfo.EVALU_PLAN_YN != 'Y'}">
	                        							<button type="button" class="inline-button green"><a onclick="commit_save(1);" title="평가위원 등록">저장</a></button>
	                        					</c:if> --%>
	                        					<button type="button" class="inline-button green"><a onclick="commit_save(1);" title="평가위원 등록">저장</a></button>
		                                    </div>
		                                    <input type="hidden" name="evaluCommId1" id="evaluCommId1" class="_objCommId"/>
	                                	</c:if>
	                                	<c:if test="${not empty commitMap01}">
	                                		<input type="text" class="regi-file-input" name="evaluCommNm1" id ="evaluCommNm1" placeholder="평가위원 검색" value="${commitMap01.USER_NM}" readonly>
	                                		<div class="incell-btn button-set hor">
	                                			<%-- <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        							<button type="button" class="inline-button green"><a onclick="commit_delt(1);" title="등록파일 삭제">삭제</a></button>
	                        						</c:if>
	                        					</c:if>
	                        					<c:if test="${evaluInfo.EVALU_PLAN_YN != 'Y'}">
	                        						<button type="button" class="inline-button green"><a onclick="commit_delt(1);" title="등록파일 삭제">삭제</a></button>
	                        					</c:if> --%>
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
		                                    	<%-- <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
														<button type="button" class="inline-button green"><a onclick="commit_save(2);" title="평가위원 등록">저장</a></button>						                        						
	                        						</c:if>
	                        					</c:if>
		                                        <c:if test="${evaluInfo.EVALU_PLAN_YN != 'Y'}">
		                                        	<button type="button" class="inline-button green"><a onclick="commit_save(2);" title="평가위원 등록">저장</a></button>
		                                        </c:if> --%>
		                                        <button type="button" class="inline-button green"><a onclick="commit_save(2);" title="평가위원 등록">저장</a></button>
		                                    </div>
		                                    <input type="hidden" name="evaluCommId2" id="evaluCommId2" class="_objCommId"/>
	                                	</c:if>
	                                	<c:if test="${not empty commitMap02}">
	                                		<input type="text" class="regi-file-input" name="evaluCommNm2" id ="evaluCommNm2" placeholder="평가위원 검색" value="${commitMap02.USER_NM}" readonly>
	                                		<div class="incell-btn button-set hor">
	                                			<%-- <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        							<button type="button" class="inline-button green"><a onclick="commit_delt(2);" title="등록파일 삭제">삭제</a></button>
	                        						</c:if>
	                        					</c:if>
	                        					<c:if test="${evaluInfo.EVALU_PLAN_YN != 'Y'}">
	                        						<button type="button" class="inline-button green"><a onclick="commit_delt(2);" title="등록파일 삭제">삭제</a></button>
	                        					</c:if> --%>
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
		                                    	<%-- <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        							<button type="button" class="inline-button green"><a onclick="commit_save(3);" title="평가위원 등록">저장</a></button>
	                        						</c:if>
	                        					</c:if>
	                        					<c:if test="${evaluInfo.EVALU_PLAN_YN == 'N'}">
	                        						<button type="button" class="inline-button green"><a onclick="commit_save(3);" title="평가위원 등록">저장</a></button>
	                        					</c:if> --%>
	                        					<button type="button" class="inline-button green"><a onclick="commit_save(3);" title="평가위원 등록">저장</a></button>
		                                    </div>
		                                    <input type="hidden" name="evaluCommId3" id="evaluCommId3" class="_objCommId"/>
	                                	</c:if>
	                                	<c:if test="${not empty commitMap03}">
	                                		<input type="text" class="regi-file-input" name="evaluCommNm3" id ="evaluCommNm3" placeholder="평가위원 검색" value="${commitMap03.USER_NM}" readonly>
	                                		<div class="incell-btn button-set hor">
	                                			<%-- <c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        							<button type="button" class="inline-button green"><a onclick="commit_delt(3);" title="등록파일 삭제">삭제</a></button>
	                        						</c:if>
	                        					</c:if>
	                        					<c:if test="${evaluInfo.EVALU_PLAN_YN == 'N'}">
	                        						<button type="button" class="inline-button green"><a onclick="commit_delt(3);" title="등록파일 삭제">삭제</a></button>
	                        					</c:if> --%>
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
	                            
	                            <%-- <c:if test="${empty rtnMap.commList}">	
	                            	<tr>
		                                <td class="fix-width title">평가위원</td>
		                                <td>
		                                    <input type="text" class="regi-file-input" name="evaluCommNm1" id ="evaluCommNm1" placeholder="평가위원 검색" readonly>
		                                    <div class="block-btn button-set hor">
		                                        <!-- <button type="button" class="inline-button green"><a href="#link" title="평가위원 등록" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button> -->
		                                        <button type="button" class="inline-button green" id="selBtnCommit"><a href="#link" title="평가위원 등록" onclick="modal_open();"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
		                                    </div>
		                                    <!-- <div class="regi-file">평가위원을 검색하세요</div> -->
		                                    <!-- <div class="regi-file">서면검토서.hwp</div> -->
		                                    <div class="incell-btn button-set hor">
		                                        <button type="button" class="inline-button green"><a href="#" title="평가위원 등록">저장</a></button>
		                                        <button type="button" class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
		                                    </div>
		                                    <input type="hidden" name="evaluCommId1" id="evaluCommId1" class="_objCommId"/>
		                                </td>
		                                <td class="fix-width date">2018-09-08 16:18:00</td>
		                            </tr>
	                            </c:if>
	                            
	                            <c:if test="${not empty rtnMap.commList}">   
	                            	<c:forEach items="${rtnMap.commList }" var="item"  varStatus="idx">
	                            		<tr>
			                                <td class="fix-width title">평가위원</td>
			                                <td>
			                                    <input type="text" class="regi-file-input" name="evaluCommNm${idx.count }"  id="evaluCommNm${idx.count }" placeholder="평가위원 검색" value="${item.userNm }"  readonly="readonly">
			                                    <div class="block-btn button-set hor">
			                                        <button type="button" class="inline-button green" id="selBtnCommit"><a href="#" title="평가위원 등록" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
			                                    </div>
			                                    <!-- <div class="regi-file">평가위원을 검색하세요</div> -->
			                                    <!-- <div class="regi-file">서면검토서.hwp</div> -->
			                                    <div class="incell-btn button-set hor">
			                                        <button type="button" class="inline-button green"><a href="#" title="평가위원 등록">저장</a></button>
			                                        <button type="button" class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
			                                    </div>
			                                </td>
			                                <td class="fix-width date">2018-09-08 16:18:00</td>
			                            </tr>
	                            	</c:forEach>
	                            </c:if> --%>
	                            
	                            
	                            
	                            
	                            
	                            <!-- <tr>
	                                <td class="fix-width title">평가위원 B</td>
	                                <td>
	                                    <input type="text" class="regi-file-input" id="committee2" placeholder="평가위원 검색" value="유관순" readonly>
	                                    <div class="block-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
	                                    </div>
	                                    <div class="regi-file">평가위원을 검색하세요</div>
	                                    <div class="regi-file">서면검토서.hwp</div>
	                                    <div class="incell-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록">저장</a></button>
	                                        <button class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
	                                    </div>
	                                </td>
	                                <td class="fix-width date">2018-09-08 16:18:00</td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가위원 C</td>
	                                <td>
	                                    <input type="text" class="regi-file-input" id="committee3" placeholder="평가위원 검색" value="강감찬" readonly>
	                                    <div class="block-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
	                                    </div>
	                                    <div class="regi-file">평가위원을 검색하세요</div>
	                                    <div class="regi-file">서면검토서.hwp</div>
	                                    <div class="incell-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록">저장</a></button>
	                                        <button class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
	                                    </div>
	                                </td>
	                                <td class="fix-width date">2018-09-08 16:18:00</td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가위원 B</td>
	                                <td>
	                                    <input type="text" class="regi-file-input" id="committee4" placeholder="평가위원 검색" value="" readonly>
	                                    <div class="block-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
	                                    </div>
	                                    <div class="regi-file">평가위원을 검색하세요</div>
	                                    <div class="regi-file">서면검토서.hwp</div>
	                                    <div class="incell-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록">저장</a></button>
	                                        <button class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
	                                    </div>
	                                </td>
	                                <td class="fix-width date">-</td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가위원 E</td>
	                                <td>
	                                    <input type="text" class="regi-file-input" id="committee5" placeholder="평가위원 검색" value="" readonly>
	                                    <div class="block-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록"><i class="glyphicon glyphicon-search"></i>평가위원검색</a></button>
	                                    </div>
	                                    <div class="regi-file">평가위원을 검색하세요</div>
	                                    <div class="regi-file">서면검토서.hwp</div>
	                                    <div class="incell-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="평가위원 등록">저장</a></button>
	                                        <button class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
	                                    </div>
	                                </td>
	                                <td class="fix-width date">-</td>
	                            </tr> -->
	                        </table>
	
	                        <!-- 조회 모드에서는 제공되지 않습니다. -->
	                        <div class="body-descriptions">
	                            아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">평가실행계획</span>이 등록</strong> 되어 기획평가단 및 관련기관과 공유됩니다.<br>
	                            <strong>평가진행 이력이 존재할 경우 제출취소가 불가</strong>하오니 내용이 정확한지 확인하신 후 제출하시기 바랍니다.<br>
	                        </div>
	
	                        <div class="submit-set">
	                        	<c:if test="${evaluInfo.EVALU_PLAN_YN == 'Y'}">
	                        		<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
	                        			<button type="button" class="evtdss-submit-cancel"><a onclick="submission_btn('N')" title="제출취소">제출취소</a></button>	
	                        		</c:if>
	                        	</c:if>
	                        	<c:if test="${evaluInfo.EVALU_PLAN_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a onclick="submission_btn('Y')" title="제출하기">제출하기</a></button>
	                        	</c:if>
	                            
	                            <!-- 제출이력이 있을 경우 표시 -->
	                            <!-- <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div> -->
	                            <!-- /제출이력이 있을 경우 표시 -->
	                        </div>
	
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
	                        <!-- /조회 모드에서는 제공되지 않습니다. -->
	
	                        <!-- /Contents -->
	                    </div>
	                </div>
	            </div> <!-- /.container -->
	
	        </div>
	    </div>
	
	</div> <!-- /contents-wrap -->
	
	
</form:form>	
			
</div><!-- /contents -->


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


<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>