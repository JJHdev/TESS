<%
 /****************************************************************************************
*** ID                  : listLogAccMenu.jsp
*** Title               :  [관리자-메뉴별접속통계] 리스트 화면
*** Description         :  [관리자-메뉴별접속통계] 리스트 화면
***
*** -----------------------------    Modified Log   --------------------------------------
*** ver             date                        author                  description
***  -------------------------------------------------------------------------------------
*** 1.0         2014-11-19                      LCS                 First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>
<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

</head>

<body>
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
<!-- ======================================================= -->


<%-- +++++++++++++++++++++++++++++++++++++ --%>
<%-- FORM                                  --%>
<%-- +++++++++++++++++++++++++++++++++++++ --%>

<form:form commandName="model" name="model" id="model">


    <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchDateType"    id="srchDateType"  title="srchDateType"/>
        <input type="hidden" name="srchFromDate"    id="srchFromDate"  title="srchFromDate" />
        <input type="hidden" name="srchToDate"      id="srchToDate"   title="srchToDate"/>
        <input type="hidden" name="srchMenuNm"      id="srchMenuNm"   title="srchMenuNm"/>
        <input type="hidden" name="srchPersonUser"  id="srchPersonUser" title="srchPersonUser" />
    </div>



<div class="group_wrap_02">
    <div style="width:90%; padding:0 0 0 10px;">
        <table class="style_search_01">
            <colgroup>
                <col width="230" />
                <col width="600" />
                <col width="160" />
                <col width="" />
            </colgroup>
            <tr>
                <th>검색기간</th>
                <td>
                    <!--
                    <select name="srchDateTypeTemp" id="srchDateTypeTemp" style="width:100px;" title="검색기간 구분">
                        <option value="">::전체::</option>
                    </select>
                     -->
                    <input id="srchFromDateTemp" name="srchFromDateTemp" class="_calendar" style="width:85px; background:#f6f6f6" type="text" value="" title="시작일"/>
                    -
                    <input id="srchToDateTemp"   name="srchToDateTemp" class="_calendar" style="width:85px; background:#f6f6f6;" type="text" value="" title="종료일"/>

                </td>
                <th><label for="srchMenuNmTemp">메뉴명</label></th>
                <td>
                    <input type="text" id="srchMenuNmTemp" name="srchMenuNmTemp" style="width:200px;" title="메뉴명"/>
                </td>
            </tr>
            <!--
            <tr>
                <th>개인화 서비스 인원</th>
                <td colspan="1">
                    <input type="text" id="srchPersonUserTemp" name="srchPersonUserTemp" style="width:200px;" title="개인화 서비스 인원"/>
                </td>
            </tr>
			 -->
        </table>

    </div>
</div>
<div style="border-top:1px solid #ededed;"></div>


<div style="height:20px;"></div>



<div style="position:relative; margin:0; height:28px;">

    <!-- 관리자-->
    <div style=" position:absolute; top:0px; right:0px;">
        <span class="small_btn_01 small_color_03" id="prcBtnSrch">
            <a href="#link"><img src='<c:url value="/images/btns/icon_01.png"/>' alt="조회"><strong><spring:message code="btn.inquire"/></strong></a></span>
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


<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />

</body>
</html>