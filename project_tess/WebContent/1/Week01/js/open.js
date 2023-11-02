<!--
//2011년 방송대 멀티미디어강의 980*670 사이즈 런치 스크립트 김상엽(813)
//
function launchClose() {
	window.opener = this;
	window.close();
}

function GetOpenParam(t) {
	t = parseInt(t, 10);
	if (t > 0)
		return '?startat=' + t;
	else
		return '';
}

function GetWinWidth( x ) {
	var objData = new ActiveXObject("Msxml.DOMDocument");
	if (objData != null)
	{
		objData.async = false;
		objData.load('js/open.xml');
		if (objData.readyState == 4 && objData.parseError == 0)
		{
			var query = "/settings/play_info/size/win_size_x";
			var objX = objData.selectSingleNode(query);
			if (objX)
				x = objX.text;
		}
		objData = null;
	}
	return x;
}

function GetWinHeight( y ) {
	var objData = new ActiveXObject("Msxml.DOMDocument");
	if (objData != null)
	{
		objData.async = false;
		objData.load('js/open.xml');
		if (objData.readyState == 4 && objData.parseError == 0)
		{
			var query = "/settings/play_info/size/win_size_y";
			var objY = objData.selectSingleNode(query);
			if (objY)
				y = objY.text;
		}
		objData = null;
	}
	return y;
}

-->