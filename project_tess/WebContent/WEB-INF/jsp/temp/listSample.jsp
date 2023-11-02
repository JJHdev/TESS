<%
 /****************************************************************************************
***	ID					: listSample.jsp
***	Title				: Template List Screen
***	Description			: Template List Page
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-06-16				ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>
<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script src="/js/common-dyUtil.js"></script>

<style>
    .formTitle {display: inline-block; width:150px; text-align: left; background-color: #eaeaea;}
    .subContent{background-color: #f7f7f7; padding: 10px;}
</style>
</head>

<body>
<!-- header layout -->
<app:layout mode="header" />

<!-- ==================== 중앙내용 시작 ==================== -->
<c:if test="${not empty map.gsUserId}">
<table width="100%">
<tr>
	<td width="30%"><spring:message code="title.test"  arguments="The screen, template"/></td>
	<td align="right">
		User Id : <font color="#00BD00"><c:out value="${map.gsUserId}"/> </font>&nbsp;&nbsp;
		User Name : <font color="#00BD00"><c:out value="${map.gsUserNm}"/> </font>&nbsp;&nbsp;
		Role Id : <font color="#00BD00"><c:out value="${map.gsRoleId}"/> </font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<a href="/j_logout_check.do">Logout</a>]</td>
</tr>
</table>
</br>
</hr>
</c:if>

<!-- Form Tag -->
<form:form commandName="model" id="form1" name="form1" method="post">
<table width="100%" cellpadding="0" cellspacing="0" class="table-line" border="0">
<tr>
	<td width="15%"><font color="#DD5800"><spring:message code="title.tmp.hed.calendar"/></font></td>
	<td width="" >
		<form:input path="fromDate" id="calendar1-1" size="8" maxlength="10" cssClass="input_M" readonly="false"/> ~
		<form:input path="toDate" id="calendar1-2" size="8" maxlength="10" cssClass="input_M" readonly="true"/>
	</td>
</tr>
</table>

<br/>

<table width="100%" cellpadding="0" cellspacing="0" class="table-line" border="0">
<tr>
	<td width="15%"><font color="#DD5800"><spring:message code="title.tmp.hed.formTag"/></font></td>
	<td width="40%" align="left" valign="top">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="40%">1-1. InputBox : </td>
			<td><form:input path="userId" size="10" maxlength="8" cssClass="input_M"/></td>
		</tr>
		<tr>
			<td>2-1. Combo List1 :</td>
			<td><form:select path="comboAdrr" items="${cmbCompStat}" multiple="false" cssClass="select_M" cssStyle="border:none;" disabled="true"/></td>
		</tr>
		<tr>
			<td>2-1. Combo option :</td>
			<td>
					<form:select path="cmb" cssClass="select_M">
						  <form:option value="seoul" label="서울" />
						  <form:option value="daegu" label="대구" />
						  <form:option value="busan" label="부산" />
					</form:select>
			</td>
		</tr>
		</table>
	</td>
	<td width="" align="left" valign="top">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="40%">3-1. CheckBoxes   : </td>
			<td><form:checkboxes path="arrChkAddr" items="${chkInstType}" cssStyle="border:none;" delimiter="<br/>" /></td>
		</tr>
		<tr>
			<td>3-2. CheckBox   : </td>
			<td>
				<form:checkbox path="chk" value="10" label="상태1" cssClass="checkbox_001" cssStyle="border:none;"/>
				<form:checkbox path="chk" value="10" label="상태2" cssClass="checkbox_001" cssStyle="border:none;"/>
			</td>
		</tr>
		<tr>
			<td height="10"></td>
			<td></td>
		</tr>
		<tr>
			<td>4-1. RadioButtons   : </td>
			<td> <form:radiobuttons  path="rdoAddr" items="${chkInstType}" cssStyle="border:none;"/></td>
		</tr>
		<tr>
			<td>4-2. RadioButton   : </td>
			<td>
				<form:radiobutton  path="rdo" label="라디오1" cssStyle="border:none;"/>
				<form:radiobutton  path="rdo" label="라디오2" cssStyle="border:none;"/>
			</td>
		</tr>
		<tr>
			<td height="10"></td>
			<td></td>
		</tr>
		<tr>
			<td>5. Hidden    : 소스참조</td>
			<td>
				<form:hidden path="userNm"/>
				<form:hidden path="page" value="1"/>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</form:form>

<hr/>
<span style="text-decoration: underline; font-weight: bold;">
#. Alert, Confirm, Prompt
</span>

<table width="100%" cellpadding="0" cellspacing="0" class="table-line" border="0">
<tr>
	<td width="" >
		<script>
			function jAlertSample(){
				nAlert('샘플 Alert 샘플 Alert 샘플 Alert 샘플 Alert 샘플 Alert 샘플 Alert 샘플 Alert', '타이틀');
			}
			function jConfirmSample(){
				nConfirm('샘플 Confirm', '타이틀', function(r) {
				    nAlert('Confirmed: ' + r, '결과');
				});
			}
			function jPromptSample(){
				nPrompt('샘플 Prompt', 'value', 'Title', function(r) {
				    if( r ) alert('뭐라꼬? ' + r);
				});
			}

			function goTest() {
				alert('ok');
			}
		</script>

		<a href="#none" onclick="jAlertSample()"> jAlert </a>&nbsp;&nbsp;&nbsp;
		<a href="#none" onclick="jConfirmSample()"> jConfirm </a>&nbsp;&nbsp;&nbsp;
		<a href="#none" onclick="jPromptSample()"> jPrompt </a>
	</td>
</tr>
</table>

<br/>
<hr/>

<!--  Message Examples  -->
<span style="text-decoration: underline; font-weight: bold;">
<spring:message code="title.tmp.hed.button" />
</span>

<br/>
<hr/>

<!-- Button Examples -->
<!-- 기본 버튼 -->
<app:button id="search" jsFunction="onClickButton"/>
<!-- 옵션 사용 버튼 -->
<app:button id="regiopen" jsFunction="onClickButton" style="blue"/>
<app:button id="delete" jsFunction="onClickButton" style="blue" name="삭제버튼"/>
<app:button id="check" jsFunction="onClickButton" style="button blue icon" icon="check" width="60"/>

<br/>

<app:button id="delt" jsFunction="onClickButton"/>
<app:button id="delete" jsFunction="onClickButton" icon="disk"/>
<app:button id="confirm" jsFunction="onClickButton" icon="check_box"/>
<app:button id="cancel" jsFunction="onClickButton" style="gray"/>
<app:button id="cancel" jsFunction="onClickButton" style="gray" width="60"/>

<br/>
<hr/>

<!--  Grid Zone -->
<table width="100%" cellpadding="0" cellspacing="1" border="0" bgcolor="#8E8EFF">
<thead>
  <tr bgcolor="#AAD5FF">
	<th class="title" width="" nowrap><spring:message code="title.no"/></th>
	<th class="title" width="" nowrap><spring:message code="title.id"/></th>
	<th class="title" width="" nowrap><spring:message code="title.name"/></th>
	<th class="title" width="50%" nowrap><spring:message code="title.title"/></th>
	<th class="title" width="20%" nowrap><spring:message code="title.date"/></th>
	<th class="title" width="" nowrap>User type</th>
  </tr>
</thead>
<tbody>
	<c:forEach var="data" items="${pageList}" varStatus="state">
		<tr bgcolor="#EEF7FF">
			<td class="lt_text" align="center"><c:out value="${state.count + startNo}"/></td>
			<td class="lt_text" align="center"><c:out value="${data.userId}"/></td>
			<td class="lt_text" align="center"><c:out value="${data.userNm}"/></td>
			<td class="lt_text"><a href="<c:url value='/temp/openRegiSample.do?seq=${data.seq}'/>"><c:out value="${data.title}"/></a></td>
			<td class="lt_text" align="center"><c:out value="${data.regiDttm}"/></td>
			<td class="lt_text" align="center"><c:out value="${data.userTypeNm}"/></td>
		</tr>
	</c:forEach>
	<c:if test="${fn:length(pageList) == 0}">
		<tr bgcolor="#EEF7FF">
			<td class="no_result" colspan="50" align="center"><spring:message code="exception.NoResult"/></td>
		</tr>
	</c:if>
</tbody>
</table>

<br/>

<!-- 페이징 -->
<div style="position:relative;">
	<app:paging name="pageList" jsFunction="fn_search" />
</div>


<br/>
<br/>
<span style="text-decoration: underline; font-weight: bold;">
# Dynamic row 예제
</span>
<br/>
<br/>
<!-- control buttons -->
<app:button id="add" jsFunction="onClickButton" style="blue"/>
<app:button id="delete" jsFunction="onClickButton" style="blue"/>

<table width="100%" cellpadding="0" cellspacing="1" border="0" bgcolor="#8E8EFF" id="dytbl1">
<thead>
  <tr bgcolor="#AAD5FF">
    <th class="title" width="" nowrap><input type="checkbox" name="chkAll" title="전체선택"/></th>
    <th class="title" width="" nowrap><spring:message code="title.id"/></th>
    <th class="title" width="" nowrap><spring:message code="title.name"/></th>
    <th class="title" width="50%" nowrap>파일</th>
    <th class="title" width="20%" nowrap><spring:message code="title.date"/></th>
    <th class="title" width="" nowrap>User type</th>
  </tr>
</thead>
<tbody>
    <tr bgcolor="#EEF7FF">
        <td class="lt_text" align="center">
            <input type="checkbox" name="delChk" title="삭제"/>
        </td>
        <td class="lt_text" align="center">
            <input type="text" name="id" size="10" title="텍스트"/>
        </td>
        <td class="lt_text" align="center">
            <input type="text" name="name" size="10" title="텍스트"/>
        </td>
        <td class="lt_text" align="center">
            <input type="file" name="upfile001" class="input1" style="padding-bottom:4;width:600;" title="파일경로"/>
        </td>
        <td class="lt_text" align="center">
            <input type="text" name="date1" size="15" class="_calendar" title="날짜1"/>
            <input type="text" name="date2" size="15" class="_calendar" title="날짜2"/>
        </td>
        <td class="lt_text" align="center"></td>
    </tr>
</tbody>
</table>

<br/>
<br/>
<span style="text-decoration: underline; font-weight: bold;">
# Dynamic Group 예제
</span>
<br/>
<br/>

<span id="btn_addGrp" class="button middle_bt"><a href="javascript:onClickButton('addGrp');" >추가</a></span>
<span id="btn_deleteGrp" class="button middle_bt"><a href="javascript:onClickButton('deleteGrp');" >삭제</a></span>
<div class="subContent">
    <div id="DyArea">

        <div class="_dynamicGroup" style="border-style: solid;">
            <input type="checkbox" name="delChk" title="삭제선택"/>삭제선택<br/>
            <span class="formTitle">ID   :</span> <input type="text" name="id" size="10" title="ID"/><br/>
            <span class="formTitle">Name :</span> <input type="text" name="name" size="10"  title="Name"/><br/>
            <span class="formTitle">파일 :</span> <input type="file" name="upfile001" class="input1" style="padding-bottom:4;width:600;" title="파일"/>
                   <input type="file" name="upfile001" class="input1" style="padding-bottom:4;width:600;" title="파일"/><br/>
            <span class="formTitle">날짜 :</span> <input type="text" name="date1" size="15" class="_calendar" title="날짜1"/>
                   <input type="text" name="date2" size="15" class="_calendar" title="날짜2"/><br/>
            <span class="formTitle">날짜(mask적용) :</span> <input type="text" name="dateMask1" id="dateMask1" class="_calendar" size="15"  title="mask"/> (mask 테스트용)
        </div>

    </div>
</div>

<br/>
<br/>

<span style="text-decoration: underline; font-weight: bold;">
    # DAUM 우편번호 검색 샘플
</span>
(<a href="http://postcode.map.daum.net/guide" target="_blank" > Guide Site Url</a> )
<br/>
<br/>
<div class="subContent">

    <form class="form-inline well">
        <span class="formTitle"><label for="post1">우편번호 :</label></span>
                   <input type="text" id="post1" class="d_form mini" style="width:60px;" title="우편번호1"> -
                   <input type="text" id="post2" class="d_form mini" style="width:60px;" title="우편번호2">
                   <input type="button" onclick="openDaumPostcode()" value="popup 우편번호 찾기" class="d_btn" title="우편번호찾기">
                   <input type="button" onclick="expandDaumPostcode()" value="iframe 우편번호 찾기" class="d_btn" title="우편번호찾기"><br>

        <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative;-webkit-overflow-scrolling:touch;">
            <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
        </div>


        <span class="formTitle"><label for="addrType">선택된주소 TYPE :</label></span> <input type="text" id="addrType" class="d_form mini" style="width:50px;" > [선택된 주소 타입: R(도로명), N(지번)] <br/>
        <span class="formTitle"><label for="addr">주소     :</label></span> <input type="text" id="addr"    class="d_form" placeholder="주소"     style="width: 500px;"><br/>
        <span class="formTitle"><label for="addr1">주소(1)  :</label></span> <input type="text" id="addr1"   class="d_form" placeholder="주소1"    style="width: 400px;"><br/>
        <span class="formTitle"><label for="addr2">주소(2)  :</label></span> <input type="text" id="addr2"   class="d_form" placeholder="주소2"    style="width: 400px;"><br/>
        <span class="formTitle"><label for="relAddr">지번주소 :</label></span> <input type="text" id="relAddr" class="d_form" placeholder="지번주소" style="width: 500px;">(* 선택된 주소 타입이 '도로명' 일 때만 값이 존재!)<br/>
        <span class="formTitle"><label for="engAddr">영문주소 :</label></span> <input type="text" id="engAddr" class="d_form" placeholder="영문주소" style="width: 600px;"><br/>
        <span class="formTitle"><label for="addrDetail">상세주소 :</label></span> <input type="text" id="addrDetail"   class="d_form" placeholder="상세주소" style="width: 400px;"><br/>
    </form>
</div>

<br/>


<span style="text-decoration: underline; font-weight: bold;">
    # mast를 이용한 입력 관리 예제
</span>
<br/>
<br/>
<div class="subContent">
    <form class="form-inline well">
        <span class="formTitle"><label for="calMask">날짜 mask적용 :</label></span> <input type="text" id="calMask" class="d_form mini" style="width:120px;"> <br/>
        <span class="formTitle"><label for="floatMask">Float mask적용 :</label></span> <input type="text" id="floatMask" class="d_form mini" style="width:120px;"> <br/>
        <span class="formTitle"><label for="buzRegNoMask">사업자번호 mask적용 :</label></span> <input type="text" id="buzRegNoMask" class="d_form mini" style="width:150px;"> <br/>
        <span class="formTitle"><label for="usrRegNoMask">주민번호 mask적용 :</label></span> <input type="text" id="usrRegNoMask" class="d_form mini" style="width:150px;"> <br/>
        <span class="formTitle"><label for="phoneNoMask">전화번호 mask적용 :</label></span> <input type="text" id="phoneNoMask" class="d_form mini" style="width:150px;"> <br/>
    </form>
</div>


<br/>


<span style="text-decoration: underline; font-weight: bold;">
    # 주소 API(juso.go.kr) 이용한 주소 예제
</span>
<div class="subContent">
    <span><a href="javascript:goPopup();">주소 팝업</a></span>
    <form name="jusoForm">
        <table>
            <tr><td><label for="roadFullAddr">도로명주소 전체(포멧)</label></td><td><input type="text"  style="width:500px;" id="roadFullAddr"  name="roadFullAddr" /></td></tr>
            <tr><td><label for="roadAddrPart1">도로명주소           </label></td><td><input type="text"  style="width:500px;" id="roadAddrPart1"  name="roadAddrPart1" /></td></tr>
            <tr><td><label for="addrInputDetail">고객입력 상세주소    </label></td><td><input type="text"  style="width:500px;" id="addrInputDetail"  name="addrInputDetail" /></td></tr>
            <tr><td><label for="roadAddrPart2">참고주소             </label></td><td><input type="text"  style="width:500px;" id="roadAddrPart2"  name="roadAddrPart2" /></td></tr>
            <tr><td><label for="engJusoAddr">영문 도로명주소      </label></td><td><input type="text"  style="width:500px;" id="engJusoAddr"  name="engJusoAddr" /></td></tr>
            <tr><td><label for="jibunAddr">지번 주소            </label></td><td><input type="text"  style="width:500px;" id="jibunAddr"  name="jibunAddr" /></td></tr>
            <tr><td><label for="zipNo">우편번호             </label></td><td><input type="text"  style="width:500px;" id="zipNo"  name="zipNo" /></td></tr>
            <tr><td><label for="admCd">행정구역코드        </label></td><td><input type="text"  style="width:500px;" id="admCd"  name="admCd" /></td></tr>
            <tr><td><label for="rnMgtSn">도로명코드          </label></td><td><input type="text"  style="width:500px;" id="rnMgtSn"  name="rnMgtSn" /></td></tr>
            <tr><td><label for="bdMgtSn">건물관리번호        </label></td><td><input type="text"  style="width:500px;" id="bdMgtSn"  name="bdMgtSn" /></td></tr>
        </table>
    </form>
</div>

<br/>
<br/>
<!-- ==================== 중앙내용 종료 ==================== -->

<!-- footer layout -->
<app:layout mode="footer" />

</body>
</html>
