<%@ page language="java" pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="javascript"  type="text/javascript" src="/js/common.js"></script>		<!-- Common Script -->


<%

out.println("Remote IP(request.getRemoteAddr()) = "+request.getRemoteAddr());

%>
<br>
<br>

메인 페이지

#. [관리자]코드관리 : <a href="/sys/code/listCodeMgmt.do">go</a>
<br>
#. [관리자]코드관리(Tree형태) : <a href="/sys/code/listCodeTreeMgmt.do">go</a>
<br>
#. [관리자]롤관리 : <a href="/sys/role/listRoleMgmt.do">go</a>
<br>
#. [관리자]프로그램관리 : <a href="/sys/prog/listProgMgmt.do">go</a>
<br>
#. [관리자]메뉴관리 : <a href="/sys/menu/listMenuMgmt.do">go</a>
<br>
#. [관리자]롤별 프로그램관리 : <a href="/sys/role/listRoleByProgMgmt.do">go</a>
<br>
#. [관리자]롤별 메뉴관리 : <a href="/sys/role/listRoleByMenuMgmt.do">go</a>
<br/>
<br/>
#. [공통]로그인 : <a href="/login.do">go</a>
<br>
#. [알림방]공지사항 : <a href="/bbs/listBbsNotice.do">go</a>
<br/>

	 