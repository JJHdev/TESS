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
	                    <li>평가사업조회</li>
	                    <li>${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</li>
	                    <li>${evaluInfo.PLANEVAL_BUSI_NAME}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</h3>
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
	                        <li class=""><a onclick="goBusiInfo();" title="사업정보">사업정보</a></li>
	                        <li class="active"><a title="평가정보">평가정보</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/busi/listEvaluBusi.do" title="목록으로"><</a></div>
	                </div>
	            </div>

	<!------------------------------------------------------------------->
	<!------------------------------------------------------------------->
	<!----------------------------- 평가위원 ------------------------------->
	<!------------------------------------------------------------------->
	<!------------------------------------------------------------------->
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">평가정보</h4>
								<a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	
	                        <div class="tab-wrap">
	                            <ul class="tab-steps">
	                                <li class=""><a onclick="goStep(1);" title="서면검토">서면검토</a></li>
	                                <li class=""><a onclick="goStep(2);" title="평가의견">평가의견</a></li>
	                                <li class="active"><a onclick="goStep(3);" title="종합결과">종합결과</a></li>
	                                <li class=""><a onclick="goStep(5);" title="이행계획서">이행계획서</a></li>
	                                <li class=""><a onclick="goStep(4);" title="평가종료">평가종료</a></li>
	                            </ul>
	                        </div>
	                        <!-- Contents -->
	
	                        <p class="section-title">종합결과서 제출<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
	
	                        <!-- 관리자 전용 -->
	                        <div class="select-committee">
	                            <ul>
	                                <li class="active"><a href="#" title="평가위원 A">평가위원 A (홍길동)</a></li>
	                                <li class=""><a href="#" title="평가위원 B">평가위원 B (강감찬)</a></li>
	                                <li class=""><a href="#" title="평가위원 C">평가위원 C (유관순)</a></li>
	                            </ul>
	                        </div>
	                        
	                        <!-- /관리자 전용 -->
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>구분</th>
	                                <th>서류등록</th>
	                                <th>등록일시</th>
	                                <th>진행</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">종합결과서</td>
	                                <td>
	                                    <input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT13" id="AT13">
	                                    <c:if test="${fileInfo == null}">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>
	                                    	<div class="incell-btn button-set hor">
		                                        <button type="button" class="inline-button green"><a onclick="doc_save('AT13');" title="선택파일 추가">저장</a></button>
		                                    </div>
	                                    </c:if>
	                                    <c:if test="${fileInfo != null}">
	                                    	<div class="regi-file" rel="Y" fileNo="${fileInfo.EVALU_FILE_NO}">${fileInfo.FILE_ORG_NM}</div>
	                                    	<div class="incell-btn button-set hor">
		                                        <button type="button" class="inline-button green"><a onclick="doFileDelete('${totalResultMap.TOTAL_RESULT_YN}')" title="등록파일 삭제">삭제</a></button>
		                                    </div>
	                                    </c:if>
	                                    <div class="regi-file">서면검토서.hwp</div>
	                                </td>
	                                <td class="fix-width date">${fileInfo.REGI_DATE}</td>
	                                <td class="fix-width file">미제출</td> <!-- 평가위원용 : 미제출/제출/승인 문구 표기 -->
	                                <!-- 관리자용 : 미제출/승인버튼 -->
	                                <td class="fix-width file">
	                                    <!-- 미제출 -->
	                                    <div class="button-set hor">
	                                        <button class="inline-button confirm"><a href="#" title="승인처리">승인</a></button>
	                                        <c:if test="${totalResultMap.TOTAL_RESULT_YN != 'Y'}">
	                                        	미제출
	                                        </c:if>
	                                        <c:if test="${totalResultMap.TOTAL_RESULT_YN == 'Y'}">
	                                        	제출
	                                        </c:if>
	                                    </div>
	                                </td>
	                            </tr>
	                        </table>
	                        
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>구분</th>
	                                <th>내용</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">
	                                	<c:if test="${evaluInfo.FINAL_EVALU_FND_NOTE == null}">
	                                    	종합의견
	                                    	<div class="save-date"><span class="txt-heightlight"></span> 저장되지 않음</div>
	                                    </c:if>
	                                    <c:if test="${evaluInfo.FINAL_EVALU_FND_NOTE != null}">
	                                    	종합의견
	                                    	<%-- <div class="save-date"><span class="txt-heightlight">${evaluInfo.OPINION_NOTE_DATE}</span> 저장</div> --%>
	                                    </c:if>
	                                </td>
	                                <td>
	                                    <div class="incell-textarea">
	                                        <textarea id="finalFndNote">${evaluInfo.FINAL_EVALU_FND_NOTE}</textarea>
	                                        <div class="incell-btn button-set ver">
	                                            <button type="button" class="inline-button green"><a onclick="saveNote();" title="저장">저장</a></button>
	                                            <button type="button" class="inline-button green"><a onclick="deltNote();" title="삭제">삭제</a></button>
	                                        </div>
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">
	                                	<c:if test="${evaluInfo.FINAL_EVALU_IPM_NOTE == null}">
	                                    	개선사항
	                                    	<div class="save-date"><span class="txt-heightlight"></span> 저장되지 않음</div>
	                                    </c:if>
	                                    <c:if test="${evaluInfo.FINAL_EVALU_IPM_NOTE != null}">
	                                    	개선사항
	                                    	<div class="save-date"><span class="txt-heightlight">${evaluInfo.OPINION_NOTE_DATE}</span> 저장</div>
	                                    </c:if>
	                                    	개선사항
	                                    	<div class="save-date"><span class="txt-heightlight"></span> 저장되지 않음</div>
	                                </td>
	                                <td>
	                                    <div class="incell-textarea">
	                                        <textarea id="finalIpmNote">${evaluInfo.FINAL_EVALU_IPM_NOTE}</textarea>
	                                        <div class="incell-btn button-set ver">
	                                            <button type="button" class="inline-button green"><a onclick="saveIpm();" title="저장">저장</a></button>
	                                            <button type="button" class="inline-button green"><a onclick="deltIpm();" title="삭제">삭제</a></button>
	                                        </div>
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">평가결과서</td>
	                                <td>
	                                	<input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT13" id="AT13">
	                                    <c:if test="${fileInfo == null}">
	                                    	<div class="regi-file" rel="N">등록파일 없음</div>
	                                    	<div class="incell-btn button-set hor">
		                                        <button type="button" class="inline-button green"><a onclick="doc_save('AT13');" title="선택파일 추가">저장</a></button>
		                                    </div>
	                                    </c:if>
	                                    <c:if test="${fileInfo != null}">
	                                    	<div class="regi-file" rel="Y" fileNo="${fileInfo.EVALU_FILE_NO}"><a href="/evalu/evaluFileDownload.do?EvaluFileNo=${fileInfo.EVALU_FILE_NO}">${fileInfo.FILE_ORG_NM}</a></div>
	                                    	<div class="incell-btn button-set hor">
		                                        <button type="button" class="inline-button green"><a onclick="doFileDelete('${totalResultMap.TOTAL_RESULT_YN}')" title="등록파일 삭제">삭제</a></button>
		                                    </div>
	                                    </c:if>
	                                    <input type="file" class="regi-file-input" id="upFile1">
	                                    <div class="regi-file">등록파일 없음</div>
	                                    <div class="regi-file">서면검토서.hwp</div>
	                                    <div class="incell-btn button-set hor">
	                                        <button class="inline-button green"><a href="#" title="선택파일 추가">저장</a></button>
	                                        <button class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
	                                    </div>
	                                </td>
	                            </tr>
	                            
	                            <c:if test="${evaluInfo.EVALU_STAGE == 'EVALU_PREV' || evaluInfo.EVALU_STAGE == 'EVALU_PROG'}">
	                            	<tr>
		                                <td class="fix-width title">
		                                   	 평가결과
		                                </td>
		                                <td>
		                                    <strong class="txt-heightlight">[${evaluInfo.EVALU_STAGE_NM}]</strong> <!-- 해당 평가단계 -->
		
		                                    <!-- 평가사업관리 > 평가지표 설정 > 평가결과 항목 에서 지정한 배열로 내용구성 -->
		                                    
		                                    <label class="incell-radio radio-inline" title="적합">
		                                    	<c:if test="${evaluInfo.FINAL_EVALU_FND == 'P'}">
		                                    		<input type="radio" name="finalFnd" id="evalResult1" value="P" checked>적합
		                                    	</c:if>
		                                    	<c:if test="${evaluInfo.FINAL_EVALU_FND != 'P'}">
		                                    		<input type="radio" name="finalFnd" id="evalResult1" value="P">적합
		                                    	</c:if>
		                                    </label>
		                                    <label class="incell-radio radio-inline" title="조건부 적합">
		                                    	<c:if test="${evaluInfo.FINAL_EVALU_FND == 'C'}">
					                         		<input type="radio" name="finalFnd" id="evalResult2" value="C" checked>조건부 적합
		                                    	</c:if>
		                                    	<c:if test="${evaluInfo.FINAL_EVALU_FND != 'C'}">
		                                    		<input type="radio" name="finalFnd" id="evalResult2" value="C">조건부 적합
		                                    	</c:if>
		                                    </label>
		                                    <label class="incell-radio radio-inline" title="부적합">
		                                    	<c:if test="${evaluInfo.FINAL_EVALU_FND == 'F'}">
		                                    		<input type="radio" name="finalFnd" id="evalResult3" value="F" checked>부적합
		                                    	</c:if>
		                                    	<c:if test="${evaluInfo.FINAL_EVALU_FND != 'F'}">
		                                    		<input type="radio" name="finalFnd" id="evalResult3" value="F">부적합
		                                    	</c:if>
		                                    </label>
		                                </td>
		                            </tr>
	                            </c:if>
	                        </table>
	
	                        <div class="body-descriptions">
	                            파일명에 <strong>이름 및 소속 등의 개인정보는 반드시 삭제 후 <span class="txt-heightlight">한글(.hwp)</span>파일로 업로드</strong>하여 주시기 바랍니다.<br>
	                            <br>
	                            아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">종합결과서</span>가 제출</strong>되며 관리자가 승인하기 전에는 제출취소를 통해 철회할 수 있습니다.<br>
	                            내용이 정확한지 최종적으로 확인하신 후 진행하시기 바랍니다.<br>
	                        </div>
	
	                        <div class="submit-set">
	                        	<c:if test="${totalResultMap.TOTAL_RESULT_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="제출하기">제출하기</a></button>
	                        	</c:if>
	                        	<c:if test="${totalResultMap.TOTAL_RESULT_YN == 'Y'}">
	                        		<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
	                        	</c:if>
	                            
	                            <!-- 제출이력이 있을 경우 표시 -->
	                            <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div>
	                            <!-- /제출이력이 있을 경우 표시 -->
	                        </div>
	                    </div>
	                        <!-- /Contents -->
                    </div>
            	</div> <!-- /.container -->
			</form:form>
		</div> <!-- /contents-wrap -->
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