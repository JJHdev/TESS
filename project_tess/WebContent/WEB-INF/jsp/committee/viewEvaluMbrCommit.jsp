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
	
	<div class="contentsTilte">
		<strong>평가위원 정보 수정화면</strong>
		<ol class="breadcrumb pull-right">
	       	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">평가관리</a></li>
			<li><a href="#">평가위원관리</a></li>
			<li>평가위원 등록화면</li>
		</ol>
	</div>
	   <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
	    <li role="presentation" class="active"><a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">평가위원 기본정보</a></li>
	    <li role="presentation"><a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">평가대상 목록</a></li>
    </ul>
	
	<div class="tab-content">	
		<div role="tabpanel" class="tab-pane active" id="tab1">
			<table class="table tableNormal small">
				<colgroup>
					<col style="width: 115px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr class="top2">
						<th class="leftNoLine">아이디</th>
						<td class="rightNoLine">
						<!-- 
							<input type="text" class="form-control input-sm marginRright12 pull-left" id="commitId" placeholder="" style="width: 198px;" />
							<a class="btn btn-smOrange" href="#" ><i class="icon-ic_done_all">&nbsp;</i>중복확인</a>
						-->	
							<form:input path="userId" id="userId" _required="true" cssClass="form-control input-sm marginRright12 pull-left" maxlength="15" cssStyle="width: 175px;"  title="사용자 ID" readonly="true"/>
							<input type="hidden" name="userIdDuplChkYn" id="userIdDuplChkYn"/>
						</td>
					</tr>
					<tr>
						<th class="leftNoLine">성명</th>
						<td class="rightNoLine">
							<form:input path="userNm" type="text" class="form-control input-sm" id="userNm" _required="true" maxlength="15" placeholder="" style="width: 198px;" title="성명" />
						</td>
					</tr>	
					<tr>
						<th class="leftNoLine">비밀번호</th>
						<td class="rightNoLine">
							<form:password path="passwd" cssClass="form-control input-sm pull-left marginRright10" id="passwd" _required="true" maxlength="12" cssStyle="width: 198px;"  title="비밀번호"/>
							<span class="textPosition">※ 영문,숫자,특수문자 혼합 6자~12자까지 입력 가능</span> 
						</td>
					</tr>	
					<tr>
						<th class="leftNoLine">비밀번호 확인</th>
						<td class="rightNoLine">
							<form:password path="passwdCfrm" class="form-control input-sm" id="passwdCfrm"  _required="true"  maxlength="12" style="width: 198px;" title="비밀번호 확인"/>
						</td>
					</tr>	
					<tr>
						<th class="leftNoLine">E-mail</th>
						<td class="rightNoLine">
							<table class="noLine">
								<tr>
									<td>
										<form:input path="email1" type="text" class="form-control input-sm" id="email1" _required="true" placeholder="" style="width: 126px;" title="이메일주소1" />
									</td>
									<td>&nbsp;@&nbsp;</td>
									<td>
										<form:input path="email2" type="text" class="form-control input-sm marginRright12" id="email2" _required="true" placeholder="" style="width: 126px;" title="이메일주소2" />
										<form:hidden path="email"/>
									</td>
									<td>
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
					
					<tr>
						<th class="leftNoLine">연락처</th>
						<td class="rightNoLine">
							<table class="noLine">
								<tr>
									<td>
										<select class="form-control input-sm" name="cellphoneNo1" id="cellphoneNo1" style="width: 68px;">
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
									<td>
									<form:input path="cellphoneNo2" type="text" class="form-control input-sm" id="cellphoneNo2" _required="true" placeholder="" style="width: 68px;" maxlength="4" title="휴대폰 번호2" />
									</td>
									<td>&nbsp;-&nbsp;</td>
									<td>
									<form:input path="cellphoneNo3" type="text" class="form-control input-sm" id="cellphoneNo3" _required="true" placeholder="" style="width: 68px;" maxlength="4" title="휴대폰 번호3" />
									</td>
									<form:hidden path="cellphoneNo" />
								</tr>
							</table>
						</td>
					</tr>	
					<tr>
						<th class="leftNoLine">소속</th>
						<td class="rightNoLine">
							<form:input path="attach" type="text" class="form-control input-sm" id="attach" _required="true" maxlength="15" placeholder="" style="width: 198px;" title="소속" />
							<!-- <input type="text" class="form-control input-sm" id="attach"  _required="true" placeholder="" style="width: 198px;" title="소속" />-->
						</td>
					</tr>	
					<tr>
						<th class="leftNoLine">직종</th>
						<td class="rightNoLine">
						<select class="form-control input-sm" name="occupa" id="occupa" style="width: 240px;" title="직종">
							<c:if test= "${model.occupa eq null}">
			            		<option value="" selected>::선택하세요::</option>
			            	</c:if>
							 <c:forEach items="${occupaList}" var="occupa">
							 	
							 	<c:if test= "${model.occupa == occupa.code}">
				            		<option value="${occupa.code}" selected>${occupa.codeNm}</option>
				            	</c:if>
				            	<c:if test= "${model.occupa != occupa.code}">
				            		<option value="${occupa.code}" label="${occupa.codeNm}">${occupa.codeNm}</option>
				            	</c:if>
			                </c:forEach>
						</select>
						</td>
					</tr>
					
					<tr>
						<th class="leftNoLine">주소</th>
						<td class="rightNoLine tdAddress">
								<p style="margin-bottom:5px;">
									<span class="pull-left">우편번호 :</span>
									<form:input path ="roadPostNo" class="form-control input-sm marginRright12 pull-left" id="roadPostNo" placeholder="" style="width: 86px;" readonly="true"/>
									<a class="btn btn-smBlue" href="#" id="postPopBtn"><i class="icon-ic_location_on">&nbsp;</i>주소찾기</a>
								</p>
		
								<p style="margin-bottom:5px;">
									<span class="pull-left">기본주소 :</span>
									<form:input path ="roadAddress1" class="form-control input-sm" id="roadAddress1" placeholder="" disabled="disabled" style="width: 352px;" readonly="true"/>
									<form:hidden path="roadAddr1" />
									<form:hidden path="roadAddr2" />
									<form:hidden path="roadAddr3" />
									<form:hidden path="roadAddr4" />
								</p>
		
								<p style="margin:0px;">
									<span class="pull-left">상세주소 :</span>
									<form:input path="roadAddr5"  cssClass="form-control input-sm" id="roadAddr5" placeholder="" style="width: 352px;" />
								</p>
						</td>
					</tr>
					
					<tr class="bottom">
						<th class="leftNoLine">분야</th>
						<td class="rightNoLine">
							<table class="checkboxTable">
								<tbody>
									<tr><th colspan="6">문화</th></tr>
									<tr>
									<c:forEach items="${fieldCultList}" var="fieldCult"  varStatus="idx">
										<c:if test="${idx.count % 6 eq 1 }">
											<tr>
										</c:if>
											<td><div class="checkbox"><label><input name="culture" type="checkbox"  value='<c:out value="${fieldCult.code}"/>' id=<c:out value="${fieldCult.code}"/>>${fieldCult.codeNm}</label></div></td>
							        	<c:if test="${idx.count % 6 eq 0 }">
							        	</tr>
							        	</c:if>
						        	</c:forEach>
						            </tr>
								</tbody>
								<form:hidden path="fieldList" />
							</table>
							
							<hr class="checkboxLine">
							
							<table class="checkboxTable">
								<tr><th colspan="6">예술</th></tr>
								<tr>
								<c:forEach items="${fieldArtList}" var="fieldArt"  varStatus="idx">
									<c:if test="${idx.count % 6 eq 1 }">
										<tr>
									</c:if>
										<td><div class="checkbox"><label><input name="art" type="checkbox"  value='<c:out value="${fieldArt.code}"/>' id=<c:out value="${fieldArt.code}"/>>${fieldArt.codeNm}</label></div></td>
						        	<c:if test="${idx.count % 6 eq 0 }">
						        	</tr>
						        	</c:if>
						        </c:forEach>
								</tr>
							</table>
							
							<hr class="checkboxLine">
							
							<table class="checkboxTable">
								<tr><th colspan="6">문화산업</th></tr>
								<tr>
									<c:forEach items="${fieldIndstList}" var="fieldIndst"  varStatus="idx">
									<c:if test="${idx.count % 6 eq 1 }">
										<tr>
									</c:if>
										<td><div class="checkbox"><label><input name="industry" type="checkbox"  value='<c:out value="${fieldIndst.code}"/>' id=<c:out value="${fieldIndst.code}"/>>${fieldIndst.codeNm}</label></div></td>
						        	<c:if test="${idx.count % 6 eq 0 }">
						        	</tr>
						        	</c:if>
						            </c:forEach>
								</tr>
							</table>
							
							<hr class="checkboxLine">
							
							<table class="checkboxTable">
								<tr><th colspan="6">관광</th></tr>
								<tr>
								<c:forEach items="${fieldTravList}" var="fieldTrav"  varStatus="idx">
									<c:if test="${idx.count % 6 eq 1 }">
									<tr>
									</c:if>
										<td><div class="checkbox"><label><input name="travel" type="checkbox"  value='<c:out value="${fieldTrav.code}"/>' id=<c:out value="${fieldTrav.code}"/>>${fieldTrav.codeNm}</label></div></td>
						        	<c:if test="${idx.count % 6 eq 0 }">
						        	</tr>
						        	</c:if>
						        </c:forEach>
							</table>
		
							<hr class="checkboxLine">
							
							<table class="checkboxTable">
								<tr><th colspan="6">기타</th></tr>
								<tr>
								<c:forEach items="${fieldEtcList}" var="fieldEtc"  varStatus="idx">
									<c:if test="${idx.count % 6 eq 1 }">
									<tr>
									</c:if>
										<td><div class="checkbox"><label><input name="etc" type="checkbox"  value='<c:out value="${fieldEtc.code}"/>' id=<c:out value="${fieldEtc.code}"/>>${fieldEtc.codeNm}</label></div></td>
						        	<c:if test="${idx.count % 6 eq 0 }">
						        	</tr>
						        	</c:if>
						        </c:forEach>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table><!-- //Table-->
			<div class="text-center" style="margin:55px 0 115px;">
			<a class="btn btn-green marginRright12" href="#"  id="prcBtnSave"><i class="icon-ic_create">&nbsp;</i>등록</a><!-- 20160203 : marginRright15 => marginRright12 이름변경 -->
			<a class="btn btn-red" href="#"  id="prcBtnList"><i class="icon-ic_refresh">&nbsp;</i>취소</a><!-- 20160203 : 모달링크 삭제, 하단 모달내용 삭제 -->
			</div>
		</div>
		
			
		<div role="tabpanel" class="tab-pane" id="tab2">
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
		</div><!-- //tab2-->
	    
	  </div><!-- //tab-content-->
		
	</div>
	
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
