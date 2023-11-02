<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="header.jsp" %>
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
<style>
	.contentText {
		text-align: center;
	}
	.contents {
		max-width: 1186px;
    	margin: 0 auto;
	} 
</style>

<body id="top">
<div class="wrap">
	
<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />



<div class="lnb" style="height:40px;">
    <div class="container">
        <div class="lnb-roller">
            <a href="javascript:void(0);" title="메뉴보기" onclick="lnbScroll()"><img alt="메뉴보기" src="/img/arrow_bottom_medium.png"></a>
        </div>
        <ul class="evtdss-localmenu">
    </div>
</div>

        

<div class="contents login" >
	
	<div class="contentsTilteLine" style="padding-top:3%;">
		<strong>로그인</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">회원정보</a></li>
			<li>로그인</li>
		</ol>
	</div>
						
	<div class="contentText hMargin">
		<p>- 회원이 되시면 다양한 혜택을 누릴 수 있습니다.<br />
		- 아직 회원이 아니시면 무료회원가입으로 TDSS 평가지원시스템의 다양한 혜택을 누려보세요.</p>
	</div>

	<div style="text-align:center;">
		<img title="로그인 이미지" src="img/login.png" width="280px" alt="로그인 이미지" />
		
		<div class="alert pull-right" style="margin-bottom:5%; float:none !important; display:inline-block; vertical-align:top; text-align:left;">
			<form name="form1" id="form1" action="" method="post">
				<table class="loginTable" >
					<colgroup>
						<col style="width:90px;">
						<col style="width:280px;">
						<col style="width:50px;">
					</colgroup>
					<tbody>
						<tr>
							<td colspan="3" class="loginTitle ">
								Member <span class="text-center" >Login</span>	<hr>
							</td>
						</tr>
						<tr>
							<th><i class="icon-ic_user_id"> </i>아이디</th>
							<td><input type="text" alt="아이디" title="아이디" label="아이디" class="form-control input-sm"  id="j_userid" name="j_userid" maxlength="15 " tabindex="1"></td>
							<td rowspan="2"><a class="btn btn-smRed btn-login" href="#"  id="loginBtn" tabindex="3">로그인</a></td>
						</tr>
						<tr>
							<th><i class="icon-ic_password"> </i>비밀번호</th>
							<td><input type="password" label="패스워드" alt="패스워드" title="패스워드" class="form-control input-sm" id="j_password" name="j_password"  maxlength="12" tabindex="2"></td>
						</tr>
						<tr>
							<td colspan="3"><hr style="margin-top: 7px;"></td>
						</tr>
						<tr>
							<td colspan="3" class="selectBtn" style="padding-bottom: 20px;">
								<!-- <a href="/memb/viewMembFindId.do" ><i class="icon-ic_account_circle">&nbsp;</i>아이디찾기</a>
								<a href="/memb/viewMembFindPwd.do" ><i class="icon-ic_lock_outline">&nbsp;</i>비밀번호찾기</a> -->
								<a href="/memb/openRegiMembUser02.do" ><i class="icon-ic_person_add" style="position:relative; top:5px; font-size: 20px;">&nbsp;</i>회원가입</a>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	
	
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