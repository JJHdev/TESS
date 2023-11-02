<%
 /****************************************************************************************
***	ID					: listSample.jsp
***	Title				: Template List Screen
***	Description			: Template List Page
***
***	-----------------------------    Modified Log   --------------------------------------
***	ver				date						author					description
***  -----------------------------------------------------------------------------------------
***	1.0			2014-06-16				ntarget					First Coding.
*****************************************************************************************/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>
<title><spring:message code="title.sysname"/></title>
<app:layout mode="stylescript" type="popup" /><!-- style & javascript layout -->

<body>
<!-- header layout -->
<app:layout mode="headerPopup" title="우편번호 검색"/>

<!-- ==================== 중앙내용 시작 ==================== -->
	<!--step_01-->
	<div style="display:none;">
		<div class="popup_explain_00">
			찾고자 하는 주소의 동(읍/면)명을 입력하신 후 검색을 누르세요.
		</div>
		<ul class="popup_explain_01">
			<li>예)서울시 강동구 둔촌2동 이라면, '둔촌2' 혹은 '둔촌2동'으로 입력해 주세요.</li>
		</ul>

		<div style="border-bottom:1px solid #e9e9e9; clear:both;height:1px; margin-bottom:10px;"></div>
		<form name="b_form" method="post" action="">
		<input type="hidden" name="" value="" />
			<div class="popup_contents_02">
				<div style="border-bottom:2px solid #343434;"></div>
				<table class="popup_table_01">
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
					<tr>
						<th style="border-bottom:1px solid #343434;">검색어</th>
						<td style="border-bottom:1px solid #343434;">
							<input type="text" id="" name="" class="input_M" value="대치동" style="width:40%;" title="검색어">
							<span class="middle_btn_01 middle_color_01"><a href="#void"><strong>검색</strong></a></span>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<!--//step_01-->

	<!--step_02-->
	<div style="display:block;">
		<div class="popup_explain_00">
			찾고자 하는 주소의 동(읍/면)명을 입력하신 후 검색을 누르세요.
		</div>
		<ul class="popup_explain_01">
			<li>예)서울시 강동구 둔촌2동 이라면, '둔촌2' 혹은 '둔촌2동'으로 입력해 주세요.</li>
		</ul>

		<div style="border-bottom:1px solid #e9e9e9; clear:both;height:1px; margin-bottom:10px;"></div>
		<form name="b_form" method="post" action="">
		<input type="hidden" name="" value="" />
			<div class="popup_contents_02">
				<div style="border-bottom:2px solid #343434;"></div>
				<table class="popup_table_01">
				<colgroup>
					<col width="">
					<col width="">
				</colgroup>
					<tr>
						<th style="border-bottom:1px solid #343434;">검색어</th>
						<td style="border-bottom:1px solid #343434;">
							<input type="text" id="" name="" class="input_M" value="대치동" style="width:40%;" title="텍스트">
							<span class="middle_btn_01 middle_color_01"><a href="#void"><strong>검색</strong></a></span>
						</td>
					</tr>
				</table>
				<div class="address_cell">
					<div class="fixed_table_wrap" style="height:230px;">
					<div class="th_bg"></div>
						<div class="fixed_table_in">
							<table class="fixed_table" cellspacing="0" width="98%">
								<colgroup>
									<col width="10%" />
									<col width="36%" />
									<col width="37%" />
									<col width="15%" />
								</colgroup>
								<thead>
									<tr>
										<th><div style="width:10%;">번호</div></th>
										<th><div style="width:36%;">도로명주소</div></th>
										<th><div style="width:37%;">지번</div></th>
										<th><div style="width:15%;">우편번호</div></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="text-align:center;">1</td>
										<td><a href="#">서울특별시 강남구 영동대로 411(대치동)</a></td>
										<td><a href="#">서울특별시 강남구 대치동 948-2 대치동 빌딩</a></td>
										<td style="text-align:center;">135-854</td>
									</tr>
									<tr>
										<td style="text-align:center;">2</td>
										<td><a href="#">서울특별시 강남구 영동대로 411(대치동)</a></td>
										<td><a href="#">서울특별시 강남구 대치동 948-2 대치동 빌딩</a></td>
										<td style="text-align:center;">135-854</td>
									</tr>
									<tr>
										<td style="text-align:center;">3</td>
										<td><a href="#">서울특별시 강남구 영동대로 411(대치동)</a></td>
										<td><a href="#">서울특별시 강남구 대치동 948-2 대치동 빌딩</a></td>
										<td style="text-align:center;">135-854</td>
									</tr>
									<tr>
										<td style="text-align:center;">4</td>
										<td><a href="#">서울특별시 강남구 영동대로 411(대치동)</a></td>
										<td><a href="#">서울특별시 강남구 대치동 948-2 대치동 빌딩</a></td>
										<td style="text-align:center;">135-854</td>
									</tr>
									<tr>
										<td style="text-align:center;">50000</td>
										<td><a href="#">서울특별시 강남구 영동대로 411(대치동)</a></td>
										<td><a href="#">서울특별시 강남구 대치동 948-2 대치동 빌딩</a></td>
										<td style="text-align:center;">135-854</td>
									</tr>
									<tr>
										<td style="text-align:center;">6</td>
										<td><a href="#">서울특별시 강남구 영동대로 411(대치동)</a></td>
										<td><a href="#">서울특별시 강남구 대치동 948-2 대치동 빌딩</a></td>
										<td style="text-align:center;">135-854</td>
									</tr>
								</tbody>
							</table>

							<script type="text/javascript">
							//셀 스타일 변경
							jQuery(document).ready(function(){
								jQuery(".fixed_table th:first div").css("border-left","none");
							});
							</script>
						</div>
					</div>
				</div>
			</div>
		</form>

		<div style="height:15px;"></div>


		<div style="position:relative;">
			<!-- 페이징 -->
			<div class="pagenum_01">
				<a href="#" class="prev_end"><span>처음</span></a>
				<a href="#" class="prev"><span>이전</span></a>
				<a href="#">1</a>
				<a href="#">2</a>
				<strong>3</strong>
				<a href="#">400</a>
				<a href="#">234000</a>
				<a href="#" class="next"><span>다음</span></a>
				<a href="#" class="next_end"><span>끝</span></a>
			</div>
			<!--//페이징 -->
		</div>

	</div>

<!-- ==================== 중앙내용 종료 ==================== -->

<!-- footer layout -->
<app:layout mode="footerPopup" />

</body>
</html>
