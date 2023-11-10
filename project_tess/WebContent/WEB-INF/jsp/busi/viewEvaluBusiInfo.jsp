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
	<script type="text/javascript" src="/jquery/jstree/_lib/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="/jquery/jstree/_lib/jquery.cookie.js"></script>
	
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
    <form:hidden path="evaluStage" />
    <form:hidden path="evaluGubun" />
    
    <input type="hidden" name="userId" id="userId" value="<c:out value="${paramMap.gsUserId}"/>">

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

	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>평가사업조회</li>
	                    <li>${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</li>
	                    <li>${evaluInfo.PLANEVAL_BUSI_NAME}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</h3>
	                </div>
	            </div>
	
	            <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	                <div class="shade"></div>
	                <div class="project-title">
	                    <h2>${evaluInfo.PLANEVAL_BUSI_NAME}</h2>
	                    <p>${evaluInfo.busiAddress1} / ${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM}</p>
	                </div>
	                <div class="local-menu">
	                    <ul>
	                        <li class="active"><a title="사업정보">사업정보</a></li>
	                        <li class=""><a onclick="fn_goEvaluInfo();" title="평가정보">평가정보</a></li>
	                    </ul>
	                    <div class="back-list"><a href="/busi/listEvaluBusi.do" title="목록으로"><</a></div>
	                </div>
	            </div>
	
	            <div class="container b-section">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="body-head">
	                            <h4 class="page-title">사업정보</h4>
								<a href="javascript:void(0);" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"><span class="sr-only">인쇄하기</span></span></a>
	                        </div>
	                        <!-- Contents -->
		                    <p class="section-title">관광개발사업 개요<small>최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table">
	                        	<tr>
	                                <td class="labeler">코드명</td>
	                                <td colspan="3"><input type="text" name="planEvalBusiNo"  id="planEvalBusiNo"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.planEvalBusiNo}"/>'/></td>
	                            </tr>
	                            <tr>
	                            	<td class="labeler">사업유형</td>
	                                <td colspan="3"><input type="text" name="busiTypeNm"  id="busiTypeNm"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiTypeNm}"/>'/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업명</td>
	                                <td colspan="3"><input type="text" name="planEvalBusiName"  id="planEvalBusiName"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.planEvalBusiName}"/>'/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업목적</td>
	                                <td colspan="3"><input type="text" name="busiCateNm"  id="busiCateNm"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiCateNm}"/>'/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">위치</td>
	                                <td colspan="3">
		                                <input type="text" name="busiAddr12"  id="busiAddr12"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiAddr12}"/>'/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">주요시설</td>
	                                <td colspan="3">
		                                <input type="text" name="busiAddr5"  id="busiAddr5"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiAddr5}"/>'/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">총 사업기간</td>
	                                <td>
	                                	<input type="text" name="convBusiSttDate"  id="convBusiSttDate"  value='<c:out value="${mastMap.convBusiSttDate}"/>'/> ~ 
	                                	<input type="text" name="convBusiEndDate"  id="convBusiEndDate"  value='<c:out value="${mastMap.convBusiEndDate}"/>'/>
                                	</td>
                                	<td class="labeler">사업비</td>
	                                <td>
	                                	<input type="text" name="planBusiExps"  id="planBusiExps"  value='<c:out value="${mastMap.planBusiExps}"/>'/>
                                	</td>
	                            </tr>
	                        </table>
		                    
	
	                        <p class="section-title">첨부 파일<small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
							<caption class="sr-only">첨부파일</caption>
							<colgroup><col/><col/><col/></colgroup>
	                        <thead>
	                        	<tr>
	                                <th scope="col">구분</th>
	                                <th scope="col" class="fix-width file">첨부파일</th>
	                            </tr>
	                        </thead>
	                        
	                       <%--  DB 목록이 없어서 추후 작업 예정
	                        <tbody>
	                        	<c:forEach items="${fileList}" varStatus="status" var="flist">
	                        		<tr>
		                                <td><c:out value="${flist.CODE_NM}"/></td>
		                                <td class="fix-width file">
		                                    <a href="#" class="<c:out value="${flist.CODE_NM}"/>">
		                                    	<c:out value="${flist.FILE_ORG_NM}"/>
		                                    </a>
		                                </td>
		                                <td class="fix-width date"><c:out value="${flist.REGI_DATE}"/></td>
		                            </tr>
	                        	</c:forEach>
	                        </tbody>
	                         --%>
                            <tr>
                                <td>사업설명서 지침서</td>
                                <td class="fix-width file"><a href="#" class="보조금 교부신청서"><img src="../../../images/icon_file_hwp.jpg"></a></td>
                            </tr>
                            <tr>
                                <td>추가 첨부파일</td>
                                <td class="fix-width file"><a href="#" class="기본계획 수립용역 보고서"><img src="../../../images/icon_file_zip.jpg"></a></td>
                                <!-- <td class="fix-width date">2018-09-13 23:14:11</td> -->
                            </tr>
                            </table>
                            
                            <p class="section-title" style="display:flex; justify-content: space-between;">사업설명서 등록
							    <small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small>
							    <sapn class="submit-set" style="padding: 0px 0 0; margin-bottom:5px;">
							    	<button type="button" id="addRowBtn" class="evtdss-submit"><a id="addRow" title="저장하기">추가</a></button>
							    	<button type="button" id="removeRowBtn" class="evtdss-submit"><a id="removeRow" title="삭제">삭제</a></button>
							    </sapn>
							</p>
							<table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
							    <caption class="sr-only">사업설명서 등록</caption>
							    <thead>
							        <tr>
							            <th>구분</th>
							            <th class="fix-width file">파일 업로드</th>
							            <th class="fix-width file">첨부파일</th>
							        </tr>
							    </thead>
							    <tbody id="tableBody">
							        <tr>
							            <td><span class="special-dot">*</span>사업설명서(한글)</td>
							            <td><input type="file" class="regi-file-input" id="upFile1"></td>
							            <td class="fix-width file"><a href="#" class="사업설명서(한글)"><img src="../../../images/icon_file_hwp.jpg"></a></td>
							        </tr>
							        <tr>
							            <td><span class="special-dot">*</span>사업설명서(PDF)</td>
							            <td><input type="file" class="regi-file-input" id="upFile1"></td>
							            <td class="fix-width file"><a href="#" class="사업설명서(PDF)"><img src="../../../images/icon_file_pdf.jpg"></a></td>
							        </tr>
							        <tr>
		                                <td>기본계획서</td>
		                                <td><input type="file" class="regi-file-input" id="upFile1"></td>
		                                <td class="fix-width file"><a href="#" class="기본계획서"><img src="../../../images/icon_file_pdf.jpg"></a></td>
		                            </tr>
		                            <tr>
		                                <td>기타</td>
		                                <td><input type="file" class="regi-file-input" id="upFile1"></td>
		                                <td class="fix-width file"><a href="#" class="기타"><img src="../../../images/icon_file_hwp.jpg"></a></td>
		                            </tr>
							    </tbody>
							</table>
							
	                        <div class="submit-set">
	                        	<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="저장하기">저장하기</a></button>
	                        	</c:if>
	                        	<c:if test="${viewCommitStatus.OPINION_YN == 'Y' && viewCommitStatus.OPINION_APV_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
	                        	</c:if>
	                            <!-- 제출이력이 있을 경우 표시 -->
	                            <div class="evtdss-submit-date">이 문서는 <span class="txt-heightlight">2018-08-21 14:24:36 에 제출</span> 되었습니다.</div>
	                            <!-- /제출이력이 있을 경우 표시 -->
	                        </div>
                        <!-- /Contents -->
	                    </div>
	                </div>
	            </div> <!-- /.container -->
	
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