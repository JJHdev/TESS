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
	<script type="text/javascript" src='<c:url value="/jquery/jstree/jquery.jstree.js"/>'></script>
	<script type="text/javascript" src='<c:url value="/jquery/jstree/_lib/jquery.hotkeys.js"/>'></script>
	<script type="text/javascript" src='<c:url value="/jquery/jstree/_lib/jquery.cookie.js"/>'></script>
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
    <div id="fileContentArea">
	   	<c:forEach var="entry1" items="${evaluInfo}">
		    <input type="hidden" name="${entry1.key}" value="${entry1.value}" />
		</c:forEach>
		<c:forEach var="entry2" items="${mastMap}">
		    <input type="hidden" name="${entry2.key}" value="${entry2.value}" />
		</c:forEach>
	</div>
    <input type="hidden" name="regiEvaluCommId"     id="regiEvaluCommId"/>
    <div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
            	<div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>평가사업조회</li>
	                    <li>${evaluInfo.prgrGubunNmHist} ${evaluInfo.evaluStageNmHist}</li>
	                    <li>${mastMap.evaluBusiNmInfo}</li>
	                </ul>
            	</div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">${evaluInfo.prgrGubunNmHist} ${evaluInfo.evaluStageNmHist}</h3>
	                </div>
	            </div>

	            <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	                <div class="shade"></div>
	                <div class="project-title">
	                    <h2>${mastMap.evaluBusiNmInfo}</h2>
	                    <p>${evaluInfo.busiAddr1NmHist} / ${evaluInfo.prgrGubunNmHist} ${evaluInfo.evaluStageNmHist}</p>
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
	                                <td colspan="3"><input type="text" name="PLANEVAL_BUSI_NAME"  id="PLANEVAL_BUSI_NAME"  readonly="readonly" style="width: -webkit-fill-available;"value='<c:out value="${mastMap.evaluBusiNmInfo}"/>'/></td>
	                            </tr>
	                            <tr>
	                            	<th class="fix-width title">지방자치단체</th>
	                            	<td><input type="text" name="busiAddress1"  id="busiAddress1" readonly="readonly"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiTypeLevel1NmInfo}"/>'/></td>
	                            	<th class="fix-width title">담당부서</th>
	                            	<td><input type="text" name="gsDeptNm"  id="gsDeptNm" readonly="readonly"  style="width: -webkit-fill-available;"value='<c:out value="${paramMap.gsDeptNm}"/>'/></td>
	                            </tr>
	                            <tr>
	                            	<th class="fix-width title">담당자</th>
	                            	<td><input type="text" name="gsUserNm"  id="gsUserNm" readonly="readonly"  style="width: -webkit-fill-available;"value='<c:out value="${paramMap.gsUserNm}"/>'/></td>
	                            	<th class="fix-width title">전화번호</th>
	                            	<td><input type="text" name="gsTelNo"  id="gsTelNo" readonly="readonly"  style="width: -webkit-fill-available;"value='<c:out value="${paramMap.gsTelNo}"/>'/></td>
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
	                        <table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
								<caption class="sr-only">첨부파일</caption>
								<colgroup><col/><col/><col/></colgroup>
		                        <thead>
		                        	<tr>
		                                <th scope="col" style="width:70%;">구분</th>
		                                <th scope="col" style="width:30%;" class="fix-width file">첨부파일</th>
		                            </tr>
		                        </thead>
		                        
		                        <c:forEach items="${sysRrencFileList}" varStatus="status" var="flist">
								    <c:if test="${fn:substring(flist.CODE, 3, 4) eq '2'}">
								        <tr>
								            <td><c:out value="${flist.addColNm2} ${flist.CODE_NM}"/></td>
								            <td class="fix-width file">
								                <a href="<c:out value='/comm/fileDownloadSample.do?fileNo=${flist.CODE}'/>">
								                    <c:out value="${flist.CODE_NM}"/>
								                </a>
								            </td>
								        </tr>
								    </c:if>
								</c:forEach>
                           	</table>
	                        
	                        <p class="section-title" style="display:flex; justify-content: space-between;">이행계획서 제출</p>
							<table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
							    <caption class="sr-only">이행계획서 제출</caption>
							    <thead>
							        <tr>
							            <th>구분</th>
							            <th class="fix-width file">파일 업로드</th>
							            <th class="fix-width file">첨부파일</th>
							            <th class="fix-width file">첨부파일 삭제</th>
							        </tr>
							    </thead>
							    <tbody id="tableBody">
							        <c:forEach items="${sysUldFileList}" var="fileType">
							            <c:if test="${fileType.CODE eq 'AT09'}">
							                <tr>
							                    <td>
							                    	<c:if test="${fileType.CODE eq 'AT09'}" >
									                    <span class="special-dot">*</span>
							                    	</c:if>
								                    ${fileType.CODE_NM}
								                </td>
							                    <td>
							                        <c:set var="fileExists" value="false"/>
							                        <c:forEach var="fileInfo" items="${upFileList}">
							                            <c:if test="${fileInfo.atthType eq fileType.CODE}">
							                                <c:set var="fileExists" value="true"/>
							                            </c:if>
							                        </c:forEach>
							                        <c:if test="${!fileExists}">
							                            <input type="file" class="regi-file-input" id="upfile${fileType.CODE}">
							                        </c:if>
							                    </td>
							                    <td class="fix-width file">
							                        <c:forEach var="fileInfo" items="${upFileList}">
							                            <c:if test="${fileInfo.atthType eq fileType.CODE}">
							                                <a href="/busi/fileDownload.do?rootNo=${evaluInfo.evaluHistSnHist}&atthType=${fileType.CODE}">
							                                    <c:out value="${fileInfo.fileOrgNm}"/>
							                                </a>
							                            </c:if>
							                        </c:forEach>
							                    </td>
							                    <td>
							                        <c:if test="${fileExists}">
							                            <div class="submit-set">
							                                <button type="button" class="evtdss-submit" onclick="onClickButton('upfile${fileType.CODE}')" ><a title="파일삭제">삭제</a></button>
							                            </div>
							                        </c:if>
							                    </td>
							                </tr>
							            </c:if>
							        </c:forEach>
							    </tbody>
							</table>
	                        <div class="submit-set">
	                        	<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit" onclick="onClickButton('prcBtnSave')" title="이행계획서 제출"><a title="이행계획서 제출">이행계획서 제출</a></button>
	                        	</c:if>
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