<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
	
	<!-- tode공통 추가 js -->
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
	<script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script>
	
	<!-- jstree 추가 js -->
	<script type="text/javascript" src="/jquery/jstree/jquery.jstree.js"></script>
	<script type="text/javascript" src="/jquery/jstree/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="/jquery/jstree/jquery.cookie.js"></script>
	
</head>

<body id="top">
<div class="wrap">

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" />

<!-- ======================================================= -->
<!-- ==================== 중앙내용 시작 ==================== -->
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
        <input type="hidden" name="srchBusiStage"  id="srchBusiStage"  value='<c:out value="${paramMap.srchBusiStage}"/>'/>
        <input type="hidden" name="srchEvaluDate"  id="srchEvaluDate"  value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
    </div>
    
    <input type="hidden" name="regiEvaluCommId"     id="regiEvaluCommId"/>

    <%-- 평가위원 타켓 --%>
    <input type="hidden" name="targetId"     id="targetId"/>
    <input type="hidden" name="paramEvaluItem" id="paramEvaluItem"/>
    <input type="hidden" name="preEvaluItem" id="preEvaluItem" value="${rtnMap.stgMap.evaluStage }"/>
    <input type="hidden" name="arrIndi" id="arrIndi" value="${rtnMap.arrIndi }"/>
    <input type="hidden" name="deltEvaluCommId" id="deltEvaluCommId" />
    							
	<div class="contentsTilteLine">
		<strong>사업평가관리 평가계획 등록</strong>
		<ol class="breadcrumb pull-right">
        	<strong>현재 페이지 :&nbsp;</strong>
			<li><a href="#">HOME</a></li>
			<li><a href="#">사업관리</a></li>
			<li><a href="#">사업평가관리</a></li>
			<li>사업평가관리 평가계획 등록</li>
		</ol>
	</div>
						
	<h5>평가계획 수립정보 입력</h5>
	<!-- Table -->
	<table class="table tableNormal small" id="dyTblStah">
		<colgroup>
			<col style="width: 115px;">
			<col style="width: 198px;">
			<col style="width: 198px;">
			<col style="width: *;">
		</colgroup>
			<tr class="top2">
				<th class="leftNoLine">평가대상항목</th>
				<td class="rightNoLine">
					<select name="evaluItem" id="evaluItem" style="width: 130px; " title="평가대상항목" class="form-control input-sm pull-left marginRright12">
		                <option value=""></option>
		                <c:forEach items="${evaluItemCdComboList }" varStatus="status" var="evaluItem">
		                    <option value='<c:out value="${evaluItem.code }"/>'  <c:if test="${rtnMap.stgMap.evaluStage eq evaluItem.code}">selected="selected"</c:if>><c:out value="${evaluItem.codeNm }"/></option>
		                </c:forEach>
		            </select>
					<select name="evaluGubun" id="evaluGubun" style="width: 130px; " title="평가년도" class="form-control input-sm">
		                <option value=""></option>
	                    <option value='PREV' <c:if test="${rtnMap.stgMap.evaluGubun eq 'PREV'}">selected="selected"</c:if>>2014년</option>
	                    <option value='AFTER' <c:if test="${rtnMap.stgMap.evaluGubun eq 'AFTER'}">selected="selected"</c:if>>2015년</option>
	                    <option value='AFTER2016' <c:if test="${rtnMap.stgMap.evaluGubun eq 'AFTER2016'}">selected="selected"</c:if>>2016년</option>
		            </select>
				</td>
				<td colspan="2" class="leftNoLine rightNoLine"> </td>
			</tr>
			<tr>
				<th class="leftNoLine">사전평가대상</th>
				<td class="rightNoLine">
					<select name="evaluAssment" id="evaluAssment" style="width: 130px; " title="사전평가대상" class="form-control input-sm">
		                <option value=""></option>
		                <c:forEach items="${evaluAssmentComboList }" varStatus="status" var="evaluAssment">
		                    <option value='<c:out value="${evaluAssment.code }"/>'  <c:if test="${rtnMap.stgMap.evaluBefoTrgt eq evaluAssment.code}">selected="selected"</c:if>><c:out value="${evaluAssment.codeNm }"/></option>
		                </c:forEach>
		            </select>

				</td>
				<td colspan="2" class="leftNoLine rightNoLine"> </td>
			</tr>	
			<tr>
				<th class="leftNoLine">평가일</th>
				<td class="rightNoLine">
					<div class="input-group">
						<input name="evaluSttDate"  id ="evaluSttDate" class="date-picker form-control input-sm" title="평가일"  value="${rtnMap.stgMap.evaluDate }"/>
                		<label for="evaluSttDate" class="input-group-addon btn btn-calendar"><i class="fa fa-calendar"> </i></label>
            		</div>
				</td>
				<td colspan="2" class="leftNoLine rightNoLine"> </td>
			</tr>
			<tr>
				<th rowspan="1" class="leftNoLine bottom">평가항목 매칭</th>
				<td colspan="2" class="rightNoLine">
	            	<div id="evaluItemDiv" class="demo">

					</div>
				</td>	
			</tr>	
		<c:if test="${empty rtnMap.commList}">	
			<tr>
				<th class="leftNoLine" rowspan="2">평가위원 매칭</th>
				<td colspan="3" class="rightNoLine" align="right">
					<a href="#link"  class="btn btn-smBlue"  id="ctlBtnCommAdd"><i class="icon-ic_note_add">&nbsp;</i>평가위원 추가</a>
					<a href="#link"  class="btn btn-smRed"  id="ctlBtnCommDel"><i class="icon-ic_note_add">&nbsp;</i>평가위원 삭제</a>
				</td>
			</tr>		
			<tr class="_commTr">
				<td colspan="3" class="rightNoLine">
					<ul class="file_input">
						<li><input type="checkbox" name="delChk" class="checkbox_01"  title="파일삭제"/></li>
						<li class="fileName">
							<input name="evaluCommNm1"  id ="evaluCommNm1" style="width: 400px;" title="평가위원" class="form-control input-sm _objCommNm" readonly="readonly"/>
						</li>
						<li style="margin-right:0;">
							<span class="small_btn_01 small_color_01" id="selBtnCommit" ><a href="#link" class="btn btn-smOrange" data-toggle="modal" data-target="#myModal"><i class="icon-ic_account_circle">&nbsp;</i>평가위원 선택</a></span>
				        	<input type="hidden" name="evaluCommId1" id="evaluCommId1" class="_objCommId"/>	
						</li>
					</ul>
				</td>
			</tr>
		<!-- 
			<tr>
				<td colspan="3" class="rightNoLine">
					<input name="evaluCommNm2"  id ="evaluCommNm2" style="width: 536px;" title="평가위원2" class="form-control input-sm marginRright12 pull-left" readonly="readonly"/>
	        		<span class="small_btn_01 small_color_01" id="selBtnCommit" ><a href="#link" class="btn btn-smOrange" data-toggle="modal" data-target="#myModal"><i class="icon-ic_account_circle">&nbsp;</i>평가위원 선택</a></span>
		        	<input type="hidden" name="evaluCommId2" id="evaluCommId2"/>
        	
				</td>
			</tr>
			<tr>
				<td colspan="3" class="rightNoLine">
					<input name="evaluCommNm3"  id ="evaluCommNm3" style="width: 536px;" title="평가위원3" class="form-control input-sm marginRright12 pull-left" readonly="readonly"/>
	        		<span class="small_btn_01 small_color_01" id="selBtnCommit" ><a href="#link" class="btn btn-smOrange" data-toggle="modal" data-target="#myModal"><i class="icon-ic_account_circle">&nbsp;</i>평가위원 선택</a></span>
		        	<input type="hidden" name="evaluCommId3" id="evaluCommId3"/>
        	
				</td>
			</tr>
		 -->	
    	</c:if>		
    	<c:if test="${not empty rtnMap.commList}">   
    		<c:forEach items="${rtnMap.commList }" var="item"  varStatus="idx">
    		<tr <c:if test="${idx.count ne 1 }">class="_commTr"</c:if>>
			    <c:if test="${idx.count eq 1 }">
			        <th rowspan="${fn:length(rtnMap.commList) +1 }"><label for="busiDevEnty">평가위원매칭</label></th> 
					<td colspan="3" class="rightNoLine" align="right">
						<a href="#link"  class="btn btn-smBlue"  id="ctlBtnCommAdd"><i class="icon-ic_note_add">&nbsp;</i>평가위원 추가</a>
						<a href="#link"  class="btn btn-smRed"  id="ctlBtnCommDel"><i class="icon-ic_note_add">&nbsp;</i>평가위원 삭제</a>
					</td>	
					</tr> 
					<tr class="_commTr">		        
			    </c:if> 
				<td colspan="3" class="rightNoLine">
					<ul class="file_input">
						<li><input type="checkbox" name="delChk" class="checkbox_01"  title="파일삭제"/></li>
						<li class="fileName">
							<input name="evaluCommNm${idx.count }"  id ="evaluCommNm${idx.count }" style="width: 400px;" title="평가위원" class="form-control input-sm _objCommNm"  value="${item.userNm }"  readonly="readonly"/>
		        		</li>
		        		<li style="margin-right:0;">
			        		<span class="small_btn_01 small_color_01" id="selBtnCommit" ><a href="#link" class="btn btn-smOrange" data-toggle="modal" data-target="#myModal"><i class="icon-ic_account_circle">&nbsp;</i>평가위원 선택</a></span>
							<input type="hidden" name="evaluCommId${idx.count }" id="evaluCommId${idx.count }" value="${item.userId }" class="_objCommId"/>
						</li>
					</ul>
				</td>	
			</tr>	
    	  	</c:forEach>	
    	</c:if>						
	</table><!-- //Table-->

<!--  
<script>

	var arrIndi = $("#arrIndi").val();
	
	if(!isEmpty(arrIndi)){
		
		var arrStr = arrIndi.split(",");
		
		for ( var i in arrStr) { 
			
//			$("#evaluItemDiv").jstree("is_selected", $("#"+arrStr[i]) );
			$("#"+arrStr[i]).addClass("jstree-checked");
		}
	}	
</script>
-->	

	<div class="text-center" style="margin:100px 0 100px;">
				
		<span class="big_btn_01 big_color_01" id="prcBtnSave"><a href="#link" class="btn btn-green marginRright12"><i class="icon-ic_create">&nbsp;</i>저장</a></span>
        <span class="big_btn_01 big_color_02" id="prcBtnList"><a href="#link" class="btn btn-red"><i class="icon-ic_refresh">&nbsp;</i>취소</a></span>
        
	</div>
	
</form:form>	
			
</div><!-- /contents -->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 650px;">
      <div class="modal-header">
      	<div class="pull-left"><i class="icon-ic_account_circle"></i></div>
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="icon-ic_close"></i></span></button>
        	<h4>평가위원 목록</h4>
      </div>
      <div class="modal-body">
      
      <form name="frm" id="frm" method="post" >
      
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

			<table class="table table2Way marginBottom40"><!-- 검색-->
				<colgroup>
					<col style="width: 105px">
					<col style="width: 150px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr class="topPadding">
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>지역</th>
						<td>
						    <select class="form-control input-sm" name="srchBusiAddr1Temp" id="srchBusiAddr1Temp">
								<option value="">::전체::</option>
							</select>
						</td>
						<td>
						    <select class="form-control input-sm" style="width: 142px;" name="srchBusiAddr2Temp" id="srchBusiAddr2Temp">
								<option value="">::전체::</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가분야</th>
						<td colspan="2">
						    <select class="form-control input-sm" style="width: 142px;"  name="srchBusiTypeTemp" id="srchBusiTypeTemp" >
		                        <option value="">::전체::</option>
		                        <c:forEach items="${busiTypeComboList }" varStatus="idx" var="type">
		                            <option value='<c:out value="${type.code }"/>' ${(paramMap.srchBusiType == type.code)? "selected":"" }>
		                                <c:out value="${type.codeNm }"/>
		                            </option>
		                        </c:forEach>
							</select>
						</td>
					</tr>
					<tr class="bottomPadding">
						<th><i class="icon-ic_radio_button_on pinkText">&nbsp;</i>평가위원</th>
						<td colspan="2">
						    <input type="text" class="form-control input-sm" id="srchEvaluCommNmTemp" name="srchEvaluCommNmTemp" style="width: 292px;" value='<c:out value="${paramMap.srchEvaluCommNm }"/>' >
						</td>
					</tr>
				</tbody>
				<tfoot>	
					<tr>
						<td colspan="3">
							<a class="btn btn-search marginRright12" id="prcBtnSrch"><i class="icon-ic_search">&nbsp;</i>검색</a><!-- 20160203 : 전체변경1 -->
							<!--  
							<a class="btn btn-grassGreen" href="#" data-toggle="modal" data-target="#myModal"><i class="icon-ic_border_color">&nbsp;</i>평가대상 선정</a><!-- 20160203 : 전체변경2 
							-->
						</td>
					</tr>	
				</tfoot>					
			</table><!-- //검색-->
			
		</form>	
			
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
			
			<div class="text-center" style="margin: 40px 0;">
				<button type="button" class="btn btn-green marginRright12" id="prcBtnSect"><i class="icon-ic_check"> </i>선택완료</button>
				<button type="button" class="btn btn-red" data-dismiss="modal" id="prcBtnCnle"><i class="icon-ic_refresh"> </i>취소</button>
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