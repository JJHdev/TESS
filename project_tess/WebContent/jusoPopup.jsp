<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소 검색</title>
<%
	//request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	String inputYn       = request.getParameter("inputYn");
	String roadFullAddr  = request.getParameter("roadFullAddr");
	String roadAddrPart1 = request.getParameter("roadAddrPart1");
	String roadAddrPart2 = request.getParameter("roadAddrPart2");
	String engAddr       = request.getParameter("engAddr");
	String jibunAddr     = request.getParameter("jibunAddr");
	String zipNo         = request.getParameter("zipNo");
	String addrDetail    = request.getParameter("addrDetail");
	String admCd         = request.getParameter("admCd");
	String rnMgtSn       = request.getParameter("rnMgtSn");
	String bdMgtSn       = request.getParameter("bdMgtSn");
%>
</head>
<script language="javascript">
function init(){

	var url = location.href;
	var confmKey = ""; // 인증키

	//-----------------------------
	// * 인증기 설정 부분
	//-----------------------------
    // LCS 로컬 서버일 때
    /*
	if(top.document.location.hostname == "125.140.104.227"){
	    confmKey = "bnVsbDIwMTQxMjEwMDk0NDUy";
	}
	*/
	if(top.document.location.hostname == "localhost"){
	    confmKey = "U01TX0FVVEgyMDE2MDMwNDA5MDE1ODA=";
	}
	// 개발서버일 때
	else if(top.document.location.hostname == "125.7.243.212"){
	    confmKey = "U01TX0FVVEgyMDE1MTIwMjE3NTk0MjA=";
	}else if(top.document.location.hostname == "125.140.104.224"){
	    confmKey = "bnVsbDIwMTQxMjExMTQyMjQ4";
	}
	// TODO [LCS-addr] : 실서버일 때 인증키 입력해야 함.
	else if(top.document.location.hostname == "tdss.kr"){
		confmKey = "U01TX0FVVEgyMDE1MDMzMTE1MzYyMw=="
	}
	
	// 테스트 인증키
	 //confmKey = "TESTJUSOGOKR";
	 
	// 화면 구분
	var inputYn= "<%=inputYn%>";

	//-----------------------------
	// 처리
	//-----------------------------
	if(inputYn != "Y"){

	    if(confmKey == ""){
	        alert("인증키가 입력되지 않았습니다.");
	        self.close();
	    }
	    else {
    		document.form.confmKey.value = confmKey;
    		document.form.returnUrl.value = url;
    		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
    		//document.form.action="http://10.182.60.22/addrlink/addrLinkUrl.do"; //내부행망
    		document.form.submit();
	    }
	}else{
	    var addrInfo = {
	            roadFullAddr  : "<%=roadFullAddr%>",   // 도로명주소 전체(포멧)
	            roadAddrPart1 : "<%=roadAddrPart1%>",  // 도로명주소
	            roadAddrPart2 : "<%=roadAddrPart2%>",  // 참고주소
	            addrDetail    : "<%=addrDetail%>",     // 고객입력 상세주소
	            engAddr       : "<%=engAddr%>",        // 영문 도로명주소
	            jibunAddr     : "<%=jibunAddr%>",      // 지번 주소
	            zipNo         : "<%=zipNo%>",          // 우편번호
	            admCd         : "<%=admCd%>",          // 행정구역코드
	            rnMgtSn       : "<%=rnMgtSn%>",        // 도로명코드
	            bdMgtSn       : "<%=bdMgtSn%>"         // 건물관리번호
	    };

	    // opener에 아래 이름의 함수를 구현해야 함.
	    if(opener) {
			window.opener.jusoCallBack(addrInfo) ;
	    }
		window.close();
	}
}


</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey"   name="confmKey"   value=""/>
		<input type="hidden" id="returnUrl"  name="returnUrl"  value=""/>
	</form>
</body>
</html>