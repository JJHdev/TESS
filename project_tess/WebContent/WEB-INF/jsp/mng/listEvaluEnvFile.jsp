<%--
*******************************************************************************
***    명칭: listEvaluEnvStep.jsp
***    설명: [관리자] 평가환경설정 > 참조파일관리 화면
***
***    -----------------------------    Modified Log   ---------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0    2023.11.17        LHB       First Coding.
*******************************************************************************
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

	<!-- Evalu공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
	
	<style>
		.regi-file[rel='Y'] { cursor: pointer; }
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
    <div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>관리자</li>
	                    <li>평가환경설정</li>
	                    <li>참조파일관리</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">참조파일관리</h3>
	                    <!-- Contents -->
	                    <ul class="page-tabs">
	                        <li class="page-tab w33"><a href="/mng/listEvaluEnvStep.do">평가단계관리</a></li>
	                        <li class="page-tab w33"><a href="/mng/listEvaluEnvIndex.do">평가지표관리</a></li>
	                        <li class="page-tab w33 active"><a href="/mng/listEvaluEnvFile.do">참조파일관리</a></li>
	                    </ul>
	                    
                    	<select class="form-control fc-black mt-15px mb-15px" id="evaluStage">
	                    	<c:forEach items="${evaluStageList}" var="item">
	                    		<option value="<c:out value="${item.code}" />"><c:out value="${item.codeNm}" /></option>
	                    	</c:forEach>
	                    </select>
	
	                    <p class="section-title">참조파일<small class="">등록한 첨부파일들은 각 공개대상에게 노출됩니다.</small></p>
	                    <div class="table-wrap">
	                        <table class="sample-file-table" summary="평가 프로세스에서 사용되는 참조 파일을 관리할 수 있습니다.">
								<caption class="sr-only">참조파일목록</caption>
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 19%;">
									<col style="width: 33%;">
									<col style="width: 33%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="fix-width title">공개대상</th>
										<th scope="col" class="fix-width title">서류명</th>
										<th scope="col" class="fix-width title">샘플</th>
										<th scope="col" class="fix-width title">양식</th>
	                            	</tr>
								</thead>
								<tbody>
									<!--
									<tr>
										<td class="align-center">지자체</td>
										<td class="align-center">사업설명서</td>
										<td>
											<input type="file" name="upload" class="regi-file-input">
		                                    <div class="regi-file" rel="N">등록파일 없음</div>
		                                    <div class="incell-btn button-set hor">
	                                        	<button type="button" class="inline-button green"><a onclick="doc_save('AT07');" title="선택파일 추가">저장</a></button>
		                                    </div>
										</td>
										<td></td>
									</tr>
									<tr>
										<td class="align-center" rowspan="3">평가위원</td>
										<td class="align-center">서면검토서</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td class="align-center">평가지침서</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td class="align-center">평가의견서</td>
										<td></td>
										<td></td>
									</tr>
									-->
								</tbody>
	                        </table>
	                    </div>
	                    
	                    <div class="body-descriptions">
                            <strong>샘플 파일은 PDF, HWP</strong>, <strong>양식 파일은 HWP</strong> 파일만 첨부할 수 있습니다. 샘플 파일은 파일 용량을 위해 <strong>PDF</strong>를 권장합니다.<br>
                            파일 용량 제한은 <strong class="fc-red">50MB</strong> 입니다.
                        </div>
	
						<!--
	                    <div class="submit-set">
	                        <button class="evtdss-submit"><a onclick="regi_btn();" title="저장">저장</a></button>
	                        <button class="evtdss-submit-cancel"><a href="#" title="초기화">초기화</a></button>
	                    </div>
	                    -->
	                    <!-- /Contents -->
	                </div>
	            </div>
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
</div><!--/#wrap-->

</body>
</html>