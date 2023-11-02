<%
 /****************************************************************************************
***	ID					: login.jsp
***	Title				: login 화면
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date				author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-10-01				ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="ko">
<head>

<%@ include file ="./header.jsp" %>

<c:set var="returnFlag" value="<%=returnFlag%>"/>

<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->

<script type="text/javascript" >
$(function() {
    $('#j_password').keypress(function(e){
        if (e.keyCode == 13) {
            loginProc();
            return false;		// jAlert와 keyCode 사용시 return false 해줘야함.
        }
    });
    $("#loginBtn").click(function(){
        loginProc();
    });

    // [2014.11.26 lcs] id에 자동 focus 설정
    $("#j_userid").focus();

	//로그인 실패 리턴메세지
	var message	= "${returnFlag}";

	if (message == "E1") {
		message = MSG_COMM_E001;		// 등록된 사용자 정보가 없습니다.
	}
	if (message == "E2") {
		message = MSG_COMM_E002;		// 패스워드 틀립니다.
	}
	if (message == "E3") {
		message = MSG_COMM_E003;		// 사용제한된 ID.
	}
	if (message == "E8") {
		message = MSG_COMM_E008;		// 해당 사용자는 사용가능 상태가 아닙니다.
	}
	if (message == "EA") {
		message = MSG_COMM_E014;		// 해당 사용자는 사용가능 상태가 아닙니다.
	}
	if (message == "EB") {
		message = MSG_COMM_E016;		// 등록된 권한정보가 없습니다. 관리자에게 문의바랍니다.
	}
	if (message == "EF") {
		message = MSG_COMM_E015;		// URL 강제접속시 Return값 로그인후 사용가능함.
	}

	if (isEmpty(message) == false) {
	    // [2014.11.26 lcs] id에 자동 focus 설정
//		jAlert(message);
	    msgAlert(message, $("#j_userid"));
	}

    //-------------------------------
    //메시지 출력
    //-------------------------------
    resultMessage();
});

// 로그인 처리.
function loginProc() {
    var form = $("#form1");

    if (isEmpty($('#j_userid').val())) {
    	jAlert(MSG_COMM_U001);
    	return;
    }
    if (isEmpty($('#j_password').val())) {
    	jAlert(MSG_COMM_U002);
    	return;
    }
    form.attr("action", ROOT_PATH + "/j_login_check.do");

    form.submit();
}
</script>
</head>

<body>
<!-- header layout -->
<app:layout mode="header" />

<form name="form1" id="form1" action="">
<input type="hidden" id="certSignData" name="certSignData" title="인증서 정보"> <!-- 인증서 정보-->
<div class="member_out_line" style="margin:0 0 50px 0;">
	<div class="member_in_wrap">

		<div class="member_txt"><img src='<c:url value="/images/member/member_01.jpg"/>' alt="member login" /></div>

		<div class="login_form">
			<div><label for="j_userid">아이디</label> <input type="text" id="j_userid" name="j_userid" class="input_login_01" style="width:250px; margin-bottom:5px; ime-mode:disabled;" maxlength="15 "/></div>
			<div><label for="j_password">비밀번호</label> <input type="password" id="j_password" name="j_password" class="input_login_01" style="width:250px;" maxlength="12"/></div>
			<div class="login_btn" id="loginBtn"><a href="#void" /><img src='<c:url value="/images/btns/login_btn_01.png"/>' alt="로그인" style="margin-left:5px;" /></a></div>
		</div>

		<ul class="member_explain_01">
			<li>회원이 되시면 다양한 혜택을 누릴 수 있습니다.</li>
			<li>아직 회원이 아니시면 무료회원가입으로 국가 관광자원통합정보스시스템 마스터플랜의 다양한 혜택을 누려보세요.</li>
		</ul>


		<div class="member_etc_btn_01 clearfix">
			<span class="small_btn_01 small_color_03"><a href="/memb/viewMembFindId.do"><img src='<c:url value="/images/btns/icon_01.png"/>' alt="아이디찾기"><strong>아이디 찾기</strong></a></span>
			<span class="small_btn_01 small_color_03"><a href="/memb/viewMembFindPwd.do"><img src='<c:url value="/images/btns/icon_01.png"/>' alt="비밀번호찾기"><strong>비밀번호 찾기</strong></a></span>
			<span class="small_btn_01 small_color_04"><a href="/memb/openRegiMembUser01.do"><img src='<c:url value="/images/btns/s_icon_01.png"/>' alt="회원가입"><strong>회원가입</strong></a></span>
		</div>

	</div>
</div>
</form>

<div style="clear:both; height:50px;"></div>

<!-- GPKI삭제로 인한 화면제외 2015-01-28
<div class="title_00">인증서 로그인</div>


<div class="member_out_line" style="margin:0 0 50px 0;">
	<div class="member_in_wrap">
		<div class="member_txt"><img src='<c:url value="/images/member/member_09.jpg"/>' alt="certificate login" /></div>
		<div style="text-align:center; margin-top:20px;">
			<a href="#void" /><img src='<c:url value="/images/btns/login_btn_02.png"/>' alt="인증서 로그인" /></a>
		</div>

		<div class="member_etc_btn_01 clearfix">
			<span class="small_btn_01 small_color_03"><a href="#link"><img src='<c:url value="/images/btns/b_icon_01.png"/>' alt="인증서 발급안내"><strong>인증서 발급안내</strong></a></span>
			<span class="small_btn_01 small_color_03"><a href="#link"><img src='<c:url value="/images/btns/s_icon_06.png"/>' alt="전자 인증서 관리"><strong>전자 인증서 관리</strong></a></span>
		</div>

	</div>
</div>

 --> 

<!-- ==================== 중앙내용 종료 ==================== -->

<!-- footer layout -->
<app:layout mode="footer" />

</body>
</html>