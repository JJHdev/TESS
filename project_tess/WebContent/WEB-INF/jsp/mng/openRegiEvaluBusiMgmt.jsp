<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<html lang="ko">
<head>
    <%@ include file="../header.jsp" %>
    <title><spring:message code="title.sysname"/></title>
    <app:layout mode="stylescript" type="normal" /><!-- style & javascript layout -->
    <!-- tode공통 추가 js -->
    <script language="javascript" type="text/javascript" src='<c:url value="/js/common-dyUtil.js"/>'></script>
    <script language="javascript" type="text/javascript" src='<c:url value="/js/common-bizUtil.js"/>'></script>

    <%-- 슬라이드 처리 함수 --%>
    <%-- <script language="javascript"  type="text/javascript" src='<c:url value="/js/evalu/todeComm.js"/>'></script> --%>
</head>

<%-- 3칸으로 변경--%>
<style>
    .o-search.tab1 .o-search-col { left: 0%; }
    .o-search.tab2 .o-search-col { left: 33.5%; }
    .o-search.tab3 .o-search-col { left: 67.0%; width: 33% !important; border-right: 1px solid #444}

    .o-search-col{ width: 33.5%; }
</style>

<body id="top">
<div class="wrap">

    <!-- header layout -->
    <app:layout mode="header"/>

    <!-- ======================================================= -->
    <!-- ==================== 중앙내용 시작 ==================== -->
    <!-- ======================================================= -->
    
<form:form commandName="model" name="model" id="model">

    <div class="contents" style="padding:0px;">

            <%-- 공통 필수 --%>
            <input type="hidden" name="mode" id="mode"/>
            <input type="hidden" name="page" id="page" value='<c:out value="${paramMap.page }"/>'/>

            <%-- pk --%>
            <input type="hidden" name="evaluBusiNo" id="evaluBusiNo"/>
            <input type="hidden" name="evaluStage" id="evaluStage" value="${paramMap.evaluStage}"/>

            <%-- 검색조건 --%>
            <div id="srchCondArea">
                <input type="hidden" name="srchBusiAddr1" id="srchBusiAddr1"
                       value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
                <input type="hidden" name="srchBusiAddr2" id="srchBusiAddr2"
                       value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
                <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal"
                       value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
                <input type="hidden" name="srchBusiType" id="srchBusiType"
                       value='<c:out value="${paramMap.srchBusiType}"/>'/>
                <input type="hidden" name="srchBusiCate" id="srchBusiCate"
                       value='<c:out value="${paramMap.srchBusiCate}"/>'/>
                <input type="hidden" name="srchEvaluBusiNm" id="srchEvaluBusiNm"
                       value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
                <input type="hidden" name="srchEvaluDate" id="srchEvaluDate"
                       value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
                <input type="hidden" name="srchFinalEvaluFnd" id="srchFinalEvaluFnd"
                       value='<c:out value="${paramMap.srchFinalEvaluFnd}"/>'/>
            </div>

            <div class="contents-wrap">
                <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
                    <div class="container">
                        <div class="evtdss-breadcrumb">
                            <ul>
                                <li>홈</li>
                                <li>관리자</li>
                                <li>평가사업관리</li>
                            </ul>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h3 class="page-title">평가사업관리</h3>
                                <!-- Contents -->
                                <form>
                                    <div class="form-group search-form">
                                        <ul class="g-search">
                                            <li class="g-search-col w25"><input type="text" class="g-search-input-txt" title="사업코드 검색" placeholder="사업코드" id="search-busiCode"></li>
                                            <li class="g-search-col w75"><input type="text" class="g-search-input-txt"  title="사업정보 검색" placeholder="사업명" id="search-busiName"></li>
                                            <%--<li class="g-search-col w25"><input type="text" class="g-search-input-txt" title="지역명 검색" placeholder="지역명"></li>--%>
                                        </ul>
                                        <div class="g-search-btn">
                                            <a href="javascript:void(0);" onclick="search_btn(0)" title="검색시작">검색</a>
                                        </div>
                                    </div>
                                </form>

                                <div class="search-acd" id="searchItem" role="tablist" aria-multiselectable="true">
                                    <div class="o-search tab1 panel">
                                        <div class="o-search-col " role="tab" id="headingOne">
                                            <a onClick="$.searchSlider('headingOne')" class="collapsed" role="button"
                                               data-toggle="collapse" data-parent="#searchItem" href="#collapseThree"
                                               aria-expanded="false" aria-controls="collapseThree"
                                               title="평가연도/단계">연도</a>
                                        </div>
                                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel"
                                             aria-labelledby="headingOne">
                                            <ul class="i-search">
                                                <li class="i-search-col w50">
                                                    <%--TODO:: 시작연도--%>
                                                    <div class="i-search-result" id="i-search-sYear">
                                                    </div>
                                                <li class="i-search-col w50">
                                                    <%--TODO:: 종료연도--%>
                                                    <div class="i-search-result" id="i-search-eYear">
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="o-search tab2 panel">
                                        <div class="o-search-col" role="tab" id="headingTwo">
                                            <a onClick="$.searchSlider('headingTwo')" class="collapsed" role="button"
                                               data-toggle="collapse" data-parent="#searchItem" href="#collapseOne"
                                               aria-expanded="false" aria-controls="collapseOne" title="지역">지역</a>
                                        </div>
                                        <div id="collapseOne" class="panel-collapse collapse" role="tabpanel"
                                             aria-labelledby="headingTwo">
                                            <ul class="i-search">
                                                <li class="i-search-col w50" id="i-search-sido">
                                                </li>
                                                <li class="i-search-col w50" id="i-search-gungu">
                                                    <div class="i-search-item selected"><a title="전체">전체</a></div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="o-search tab3 panel">
                                        <div class="o-search-col " role="tab" id="headingThree">
                                            <a onClick="$.searchSlider('headingThree')" class="collapsed" role="button"
                                               data-toggle="collapse" data-parent="#searchItem" href="#collapseTwo"
                                               aria-expanded="false" aria-controls="collapseTwo" title="회계구분/사업유형">회계구분/사업유형</a>
                                        </div>
                                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel"
                                             aria-labelledby="headingThree">
                                            <ul class="i-search">
                                                <li class="i-search-col w50" id="i-search-busiType">
                                                    <div class="i-search-item active"><a title="전체"  onclick="selectBusiType(this, '', '전체')">전체</a></div>
                                                    <c:forEach items="${busiTypeComboList}" varStatus="idx" var="type">
                                                        <div class="i-search-item "><a title="전체" onclick="selectBusiType(this, '${type.code}', '${type.codeNm}' )">${type.codeNm}</a></div>
                                                    </c:forEach>
                                                </li>
                                                <li class="i-search-col w50">
                                                    <div class="i-search-result" id="i-search-busiCate">
                                                        <div class="i-search-item selected" id="projecttype0"><a href="javascript:void(0)" title="전체">전체</a></div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="search-words">
                                        <!-- <p>현재 지정된 검색 조건이 없습니다.</p> -->
                                        <p class="silent">현재 지정된 검색 조건이 없습니다.</p>
                                        <label>검색조건 :</label>
                                        <div class="searach-word" id="search_year">[연도]&nbsp;전체</div>
                                        <div class="searach-word" id="search_area">[지역]&nbsp;전체</div>
                                        <div class="searach-word" id="search_type">[유형]&nbsp;전체</div>
                                    </div>

                                </div>

                                <div class="grid-head">
                                    <div class="grid-count">총 <strong id="girdCnt">0</strong> 건</div>
                                    <button class="grid-print" data-grid-control="excel-export" title="엑셀저장">엑셀저장
                                    </button>
                                </div>
                                <div class="grid-wrap" data-ax5grid="project-grid" data-ax5grid-config="{}"></div>
                                <!-- /Contents -->

                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /contents-wrap -->
    </div>
</form:form>

    <!-- ======================================================= -->
    <!-- ==================== 중앙내용 종료 ==================== -->
    <!-- ======================================================= -->

    <!-- foot 부분 -->
    <!-- ==================== bottom footer layout ============= -->
    <app:layout mode="footer" type="main"/>
</div><!--/#wrap-->



</body>

</html>