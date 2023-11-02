<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)404.jsp 1.0 2014/10/01                                             --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2014 CUBES CO., INC.                                     --%>
<%-- ALL RIGHTS RESERVED.                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html lang="ko">
<head>
<%@ include file ="../header.jsp" %>
<title><spring:message code="title.sysname"/></title>

</head>

<body>
<!-- header layout -->

	<center>
	
	<div style="margin-top:1px; width:968px; border:1px solid #cccccc; background:#f5f5f5; padding:50px 60px;">
		<div style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:22px; color:#000000; margin-bottom:40px;">403 Forbidden (접근 권한이 없습니다.)</div>
	</div>
	<center>
	
	<div style="height:15px;"></div>

	<div class="button_box">
	    <span><a href="javascript:history.go(-1);">이전페이지로 돌아가기</a></span>
	    </div>
	</div>

<!-- footer layout -->

</body>
</html>
