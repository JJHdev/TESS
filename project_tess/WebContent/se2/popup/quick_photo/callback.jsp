<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
    <title>FileUploader Callback</title>
</head>
<body>
    <script type="text/javascript">
    	// alert("callback");
		// document.domain 설정
		try { document.domain = "http://localhost:8080/"; } catch(e) {}
//	    try { document.domain = "http://125.140.104.65:8080/"; } catch(e) {}
		
        // execute callback script
        var sUrl = decodeURI(document.location.search.substr(1));
		if (sUrl != "blank") {
	        var oParameter = {}; // query array

	        sUrl.replace(/([^=]+)=([^&]*)(&|$)/g, function(){
	            oParameter[arguments[1]] = arguments[2];
	            return "";
	        });
	        
	        if ((oParameter.errstr || '').length) { // on error
	            (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_error'])(oParameter);
	        } else {
		        (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_success'])(oParameter);
		   }
		}
    </script>
</body>
</html>
 