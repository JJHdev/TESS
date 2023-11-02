<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
		<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
	<!-- 네이버 에디터 -->
	<script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<!-- 네이버 에디터 -->
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ========================= -->
<!-- ======================================================= -->
	
<div class="contents" >.

<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>
<form:form commandName="model" name="model" id="model"  enctype="multipart/form-data">

    <%-- pk --%>
    <input type="hidden" name="mode"        id="mode"        value='<c:out value="${paramMap.mode }"/>'>
    
    <%-- pk --%>
    <form:hidden path="evaluBusiNo" />
    <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}" />
    <input type="hidden" name="evaluId"  id="evaluId" value="${paramMap.evaluId }"/>
    <input type="hidden" name="evaluInptCulm"  id="evaluInptCulm"/>     
    <input type="hidden" name="evaluFndSeq"  id="evaluFndSeq"/>
    <input type="hidden" name="evaluProcStep"  id="evaluProcStep" value="${paramMap.evaluProcStep }"/> 
    <input type="hidden" name="curtEvaluCode" id ="curtEvaluCode" value='<c:out value="${evaluStageLvl2.code}"/>'/>      
    <input type="hidden" name="regiMode"  id="regiMode"/>       
    <input type="hidden" name="evaluEtcSeq"  id="evaluEtcSeq" value="${paramMap.evaluEtcSeq}" />       
	
	<div class="contentsTilteLine">
		<strong>계획평가 평가정보 입력</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가대상</a></li>
			<li><a href="#">계획평가</a></li>
			<li>상세화면</li>
		</ol>
	</div>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div class="tab-pane active">

				<h4>${evaluStageLvl2.codeNm }</h4>
			
			<c:forEach items="${evaluInptItem }" var="item" varStatus="idx">	
				<h5>${item.codeNm }</h5>
			</c:forEach>	
				<!-- Table -->
				<table class="table tableNormal thCenter tdCenter">
					<colgroup>
						<col style="width: 100px;">
						<col style="width: *;">
					</colgroup>
					<tbody>
						<tr class="top2">
							<th class="leftNoLine">제목</th>
							<th colspan="3">컨설팅 제안 내용</th>
						</tr>
					<c:forEach items="${evaluInptItem }" var="item" varStatus="idx">
						<tr> 
							<td>${paramMap.evaluEtcSeq}</td>
							<td>
								<input type="text" class="form-control input-sm"  name="txt${item.code }" id="dpthFinalTxt" title="컨설팅 제안제목" value="${fndList[idx.count-1].evaluEtcVal }">
								<input type="hidden" class="form-control input-sm" value="${paramMap.evaluEtcSeq}"  name="seq${item.code }" >
							</td>
						</tr>
						<tr class="bottom">
							<td colspan="3" style="padding:10px 5px;" class="leftNoLine rightNoLine"> 
								<textarea rows="20" cols="135" id="dpthFinalDesc" title="${item.codeNm }" name="${item.code }">${fndList[idx.count-1].evaluFndVal }</textarea>
								<input type="hidden" name="arrEvaluFndSeq"  value="${fndList[idx.count-1].evaluFndSeq }"/>
							</td>
						</tr>							
					</c:forEach>	 
					</tbody>
				</table><!-- //Table-->				
				
		</div><!-- //tab-pane-->
	  </div><!-- //tab-content-->

	<div class="text-center" style="margin:50px 0;">
	<c:if test="${paramMap.mode eq 'regi' }">
		<a class="btn btn-green marginRright12" id="prcBtnAddSave" ><i class="icon-ic_keyboard_arrow_right">&nbsp;</i>추가저장</a>
	</c:if>
		<a class="btn btn-green marginRright12"  id="prcBtnSave"><i class="icon-ic_done_all">&nbsp;</i>저장</a>
	</div> 
							
</form:form>	

<!--  네이버 에디터 스크립트 -->
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "dpthFinalDesc",
	    sSkinURI: "../se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2",
           htParams :
           {
                     fOnBeforeUnload : function()
                     {
                     }
           }
	});
</script>
			
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
