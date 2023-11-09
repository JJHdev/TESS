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
		    <input type="hidden" name="docuType" id="docuType" value="">
		    <input type="hidden" name="atthType" id="atthType" value="">
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
			                        <li class=""><a onclick="goBusiInfo();" title="사업정보">사업정보</a></li>
			                        <li class="active"><a title="평가정보">평가정보</a></li>
			                    </ul>
			                    <div class="back-list"><a href="/busi/listEvaluBusi.do" title="목록으로"><</a></div>
			                </div>
			            </div>
	
						<!------------------------------------------------------------------->
						<!------------------------------------------------------------------->
						<!----------------------------- 평가위원 ------------------------------->
						<!------------------------------------------------------------------->
						<!------------------------------------------------------------------->
						
			
		<!------------------------------------------------------------------->
		<!------------------------------------------------------------------->
		<!------------------------------ 관리자 ------------------------------->
		<!------------------------------------------------------------------->
		<!------------------------------------------------------------------->
					<div class="container b-section">
	                	<div class="row">
	                    	<div class="col-md-12">
		                        <div class="body-head">
		                            <h4 class="page-title">평가정보</h4>
		                            <a href="#" class="body-print" title="인쇄하기"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></a>
		                        </div>
	                        	<div class="tab-wrap">
		                            <ul class="tab-steps">
		                                <li class="active"><a onclick="goStep(1);" title="서면검토">서면검토</a></li>
		                                <li class=""><a onclick="goStep(2);" title="평가의견">평가의견</a></li>
		                                <li class=""><a onclick="goStep(3);" title="종합결과">종합결과</a></li>
		                                <li class=""><a onclick="goStep(5);" title="이행계획서">이행계획서</a></li>
		                                <li class=""><a onclick="goStep(4);" title="평가종료">평가종료</a></li>
		                            </ul>
		                        </div>
		                        
		                        <p class="section-title">연구원분들이 추후 입력 값 전달 예정<small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
		                        <table class="evtdss-form-table" >
		                            <tr>
		                                <td class="labeler">사업명</td>
		                                <td><input type="text" name="planEvalBusiName"  id="planEvalBusiName"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.planEvalBusiName}"/>'/></td>
		                                <td class="labeler">사업지유형</td>
		                                <td><c:out value="${mastMap.busiFigureType}"/></td>
		                                <td class="labeler">사업유형</td>
		                                <td><input type="text" name="busiCateNm"  id="busiCateNm"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiCateNm}"/>'/></td>
		                            </tr>
		                            <tr>
		                                <td class="labeler">위치</td>
		                                <td colspan="3">
			                                <input type="text" name="busiAddr12"  id="busiAddr12"  style="width: -webkit-fill-available;"value='<c:out value="${mastMap.busiAddr12}"/>'/>
		                                </td>
		                            </tr>
	                            </table>
	                        		
                        		<p class="section-title">사업설명서<small class="silent">최종 개정내용은 사업계획서를 참조하시기 바랍니다.</small></p>
			                        <table class="evtdss-form-table" summary="지자체에서 등록한 사업정보 첨부파일 목록입니다.">
									<caption class="sr-only">사업설명서 등록</caption>
		                             <tr>
		                                <th>구분</th>
		                                <th class="fix-width file">첨부파일</th>
		                                <th class="fix-width date">등록일시</th>
		                            </tr>
		                            <tr>
		                                <td><span class="special-dot">*</span>사업설명서</td>
		                                <td class="fix-width file"><a href="#" class="사업설명서"><img src="../../../images/icon_file_hwp.jpg"></a></td>
		                                <td class="fix-width date">2018-09-13 23:14:11</td>
		                            </tr>
		                            <tr>
		                                <td>기본계획서</td>
		                                <td class="fix-width file"><a href="#" class="기본계획서"><img src="../../../images/icon_file_pdf.jpg"></a></td>
		                                <td class="fix-width date">2018-09-13 23:14:11</td>
		                            </tr>
		                            <tr>
		                                <td>기타</td>
		                                <td class="fix-width file"><a href="#" class="기타"><img src="../../../images/icon_file_hwp.jpg"></a></td>
		                                <td class="fix-width date">2018-09-13 23:14:11</td>
		                            </tr>
		                        </table>
                        		
								<p class="section-title">참조파일<small class="silent">아래 첨부파일을 다운로드하여 참고하세요</small></p>
                        		<table class="evtdss-form-table noMargin">
		                            <tr>
		                                <th>구분</th>
		                                <th class="fix-width file">첨부파일</th>
		                                <th class="fix-width date">등록일시</th>
		                            </tr>
		                            <tr>
		                                <td>서면검토서 샘플</td>
		                                <c:if test="${evaluDocB == null}">
		                                	<td class="fix-width file">
			                                    <a title="서면검토서 샘플"></a>
			                                </td>
			                                <td class="fix-width date"></td>
		                                </c:if>
		                                <c:if test="${evaluDocB != null}">
		                                	<td class="fix-width file">
			                                    <a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocB.EVALU_FILE_NO}" title="서면검토서 샘플"><img src="../../../images/icon_file_hwp.jpg"></a>
			                                </td>
			                                <td class="fix-width date">${evaluDocB.REGI_DATE}</td>
		                                </c:if>
		                            </tr>
		                            <tr>
		                                <td>${evaluInfo.EVALU_GUBUN} ${evaluInfo.EVALU_STAGE_NM} 평가지침서</td>
		                                <c:if test="${evaluDocA == null}">
		                                	<td class="fix-width file">
			                                    <a title="평가지침서 샘플"></a>
			                                </td>
			                                <td class="fix-width date"></td>
		                                </c:if>
		                                <c:if test="${evaluDocA != null}">
		                                	<td class="fix-width file">
			                                    <a href="/evalu/evaluFileDownload.do?EvaluFileNo=${evaluDocA.EVALU_FILE_NO}" title="평가지침서 샘플"><img src="../../../images/icon_file_hwp.jpg"></a>
			                                </td>
			                                <td class="fix-width date">${evaluDocA.REGI_DATE}</td>
		                                </c:if>
		                            </tr>
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
				</div> <!-- /contents-wrap -->
			</div><!-- /contents -->
		</div>
	</form:form>
</div>



		                        		
<!-- <div class="body-descriptions">
파일명에 <strong>이름 및 소속 등의 개인정보는 반드시 삭제 후 <span class="txt-heightlight">한글(.hwp)</span>파일로 업로드</strong>하여 주시기 바랍니다.<br>
<br>
아래의 <strong><span class="txt-heightlight">제출</span> 버튼을 클릭</strong> 하면 작성한 <strong><span class="txt-heightlight">서면검토서</span>가 제출</strong>되며 관리자가 승인하기 전에는 제출취소를 통해 철회할 수 있습니다.<br>
내용이 정확한지 최종적으로 확인하신 후 진행하시기 바랍니다.<br>
</div> -->
	
<!-- ======================================================= -->
<!-- ==================== 중앙내용 종료 ==================== -->
<!-- ======================================================= -->
<!-- foot 부분 -->
<!-- ==================== bottom footer layout ============= -->
<app:layout mode="footer" />
</div><!--/#wrap-->
</body>
</html>