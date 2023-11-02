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
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/memb/commonBaseUscm.js"/>'></script>
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ========================= -->
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
    
     <%-- 검색조건 --%>
    <div id="srchCondArea">
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
    </div>
	
	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>관리자</li>
	                    <li>평가위원관리</li>
	                    <li>평가위원정보</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">평가위원관리</h3>
	
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
	                                </div>
	                                <div class="inline-btn">
	                                    <button type="button" class="inline-button green">
	                                    	<a class="userChkDuplBtn" href="#" title="중복확인">중복확인</a>
	                                    </button>
	                                    <div class="incell-etc">12자 이내의 영문, 숫자만 가능하며 특수문자는 '_' 만 사용가능합니다.</div>
	                                </div>
	                                <input type="hidden" name="userIdDuplChkYn" id="userIdDuplChkYn"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>비밀번호</td>
	                            <td>
	                                <div class="incell-textinput w33">
	                                    <!-- <input type="password" title="비밀번호" name="commPw" placeholder="비밀번호"> -->
	                                    <form:password path="passwd" id="passwd" _required="true" maxlength="12" title="비밀번호" placeholder="비밀번호"/>
	                                </div>
	                                <!-- 관리자 전용 기능 -->
	                                <div class="inline-btn">
	                                    <button class="inline-button green"><a href="#" title="초기화">초기화</a></button>
	                                </div>
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
	                                    <!-- <input type="text" name="attach" id="attach"  _required="true" placeholder="소속기관/단체명" title="소속기관/단체명" /> -->
	                                    <form:input path="deptNm" type="text" id="deptNm" _required="true" maxlength="15" placeholder="" title="소속" />
	                                </div>
	                                <div class="incell-textinput w33">
	                                    <!-- <input type="text" title="직위 또는 직함" name="commPro" placeholder="직위 또는 직함"> -->
	                                    <%-- <select name="occupa" id="occupa" style="width: 240px; margin: 0;" title="직종">
											<option value="">:: 직업 종류를 선택하세요 ::</option>
											 <c:forEach items="${occupaList}" var="occupa">
								            	<option value="${occupa.code}" label="${occupa.codeNm}">${occupa.code}</option>
							                </c:forEach>
										</select> --%>
										<select name="occupa" id="occupa" style="width: 240px; margin: 0;" title="직종">
											<c:if test= "${model.occupa eq null}">
							            		<option value="" selected>::선택하세요::</option>
							            	</c:if>
											<c:forEach items="${occupaList}" var="occupa">
												<c:if test= "${model.occuNm == occupa.code}">
								            		<option value="${occupa.code}" selected>${occupa.codeNm}</option>
								            	</c:if>
								            	<c:if test= "${model.occuNm != occupa.code}">
								            		<option value="${occupa.code}" label="${occupa.codeNm}">${occupa.codeNm}</option>
								            	</c:if>
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
	                                                <!-- <input type="text" title="일반전화번호" name="commPhone" placeholder="일반전화번호"> -->
	                                                <input type="hidden" name="telNo" id="telNo"  _required="true" placeholder="일반전화번호" title="일반전화번호" />
	                                                <table class="noLine">
														<tr>
															<td style="padding: 0;">
																<!-- <select name="telphoneNo1" id="telphoneNo1" style="width: 68px; margin: 0;">
																		<option value="02" label="02">02</option>
																</select> -->
																<select name="cellphoneNo1" id="cellphoneNo1" style="width: 68px; margin: 0;">
																	<%-- <c:forEach items="${phoneFNumCodeList}" var="cellNo">
														            	<option value="${cellNo.code}" label="${cellNo.codeNm}">${cellNo.code}</option>
													                </c:forEach> --%>
																 	<option value="02" label="02">02</option>
																</select>
															</td>
															<td>&nbsp;-&nbsp;</td>
															<!-- <td style="padding: 0;"><input type="text" name="telphoneNo2" id="telphoneNo2" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호2"/></td> -->
															<td style="padding: 0;"><form:input path="telphoneNo2" type="text" id="telphoneNo2" _required="true" placeholder="휴대폰 번호2" maxlength="4" title="휴대폰 번호2" /></td>
															<td>&nbsp;-&nbsp;</td>
															<!-- <td style="padding: 0;"><input type="text" name="telphoneNo3" id="telphoneNo3" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호3"/></td> -->
															<td style="padding: 0;"><form:input path="telphoneNo3" type="text" id="telphoneNo3" _required="true" placeholder="휴대폰 번호3" maxlength="4" title="휴대폰 번호3" /></td>
															<input type="hidden" name="telphoneNo" id="telphoneNo">
														</tr>
													</table>
	                                            </div>
	                                            <div class="incell-etc" style="vertical-align: top; margin-top: 8px">공백없이 연속된 숫자로 입력하세요. <strong>예) 0212345678</strong></div>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <td class="labeler">휴대전화</td>
	                                        <td class="align-left">
	                                            <div class="incell-textinput w40">
	                                                <!-- <input type="text" title="휴대전화번호" name="commMobile" placeholder="휴대전화번호"> -->
	                                                <!-- <input type="text" name="cellno" id="cellno"  _required="true" placeholder="휴대전화번호" title="휴대전화번호" /> -->
	                                                <table class="noLine">
														<tr>
															<td style="padding: 0;">
																<select name="cellphoneNo1" id="cellphoneNo1" style="width: 68px; margin: 0;">
																	<%-- <c:forEach items="${phoneFNumCodeList}" var="cellNo">
														            	<option value="${cellNo.code}" label="${cellNo.codeNm}">${cellNo.code}</option>
													                </c:forEach> --%>
													                <c:forEach items="${phoneFNumCodeList}" var="cellNo">
																	 	<c:if test= "${model.cellphoneNo1 == cellNo.code}">
														            		<option value="${cellNo.code}" selected>${cellNo.code}</option>
														            	</c:if>
														            	<c:if test= "${model.cellphoneNo1 != cellNo.code}">
														            		<option value="${cellNo.code}" label="${cellNo.codeNm}">${cellNo.code}</option>
														            	</c:if>
													                </c:forEach>
																</select>
															</td>
															<td>&nbsp;-&nbsp;</td>
															<!-- <td style="padding: 0;"><input type="text" name="cellphoneNo2" id="cellphoneNo2" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호2"/></td> -->
															<td style="padding: 0;"><form:input path="cellphoneNo2" type="text" id="cellphoneNo2" _required="true" placeholder="휴대폰 번호2" maxlength="4" title="휴대폰 번호2" /></td>
															<td>&nbsp;-&nbsp;</td>
															<!-- <td style="padding: 0;"><input type="text" name="cellphoneNo3" id="cellphoneNo3" style="width: 68px;"  _required="true" maxlength="4" title="휴대폰 번호3"/></td> -->
															<td style="padding: 0;"><form:input path="cellphoneNo3" type="text" id="cellphoneNo3" _required="true" placeholder="휴대폰 번호3" maxlength="4" title="휴대폰 번호3" /></td>
															<form:hidden path="cellphoneNo" />
														</tr>
													</table>
	                                            </div>
	                                            <div class="incell-etc" style="vertical-align: top; margin-top: 8px">공백없이 연속된 숫자로 입력하세요. <strong>예) 01012345678</strong></div>
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
															<!-- <input type="text" class="form-control input-sm" id="email1" name="email1" _required="true" style="width: 126px; height: 30px;" title="이메일주소1"/> -->
															<form:input path="email1" type="text" class="form-control input-sm" id="email1" _required="true" placeholder="이메일주소1" style="width: 126px; height: 30px;" title="이메일주소1" />
														</td>
														<td>&nbsp;@&nbsp;</td>
														<td style="padding: 0;">
															<!-- <input type="text" name="email2" class="form-control input-sm marginRright12" id="email2" style="width: 126px; height: 30px;"/> -->
															<form:input path="email2" type="text" class="form-control input-sm marginRright12" id="email2" _required="true" placeholder="이메일주소2" style="width: 126px; height: 30px;" title="이메일주소2" />
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
		                                            <%-- <label class="radio-inline multi-radio"><input type="checkbox" name="travel" value="${fieldCult.code}"> ${fieldCult.codeNm}</label> --%>
		                                            <c:if test="${fieldCult.FIELD_CHECK != 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="travel" value="${fieldCult.code}" checked> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        	<c:if test="${fieldCult.FIELD_CHECK == 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="travel" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                            <c:if test="${fieldCult.code == 'FC01'}">
		                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="여행, 숙박, 컨벤션, 카지노 등">?</button>
		                                            </c:if>
		                                            <c:if test="${fieldCult.code == 'FC02'}">
		                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="축제, 이벤트 등">?</button>
		                                            </c:if>
		                                        </td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w100">
		                                                <!-- <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요"> -->
		                                                <c:if test="${fieldCult.DETAIL_SUB_FIELD != null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요" value="${fieldCult.DETAIL_SUB_FIELD}">
		                                            	</c:if>
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD == null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
		                                            	</c:if>
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
		                                            <%-- <label class="radio-inline multi-radio"><input type="checkbox" name="economy" value="${fieldCult.code}"> ${fieldCult.codeNm}</label> --%>
		                                            <c:if test="${fieldCult.FIELD_CHECK != 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="economy" value="${fieldCult.code}" checked> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        	<c:if test="${fieldCult.FIELD_CHECK == 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="economy" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        </td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w100">
		                                                <!-- <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요"> -->
		                                                <c:if test="${fieldCult.DETAIL_SUB_FIELD != null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요" value="${fieldCult.DETAIL_SUB_FIELD}">
		                                            	</c:if>
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD == null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
		                                            	</c:if>
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
		                                            <%-- <label class="radio-inline multi-radio"><input type="checkbox" name="culture" value="${fieldCult.code}"> ${fieldCult.codeNm}</label> --%>
		                                            <c:if test="${fieldCult.FIELD_CHECK != 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="culture" value="${fieldCult.code}" checked> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        	<c:if test="${fieldCult.FIELD_CHECK == 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="culture" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                            <c:if test="${fieldCult.code == 'FI02'}">
		                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="영화, 음악, 게임, 애니메이션 등">?</button>
		                                            </c:if>
		                                            <c:if test="${fieldCult.code == 'FI03'}">
		                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="문화재, 문화유산, 민속학 등">?</button>
		                                            </c:if>
		                                        </td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w100">
		                                                <!-- <input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요"> -->
		                                                <c:if test="${fieldCult.DETAIL_SUB_FIELD != null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요" value="${fieldCult.DETAIL_SUB_FIELD}">
		                                            	</c:if>
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD == null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
		                                            	</c:if>
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
		                                        	<c:if test="${fieldCult.FIELD_CHECK != 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="content" value="${fieldCult.code}" checked> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        	<c:if test="${fieldCult.FIELD_CHECK == 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="content" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        </td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w100">
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD != null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요" value="${fieldCult.DETAIL_SUB_FIELD}">
		                                            	</c:if>
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD == null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
		                                            	</c:if>
		                                            </div>
		                                        </td>
		                                    </tr>
	                                	</c:forEach>
	                                </table>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>환경</td>
	                            <td class="fix-width noPadding" colspan="2">
	                                <table class="evtdss-form-table-incell" id="FT05">
	                                    <c:forEach items="${fieldEnvList}" var="fieldCult"  varStatus="idx">
	                                		<tr class="field_tr">
		                                        <td class="fix-width cate align-left">
		                                        	<c:if test="${fieldCult.FIELD_CHECK != 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="environment" value="${fieldCult.code}" checked> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        	<c:if test="${fieldCult.FIELD_CHECK == 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="environment" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                            <c:if test="${fieldCult.code == 'FE01'}">
		                                            	<button type="button" class="btn btn-sm btn-default btn-balloon" data-toggle="tooltip" data-placement="top" title="환경영향평가, 산림생태 등">?</button>
		                                            </c:if>
		                                        </td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w100">
		                                               <c:if test="${fieldCult.DETAIL_SUB_FIELD != null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요" value="${fieldCult.DETAIL_SUB_FIELD}">
		                                            	</c:if>
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD == null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
		                                            	</c:if>
		                                            </div>
		                                        </td>
		                                    </tr>
	                                	</c:forEach>
	                                </table>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>도시ㆍ건축</td>
	                            <td class="fix-width noPadding" colspan="2">
	                                <table class="evtdss-form-table-incell" id="FT06">
	                                    <c:forEach items="${fieldConsList}" var="fieldCult"  varStatus="idx">
	                                		<tr class="field_tr">
		                                        <td class="fix-width cate align-left">
		                                            <%-- <label class="radio-inline multi-radio"><input type="checkbox" name="construct" value="${fieldCult.code}"> ${fieldCult.codeNm}</label> --%>
		                                            <c:if test="${fieldCult.FIELD_CHECK != 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="construct" value="${fieldCult.code}" checked> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        	<c:if test="${fieldCult.FIELD_CHECK == 0}">
		                                        		<label class="radio-inline multi-radio"><input type="checkbox" name="construct" value="${fieldCult.code}"> ${fieldCult.codeNm}</label>
		                                        	</c:if>
		                                        </td>
		                                        <td class="align-left">
		                                            <div class="incell-textinput w100">
		                                                <c:if test="${fieldCult.DETAIL_SUB_FIELD != null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요" value="${fieldCult.DETAIL_SUB_FIELD}">
		                                            	</c:if>
		                                            	<c:if test="${fieldCult.DETAIL_SUB_FIELD == null}">
		                                            		<input type="text" title="세부분야" name="detailSubField" placeholder="구체적인 세부분야를 입력하세요">
		                                            	</c:if>
		                                            </div>
		                                        </td>
		                                    </tr>
	                                	</c:forEach>
	                                </table>
	                            </td>
	                        </tr>
	                        <form:hidden path="fieldList" />
	                        
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
	                        <button type="button" class="evtdss-submit" id="prcBtnSave"><a href="#" title="수정">수정</a></button>
	                        <button type="button" class="evtdss-submit-cancel" id="prcBtnList"><a href="#" title="취소">취소</a></button>
	                        <!-- 등록이력이 있을 경우 표시 -->
	                        <!-- <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 등록</span> 되었습니다.</div> -->
	                        <!-- /등록이력이 있을 경우 표시 -->
	                    </div>
	                    <!-- /Contents -->
	                </div>
	            </div>
	
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

<script>
// jQuery로 바꿔야함
var fieldData ='${model.fieldDetail}';
var fieldList = fieldData.split(',');
if(fieldData!='') {
	for(var i=0; i<fieldList.length; i++) {
		document.getElementById(fieldList[i]).checked=true;
	}
}

</script>
