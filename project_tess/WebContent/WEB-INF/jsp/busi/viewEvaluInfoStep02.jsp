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
	<!-- jstree 추가 js -->
	<script type="text/javascript" src="/jquery/jstree/jquery.jstree.js"></script>
	<script type="text/javascript" src="/jquery/jstree/_lib/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="/jquery/jstree/_lib/jquery.cookie.js"></script>
	
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/pdfjs-2.2.228-dist/build/pdfobject.min.js"/>'></script>

					
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	// 모델 리스트를 만들고 맵을 추가합니다.
	List<Map<String, String>> model = new ArrayList<Map<String, String>>();
	// 맵을 생성하고 아이템들을 맵에 추가합니다.
	Map<String, String> scoreType1 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType2 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType3 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType4 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType5 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType6 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType7 = new LinkedHashMap<String, String>();
	Map<String, String> scoreType8 = new LinkedHashMap<String, String>();
	
	Map<String, String> mainTable1 = new LinkedHashMap<String, String>();
	Map<String, String> subTable1 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable1 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable2 = new LinkedHashMap<String, String>();
	Map<String, String> subTable2 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable3 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable4 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable5 = new LinkedHashMap<String, String>();
	Map<String, String> subTable3 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable6 = new LinkedHashMap<String, String>();
	Map<String, String> subsubTable7 = new LinkedHashMap<String, String>();
	Map<String, String> mainTable2 = new LinkedHashMap<String, String>();
	Map<String, String> subTable4 = new LinkedHashMap<String, String>();
	Map<String, String> subTable5 = new LinkedHashMap<String, String>();
	Map<String, String> subTable6 = new LinkedHashMap<String, String>();
	
	scoreType1.put("sysScore", "1");
	scoreType1.put("title", "미확보");
	scoreType1.put("score", "3");
	model.add(new LinkedHashMap<String, String>(scoreType1));
	scoreType2.put("sysScore", "1");
	scoreType2.put("title", "확보가능");
	scoreType2.put("score", "4");
	model.add(new LinkedHashMap<String, String>(scoreType2));
	scoreType3.put("sysScore", "1");
	scoreType3.put("title", "확보");
	scoreType3.put("score", "5");
	model.add(new LinkedHashMap<String, String>(scoreType3));
	
	scoreType4.put("sysScore", "2");
	scoreType4.put("title", "미흡");
	scoreType4.put("score", "1");
	model.add(new LinkedHashMap<String, String>(scoreType4));
	scoreType5.put("sysScore", "2");
	scoreType5.put("title", "다소미흡");
	scoreType5.put("score", "2");
	model.add(new LinkedHashMap<String, String>(scoreType5));
	scoreType6.put("sysScore", "2");
	scoreType6.put("title", "보통");
	scoreType6.put("score", "3");
	model.add(new LinkedHashMap<String, String>(scoreType6));
	scoreType7.put("sysScore", "2");
	scoreType7.put("title", "다소우수");
	scoreType7.put("score", "4");
	model.add(new LinkedHashMap<String, String>(scoreType7));
	scoreType8.put("sysScore", "2");
	scoreType8.put("title", "우수");
	scoreType8.put("score", "5");
	model.add(new LinkedHashMap<String, String>(scoreType8));
	
	scoreType4.put("sysScore", "3");
	scoreType4.put("title", "미흡");
	scoreType4.put("score", "5");
	model.add(new LinkedHashMap<String, String>(scoreType4));
	scoreType5.put("sysScore", "3");
	scoreType5.put("title", "다소미흡");
	scoreType5.put("score", "6");
	model.add(new LinkedHashMap<String, String>(scoreType5));
	scoreType6.put("sysScore", "3");
	scoreType6.put("title", "보통");
	scoreType6.put("score", "7");
	model.add(new LinkedHashMap<String, String>(scoreType6));
	scoreType7.put("sysScore", "3");
	scoreType7.put("title", "다소우수");
	scoreType7.put("score", "8");
	model.add(new LinkedHashMap<String, String>(scoreType7));
	scoreType8.put("sysScore", "3");
	scoreType8.put("title", "우수");
	scoreType8.put("score", "9");
	model.add(new LinkedHashMap<String, String>(scoreType8));

	mainTable1.put("mainCode", "Q");
	mainTable1.put("subCode", "Q1");
	mainTable1.put("title", "사업의 성과");
	mainTable1.put("score", "50");
	model.add(new LinkedHashMap<String, String>(mainTable1)); // 새로운 LinkedHashMap으로 복사하여 추가

	mainTable2.put("mainCode", "Q");
	mainTable2.put("subCode", "Q2");
	mainTable2.put("title", "운영 성과");
	mainTable2.put("score", "50");
	model.add(new LinkedHashMap<String, String>(mainTable2)); // 새로운 LinkedHashMap으로 복사하여 추가

	subTable1.put("mainCode", "Q1");
	subTable1.put("subCode", "Q11");
	subTable1.put("title", "사전행정절차이행여부");
	subTable1.put("score", "10");
	model.add(new LinkedHashMap<String, String>(subTable1)); // 새로운 LinkedHashMap으로 복사하여 추가
	subTable2.put("mainCode", "Q1");
	subTable2.put("subCode", "Q12");
	subTable2.put("title", "입지적합성");
	subTable2.put("score", "30");
	model.add(new LinkedHashMap<String, String>(subTable2)); // 새로운 LinkedHashMap으로 복사하여 추가
	subTable3.put("mainCode", "Q1");
	subTable3.put("subCode", "Q13");
	subTable3.put("title", "운영가능성검토");
	subTable3.put("score", "10");
	model.add(new LinkedHashMap<String, String>(subTable3)); // 새로운 LinkedHashMap으로 복사하여 추가
	
	subsubTable1.put("mainCode", "Q11");
	subsubTable1.put("subCode", "Q111");
	subsubTable1.put("title", "부지확보 계획의 타당성");
	subsubTable1.put("content", "사업부지 미확정, 미확인되는 경우 향후 계획에 대한 확인 필요");
	subsubTable1.put("judgmnet", "● 현재 사업대상지 부지의 93% 매입이 완료되었으며 나머지 부지도 구두이기는 하지만 매매의향을 확인한 상태로 시굴조사 등에 협조하고 있어 향후 나머지 부지도 대부분 확보할 가능성이 높음.");
	subsubTable1.put("Improvements", "● 되도록 구두가 아니라 서면으로 매각 의향서나 동의서를 확보하는 것이 필요함.<br/>● 실시설계가 완료되는 시점 전에는 필요한 부지를 모두 확보하는 것이 좋으며 만약을 대비해 부지확보가 불가능할 경우 해당 토지를 관광지에서 제척하는 안도 고려해 실시 설계 시 반영해야 할 것임. ");
	subsubTable1.put("scoretype", "1");
	subsubTable1.put("score", "5");
	model.add(new LinkedHashMap<String, String>(subsubTable1)); // 새로운 LinkedHashMap으로 복사하여 추가
	subsubTable2.put("mainCode", "Q11");
	subsubTable2.put("subCode", "Q112");
	subsubTable2.put("title", "관련 인허가 계획의 타당성");
	subsubTable2.put("content", "환경영향평가, 문화재심의, 하천점용허가 등 인허가 절차 계획 수립 및 진행 여부 확인");
	subsubTable2.put("judgmnet", "● 현재 문화재 시굴조사 중으로 특별한 문제는 없어 보임.<br/>● 인허가 관련해서 특별히 진행된 부분이 없음. 현재는 근린공원으로 지정되어 있어 야영장 시설은 가능하나 그 외 시설의 경우 인허가가 필요할 수도 있음. ");
	subsubTable2.put("Improvements", "");
	subsubTable2.put("scoretype", "2");
	subsubTable2.put("score", "5");
	model.add(new LinkedHashMap<String, String>(subsubTable2)); // 새로운 LinkedHashMap으로 복사하여 추가
	subsubTable3.put("mainCode", "Q12");
	subsubTable3.put("subCode", "Q113");
	subsubTable3.put("title", "부지용도와 시설간의 부합성");
	subsubTable3.put("content", "ㆍ토지이용 상 법적규제 문제가 없는지<br/>ㆍ사업대상지의 급경사지 등으로 경관훼손 등이 발생하지 않는지");
	subsubTable3.put("judgmnet", "● 부지 용도가 보전녹지 또는 공익산지로 되어 있으며 주민들이 이용하는 산책로에 인접해 있음. 계획상의 토지이용구역내에는 경관훼손이나 급경사지를 우려할 만한 곳은 거의 없음. ");
	subsubTable3.put("Improvements", "");
	subsubTable3.put("scoretype", "3");
	subsubTable3.put("score", "15");
	model.add(new LinkedHashMap<String, String>(subsubTable3)); // 새로운 LinkedHashMap으로 복사하여 추가
	subsubTable4.put("mainCode", "Q12");
	subsubTable4.put("subCode", "Q114");
	subsubTable4.put("title", "대상지 접근성 수준");
	subsubTable4.put("content", "ㆍ대중교통 기반이 잘 되어 있는지<br/>ㆍ진입도로가 있어 국도 등으로부터 사업대상지로 직접 진입이 가능한지<br/>ㆍ진출입로가 확보되어 접근성이 용이한 ");
	subsubTable4.put("judgmnet", "● 도시고속도로 안영TG에서 멀지 않아 접근성이 좋은 편이며 대중교통으로도 접근이 가능한 편임.<br/>● 계획처럼 대상지로의 진입도로를 더 넓힌다면 국도에서의 접근성도 좋은 편임.  <br/>● 다만 제1 뿌리공원과의 연계를 위한 대중교통이나 자동차의 접근성은 상대적으로 좋지 않은 편임.");
	subsubTable4.put("Improvements", "");
	subsubTable4.put("scoretype", "1");
	subsubTable4.put("score", "5");
	model.add(new LinkedHashMap<String, String>(subsubTable4)); // 새로운 LinkedHashMap으로 복사하여 추가
	subsubTable5.put("mainCode", "Q12");
	subsubTable5.put("subCode", "Q115");
	subsubTable5.put("title", "대상지 내 시설물 입지 적절성 ");
	subsubTable5.put("content", "ㆍ공간 및 시설 도입・배치에 법적제한은 없는지 <br/>	ㆍ공간과 시설의 배치, 시설간의 동선(보행 등)이 적정하게 구성되어 있는지<br/>	ㆍ시설물의 디자인계획이 주변 자연환경과 조화를 이루도록 계획했는지 ");
	subsubTable5.put("judgmnet", "● 대상지내 시설물의 입지는 적절하나, 캠핑장과 조형물, 유아숲 등의 배치는 재고려가 필요함. 또한 시설 간의 동선 및 제1 뿌리공원과의 연계성이 부족함.  ");
	subsubTable5.put("Improvements", "● 캠핑장은 가능한 능선에 위치하되 등산로로부터의 독립성을 보장하도록 하고, 등산로를 통한 입출입이 용이한 상황에서 입장료를 받기 위한 공간을 조성하기가 상당히 어려울 것이므로 이를 감안하여 시설 설계를 해야 함. 또한 실시설계에서 시설간 배치를 재고려해야 할 것임. ");
	subsubTable5.put("scoretype", "2");
	subsubTable5.put("score", "10");
	model.add(new LinkedHashMap<String, String>(subsubTable5)); // 새로운 LinkedHashMap으로 복사하여 추가
	subsubTable6.put("mainCode", "Q13");
	subsubTable6.put("subCode", "Q116");
	subsubTable6.put("title", "지역주민 참여활성화 방안 수립 여부");
	subsubTable6.put("content", "ㆍ계획수립과정에 지역주민이 참여했거나, 현재 지역주민이 참여하고 있는지<br/>	ㆍ사업내용에 주민참여를 위한 계획(지역주민설명회 개최)이 포함되어 있는지<br/>	ㆍ지역주민 고용을 위한 계획은 있는지");
	subsubTable6.put("judgmnet", "● 계획수립 과정에 지역주민이 참여하고 있거나 공청회나 설명회가 있지는 않았음.<br/>	● 관광지 시설 자체가 주민여가공간으로의 활용성이 높고 시설운영에 있어서 지역주민 고용을 위한 고려는 가능할 것으로 보임.  ");
	subsubTable6.put("Improvements", "● 운영계획 수립단계에서 지역주민의 고용 가능성을 확인하여 적극 추진할 것을 추천함. ");
	subsubTable6.put("scoretype", "1");
	subsubTable6.put("score", "7");
	model.add(new LinkedHashMap<String, String>(subsubTable6)); // 새로운 LinkedHashMap으로 복사하여 추가
	subsubTable7.put("mainCode", "Q13");
	subsubTable7.put("subCode", "Q117");
	subsubTable7.put("title", "지속운영 가능성");
	subsubTable7.put("content", "ㆍ지속적 수익원(cash cow)이 되는 목표시장과 시설, 프로그램, 상품 등이 있는지<br/>	ㆍ향후 운영・관리를 위한 예산이 확보되었거나 지원계획이 있는지");
	subsubTable7.put("judgmnet", "● 목표시장은 수립되어 있고 캠핑장이나 글램핑장이 지속적 수익원이 될 수는 있을 것으로 보임. 다만 타당성 보고서에서도 적시되어 있듯이 경제적 타당성은 다소 결여되어 있으므로 향후 이를 보완할 필요가 있음.");
	subsubTable7.put("Improvements", "● 지속운영 가능성을 높이기 위해서 제2 뿌리공원의 매력물을 중심으로 한 프로그램의 개발이 필요하며 다양한 기념품이나 식음사업 또한 캠핑장을 규모의 경제 달성이 가능한 공간으로 만들 필요가 있음. 또한 향후 운영 주체를 어떻게 할지에 대한 고려가 사전에 있어야 할 것임. <br/>	● 유교 테마인 성씨문화 중심의 관광매력물 시설 공간의 재구성이 필요함(조형물에서 벗어나 제1 뿌리공원과는 다른 성씨 문화의 스토리텔링 콘텐츠화가 요구됨).");
	subsubTable7.put("scoretype", "1");
	subsubTable7.put("score", "3");
	model.add(new LinkedHashMap<String, String>(subsubTable7)); // 새로운 LinkedHashMap으로 복사하여 추가

	
    // 맵에 값을 추가합니다.
    request.setAttribute("model", model); // 이 맵을 request 속성에 추가합니다.
    
%>

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
    position: fixed;
    top: 560px;
    left: 30px;
    width: 45%;
    height: 85%;
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
	
    	<div class="contents-wrap" style="width:50%">
			<div class="wrapper sub" id="toptop" style="max-width:100%; background-color: #EDEEEE;"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
   				<div class="container">
   				
					<div id="pdfModal">
					<p class="section-title">사업설명서</p>
					  <!-- 모달창 컨텐츠 -->
						<div class="pdf-viewer">
							<object data='/1/Week01/data/download01/01.pdf#pagemode=thumbs&scrollbar=1&toolbar=1&statusbar=1&messages=1&navpanes=1'  
									type='application/pdf' width='100%' height='100%'>
								<p>This browser does not support inline PDFs. Please download the PDF to view it: <a href="/1/Week01/data/download01/01.pdf">Download PDF</a></p>
							</object>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		
		
		
    	<div class="contents-wrap" style="width:50%">
			<div class="wrapper sub" style="max-width:100%"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
   				<div class="container">
		            <p class="section-title">참조파일<small class="silent">아래 첨부파일을 다운로드하여 참고하세요</small></p>
		            <table class="evtdss-form-table noMargin">
		                <tr>
		                    <th>구분</th>
		                    <th class="fix-width file">첨부파일</th>
		                    <th class="fix-width date">등록일시</th>
		                </tr>
		                <tr>
		                    <td>평가의견서 샘플</td>
		                    	<td class="fix-width file">
		                         <a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocC.EVALU_FILE_NO}" title="평가의견서 샘플"><img src="../../../images/icon_file_hwp.jpg"></a>
		                     </td>
		                     <td class="fix-width date">${evaluDocC.REGI_DATE}</td>
		                </tr>
		                <tr>
		                    <td>${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM} 평가지침서</td>
		                    	<td class="fix-width file">
		                         <a title="평가지침서 샘플"><a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocA.EVALU_FILE_NO}" title="평가지침서 샘플"><img src="../../../images/icon_file_hwp.jpg"></a></a>
		                     </td>
		                     <td class="fix-width date">${evaluDocA.REGI_DATE}</td>
		                </tr>
		            </table>
		            
		            <!-- Contents -->
		            <p class="section-title" style="margin-top: 30px">평가의견서 등록<small class="silent">제출 전 첨부파일을 확인하시기 바랍니다.</small></p>
		
					<c:set var="count1" value="0"/> <!-- 순번을 위한 변수 초기화 -->
					<c:set var="count2" value="0"/> <!-- 순번을 위한 변수 초기화 -->
					<ul>
						<c:forEach items="${model}" var="item" varStatus="status">
						<!-- 대분류인 경우에만 출력합니다. -->
							<c:if test="${item['mainCode'] == 'Q'}">
							<c:set var="count1" value="${count1 + 1}"/>
							  <li>${count1}. ${item['title']} (점수: ${item['score']})
							      <ul class="node">
							          <c:forEach items="${model}" var="subitem" varStatus="subStatus">
							              <!-- 대분류와 하위 항목의 관계를 확인하여 출력합니다. -->
											<c:if test="${subitem['mainCode'] == item['subCode']}">
												<c:set var="count2" value="${count2 + 1}"/>
												<li>${count2}) ${subitem['title']} (점수: ${subitem['score']})
													<c:forEach items="${model}" var="subsubitem" varStatus="subsubStatus">
							                             <!-- 하위 항목과 관련된 내용 출력 -->
														<c:if test="${subsubitem['mainCode'] == subitem['subCode']}">
															<table class="evtdss-form-table">
																<tr>
																	<th style=text-align:left;> ${subsubitem['title']} <br/><span style=color:red; >(${subsubitem['score']})</span></th>
															        <td style=text-align:left;> ${subsubitem['content']}</td>
																</tr>
																
																<tr>
																    <td colspan="2">
																        <!-- 구분 타이틀 줄 -->
																        <div style="display: flex; width: 100%; padding-bottom: 10px; border-bottom: 1px solid #ccc;">
																            <span style="flex: 1; font-weight: bold; border-right: 1px solid #ccc;">구분</span>
																            <c:forEach var="itemm" items="${model}">
																                <c:if test="${subsubitem['scoretype'] == itemm.sysScore}">
																                    <span style="flex: 1; text-align: center; border-right: 1px solid #ccc;">${itemm.title}</span>
																                </c:if>
																            </c:forEach>
																        </div>
																        
																        <!-- 점수 줄 -->
																        <div style="display: flex; width: 100%; padding-bottom: 10px; border-bottom: 1px solid #ccc;">
																            <span style="flex: 1; font-weight: bold; border-right: 1px solid #ccc;">점수</span>
																            <c:forEach var="itemm" items="${model}">
																                <c:if test="${subsubitem['scoretype'] == itemm.sysScore}">
																                    <span style="flex: 1; text-align: center; border-right: 1px solid #ccc;">${itemm.score}</span>
																                </c:if>
																            </c:forEach>
																        </div>
																        
																        <!-- 체크란 줄 -->
																        <div style="display: flex; width: 100%; padding-bottom: 10px;">
																            <span style="flex: 1; font-weight: bold; border-right: 1px solid #ccc;">체크란</span>
																            <c:forEach var="itemm" items="${model}">
																                <c:if test="${subsubitem['scoretype'] == itemm.sysScore}">
																                    <span style="flex: 1; text-align: center;  border-right: 1px solid #ccc;"><input role="checkbox" id="cb_grid" class="cbox" type="checkbox"></span>
																                </c:if>
																            </c:forEach>
																        </div>
																    </td>
																</tr>
															    
																<tr class="content-box">
																    <td colspan="2">
																        <span class="content-title">판단의견</span>
																        <textarea style="width:820px; height:80px; "name="judgment">${subsubitem['judgmnet']}</textarea>
																        <br/><br/>
																        <span class="content-title">개선사항</span>
																        <textarea style="width:820px; height:80px; "name="improvements">${subsubitem['Improvements']}</textarea>
																        <br/><br/>
																    </td>
																</tr>
															</table>
														</c:if>
													</c:forEach>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:if>
						</c:forEach>
					</ul>	
					
					
					
		                  
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
					        	평가의견서
					    </td>
					    <td>
					        <input type="file" name="upload" class="regi-file-input" _docuType="PLYY" _atthType="AT12" id="AT12">
					        <c:if test="${fileInfo == null}">
					       	<div class="regi-file" rel="N">등록파일 없음</div>
					       	<div class="incell-btn button-set hor">
					            <button type="button" class="inline-button green"><a onclick="doc_save('AT12');" title="선택파일 추가">저장</a></button>
					        </div>
					       </c:if>
					       <c:if test="${fileInfo != null}">
					       	<div class="regi-file" rel="Y" fileNo="${fileInfo.EVALU_FILE_NO}">${fileInfo.FILE_ORG_NM}</div>
					       	<div class="incell-btn button-set hor">
					            <button type="button" class="inline-button green"><a onclick="doFileDelete('${viewCommitStatus.REVIEW_YN}')" title="등록파일 삭제">삭제</a></button>
					        </div>
					       </c:if>
					        
					        <div class="regi-file">등록파일 없음</div>
					        <div class="incell-btn button-set hor">
					            <button class="inline-button green"><a href="#" title="선택파일 추가">저장</a></button>
					            <button class="inline-button green"><a href="#" title="등록파일 삭제">삭제</a></button>
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
		
					<div class="body-descriptions">
					    파일명에 <strong>이름 및 소속 등의 개인정보는 반드시 삭제 후 <span class="txt-heightlight">한글(.hwp)</span>파일로 업로드</strong>하여 주시기 바랍니다.<br>
					    <br>
					    아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">평가의견서</span>가 제출</strong>되며 관리자가 승인하기 전에는 제출취소를 통해 철회할 수 있습니다.<br>
					    내용이 정확한지 최종적으로 확인하신 후 진행하시기 바랍니다.<br>
					</div>
		             
					<div class="submit-set fixed-div">
						<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
							<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="저장하기">저장하기</a></button>
							<button type="button" class="evtdss-submit" id="modalBtn"><a title="점수확인">점수확인</a></button>
						</c:if>
						<c:if test="${viewCommitStatus.OPINION_YN == 'Y' && viewCommitStatus.OPINION_APV_YN != 'Y'}">
							<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
						</c:if>
							<div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div>
					</div>
				</div>
			</div>
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
			console.log("scrollY의 높이"+scrollY);
			
			var totalHeight = document.body.scrollHeight
			console.log('총 높이'+totalHeight);
			
			var footerElement = document.querySelector('footer');
			var footerTopRelative = footerElement.getBoundingClientRect().top;
			var scrollOffset = window.pageYOffset || document.documentElement.scrollTop;
			var footerTopAbsolute = footerTopRelative + scrollOffset;
			console.log("Footer의 문서 최상단부터의 위치:", footerTopAbsolute);
			
			var pdfModalElement = document.getElementById('pdfModal');
			var pdfModalHeight = pdfModalElement.offsetHeight;
			console.log("pdfModal의 높이:", pdfModalHeight);
			// 화면 중앙까지의 거리 계산
			var distanceToCenter = (windowHeight / 2) - (pdfModal.offsetHeight / 2);
			if(scrollY + pdfModalHeight  + 50> footerTopAbsolute){
				pdfModal.style.top = -5 + '%';
			} else if (scrollY > 470) {
				var newTop = Math.min(distanceToCenter, scrollY) + 40;
				console.log('s'+newTop);
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
	});
</script>
</body>
</html>