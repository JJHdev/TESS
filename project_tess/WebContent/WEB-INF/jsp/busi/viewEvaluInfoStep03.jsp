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
    margin-left: 20px;
}
/* 전체 테이블 스타일 */
.evtdss-form-table {
    width: 100%;
    border-collapse: collapse; /* 셀 간격 없애기 */
}

.evtdss-form-table th,
.evtdss-form-table td {
    border: 1px solid #ddd; /* 경계선 스타일 */
    padding: 8px; /* 패딩 설정 */
    text-align: left; /* 왼쪽 정렬 */
}

/* 제목 및 점수 스타일 */
.evtdss-form-table th {
    color: #000;
    font-weight: bold; /* 굵은 글씨 */
}

/* 판단의견과 개선사항을 위한 스타일 */
.content-box td {
    background-color: #f9f9f9; /* 배경색 */
    padding: 15px; /* 패딩 설정 */
    line-height: 1.6; /* 줄 간격 */
}

/* 판단의견과 개선사항의 제목 스타일 */
.content-title {
    font-weight: bold; /* 굵은 글씨 */
    margin-bottom: 10px; /* 아래쪽 마진 */
    display: block; /* 블록 요소로 표시 */
}
</style>
<style>

.content-container {
  display: flex; /* Flexbox를 사용하여 PDF와 테이블을 나란히 배치 */
  width: 100%; /* 모달 컨텐츠의 전체 너비를 사용 */
}

.pdf-viewer {
  flex: auto; /* 반을 차지하도록 유연성 부여 */
  overflow: hidden; /* PDF가 컨테이너를 넘어가지 않도록 함 */
  height: inherit;
}

#pdf-viewer {
  width: 100%;
  overflow-y: scroll;
  background: #fff;
  padding: 20px;
  box-sizing: border-box;
}

#pdf-viewer canvas {
  width: 100%; /* 캔버스 너비를 컨테이너에 맞춥니다. */
  border-bottom: 1px solid #ccc; /* 페이지 간 구분선 추가 */
  margin-bottom: 20px; /* 페이지 간 간격 추가 */
  page-break-after: always; /* 인쇄 시 페이지 구분 */
}
canvas {
  width: 100%; /* 캔버스 너비를 컨테이너에 맞춥니다. */
  border-bottom: 1px solid #ccc; /* 페이지 간 구분선 추가 */
  margin-bottom: 20px; /* 페이지 간 간격 추가 */
}
.modal-content{
  border-radius: 26px;
}
#pdfModal {
    /* 기존 스타일 유지 */
    position: fixed;
    top: 530px;
    left: 30px;
    width: 45%;
    height: 70%;
    z-index: 100;
    
    /* Transition 추가 */
    transition: top 0.4s ease; /* 'top' 속성에 대한 전환을 0.5초 동안 부드럽게 적용 */
/* } */

</style>
					
<script>
function adjustModalPosition() {
    var pdfModal = document.getElementById('pdfModal');
    var windowHeight = window.innerHeight;
    var scrollY = window.scrollY;
    var documentHeight = document.documentElement.scrollHeight;

    // 화면 중앙까지의 거리 계산
    var distanceToCenter = (windowHeight / 2) - (pdfModal.offsetHeight / 2);

    // 스크롤이 맨 아래에 도달했는지 확인
    var scrollBottom = documentHeight - windowHeight;
    var nearBottom = scrollBottom - 100; // 100px은 조정 가능

    if (scrollY >= scrollBottom) {
        pdfModal.style.top = '-20%';
    } else if (scrollY > nearBottom) {
        var newTop = distanceToCenter - ((scrollY - nearBottom) * (100 / (scrollBottom - nearBottom)));
        pdfModal.style.top = newTop + 'px';
    } else if (scrollY > 450) {
        var newTop = Math.min(distanceToCenter, scrollY - 530 + 530);
        pdfModal.style.top = newTop + 'px';
    } else {
        var newTop = Math.max(0, 530 - scrollY);
        pdfModal.style.top = newTop + 'px';
    }
}

// 스크롤 이벤트 리스너
window.addEventListener('scroll', adjustModalPosition);

// 창 크기 변경 이벤트 리스너
window.addEventListener('resize', adjustModalPosition);
</script>
	

	
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
    
    <div class="contents-wrap" style="background-color:white; margin-bottom: -70px;">
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
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
	    var pdfViewer = document.querySelector('.modal-content');
	    var table = document.querySelector('.evtdss-form-table');
	    var pdfPreviewCell = document.getElementById('pdfPreviewCell');
	    var opinionCell = document.getElementById('opinionCell');
	
	    // PDF미리보기 클릭 이벤트
	    document.getElementById('pdfPreviewLink').addEventListener('click', function(event) {
	        event.preventDefault();
	        pdfViewer.style.display = 'block'; // PDF 뷰어 표시
	        table.style.display = 'none'; // 테이블 숨김
	        pdfPreviewCell.style.backgroundColor = '#38b6ab'; // 배경색 변경
	        pdfPreviewCell.firstElementChild.style.color = 'white'; // 글꼴 색상 변경
	        opinionCell.style.backgroundColor = ''; // 다른 셀 배경색 제거
	        opinionCell.firstElementChild.style.color = ''; // 다른 셀 글꼴 색상 제거
	    });
	
	    // 평가의견서 클릭 이벤트
	    document.getElementById('opinionLink').addEventListener('click', function(event) {
	        event.preventDefault();
	        pdfViewer.style.display = 'none'; // PDF 뷰어 숨김
	        table.style.display = 'table'; // 테이블 표시
	        opinionCell.style.backgroundColor = '#38b6ab'; // 배경색 변경
	        opinionCell.firstElementChild.style.color = 'white'; // 글꼴 색상 변경
	        pdfPreviewCell.style.backgroundColor = ''; // 다른 셀 배경색 제거
	        pdfPreviewCell.firstElementChild.style.color = ''; // 다른 셀 글꼴 색상 제거
	    });
	});
    </script>
    
	<div style="display:flex;">	
    	<div class="contents-wrap" style="width:50%">
			<div class="wrapper sub" style="max-width:100%; background-color: #EDEEEE;"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
				<table border="1" style="width: 100%; text-align: center;">
				    <tr>
				        <td colspan="2" style="background-color:#38b6ab;"><a href="#" title="평가위원 A" style="color:white;">평가위원 A (홍길동)</a></td>
				        <td colspan="2"><a href="#" title="평가위원 B">평가위원 B (강감찬)</a></td>
				        <td colspan="2"><a href="#" title="평가위원 C">평가위원 C (유관순)</a></td>
				    </tr>
				    <tr>
				        <td colspan="3" id="pdfPreviewCell" style="background-color:#38b6ab;"><a href="#" id="pdfPreviewLink" style="color:white;" title="평가위원 A">PDF미리보기</a></td>
				        <td colspan="3" id="opinionCell"><a href="#" id="opinionLink" title="평가위원 B">평가의견서</a></td>
				    </tr>
				</table>
				
				<table class="evtdss-form-table" style="margin-top:50px;  display: none;">
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
				
				<!-- --------------------------------------------------------------------------------------------------------------------------- -->
                
   				<div class="container">
					<div class="modal-content" style="margin: 3% auto;">
						<div class="content-container">
							<div class="pdf-viewer">
								<object data='/1/Week01/data/download01/01.pdf#pagemode=thumbs&scrollbar=1&toolbar=1&statusbar=1&messages=1&navpanes=1'  type='application/pdf' width='100%' height='100%'>
									<p>This browser does not support inline PDFs. Please download the PDF to view it: <a href="/1/Week01/data/download01/01.pdf">Download PDF</a></p>
								</object>
							</div>
						</div>
					</div>
				</div>
				
				
				
				
			</div>
		</div>
		
		
		
    	<div class="contents-wrap" style="width:50%">
			<div class="wrapper sub" style="max-width:100%"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
   				<div class="container">
    
    
	<!------------------------------------------------------------------->
	<!----------------------------- 평가위원 ------------------------------->
	<!------------------------------------------------------------------->
	<!------------------------------------------------------------------->
	            <div class="container b-section" style="margin-top: 10px;">
	                <div class="row">
	                    <div class="col-md-12">
	                        <!-- Contents -->
	
	                        <p class="section-title">종합결과서 제출<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
	
	                       <%--  <!-- 관리자 전용 -->
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
	                                <th>미리보기</th>
	                            </tr>
	                            <tr>
	                                <td class="fix-width title">종합결과서</td>
	                                <td>
	                                    <c:if test="${fileInfo != null}">
	                                    	<div class="regi-file" rel="Y" fileNo="${fileInfo.EVALU_FILE_NO}">${fileInfo.FILE_ORG_NM}</div>
	                                    	<div class="incell-btn button-set hor">
		                                        <button type="button" class="inline-button green"><a onclick="doFileDelete('${totalResultMap.TOTAL_RESULT_YN}')" title="등록파일 삭제">삭제</a></button>
		                                    </div>
	                                    </c:if>
	                                    <div class="regi-file" style="float:right;">서면검토서.hwp</div>
	                                </td>
	                                <td class="fix-width date">${fileInfo.REGI_DATE}</td>
	                                <!-- 관리자용 : 미제출/승인버튼 -->
	                                <td class="fix-width file">
	                                    <!-- 미제출 -->
	                                    <div class="button-set hor">
	                                        <button class="inline-button confirm" id="preview-pdf-btn"><a href="#" title="미리보기">미리보기</a></button>
	                                    </div>
	                                </td>
	                            </tr>
	                        </table> --%>
	                        
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
	
	                       <!--  <div class="body-descriptions">
	                            파일명에 <strong>이름 및 소속 등의 개인정보는 반드시 삭제 후 <span class="txt-heightlight">한글(.hwp)</span>파일로 업로드</strong>하여 주시기 바랍니다.<br>
	                            <br>
	                            아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">종합결과서</span>가 제출</strong>되며 관리자가 승인하기 전에는 제출취소를 통해 철회할 수 있습니다.<br>
	                            내용이 정확한지 최종적으로 확인하신 후 진행하시기 바랍니다.<br>
	                        </div> -->
	
	                        <div class="submit-set">
	                        	<c:if test="${totalResultMap.TOTAL_RESULT_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="제출하기">제출하기</a></button>
	                        	</c:if>
	                        	<c:if test="${totalResultMap.TOTAL_RESULT_YN == 'Y'}">
	                        		<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
	                        	</c:if>
	                        	
                                <!-- 미제출 -->
                            	<button type="button" class="evtdss-submit"><a id="prcBtnSave2" title="승인처리">승인</a></button>
                                <c:if test="${viewCommitStatus.OPINION_APV_YN != 'Y'}">
                                	승인대기
                                </c:if>
                                <c:if test="${viewCommitStatus.OPINION_APV_YN == 'Y'}">
                                	승인완료
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


<style>
.modal-content {
  display: flex; /* Flexbox를 사용하여 내부 컨텐츠를 나란히 배치 */
  justify-content: center; /* 가운데 정렬 */
  align-items: stretch; /* 높이를 같게 조정 */
}

.content-container {
  display: flex; /* Flexbox를 사용하여 PDF와 테이블을 나란히 배치 */
  width: 100%; /* 모달 컨텐츠의 전체 너비를 사용 */
}

.pdf-viewer {
  flex: auto; /* 반을 차지하도록 유연성 부여 */
  overflow: hidden; /* PDF가 컨테이너를 넘어가지 않도록 함 */
  height: 560px;
}

th, td {
  border: 1px solid #ddd; /* 셀에 테두리 추가 */
  padding: 8px; /* 셀 패딩 */
}

th {
  background-color: #f2f2f2; /* 테이블 헤더 배경색 */
  text-align: left; /* 텍스트 왼쪽 정렬 */
}
.modal {
  display: none; /* 기본적으로 숨겨져 있음 */
  position: fixed;
  z-index: 100%; /* 페이지 위에 표시 */
  left: 0;
  top: 0;
  width: 100%; /* 전체 너비 */
  height: 170%; /* 전체 높이 */
  overflow: auto; /* 스크롤바 추가 */
  background-color: rgb(0,0,0); /* 백그라운드 색상 */
  background-color: rgba(0,0,0,0.4); /* 어두운 투명도 */
}

/* 모달창 컨텐츠 스타일 */
.modal-content {
  background-color: #fefefe;
  margin: 4% auto; /* 페이지 중앙에 위치 */
  padding: 20px;
  border: 1px solid #888;
  width: 95%; /* 대부분의 화면을 차지 */
  height: 90%;
}

/* 닫기 버튼 스타일 */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

#pdf-viewer {
  width: 100%;
  overflow-y: scroll;
  background: #fff;
  padding: 20px;
  box-sizing: border-box;
}

#pdf-viewer canvas {
  width: 100%; /* 캔버스 너비를 컨테이너에 맞춥니다. */
  border-bottom: 1px solid #ccc; /* 페이지 간 구분선 추가 */
  margin-bottom: 20px; /* 페이지 간 간격 추가 */
  page-break-after: always; /* 인쇄 시 페이지 구분 */
}
canvas {
  width: 100%; /* 캔버스 너비를 컨테이너에 맞춥니다. */
  border-bottom: 1px solid #ccc; /* 페이지 간 구분선 추가 */
  margin-bottom: 20px; /* 페이지 간 간격 추가 */
}

</style>
	
<div id="pdfModal" class="modal">
  <!-- 모달창 컨텐츠 -->
  <div class="modal-content">
    <div class="content-container">
      <div class="pdf-viewer">
        <object data='/1/Week01/data/download01/01.pdf#pagemode=thumbs&scrollbar=1&toolbar=1&statusbar=1&messages=1&navpanes=1'  type='application/pdf' width='100%' height='100%'>
          <p>This browser does not support inline PDFs. Please download the PDF to view it: <a href="/1/Week01/data/download01/01.pdf">Download PDF</a></p>
        </object>
      </div>
      
      <div style="flex: auto; overflow: auto;">
        <!-- 테이블 -->
		<p class="section-title" style="margin-left : 50px;">종합결과서</p>
        <table style=" width: 92%; margin-left : 50px; border-collapse: collapse;">
			<tr>
			    <th style="width: 50px;">구분</th>
			    <th style="width: 450px;">내용</th>
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
		<div class="submit-set">
			<c:if test="${totalResultMap.TOTAL_RESULT_YN != 'Y'}">
				<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="저장하기">저장하기</a></button>
			</c:if>
			<c:if test="${totalResultMap.TOTAL_RESULT_YN == 'Y'}">
				<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="취소">취소</a></button>
			</c:if>
			<!-- 제출이력이 있을 경우 표시 -->
			<div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div>
			<!-- /제출이력이 있을 경우 표시 -->
		</div>
      </div>
    </div>
    <span class="close">&times;</span>
  </div>
</div>

<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>