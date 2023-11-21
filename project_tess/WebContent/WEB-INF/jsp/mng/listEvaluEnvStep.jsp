<%--
*******************************************************************************
***    명칭: listEvaluEnvStep.jsp
***    설명: [관리자] 평가환경설정 > 평가단계관리 화면
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
	                    <li>평가단계관리</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가환경설정</h3>
	                    <!-- Contents -->
	                    <ul class="page-tabs">
	                        <li class="page-tab w33 active"><a href="/mng/listEvaluEnvStep.do">평가단계관리</a></li>
	                        <li class="page-tab w33"><a href="/mng/listEvaluEnvIndex.do">평가지표관리</a></li>
	                        <li class="page-tab w33"><a href="/mng/listEvaluEnvFile.do">참조파일관리</a></li>
	                    </ul>
	
	                    <div class="grid-head">
	                        <div class="grid-count">총 <strong>${fn:length(evaluStageList)}</strong> 건</div>
	                        <button class="grid-print" title="엑셀파일저장">엑셀저장</button>
	                    </div>
	                    <div class="table-wrap">
	                        <table summary="평가시스템에서 사용되는 연도별 평가단계를 관리할 수 있습니다.">
								<caption class="sr-only">평가단계관리목록</caption>
								<colgroup><col /><col /><col /><col /></colgroup>
								<thaed>
									<tr>
										<th scope="col" class="fix-width title">코드</th>
										<th scope="col" class="">평가단계명</th>
										<th scope="col" class="fix-width title">사용여부</th>
										<th scope="col" class="fix-width title" style="width:10%">순서</th>
										<th scope="col" class="fix-width title">기능</th>
	                            	</tr>
								</thaed>
								<tbody>
								<c:forEach items="${evaluStageList}" varStatus="idx" var="item">
									<tr>
		                                <td>
		                                    <div class="incell-textinput w100">
		                                        <input type="text" title="평가단계코드" name="code" placeholder="평가단계코드" value="${item.code}" disabled>
		                                    </div>
		                                </td>
		                                <td>
		                                    <div class="incell-textinput w100">
		                                        <input type="text" title="평가단계명" name="codeNm" placeholder="평가단계명" value="${item.codeNm}">
		                                    </div>
		                                </td>
		                                <td class="align-center">
		                                    <select name="useYn" title="사용여부" class="form-control">
			                                	<option value="Y" <c:if test="${item.useYn == 'Y'}">selected</c:if>>활성</option>
	                                        	<option value="N" <c:if test="${item.useYn == 'N'}">selected</c:if>>비활성</option>
		                                    </select>
		                                </td>
		                                <td class="align-center">
		                                    <div class="incell-textinput w100">
		                                        <input type="text" title="순서" name="codeOdr" placeholder="순서" value="${item.codeOdr}">
		                                    </div>
		                                </td>
		                                <td class="align-center">
		                                    <div class="button-set hor">
		                                        <button class="inline-button confirm" title="수정"><a href="javascript:void(0);" onclick="updt_btn(this);" title="수정">수정</a></button>
		                                        <button class="inline-button black" title="삭제"><a href="javascript:void(0);" onclick="delt_btn('${item.code}');" title="삭제">삭제</a></button>
		                                    </div>
		                                </td>
		                            </tr>
								</c:forEach>
								</tbody>
	                        </table>
	                    </div>
	
	                    <p class="section-title">단계등록<small class="silent">평가단계 세부설정</small></p>
	                    <table class="evtdss-form-table">
	                        <tr>
	                            <th>구분</th>
	                            <th>내용</th>
	                        </tr>
	                        <tr>
	                            <td class="fix-width title">코드</td>
	                            <td>
	                                <div class="incell-textinput w50">
	                                    <input type="text" title="코드" name="code" placeholder="코드" value="">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="fix-width title">평가단계명</td>
	                            <td>
	                                <div class="incell-textinput w50">
	                                    <input type="text" title="평가단계명" name="codeNm" placeholder="평가단계명" value="">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="fix-width title">사용여부</td>
	                            <td>
	                                <div class='col-sm-6 noPadding'>
	                                    <div class="form-group inline-radio regiIndicatUseYn">
	                                        <label class="radio-inline">
	                                            <input type="radio" name="useYn" value="Y" checked> 활성
	                                        </label>
	                                        <label class="radio-inline">
	                                            <input type="radio" name="useYn" value="N"> 비활성
	                                        </label>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                    </table>
	                    <div class="submit-set">
	                        <button class="evtdss-submit"><a onclick="regi_btn();" title="저장">저장</a></button>
	                        <button class="evtdss-submit-cancel"><a href="#" title="초기화">초기화</a></button>
	                        <!-- 제출이력이 있을 경우 표시 -->
	                        <!-- <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 저장</span> 되었습니다.</div> -->
	                        <!-- /제출이력이 있을 경우 표시 -->
	                    </div>
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