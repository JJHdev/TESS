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
    
    <%-- 허용된 첨부파일 확장명 --%>
    <input type="hidden" name="allowedFileExts"    id="allowedFileExts"     value='<c:out value="${paramMap.allowedFileExts}"/>'/>
    <input type="hidden" name="allowedImgFileExts" id="allowedImgFileExts"  value='<c:out value="${paramMap.allowedImgFileExts}"/>'/>
    
    <%-- [첨부파일] 삭제 pks 설정 --%>
    <input type="hidden" name="deltFileDatas"     id="deltFileDatas"/>
    <%-- [년도별 사업계획서] 삭제 year 설정 --%>
    <input type="hidden" name="deltPlyyYearDatas" id="deltPlyyYearDatas"/>
     
	<div class="contentsTilteLine">
	<c:if test="${paramMap.mode eq 'regi' }">
		<strong>사업등록 입력화면</strong>
	</c:if>
	<c:if test="${paramMap.mode eq 'updt' }">
		<strong>사업등록 수정화면</strong>
	</c:if>	
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">사업관리</a></li>
			<li><a href="#">사업등록</a></li>
			<li>사업등록 상세화면</li>
		</ol>
	</div>
						
	<h5>관광개발사업 개요</h5>
	<!-- Table -->
	<table class="table tableNormal small">
		<colgroup>
			<col style="width: 115px;">
			<col style="width: *;">
		</colgroup>
		<tbody>
			<tr class="top2">
				<th class="leftNoLine">사업명</th>
				<td class="rightNoLine">
						<form:input path="evaluBusiNm" cssStyle="width:90%;"  class="form-control input-sm" title="사업명"/>
				</td>
			</tr>
			<tr>
				<th class="leftNoLine">위치</th>
				<td class="rightNoLine"><!-- 20160203 : colspan="2" 삭제 -->
					<ul class="ulList">
					  	<li class="marginRright12">
							<select name="cityauth1" id="cityauth1" class="form-control input-sm" style="width: 137px;" title="시도">
				                <option value=""></option>
				                <c:forEach items="${cityauth1List }" varStatus="status" var="cityauth">
				                    <option value='<c:out value="${cityauth.code }"/>'><c:out value="${cityauth.codeNm }"/></option>
				                </c:forEach>
							</select>
						</li>
						<li>
							<select name="cityauth2" id="cityauth2" class="form-control input-sm" style="width: 137px;" title="시군구">
							 <option value=""></option>
							</select>
					  	</li>
					</ul>
					<br />
					<form:input  path="busiAddr5"  cssClass="form-control input-sm"  title="상세주소"/>
					
		            <%-- 시군구 콤보 초기 loading을 위한 객체 --%>
		            <input type="hidden" id="cityauth2Val" name="cityauth2Val" value='<c:out value="${model.busiAddr2}"/>'/>
		            <form:hidden path="busiAddr1"/>
		            <form:hidden path="busiAddr2"/>
		            <form:hidden path="busiAddr3"/>
		            <form:hidden path="busiAddr4"/>						
				</td>
			</tr>	
			<tr>
				<th class="leftNoLine">전체부지면적</th>
				<td class="rightNoLine">
					<ul class="ulList">
						<li class="marginRright12">
							<form:input  path="totSiteArea" cssClass="form-control input-sm _float" style="width: 285px;" title="전체부지면적"/> 
						</li>
						<li>	
							<form:select path="totSiteUnit" cssClass="form-control input-sm" cssStyle="width: 100px;" title="입력단위" items="${totSiteUnit}" ></form:select>
						</li>
					</ul>	
				</td>
			</tr>	
			<tr>
				<th class="leftNoLine">총 사업비</th>
				<td class="rightNoLine"><form:input  path="totBusiExps" cssClass="form-control input-sm _float" cssStyle="width: 285px;" title="총 사업비"/></td>
			</tr>
			<tr>
				<th class="leftNoLine">사업기간</th>
				<td class="rightNoLine">
						<table class="noLine">
							<tr>
								<td> 
									<div class="input-group">
				                		<form:input path="busiSttDate" cssClass="date-picker form-control input-sm" style="width: 103px;"  title="총 사업기간 시작일" />
				                		<label for="busiSttDate" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
				            		</div>
								</td>
								<td>&nbsp;~&nbsp;</td>
								<td>
									<div class="input-group">
				                		<form:input path="busiEndDate" cssClass="date-picker form-control input-sm" style="width: 103px;"  title="총 사업기간 종료일" />
				                		<label for="busiEndDate" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
				            		</div>
								</td>
							</tr>
						</table>
				</td>	
			</tr>	
			<tr>
				<th class="leftNoLine">사업개발주체</th>
				<td class="rightNoLine"><form:input path="busiDevEnty" class="form-control input-sm" style="width: 285px;" title="사업운영주체"/></td>
			</tr>	
			<tr>
				<th class="leftNoLine">계획수립일자</th>
				<td class="rightNoLine">
					<table class="noLine">
						<tr>					
							<td> 
								<div class="input-group">
									<form:input path="busiPlanDate" class="date-picker form-control input-sm" style="width: 103px;" title="계획수립일자"/>
									<label for="busiPlanDate" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
								</div>
							</td>
						</tr>
					</table>	
				</td>
			</tr>	
			<tr class="bottom">
				<th class="leftNoLine">사업의 구분</th>
				<td class="rightNoLine">
					<ul class="ulList">
					  	<li class="marginRright12">
							<select name="busiType" id="busiType" class="form-control input-sm" style="width: 137px;" title="사업의 구분">
				                <option value=""></option>
				                <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
				                     <option value='<c:out value="${type.code }"/>' ${(model.busiType == type.code)? "selected":"" }>
				                         <c:out value="${type.codeNm }"/>
				                     </option>
				                </c:forEach>
							</select>
						</li>
						<li>
							<select name="busiCate" id="busiCate" class="form-control input-sm" style="width: 137px;" title="사업의 유형" >
							 	<option value=""></option>
				                 <c:forEach items="${busiCateComboList }" varStatus="idx" var="cate">
				                     <c:if test="${model.busiType == cate.parentCode }">
				                         <option value='<c:out value="${cate.code }"/>' ${(model.busiCate == cate.code)? "selected":"" }>
				                             <c:out value="${cate.codeNm }"/>
				                         </option>
				                     </c:if>
				                 </c:forEach>							 	
							</select>
					  	</li>
					</ul>
				</td>
			</tr>	
		</tbody>
	</table><!-- //Table-->


	<h5 class="position">사업관련파일
		<span class="smBtn">
			<a href="#href"  class="btn btn-smBlue marginRright4"  id="ctlBtnAdd" ><i class="icon-ic_note_add">&nbsp;</i>파일추가</a>
			<a href="#href" class="btn btn-smRed" id="ctlBtnRemv"><i class="fa fa-trash">&nbsp;</i>파일삭제</a>
		</span>
	</h5>
	<!-- Table -->
	<table class="table tableNormal" id="dyTblPlyy">
		<colgroup>
			<col style="width: 115px;">
			<col style="width: 190px;">
			<col style="width: *;"> 
		</colgroup>
		<tbody>
		<%-- 첨부파일 구분 표시를 위한 loop --%>
		<c:set var="plyyYearVal" value=""/>
		<c:forEach items="${plyyFileList }" varStatus="idx" var="plyyFYear"> 
			<c:if test="${plyyYearVal != plyyFYear.atthType }">
				<c:set var="plyyYearVal" value="${plyyFYear.atthType }"/>
				<tr class="top bottom">
					<th class="leftNoLine">첨부파일</th>
					<td class="rightNoLine">
						<ul class="file_input">
							<li><input type="checkbox" name="delChk" value='<c:out value="${plyyFYear.atthType }"/>' ></li>
							<li>
								<select class="form-control input-sm" style="width: 137px;" name="arrBusiPlyyDocuTypeYearTemp" title="첨부파일 구분" ${(null eq plyyFYear.atthType)? "":"disabled" }>
								 <option value=""></option>
				                 <c:forEach items="${atthTypeComboList }" varStatus="idx" var="atthType">
				                         <option value='<c:out value="${atthType.code }"/>'   <c:if test="${atthType.code eq plyyFYear.atthType}"> selected='selected'</c:if>>
				                             <c:out value="${atthType.codeNm }"/>
				                         </option>
				                 </c:forEach>									 
								</select>								  
								<input type="hidden" name="arrBusiPlyyDocuTypeYear" value='<c:out value="${plyyFYear.atthType }"/>'/>
							</li>	
						</ul>				
					</td>
					<td class="rightNoLine">
	                <%-- 첨부파일별 파일 리스트를 출력하기 위한 loop --%>
	                <c:if test="${fn:length(plyyYearVal) > 0 }">
	                    <div  class="_attachedFileArea" style="margin-bottom: 5px ;">
	                        <c:forEach items="${plyyFileList }" varStatus="idx" var="plyyF">
	                            <c:if test="${plyyYearVal==plyyF.atthType && null != plyyF.atthType}">
	                                <div class="_dynamicFileGroup">
	                                    <a href="#down" class="_fileDownCls" _todeFileNo='<c:out value="${plyyF.evaluFileNo }"/>'>
	                                        <i class="icon-ic_attachment textRed">&nbsp;</i><c:out value="${plyyF.fileOrgNm }"/>
	                                    </a>
	                                </div>
	                            </c:if>
	                        </c:forEach>
	                    </div>
	                </c:if>	
	                <%-- 신규파일 입력 FORM --%>			
					<div style="display: inline;" class="_dyFileAreaCls">
						<div style="display: inline;" class="_dynamicGroup">
							<ul class="file_input">
								<li><input type="text" id="upfilePath" name="upfilePath" class="file_input_textbox form-control input-sm" style="width: 350px;" disabled="disabled" readonly="readonly" title="파일경로">
									<div class="file_input_div">
										<input type="button" value="&#xe91b;&nbsp;파일첨부" class="file_input_button btn btn-smOrange" /> 
										<input type="file" name="upload" class="file_input_hidden"  _docuType="PLYY" _atthType=""  title="파일"/> 
									</div>
								</li>
							</ul>
						</div>
					</div>		
					</td>
				</tr>
			</c:if>
		</c:forEach>	
		</tbody>
	</table><!-- //Table-->

	<div class="text-center" style="margin:55px 0 115px;">
		<a class="btn btn-green marginRright12" href="#href"  id="prcBtnSave"><i class="icon-ic_create">&nbsp;</i>등록</a><!-- 20160203 : marginRright15 => marginRright12 이름변경 -->
		<a class="btn btn-red" href="#"  id="prcBtnList"><i class="icon-ic_refresh">&nbsp;</i>취소</a><!-- 20160203 : 모달링크 삭제, 하단 모달내용 삭제 -->
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