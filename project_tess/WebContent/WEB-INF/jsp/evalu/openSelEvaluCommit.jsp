<%
 /****************************************************************************************
*** ID                  : viewTodeUserHist.jsp
*** Title               : [담당자 상세조회] 상세화면 popup 화면
*** Description         : [담당자 상세조회] 상세화면 popup 화면
***
*** -----------------------------    Modified Log   --------------------------------------
*** ver             date                        author                  description
***  -----------------------------------------------------------------------------------------
*** 1.0         2014-10-20                  LCS                         First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>
<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="popup" /><!-- style & javascript layout -->

<!-- tode공통 추가 js -->
<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>

<body>
<!-- header layout -->
<app:layout mode="headerPopup" title="담당자 상세조회"/>

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
<!-- ======================================================= -->



<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>

<form:form commandName="model" name="model" id="model">

    <%-- pk --%>
    <input type="hidden" name="mode"     id="mode"     />
    <input type="hidden" name="subMode"  id="subMode"  />
     <input type="hidden" name="page"       id="page"      value='<c:out value="${paramMap.page }"/>'/>
     
     <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchEvaluCommNm"  id="srchEvaluCommNm"  value='<c:out value="${paramMap.srchEvaluCommNm}"/>'/>
    </div>
    
        <%-- 평가위원 타켓 --%>
    <input type="hidden" name="targetId"  id="targetId"  value='<c:out value="${paramMap.targetId}"/>'/>
    
    
    <div style="width:600px; padding:0 0 0 10px;">
        <table class="style_search_01">
            <colgroup>
                <col width="60" >
                <col width="250" >
                <col width="120" >
                <col width="" >
            </colgroup>
            <tr>
                <th>지역</th>
                <td>
                    <select name="srchBusiAddr1Temp" id="srchBusiAddr1Temp" class="select_M" style="width:120px;">
                        <option value="">::전체::</option>
                    </select>
                    <select name="srchBusiAddr2Temp" id="srchBusiAddr2Temp" class="select_M" style="width:120px;">
                        <option value="">::전체::</option>
                    </select>
                </td>
                <th>평가분야</th>
                <td>
                    <select name="srchBusiTypeTemp" id="srchBusiTypeTemp" class="select_M" style="width:170px;" title="평가분야 조건">
                        <option value="">::전체::</option>
                        <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
                                <c:out value="${type.codeNm }"/>
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th><label for="srchEvaluBusiNmTemp">평가위원명</label></th>
                <td>
                    <input type="text" id="srchEvaluCommNmTemp" name="srchEvaluCommNmTemp" class="input_M" style="width:230px;" value='<c:out value="${paramMap.srchEvaluCommNm }"/>' />
                </td>
            </tr>
        </table>
        <!--//관리자-->
    
    </div>
    
    <div style="position:relative; margin:0; height:28px;">

    <!-- 관리자-->
    <div style=" position:absolute; top:0px; right:0px;">
        <span class="small_btn_01 small_color_03" id="prcBtnSrch"><a href="#link"><img src='<c:url value="/images/btns/icon_01.png"  />' alt="검색" ><strong>검색</strong></a></span>
        <span class="small_btn_01 small_color_01" id="prcBtnSect"><a href="#link"><img src='<c:url value="/images/btns/s_icon_01.png"/>' alt="평가위원선택" ><strong>평가위원선택</strong></a></span>
    </div>
    <!--//관리자-->

	</div>
	<div style="height:10px;"></div>

    <%-- 그리드 표시 영역 --%>
    <div class="round_top_01">
        <div class="round_bottom_01" >
            <div id="rsperror" title="Server Error Message...." style="color:red;"></div>
    
            <!-- Grid -->
            <div id="jqgrid" style="margin:0 0 6px 0px;">
                    <table style="vertical-align: top; width:100%;">
                    <tr>
                        <td style="vertical-align: top; ">
                            <table id="grid" class="grid"></table>
                            <div id="pager"></div>
                        </td>
                    </tr>
                    </table>
            </div>
    
            <div id="dialog" title="Feature not supported" style="display:none">
            <p><spring:message code="title.grid.dialog"/></p>
            </div>
    
            <div id="dialogSelectRow" title="Warning" style="display:none">
            <p><spring:message code="title.grid.dialog.selectrow"/></p>
            </div>
    
        </div>
    </div>
 
 
<div style="height:15px;"></div>

</form:form>


<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->

<!-- footer layout -->
<app:layout mode="footerPopup" />

</body>
</html>
