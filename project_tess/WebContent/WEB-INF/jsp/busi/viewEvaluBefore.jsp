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
    <input type="hidden" name="uscmType" id="uscmType" value="<c:out value="${paramMap.gsUscmType}"/>">

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
	                    <li>2018 평가사업</li>
	                    <li>${evaluInfo.TODE_BUSI_NM}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">2018 평가사업</h3>
	                </div>
	            </div>
	        </div>
	
	        <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	            <div class="shade"></div>
	            <div class="project-title">
	                <h2>${evaluInfo.TODE_BUSI_NM}</h2>
	                <p>${evaluInfo.busiAddress1} / ${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</p>
	            </div>
	            <div class="local-menu">
	                <ul>
	                    <li class="unabled"><a href="./evalProjectInfo.html" title="사업정보">사업정보</a></li>
	                    <li class="unabled"><a href="./evalProgressDocuments.html" title="평가정보">평가정보</a></li>
	                </ul>
	                <div class="back-list"><a href="./evalList.html" title="목록으로"><</a></div>
	            </div>
	        </div>
	
	        <div class="container b-section">
	            <div class="row">
	                <div class="col-md-12">
	                    <div class="body-head">
	                        <h4 class="page-title">평가위원 사전행정절차</h4>
							<a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                    </div>
	                    <!-- Contents -->
	                    <div class="body-descriptions">
	                        배정된 평가위원은 <strong>평가사업 참여를 위한 사전행정서류 확인 및 동의 후 사업정보 열람이 가능</strong>합니다.<br>
	                        하단의 보안각서, 청탁금지서약서, 개인정보 수집ㆍ이용동의서를 잘 읽고 동의하신 후 제출하시기 바랍니다.
	                    </div>
	
	                    <p class="section-title">보안각서<small class="silent">부가설명을 작성합니다</small></p>
	                    <div class="doc-form-scroll">
	                        본인은 문화체육관광부와 한국문화관광연구원에서 시행하는 「2018년 지역관광개발사업 평가(이하 ‘본 평가’)」의 평가위원으로서 아래의 각호의 보안사항에 대한 준수
	                        책임이 있음을 각서로 제출합니다.<br>
	                        <br>
	                        - 아 &nbsp;&nbsp; 래 -<br>
	                        <br>
	                        <strong>
	                        1. 본 평가와 관련된 일체의 보안사항을 준수 및 이행하고 업무상 인지한 사실에 대하여 비밀을 유지하겠습니다.<br>
	                        2. 본 평가 중에 인지한 보안사항에 대하여 평가종료 후에도 외부에 누설하지 않겠습니다.<br>
	                        </strong>
	                        <br>
	                        만약 보안사항을 외부에 누설시켜 해당기관에 중대한 손실을 입히게 될 경우에는 관계법령에 의거 어떠한 처벌도 감수하겠습니다.
	                    </div>
	                    <div class="conform-check">
	                        <div class="checkbox">
	                            <label>
	                                <input type="checkbox" title="보안각서 동의" name="docType01"> 위 보안각서를 숙지하였으며 내용에 동의합니다.
	                            </label>
	                        </div>
	                    </div>
	
	                    <p class="section-title">청탁금지서약서<small class="silent">부가설명을 작성합니다</small></p>
	                    <div class="doc-form-scroll">
	                        「2018년 지역관광개발사업 평가」의 공정하고 엄정한 평가를 위해 노력하여 주시는 심사위원 여러분의 노고에 진심으로 감사드립니다.<br>
	                        「부정청탁 및 금품 등 수수의 금지에 관한 법률(이하󰡐청탁금지법󰡑)」시행(‘16.9.28)에 따라 심사 시 발생할 수 있는 논란을 사전에 예방하기 위하여 아래와 같이
	                        서약서를 작성해 주실 것을 요청 드립니다.<br>
	                        <br>
	                        - 아 &nbsp;&nbsp; 래 -<br>
	                        <br>
	                        본인은「청탁금지법」에 따라 ‘공직자 등(교직원)’또는 ‘공무수행사인(민간인)’ 에 해당하여, 수수가 금지되는 사항에 대해 법을 준수할 것을 서약합니다.<br>
	                        <div class="text-box-inline">
	                            <strong>&lt;수수가 금지되는 사항&gt;</strong><br>
	                                1. 평가대상 사업 지자체측 또는 유관기관을 통해 제공받는 <strong>음식물, 식사 등의 접대ㆍ향응, 교통ㆍ숙박 등의 편의 제공</strong><br>
	                                2. 평가대상 사업 지자체측 또는 유관기관을 통해 제공받는 <strong>기념품(특산품, 홍보기념품, 기타 홍보물품 등)</strong><br>
	                        </div>
	                    </div>
	                    <div class="conform-check">
	                        <div class="checkbox">
	                            <label>
	                                <input type="checkbox" title="청탁금지서약서 동의" name="docType02"> 위 청탁금지서약서를 숙지하였으며 내용에 동의합니다.
	                            </label>
	                        </div>
	                    </div>
	
	                    <p class="section-title">개인정보 수집ㆍ이용 동의서<small class="silent">부가설명을 작성합니다</small></p>
	                    <div class="doc-form-scroll">
	                        「개인정보 보호법」에 따라 「2018년 지역관광개발사업 평가」와 관련하여  개인정보의 수집 및 이용 등에 관한 동의여부를 확인하여 주시기 바랍니다.<br>
	                        <br>
	                        - 아 &nbsp;&nbsp; 래 -<br>
	                        <br>
	                        1. 정보 수집ㆍ이용 기관명 : 한국문화관광연구원<br>
	                        2. 정보 수집ㆍ이용 범위와 사용목적<br>
	                        ○ 수집ㆍ이용 범위 : 주민등록번호, 전화번호, 주소, 은행계좌번호<br>
	                        ○ 사용목적 : 평가관리 및 사례비 지급<br>
	                        <br>
	                        한국문화관광연구원은 개인정보 제공자가 동의한 내용 외의 목적으로 활용하지 않으며 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.<br>
	                    </div>
	                    <div class="conform-check">
	                        <div class="checkbox">
	                            <label>
	                                <input type="checkbox" title="개인정보 수집ㆍ이용 동의서 동의" name="docType03"> 위 개인정보 수집ㆍ이용 동의서를 숙지하였으며 내용에 동의합니다.
	                            </label>
	                        </div>
	                    </div>
	
	                    <p class="section-title">본인확인<small class="silent">가입하신 정보가 본인이 맞는지 확인하세요</small></p>
	                    <table class="evtdss-form-table" summary="아래 표시된 정보가 본인이 맞는지 확인합니다.">
	                    <caption>본인확인</caption>
	                    <thead>
	                        <tr>
	                            <th>구분</th>
	                            <th>내용</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr>
	                            <td align="center">소속</td>
	                            <td><strong>${paramMap.gsDeptNm}</strong></td>
	                        </tr>
	                        <tr>
	                            <td align="center">이름</td>
	                            <td><strong>${paramMap.gsUserNm}</strong></td>
	                        </tr>
						</tbody>	                        
	                    </table>
	
	                    <div class="submit-set">
	                        <button type="button" title="제출하기" class="evtdss-submit"><a id="prcBtnSave" title="제출하기">제출하기</a></button>
	                        <button type="button" title="제출취소" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
	                    </div>
	                    <!-- /Contents -->
	                </div>
	            </div>
	        </div> <!-- /.container -->
	    </div> <!-- /.wrapper -->
	</div> <!-- /.contents-wrap -->
	
	
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