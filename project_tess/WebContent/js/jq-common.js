
/*
 * @(#)x-common.js 1.0 2014/06/10
 *
 * COPYRIGHT (C) 2014 CUBES CO., INC.
 * ALL RIGHTS RESERVED.
 */

/**
 * 공통 확장 스크립트이다.
 *
 * @author 이찬석
 * @version 1.0 2014/06/10
 */
////////////////////////////////////////////////////////////////////////////////
// jQuery 관련 공통 custom 코드 관리
////////////////////////////////////////////////////////////////////////////////

// 공통 변수
var _IS_TEST_CAST_ = false;

////////////////////////////////////////////////////////////////////////////////

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// select box 동적 구성 관련
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(function($) {
    $.fn.emptySelect = function() {
        return this.each(function() {
            if(this.tagName=='SELECT') this.options.length = 1;
        });
    };

    $.fn.loadSelect = function(optionsDataArray) {
        return this.emptySelect().each(function() {
            if(this.tagName=='SELECT') {
                var selectElement = this;
                $.each(optionsDataArray, function(idx, optionData) {
                    var option = new Option( optionData.codeNm, optionData.code);
                    if($.browser.msie){
                        selectElement.add(option);
                    }else{
                        selectElement.add(option,null);
                    }
                });
            }
        });
    };
})(jQuery);


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Validation 관련 내용
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// 입력 필수 검사.
function fn_checkRequired(chkObj,formNm) {
    return _fn_commValid(chkObj, "required", formNm);
}
// 날짜 검사.
function fn_checkDate(chkObj,formNm) {
    return _fn_commValid(chkObj, "date", formNm);
}

function fn_checkDateFmt(chkObj,formNm) {
    return _fn_commValid(chkObj, "dateFmt", formNm);
}
// email 검사.
function fn_checkEmail(chkObj,formNm) {
    return _fn_commValid(chkObj, "email", formNm);
}
function fn_checkAmount(chkObj,formNm) {
    return _fn_commValid(chkObj, "amount", formNm);
}

// 형식 검사
function fn_checkType(chkObj, formNm){
    return _fn_commValid(chkObj, "typeCheck", formNm);
}

function fn_checkUserId(chkObj, formNm) {
    return _fn_commValid(chkObj, "userId", formNm);
}

function fn_checkFileExt(chkObj, formNm) {
    return _fn_commValid(chkObj, "fileExt", formNm);
}


// 기본 검사 method
function _fn_commValid(chkObj, type, formName) {

    var rtnValue = true;

    if(formName == undefined || isEmpty(formName) == true ){
        formName = null;
    }

    var formTitleStr = chkObj.attr("title");
    var formNm       = chkObj.attr("name");
    var formValue    = chkObj.val();
    var addMsg = "";

    if(formName != null ){
        formTitleStr = formName;
    }

    // 입력 필수 검사.
    if(type == "required") {
        if(isEmpty(formValue) == true) {
            addMsg = MSG_COMM_2001;         //" 항목을 입력하세요.";
            if(chkObj.prop("tagName") == "SELECT") {
                addMsg = MSG_COMM_2002;     //" 항목을 선택하세요";
            }
        }
    }else if(type == "date" ){
        var convFormValue = formValue;
        // 10자리이면 "/"를 제거하고 검사
        if(formValue.length == 10){
            convFormValue = convFormValue.split("/").join("");
        }
        if(isDate(convFormValue) == false) {
            addMsg = MSG_COMM_2003;         //" 항목은 날짜 형식에 맞지 않습니다.";
        }
    }else if(type == "dateFmt" ){

        if(formValue.length == 0){

        }else if(formValue.length == 8){
            if(isDate(formValue) == false) {
                addMsg = MSG_COMM_2003;         //" 항목은 날짜 형식에 맞지 않습니다.";
            }
        }else if(formValue.length == 10){
            var value = formValue.substring(0,4) + formValue.substring(5,7) + formValue.substring(8,10);
            if(isDate(value) == false) {
                addMsg = MSG_COMM_2003;         //" 항목은 날짜 형식에 맞지 않습니다.";
            }
        }else{
            addMsg = MSG_COMM_2003;         //" 항목은 날짜 형식에 맞지 않습니다.";
        }

    }else if(type == "email" ){
        if(isEmail(formValue) == false) {
            addMsg = MSG_COMM_2004;         //" 항목은 Email 형식에 맞지 않습니다.";
        }
    }else if(type == "amount" ){
        if(isEmpty(formValue) == true) {
            // 값이 없으면 통과
        }else if (isFloat(formValue) == false) { // float형식 검사.
            addMsg = MSG_COMM_2010;         //" 항목은 양표시 형식에 맞지 않습니다.";
        }else{
            var floatVal = parseFloat(formValue);
            if(floatVal < 0){
                addMsg = MSG_COMM_2010;         //" 항목은 양표시 형식에 맞지 않습니다.";
            }
        }
    }else if(type == "fileExt" ){

        //-------------------------
        // 첨부파일 허용여부 : _ALLOWED_FILE_EXTS는 스크립트 파일에 global 변수로 정의해 놓으면 됨.
        //-------------------------
        if(isAtthAllowedFileType(formValue, _ALLOWED_FILE_EXTS) == false) {
            addMsg = MSG_COMM_2012;     //"첨부한 파일이 허용된 파일 유형이 아닙니다."
        }

    }else if(type == "typeCheck" ){
        var upperFormNm = formNm.toUpperCase();
        var upperTagNm = chkObj.prop("tagName");

        if(formValue != "" && trim(formValue).length > 0 ) {

            if(upperFormNm.indexOf("BUSIREGNNO") >= 0){
                var convFormValue = formValue.split("-").join("");  // replaceAll 효과 ("-" 모두제거)
                if(isBizRegNo(convFormValue) == false) {
                    addMsg = MSG_COMM_2005;     //" 항목은 사업자등록번호 형식에 맞지 않습니다.";
                    if(_IS_TEST_CAST_ == true){
                        // 2013.10.11 LCS : 테스트 진행을 위해 임시로 풀어 놓음
                        // _IS_TEST_CAST_ 이 true이면 사업자등록번호 check 하지 않음.
                        addMsg = "";
                        // 테스트 상황이면 전체 길이만 검사함.
                        if(convFormValue.length != 10) {
                            addMsg = MSG_COMM_2005;
                        }
                    }
                }
            }else if(upperFormNm.indexOf("USERID") >= 0){   // 사용자 아이디 검사.
                //var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9]{3,12}$/;
                //return (pattern.test(el.value)) ? true : _doError(el,"아이디는 4~12자의 영문, 숫자만 사용할 수 있으며\n첫글자는 반드시 영문이어야합니다.");
//                var pattern = /^[a-zA-Z0-9.]{4,20}$/;
                var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9.]{3,19}$/;
                if( pattern.test(formValue) == false){
                    addMsg = "아이디 형식에 맞지 않습니다.\n아이디는 4~20자리수로 숫자와 영문만사용할 수 있으며 첫글자는 반드시 영문이어야 합니다. ";
                }
            }else if(upperFormNm.indexOf("DATE") >= 0){
                var convFormValue = formValue;
                // 10자리이면 "/"를 제거하고 검사
                if(formValue.length == 10){
                    convFormValue = convFormValue.split("/").join("");
                }
                if(isDate(convFormValue) == false) {
                    addMsg = MSG_COMM_2006;     //" 항목은 날짜 형식에 맞지 않습니다.";
                }
            }else if(upperFormNm.indexOf("PASSWD") >= 0){
                if(isValidPassword(formValue) == false) {
                    addMsg = MSG_COMM_2007;     //" 항목은 비밀번호 조건에 맞지 않습니다.";
                }
            }else if(upperFormNm.indexOf("CELLPHONENO2") >= 0 || upperFormNm.indexOf("TELNO2") >= 0){
                if(isNumberOnly(formValue) == false || formValue.length < 3 ) {
                    addMsg = MSG_COMM_2008;     //" 항목은 3자리 또는 4자리 숫자만 입력하세요.";
                }
            }else if(upperFormNm.indexOf("CELLPHONENO3") >= 0 || upperFormNm.indexOf("TELNO3") >= 0){
                if(isNumberOnly(formValue) == false || formValue.length < 4 ) {
                    addMsg = MSG_COMM_2009;     //" 항목은 4자리 숫자만 입력하세요.";
                }
            }else if(upperFormNm.indexOf("GPSX") >= 0 || upperFormNm.indexOf("GPSY") >= 0){
                if (isFloat(formValue) == false ){
                    addMsg = MSG_COMM_2011;     //" 항목은 GPS 좌표 형식에 맞지 않습니다.";
                }
            }else if(upperFormNm.indexOf("UPFILE") >= 0){
                if(isAtthAllowedFileType(formValue, _ALLOWED_FILE_EXTS) == false) {
                    addMsg = MSG_COMM_2012;     //"첨부한 파일이 허용된 파일 유형이 아닙니다."
                    formTitleStr = "";
                }
            }

            // TEXTAREA 항목의 최대 길이 조건 확인.
            if(formValue != "" && "TEXTAREA" == upperTagNm) {
                var byteLen   = jsByteLength(formValue);
                var maxLength = 4000; 

                     if(upperFormNm.indexOf("RECTNOTE") >= 0){ maxLength = 800; }      // 반려사유
                else if(upperFormNm.indexOf("PERMCOND") >= 0){ maxLength = 1600; }      // 허가조건
                else if(upperFormNm.indexOf("CHGDETAIL") >= 0){ maxLength = 800; }     // 변경사항

                if(byteLen > maxLength) {
                    addMsg = " 항목이 최대 입력가능 길이("+maxLength+") 이상 입력됐습니다. 현재길이("+byteLen+")";
                }
            }
        }

    }

    // 메시지가 설정되었으면 오류임.
    if(addMsg != "" ) {
        msgAlert(formTitleStr + addMsg, chkObj);
//        chkObj.focus();
        rtnValue = false;
    }

    return rtnValue;
}

//파일 첨부에서 허용된 파일 형식인지 확인.
//fullFileNm : 전체 파일명
//allowedExtNms : 허용된 확장명 문자열 (ex : txt,xls,pdf)
function isAtthAllowedFileType(fullFileNm, allowedExtNms) {

    //-----------------------------
    // 제한된 확장명이 전달되지 않으면 무조건 허용.
    //-----------------------------
    if(allowedExtNms == undefined || allowedExtNms == null) {
        return true;
    }

    var allowedExtNmsTm = "|"+allowedExtNms.replace(new RegExp(",", 'g'), "|") + "|";
    allowedExtNmsTm = allowedExtNmsTm.toUpperCase().replace(/ /g,"");
    allowedExtNmsTm = allowedExtNmsTm.replace(/ /g,"");     // 중간의 모든 공백 제거

    var extNm = fullFileNm.substring( fullFileNm.toLowerCase().lastIndexOf(".") + 1 );
    var extNmTm = "|"+extNm.toUpperCase() +"|";

    if(allowedExtNmsTm.indexOf(extNmTm) >= 0){
        return true;
    }else{
        return false;
    }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 기타 관련 내용
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// ** 20141013 LCS 제거 : common-dyUtil.js 사용으로 변경
//
////~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
////특정 area 내의 화면 그룹을 복제해서 추가 관련
////~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
////해당 area의 내부의 맨 마지막에 특정 group를 생성 추가.
//function fn_AddDynamicGroupInArea(areaObj, dynamicNm, funcNm) {
//    try {
////        var divObj = $("#"+areaId);
////        var dynamicGroupObj = $("#"+areaId + ">._dynamicGroup:last-child");
//
//        var divObj = areaObj;
//        var dynamicGroupObj = divObj.find("."+dynamicNm+":last-child");
//
//        newGroupObj = dynamicGroupObj.clone(true);
//        newGroupObj.appendTo(divObj);
//
//        fn_ControlInit(newGroupObj, 0);
//
//        // 새로추가된 row에 대해서 입력받은 func 호출.
//        if(funcNm != undefined && funcNm != null && funcNm.length > 0) {
//            var funcObj = eval(funcNm);
//            // dynamicGroupObj : 새로 생성되기전 마지막 객체
//            // newGroupObj : 새로 생성된 객체
//            funcObj(dynamicGroupObj, newGroupObj);
//        }
//
//        return newGroupObj;
//    }catch (e) {
//        alert("fn_AddDynamicGroupInArea func - "+e.Message);
//    }
//}
//
////삭제 checkbox가 check된 대상만 삭제하는 func
//function fn_RemoveCheckDynamicGroup(areaObj, dynamicNm, chkNm, funcNm){
//    try {
//        //var divObj = $("#"+areaId);
////        var dynamicGroupObj = $("#"+areaId + ">._dynamicGroup");
//        var dynamicGroupObj = areaObj.find("."+dynamicNm);
//        var rtnObj = null;
//
//        dynamicGroupObj.each(function(){
//
//            if($(this).find("input:checkbox[name="+chkNm+"]").prop("checked") == true ){
////                var objCnt = $("#"+areaId + ">._dynamicGroup").length;
//                var objCnt = areaObj.find("."+dynamicNm).length;
//
//                // 새로추가된 row에 대해서 입력받은 func 호출. 삭제 처리 되기 전에 function 호출
//                if(funcNm != undefined && funcNm != null && funcNm.length > 0) {
//                    var funcObj = eval(funcNm);
//                    funcObj($(this));
//                }
//
//                if(objCnt > 1) {
//                    $(this).remove();
//                    rtnObj = null;
//                }else{
//                    fn_ControlInit($(this), 0);
//                    rtnObj = $(this);
//                }
//
//            }
//        });
//
//        // 삭제되었다면  null이, 삭제되지 않고 초기화만 되었다면 해당 areaObject가 리턴.
//        return rtnObj;
//    }catch (e) {
//        alert("fn_RemoveCheckDynamicGroup func - "+e.Message);
//    }
//}
//
////특정 row에 포함되어 있는 object의 값을 초기화 한다.
//function fn_ControlInit(jRowobj){
// try {
//     jRowobj.find(':input:text').val('');
//     jRowobj.find(':input:hidden').val('');
//     jRowobj.find('select').each(function () {
//         $(this).val("");
//     });
//     jRowobj.find(':input:radio').prop("checked", false);
//     jRowobj.find(':input:checkbox').prop("checked", false);
//     //맨 마지막 row를 삭제할 때 disabled된 상태가 유지되는 문제해결
//     jRowobj.find(":disabled").removeAttr("disabled");
//
// }catch (e) {
//     alert("fn_ControlInit func - "+e.Message);
// }
//}
//
//
////id값의 뒤 3자리를 이용해서 자동 증가 시킨다.
//function fn_idIncrease(idStr){
//  var rtnVal = idStr;
//  if(idStr != undefined && idStr != null && idStr.length > 3) {
//      var headStr = idStr.substring(0,idStr.length-3);
//      var idxStr  = idStr.substring(idStr.length-3, idStr.length);
//      var nextIdx = parseInt(idxStr, 10) + 1;
//
//      var nextIdxStr = nextIdx + "";
//      if(nextIdxStr.length == 1) {
//          rtnVal = headStr + '00' + nextIdxStr;
//      }else if(nextIdxStr.length == 2) {
//          rtnVal = headStr + '0' + nextIdxStr;
//      }else if(nextIdxStr.length == 3) {
//          rtnVal = headStr + nextIdxStr;
//
//      }
//  }
//  return rtnVal;
//}

///**
// * jQuery Calendar
// */
//$.datepicker.setDefaults({
//    buttonText: "Calendar"
//  , showOn: 'button' 						// 우측에 달력 icon 을 보인다.
//  , buttonImage: '/images/contents/calendar_btn_01.gif'  	// 우측 달력 icon 의 이미지 패스
//  , buttonImageOnly: true 					//  inputbox 뒤에 달력icon만 표시한다. ('...' 표시생략)
//  , changeMonth: true 						// 월선택 select box 표시 (기본은 false)
//  , changeYear: true  						// 년선택 selectbox 표시 (기본은 false)
//  , showButtonPanel: true 					// 하단 today, done  버튼기능 추가 표시 (기본은 false)
//  //, showOtherMonths: true
//  //, selectOtherMonths: true
//  //, monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월']
//  ,dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
//  //,showMonthAfterYear:true,
//  , monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
//
//  , currentText: '오늘'    //button:Today
//  , closeText: '닫기'    //button:Close
//});

//$(document).ready(function() {
//	$("#calendar1-1").datepicker({ // inputbox 의 id 가 startDate 이겠죠.
//		dateFormat : 'yy-mm-dd'
//	});
//	$("#calendar1-2").datepicker({ // inputbox 의 id 가 startDate 이겠죠.
//		dateFormat : 'yy-mm-dd'
//	});
//});
$(function() {
	$(".date-picker").datepicker({
	 	dateFormat: 'yy-mm-dd',
	    changeMonth: true,
	    changeYear: true,
		dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	 	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	 	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	 	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	 });
	 $(".date-picker").on("change", function () {
	    var id = $(this).attr("id");
	    var val = $("label[for='" + id + "']").text();
	    $("#msg").text(val + " changed");
	});
	/*
	$(".date-picker-month").datepicker({
	 	dateFormat: 'yy-mm',
		minViewMode: 'months',
	    changeMonth: true,
	    changeYear: true,
		dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	 	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	 	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	 	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	 });
	 $(".date-picker-month").on("change", function () {
	    var id = $(this).attr("id");
	    var val = $("label[for='" + id + "']").text();
	    $("#msg").text(val + " changed");
	});*/
	
	$(".date-picker-month").datepicker({
	    format: 'yyyy-mm-dd',
		dateFormat: 'yy-mm',
	    autoclose: true,
	    minViewMode: 'months',
	    templates: {
	       leftArrow: '<i class="icon-angle-left"></i>',
	       rightArrow:'<i class="icon-angle-right"></i>',
	    },
	    language: 'ko',
		dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	 	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	 	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	 	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		currentText: '오늘',
		closeText: '닫기',
		changeMonth: true, 
    	changeYear: true,  
		showButtonPanel: true, 
		showMonthAfterYear: true,
		beforeShow: function(dateText) {
			var value = dateText.value;
			var year = value.split('-')[0];
			var month = value.split('-')[1];
			 $(this).datepicker("option", "defaultDate", new Date(year, month-1, 1));
			$(this).datepicker("setDate", new Date(year, month-1, 1));
		},
	});
}); 


var suffix	= '<span style="color:red; font-size:1.4em;">*</span>';


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 공통 message 관련 함수.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/**
 *  메시지(string)에 argument부분을 변환 처리하는 function
 * argument는 중괄호와 0부터 시작하는 순차번호로 표시  ex) {0}, {1} ...
 *
 * @param msgTemp
 * @param arguArray
 * @returns
 */
//function convertMessageArgument(msgTemp, arguArray) {
function convertMsgArgs(msgTemp, arguArray) {
//    function messageAttr(msgTemp, arguArray) {
    var rtnMsg = msgTemp;
    for(var i=0;i<arguArray.length;i++) {
        rtnMsg = rtnMsg.replace("{"+ i +"}", arguArray[i]);
    }
    return rtnMsg;
}

/**
 * 메시지 출력과 닫기후 포커스 할 대상만 설정할 수 있는 msg box
 * @param message
 * @param focusObj
 */
function msgAlert(message, focusObj) {
    if(isEmpty(message) == false) {
        // 20141008 LCS 수정 : layer alert창으로 변경
        //alert(message);
        nAlert(message, null, function(){
            if(focusObj)
                focusObj.focus();
        });
    }
}

// alert
function nAlert(message, title, callback) {
    if( title == null ) title = '정보';
    jAlert(message, title, callback);
}

// confirm
function nConfirm(message, title, callback) {
    if( title == null ) title = '확인';
    jConfirm(message, title, callback) ;
}

// prompt
function nPrompt(message, value, title, callback) {
    if( title == null ) title = 'Prompt';
    jPrompt(message, value, title, callback) ;
}



