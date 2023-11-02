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
</head>

<body id="top">
<div class="wrap">

<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
<!-- ======================================================= -->
	
<div class="contents" >

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model" enctype="multipart/form-data">

    <%-- pk --%>
    <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}" />
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluGubun" id="evaluGubun" value="${paramMap.evaluGubun}" />  
    <input type="hidden" name="evaluBusiNo" id="evaluBusiNo" value="${paramMap.evaluBusiNo}" />  
    
	<div class="contentsTilteLine">
		<strong>사전평가 평가정보 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상 2017년</a></li>
			<li><a href="#">사전평가</a></li>
			<li>평가정보 입력</li>
		</ol>
	</div>
	
	<div class="tab-content">
	    <div class="tab-pane active">
			<h4>첨부파일</h4>
			<h5>검토의견서</h5>
			<div style="display: inline;" class="_dyFileAreaCls">
				<div style="display: inline;" class="_dynamicGroup">
					<ul class="file_input" style="position:relative; float:left; cursor:pointer;">
						<li class="fileName" style="padding: 1px;">
							<input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" disabled="disabled" readonly="readonly" value="${CT410Map.FILE_ORG_NM}">
							<div class="file_input_div">
								<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button btn btn-smOrange" />
								<input type="file"  name="upfile0"class="file_input_hidden" onchange="javascript:fn_checkFileObjValid(this)"  title="파일첨부"/> 
							</div>
						</li>
					</ul>
				</div>
			</div>
			<br><br><br>
  			<h4>사업준비도(40)</h4>
			<h5>가. 사전점검요인(30)</h5>
			<div class="alert">
			· &nbsp;지역발전 특별회계, 기금 등의 국고보조금 대상사업으로 적합한지 사전행정절차이행을 완료했는지<br>&emsp;등을 검토하고 담당 지자체의 사업 추진을 위한 노력성을 진단
			<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 17%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr> 
							<th>항목</th><th colspan="6">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 보조금지원사업<br>&emsp;적합성(10)</td><td colspan="6">- 역사·문화·관광·레포츠·생태자원 등을 활용한 관광자원개발사업에 해당되는지 여부<br>
						   &emsp;  · 관광자원개발 가이드라인에서 허용하는 사업(체험시설, 휴양시설, 관람 및 전시시설, 문화재 주변 정비 시설,<br>&emsp;안내 및 편의 시설 등)<br>- 관광개발 및 관광활동 지원과 무관한 사업에 해당되는지 여부<br>
						   &emsp;  · 균특법, 보조금 관련법 등에서 제외하는 사업(도로 개보수비(진입도로 제외), 토지매입비, 지장물 보상비, <br>&emsp;기본 계획 수립비, 각종 조사비, 제영향평가비, 에너지사업계획비, 각종 부담금(공공기반시설 설치를 위한<br>&emsp; 부담금제외) 등)</td>
					</tr>
					<tr  align="center">
						<td  colspan="3" >적합(10)</td><td colspan="3">부적합(0)</td>
					</tr>
					<tr  align="center">
						<td colspan="3"><input type="radio" name="PV211" value="10">  </td><td colspan="3"><input type="radio" name="PV211" value="0"></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 사전행정절차<br>&emsp;이행여부(10)</td><td colspan="6">- 기본계획수립, 기본설계 및 실시설계 수립, 지방재정투자심사, 사업부확보, 지방비 확보, 관련법령 인·허가 등 사전행정절차 이행 여부</td>
					</tr>
					<tr align="center">
						<td  colspan="2">모든 사전행정절차<br>이행완료(10)</td><td colspan="2">일부 법적·행정적 절차를<br>이행하지 않았으나 연내 해결<br> 가능함(5)</td><td colspan="2">일부 법적·행정적 절차를<br>이행하지 않았고 연내 해결이<br>가능하지 않음(0)</td>
					</tr>
					<tr align="center">
						<td colspan="2"><input type="radio" name="PV212" value="10">  </td><td colspan="2"><input type="radio" name="PV212" value="5"></td><td colspan="2"><input type="radio" name="PV212" value="0"></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">3. 사업추진의지(10)</td><td colspan="5">- 지자체의 공약사업, 지자체 업무계획 포함, 중기지방재정계획에 예산 반영, 전문가 자문회의 개최,<br>&emsp;주민의견수렴 등 사업추진을 위한 노력 현황</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(10)</td><td colspan="1">우수(8)</td><td colspan="1">보통(6)</td><td colspan="1">미흡(4)</td><td colspan="1">매우미흡(2)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV213" value="10"><td colspan="1"><input type="radio" name="PV213" value="8"><td colspan="1"><input type="radio" name="PV213" value="6"><td colspan="1"><input type="radio" name="PV213" value="4"><td colspan="1"><input type="radio" name="PV213" value="2">
					</tr>
				</tbody>
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV210" title="PV210" name="PV210">${PV210Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			
			<h5>나. 입지적합성(10)</h5>
			<div class="alert">
				· &nbsp;사업적합 부지 현황과 부지 내 시설물 입지 적합여부를 종합적으로 고려하여 평가
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 사업부지<br>&emsp;적합성(5)</td><td colspan="5">- 토지이용상 법적 규제, 진출입로, 접근성, 경관훼손 등 입지 적합 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우적절(5)</td><td colspan="1">적절(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV221" value="5"><td colspan="1"><input type="radio" name="PV221" value="4"><td colspan="1"><input type="radio" name="PV221" value="3">
						<td colspan="1"><input type="radio" name="PV221" value="2"><td colspan="1"><input type="radio" name="PV221" value="1">
					</tr>
				</tbody>
								<tbody>
					<tr>
						<td rowspan="3">2. 사업부지 내<br>&emsp;시설물<br>&emsp;입지적합성(5)</td><td colspan="5">- 시설계획, 시설 도입상 법적 규제, 공간과 시설의 배치, 동선 계획, 디자인 계획 등 시설물 도입 적합 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우적절(5)</td><td colspan="1">적절(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV222" value="5"><td colspan="1"><input type="radio" name="PV222" value="4"><td colspan="1"><input type="radio" name="PV222" value="3">
						<td colspan="1"><input type="radio" name="PV222" value="2"><td colspan="1"><input type="radio" name="PV222" value="1">
					</tr>
				</tbody>
				
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV220" title="PV220" name="PV220">${PV220Map.EVALU_FND_VALUE}</textarea>
			</div>
		
			
			
			
   			<h4>내용적정성(30)</h4>
			<h5>가. 사업 목적 부합성(10)</h5>
			<div class="alert">
				· &nbsp;상위계획 및 유관 계획과 개발 콘셉트의 부합성, 불필요한 시설 및 프로그램의 도입여부, 주변<br>&emsp;자연환경과의 조화정도, 체험프로그램의 적정성 등을 종합적으로 평가
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 유관계획과의<br>&emsp;적합성(5)</td><td colspan="5">- 상위(유관)계획과의 연계성 여부(해당시)</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우적절(5)</td><td colspan="1">적절(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV311" value="5"><td colspan="1"><input type="radio" name="PV311" value="4"><td colspan="1"><input type="radio" name="PV311" value="3">
						<td colspan="1"><input type="radio" name="PV311" value="2"><td colspan="1"><input type="radio" name="PV311" value="1">
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 사업추진<br>&emsp;당위성(5)</td><td colspan="5">- 사업목적 및 개발컨셉과 사업내용의 부합성 등 사업추진 당위성 여부에 대한 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우적절(5)</td><td colspan="1">적절(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV312" value="5"><td colspan="1"><input type="radio" name="PV312" value="4"><td colspan="1"><input type="radio" name="PV312" value="3">
						<td colspan="1"><input type="radio" name="PV312" value="2"><td colspan="1"><input type="radio" name="PV312" value="1">
					</tr>
				</tbody>
				
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV310" title="PV310" name="PV310">${PV310Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			<h5>나. 사업규모 적정성(10)</h5>
			<div class="alert">
			· &nbsp;사업대상지의 여건과 방문객을 고려한 사업규모가 제시된 것인지, 사업내용에 따른 사업비가 적정한 지 등을 고려하여 진단.
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 수요예측의<br>&emsp;적정성(5)</td><td colspan="5">- 객관적인 관광수요의 추정 여부, 추정치의 적정 수준 여부 등 수요예측의 적정성 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우적절(5)</td><td colspan="1">적절(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV321" value="5"><td colspan="1"><input type="radio" name="PV321" value="4"><td colspan="1"><input type="radio" name="PV321" value="3">
						<td colspan="1"><input type="radio" name="PV321" value="2"><td colspan="1"><input type="radio" name="PV321" value="1">
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 수요대비<br>&emsp;사업규모<br>&emsp;적정성(5)</td><td colspan="5">- 시설, 프로그램, 부지조성비 및 건축비 등 수요대비 규모적정성 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우적절(5)</td><td colspan="1">적절(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV322" value="5"><td colspan="1"><input type="radio" name="PV322" value="4"><td colspan="1"><input type="radio" name="PV322" value="3">
						<td colspan="1"><input type="radio" name="PV322" value="2"><td colspan="1"><input type="radio" name="PV322" value="1">
					</tr>
				</tbody>
				
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV320" title="PV320" name="PV320">${PV320Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			<h5>다. 사업 특화성(10)</h5>
			<div class="alert">
				· &nbsp;매력적인 관광자원으로서 역할 수행가능성, 지역(대성자) 여건과 부합하는 독창적 사업내용 여부 등을 검토 하여 진단
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 관광콘텐츠의<br>&emsp;매력성(5)</td><td colspan="5">- 핵심 관광콘텐츠의 존재 여부, 독창적 관광콘텐츠 발굴 여부 등 관광콘텐츠의 매력성 여부에 대한 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr>
						<td colspan="1"><input type="radio" name="PV331" value="5"><td colspan="1"><input type="radio" name="PV331" value="4"><td colspan="1"><input type="radio" name="PV331" value="3">
						<td colspan="1"><input type="radio" name="PV331" value="2"><td colspan="1"><input type="radio" name="PV331" value="1">
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 관광콘텐츠의<br>&emsp;독창성(5)</td><td colspan="5">- 유사 및 경쟁시설과의 차별성 보유 및 사업의 독창성 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV332" value="5"><td colspan="1"><input type="radio" name="PV332" value="4"><td colspan="1"><input type="radio" name="PV332" value="3">
						<td colspan="1"><input type="radio" name="PV332" value="2"><td colspan="1"><input type="radio" name="PV332" value="1">
					</tr>
				</tbody>
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV330" title="PV330" name="PV330">${PV330Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			<h5>라. 사업 중복성(0)</h5>
			<div class="alert">
			· &nbsp;동일 사업에 대해 (부처 간)중복적 투자와 정책적 유사사업의 존재 여부를 파악하고, 인근 지역에 동일하거나 유사정도가 높은 사업 &emsp;또는 사업계획이 존재하는지를 수요 확보 가능성과 연결하여 종합적으로 진단
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 유사중복 비교표 작성<br>&emsp;충실성(5)</td><td colspan="5">- 유사중복 비교표 작성 충실성에 대한 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(0)</td><td colspan="1">우수(-1)</td><td colspan="1">보통(-2)</td><td colspan="1">미흡(-3)</td><td colspan="1">매우미흡(-4)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV341" value="0"><td colspan="1"><input type="radio" name="PV341" value="-1"><td colspan="1"><input type="radio" name="PV341" value="-2">
						<td colspan="1"><input type="radio" name="PV341" value="-3"><td colspan="1"><input type="radio" name="PV341" value="-4">
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 타 사업과의 중복성(5)</td><td colspan="5">- 인접 지역 또는 지역 내 동일/유사사업의 존재 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">유사사업<br>없음(0)</td><td colspan="1">유사사업<br>있으나<br>관광수요 확보<br>가능성<br>높음(-1)</td><td colspan="1">유사사업<br>있으나<br>관광수요 확보<br>가능성<br>있음(-2)</td><td colspan="1">유사사업<br>있으며 다소<br>중복성이<br>있음(-3)</td><td colspan="1">유사사업<br>있으며<br>중복성이<br>큼(-4)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV342" value="0"><td colspan="1"><input type="radio" name="PV342" value="-1"><td colspan="1"><input type="radio" name="PV342" value="-2">
						<td colspan="1"><input type="radio" name="PV342" value="-3"><td colspan="1"><input type="radio" name="PV342" value="-4">
					</tr>
				</tbody>
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV340" title="PV340" name="PV340">${PV340Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			<h4>3. 집행 가능성 및 사업 효과성(30)</h4>
			<h5>가. 운영가능성(10)</h5>
			<div class="alert">
			· &nbsp;사업추진인력에 대한 계획 수립 여부, 시설 및 프로그램 관리운영 준비여부, 지역주민 협력 여부에 대한 진단
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 관리·운영 계획<br>&emsp;수립 여부(5)</td><td colspan="5">- 관리운영계획 수립(사업추진 조직 및 인력 계획 포함), 운영주체 선정, 운영주체의 적합성, 유료 이용 요금 책정의 적정성 등 시설 및 프로그램 관리운영에 대한 준비 여부</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV411" value="5"><td colspan="1"><input type="radio" name="PV411" value="4"><td colspan="1"><input type="radio" name="PV411" value="3">
						<td colspan="1"><input type="radio" name="PV411" value="2"><td colspan="1"><input type="radio" name="PV411" value="1">
					</tr>
				</tbody>
								<tbody>
					<tr>
						<td rowspan="3">2. 지역주민 협력<br>&emsp;여부(5)</td><td colspan="5">- 지역주민 설명회, 주민 참여도, 주민요구사업 등 사업에 대한 지역주민의 의지를 종합적으로 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV412" value="5"><td colspan="1"><input type="radio" name="PV412" value="4"><td colspan="1"><input type="radio" name="PV412" value="3">
						<td colspan="1"><input type="radio" name="PV412" value="2"><td colspan="1"><input type="radio" name="PV412" value="1">
					</tr>
				</tbody>
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV410" title="PV410" name="PV410">${PV410Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			
			<h5>나. 사업 실현 가능성(10)</h5>
			<div class="alert">
				· &nbsp;유료시설 및 프로그램의 수익 등 자체발생 수입으로 지속운영이 가능한지에 대한 여부와, 공공예산의 지속 투입을 통해서라도 유지가  &emsp;필요한 사업인가에 대한 당위성 여부를 진단
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 17%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 사업의<br>&emsp;실현가능성(5)</td><td colspan="5">- 사업계획의 목적달성 가능 여부, 사업기간 내 완료 가능성 등 사업의 실현가능성에 대한 종합적인 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV421" value="5"><td colspan="1"><input type="radio" name="PV421" value="4"><td colspan="1"><input type="radio" name="PV421" value="3">
						<td colspan="1"><input type="radio" name="PV421" value="2"><td colspan="1"><input type="radio" name="PV421" value="1">
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 사업의<br>&emsp;지속가능성(5)</td><td colspan="5">- 유료시설 및 프로그램의 수익 등 자체발생 수입으로 지속운영 가능여부 판단<br>&emsp; - 공공예산의 지속 투입을 통해 유지가 필요한 사업인가에 대한 당위성 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV422" value="5"><td colspan="1"><input type="radio" name="PV422" value="4"><td colspan="1"><input type="radio" name="PV422" value="3">
						<td colspan="1"><input type="radio" name="PV422" value="2"><td colspan="1"><input type="radio" name="PV422" value="1">
					</tr>
				</tbody>
					<tbody>
					<tr>
						<td rowspan="3">3. 민자유치<br>&emsp;가능성(민자유치계<br>&emsp;획이 있는 경우)(0)</td><td colspan="5">- 민자유치 가능성에 대한 판단(해당시)<br>&emsp;&nbsp; * 설명회개최 및 참가업체 유무, 투자의향서, 확약서, 계약서 등의 자료를 기준으로 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우높음(0)</td><td colspan="1">높음(-1)</td><td colspan="1">보통(-2)</td><td colspan="1">낮음(-3)</td><td colspan="1">매우낮음(-4)</td>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV423" value="0"><td colspan="1"><input type="radio" name="PV423" value="-1"><td colspan="1"><input type="radio" name="PV423" value="-2">
						<td colspan="1"><input type="radio" name="PV423" value="-3"><td colspan="1"><input type="radio" name="PV423" value="-4">
					</tr>
				</tbody>
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV420" title="PV420" name="PV420">${PV420Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			<h5>다. 사업 효과성(10)</h5>
			<div class="alert">
				· &nbsp;지자체에 미치는 사회/경제적 영향과 소득증대 및 고용 창출 효과에 대한 진단
				<table class="table tableNormal" id="evaluInfoTab">
				<colgroup>
					<col style="width: 17%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
					<col style="width: 16%;">
				</colgroup>
					<thead>
						<tr>
							<th>항목</th><th colspan="5">평가방법</th>
						</tr>
					</thead>
				<tbody>
					<tr>
						<td rowspan="3">1. 지역관광발전 및<br>&emsp;경제활성화<br>&emsp;기여도(5)</td><td colspan="5">- 지역관광발전 및 지자체에 미치는 사회적/경제적 영향을 종합적으로 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					</tr>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV431" value="5"><td colspan="1"><input type="radio" name="PV431" value="4"><td colspan="1"><input type="radio" name="PV431" value="3">
						<td colspan="1"><input type="radio" name="PV431" value="2"><td colspan="1"><input type="radio" name="PV431" value="1">
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2. 지역민 소득<br>&emsp;증대 및 고용<br>&emsp;창출 효과(5)</td><td colspan="5">- 지역 주민의 소득 증대 및 고용 창출 효과에 대한 판단</td>
					</tr>
					<tr align="center">
						<td colspan="1">매우우수(5)</td><td colspan="1">우수(4)</td><td colspan="1">보통(3)</td><td colspan="1">미흡(2)</td><td colspan="1">매우미흡(1)</td>
					<tr align="center">
						<td colspan="1"><input type="radio" name="PV432" value="5"><td colspan="1"><input type="radio" name="PV432" value="4"><td colspan="1"><input type="radio" name="PV432" value="3">
						<td colspan="1"><input type="radio" name="PV432" value="2"><td colspan="1"><input type="radio" name="PV432" value="1">
					</tr>
				</tbody>
					<tr>
							<th>총점</th><th colspan="6">(        )</th>
					</tr>
			</table>
				<textarea rows="10" cols="119" id="PV430" title="PV430" name="PV430">${PV430Map.EVALU_FND_VALUE}</textarea>
			</div>
			
			<h5>※평가 총괄표</h5>
			<div class="alert">
				<table class="table tableNormal" id="evaluInfoTab">
					<colgroup>
						<col style="width: 12.5%;">
						<col style="width: 12.5%;">
						<col style="width: 25%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>
					<thead>
						<tr align="center">
							<th>항목</th><th>평가방법</th><th >평가지표</th><th colspan="5">배점</th>
						</tr>
					</thead>
				<tbody>
					<tr align="center">
						<td rowspan="7">사업<br>준비도(40)</td><td  rowspan="4">사전점검<br>요인(30)</td>
					</tr>
					<tr >
						<td >보조금지원사업 적합성</td>	<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
				 	</tr>
					<tr>
						<td >사전행정 절차 이행 여부</td><td colspan="2"><input type="radio" name="PV431" value="5">10<td colspan="2"><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10
					</tr>
					<tr>
						<td>사업추진의지</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
					<tr align="center">
						<td  rowspan="3">입지적합성(10)</td>
					</tr>
					<tr>
					  <td>사업재상지의 입지 적합성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
					<tr>
					  <td>사업 대상지 내 시설물 입지 적절성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
				</tbody>
				<tbody>
					<tr align="center">
						<td rowspan="12">내용<br>적정성(30)</td><td  rowspan="3">사업 목적<br>부합성(10)</td>
					</tr>
					<tr >
						<td >유관계획과의 정합성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
				 	</tr>
					<tr>
						<td >사업추진의 당위성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
					<tr align="center">
						<td  rowspan="3">사업 특화성(10)</td>
					</tr>
					<tr>
					  <td>수요예측의 적정성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
					<tr>
					  <td>수요대비 사업규모 적정성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
						<tr align="center">
						<td  rowspan="3">사업 규모<br>적정성(10)</td>
					</tr>
					<tr>
					  <td>수요예측의 적정성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
					<tr>
					  <td>수요대비 사업규모 적정성</td><td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
						<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10<td><input type="radio" name="PV431" value="5">10
					</tr>
					
				</tbody>
				
				
				</table>
			</div>
			
			<div class="text-center" style="margin:55px 0;">
				<a class="btn btn-green marginRright12" id="prcBtnSave" ><i class="icon-ic_done_all">&nbsp;</i>저장</a>
				<a class="btn btn-red" id="prcBtnList"><i class="icon-ic_refresh">&nbsp;</i>취소</a>
			</div>
			
		</div>
    </div>
	    
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