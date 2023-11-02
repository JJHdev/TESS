$(document).ready(function() {
	var roleId 		= $("input[name=gsRoleId]").val();
	var seq 		= $("input[name=seq]").val();

	/*
	if (roleId != ROLE_ID_ADMIN || seq == '') {
		$("span[id=btn_delt]").hide();
	}
	*/
});

// File Download
function download(fileNo) {
	document.location.href = ROOT_PATH +"/comm/fileDownload.do?fileNo="+fileNo;
}


// Button Action
function onClickButton(mode) {
	var form = $("#form1");

	switch(mode.toUpperCase()) {
		case "REGI":
			if ($("#seq").val() != '') {
				form.prop("action", ROOT_PATH+"/temp/updtSample.do");
			} else {
				form.prop("action", ROOT_PATH+"/temp/regiSample.do");
			}

			if ($("#title").val() == '') {
				alert('제목을 입력하세요.');
				return;
			}

			form.submit();
			break;
		case "LIST":
			document.location.href = ROOT_PATH +"/temp/listSample.do";
			break;

		case "DELT":
			if (!confirm(MSG_COMM_C002)) 	{
				return;
			}

			form.prop("action", ROOT_PATH+"/temp/deltSample.do");
			form.submit();
			break;
	}
}