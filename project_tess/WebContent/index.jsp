<%@ page language="java" pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html lang="ko">
<head>
<title>Intro</title>

<script language="JavaScript">
	//if (top.document.location.hostname == "www.") {
	//	top.document.location.href = "http://" + top.document.location.host + "/main.do";
	//}
	//else {
	//	top.document.location.href = "/main.do";
	//}
	// 2023.11.01 LHB DEV / PRD 환경 분기 처리
	const domain = window.location.href; 
	if (domain.indexOf('localhost')>-1 || domain.indexOf('210.113.102.196')>-1) {
		top.document.location.href = "http://" + top.document.location.host + "/main.do";	
	} else {
		top.document.location.href = "https://" + top.document.location.host + "/main.do";
	}
</script>
</head>
</html>
