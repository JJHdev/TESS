<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="en">
<head>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <input type="hidden" name="srchBusiAddr1"   id="srchBusiAddr1"   	value='<c:out value="${paramMap.srchBusiAddr1}"/>'/>
        <input type="hidden" name="srchBusiAddr2"   id="srchBusiAddr2"   	value='<c:out value="${paramMap.srchBusiAddr2}"/>'/>
        <input type="hidden" name="srchBusiAddrVal" id="srchBusiAddrVal" 	value='<c:out value="${paramMap.srchBusiAddrVal }"/>'/>
        <input type="hidden" name="srchBusiType"    id="srchBusiType"    	value='<c:out value="${paramMap.srchBusiType}"/>'/>
        <input type="hidden" name="srchBusiCate"    id="srchBusiCate"    	value='<c:out value="${paramMap.srchBusiCate}"/>'/>
        <input type="hidden" name="srchEvaluBusiNm"  id="srchEvaluBusiNm"   value='<c:out value="${paramMap.srchEvaluBusiNm}"/>'/>
        <input type="hidden" name="srchBusiStage"  id="srchBusiStage"  		value='<c:out value="${paramMap.srchBusiStage}"/>'/>
        <input type="hidden" name="srchEvaluDate"  id="srchEvaluDate"  		value='<c:out value="${paramMap.srchEvaluDate}"/>'/>
    </div>
    <div id="fileContentArea">
    	<c:forEach var="entry1" items="${evaluInfo}">
		    <input type="hidden" name="${entry1.key}" value="${entry1.value}" />
		</c:forEach>
		<c:forEach var="entry2" items="${mastMap}">
		    <input type="hidden" name="${entry2.key}" value="${entry2.value}" />
		</c:forEach>
    </div>
    
    <input type="hidden" name="regiEvaluCommId"     id="regiEvaluCommId"/>
</form:form>

	<div class="contents-wrap">
	    <div class="wrapper sub"> <!-- 메인페이지 : 'main', 서브페이지 : 'sub' 클래스 추가 -->
	        <div class="container">
	            <div class="evtdss-breadcrumb">
	                <ul>
	                    <li>홈</li>
	                    <li>평가사업조회</li>
	                    <li>${evaluInfo.prgrGubunNmHist} ${evaluInfo.evaluStageNmHist}</li>
	                    <li>${mastMap.evaluBusiNmInfo}</li>
	                </ul>
	            </div>
	            <div class="row">
	                <div class="col-md-12">
	                    <h3 class="page-title">${evaluInfo.prgrGubunNmHist} ${evaluInfo.evaluStageNmHist}</h3>
	                </div>
	            </div>
	
	            <div class="project-header" style="background-image:url(/img/storage/project-theme.jpg)">
	                <div class="shade"></div>
	                <div class="project-title">
	                    <h2>${mastMap.evaluBusiNmInfo}</h2>
	                    <p>${evaluInfo.busiAddr1NmHist} / ${evaluInfo.prgrGubunNmHist} ${evaluInfo.evaluStageNmHist}</p>
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
	                                <td colspan="3"><input type="text" name="evaluHistNoHist"  id="evaluHistNoHist" readonly="readonly" style="width: -webkit-fill-available;"value='<c:out value="${evaluInfo.evaluHistNoHist}"/>'/></td>
	                            </tr>
	                            <tr>
	                            	<td class="labeler">사업유형</td>
	                                <td colspan="3"><input type="text" name="busiCateNmInfo"  id="busiCateNmInfo"  readonly="readonly"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiTypeLevel1NmInfo}"/> > <c:if test="${mastMap.busiTypeLevel2NmInfo ne null and mastMap.busiTypeLevel1NmInfo != ''}"> <c:out value="${mastMap.busiTypeLevel2NmInfo}" /> > </c:if> <c:out value="${mastMap.busiCateNmInfo}"/> '/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업명</td>
	                                <td colspan="3"><input type="text" name="evaluBusiNmInfo"  id="evaluBusiNmInfo"  readonly="readonly" style="width: -webkit-fill-available;"value='<c:out value="${mastMap.evaluBusiNmInfo}"/>'/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업목적</td>
	                                <td colspan="3"><input type="text" name="updtBusiNoteHist"  id="updtBusiNoteHist"  style="width: -webkit-fill-available;"value='<c:out value="${evaluInfo.busiNoteHist}"/>'/></td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">위치</td>
	                                <td colspan="3">
                                    	<select id="updtBusiAddr1Hist"  name="updtBusiAddr1Hist"  class="input-sm wd-20p" data-value="<c:out value='${evaluInfo.busiAddr1Hist}'/>"><option value="">선택</option></select>
                                    	<select id="updtBusiAddr2Hist"  name="updtBusiAddr1Hist"  class="input-sm wd-20p" data-value="<c:out value='${evaluInfo.busiAddr2Hist}'/>"><option value="000">본청</option></select>
                                    	<input type="text" name="updtBusiAddr3Hist"  id="updtBusiAddr3Hist"  style="width: -webkit-fill-available;"value='<c:out value="${evaluInfo.busiAddr3Hist}"/>'/>
                                    </td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">주요시설</td>
	                                <td colspan="3">
		                                <input type="text" name="updtMainFcltHist"  id="updtMainFcltHist"  style="width: -webkit-fill-available;"value='<c:out value="${evaluInfo.mainFcltHist}"/>'/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td class="labeler">사업기간</td>
	                                <td colspan="3">
		                                <input type="month" name="updtBusiSttDateHist" id="updtBusiSttDateHist" style="width: auto;" value='<c:out value="${evaluInfo.busiSttDateHist}"/>'/>~
										<input type="month" name="updtBusiEndDateHist" id="updtBusiEndDateHist" style="width: auto;" value='<c:out value="${evaluInfo.busiEndDateHist}"/>'/>
                                 	</td>
	                            </tr>
	                            <tr>
                                	<td class="labeler">사업비</td>
	                                <td colspan="3">
	                                	<input type="text" name="totalBusiExpsHist"  	id="totalBusiExpsHist"  value='<c:out value="${evaluInfo.totalBusiExpsHist}"/>'/> 백만원 <br/>
	                                	<input type="text" name="updtTotBusiExps1Hist"   id="updtTotBusiExps1Hist"   value='<c:out value="${evaluInfo.totBusiExps1Hist}"/>'/> (국비) 백만원 	<br/>
	                                	<input type="text" name="updtTotBusiExps2Hist"   id="updtTotBusiExps2Hist"   value='<c:out value="${evaluInfo.totBusiExps2Hist}"/>'/> (지방비)백만원	<br/>
	                                	<input type="text" name="updtTotBusiExps3Hist"   id="updtTotBusiExps3Hist"   value='<c:out value="${evaluInfo.totBusiExps3Hist}"/>'/> (민자) 백만원	<br/>
                                	</td>
	                            </tr>
	                        </table>
	                        
	                        <div class="submit-set">
	                        	<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit"><a id="prcBtnSave" title="개요등록">개요 등록</a></button>
	                        	</c:if>
	                        	<c:if test="${viewCommitStatus.OPINION_YN == 'Y' && viewCommitStatus.OPINION_APV_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit-cancel"><a id="prcBtnCancle" title="제출취소">제출취소</a></button>
	                        	</c:if>
	                            <!-- 제출이력이 있을 경우 표시 -->
	                        </div>
							
	                        <p class="section-title">첨부 파일<small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
	                        <table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
								<caption class="sr-only">첨부파일</caption>
								<colgroup><col/><col/><col/></colgroup>
		                        <thead>
		                        	<tr>
		                                <th scope="col" style="width:70%;">구분</th>
		                                <th scope="col" style="width:30%;" class="fix-width file">첨부파일</th>
		                            </tr>
		                        </thead>
		                        
		                        <c:forEach items="${sysRrencFileList}" varStatus="status" var="flist">
								    <c:if test="${fn:substring(flist.CODE, 3, 4) eq '0' or  fn:substring(flist.CODE, 3, 4) eq '1'}">
								        <tr>
								            <td><c:out value="${flist.addColNm2} ${flist.CODE_NM}"/></td>
								            <td class="fix-width file">
								                <a href="<c:out value='/comm/fileDownloadSample.do?fileNo=${flist.CODE}'/>">
								                    <c:out value="${flist.CODE_NM}"/>
								                </a>
								            </td>
								        </tr>
								    </c:if>
								</c:forEach>
                           	</table>
                           	
                            <p class="section-title" style="display:flex; justify-content: space-between;">사업설명서 등록
							    <small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small>
							    <!-- <sapn class="submit-set" style="padding: 0px 0 0; margin-bottom:5px;">
							    	<button type="button" id="addRowBtn" class="evtdss-submit"><a id="addRow" title="파일추가">추가</a></button>
							    	<button type="button" id="removeRowBtn" class="evtdss-submit"><a id="removeRow" title="파일삭제">삭제</a></button>
							    </sapn> -->
							</p>
							<table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
						    	<caption class="sr-only">사업설명서 등록</caption>
							    <thead>
							        <tr>
							            <th>구분</th>
							            <th class="fix-width file">파일 업로드</th>
							            <th class="fix-width file">첨부파일</th>
							            <th class="fix-width file">첨부파일 삭제</th>
							        </tr>
							    </thead>
							    <tbody id="tableBody">
							        <c:forEach items="${sysUldFileList}" var="fileType">
							            <c:if test="${fileType.CODE eq 'AT01' or fileType.CODE eq 'AT02' or fileType.CODE eq 'AT03' or fileType.CODE eq 'AT04' or fileType.CODE eq 'AT05'}">
							                <tr>
							                    <td>
							                    	<c:if test="${fileType.CODE eq 'AT01' or fileType.CODE eq 'AT02'}" >
									                    <span class="special-dot">*</span>
							                    	</c:if>
								                    ${fileType.CODE_NM}
								                </td>
							                    <td>
							                        <c:set var="fileExists" value="false"/>
							                        <c:forEach var="fileInfo" items="${upFileList}">
							                            <c:if test="${fileInfo.atthType eq fileType.CODE}">
							                                <c:set var="fileExists" value="true"/>
							                            </c:if>
							                        </c:forEach>
							                        <c:if test="${!fileExists}">
							                            <input type="file" class="regi-file-input" id="upfile${fileType.CODE}">
							                        </c:if>
							                    </td>
							                    <td class="fix-width file">
							                        <c:forEach var="fileInfo" items="${upFileList}">
							                            <c:if test="${fileInfo.atthType eq fileType.CODE}">
							                                <a href="/busi/fileDownload.do?rootNo=${evaluInfo.evaluHistSnHist}&atthType=${fileType.CODE}">
							                                    <c:out value="${fileInfo.fileOrgNm}"/>
							                                </a>
							                            </c:if>
							                        </c:forEach>
							                    </td>
							                    <td>
							                        <c:if test="${fileExists}">
							                            <div class="submit-set">
							                                <button type="button" class="evtdss-submit" onclick="onClickButton('upfile${fileType.CODE}')" ><a title="파일삭제">삭제</a></button>
							                            </div>
							                        </c:if>
							                    </td>
							                </tr>
							            </c:if>
							        </c:forEach>
							   	 </tbody>
							</table>
	                        <div class="submit-set">
	                        	<c:if test="${viewCommitStatus.OPINION_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit" onclick="onClickButton('prcBtnFileSave')" title="사업설명서등록"><a title="사업설명서 등록">사업설명서 등록</a></button>
	                        	</c:if>
	                        	<c:if test="${viewCommitStatus.OPINION_YN == 'Y' && viewCommitStatus.OPINION_APV_YN != 'Y'}">
	                        		<button type="button" class="evtdss-submit-cancel" onclick="onClickButton('prcBtnCancle')" title="제출취소"><a title="제출취소 등록">제출취소</a></button>
	                        	</c:if>
	                            <!-- 제출이력이 있을 경우 표시 -->
	                        </div>
                       <!-- /Contents -->
	                   </div>
	               </div>
	           </div> <!-- /.container -->
	        </div>
	    </div>
	</div> <!-- /contents-wrap -->
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