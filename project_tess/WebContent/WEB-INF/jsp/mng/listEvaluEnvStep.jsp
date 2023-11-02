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
	                        <li class="page-tab active"><a href="/mng/listEvaluEnvStep.do">평가단계관리</a></li>
	                        <li class="page-tab"><a href="/mng/listEvaluEnvIndex.do">평가지표관리</a></li>
	                    </ul>
	
	                    <div class="grid-head">
	                        <div class="grid-count">총 <strong>${fn:length(evaluEnvStepList)}</strong> 건</div>
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
										<th scope="col" class="fix-width title">메인 활성화 여부</th>
										<th scope="col" class="fix-width title" style="width:10%">순서</th>
										<th scope="col" class="fix-width title">기능</th>
	                            	</tr>
								</thaed>
								<tbody>
								<c:forEach items="${evaluEnvStepList }" varStatus="idx" var="item">
									<tr>
		                                <td>
		                                    <div class="incell-textinput w100">
		                                        <input type="text" title="평가단계코드" name="updtIndicatCd" placeholder="평가단계코드" value="${item.evaluIndicatCd}" disabled>
		                                    </div>
		                                </td>
		                                <td>
		                                    <div class="incell-textinput w100">
		                                        <input type="text" title="평가단계명" name="updtIndicatNm" placeholder="평가단계명" value="${item.evaluIndicatNm}">
		                                    </div>
		                                </td>
		                                <td class="align-center">
		                                    <select name="updtIndicatUseYn" title="사용여부" class="form-control">
		                                    	<c:if test="${item.evaluIndicatUseYn == 'Y'}">
				                                	<option value="Y" selected>활성</option>
		                                        	<option value="N">비활성</option>
		                                    	</c:if>
		                                    	<c:if test="${item.evaluIndicatUseYn == 'N'}">
				                                	<option value="Y">활성</option>
		                                        	<option value="N" selected>비활성</option>
		                                    	</c:if>
		                                    </select>
		                                </td>
		                                <td class="align-center">
		                                    <select name="updtMainOpenYn" title="메인 활성화 여부" class="form-control">
		                                    	<c:if test="${item.mainOpenYn == 'Y'}">
				                                	<option value="Y" selected>활성</option>
		                                        	<option value="N">비활성</option>
		                                    	</c:if>
		                                    	<c:if test="${item.mainOpenYn == 'N'}">
				                                	<option value="Y">활성</option>
		                                        	<option value="N" selected>비활성</option>
		                                    	</c:if>
		                                    </select>
		                                </td>
		                                <td class="align-center">
		                                    <div class="incell-textinput w100">
		                                        <input type="text" title="순서" name="updtMainOpenOrd" placeholder="순서" value="${item.mainOpenOrd}">
		                                    </div>
		                                </td>
		                                <td class="align-center">
		                                    <div class="button-set hor">
		                                        <button class="inline-button confirm" title="수정"><a href="javascript:void(0);" onclick="updt_btn(this);" title="수정">수정</a></button>
		                                        <button class="inline-button black" title="삭제"><a href="javascript:void(0);" onclick="delt_btn('${item.evaluIndicatCd}');" title="삭제">삭제</a></button>
		                                    </div>
		                                </td>
		                            </tr>
								</c:forEach>
								</tbody>
	                        </table>
	                        <!-- <div class="pagination-wrap">
	                            <form class="form-horizontal">
	                                <div class="form-group">
	                                    <div class="col-sm-2">
	                                        <select name="evalPageRows" class="form-control">
	                                            <option value="v10">10개씩 보기</option>
	                                            <option value="v25">25개씩 보기</option>
	                                            <option value="v50">50개씩 보기</option>
	                                            <option value="v100">100개씩 보기</option>
	                                        </select>
	                                    </div>
	                                    <div class="col-sm-10">
	                                        <ul class="paging-wrap">
	                                            활성화 페이지 .active 처리
	                                            <li class="page-btn disable"><a href="#" title="이전">이전</a></li>
	                                            <li class="pages active"><a href="#" title="1">1</a></li>
	                                            <li class="pages"><a href="#" title="2">2</a></li>
	                                            <li class="pages"><a href="#" title="3">3</a></li>
	                                            <li class="pages"><a href="#" title="4">4</a></li>
	                                            <li class="pages"><a href="#" title="5">5</a></li>
	                                            <li class="dots"></li>
	                                            <li class="pages"><a href="#" title="99">99</a></li>
	                                            <li class="page-btn"><a href="#" title="다음">다음</a></li>
	                                        </ul>
	                                    </div>
	                                </div> /.form-group
	                            </form> /.form-horizontal
	                        </div> --> <!-- /.pagination-wrap-group -->
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
	                                    <input type="text" title="코드" name="regiIndicatCd" placeholder="코드" value="">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="fix-width title">평가단계명</td>
	                            <td>
	                                <div class="incell-textinput w50">
	                                    <input type="text" title="평가단계명" name="regiIndicatNm" placeholder="평가단계명" value="">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="fix-width title">사용여부</td>
	                            <td>
	                                <div class='col-sm-6 noPadding'>
	                                    <div class="form-group inline-radio regiIndicatUseYn">
	                                        <label class="radio-inline">
	                                            <input type="radio" name="regiIndicatUseYn" value="Y" checked> 활성
	                                        </label>
	                                        <label class="radio-inline">
	                                            <input type="radio" name="regiIndicatUseYn" value="N"> 비활성
	                                        </label>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="fix-width title">메인 활성화 여부</td>
	                            <td>
	                                <div class='col-sm-6 noPadding'>
	                                    <div class="form-group inline-radio regiIndicatUseYn">
	                                        <label class="radio-inline">
	                                            <input type="radio" name="regiMainOpenYn" value="Y"> 활성
	                                        </label>
	                                        <label class="radio-inline">
	                                            <input type="radio" name="regiMainOpenYn" value="N" checked> 비활성
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