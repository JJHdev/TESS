<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)accessDenied.jsp 1.0 2014/10/11                                    --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2006 CUBES CO., INC.                                     --%>
<%-- ALL RIGHTS RESERVED.                                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file ="../header.jsp" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- ACCESS DENIED ERROR 를 표시하는 화면이다.                              --%>
<%--                                                                        --%>
<%-- @author                                                                --%>
<%-- @version 1.0 2014/10/11                                               --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<html>
<head>
    <title>Access Denied Message</title>
    <!-- ==================== style & javascript layout ==================== -->
    <app:layout mode="stylescript" type="normal" />
</head>
<body>


<div class="sub_top_visual_wrap guide_visual_wrap">
    <div class="wid_box sub_visual_box01 error_visual">
        <div class="sub_top_page">
        <h2>Access Denied</h2>
        </div>
    </div>
</div>
<div class="wid_box sub_contents_wrap guide_sub_type">
    <div class="error_wrap">
        <div class="error_box">
            <p class="error_text">해당 화면에 접근할수있는 권한이 없습니다. 관리자에게 문의 바랍니다.</p>
        </div>
    </div>
<div class="button_box">
    <span class="button blue icon"><span class="back_icon"></span><a href="javascript:history.go(-1);">이전페이지로 돌아가기</a></span>
    </div>
</div>


</body>
</html>
