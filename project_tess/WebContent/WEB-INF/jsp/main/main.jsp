<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<html lang="ko">
<head>
    <%@ include file="../header.jsp" %>
    <title><spring:message code="title.sysname"/></title>
    <app:layout mode="stylescript" type="main" /><!-- style & javascript layout -->

    <script language="javascript" type="text/javascript" src='/js/common-dyUtil.js'></script>
    <script language="javascript" type="text/javascript" src='/js/common-bizUtil.js'></script>
</head>

<body id="page-top">
<div class="overlay"></div>
<!-- <div class="wrap"> -->

<!-- 헤더부분 -->
<!-- header layout -->
<app:layout mode="header" type="main"/>

<form:form commandName="model" name="model" id="model">
	<input type="hidden" name="srchBusiAddr1" id="srchBusiAddr1"/>
    <input type="hidden" name="srchBusiAddr2" id="srchBusiAddr2"/>
    <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal"/>
    <input type="hidden" name="srchBusiType" id="srchBusiType"/>
    <input type="hidden" name="srchBusiCate" id="srchBusiCate"/>
    <input type="hidden" name="srchEvaluBusiNm" id="srchEvaluBusiNm"/>
    <input type="hidden" name="srchEvaluDate" id="srchEvaluDate"/>
    <input type="hidden" name="srchFinalEvaluFnd" id="srchFinalEvaluFnd"/>
	<input type="hidden" name="srchEvaluGubun" id="srchEvaluGubun"/>
</form:form>

<div class="jumbotron">
    <div class="bg-dot"></div>
    <div class="container chart-wrap">
        <h1 class="section-title-silent">CHARTS</h1>
        <div class="row" id="stage_slide">

            <c:set var="index" value="0"></c:set>
            <c:forEach items="${listEvaluMainStat }" var="item" varStatus="idx">

                <%-- <c:choose>
                    <c:when test="${item.evaluIndicatCd eq 'EVALU_CENT' }"><c:set var="term"
                                                                                  value="1차(2월)/2차(5월)/3차(9월)"/></c:when>
                    <c:when test="${item.evaluIndicatCd eq 'EVALU_PREV' }"><c:set var="term" value="3월~5월"/></c:when>
                    <c:when test="${item.evaluIndicatCd eq 'EVALU_PROG' }"><c:set var="term" value="6월~8월"/></c:when>
                    <c:when test="${item.evaluIndicatCd eq 'EVALU_AFTR' }"><c:set var="term" value="9월~10월"/></c:when>
                </c:choose> --%>

                <%-- <c:if test="${item.evaluIndicatCd eq 'EVALU_CENT' or item.evaluIndicatCd eq 'EVALU_PREV' or item.evaluIndicatCd eq 'EVALU_PROG' or item.evaluIndicatCd eq 'EVALU_AFTR' }"> --%>
                    <%-- <c:if test="${idx.count % 3 eq 1 }">
                        <div class="main-step-proc col-sm-6 col-md-3">
                        <div class="main-step-box">
                        <div class="ovelay-white"></div>
                        <ul>
                        <span class="silent">단계별 평가진행 개요</span>
                        <li><h4>${item.evaluIndicatNm }</h4></li>
                        <li><p>${term}</p></li>
                        <li>
                    </c:if>
                    <c:if test="${idx.count % 3 ne 1}">
                        <div class="main-step-count">
                            <label>${item.codeNM }</label>
                            <h4>${item.cnt }</h4>
                        </div>
                    </c:if>
                    <c:if test="${idx.count % 3 eq 0 }">
                        </li>
                        </ul>
                        </div>
                        </div>
                    </c:if> --%>
                <%-- </c:if> --%>
                
                <div class="main-step-proc col-sm-6 col-md-3">
	                <div class="main-step-box">
	                	<div class="ovelay-white"></div>
	                		<ul>
	                			<span class="silent">단계별 평가진행 개요</span>
	                			<li><h4>${item.EVALU_INDICAT_NM}</h4></li>
	                			<li><p>${term}</p></li>
	                			<li>
	                				<div class="main-step-count">
			                            <label>평가중</label>
			                            <c:if test="${item.CNTN == null}">
			                            	<h4>0</h4>
			                            </c:if>
			                            <c:if test="${item.CNTN != null}">
			                            	<h4>${item.CNTN}</h4>
			                            </c:if>
			                        </div>
			                        <div class="main-step-count">
			                            <label>평가완료</label>
			                            <c:if test="${item.CNTY == null}">
			                            	<h4>0</h4>
			                            </c:if>
			                            <c:if test="${item.CNTY != null}">
			                            	<h4>${item.CNTY}</h4>
			                            </c:if>
			                        </div>
	                			</li>
	                		</ul>
	                	</div>
	                </div>
	                
            </c:forEach>
            
            <!-- <div class="main-step-proc col-sm-6 col-md-3">
                <div class="main-step-box">
                    <div class="ovelay-white"></div>
                    <ul>
                        <span class="silent">단계별 평가진행 개요</span>
                        <li><h4>중앙투자심사검토</h4></li>
                        <li><p>1차(2월)/2차(5월)/3차(9월)</p></li>
                        <li>
                            <div class="main-step-count">
                                <label>평가중</label>
                                <h4>0</h4>
                            </div>
                            <div class="main-step-count">
                                <label>평가완료</label>
                                <h4>32</h4>
                            </div>
                        </li>
                    </ul>
                </div>
            </div> -->


            <!-- <div class="main-step-proc col-sm-6 col-md-3">
                <div class="main-step-box">
                    <div class="ovelay-white"></div>
                    <ul>
                        <span class="silent">단계별 평가진행 개요</span>
                        <li><h4>중앙투자심사검토</h4></li>
                        <li><p>1차(2월)/2차(5월)/3차(9월)</p></li>
                        <li>
                            <div class="main-step-count">
                                <label>평가중</label>
                                <h4>0</h4>
                            </div>
                            <div class="main-step-count">
                                <label>평가완료</label>
                                <h4>32</h4>
                            </div>
                        </li>
                    </ul>
                </div>
            </div> /.main-step-proc
            <div class="main-step-proc col-sm-6 col-md-3">
                <div class="main-step-box">
                    <div class="ovelay-white"></div>
                    <ul>
                        <span class="silent">단계별 평가진행 개요</span>
                        <li><h4>사전평가</h4></li>
                        <li><p>3월~5월</p></li>
                        <li>
                            <div class="main-step-count">
                                <label>평가중</label>
                                <h4>0</h4>
                            </div>
                            <div class="main-step-count">
                                <label>평가완료</label>
                                <h4>64</h4>
                            </div>
                        </li>
                    </ul>
                </div>
            </div> /.main-step-proc
            <div class="main-step-proc col-sm-6 col-md-3">
                <div class="main-step-box">
                    <div class="ovelay-white"></div>
                    <ul>
                        <span class="silent">단계별 평가진행 개요</span>
                        <li><h4>집행평가</h4></li>
                        <li><p>6월~8월</p></li>
                        <li>
                            <div class="main-step-count">
                                <label>평가중</label>
                                <h4>0</h4>
                            </div>
                            <div class="main-step-count">
                                <label>평가완료</label>
                                <h4>32</h4>
                            </div>
                        </li>
                    </ul>
                </div>
            </div> /.main-step-proc
            <div class="main-step-proc col-sm-6 col-md-3">
                <div class="main-step-box">
                    <div class="ovelay-white"></div>
                    <ul>
                        <span class="silent">단계별 평가진행 개요</span>
                        <li><h4>사후평가</h4></li>
                        <li><p>9월~10월</p></li>
                        <li>
                            <div class="main-step-count">
                                <label>평가중</label>
                                <h4>0</h4>
                            </div>
                            <div class="main-step-count">
                                <label>평가완료</label>
                                <h4>32</h4>
                            </div>
                        </li>
                    </ul>
                </div>
            </div> /.main-step-proc -->
        </div> <!-- /.row -->
        
        <a id="stage_prev" class="stage_prev"><img src="./images/stage_prev_btn.png" alt="이전 버튼" title="이전 버튼"></a>
        <a id="stage_next" class="stage_next"><img src="./images/stage_next_btn.png" alt="다음 버튼" title="다음 버튼"></a>

        <div class="row">
            <div class="main-graph-proc col-sm-12">
                <div class="main-graph-wrap">
                    <div class="ovelay-white"></div>
                    <div class="main-graph-box col-sm-3">
                        <div class="divide-y"></div>
                        <h4>누적평가위원수</h4>

                        <canvas id="committeeCount" title="누적평가위원수" height="290"></canvas>
                        <script>
                            var committeeChartData = {
                                labels: ['2017', '2018'],
                                datasets: [{
                                    label: '누적인원',
                                    backgroundColor: window.chartColors.green,
                                    data: [
                                        100,
                                        79
                                    ]
                                }, {
                                    label: '당해연도 참여인원',
                                    backgroundColor: window.chartColors.blue,
                                    data: [
                                        0,
                                        3
                                    ]
                                }, {
                                    label: '신규추가인원',
                                    backgroundColor: window.chartColors.red,
                                    data: [
                                        0,
                                        21
                                    ]
                                }]
                            };
                        </script>
                    </div>
                    <div class="main-graph-box col-sm-3">
                        <div class="divide-y"></div>
                        <h4>2018년 평가목표</h4>

                        <canvas id="evalTargetCount" title="2018년 평가목표" height="290"></canvas>
                        <script>
                            var evalChartData = {
                                labels: ['목표', '달성'],
                                datasets: [{
                                    backgroundColor: window.chartColors.green,
                                    data: [
                                        16,
                                        0
                                    ]
                                }]
                            };
                        </script>
                    </div>
                    <div class="main-graph-box col-sm-6">
                        <h4>연도별 평가현황</h4>
                        
                        <%-- <c:set var="listEvaluYearInfo" value="${listEvaluYearInfo}"/> --%>
                        
                        <canvas id="evalYearCount" title="연도별 평가현황" height="135"></canvas>
                        <script>

                        	var listStage = new Array();
                        	var list2014 = new Array();
                        	var list2015 = new Array();
                        	var list2016 = new Array();
                        	var list2017 = new Array();
                        	var list2018 = new Array();
                        
                        	<c:forEach items="${listEvaluYearInfo}" var="item">
								listStage.push("${item.EVALU_NAME}");
								list2014.push("${item.y2014}");
								list2015.push("${item.y2015}");
								list2016.push("${item.y2016}");
								list2017.push("${item.y2017}");
								list2018.push("${item.y2018}");
							</c:forEach>
							
							console.log(listStage);
                        	
                            var evalYearData = {
                                labels: ['2014', '2015', '2016', '2017', '2018'],
                                
                                datasets: [
                                           
									{
									    label: listStage[0],
									    backgroundColor: window.chartColors.green,
									    data: [
									        list2014[0], list2015[0], list2016[0], list2017[0], list2018[0]
									    ]
									}, {
									    label: listStage[1],
									    backgroundColor: window.chartColors.red,
									    data: [
									        list2014[1], list2015[1], list2016[1], list2017[1], list2018[1]
									    ]
									}, {
									    label: listStage[2],
									    backgroundColor: window.chartColors.blue,
									    data: [
									        list2014[2], list2015[2], list2016[2], list2017[2], list2018[2]
									    ]
									}, {
									    label: listStage[3],
									    backgroundColor: window.chartColors.orange,
									    data: [
									        list2014[3], list2015[3], list2016[3], list2017[3], list2018[3]
									    ]
									}, {
									    label: listStage[4],
									    backgroundColor: window.chartColors.gray,
									    data: [
									        list2014[4], list2015[4], list2016[4], list2017[4], list2018[4]
									    ]
									}
                                           
	                                /* {
	                                    label: '중앙투자심사',
	                                    backgroundColor: window.chartColors.green,
	                                    data: [
	                                        0, 0, 29, 2, 0
	                                    ]
	                                }, {
	                                    label: '사전평가',
	                                    backgroundColor: window.chartColors.red,
	                                    data: [
	                                        0, 0, 27, 20, 6
	                                    ]
	                                }, {
	                                    label: '집행평가',
	                                    backgroundColor: window.chartColors.blue,
	                                    data: [
	                                        0, 0, 12, 0, 10
	                                    ]
	                                }, {
	                                    label: '사후평가',
	                                    backgroundColor: window.chartColors.orange,
	                                    data: [
	                                        0, 0, 0, 6, 0
	                                    ]
	                                }, {
	                                    label: '컨설팅',
	                                    backgroundColor: window.chartColors.red,
	                                    data: [
	                                        4, 1, 0, 0, 0
	                                    ]
	                                } */
	                                
                                ]
                            };
                        </script>
                    </div>
                </div>
            </div>
        </div> <!-- /.row -->

        <!--
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>
        -->
    </div>
</div>

<div class="contents-wrap">
    <div class="wrapper main"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
        <div class="container">
            <div class="row">
                <div class="main-content-layout col-sm-6 col-md-4">
                    <%-- <div class="main-content-inner col-sm-12">
                        <div class="main-content-box hx2">
                            <div class="box-title">
                                <h3>주요일정</h3>
                            </div>

                            <section class="calendar_area" style="padding: 0; margin: 0;">
                                <div class="month-pick">
                                    <button class="" title="이전월" type="button" onclick="prevM()">
                                        <img src="img/arw_sm_left.png" alt="이전월">
                                    </button>
                                    <span id="strMonth">2018년 8월</span>
                                    <button type="button" onclick="nextM()">
                                        <img src="img/arw_sm_right.png" alt="다음월">
                                    </button>
                                </div>
                                <div id="calendar"></div>
                            </section>
                            <div class="box-scroll" style="height: 155px">
                                <div class="read-more">
                                    <a id="toDay" title="세부일정 더보기"></a>
                                </div>
                                <ul id="scheduleList">
                                    <li><label>사전평가</label></li>
                                    <li>
                                        <div class="title"><a href="../bbs/scheduleView.html"
                                                              title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a>
                                        </div>
                                        <div class="date">2018-08-04 15:00</div>
                                    </li>
                                </ul>
                                <ul>
                                <li><label>사전평가</label></li>
                                <li>
                                <div class="title"><a href="../bbs/scheduleView.html" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a></div>
                                <div class="date">2018-08-04 15:00</div>
                                </li>
                                </ul>
                                <ul>
                                <li><label>사전평가</label></li>
                                <li>
                                <div class="title"><a href="../bbs/scheduleView.html" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a></div>
                                <div class="date">2018-08-04 15:00</div>
                                </li>
                                </ul>
                                <ul>
                                <li><label>사전평가</label></li>
                                <li>
                                <div class="title"><a href="../bbs/scheduleView.html" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a></div>
                                <div class="date">2018-08-04 15:00</div>
                                </li>
                                </ul>

                                <!-- 목룍출력 후 표시 -->


                            </div>
                        </div>
                    </div> --%>
                    
                    <div class="main-content-inner">
						<div class="main-content-box">
                           <div class="main-content-head">
                               <h3>주요일정</h3>

                               <div class="main-content-btns">
                                   <a title="더보기" href="/bbs/listBbsSchedule.do">더보기 <i class="glyphicon glyphicon-plus"></i></a>
                               </div>
                           </div>
                           <div class="main-content-body">
                               <p class="sr-only">주요일정을 확인합니다.</p>
                               <div class="main-comp-bbs">
                                   <ul id="daily_bbs_ul">
                                       <!-- <li class="needLabel">
                                           <label>중앙투자심사</label>
                                           <a href="#" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a>
                                           <span>2018-08-04 15:00</span>
                                       </li>
                                       <li class="needLabel">
                                           <label>사전평가</label>
                                           <a href="#" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a>
                                           <span>2018-08-04 15:00</span>
                                       </li>
                                       <li class="needLabel">
                                           <label>중앙투자심사</label>
                                           <a href="#" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a>
                                           <span>2018-08-04 15:00</span>
                                       </li> -->
                                   </ul>
                               </div>
                           </div>
                       </div>
                	</div>
                	
                	<div class="main-content-inner">
                        <div class="main-content-box">
                            <div class="main-content-head">
                                <h3>공지사항</h3>

                                <div class="main-content-btns">
                                    <a title="더보기" href="/bbs/listBbsNotice.do">더보기 <i class="glyphicon glyphicon-plus"></i></a>
                                </div>
                            </div>
                            <div class="main-content-body">
                                <p class="sr-only">공지사항을 확인합니다.</p>
                                <div class="main-comp-bbs">
                                    <ul>
                                    	<c:forEach items="${custBbsB01List }" var="item" varStatus="idx" end="5">
                                    		<li>
	                                			<%-- <a onclick="bbsView(${item.bbsNo}, '${item.bbsKind}')" 
	                                				title="${item.bbsSubject}" href="javascript:void(0);">
		                                			<img src="img/storage/jacket.png" alt="${item.bbsSubject}">
		                                            <p>${item.bbsSubject}</p>
		                                        </a> --%>
		                                        
		                                        <a onclick="bbsView(${item.bbsNo}, '${item.bbsKind}')" href="javascript:void(0);"
		                                        title="${item.bbsSubject}">${item.bbsSubject}</a>
                                            	<span>${item.regiDate}</span>
	                                		</li>
	                                	</c:forEach>
                                    
                                        <!-- <li>
                                            <a href="#" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a>
                                            <span>2018-08-04 15:00</span>
                                        </li>
                                        <li>
                                            <a href="#" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 제목이 너무 길어서 말줄임이 되는 경우</a>
                                            <span>2018-08-04 15:00</span>
                                        </li>
                                        <li>
                                            <a href="#" title="만학천봉 관광레포츠시설 확충 종합평가">만학천봉 관광레포츠시설 확충 종합평가</a>
                                            <span>2018-08-04 15:00</span>
                                        </li> -->
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="main-content-layout  col-sm-6 col-md-8">

                    <div class="main-content-inner col-md-8 col-sm-12">
                        <div class="main-content-box">
                            <div class="main-content-head">
                                <h3>자료실</h3>

                                <div class="main-content-btns">
                                    <a href="/bbs/listBbsFile.do" title="자료실 더보기">자료실 더보기 
                                    	<i class="glyphicon glyphicon-plus"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="main-content-body">
                                <div class="desc">평가사업 진행에 필요한 공용자료를 모았습니다.</div>

                                <form:form name="bbsViewForm" id="bbsViewForm" method="post">
                                    <input type="hidden" name="bbs_no" id="bbs_no"/>
                                    <input type="hidden" name="bbs_type" id="bbs_type" value="B04"/>
                                </form:form>
                                
                                <%-- <ul class="thumbs">
                                    <c:forEach items="${custBbsB02List }" var="item" varStatus="idx" end="3">
                                        <li>
                                            <a onclick="bbsView(${item.bbsNo}, '${item.bbsKind}')"
                                               title="${item.bbsSubject}" href="javascript:void(0);">
                                                <img src="img/storage/jacket.png" alt="${item.bbsSubject}">
                                                <p>${item.bbsSubject}</p>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul> --%>
                                
                                <div class="thumbs" id="reference_slide">
                                	<c:forEach items="${custBbsB02List }" var="item" varStatus="idx">
                                		<div class="file_item">
                                			<a onclick="bbsView(${item.bbsNo}, '${item.bbsKind}')" 
                                				title="${item.bbsSubject}" href="javascript:void(0);">
	                                			<img src="img/storage/jacket.png" alt="${item.bbsSubject}">
	                                            <p>${item.bbsSubject}</p>
	                                        </a>
                                		</div>
                                	</c:forEach>
                                </div>
                            </div>
                            
                            <a id="reference_prev" class="reference_prev"><img src="./images/reference_prev_btn.png" alt="이전 버튼" title="이전 버튼"></a>
                            <a id="reference_next" class="reference_next"><img src="./images/reference_next_btn.png" alt="다음 버튼" title="다음 버튼"></a>
                        </div>
                    </div>

                    <div class="main-content-inner col-md-4 col-sm-6">
                        <div class="main-content-box green">
                            <div class="main-content-head">
                                <h3>나의 평가업무</h3>
                            </div>
                            <div class="main-content-body">
                                <p>진행중인 평가사업을 확인하고<br>업무를 진행할 수 있습니다.</p>
                                <div class="main-content-btns">
                                    <a href="/busi/listEvaluBusi.do" title="평가업무보기 " class="white">평가업무보기 <i
                                            class="glyphicon glyphicon-plus"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="main-content-inner col-md-8 col-sm-6 mobile-hide">
                        <div class="main-content-box">
                            <div class="main-content-head">
                                <h3>평가사업검색</h3>

                                <div class="main-content-btns">
                                	<c:if test="${ map.gsUserId eq null}">
	                                	<a title="평가진행사업 " onclick="login_check();">
	                                		평가진행사업 <i class="glyphicon glyphicon-plus"></i>
	                                	</a>
	                                	<!-- <a title="평가업무보기 " onclick="login_check();">
	                                    	평가업무보기 <i class="glyphicon glyphicon-plus"></i>
	                                    </a> -->
                                	</c:if>
                                	<c:if test="${ map.gsUserId ne null}">
                                		<a title="평가진행사업 " href="/busi/listEvaluBusi.do">
	                                		평가진행사업 <i class="glyphicon glyphicon-plus"></i>
	                                	</a>
	                                	<!-- <a title="평가업무보기 " href="/busi/listEvaluBusi.do">
	                                    	평가업무보기 <i class="glyphicon glyphicon-plus"></i>
	                                    </a> -->
                                	</c:if>
                                    <!-- <a title="평가진행사업 " href="../evaluation/evalList.html">평가진행사업 <i
                                            class="glyphicon glyphicon-plus"></i></a> -->
                                    <!-- <a title="평가업무보기 " href="#">
                                    	평가업무보기 <i class="glyphicon glyphicon-plus"></i>
                                    </a> -->
                                </div>
                            </div>

                            <div class="main-content-body">
                                <form>
                                    <table class="table-search">
                                        <tr>
                                            <td class="search-label">평가연도</td>
                                            <td>
                                                <div class="form-group noMargin noPadding">
                                                    <select id="newEvalYear" title="평가연도">
                                                        <option value="" selected>전체</option>
                                                        <option value="2018">2018</option>
                                                        <option value="2017">2017</option>
                                                        <option value="2016">2016</option>
                                                        <option value="2015">2015</option>
                                                        <option value="2014">2014</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td class="search-label">평가단계</td>
                                            <td>
                                                <div class="form-group noMargin noPadding">
                                                    <!-- <select id="searchStep" title="평가단계">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="사전평가">사전평가</option>
                                                        <option value="사후평가">사후평가</option>
                                                        <option value="집행평가">집행평가</option>
                                                    </select> -->
                                                    
                                                    <select class="form-control input-sm" name="srchEvaluStageTemp" id="srchEvaluStageTemp" title="평가단계">
														<option value="">::전체::</option>
														<c:forEach items="${busiStageComboList}" varStatus="idx" var="busiStage">
																<option value='<c:out value="${busiStage.code }"/>' ${(paramMap.srchBusiCate == busiStage.code)? "selected":"" }>
																	<c:out value="${busiStage.codeNm }"/>
																</option>
														</c:forEach>
													</select>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="search-label">지역선택</td>
                                            <td>
                                                <div class="form-group noMargin noPadding">
                                                    <!-- <select id="searchUnion" title="시/도">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="서울">서울</option>
                                                        <option value="인천">인천</option>
                                                        <option value="경기">경기</option>
                                                        <option value="강원">강원</option>
                                                        <option value="충북">충북</option>
                                                    </select> -->
                                                    <select name="srchBusiAddr1Temp" id="srchBusiAddr1Temp" title="시/도">
														<option value="">::전체::</option>
													</select>
                                                </div>
                                            </td>
                                            <td colspan="2">
                                                <div class="form-group noMargin noPadding">
                                                    <!-- <select id="searchArea" title="시/군/구">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="강남">강남</option>
                                                        <option value="강북">강북</option>
                                                        <option value="강서">강서</option>
                                                        <option value="강남">강남</option>
                                                        <option value="성북">성북</option>
                                                        <option value="성동">성동</option>
                                                        <option value="노원">노원</option>
                                                    </select> -->
                                                    <select name="srchBusiAddr2Temp" id="srchBusiAddr2Temp" title="시/군/구">
														<option value="">::전체::</option>
													</select>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="search-label">사업명</td>
                                            <td><input type="text" class="search-input-txt" id="srchEvaluBusiNmTemp" name="srchEvaluBusiNmTemp" title="사업명" placeholder="사업명"></td>
                                            <td class="search-label">평가위원</td>
                                            <td><input type="text" class="search-input-txt" id="srchEvaluCommitNmTemp" name="srchEvaluCommitNmTemp" title="평가위원" placeholder="평가위원"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <button type="button" title="검색" onclick="busi_search();"><img alt="검색" src="img/m-search.png"></button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>

                        </div>
                    </div>
					
					
					<c:if test="${map.gsRoleId eq 'ROLE_AUTH_SYS'}">
						<div class="main-content-inner col-md-4 col-sm-6">
	                        <div class="main-content-box">
	                            <div class="main-content-body symbox">
	                                <div class="main-content-image">
	                                    <img src="img/main_box_img_0.png" alt="전문분야별 평가위원">
	                                </div>
	
	                                <h3>전문분야별 평가위원</h3>
	                                <p>관련분야 별 기획평가단 관리</p>
	                                <div class="main-content-btns">
	                                    <a href="/mng/listEvaluMbrMgmt.do" title="평가위원 관리 ">평가위원 관리 <i
	                                            class="glyphicon glyphicon-plus"></i></a>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
					</c:if>
                </div>
                <div class="main-content-layout col-sm-12 mobile-show">
                    <div class="main-content-inner">
                        <div class="main-content-box">
                            <div class="main-content-head">
                                <h3>평가사업검색</h3>

                                <div class="main-content-btns">
                                    <a title="평가진행사업" href="../evaluation/evalList.html">평가진행사업 <i
                                            class="glyphicon glyphicon-plus"></i></a>
                                    <a title="평가업무보기" href="../evaluation/evalCompleteList.html">평가업무보기 <i
                                            class="glyphicon glyphicon-plus"></i></a>
                                </div>
                            </div>

                            <div class="main-content-body">
                                <form>
                                    <table class="table-search">
                                        <tr>
                                            <td class="search-label">평가연도</td>
                                            <td>
                                                <div class="form-group noMargin noPadding">
                                                    <select title="평가연도" id="newEvalYear">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="2019">2019</option>
                                                        <option value="2018">2018</option>
                                                        <option value="2017">2017</option>
                                                        <option value="2016">2016</option>
                                                        <option value="2015">2015</option>
                                                        <option value="2014">2014</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td class="search-label">평가단계</td>
                                            <td>
                                                <div class="form-group noMargin noPadding">
                                                    <select title="평가단계" id="searchStep">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="사전평가">사전평가</option>
                                                        <option value="사후평가">사후평가</option>
                                                        <option value="집행평가">집행평가</option>
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="search-label">지역선택</td>
                                            <td>
                                                <div class="form-group noMargin noPadding">
                                                    <select title="시/도" id="searchUnion">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="서울">서울</option>
                                                        <option value="인천">인천</option>
                                                        <option value="경기">경기</option>
                                                        <option value="강원">강원</option>
                                                        <option value="충북">충북</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td colspan="2">
                                                <div class="form-group noMargin noPadding">
                                                    <select title="시/군/구" id="searchArea">
                                                        <option value="전체" selected>전체</option>
                                                        <option value="강남">강남</option>
                                                        <option value="강북">강북</option>
                                                        <option value="강서">강서</option>
                                                        <option value="강남">강남</option>
                                                        <option value="성북">성북</option>
                                                        <option value="성동">성동</option>
                                                        <option value="노원">노원</option>
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="search-label">사업명</td>
                                            <td><input type="text" class="search-input-txt" title="사업명" placeholder="사업명"></td>
                                            <td class="search-label">평가위원</td>
                                            <td><input type="text" class="search-input-txt" title="평가위원" placeholder="평가위원"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <button type="submit" title="검색"><img alt="검색하기" src="img/m-search.png"></button>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div> <!-- /.row -->

        </div>
        <!-- Contents Layout -->
<!--     </div> -->

</div> <!-- /contents-wrap -->

<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->

<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" type="main"/>
<!--</div>--><!--/#wrap-->


<script>

    // 주요일정 , 자료실 상세보기 이동
    // 상세보기로 이동
    function bbsView(bbs_no, bbs_type) {

        var form = $('#bbsViewForm');
        $('#bbs_no').val(bbs_no);
        $('#bbs_type').val(bbs_type);

        if (bbs_type == 'B01') {
        	form.attr("action", "/bbs/viewBbsNotice.do");
        } else if (bbs_type == 'B02') {
            form.attr("action", "/bbs/viewBbsFile.do");
        } else if (bbs_type == 'B04') {
            form.attr("action", "/bbs/viewBbsSchedule.do");
        }

        form.submit();
    }


    window.onload = function () {
        var ctx = document.getElementById('committeeCount').getContext('2d');
        window.myBar = new Chart(ctx, {
            type: 'bar',
            data: committeeChartData,
            options: {
                title: {
                    display: false,
                    text: '누적평가위원수'
                },
                legend: {
                    position: 'bottom',
                    labels: {
                        fontSize: 11,
                        boxWidth: 12
                    }
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        stacked: true,
                    }],
                    yAxes: [{
                        stacked: true
                    }]
                }
            }
        });

        var ctx2 = document.getElementById('evalTargetCount').getContext('2d');
        window.myBar2 = new Chart(ctx2, {
            type: 'bar',
            data: evalChartData,
            options: {
                title: {
                    display: false,
                    text: '2018년 평가목표'
                },
                legend: {
                    position: 'bottom',
                    display: false
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        stacked: true,
                    }],
                    yAxes: [{
                        stacked: true
                    }]
                }
            }
        });

        var ctx3 = document.getElementById('evalYearCount').getContext('2d');
        window.myBar3 = new Chart(ctx3, {
            type: 'bar',
            data: evalYearData,
            options: {
                title: {
                    display: false,
                    text: '연도별 평가현황'
                },
                legend: {
                    position: 'bottom',
                    display: true,
                    labels: {
                        fontSize: 11,
                        boxWidth: 12
                    }
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        stacked: true,
                    }],
                    yAxes: [{
                        stacked: true
                    }]
                }
            }
        });
    };
</script>

<script>
    $(function () {
        calendarEvent();
        // day_select();

        if ($(".calendar_area").length) {
            $(".confirm").on('click', function () {
                var cur_year = $('.top_title .thisyear').text();
                var cur_month = $('.top_title .thismonth').text();
                if (cur_month.length < 2) {
                    cur_month = "0".concat(cur_month);
                }
                var getyear = $('.pop_contents .setyear').val();
                var getmonth = $('.pop_contents .setmonth').val();

                if (cur_year == getyear && cur_month == getmonth) {
                    ; //no change
                } else {
                    var forma = getyear + '-' + getmonth + '-01';
                    $('td.fc-today').removeClass("fc-today");
                    $('.month_select .thisyear').text(getyear);
                    $('.top_title .thisyear').text(getyear);
                    if (getmonth.charAt(0) == '0')
                        getmonth = getmonth.replace("0", "");
                    $('.month_select .thismonth').text(getmonth);
                    $('.top_title .thismonth').text(getmonth);
                    $('#calendar').fullCalendar('gotoDate', forma);
                    has_kor_holiday();
                    day_select();
                    height_checker();
                }
            });

        }
    });

    var y;
    var m;
    var d;

    // 월 출력
    function strMonth() {
        if (m == -1) {
            y--;
            m = 11
        }
        if (m == 12) {
            y++;
            m = 0
        }
        $("#strMonth").empty();
        $("#strMonth").text(y + '년 ' + (m + 1) + '월')
        day_select();
        $("#toDay").text(y + '년 ' + (m + 1) + '월 일정');
        getDaySchedule(y + '' + (m + 1));
    }

    // 다음월
    function nextM() {
        $('#calendar').fullCalendar('next')
        m++;
        strMonth();
    }

    // 이전월
    function prevM() {
        $('#calendar').fullCalendar('prev')
        m--;
        strMonth();
    }

    function day_select() {
        $(".fc-day-number").on('click', function () {
            // if (!$(this).parent().hasClass("__holiday") && !$(this).parent().hasClass("fc-sat") && !$(this).parent()
            //     .hasClass(
            //         "fc-sun") && !$(this).parent().hasClass("fc-today")) {
            //     var today_temp = $(this).parent().attr("data-date");
            //     $('td.fc-today').removeClass("fc-today");
            //     $(this).parent().addClass("fc-today");
            // }
        });

    }


    function day_envet(list){
        $(".fc-day-number").each(function () {
            var isSc = false;
            $(this).parent().removeClass("fc-today");
            var today_temp = $(this).parent().attr("data-date").substring(5,10)
            $.each(list, function(){
                console.log(today_temp + '|' + this.BBSDATE + ';')
                if ( today_temp == this.BBSDATE){
                    isSc = true;
                    console.log('일정있음')
                }
            })
            if(isSc)
                $(this).parent().addClass("fc-today");
        })

    }

    function getDaySchedule(date) {
        jQuery.ajax({
            url: "/bbs/daySchedule.do",
            type: "POST",
            data: {
                date: date
            },
            dataType: "json",
//		            contentType:"application/json; text/html; charset=utf-8",
            success: function (result) {
                console.log(result)
                var list = result.list
                if (list.length == 0) {
                    $("#scheduleList").empty();
                    $("#scheduleList").append('<li><label>' + '일정이 없습니다.' + '</label></li>')
                } else {
                    $("#scheduleList").empty();
                    $.each(list, function () {
                        console.log(this);
                        /* $("#scheduleList").append('<li style="display: inline-block; width: 100%"><label style="margin: 0px 10px; float:left;" >' + this.BBSDATE + '</label>' + '<div style="display: inline-block" class="title"><a id="sc' + this.BBSDATE + '" onClick="bbsView(\'' + this.BBSNO + '\', \'B04\')" title="' + this.BBSSUBJECT + '">' + this.BBSSUBJECT + '</a></li>') */
                        $("#daily_bbs_ul").append('<li class="needLabel"><label>' + this.BBSDATE + '</label><a style="cursor:pointer;" id="sc' + this.BBSDATE + '" onClick="bbsView(\'' + this.BBSNO + '\', \'B04\')" title="' + this.BBSSUBJECT + '">' + this.BBSSUBJECT + '</a><span></span></li>');
                        
                    });
                    day_envet(list);
                }
            }
            , error: function (request, status, error) {
                // alert("ERROR");
                // alert(request.responseText);
            }
        });

    }


    function calendarEvent(eventData) {
        $("#calendar").html("");
        var date = new Date();
        y = date.getFullYear();
        m = date.getMonth();
        d = date.getDate();
        // 일정 날짜 표시
        $("#toDay").text(y + '-' + (m + 1) + '-' + d);
        // 월 표시
        var calendar = $('#calendar').fullCalendar({
            selectable: true,
            contentHeight: "auto",
            header: {
                left: "",
                center: "",
                right: "",
                right: ""
            },
            handleWindowResize: false,
            allDayDefault: false,
            defaultView: "month",
            showNonCurrentDates: false,
            fixedWeekCount: false,
            editable: false,
            monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
            dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
            buttonText: {
                today: "오늘",
                month: "월별",
                week: "주별",
                day: "일별",
            },
            dayClick: function (date) {
                console.log('clicked ' + date.format());
            },
        });

        // calendar.fullCalendarclientEvents’)

        strMonth(y, m);
        has_kor_holiday();
    }

    function has_kor_holiday() {
        /* 임시 2018 휴일용 입니다 */
        var moment = $('#calendar').fullCalendar('getDate');
        moment = moment.format();
        var check_year = moment.slice(0, 4);
        var check_month = moment.slice(5, 7);

        var holidays = [];
        switch (check_month) {
            case '01':
                holidays = ['01'];
                break;
            case '03':
                holidays = ['01']
                break;
            case '05':
                holidays = ['05']
                break;
            case '06':
                holidays = ['06']
                break;
            case '08':
                holidays = ['15']
                break;
            case '10':
                holidays = ['03', '09']
                break;
            case '12':
                holidays = ['25']
                break;
        }

        var add_holidays = [];
        if (check_year == "2018") {
            switch (check_month) {
                case '02':
                    add_holidays = ['15', '16', '17']
                    break;
                case '05':
                    add_holidays = ['07', '22']
                    break;
                case '06':
                    add_holidays = ['13']
                    break;
                case '09':
                    add_holidays = ['23', '24', '25', '26']
                    break;
            }
        }

        if (holidays.length > 0 && add_holidays.length > 0)
            holidays = holidays.concat(add_holidays);
        else if (add_holidays.length > 0)
            holidays = add_holidays;

        if (holidays.length > 0) {
            $(".fc-content-skeleton td.fc-day-top").each(function () {
                for (var i = 0; i < holidays.length; i++) {
                    if ($(this).attr("data-date") == check_year + '-' + check_month + '-' + holidays[i]) {
                        $(this).addClass('__holiday');
                    }
                }
            });
        }


        // 유연근무 상태 확인용 임시코드 (나중에는 삭제할것)
        $(".fc-content-skeleton td.fc-day-top").each(function () {
            if ($(this).attr("data-date") == '2018-09-07') {
                $(this).children().addClass('__smart');
            }
            if ($(this).attr("data-date") == '2018-09-11') {
                $(this).children().addClass('__timing');
            }
            if ($(this).attr("data-date") == '2018-09-21') {
                $(this).children().addClass('__homebs');
            }
            if ($(this).attr("data-date") == '2018-09-27') {
                $(this).children().addClass('__timeselect');
            }
        });
    }
</script>
</body>
</html>