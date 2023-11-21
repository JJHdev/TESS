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
	<script type="text/javascript" src="/jquery/jstree/_lib/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="/jquery/jstree/_lib/jquery.cookie.js"></script>
	
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/pdfjs-2.2.228-dist/build/pdfobject.min.js"/>'></script>

<style>
.node {
    margin-left: 2px;
}
.pdf-viewer {
  flex: auto; /* 반을 차지하도록 유연성 부여 */
  overflow: hidden; /* PDF가 컨테이너를 넘어가지 않도록 함 */
  height: inherit;
}
#pdfModal {
    /* 기존 스타일 유지 */
    width: 100%;
    height: 100%;
    z-index: 1;
    /* Transition 추가 */
    transition: top 0.2s ease; /* 'top' 속성에 대한 전환을 0.5초 동안 부드럽게 적용 */
}

.custom-modal {
    display: none; /* 기본적으로 숨김 */
    position: fixed; /* 화면에 고정 */
    z-index: 1; /* 다른 요소들 위에 위치 */
    left: 0;
    top: 0;
    width: 100%; /* 전체 너비 */
    height: 100%; /* 전체 높이 */
    overflow: auto; /* 스크롤 가능 */
    background-color: rgb(0,0,0); /* 배경 색 */
    background-color: rgba(0,0,0,0.4); /* 검정색 반투명 배경 */
}

/* 모달 콘텐츠 */
.custom-modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 페이지 중앙에 위치 */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* 너비 */
}

/* 닫기 버튼 */
.custom-close-button {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.custom-close-button:hover,
.custom-close-button:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>

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
    <div id="fileContentArea">
	   	<c:forEach var="entry1" items="${evaluInfo}">
		    <input type="hidden" name="${entry1.key}" value="${entry1.value}" />
		</c:forEach>
		<c:forEach var="entry2" items="${mastMap}">
		    <input type="hidden" name="${entry2.key}" value="${entry2.value}" />
		</c:forEach>
   	</div>
    <input type="hidden" name="regiEvaluCommId"     id="regiEvaluCommId"/>
    
    <div class="contents-wrap" style="background-color:white; margin-bottom: -70px;">
	    <div class="wrapper-2 sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
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
	<!------------------------------------------------------------------->
	<!----------------------------- 평가위원 ------------------------------->
	<!------------------------------------------------------------------->
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
	                                <li class="active"><a onclick="goStep(2);" title="평가의견">평가의견</a></li>
	                                <li class=""><a onclick="goStep(3);" title="종합결과">종합결과</a></li>
	                                <li class=""><a onclick="goStep(5);" title="이행계획서">이행계획서</a></li>
	                                <li class=""><a onclick="goStep(4);" title="평가종료">평가종료</a></li>
	                            </ul>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<div style="display:flex;">	
	
	<%-- ${upFileList.filePath} --%>
	
    	<div class="contents-wrap ix-wrapper scroll-hide" style="width:50%">
			<div class="wrapper sub hg-100p" id="toptop" style="max-width:100%;"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
   				<div class="container hg-100p">
					<div id="pdfModal">
						<p class="section-title">사업설명서</p>
						<c:set var="foundAT02" value="false" />
						<c:if test="${not empty upFileList}">
						    <c:forEach var="file" items="${upFileList}">
						        <c:if test="${file.atthType == 'AT02'}">
						            <c:set var="foundAT02" value="true" />
						            <!-- PDF 뷰어 표시 로직 -->
						            <div class="pdf-viewer">
									    <object data="/comm/pdfPreview.do?fileNo=${file.evaluFileNo}" type="application/pdf" width='100%' height='100%'>
										    <p>PDF 미리보기를 지원하지 않는 브라우저입니다. <a href="/comm/pdfPreview.do">여기</a>를 클릭하여 PDF를 다운로드하세요.</p>
										</object>
									</div>
						        </c:if>
						    </c:forEach>
						</c:if>
						
						<c:if test="${empty upFileList or !foundAT02}">
						    <div class="pdf-viewer">
								<object data='/1/Week01/data/download01/01.pdf#pagemode=thumbs&scrollbar=1&toolbar=1&statusbar=1&messages=1&navpanes=1'  
										type='application/pdf' width='100%' height='100%'>
									<p>This browser does not support inline PDFs. Please download the PDF to view it: <a href="/1/Week01/data/download01/01.pdf">Download PDF</a></p>
								</object>
							</div>
						</c:if>
						<!-- 조건에 따라 다른 처리 -->
					</div>
				</div>
			</div>
		</div>
		
    	<div class="contents-wrap ix-wrapper" style="width:50%">
			<div class="wrapper sub" style="max-width:100%"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
   				<div class="container">
		            
		            <p class="section-title">참조 파일<small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
                    <table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
						<caption class="sr-only">참조파일</caption>
						<colgroup><col/><col/><col/></colgroup>
                       	<thead>
                       	   <tr>
                              <th scope="col" style="width:70%;">구분</th>
                              <th scope="col" style="width:30%;" class="fix-width file">참조파일</th>
                          </tr>
                       </thead>
	                       
                       <c:forEach items="${sysRrencFileList}" varStatus="status" var="flist">
						    <c:if test="${fn:substring(flist.CODE, 3, 4) eq '4' or fn:substring(flist.CODE, 3, 4) eq '5'}">
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
		            
		            
		            <!-- Contents -->
		            <p class="section-title" style="margin-top: 30px">평가의견서 등록<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
		
					<div id="test"></div>
		                  
					<table class="evtdss-form-table">
					    <tr>
					        <th>구분</th>
					        <th>내용</th>
					    </tr>
					    <tr>
					        <td class="fix-width title">
					            <c:if test="${viewCommitStatus.OPINION_NOTE_DATE == null}">
					       	종합의견
					       	<div class="save-date"><span class="txt-heightlight"></span> 저장되지 않음</div>
					       </c:if>
					       <c:if test="${viewCommitStatus.OPINION_NOTE_DATE != null}">
					       	종합의견
					       	<div class="save-date"><span class="txt-heightlight">${viewCommitStatus.OPINION_NOTE_DATE}</span> 저장</div>
					       </c:if>
					   </td>
					   <td>
					       <div class="incell-textarea">
					           <textarea id="opinionNote">${viewCommitStatus.OPINION_NOTE}</textarea>
					           <div class="incell-btn button-set ver">
					               <button type="button" class="inline-button green"><a onclick="saveNote();" title="저장">저장</a></button>
					               <button type="button" class="inline-button green"><a onclick="deltNote();" title="삭제">삭제</a></button>
					            </div>
					        </div>
					    </td>
					</tr>
					<tr>
					    <td class="fix-width title">
					    	<c:if test="${viewCommitStatus.IPM_NOTE_DATE == null}">
					       	개선사항
					       	<div class="save-date"><span class="txt-heightlight"></span> 저장되지 않음</div>
					       </c:if>
					  	 	<c:if test="${viewCommitStatus.IPM_NOTE_DATE != null}">
					       	개선사항
					       	<div class="save-date"><span class="txt-heightlight">${viewCommitStatus.IPM_NOTE_DATE}</span> 저장</div>
					       </c:if>
					   </td>
					   <td>
					       <div class="incell-textarea">
					           <textarea id="ipmNote">${viewCommitStatus.IPM_NOTE}</textarea>
					           <div class="incell-btn button-set ver">
					               <button type="button" class="inline-button green"><a onclick="saveIpm();" title="저장">저장</a></button>
					               <button type="button" class="inline-button green"><a onclick="deltIpm();" title="삭제">삭제</a></button>
					            </div>
					        </div>
					    </td>
					</tr>
					<tr>
					    <td class="fix-width title">
					        	평가결과
					    </td>
					    <td>
					        <strong class="txt-heightlight">[${evaluInfo.EVALU_STAGE_NM}]</strong> <!-- 해당 평가단계 -->
					       <!-- 평가사업관리 > 평가지표 설정 > 평가결과 항목 에서 지정한 배열로 내용구성 -->
					       <label class="incell-radio radio-inline" title="적합">
					       	<c:if test="${viewCommitStatus.OPINION_FND == 'P'}">
					       		<input type="radio" name="opinionFnd" id="evalResult1" value="P" checked>적합
					       	</c:if>
					       	<c:if test="${viewCommitStatus.OPINION_FND != 'P'}">
					       		<input type="radio" name="opinionFnd" id="evalResult1" value="P">적합
					       	</c:if>
					       </label>
					       <label class="incell-radio radio-inline" title="조건부 적합">
					       	<c:if test="${viewCommitStatus.OPINION_FND == 'C'}">
						<input type="radio" name="opinionFnd" id="evalResult2" value="C" checked>조건부 적합
					       	</c:if>
					       	<c:if test="${viewCommitStatus.OPINION_FND != 'C'}">
					       		<input type="radio" name="opinionFnd" id="evalResult2" value="C">조건부 적합
					       	</c:if>
					       </label>
					       <label class="incell-radio radio-inline" title="부적합">
					       	<c:if test="${viewCommitStatus.OPINION_FND == 'F'}">
					       		<input type="radio" name="opinionFnd" id="evalResult3" value="F" checked>부적합
					       	</c:if>
					       	<c:if test="${viewCommitStatus.OPINION_FND != 'F'}">
					       		<input type="radio" name="opinionFnd" id="evalResult3" value="F">부적합
					       	</c:if>
					            </label>
					        </td>
					    </tr>
					</table>
					
					<p class="section-title" style="display:flex; justify-content: space-between;">평가의견서 첨부파일</p>
					<table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
				    	<caption class="sr-only">평가의견서</caption>
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
					            <c:if test="${fileType.CODE eq 'AT07'}">
					                <tr>
					                    <td>
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
				</div>
			</div>
		</div>
	</div>
	
	<div class="contents-wraps ta-center">
		<!-- <div class="body-descriptions">
		    파일명에 <strong>이름 및 소속 등의 개인정보는 반드시 삭제 후 <span class="txt-heightlight">한글(.hwp)</span>파일로 업로드</strong>하여 주시기 바랍니다.<br>
		    <br>
		    아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">평가의견서</span>가 제출</strong>되며 관리자가 승인하기 전에는 제출취소를 통해 철회할 수 있습니다.<br>
		    내용이 정확한지 최종적으로 확인하신 후 진행하시기 바랍니다.<br>
		</div> -->
	        
		<div class="submit-set fixed-div">
			<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
				<button type="button" class="evtdss-submit" onclick="onClickButton('prcBtnSave')" title="제출하기"><a title="제출하기">제출하기</a></button>
				<button type="button" class="evtdss-submit" id="modalBtn"><a title="점수확인">점수확인</a></button>
			</c:if>
			<c:if test="${viewCommitStatus.OPINION_YN == 'Y' && viewCommitStatus.OPINION_APV_YN != 'Y'}">
				<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
			</c:if>
				<div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div>
		</div>
	</div>
	
</form:form>	
	
		<!-- 모달 창 -->
<div id="myModal" class="custom-modal">
    <!-- 모달 콘텐츠 -->
    <div class="custom-modal-content">
		        <span class="custom-close-button">&times;</span>
		        <table class="evtdss-form-table" style="margin-top:50px;">
				    <!-- 테이블 헤더 -->
					<tr>
				        <th rowspan="2">진단항목</th>
				        <th rowspan="2">진단지표</th>
				        <th rowspan="2">진단기준</th>
				        <th colspan="5">배점</th>
				        <th rowspan="2">점수</th>
				    </tr>
					<tr>
				        <th style="width:10%; text-align:center;">미흡</th>
				        <th style="width:10%; text-align:center;">다소미흡</th>
				        <th style="width:10%; text-align:center;">보통</th>
				        <th style="width:10%; text-align:center;">다소우수</th>
				        <th style="width:10%; text-align:center;">우수</th>
				    </tr>
				    <tr>
				        <td rowspan="2">사업 준비도 (50)</td>
				        <td rowspan="2">사전행정 절차 이행여부 (10)</td>
				        <td>부지확보 계획의 타당성 (5)</td>
				        <td colspan="2" style="text-align:center;">3</td>
				        <td style="text-align:center;">4</td>
				        <td colspan="2" style="text-align:center;">5</td>
				        <td rowspan="2" style="text-align:center;">(7)</td>
				    </tr>
				    <tr>
				        <td>관련 인허가 계획의 타당성 (5)</td>
				        <td style="text-align:center;">1</td>
				        <td style="text-align:center;">2</td>
				        <td style="text-align:center;">3</td>
				        <td style="text-align:center;">4</td>
				        <td style="text-align:center;">5</td>
				    </tr>
				    <!-- 다른 진단항목 및 지표에 대한 행들 추가 -->
				    <!-- ... -->
				    <tr>
				        <td>감점 항목</td>
				        <td>중복여부</td>
				        <td>타 사업과의 중복 검토 여부</td>
					    <td colspan="2" style="text-align:center;">-3</td> <!-- 2칸 차지 -->
					    <td style="text-align:center;">-2</td>
					    <td style="text-align:center;">-1</td>
					    <td style="text-align:center;">0</td>
					    <td style="text-align:center;">(-1)</td>
				    </tr>
				    <tr>
				        <td colspan="8">합계</td>
				        <td style="text-align:center;">( 66 )</td>
				    </tr>
				    <!-- 다른 행 추가 -->
				    <!-- ... -->
				    <!-- 판정결과 행 -->
				    <tr>
				        <td colspan="6">적 합 (80점 이상)</td>
				        <td colspan="3">사업의 타당성이 인정되고 정상적인 사업 추진 가능</td>
				    </tr>
				    <tr>
				        <td colspan="6">조건부 적합 (79~60점)</td>
				        <td colspan="3">사업의 타당성은 인정되나 필요조건이 충족되어야 사업 추진 가능</td>
				    </tr>
				    <tr>
				        <td colspan="6">부적합 (60점 미만)</td>
				        <td colspan="3">사업의 타당성 결여로 사업추진이 불합리한 경우</td>
				    </tr>
				</table>
		    </div>
		</div>
	</div> <!-- /contents-wrap -->
</div><!-- /contents -->
	
<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
<!-- 모달 창 트리거 버튼 -->
<script>
	// 모달을 가져옵니다.
	var modal = document.getElementById("myModal");
	
	// 모달을 여는 버튼을 가져옵니다.
	var btn = document.getElementById("modalBtn");
	
	// 모달을 닫는 <span> 요소를 가져옵니다.
	var span = document.getElementsByClassName("custom-close-button")[0];
	
	// 사용자가 버튼을 클릭하면 모달을 엽니다.
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	
	// <span> (x)를 클릭하면 모달을 닫습니다.
	span.onclick = function() {
	    modal.style.display = "none";
	}
	
	// 사용자가 모달 외부를 클릭하면 모달을 닫습니다.
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
</script>
<script>
	$(document).ready(function(){
		function adjustModalPosition() {
			var pdfModal = document.getElementById('pdfModal');
			var windowHeight = window.innerHeight;
			var scrollY = window.scrollY;
			//console.log("scrollY의 높이"+scrollY);
			
			var totalHeight = document.body.scrollHeight
			//console.log('총 높이'+totalHeight);
			
			var footerElement = document.querySelector('footer');
			var footerTopRelative = footerElement.getBoundingClientRect().top;
			var scrollOffset = window.pageYOffset || document.documentElement.scrollTop;
			var footerTopAbsolute = footerTopRelative + scrollOffset;
			//console.log("Footer의 문서 최상단부터의 위치:", footerTopAbsolute);
			
			var pdfModalElement = document.getElementById('pdfModal');
			var pdfModalHeight = pdfModalElement.offsetHeight;
			//console.log("pdfModal의 높이:", pdfModalHeight);
			// 화면 중앙까지의 거리 계산
			var distanceToCenter = (windowHeight / 2) - (pdfModal.offsetHeight / 2);
			if(scrollY + pdfModalHeight  + 50> footerTopAbsolute){
				pdfModal.style.top = -5 + '%';
			} else if (scrollY > 470) {
				var newTop = Math.min(distanceToCenter, scrollY) + 40;
				//console.log('s'+newTop);
				pdfModal.style.top = newTop + 'px';
			} else {
				var newTop = Math.max(0, 530 - scrollY);
				pdfModal.style.top = newTop + 'px';
			} 
		}
		// 스크롤 이벤트 리스너
		//window.addEventListener('scroll', adjustModalPosition);
		// 창 크기 변경 이벤트 리스너
		//window.addEventListener('resize', adjustModalPosition);
	});
</script>
</body>
</html>