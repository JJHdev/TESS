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
<style>
.tab {
  overflow: hidden;
  background-color: #f1f1f1;
  border-radius: 8px;
}

/* 탭 버튼 스타일 */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
  border-radius: 8px 8px 0 0;
}

/* 탭 버튼 - 마우스 오버 스타일 */
.tab button:hover {
  background-color: #ddd;
}

/* 탭 버튼 - 활성화된 탭의 스타일 */
.tab button.active {
  background-color: #ccc;
}

/* 탭 내용 스타일 */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
  background-color: #fff;
  border-radius: 0 0 8px 8px;
}

/* 탭 내용의 제목 스타일 */
.tabcontent h3 {
  margin-top: 0;
}
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}

/* 탭 버튼 스타일 */
.tablinks {
  background-color: inherit;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
}

.tablinks:hover {
  background-color: #ddd;
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

	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>평가사업조회</li>
	                    <li>평가완료사업</li>
	                    <li>${mastMap.evaluBusiNmInfo}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가완료사업</h3>
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
	                        <li class=""><a onclick="fn_goBusiInfo();" title="사업정보">사업정보</a></li>
	                        <li class="active"><a title="평가정보">평가정보</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/busi/listEvaluEndBusi.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">평가정보</h4>
	                            <a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	                        <!-- Contents -->
	
	                        <p class="section-title">평가의견서<small class="silent">평가진행현황입니다.</small></p>
	                        <!-- 관리자 전용 -->
	                        
	                        <!-- 탭 버튼 -->
							<div class="tab">
							  <button class="tablinks" onclick="openTab(event, 'TabA')">평가위원 A</button>
							  <button class="tablinks" onclick="openTab(event, 'TabB')">평가위원 B</button>
							  <button class="tablinks" onclick="openTab(event, 'TabC')">평가위원 C</button>
							</div>
							
							<!-- 탭 내용 -->
							<div id="TabA" class="tabcontent" style="display:black;">
							  <h3>평가위원 A</h3>
							  <p>평가위원 A의 내용입니다.</p>
							</div>
							
							<div id="TabB" class="tabcontent">
							  <h3>평가위원 B</h3>
							  <p><div id="test"></div></p>
							</div>
							
							<div id="TabC" class="tabcontent">
							  <h3>평가위원 C</h3>
							  <p>평가위원 C의 평가의견서 입니다.</p>
							</div>
	                        
	                        
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
	
	                        <p class="section-title" style="margin-top:100px;">종합결과</p>
	                        <div id="test2"></div>
	                        
	
	                        <p class="section-title" style="display:flex; justify-content: space-between;">평가정보 첨부파일
							</p>
							<table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
							    <thead>
							        <tr>
							            <th scope="col" style="width:70%;">구분</th>
		                                <th scope="col" style="width:30%;" class="fix-width file">첨부파일</th>
							        </tr>
							    </thead>
							    <tbody id="tableBody">
							        <c:forEach items="${sysUldFileList}" var="fileType">
							            <c:if test="${fileType.CODE eq 'AT06' or fileType.CODE eq 'AT07' or fileType.CODE eq 'AT08' or fileType.CODE eq 'AT09'}">
							                <tr>
							                    <td>
								                    ${fileType.CODE_NM}
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
							                </tr>
							            </c:if>
							        </c:forEach>
							   	 </tbody>
							</table>
	
	                    </div>
	                </div>
	            </div> <!-- /.container -->
	
	        </div>
	    </div>
	
	</div> <!-- /contents-wrap -->
	
	
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