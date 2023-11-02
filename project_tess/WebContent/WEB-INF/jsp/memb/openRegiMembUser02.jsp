<%
/****************************************************************************************
*** ID                  : listTodeMgmt.jsp
*** Title               : [관광개발사업] 지자체사업조회  화면
*** Description         : [관광개발사업] 지자체사업조회 리스트 화면
***
*** -----------------------------    Modified Log   -------------------------------------
*** ver             date             	author           	description
***  ------------------------------------------------------------------------------------
*** 1.0         2014-10-13              LCS                 First Coding.
*** 2.0			2017-08-24				AlphaDuck!			디자인 개편
*****************************************************************************************/
%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
	<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<%-- <script language="javascript"  type="text/javascript" src='<c:url value="/js/stat/statComm.js"/>'></script> --%>
	<!-- 공통부분 스크립트 추가 -->
	<script type="text/javascript" src="/js/memb/commonBaseUscm.js"></script>
	<script type="text/javascript" src="/js/memb/business.js"></script>
	<script type="text/javascript" src="/js/memb/commonBase.js"></script>
	<!-- 우편번호 검색을 위한 스크립트 추가 -->
	<script src="//dmaps.daum.net/map_js_init/postcode.js"></script>
</head>
<body>
	<!-- 헤더부분 -->
	<!-- header layout -->
	<app:layout mode="header" />
	
	<form:form commandName="model" name="model" id="model" class="form-horizontal">
	
		<input type="hidden" id="gubunUser" name="gubunUser" value="${gubunUser}">
		<input type="hidden" name="disChg"  id="disChg"/>
		
		<%-- <section class="contents_box">
			<div class="col-xs-12 contents">
				<div class="con_title memb_wrap">
					<h3>회원가입</h3>
					<div class="pc"></div>
				</div>
				
				<div class="join_step box">
					<ul>
						<li class="col-xs-4">01 약관동의</li>
						<li class="col-xs-4 on">02 정보입력</li>
						<li class="col-xs-4">03 가입완료</li>
					</ul>
				</div>
				
				<div class="join">
					<div class="msg_box pc">
						<i class="msg"></i>
						<p>다음 항목들은 회원 관리 및 서비스 제공을 위해 활용됩니다.<br>설명에 따라 내용을 정확하게 입력하여 주십시오.</p>
						<div class="h30"></div>
					</div>
				
					<div class="title">필수정보</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">아이디</label>
						<div class="col-sm-10 divinner">
							<div class="col-xs-4">
								<form:input path="userId" cssClass="form-control" maxlength="15"   title="사용자 ID"/>
								<input type="hidden" name="orgUserId" id="orgUserId" value='<c:out value="${model.userId }"/>'/>
							</div>
							<div class="col-xs-4">
								<a href="#void" class="btn btn_com btn_lg bor" onclick="checkDuplUserId()" >중복확인</a>
								<input type="hidden" name="userIdDuplChkYn" id="userIdDuplChkYn"/>
								<input type="hidden" name="userIdCheck" id="userIdCheck"/>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">비밀번호</label>
						<div class="col-sm-10">
							<div class="col-xs-4">
								<form:password path="passwd" cssClass="form-control" maxlength="12"  placeholder="※ 영문,숫자,특수문자 혼합 6자~12자까지 입력 가능" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">비밀번호 확인</label>
						<div class="col-sm-10">
							<div class="col-xs-4">
								<form:password path="passwdCfrm" cssClass="form-control" maxlength="12"  placeholder="※ 영문,숫자,특수문자 혼합 6자~12자까지 입력 가능" />
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">전화번호</label>
						<div class="col-sm-10 divinner">
							<div class="col-xs-2">
								<select class="w100" name="telNo1"  id="telNo1"  title="전화번호1">
									<c:forEach items="${telFnumCodeList }" var="telType">
					                	<option value="${telType.code }" label="${telType.codeNm }"><c:out value="${telType.codeNm }"/></option>
					                </c:forEach>						
								</select>
							</div>			
							<div class="col-xs-2">
								<input type="text" class="form-control" name="telNo2" id="telNo2" placeholder=""  maxlength="4" title="전화번호2">
							</div>
							<div class="col-xs-2">
								<input type="text" class="form-control" name="telNo3" id="telNo3" placeholder=""  maxlength="4" title="전화번호3">
							</div>
							<form:hidden path="telNo" />
						</div>
					</div>
					
		<!-- 			<div class="form-group"> -->
		<!-- 				<label class="col-sm-2 control-label">휴대폰번호</label> -->
		<!-- 				<div class="col-sm-10 divinner"> -->
		<!-- 					<div class="col-xs-3"> -->
		<!-- 						<select class="w100" name="cellphoneNo1" id="cellphoneNo1"  title="휴대폰 번호"> -->
									<c:forEach items="${cellFNumCodeList }" var="cellFType">
					                	 <option value="${cellFType.code }"><c:out value="${cellFType.codeNm }"/></option>
					                 </c:forEach>						
		<!-- 						</select> -->
		<!-- 					</div>			 -->
		<!-- 					<div class="col-xs-3"> -->
		<!-- 						<input type="text" class="form-control" name="cellphoneNo2" id="cellphoneNo2" placeholder=""> -->
		<!-- 					</div> -->
		<!-- 					<div class="col-xs-3"> -->
		<!-- 						<input type="text" class="form-control" name="cellphoneNo3" id="cellphoneNo3" placeholder=""> -->
		<!-- 					</div> -->
		<!-- 				</div> -->
						<form:hidden path="cellphoneNo" />
		<!-- 			</div> -->
					
					<div class="form-group">
						<label class="col-sm-2 control-label">성명</label>
						<div class="col-sm-10 divinner">
							<div class="col-xs-4">
								<form:input path="userNm" cssClass="form-control" maxlength="15"   title="사용자명"/>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">이메일</label>
						<div class="col-sm-10 mailwrap box divinner">
							<div class="col-xs-2">
								<label for="email1">이메일</label>
								<input type="text" class="form-control" name="email1" id="email1" title="E-mail1">
							</div>
							<div class="col-xs-2 mail2">
								<label for="email2">이메일</label>
								<input type="text" class="form-control" name="email2" id="email2" placeholder="직접입력" title="E-mail2">
								<i>@</i>
							</div>
							<div class="col-xs-2">
								<label for="mail">선택</label>
								<select class="w100" name="email3" id="email3" title="E-mail3">
									<c:forEach items="${emailCdCodeList }" var="emailCd">
					                    <option value="${emailCd.code }"><c:out value="${emailCd.codeNm }"/></option>
					                </c:forEach>
								</select>
							</div>
							<form:hidden path="email"/>
							<p>* ID/비밀번호 찾기에 이용됩니다.<br>
							국가 관광자원통합정보시스템 마스터플랜에서 다양한 정보를 제공해 드립니다.<br>
							다양한 정보수신을 원치 않으시는 경우, 회원가입 후 마이페이지 > 개인정보 수정에서 수시로 변경이 가능하오니 이점 참고하시기 바랍니다.
							</p>
						</div>
					</div>
					
					<div class="form-group">
						<c:if test="${gubunUser eq 'officialUser'}">
						<label class="col-sm-2 control-label">사용자 구분</label>
						<div class="col-xs-2">
							<select class="w100" name="uscmType" id="uscmType">
								<c:forEach items="${uscmTypeCodeList }" var="uscmType" begin="6" end="7">
					                <option value="${uscmType.code }"><c:out value="${uscmType.codeNm }"/></option>
					            </c:forEach>
							</select>
						</div>
						</c:if>
						<c:if test="${gubunUser eq 'normalUser'}">
						<label class="col-sm-2 control-label">사용자 구분</label>
						<div class="col-xs-2">
							<select class="w100" name="uscmType" id="uscmType">
								<c:forEach items="${uscmTypeCodeList }" var="uscmType" begin="1" end="5">
					                <option value="${uscmType.code }"><c:out value="${uscmType.codeNm }"/></option>
					            </c:forEach>
							</select>
						</div>
						</c:if>
					</div>
					
					
					<div class="h30"></div>
					
					<c:if test="${gubunUser eq 'officialUser'}">	
						<!-- 공무원 유형 추가정보 -->
						<div class="title">추가정보</div>
					</c:if>
					
					<c:if test="${gubunUser eq 'officialUser'}">
						<div class="form-group">
							<label class="col-sm-2 control-label">지자체</label>
							<div class="col-sm-10">
								<div class="col-xs-2">
									<select class="w100" name="cityauthCd1" id="cityauthCd1"></select>
								</div>
								<div class="col-xs-2">
									<select class="w100" name="cityauthCd" id="cityauthCd"></select>
								</div>
								<input type="hidden" name="cityauthCdVal" id="cityauthCdVal" value="${map.cityauthCd }"/>
							</div>
						</div>
					
						<div class="form-group">
							<label class="col-sm-2 control-label">부서명</label>
							<div class="col-sm-10">
								<div class="col-xs-2">
									<select class="w100" name="deptCd" id="deptCd">
										<c:forEach items="${deptCodeList }" var="deptCode">
							               <option value="${deptCode.code }"><c:out value="${deptCode.codeNm }"/></option>
							            </c:forEach>
									</select>
								</div>
								<div class="col-xs-2">
									<input class="w100" type="text"  name="deptNm" id="deptNm"> &nbsp&nbsp&nbsp
								</div>
								<span class="textPosition">※ 해당하는 부서명이 없을 경우 공란으로 선택 후 부서명을 직접 입력해주시기 바랍니다.</span>
							</div>
						</div>
					
						<div class="form-group">
							<label class="col-sm-2 control-label">담당업무명</label>
							<div class="col-sm-10">
								<div class="col-xs-4">
									<input class="w100" type="text" name="uscmRole" id="uscmRole">
								</div>
							</div>
						</div>
					
		<!-- 			<div class="form-group"> -->
		<!-- 				<label class="col-sm-2 control-label">기관(업체)명</label> -->
		<!-- 				<div class="col-sm-10"> -->
		<!-- 					<input type="text" name="uscmNm" id="uscmNm"> -->
		<!-- 				</div> -->
		<!-- 			</div> -->
					
					</c:if>
				</div>
				
				<div class="btn_box">
					<a class="btn btn_com btn_lg bg_blue c_fff" href="#void" id="cnfmBtn" onclick="cnfmBtn()">가입하기</a>
					<a class="btn btn_com btn_lg bg_gray c_fff" href="#void" id="cnclBtn" onclick="joinCancel()">취소</a>
				</div>
			</div>
		</section> --%>
		
		<div class="contents-wrap">
		    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
		        <div class="container">
		            <div class="evtdss-breadcrumb">
		                <ul>
		                    <li>홈</li>
		                    <li>회원가입</li>
		                </ul>
		            </div>
		            <div class="row">
		                <div class="col-md-12">
		                    <h3 class="page-title">회원가입</h3>
		
		                    <!-- Contents -->
		                    <p class="section-title">
		                        기본 정보<small class="silent">회원 기본정보</small>
		                    </p>
		                    <table class="evtdss-form-table">
		                        <tr>
		                            <th class="fix-width title">구분</th>
		                            <th>내용</th>
		                        </tr>
		                        <tr>
		                            <td>이름</td>
		                            <td>
		                                <div class="incell-textinput w33">
		                                    <form:input path="userNm" type="text" id="userNm" _required="true" maxlength="15" placeholder="본명" title="본명" />
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>아이디</td>
		                            <td>
		                                <div class="incell-textinput w33">
		                                    <!-- <input type="text" title="아이디" name="commID" placeholder="아이디"> -->
		                                    <form:input path="userId" id="userId" _required="true" maxlength="15"  title="아이디" placeholder="아이디"/>
		                                    <input type="hidden" name="orgUserId" id="orgUserId" value='<c:out value="${model.userId }"/>'/>
		                                </div>
		                                <div class="inline-btn">
		                                    <button type="button" class="inline-button green">
		                                    	<a class="userChkDuplBtn" href="#" title="중복확인" onclick="checkDuplUserId()">중복확인</a>
		                                    </button>
		                                    <div class="incell-etc">12자 이내의 영문, 숫자만 가능하며 특수문자는 '_' 만 사용가능합니다.</div>
		                                </div>
		                                <input type="hidden" name="userIdDuplChkYn" id="userIdDuplChkYn"/>
		                                <input type="hidden" name="userIdCheck" id="userIdCheck"/>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>비밀번호</td>
		                            <td>
		                                <div class="incell-textinput w33">
		                                    <!-- <input type="password" title="비밀번호" name="commPw" placeholder="비밀번호"> -->
		                                    <form:password path="passwd" id="passwd" _required="true" maxlength="12" title="비밀번호" placeholder="비밀번호" autocomplete="new-password"/>
		                                </div>
		                                <!-- 관리자 전용 기능 -->
		                                <!-- <div class="inline-btn">
		                                    <button class="inline-button green"><a href="#" title="초기화">초기화</a></button>
		                                </div> -->
		                                <!-- /관리자 전용 기능 -->
		                                <div class="incell-etc">6자 이상이며 영문, 숫자, 특수문자를 포함해야 합니다.</div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>비밀번호 확인</td>
		                            <td>
		                                <div class="incell-textinput w33">
		                                    <!-- <input type="password" title="비밀번호 확인" name="commPw2" placeholder="비밀번호 확인"> -->
		                                    <form:password path="passwdCfrm" id="passwdCfrm"  _required="true"  maxlength="12" title="비밀번호 확인" placeholder="비밀번호 확인"/>
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>소속/직종</td>
		                            <td>
		                                <div class="incell-textinput w33">
		                                    <!-- <input type="text" title="소속기관/단체명" name="commOrg" placeholder="소속기관/단체명"> -->
		                                    <input type="text" name="deptNm" id="deptNm" _required="true" placeholder="소속기관/단체명" title="소속기관/단체명" />
		                                </div>
		                                <div class="incell-textinput w33">
		                                    <!-- <input type="text" title="직위 또는 직함" name="commPro" placeholder="직위 또는 직함"> -->
		                                    <select name="occupa" id="occupa" style="width: 240px; margin: 0;" title="직종">
												<option value="">:: 직업 종류를 선택하세요 ::</option>
												 <c:forEach items="${occupaList}" var="occupa">
									            	<option value="${occupa.code}" label="${occupa.codeNm}">${occupa.codeNm}</option>
								                </c:forEach>
											</select>
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>연락처</td>
		                            <td class="noPadding">
		                                <table class="evtdss-form-table-incell">
		                                    <tr>
		                                        <td class="labeler">사무실</td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w40">
		                                                <input type="hidden" title="일반전화번호" name="commPhone" placeholder="일반전화번호">
		                                                <input type="hidden" name="telNo" id="telNo"  _required="true" placeholder="일반전화번호" title="일반전화번호" />
		                                                <table class="noLine">
															<tr>
																<td style="padding: 0;">
																	<select name="telphoneNo1" id="telphoneNo1" title="지역번호" style="width: 68px; margin: 0;">
																		<option value="02" label="02">02</option>
																	</select>
																</td>
																<td>&nbsp;-&nbsp;</td>
																<td style="padding: 0;"><input type="text" name="telphoneNo2" id="telphoneNo2" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호2"/></td>
																<td>&nbsp;-&nbsp;</td>
																<td style="padding: 0;"><input type="text" name="telphoneNo3" id="telphoneNo3" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호3"/></td>
																<input type="hidden" name="telphoneNo" id="telphoneNo">
															</tr>
														</table>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <td class="labeler">휴대전화</td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w40">
		                                                <input type="hidden" title="휴대전화번호" name="commMobile" placeholder="휴대전화번호">
		                                                <input type="hidden" name="cellno" id="cellno"  _required="true" placeholder="휴대전화번호" title="휴대전화번호" />
		                                                <table class="noLine">
															<tr>
																<td style="padding: 0;">
																	<select title="통신사번호" name="cellphoneNo1" id="cellphoneNo1" style="width: 68px; margin: 0;">
																	 <c:forEach items="${cellFNumCodeList}" var="cellNo">
														            	<option value="${cellNo.code}" label="${cellNo.codeNm}">${cellNo.code}</option>
													                </c:forEach>
																	</select>
																</td>
																<td>&nbsp;-&nbsp;</td>
																<td style="padding: 0;"><input type="text" name="cellphoneNo2" id="cellphoneNo2" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호2"/></td>
																<td>&nbsp;-&nbsp;</td>
																<td style="padding: 0;"><input type="text" name="cellphoneNo3" id="cellphoneNo3" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호3"/></td>
																<form:hidden path="cellphoneNo" />
															</tr>
														</table>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <td class="labeler">이메일</td>
		                                        <td class="align-left">
		                                            <!-- <div class="incell-textinput w33">
		                                                <input type="text" title="이메일" name="commMail" placeholder="이메일">
		                                                <input type="text" name="email" id="email"  _required="true" placeholder="이메일호" title="이메일" />
		                                            </div> -->
		                                            <table class="noLine">
														<tr>
															<td style="padding: 0;">
																<input type="text" class="form-control input-sm" id="email1" name="email1" _required="true" style="width: 126px; height: 30px;" title="이메일주소1"/>
															</td>
															<td>&nbsp;@&nbsp;</td>
															<td style="padding: 0;">
																<input type="text" name="email2" class="form-control input-sm marginRright12" id="email2" style="width: 126px; height: 30px;" title="이메일주소2"/>
																<form:hidden path="email"/>
															</td>
															<td style="padding: 0;">
																<select name="email3"  id="email3" class="form-control input-sm" style="width: 126px;" title="E-mail3">
													            <option value="" label="직접입력"></option>
													            <c:forEach items="${emailCdCodeList}" var="emailCd">
													            	<option value="${emailCd.codeNm}" label="${emailCd.codeNm}">${emailCd.codeNm}</option>
												                </c:forEach>
															</select>
															</td>
														</tr>
													</table>
		                                        </td>
		                                    </tr>
		                                </table>
		                            </td>
		                        </tr>
		                        <!-- <tr>
		                            <td>거주 지역</td>
		                            <td>
		                                <div class='col-sm-12 noPadding'>
		                                    <div class="form-group inline-radio">
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="서울"> 서울</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="부산"> 부산</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="대구"> 대구</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="인천"> 인천</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="광주"> 광주</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="대전"> 대전</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="울산"> 울산</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="세종"> 세종</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="경기"> 경기</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="강원"> 강원</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="충북"> 충북</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="충남"> 충남</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="전북"> 전북</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="전남"> 전남</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="경북"> 경북</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="경남"> 경남</label>
		                                        <label class="radio-inline multi-radio"><input type="checkbox" value="제주"> 제주</label>
		                                    </div>
		                                </div>
		                            </td>
		                        </tr> -->
		                        <tr>
		                            <td>활동여부</td>
		                            <td>
		                                <div class='col-sm-12 noPadding'>
		                                    <div class="form-group inline-radio">
		                                        <label class="radio-inline">
		                                            <input type="radio" name="useYn" id="useYn" value="Y" checked> 활성
		                                        </label>
		                                        <label class="radio-inline">
		                                            <input type="radio" name="useYn" id="useYn" value="N"> 비활성
		                                        </label>
		                                    </div>
		                                </div>
		                            </td>
		                        </tr>
		                    </table>
		
		                    <p class="section-title">
		                        전문분야<small>최대 3개까지 중복체크 가능합니다.</small>
		                    </p>
		                    <table class="evtdss-form-table">
		                        <tr>
		                            <th class="fix-width title">구분</th>
		                            <th class="fix-width cate">분야선택</th>
		                            <th>세부분야(직접작성)</th>
		                        </tr>
		                        <tr>
		                            <td>관광</td>
		                            <td class="fix-width noPadding" colspan="2">
		                                <table class="evtdss-form-table-incell" id="FT01">
		                                	<c:forEach items="${fieldTravList}" var="fieldCult"  varStatus="idx">
		                                		<tr class="field_tr">
			                                        <td class="fix-width cate align-left">
			                                            <label class="radio-inline multi-radio"><input type="checkbox" name="travel" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
			                                            <c:if test="${fieldCult.code == 'FC01'}">
			                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="여행, 숙박, 컨벤션, 카지노, 외식 등">?</button>
			                                            </c:if>
			                                            <c:if test="${fieldCult.code == 'FC02'}">
			                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="축제, 이벤트 등">?</button>
			                                            </c:if>
			                                        </td>
			                                        <td class="align-left">
			                                            <div class="incell-textinput w100">
			                                                <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
			                                            </div>
			                                        </td>
			                                    </tr>
		                                	</c:forEach>
		                                </table>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>경제ㆍ경영</td>
		                            <td class="fix-width noPadding" colspan="2">
		                                <table class="evtdss-form-table-incell" id="FT02">
		                                    <c:forEach items="${fieldEcoList}" var="fieldCult"  varStatus="idx">
		                                		<tr class="field_tr">
			                                        <td class="fix-width cate align-left">
			                                            <label class="radio-inline multi-radio"><input type="checkbox" name="economy" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
			                                        </td>
			                                        <td class="align-left">
			                                            <div class="incell-textinput w100">
			                                                <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
			                                            </div>
			                                        </td>
			                                    </tr>
		                                	</c:forEach>
		                                </table>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>문화</td>
		                            <td class="fix-width noPadding" colspan="2">
		                                <table class="evtdss-form-table-incell" id="FT03">
		                                    <c:forEach items="${fieldCultList}" var="fieldCult"  varStatus="idx">
		                                		<tr class="field_tr">
			                                        <td class="fix-width cate align-left">
			                                            <label class="radio-inline multi-radio"><input type="checkbox" name="culture" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
			                                            <c:if test="${fieldCult.code == 'FI02'}">
			                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="영화, 음악, 게임, 애니메이션 등">?</button>
			                                            </c:if>
			                                            <c:if test="${fieldCult.code == 'FI03'}">
			                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="문화재, 문화유산, 민속학 등">?</button>
			                                            </c:if>
			                                        </td>
			                                        <td class="align-left">
			                                            <div class="incell-textinput w100">
			                                                <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
			                                            </div>
			                                        </td>
			                                    </tr>
		                                	</c:forEach>
		                                </table>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>콘텐츠</td>
		                            <td class="fix-width noPadding" colspan="2">
		                                <table class="evtdss-form-table-incell" id="FT04">
		                                    <c:forEach items="${fieldContList}" var="fieldCult"  varStatus="idx">
		                                		<tr class="field_tr">
			                                        <td class="fix-width cate align-left">
			                                            <label class="radio-inline multi-radio"><input type="checkbox" name="content" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
			                                        </td>
			                                        <td class="align-left">
			                                            <div class="incell-textinput w100">
			                                                <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
			                                            </div>
			                                        </td>
			                                    </tr>
		                                	</c:forEach>
		                                </table>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>환경 및 안전</td>
		                            <td class="fix-width noPadding" colspan="2">
		                                <table class="evtdss-form-table-incell" id="FT05">
		                                    <c:forEach items="${fieldEnvList}" var="fieldCult"  varStatus="idx">
		                                		<tr class="field_tr">
			                                        <td class="fix-width cate align-left">
			                                            <label class="radio-inline multi-radio"><input type="checkbox" name="environment" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
			                                            <c:if test="${fieldCult.code == 'FE01'}">
			                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="환경영향평가, 산림생태 등">?</button>
			                                            </c:if>
			                                        </td>
			                                        <td class="align-left">
			                                            <div class="incell-textinput w100">
			                                                <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
			                                            </div>
			                                        </td>
			                                    </tr>
		                                	</c:forEach>
		                                </table>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>도시ㆍ지역</td>
		                            <td class="fix-width noPadding" colspan="2">
		                                <table class="evtdss-form-table-incell" id="FT06">
		                                    <c:forEach items="${fieldConsList}" var="fieldCult"  varStatus="idx">
		                                		<tr class="field_tr">
			                                        <td class="fix-width cate align-left">
			                                            <label class="radio-inline multi-radio"><input type="checkbox" name="construct" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
			                                        </td>
			                                        <td class="align-left">
			                                            <div class="incell-textinput w100">
			                                                <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
			                                            </div>
			                                        </td>
			                                    </tr>
		                                	</c:forEach>
		                                </table>
		                            </td>
		                        </tr>
		                        <%-- <form:hidden path="fieldList" /> --%>
		                        
		                        <input id="fieldCodeList" name="fieldCodeList" type="hidden" value="">
		                        <input id="fieldParentCodeList" name="fieldParentCodeList" type="hidden" value="">
		                        <input id="fieldDetailContList" name="fieldDetailContList" type="hidden" value="">
		                        <%-- <form:hidden path="fieldCodeList" />
		                        <form:hidden path="fieldParentCodeList" />
		                        <form:hidden path="fieldDetailContList" /> --%>
		                    </table>
		
		                    <!-- <p class="section-title">
		                        전문경력<small>최대 5개까지 작성 가능합니다.</small>
		                    </p>
		                    <table class="evtdss-form-table">
		                        <tr>
		                            <th class="fix-width cate">기간</th>
		                            <th>내용</th>
		                        </tr>
		                        <tr>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력기간" name="resumDuration" placeholder="YYYY-MM ~ YYYY-MM">
		                                </div>
		                            </td>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력내용" name="resumTitle" placeholder="구체적인 경력 내용을 작성하에요">
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력기간" name="resumDuration" placeholder="YYYY-MM ~ YYYY-MM">
		                                </div>
		                            </td>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력내용" name="resumTitle" placeholder="구체적인 경력 내용을 작성하에요">
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력기간" name="resumDuration" placeholder="YYYY-MM ~ YYYY-MM">
		                                </div>
		                            </td>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력내용" name="resumTitle" placeholder="구체적인 경력 내용을 작성하에요">
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력기간" name="resumDuration" placeholder="YYYY-MM ~ YYYY-MM">
		                                </div>
		                            </td>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력내용" name="resumTitle" placeholder="구체적인 경력 내용을 작성하에요">
		                                </div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력기간" name="resumDuration" placeholder="YYYY-MM ~ YYYY-MM">
		                                </div>
		                            </td>
		                            <td>
		                                <div class="incell-textinput w100">
		                                    <input type="text" title="경력내용" name="resumTitle" placeholder="구체적인 경력 내용을 작성하에요">
		                                </div>
		                            </td>
		                        </tr>
		                    </table> -->
		
		                    <div class="submit-set noMargin">
		                        <button class="evtdss-submit" id="cnfmBtn" onclick="cnfmBtn();"><a href="#" title="등록">등록</a></button>
		                        <button class="evtdss-submit-cancel" id="prcBtnList"><a href="#" title="취소">취소</a></button>
		                        <!-- 등록이력이 있을 경우 표시 -->
		                        <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 등록</span> 되었습니다.</div>
		                        <!-- /등록이력이 있을 경우 표시 -->
		                    </div>
		                    <!-- /Contents -->
		                </div>
		            </div>
		
		        </div>
		    </div>
		
		</div> <!-- /contents-wrap -->
		
	</form:form>
	
	<!-- footer layout -->
	<app:layout mode="footer" type="normal"/>

</body>
</html>