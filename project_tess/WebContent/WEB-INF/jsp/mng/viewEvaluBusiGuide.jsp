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
	
	                        <p class="section-title">첨부파일<small class="silent">평가지침 및 참조 파일을 등록합니다.</small></p>
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>구분</th>
	                                <th>서류등록</th>
	                                <th>등록일시</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가지침서</td>
	                                <td>
	                                    <%-- <c:if test="${evaluDocA == null}">
	                                    	<input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT06" id="AT06">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>	
	                                    	<div class="incell-btn button-set hor">
	                                    		<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
		                                        		<button type="button" class="inline-button green"><a onclick="doc_save('AT06');" title="선택파일 추가">저장</a></button>
		                                        	</c:if>
		                                        </c:if>
		                                        <c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
		                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT06');" title="선택파일 추가">저장</a></button>
		                                        </c:if>
		                                    </div>
	                                    </c:if>
	                                    <c:if test="${evaluDocA != null}">
	                                    	<input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT06" id="AT06">
	                                    	<div class="regi-file" rel="Y">${evaluDocA.FILE_ORG_NM}</div>
	                                    	<div class="incell-btn button-set hor">
	                                    		<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
		                                        		<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocA.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                        	</c:if>
		                                        </c:if>
		                                        <c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
		                                        	<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocA.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                        </c:if>
		                                    </div>	
	                                    </c:if> --%>
	                                    
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
	                                    <%-- <c:if test="${evaluDocB == null}">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>
	                                    	<div class="incell-btn button-set hor">
	                                    		<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
		                                        		<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
		                                        	</c:if>
		                                        </c:if>
		                                        <c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
		                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
		                                        </c:if>
		                                    </div>	
	                                    </c:if>
	                                    <c:if test="${evaluDocB != null}">
	                                    	<div class="regi-file" rel="Y">${evaluDocB.FILE_ORG_NM}</div>
	                                    	<div class="incell-btn button-set hor">
	                                    		<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
		                                        		<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocB.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                        	</c:if>
		                                        </c:if>
		                                        <c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
		                                        	<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocB.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                        </c:if>
		                                    </div>		
	                                    </c:if> --%>
	                                    
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
	                                    <%-- <c:if test="${evaluDocC == null}">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>	
	                                    	<div class="incell-btn button-set hor">
	                                    		<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
		                                        		<button type="button" class="inline-button green"><a onclick="doc_save('AT08');" title="선택파일 추가">저장</a></button>
		                                        	</c:if>
		                                        </c:if>
		                                        <c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
		                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT08');" title="선택파일 추가">저장</a></button>
		                                        </c:if>
		                                    </div>	
	                                    </c:if>
	                                    <c:if test="${evaluDocC != null}">
	                                    	<div class="regi-file" rel="Y">${evaluDocC.FILE_ORG_NM}</div>	
	                                    	<div class="incell-btn button-set hor">
	                                    		<c:if test="${evaluInfo.EVALU_GUIDE_YN == 'Y'}">
	                        						<c:if test="${checkStagekHist.AGREE_CHECK == 0}">
		                                    	    	<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocC.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                    	    </c:if>
		                                   		</c:if>
		                                   		<c:if test="${evaluInfo.EVALU_GUIDE_YN != 'Y'}">
		                                   			<button type="button" class="inline-button green"><a onclick="doFileDelete('${evaluDocC.EVALU_FILE_NO}')" title="등록파일 삭제">삭제</a></button>
		                                   		</c:if>
		                                    </div>
	                                    </c:if> --%>
	                                    
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
	
	                        <!-- <p class="section-title">평가지표 설정<small class="silent">최종본이 아닐 수 있으므로 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>구분</th>
	                                <th>내용</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">
	                                    평가항목매칭
	                                    <div class="save-date"><span class="txt-heightlight">2018-09-08 16:18:00</span> 저장</div>
	                                </td>
	                                <td>
	                                    <div class="incell-comp">
	                                        <div class="incell-comp-wrap">
	                                            기존 평가지표 관리기능 삽입
	                                        </div>
	                                        <div class="incell-btn button-set ver">
	                                            <button class="inline-button green"><a href="#" title="저장">저장</a></button>
	                                            <button class="inline-button green"><a href="#" title="삭제">삭제</a></button>
	                                        </div>
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">
	                                    결과활용
	                                    <div class="save-date"><span class="txt-heightlight"></span> 저장되지 않음</div>
	                                </td>
	                                <td>
	                                    <p>‘|’&nbsp;구분자로 구분하여 항목을 작성하세요. <small class="txt-heightlight">예시) 적합|조건부 적합|부적합</small></p>
	                                    <div class="incell-text-withbtn">
	                                        <input type="text" class="input-text" placeholder="평가결과 항목입력" value="">
	                                        <p>현재설정 : <strong><span class="txt-heightlight">적합, 조건부 적합, 부적합</span></strong></p>
	                                        <div class="incell-btn button-set ver">
	                                            <button class="inline-button green"><a href="#" title="저장">저장</a></button>
	                                            <button class="inline-button green"><a href="#" title="삭제">삭제</a></button>
	                                        </div>
	                                    </div>
	                                </td>
	                            </tr>
	                        </table> -->
	                        <!-- 조회 모드에서는 제공되지 않습니다. -->
	                        <div class="body-descriptions">
	                            아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">평가지침</span>이 등록</strong> 되어 기획평가단 및 관련기관과 공유됩니다.<br>
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
	                        		<button type="button" class="evtdss-submit"><a onclick="submission_btn('Y');" title="제출하기">제출하기</a></button>
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



<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->


<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>