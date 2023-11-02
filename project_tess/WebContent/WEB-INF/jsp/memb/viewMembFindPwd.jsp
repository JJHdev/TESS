<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
	<!-- 공통부분 스크립트 추가 -->
	<script type="text/javascript" src="/js/memb/commonBaseUscm.js"></script>
	
</head>

<body id="top">
<div class="wrap">
	
<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ========================= -->
<!-- ======================================================= -->

<div class="contents login" >
	
	<div class="contentsTilteLine">
		<strong>비밀번호 찾기</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">회원정보</a></li>
			<li>아이디/비밀번호 찾기</li>
		</ol>
	</div>
	
	<h4>비밀번호 찾기</h4>
	<div class="contentText">
		<p>- 아래 정보를 입력하신 내용이 등록된 정보와 일치하면 임시 비밀번호를 발급해드립니다.<br />
		- 회원가입시 입력하신 아이디와 이름, 이메일 등을 입력해주세요.</p>
	</div>
	
	<div class="alert" style="padding-bottom: 40px; margin-bottom: 40px;">
	<form:form commandName="model" id="form1" name="form1" method="post">
		<table class="searchTable"  >
			<colgroup>
				<col style="width:90px;">
				<col style="width:380px;">
				<col style="width:60px;">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="3" class="loginTitle ">
						PASSWORD <span class="text-center" >Search</span>
						<hr>
					</td>
				</tr>
				<tr>
					<th><i class="icon-ic_account_circle"> </i>아이디</th>
					<td><form:input path="userId"  cssClass="form-control input-sm" maxlength="15" title="아이디"/></td>
					<td rowspan="3"><a class="btn btn-smRed btn-logSearch" href="#" data-toggle="modal" data-target="" id="cfrmBtn">확인</a></td>
				</tr>
				<tr>
					<th><i class="icon-ic_user_id"> </i>성명</th>
					<td><form:input path="userNm" cssClass="form-control input-sm" maxlength="25"   title="사용자 명"/></td>
				</tr>
				<tr>
					<th><i class="icon-ic_email"> </i>이메일</th>
					<td>
							<table class="searchSubTable" ><tr>
								<td><input type="text" class="form-control input-sm" id="email1" name="email1" maxlength="30"  style="width: 120px;" title="담당자 E-mail1"></td>
								<td>&nbsp;@&nbsp;</td>
								<td><input type="text" class="form-control input-sm marginRright12" id="email2" name="email2" maxlength="30" style="width: 120px;" title="담당자 E-mail2"/></td>
								<td>
									<select name="email3" id="email3"  class="form-control input-sm" style="width: 105px;">
							            <c:forEach items="${emailCdCodeList }" var="emailCd">
					                       <option value="${emailCd.code }"><c:out value="${emailCd.codeNm }"/></option>
					                    </c:forEach>
									</select>
									<form:hidden path="email"/>
								</td>
							</tr></table>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>	
	</div><!-- /alert -->
	
</div><!-- /contents -->


<!-- Modal : 아이디 찾기 실패 / 비밀번호 찾기 실패 -->
<div class="modal fade" id="idSearchErrorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
        	<h4> </h4>
      </div>
      <div class="modal-body">

			<table>
				<colgroup>
					<col style="width: 70px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr>
						<td class="titleIcon"><i class="icon-ic_error"> </i></td>
						<td class="subject">입력하신 정보와 일치하는 회원정보가 없습니다.</td>
					</tr>
				</tbody>
			</table>
			
			<div class="text-center" style="margin: 30px 0;">
				<button type="button" class="btn btn-green" data-dismiss="modal"><i class="icon-ic_check "> </i>확인</button>
        	</div>
        	
      </div><!-- //modal-body-->
    </div><!-- //modal-content -->
  </div><!-- //modal-dialog -->
</div><!-- //Modal -->


<!-- Modal : 아이디 찾기 성공 -->
<div class="modal fade" id="idSearchOkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
        	<h4>아이디 찾기</h4>
      </div>
      <div class="modal-body">

			<table>
				<colgroup>
					<col style="width: 70px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr>
						<td class="titleIcon"><i class="icon-ic_user"> </i></td>
						<td class="subject">회원님의 아이디는 <strong class="textRed">abcds</strong>입니다.</td>
					</tr>
				</tbody>
			</table>
			
			<div class="text-center" style="margin: 40px 0;">
				<button type="button" class="btn btn-green marginRright4" style="width:100px;"><i class="icon-ic_dvr"> </i>로그인</button>
				<button type="button" class="btn btn-green marginRright4" style="width:130px;"><i class="icon-ic_lock_outline"> </i>비밀번호 찾기</button>
				<button type="button" class="btn btn-red" style="width:100px;" data-dismiss="modal"><i class="icon-ic_refresh"> </i>취소</button>
        	</div>
        	
      </div><!-- //modal-body-->
    </div><!-- //modal-content -->
  </div><!-- //modal-dialog -->
</div><!-- //Modal -->


<!-- Modal : 비밀번호 찾기 성공 -->
<div class="modal fade" id="pwSearchOkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
        	<h4>비밀번호 찾기</h4>
      </div>
      <div class="modal-body">

			<table>
				<colgroup>
					<col style="width: 70px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr>
						<td class="titleIcon"><i class="icon-ic_key"> </i></td>
						<td class="subject">회원님의 임시비밀번호는 <strong class="textRed"><span id="srchUserPwd">abcds</span></strong>입니다.</td>
					</tr>
				</tbody> 
			</table>
			
			<div class="text-center" style="margin: 40px 0;">
				<a href="/login.do"><button type="button" class="btn btn-green marginRright4" ><i class="icon-ic_dvr"> </i>로그인</button></a>
				<button type="button" class="btn btn-red" data-dismiss="modal"><i class="icon-ic_refresh"> </i>취소</button>
        	</div>
        	
      </div><!-- //modal-body-->
    </div><!-- //modal-content -->
  </div><!-- //modal-dialog -->
</div><!-- //Modal -->
						
<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->		

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->

</body>
</html>