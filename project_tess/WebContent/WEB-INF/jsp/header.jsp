<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="app" %>
<%@ taglib uri="/WEB-INF/tld/f.tld" prefix="f"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page import="java.util.*" %>
<%@ page import="common.util.CommUtils" %>
<%@ page import="common.util.properties.ApplicationProperty"%>

<%
// ì ì¥ì²ë¦¬ ê²°ê³¼ ë©ìì§
String PROC_FLAG 	= (String)request.getSession().getAttribute(ApplicationProperty.get("SESS.PROCFLAG"));
PROC_FLAG 			= CommUtils.nvlTrim(PROC_FLAG);
request.getSession().removeAttribute(ApplicationProperty.get("SESS.PROCFLAG"));

String loginPage	= ApplicationProperty.get("LOGIN.PAGE");


// ì¸ì¦ìì¬ì©ì¬ë¶
String certUse = CommUtils.nvlTrim(ApplicationProperty.get("cert.use"), "true");


//ì¸ì¦ìë°ë¡ê·¸ì¸ Return ì²ë¦¬
Map returnMap 	= (HashMap)request.getSession().getAttribute("CERT_RETURN");
request.getSession().removeAttribute("CERT_RETURN");

String returnFlag		= "";

if (returnMap != null && returnMap.size() > 0) {
	returnFlag 		= CommUtils.nvlTrim((String)returnMap.get("returnFlag"));
}
%>

<meta charset="utf-8">
<meta name="language" content="Korean">
<meta http-equiv="content-language" content="ko">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="title" content="<spring:message code="title.sysname"/>">
<meta name="author" content="<spring:message code="title.sysname"/>">
<meta name="keywords" content="<spring:message code="title.sysname"/>">
<meta name="description" content="<spring:message code="title.sysname"/>">
<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">

<!--  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta name="viewport" content="width=1000">
<meta name="title" content="<spring:message code="title.sysname"/>">
<meta name="author" content="<spring:message code="title.sysname"/>">
<meta name="keywords" content="<spring:message code="title.sysname"/>">
<meta name="description" content="<spring:message code="title.sysname"/>">
<meta http-equiv="imagetoolbar" content="no">
-->


<script type="text/javascript">
	var PROC_FLAG = "<%=PROC_FLAG%>";
	var ROOT_PATH = "${pageContext.request.contextPath}";
	if (PROC_FLAG != "" && PROC_FLAG != null && PROC_FLAG != "null")  {
		console.log('header :: ' + PROC_FLAG);
		//alert(PROC_FLAG);
	}
</script>