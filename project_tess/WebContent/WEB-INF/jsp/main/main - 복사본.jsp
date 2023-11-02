<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="en">
<head>
	<%@ include file ="../header.jsp" %>
	<title><spring:message code="title.sysname"/></title>
	<app:layout mode="stylescript" type="main" /><!-- style & javascript layout -->
	
    <script language="javascript"  type="text/javascript" src='/js/common-dyUtil.js'></script>
	<script language="javascript"  type="text/javascript" src='/js/common-bizUtil.js'></script>
</head>

<body id="page-top">
<div class="overlay"> </div>
<!-- <div class="wrap"> -->
	
<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header"  type="main"/>

			<!-- ******************************** 메인1 ****************************** -->
			<div id="main1" class="main1 row">
			
			<c:set var="arrIcon" value="${fn:split('icon-ic_content_paste,icon-ic_tonality,icon-ic_border_color,icon-ic_assignment_turned_in', ',')}"></c:set>
			<c:set var="index" value="0"></c:set>
			<c:forEach items="${listEvaluMainStat }" var="item" varStatus="idx">
				<c:choose>
					<c:when test="${item.evaluIndicatCd eq 'EVALU_PLAN' }"><c:set var="color" value="pink"/></c:when>
					<c:when test="${item.evaluIndicatCd eq 'EVALU_INTR' }"><c:set var="color" value="green"/></c:when>
					<c:when test="${item.evaluIndicatCd eq 'EVALU_AFTR' }"><c:set var="color" value="blue"/></c:when>
					<c:otherwise><c:set var="color" value="puple"/></c:otherwise>
				</c:choose>
				
				<c:if test="${idx.count % 3 eq 1 }">
					<div class="col-sm-3 col-xs-6 ">
						<div class="panel xsPanel">
						  <div class="panel-heading ${color }Back"><i class="${arrIcon[index]}"></i>${item.evaluIndicatNm }</div>
						  <c:set var="index" value="${index+1}"></c:set>
						  <div class="panel-body">
								<table>
									<tr>				
				</c:if>
					<td <c:if test="${idx.count % 3 eq 1 or idx.count % 3 eq 2  }">class="rightBorder"</c:if>><h2 class="${color }Text">${item.cnt }</h2>${item.codeNM }</td>
				<c:if test="${idx.count % 3 eq 0 }">
									</tr>
								</table>
					  		</div>
						</div><!-- /panel-->
					</div><!-- /col-md-3 col-sm-6-->
				</c:if>
			</c:forEach>	
				
			</div><!-- /#main1 -->
			
			<!-- ******************************** 메인2 ****************************** -->
			<div id="main2" class="main2 row">
				
			  <form:form commandName="model" name="model" id="model">
				<div class="col-md-6 col-sm-12">
					<div class="panel">
					  <div class="panel-heading"><span class="title"><i class="icon-ic_timer hidden-xs">&nbsp;</i>빠른 평가정보 찾기</span><a class="btn btn-mainSearch pull-right" href="#none"  id="prcBtnSrch"><i class="fa fa-search">&nbsp;</i>검색</a></div>
					  <div class="panel-body xsHeight190">
					  		<input type="hidden" name="evaluStage"   id="evaluStage"   value='<c:out value="${paramMap.srchEvaluStage}"/>'/>
					  		<input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
       						<input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
       						<input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
       						<input type="hidden" name="srchFinalEvaluFnd"  id="srchFinalEvaluFnd"  value='<c:out value="${paramMap.srchFinalEvaluFnd}"/>'/>
       						<input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"  value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
       						<ul>
								<li>
									<div class="row">
										<div class="col-sm-2 col-xs-12"><strong>평가단계</strong></div>
										<div class="col-sm-10 col-xs-12">
											<select class="form-control input-sm" name="srchEvaluStageTemp" id="srchEvaluStageTemp">
												<option value="">::전체::</option>
												<c:forEach items="${busiStageComboList }" varStatus="idx" var="busiStage">
														<option value='<c:out value="${busiStage.code }"/>' ${(paramMap.srchBusiCate == busiStage.code)? "selected":"" }>
															<c:out value="${busiStage.codeNm }"/>
														</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</li>
								<li>
									<div class="row">
										<div class="col-sm-2 col-xs-12"><strong>지역선택</strong></div>
										<div class="col-sm-5 col-xs-12 xsPadding">
											<select class="form-control input-sm" name="srchBusiAddr1Temp" id="srchBusiAddr1Temp">
												<option value="">::전체::</option>
											</select>
										</div>
										<div class="col-sm-5 col-xs-12">
											<select class="form-control input-sm" name="srchBusiAddr2Temp" id="srchBusiAddr2Temp">
												<option value="">::전체::</option>
											</select>
										</div>
									</div>
								</li>
								<li>
									<div class="row">
										<div class="col-sm-2 col-xs-12"><strong>평가결과</strong></div>
										<div class="col-sm-10 col-xs-12">
											<select class="form-control input-sm" name="srchFinalEvaluFndTemp" id="srchFinalEvaluFndTemp">
												<option value="">::전체::</option>
												<c:forEach items="${finlRestlSelComboList }" varStatus="idx" var="finlRestlSel">
													<option value='<c:out value="${finlRestlSel.code }"/>' ${(paramMap.srchBusiCate == finlRestlSel.code)? "selected":"" }>
														<c:out value="${finlRestlSel.codeNm }"/>
													</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</li>
								<li>
									<div class="row">
										<div class="col-sm-2 col-xs-12"><strong>사업명</strong></div>
										<div class="col-sm-10 col-xs-12">
											<input type="text" class="form-control input-sm" id="srchEvaluBusiNmTemp"  name="srchEvaluBusiNmTemp"/>
										</div>
									</div>
								</li>
							</ul>
					  </div><!-- /panel-body -->
					</div><!-- /panel -->
				</div><!-- /col-md-6 col-sm-12 -->
				 </form:form>	
				
				<div class="col-md-6 col-sm-12">
					<div class="panel">
					  <div class="panel-heading mainTab">

							  <!-- Nav tabs -->
							  <ul class="nav nav-tabs" role="tablist">
							    <li role="presentation" class="active"><a href="#board1" aria-controls="board1" role="tab" data-toggle="tab"><i class="icon-ic_cloud_done hidden-xs">&nbsp;</i>평가완료사업</a></li>
							    <li role="presentation"><a href="#board2" aria-controls="board2" role="tab" data-toggle="tab"><i class="icon-ic_thumb_up hidden-xs">&nbsp;</i>우수평가사례</a></li>
							    <a class="btn btn-mainMore pull-right" href="#" ><i class="icon-ic_add">&nbsp;</i>더보기</a>
							  </ul>
							</div>
							
							<div class="panel-body">	
							  <!-- Tab panes -->
							  <div class="tab-content">
							    <div role="tabpanel" class="tab-pane active" id="board1">
									<ul class="topMargin">
									<c:forEach items="${listEvaluFinalBusi }" var="item" varStatus="idx" end="4">
										<c:choose>
											<c:when test="${item.evaluStage eq 'EVALU_BUDT' }"><c:set var="color" value="pink"/></c:when>
											<c:when test="${item.evaluStage eq 'EVALU_NEWS' }"><c:set var="color" value="pink"/></c:when>
											<c:when test="${item.evaluStage eq 'EVALU_INTR' }"><c:set var="color" value="green"/></c:when>
											<c:when test="${item.evaluStage eq 'EVALU_AFTR' }"><c:set var="color" value="blue"/></c:when>
											<c:otherwise><c:set var="color" value="puple"/></c:otherwise>
										</c:choose>									
										<li><a href="#href"  onclick="viewEvaluData('${item.evaluStage}' , '${item.evaluBusiNo }' )">${item.evaluBusiNm }</a><b class="${color}Text">[${item.evaluIndicatNm }]</b></li>
									</c:forEach>
									</ul>
								</div>
							    <div role="tabpanel" class="tab-pane" id="board2">
									<ul class="topMargin">
									<c:forEach items="${addtnlsList }" var="item" varStatus="idx" end="4">
										<li><a href="#href" onclick="viewEvaluData('${item.evaluStage}' , '${item.caseNo }' )">${item.caseSubject }</a><b class="pinkText">[사전평가]</b></li>
									</c:forEach>
									<!-- 
										<li><a href="#" >보성녹차밭 관광자원 명소화 사업2<span class="pinkText pull-right">[사전평가]</span></a></li>
										<li><a href="#" >화암추등대 관광자원화 사업2<span class="greenText pull-right">[계획평가]</span></a></li>
										<li><a href="#" >보성녹차밭 관광자원 명소화 사업2<span class="pinkText pull-right">[사전평가]</span></a></li>
										<li><a href="#" >화암추등대 관광자원화 사업2<span class="greenText pull-right">[계획평가]</span></a></li>
										<li><a href="#" >보성녹차밭 관광자원 명소화 사업2<span class="pinkText pull-right">[사전평가]</span></a></li>
									 -->	
									</ul>
								</div>
							  </div><!-- /tab-content -->
							</div><!-- /panel-body -->
						
					</div><!-- /panel -->
				</div><!-- /col-md-6 col-sm-12 -->
			</div><!-- /#main2 -->
			
			<!-- ******************************** 메인3 ****************************** -->
			<div id="main3" class="row">
				
				<div class="col-sm-3 col-xs-6">
					<div class="panel xsPanel">
					  <div class="panel-heading"><img src="img/tdssSystem/main3_1.png"></div>
					  <div class="panel-body"><a href="#">시스템 소개</a></div>
					</div><!-- /panel -->
				</div><!-- /col-xs-3 -->
				
				<div class="col-sm-3 col-xs-6">
					<div class="panel xsPanel">
					  <div class="panel-heading"><img src="img/tdssSystem/main3_2.png"></div>
					  <div class="panel-body"><a href="#">평가시스템이란?</a></div>
					</div><!-- /panel -->
				</div><!-- /col-xs-3 -->
				
				<div class="col-sm-3 col-xs-6">
					<div class="panel">
					  <div class="panel-heading"><img src="img/tdssSystem/main3_3.png"></div>
					  <div class="panel-body"><a href="#">사업평가관리</a></div>
					</div><!-- /panel -->
				</div><!-- /col-xs-3 -->
				
				<div class="col-sm-3 col-xs-6">
					<div class="panel">
					  <div class="panel-heading"><img src="img/tdssSystem/main3_4.png"></div>
					  <div class="panel-body"><a href="#">평가위원관리</a></div>
					</div><!-- /panel -->
				</div><!-- /col-xs-3 -->
				
			</div><!-- /#main3 -->

			<!-- ******************************** 메인4 ****************************** -->
			<div id="main4" class="main2 main4 row">
				
				<div class="col-md-6 col-sm-12">
					<div class="panel">
					  <div class="panel-heading mainTab">

							  <!-- Nav tabs -->
							  <ul class="nav nav-tabs" role="tablist">
							    <li role="presentation" class="active" id="B01"><a href="#notice" aria-controls="notice" role="tab" data-toggle="tab"><i class="icon-ic_mic_black hidden-xs"> </i>공지사항</a></li>
							    <li role="presentation" id="B02"><a href="#qna" aria-controls="qna" role="tab" data-toggle="tab"><i class="icon-ic_live_help hidden-xs"> </i>Q&amp;A</a></li>
							    <li role="presentation" id="B03"><a href="#faq" aria-controls="faq" role="tab" data-toggle="tab"><i class="icon-ic_headset_mic hidden-xs "> </i>FAQ</a></li>
							    <a class="btn btn-mainMore pull-right" href="#href"  onclick="viewCustBbs(this);"><i class="icon-ic_add"></i>&nbsp;더보기</a>
							  </ul>
							  
						</div>
						<div class="panel-body">
							  <!-- Tab panes -->
							  <div class="tab-content">
							    <div role="tabpanel" class="tab-pane active" id="notice">
									<ul class="topMargin">
									<c:forEach items="${custBbsB01List }" var="item" varStatus="idx">
										<li><a href="#href"  onclick="viewCustBbs( '${item.bbsKind }'  ,'${item.bbsNo}');">${item.bbsSubject }</a><span>[${item.regiDate }]</span></li>
									</c:forEach>
									</ul>
								</div>
							    <div role="tabpanel" class="tab-pane" id="qna">
									<ul class="topMargin">
									<c:forEach items="${custBbsB02List }" var="item" varStatus="idx">
										<li><a href="#href" onclick="viewCustBbs( '${item.bbsKind }'  ,'${item.bbsNo}');">${item.bbsSubject }</a><span>[${item.regiDate }]</span></li>
									</c:forEach>
									</ul>
								</div>
								<div role="tabpanel" class="tab-pane" id="faq">
									<ul class="topMargin">
									<c:forEach items="${custBbsB03List }" var="item" varStatus="idx">
										<li><a href="#href" onclick="viewCustBbs( '${item.bbsKind }'  ,'${item.bbsNo}');">${item.bbsSubject }</a><span>[${item.regiDate }]</span></li>
									</c:forEach>
									</ul>
								</div>
							  </div><!-- /tab-content -->
						</div>
						
					</div><!-- /panel -->
				</div><!-- /col-xs-6 -->
				
				<div class="col-md-6 col-sm-12">
					<div class="panel">
					  <div class="panel-heading"><span class="title"><i class="icon-ic_poll hidden-xs"> </i>평가위원 분야별 통계</span></div>
					  <div class="panel-body">
					  	
							<table>
								<colgroup>
									<col style="width: 90px;"/>
									<col style="width: *;"/>
									<col style="width: 50px;"/>
								</colgroup>
								<tbody>
								<c:forEach items="${listEvaluCommitStat }"  begin="0" end="4"  var="item" varStatus="idx">
									<c:choose>
										<c:when test="${idx.count eq 1 }"><c:set var="barColor" value="greenBack2"/></c:when>
										<c:when test="${idx.count eq 2 }"><c:set var="barColor" value="orangeBack"/></c:when>
										<c:when test="${idx.count eq 3 }"><c:set var="barColor" value="bluegreenBack"/></c:when>
										<c:when test="${idx.count eq 4 }"><c:set var="barColor" value="bluegreenBack2"/></c:when> 
										<c:otherwise><c:set var="barColor" value="magentaBack"/></c:otherwise>
									</c:choose>										
								
									<tr>
										<th>${item.codeNm }</th>
										<td>
											<div class="progress">
											  <div class="progress-bar ${barColor }" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${item.percent}%;"></div>
											</div>
										</td>
										<td><strong>${item.cnt }명</strong></td>
									</tr>										
								</c:forEach>
								</tbody>
							</table>

					  </div><!-- /panel-body --> 
					</div><!-- /panel -->
				</div><!-- /col-xs-6 -->
			</div><!-- /#main4 -->

<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->		

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" type="main"/>
<!--</div>--><!--/#wrap-->

</body>
</html>