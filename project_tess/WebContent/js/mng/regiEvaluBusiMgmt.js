/**
*******************************************************************************
***    명칭: regiEvaluBusiMgmt.js
***    설명: [관리자] 평가사업관리 > 평가사업등록 화면
***
***    -----------------------------    Modified Log   ------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0      2023.11.01      LHB     First Coding.
*******************************************************************************
**/

$(document).ready(function() {
	loadBusiCate();
	loadBusiAddrCombo();
});

function validation() {
	console.log('validation()');
	// 사업명, 사업구분(사업유형), 위치, 총 사업기간, 사업개발주체, 계획수립일자, 사업 내용, 전체부지면적
	const requiredListValue = ["evaluBusiNm", "busiType", "busiCate", "busiAddr1", "busiAddr2"];
	const requiredListKey	= ["사업명", "사업유형", "사업유형", "시행주체", "시행주체"];
	
	const formValue = $("#model").serializeObject();
	for (let i=0 ; i<requiredListValue.length ; i++) {
		if (isEmpty(formValue[requiredListValue[i]])) {
			alert(requiredListKey[i] + ' 항목은 필수 입력 사항입니다.');
			$("#" + requiredListValue[i]).focus();
			return false;
		}
	}
	
	if (isNotEmpty(formValue['busiSttDate']) && !isDate(formValue['busiSttDate'].replaceAll("-", ""))) {
		alert('사업기간 형식이 잘못되었습니다.');
		$("#busiSttDate").focus();
		return false;
	} else if (isNotEmpty(formValue['busiEndDate']) && !isDate(formValue['busiEndDate'].replaceAll("-", ""))) {
		alert('사업기간 형식이 잘못되었습니다.');
		$("#busiEndDate").focus();
		return false;
	} else if (isNotEmpty(formValue['busiPlanDate']) && !isDate(formValue['busiPlanDate'].replaceAll("-", ""))) {
		alert('계획수립일자 형식이 잘못되었습니다.');
		$("#busiPlanDate").focus();
		return false;
	}
	
	if (confirm('사업을 등록하시겠습니까?')) {
		return true;
	} else {
		return false;
	}
}

// 지역 검색조건 combo loading
function loadBusiAddrCombo() {
	//시도 선택시 지자체(구군) 검색
	comutils.changeCityBjd({
		loading : true,
		citysido: "busiAddr1",
		cityauth: "busiAddr2",
		init    : function(){
			return;
		}
	});
}

function loadBusiCate() {
	$("#busiType").change(function() {
		const selectCode = $(this).val();
		
		// 사업유형 데이터 조회
	    bizutils.findCode({
	        params: {parentCode: selectCode},
	        fn: function (result) {
				let html = '<option value="">선택</option>';
				if (result != null && result.length > 1) {
					$.each(result, function () {
	                    var code = this.code
	                    var name = this.codeNm;
	                    html += ('<option value="' + code + '">' + name + '</option>');
	                });
					$("#busiCate").html(html);
				}
	        }
	    });
	});
}