/**
*******************************************************************************
***    명칭: listEvaluEnvFile.js
***    설명: [관리자] 평가환경설정 > 참조파일관리 화면 스크립트
***
***    -----------------------------    Modified Log   ------------------------
***    버전        수정일자        수정자        내용
*** ---------------------------------------------------------------------------
***    1.0      2023.11.17      LHB     First Coding.
*******************************************************************************
**/

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

function loadInitPage() {}

$(document).ready(function() {});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var LIST_URL      	= ROOT_PATH+"/mng/listEvaluEnvSampleFile.do";
var REGI_URL 	   	= ROOT_PATH+"/mng/regiEvaluEnvStage.do";
var UPDT_URL		= ROOT_PATH+"/mng/updtEvaluEnvStage.do";
var DELT_URL		= ROOT_PATH+"/mng/deltEvaluEnvStage.do";

var DOWN_URL		= ROOT_PATH+"/comm/fileDownloadSample.do";
var UPLD_URL		= ROOT_PATH+"/mng/saveEvaluEnvSampleFile.do";


////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
	$("#evaluStage").change(getSampleFileList);
	$("#evaluStage").change();
});

function getSampleFileList() {
	const evaluStage = $("#evaluStage").val();
	
	$.ajax({
		url: LIST_URL,
        type: "POST",
        data: {
			evaluStage: evaluStage,
		},
        dataType:"json", 
        success: function(result) {
			const data = result.data;
			console.log(data);
			
			// 파일 목록 만드는 부분
			const gubun = $("#evaluStage option").index($("#evaluStage option:selected"));
			
			let tbodyHtml	= '';
			tbodyHtml		+= '<tr>';
			tbodyHtml		+= '<td class="align-center">지자체</td>';
			
			// 사업설명서 샘플
			const ft01		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'01'; });
			tbodyHtml		+= '<td class="align-center">사업설명서</td>';
			tbodyHtml		+= '<td><input type="file" accept=".pdf, .hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft01.length > 0 ? ft01[0].code : 'FT'+gubun+'01') + '" rel="' + (ft01.length > 0 ? 'Y' : 'N') + '">' + (ft01.length > 0 ? ft01[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			
			// 사업설명서 양식
			const ft02		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'02'; });
			tbodyHtml		+= '<td><input type="file" accept=".hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft02.length > 0 ? ft02[0].code : 'FT'+gubun+'02') + '" rel="' + (ft02.length > 0 ? 'Y' : 'N') + '">' + (ft02.length > 0 ? ft02[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			
			tbodyHtml		+= '</tr>';
			tbodyHtml		+= '<tr><td class="align-center" rowspan="3">평가위원</td>';
			
			// 서면검토서 샘플
			const ft31		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'31'; });
			tbodyHtml		+= '<td class="align-center">서면검토서</td>';
			tbodyHtml		+= '<td><input type="file" accept=".pdf, .hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft31.length > 0 ? ft31[0].code : 'FT'+gubun+'31') + '" rel="' + (ft31.length > 0 ? 'Y' : 'N') + '">' + (ft31.length > 0 ? ft31[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			
			// 서면검토서 양식
			const ft32		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'32'; });
			tbodyHtml		+= '<td><input type="file" accept=".hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft32.length > 0 ? ft32[0].code : 'FT'+gubun+'32') + '" rel="' + (ft32.length > 0 ? 'Y' : 'N') + '">' + (ft32.length > 0 ? ft32[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			tbodyHtml		+= '</tr>';
			
			// 평가지침서 샘플
			const ft41		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'41'; });
			tbodyHtml		+= '<tr>';
			tbodyHtml		+= '<td class="align-center">평가지침서</td>';
			tbodyHtml		+= '<td><input type="file" accept=".pdf, .hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft41.length > 0 ? ft41[0].code : 'FT'+gubun+'41') + '" rel="' + (ft41.length > 0 ? 'Y' : 'N') + '">' + (ft41.length > 0 ? ft41[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			
			// 평가지침서 양식
			const ft42		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'42'; });
			tbodyHtml		+= '<td><input type="file" accept=".hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft42.length > 0 ? ft42[0].code : 'FT'+gubun+'42') + '" rel="' + (ft42.length > 0 ? 'Y' : 'N') + '">' + (ft42.length > 0 ? ft42[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			tbodyHtml		+= '</tr>';
			
			// 평가의견서 샘플
			const ft51		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'51'; });
			tbodyHtml		+= '<tr>';
			tbodyHtml		+= '<td class="align-center">평가의견서</td>';
			tbodyHtml		+= '<td><input type="file" accept=".pdf, .hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft51.length > 0 ? ft51[0].code : 'FT'+gubun+'51') + '" rel="' + (ft51.length > 0 ? 'Y' : 'N') + '">' + (ft51.length > 0 ? ft51[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			
			// 평가의견서 양식
			const ft52		= data.filter(function(e, i) { return e.code === 'FT'+gubun+'52'; });
			tbodyHtml		+= '<td><input type="file" accept=".hwp" name="upload" class="regi-file-input" />';
			tbodyHtml		+= ('<div class="regi-file" data-value="' + (ft52.length > 0 ? ft52[0].code : 'FT'+gubun+'52') + '" rel="' + (ft52.length > 0 ? 'Y' : 'N') + '">' + (ft52.length > 0 ? ft52[0].addCol4 : '등록파일 없음') + '</div>');
			tbodyHtml		+= '<div class="incell-btn button-set hor">';
			tbodyHtml		+= '<button type="button" class="inline-button green"><a onclick="saveDoc(this);" title="선택파일 추가">저장</a></button>';
			tbodyHtml		+= '</div></td>';
			tbodyHtml		+= '</tr>';
			
			$("table.sample-file-table tbody").html(tbodyHtml);
			$("table.sample-file-table tbody .regi-file[rel='Y']").click(function() {
				comutils.fileSampleDownload({fileNo : $(this).data('value')});
			});
        }
	});
}

// 참조파일 저장
function saveDoc(element) {
	const code		= $(element).closest('td').find('div.regi-file').data('value');
	const fileInput	= $(element).closest('td').find('input[type=file]');
	
	if ($(fileInput)[0].files[0].size > fileMaxSize) {
		nAlert("파일 용량은 50MB를 넘을 수 없습니다.");
		return false;
	} 
	console.log(code, fileInput);
	
	console.log()
	
	nConfirm("저장하시겠습니까?", null, function(isConfirm) {
		if(isConfirm) {
			const newForm = $('<form id="fileUpload"></form>');
			newForm.append(fileInput);
			newForm.append('<input name="code" value="' + code + '"/>');
			newForm.appendTo('body');
			console.log(newForm);
			
			BIZComm.submit({
				url: UPLD_URL,
				isFile: true,
				formId: 'fileUpload',
				ajaxSuccessFn: function (formObj, data) {
					console.log(formObj, data);
				}
			});
		}
	});
}