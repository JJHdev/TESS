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
        <input type="hidden" name="srchEvaluBusiNm" id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
        <input type="hidden" name="srchBusiStage"  	id="srchBusiStage"  value='<c:out value="${paramMap.srchBusiStage}"/>'/>
        <input type="hidden" name="srchEvaluDate"  	id="srchEvaluDate"  value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
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
	<!----------------------------- 평가위원 ------------------------------->
	<!------------------------------------------------------------------->
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">평가정보</h4>
	                            <a href="#" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
	                        </div>
	                        
	                        <div class="tab-wrap">
	                            <ul class="tab-steps">
	                                <li class=""><a onclick="goStep(1);" title="서면검토">서면검토</a></li>
	                                <li class=""><a onclick="goStep(2);" title="평가의견">평가의견</a></li>
	                                <li class=""><a onclick="goStep(3);" title="종합결과">종합결과</a></li>
	                                <li class="active"><a onclick="goStep(5);" title="이행계획서">이행계획서</a></li>
	                                <li class="" style="background-color:#5f5f5f;"><a title="평가종료" style="cursor:no-drop;">평가종료</a></li>
	                            </ul>
	                        </div>
	                        
	                        <p class="section-title">이행계획서<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
							<table class="evtdss-form-table">
	                        	<tr>
	                                <th rowspan="3" style="width: 110px">개요</th>
	                                <th>사업명</th>
	                                <td colspan="3"><input type="text" name="PLANEVAL_BUSI_NAME"  id="PLANEVAL_BUSI_NAME"  style="width: -webkit-fill-available;"value='<c:out value="${evaluInfo.PLANEVAL_BUSI_NAME}"/>'/></td>
	                            </tr>
	                            <tr>
	                            	<th class="fix-width title">지방자치단체</th>
	                            	<td><input type="text" name="busiAddress1"  id="busiAddress1"  style="width: -webkit-fill-available;"value='<c:out value="${evaluInfo.busiAddress1}"/>'/></td>
	                            	<th class="fix-width title">담당부서</th>
	                            	<td><input type="text" name="gsDeptNm"  id="gsDeptNm"  style="width: -webkit-fill-available;"value='<c:out value="${paramMap.gsDeptNm}"/>'/></td>
	                            </tr>
	                            <tr>
	                            	<th class="fix-width title">담당자</th>
	                            	<td><input type="text" name="gsUserNm"  id="gsUserNm"  style="width: -webkit-fill-available;"value='<c:out value="${paramMap.gsUserNm}"/>'/></td>
	                            	<th class="fix-width title">전화번호</th>
	                            	<td><input type="text" name="gsTelNo"  id="gsTelNo"  style="width: -webkit-fill-available;"value='<c:out value="${paramMap.gsTelNo}"/>'/></td>
	                            </tr>
	                        </table> 
	                        
	                        <table class="evtdss-form-table">
							    <tr>
							        <th colspan="5">결과 및 이행계획</th>
							    </tr>
							    <tr>
							        <th style="width:10%;">개선방안</th>
							        <td colspan="4">
							            <div class="incell-textarea">
							                <textarea id="opinionNote1" style="width:105%">${viewCommitStatus.OPINION_NOTE}</textarea>
							            </div>
							        </td>
							    </tr>
							    <tr>
							        <th>이행계획</th>
							        <td colspan="4">
							            <div class="incell-textarea">
							                <textarea id="implementationPlan" style="width:105%">${viewCommitStatus.IMPLEMENTATION_PLAN}</textarea>
							            </div>
							        </td>
							    </tr>
							    <tr>
							        <th>이행일정</th>
							        <td colspan="4">
							            <div class="incell-textarea">
							                <textarea id="implementationSchedule" style="width:105%">${viewCommitStatus.IMPLEMENTATION_SCHEDULE}</textarea>
							            </div>
							        </td>
							    </tr>
							    <tr>
							        <th>담당자</th>
							        <td colspan="4">
							            <div class="incell-textarea">
							                <textarea id="personInCharge" style="width:105%">${viewCommitStatus.PERSON_IN_CHARGE}</textarea>
							            </div>
							        </td>
							    </tr>
							</table>
	                        <p class="section-title">이행계획서 참조파일<small class="silent">아래 첨부파일을 다운로드하여 참고하세요</small></p>
	                        <table class="evtdss-form-table noMargin">
	                            <tr>
	                                <th>구분</th>
	                                <th class="fix-width file">첨부파일</th>
	                                <th class="fix-width date">등록일시</th>
	                            </tr>
	                            <tr>
	                                <td>이행계획서 샘플</td>
	                                <c:if test="${evaluDocC == null}">
	                                	 <td class="fix-width file"><a href="#" class="사업설명서"><img src="../../../images/icon_file_hwp.jpg"></a></td>
		                                <td class="fix-width date">2023.10.23</td>
	                                </c:if>
	                                <c:if test="${evaluDocC != null}">
	                                	<td class="fix-width file">
		                                    <a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocC.EVALU_FILE_NO}" title="평가의견서 샘플"><img src="../../../images/icon_file_hwp.jpg"></a>
		                                </td>
		                                <td class="fix-width date">${evaluDocC.REGI_DATE}</td>
	                                </c:if>
	                            </tr>
	                            <tr>
	                                <td>${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM} 이행계획서 지침서</td>
	                                <c:if test="${evaluDocA == null}">
	                                	<td class="fix-width file">
		                                    <a title=" 이행계획서 지침서"></a>
		                                </td>
		                                <td class="fix-width date"></td>
	                                </c:if>
	                                <c:if test="${evaluDocA != null}">
	                                	<td class="fix-width file">
		                                    <a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocA.EVALU_FILE_NO}" title="평가지침서 샘플"><img src="../../../images/icon_file_hwp.jpg"></a>
		                                </td>
		                                <td class="fix-width date">${evaluDocA.REGI_DATE}</td>
	                                </c:if>
	                            </tr>
	                        </table>
	                        
	                        <p class="section-title" style="margin-top:50px;">이행계획서 제출<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
	                        <!-- /관리자 전용 -->
	                        <table class="evtdss-form-table">
	                            <tr>
	                                <th>구분</th>
	                                <th>서류등록</th>
	                                <th>등록일시</th>
	                                <th>진행</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">이행계획서</td>
	                                <td>
	                                    <input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT12" id="AT12">
	                                    <c:choose>
										    <c:when test="${fileInfo == null}">
										        <div class="regi-file" rel="N">등록파일 없음</div>
										        <div class="incell-btn button-set hor">
										            <button type="button" class="inline-button green">
										                <a onclick="doc_save('AT12');" title="선택파일 추가">저장</a>
										            </button>
										        </div>
										    </c:when>
										    <c:otherwise>
										        <div class="regi-file" rel="Y" fileNo="${fileInfo.EVALU_FILE_NO}">${fileInfo.FILE_ORG_NM}</div>
										        <div class="incell-btn button-set hor">
										            <button type="button" class="inline-button green">
										                <a onclick="doFileDelete('${viewCommitStatus.REVIEW_YN}')" title="등록파일 삭제">삭제</a>
										            </button>
										        </div>
										    </c:otherwise>
										</c:choose>
	                                    <div class="regi-file">이행계획서 양식.hwp</div>
	                                </td>
	                                <td class="fix-width date">${fileInfo.REGI_DATE}</td>
	                                <td class="fix-width file">미제출</td>  <!-- 평가위원용 : 미제출/제출/승인 문구 표기 -->
	                                <!-- 관리자용 : 미제출/승인버튼 -->
	                            </tr>
	                        </table>
		                        
	                        <div class="submit-set">
	                        	<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="제출하기">제출하기</a></button>
	                        	</c:if>
	                        	<c:if test="${viewCommitStatus.OPINION_YN == 'Y' && viewCommitStatus.OPINION_APV_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
	                        	</c:if>
	                            <!-- 제출이력이 있을 경우 표시 -->
	                            <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div>
	                            <!-- /제출이력이 있을 경우 표시 -->
	                        </div>
	                    </div>
	                </div>
	            </div>
	       </div>
	   </div>
	</div>
	</form:form>
	</div>
</div>

                        
	                        



<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />

</body>
</html>