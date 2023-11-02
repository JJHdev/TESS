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

<style>
	.regi_popup, .mod_popup {
		width: 490px;
	    height: 300px;
	    background: #fff;
	}
	.regi_popup_wrap {
		position: relative;
		padding: 30px 45px;
	}
	.regi_popup_wrap .header {
		text-align: center;
		margin-bottom: 5%;
	}
	.regi_popup_wrap .content table .CaptionTD {
	    vertical-align: middle;
	    border: 0 none;
	    padding: 2px;
	    white-space: nowrap;
	    width: 70px;
	}
	.regi_popup_wrap .content table .DataTD {
	    padding: 2px;
	    border: 0 none;
	    vertical-align: top;
	}
	.regi_popup_wrap .content table .DataTD input {
		padding-left: 5px;
	}
	.regi_popup_wrap .content table tr {
		margin-bottom: 6px;
    	display: inline-block;
    	width: 100%;
	}
	.regi_popup_wrap .content table tr:nth-child(1) .DataTD input, .regi_popup_wrap .content table tr:nth-child(2) .DataTD input, .regi_popup_wrap .content table tr:nth-child(5) .DataTD input {
		width: 270px;
	}
	.regi_popup_wrap .content table tr:nth-child(3) .DataTD input, .regi_popup_wrap .content table .DataTD select {
		width: 50px;
	}
	.regi_popup_wrap .r_btn {
		text-align: center;
		margin-top: 7%;
	}
	.regi_popup_wrap .r_btn a {
		padding: 5px 20px;	
		color: #fff;
	}
	.modfy_btn {
		color: #fff;
	    padding: 0px 15px;
	    height: 23px;
	    line-height: 23px;
	    font-size: 13px;
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
    <div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>관리자</li>
	                    <li>평가환경설정</li>
	                    <li>평가지표관리</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가환경설정</h3>
	                    <!-- Contents -->
	                    <ul class="page-tabs">
	                        <li class="page-tab"><a href="/mng/listEvaluEnvStep.do">평가단계관리</a></li>
	                        <li class="page-tab active"><a href="/mng/listEvaluEnvIndex.do">평가지표관리</a></li>
	                    </ul>
	                    
	                    <form>
	                        <div class="form-group search-form" style="margin-top: 28px;">
	                            <ul class="g-search">
	                                <!-- <li class="g-search-col w10" style="text-align: center; padding-top: 10px; background: #ededed;">
	                                	<input type="text" class="g-search-input-txt" title="평가위원ID" placeholder="평가위원ID">
	                                	<select name="bbsTemplate" class="form-control">
	                                       	<option value="기본" selected="">기본</option>
	                                       	<option value="갤러리">갤러리</option>
	                                       	<option value="FAQ">FAQ</option>
	                                    	<option value="캘린더">캘린더</option>
	                                   	</select>
	                                   	평가단계
	                                </li> -->
	                                <li class="g-search-col w50" style="border-right:0;">
	                                   	<select name="srchEvaluStageTemp" title="평가단계" id="srchEvaluStageTemp" class="form-control" style="width: 49%; display: inline-block; height: 45px;">
					 						<option value="">::평가단계::</option>
					                        <c:forEach items="${evaluStageComboList }" varStatus="idx" var="type">
					                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
					                                <c:out value="${type.codeNm }"/>
					                            </option>
					                        </c:forEach>
										</select>
	                                   	<select name="srchEvaluIndicatTemp" title="평가지표" id="srchEvaluIndicatTemp" class="form-control" style="width: 49%; display: inline-block; height: 45px;">
					 						<option value="">::평가항목::</option>
										</select>
	                                </li>
	                                <!-- <li class="g-search-col w10" style="text-align: center; padding-top: 10px; background: #ededed;">
	                                	평가지표명
	                                </li> -->
	                                <li class="g-search-col w50">
	                                	<input type="text" class="g-search-input-txt" id="srchEvaluIndicatNmTemp" name="srchEvaluIndicatNmTemp" title="평가지표명" placeholder="평가지표명" style="width:100%;">
	                                </li>
	                            </ul>
	                            <div class="g-search-btn">
	                                <a href="javascript:void(0);" onclick="onClickButton('prcBtnSrch');" title="검색시작">검색</a>
	                            </div>
	                        </div>
	                    </form>
	
						<div class="grid-head">
	                        <div class="grid-count">총 <strong></strong> 건</div>
	
	                        <button class="grid-print" title="엑셀저장"><i class="glyphicon glyphicon-download-alt"></i> 엑셀저장</button>
	                        <button class="grid-print green" title="신규등록" onclick="onClickButton('prcBtnRegi')"><i class="glyphicon glyphicon-plus"></i> 신규등록</button>
	                    </div>
	
	                    <div class="grid-wrap" data-ax5grid="committee-grid" data-ax5grid-config="{}"></div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div> <!-- /contents-wrap -->
</div><!-- /contents -->

<!-- 등록 팝업 -->
<div class="regi_popup" style="display:none;">
	<div class="regi_popup_wrap">
		<div class="header">
			<p>코드 등록</p>
		</div>
		<div class="content">
			<table>
				<tr class="FormData" id="tr_code">
					<td class="CaptionTD">코드</td>
					<td class="DataTD">
						<input type="text" title="코드" size="20" maxlength="25" id="regiCode" name=regiCode">
					</td>
				</tr>
				<tr class="FormData" id="tr_codeNm">
					<td class="CaptionTD">코드명</td>
					<td class="DataTD">
						<input type="text" title="코드명" size="20" maxlength="25" id="regiCodeNm" name="regiCodeNm">
					</td>
				</tr>
				<!-- <tr class="FormData" id="tr_order">
					<td class="CaptionTD">순서</td>
					<td class="DataTD">
						<input type="text" size="20" maxlength="25" id="code" name="code">
					</td>
				</tr> -->
				<tr class="FormData" id="tr_useYn">
					<td class="CaptionTD">사용여부</td>
					<td class="DataTD">
						<select name="regiUseYn" title="사용여부" id="regiUseYn">
							<option value="Y">사용</option>
							<option value="N">사용안함</option>
						</select>
					</td>
				</tr>
				<tr class="FormData" id="tr_parentCode">
					<td class="CaptionTD">부모코드</td>
					<td class="DataTD">
						<input type="text" title="부모코드" label="부모코드" size="20" maxlength="25" id="regiParentCode" name="regiParentCode">
					</td>
				</tr>
			</table>
		</div>
		<div class="r_btn">
			<a class="add inline-button confirm" title="등록" onclick="regi_func();">등록</a>
			<a class="cancel inline-button black" title="취소" onclick="popup_close('regi_popup');">취소</a>
		</div>
	</div>
</div>

<!-- 수정 팝업 -->
<div class="mod_popup" style="display:none;">
	<div class="regi_popup_wrap">
		<div class="header">
			<p>코드 수정</p>
		</div>
		<div class="content">
			<table>
				<tr class="FormData" id="tr_code">
					<td class="CaptionTD">코드</td>
					<td class="DataTD">
						<input type="text" title="코드" size="20" maxlength="25" id="modCode" name="modCode" readonly="readonly">
					</td>
				</tr>
				<tr class="FormData" id="tr_codeNm">
					<td class="CaptionTD">코드명</td>
					<td class="DataTD">
						<input type="text" title="코드명" size="20" maxlength="25" id="modCodeNm" name="modCodeNm">
					</td>
				</tr>
				<!-- <tr class="FormData" id="tr_order">
					<td class="CaptionTD">순서</td>
					<td class="DataTD">
						<input type="text" size="20" maxlength="25" id="code" name="code">
					</td>
				</tr> -->
				<tr class="FormData" id="tr_useYn">
					<td class="CaptionTD">사용여부</td>
					<td class="DataTD">
						<select title="사용여부" name="modUseYn" id="modUseYn">
							<option value="Y">사용</option>
							<option value="N">사용안함</option>
						</select>
					</td>
				</tr>
				<tr class="FormData" id="tr_parentCode">
					<td class="CaptionTD">부모코드</td>
					<td class="DataTD">
						<input type="text" title="부모코드" size="20" maxlength="25" id="modParentCode" name="modParentCode" readonly="readonly">
					</td>
				</tr>
			</table>
		</div>
		<div class="r_btn">
			<a class="add inline-button confirm" title="수정" onclick="mod_func();">수정</a>
			<a class="cancel inline-button black" title="취소" onclick="popup_close('mod_popup');">취소</a>
		</div>
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