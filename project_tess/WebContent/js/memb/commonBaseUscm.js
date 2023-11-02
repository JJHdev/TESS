/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @(#) commonBaseUscm.js 1.0 2013/11/06
    기본정보 등록/수정 화면에서 공통으로 사용할 스크립트 모음

    @author LCS
    @version 1.0 2013/11/06
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// 공통 loading
function fn_uscm_load( args ){
    //-------------------
    // 화면 loading 관련
    //-------------------

    // 휴대폰(전화) 번호를 자리수 구분해서 화면의 각 항목에 mapping 함.
    fn_uscm_loadCellphoneNos();
    fn_uscm_loadTelNos();

    //이메일주로를 구분해서 화면의 각 항목에 mapping 함.
    fn_uscm_loadEmails();

    // 처음 화면이 열렸을 때 domain과 연결되지 않은 우편번호 항목들 mapping
    fn_uscm_loadPostNoForms();

    //2014.10.10 처음 화면이 열렸을 때 사용자 구분에 따라 화면 변경
    fn_uscm_loadDisplayChg(args);

    //2013.12.04 지자체 선택추가
    fn_uscm_initCityauth( args );

}

// 공통 event 설정 함수
function fn_uscm_setEvent() {

//    //전자인증서관리 페이지 이동 버튼 이벤트
//    $("#infoPermTab, #cfrmBtn").click(function(){
//        doAction($(this));
//    });

    // 휴대폰 번호 입력 이벤트 연결
    $("#cellphoneNo1,#cellphoneNo2,#cellphoneNo3").change(function(){
        fn_uscm_setFullCellphoneNo();
    });

    // 전화번호 입력 이벤트 연결
    $("#telNo1,#telNo2,#telNo3").change(function(){
        fn_uscm_setFullTelNo();
    });

    // 이메일 입력 이벤트 연결.
    $("#email1,#email2").change(function(){
        fn_uscm_setFullDomain();
    });
    // 이메일 도메인 combo 이벤트
    $("#email3").change(function(){
        fn_uscm_setEmailDomain($(this));
        fn_uscm_setFullDomain();
    });

    // 우편번호 popup 버튼 클릭 이벤트
    $("#postPopBtn").click(function(){
//    	openDaumPostcode();
    	//우편번호 검색방법 변경으로 인한 메소드 변경	2014-12-11 SYM
        openFindJuso();  // common.js

    });

//    // 비밀번호 변경 popup 호출
//    $("#modPwBtn").click(function(){
//        openModifyPasswd();
//    });

}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//action 로직
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


//ID 중복 검사	--사용
function fn_checkUserIdDuplAjax(){

    var params = null;
    var userIdObj = $("#userId");
    var userIdChkYnObj = $("#userIdDuplChkYn");
    var userIdChkObj = $("#userIdCheck");

    // 사용자 id를 입력했는지 확인.
    if(fn_checkRequired(userIdObj) == false) {
        return;
    }
    //사용자 아이디 정합성 검사.
    if(fn_checkType(userIdObj) == false) {
        return;
    }

    params = {userId:userIdObj.val()};

    $.ajax({
        url : ROOT_PATH + "/memb/getMembCheckIdDupl.do",
        data : params,
        dataType : "json",
        contentType : "application/json; text/html; charset=utf-8",
        success : function(result) {

            var duplCnt = result.duplCnt;

            if(duplCnt == 0) {
                // 사용 가능한 상태.
//                msgAlert(userIdObj.val() + "는 사용 가능한 아이디입니다.");
                msgAlert(convertMsgArgs(MSG_MEMB_A001,[userIdObj.val()]));
                userIdChkYnObj.val("Y");
                userIdChkObj.val(userIdObj.val());
            }else if(duplCnt > 0) {
                // 이미 등록된 상태.
//                msgAlert(userIdObj.val() + "는 사용하실 수 없는 아이디입니다.\n다른 아이디를 입력하시고 중복 확인 해주시기 바랍니다.");
                msgAlert(convertMsgArgs(MSG_MEMB_A002,[userIdObj.val()]));
                userIdChkYnObj.val("");
                userIdObj.val("");
            }
        },
        error : function(request, status, error) {
            // msg : "아이디 검사중 오류가 발생했습니다."
            msgAlert(MSG_MEMB_A003);
        }
    });
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//화면 처리 관련 및 이벤트
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//화면 처음 loading시 휴대폰 번호를 자리수 구분해서 화면의 각 항목에 mapping 함.
function fn_uscm_loadCellphoneNos(){
    var phoneNo1Obj = $("#cellphoneNo1");
    var phoneNo2Obj = $("#cellphoneNo2");
    var phoneNo3Obj = $("#cellphoneNo3");
    var phoneNoObj  = $("#cellphoneNo");

    var phoneNoVal  = phoneNoObj.val();

    if(isEmpty(phoneNoVal) == false) {
        if(phoneNoVal.length == 12){
            phoneNo1Obj.val(phoneNoVal.substring(0,3));
            phoneNo2Obj.val(phoneNoVal.substring(4,7));
            phoneNo3Obj.val(phoneNoVal.substring(8,12));
        }else if(phoneNoVal.length == 13){
            phoneNo1Obj.val(phoneNoVal.substring(0,3));
            phoneNo2Obj.val(phoneNoVal.substring(4,8));
            phoneNo3Obj.val(phoneNoVal.substring(9,13));
        }
    }
}

//화면 처음 loading시 전화번호를 자리수 구분해서 화면의 각 항목에 mapping 함.
function fn_uscm_loadTelNos(){
    var telNo1Obj = $("#telNo1");
    var telNo2Obj = $("#telNo2");
    var telNo3Obj = $("#telNo3");
    var telNoObj  = $("#telNo");

    var telNoVal  = telNoObj.val();

    if(isEmpty(telNoVal) == false) {

        if(telNoVal.indexOf('02') == 0) {
            if(telNoVal.length == 11){
                telNo1Obj.val(telNoVal.substring(0,2));
                telNo2Obj.val(telNoVal.substring(3,6));
                telNo3Obj.val(telNoVal.substring(7,11));
            }else if(telNoVal.length == 12){
                telNo1Obj.val(telNoVal.substring(0,2));
                telNo2Obj.val(telNoVal.substring(3,7));
                telNo3Obj.val(telNoVal.substring(8,12));
            }
        }else if(telNoVal.indexOf('0303') == 0 || telNoVal.indexOf('0505') == 0 ){
            if(telNoVal.length == 13){
                telNo1Obj.val(telNoVal.substring(0,4));
                telNo2Obj.val(telNoVal.substring(5,8));
                telNo3Obj.val(telNoVal.substring(9,13));
            }else if(telNoVal.length == 14){
                telNo1Obj.val(telNoVal.substring(0,4));
                telNo2Obj.val(telNoVal.substring(5,9));
                telNo3Obj.val(telNoVal.substring(10,14));
            }
        }else{
            if(telNoVal.length == 12){
                telNo1Obj.val(telNoVal.substring(0,3));
                telNo2Obj.val(telNoVal.substring(4,7));
                telNo3Obj.val(telNoVal.substring(8,12));
            }else if(telNoVal.length == 13){
                telNo1Obj.val(telNoVal.substring(0,3));
                telNo2Obj.val(telNoVal.substring(4,8));
                telNo3Obj.val(telNoVal.substring(9,13));
            }
        }
    }
}

//화면 처음 loading시 이메일주소를 구분해서 화면의 각 항목에 mapping 함.
function fn_uscm_loadEmails() {
    var emailObj = $("#email");

    if(emailObj.size() > 0) {

        var emailVal = $("#email").val();
        var emailArr = emailVal.split("@");

        var email1Obj = $("#email1");
        var email2Obj = $("#email2");
        var email3Obj = $("#email3");

        if(emailArr.length == 2) {
            email1Obj.val(emailArr[0]);
            email2Obj.val(emailArr[1]);

            email3Obj.find("option").each(function(){
                var tagObj = $(this);
                if(tagObj.text() == emailArr[1]){
                    tagObj.prop("selected", true);

                    // 도메인 입력항목을  readOnly 로 설정.
                    email2Obj.prop("readOnly", true);

                    return false;
                }
            });
        }

    }
}

//휴대포 번호 설정.
function fn_uscm_setFullCellphoneNo() {
    var phoneNo1Val = $("#cellphoneNo1").val();
    var phoneNo1Va2 = $("#cellphoneNo2").val();
    var phoneNo1Va3 = $("#cellphoneNo3").val();

    $("#cellphoneNo").val(phoneNo1Val+"-"+phoneNo1Va2+"-"+phoneNo1Va3);
}

// json 객체를 받아 휴대폰의 모든 객체에 적용함.
function fn_uscm_setAllCellphoneNoForms(args){

    var phoneNo1Val = args.cellphoneNo1;
    var phoneNo1Va2 = args.cellphoneNo2;
    var phoneNo1Va3 = args.cellphoneNo3;

    $("#cellphoneNo1").val(phoneNo1Val);
    $("#cellphoneNo2").val(phoneNo1Va2);
    $("#cellphoneNo3").val(phoneNo1Va3);

    $("#cellphoneNo").val(phoneNo1Val+"-"+phoneNo1Va2+"-"+phoneNo1Va3);
}

//전화 번호 설정.
function fn_uscm_setFullTelNo() {
    var telVal = $("#telNo1").val();
    var telVa2 = $("#telNo2").val();
    var telVa3 = $("#telNo3").val();

    $("#telNo").val(telVal+"-"+telVa2+"-"+telVa3);
}

//이메일 설정.
function fn_uscm_setFullDomain() {

    var email1Val = $("#email1").val();
    var email2Val = $("#email2").val();

    $("#email").val(email1Val + "@" + email2Val);
}

//이메일 도메인 값 설정 func
function fn_uscm_setEmailDomain(dmSelObj) {
    var email2Obj = $("#email2");

    if(isEmpty(dmSelObj.val()) == true) {
        email2Obj.prop("readOnly", false);
        email2Obj.val("");
        email2Obj.removeClass("read_only_int");
    }else{
        email2Obj.prop("readOnly", true);
        email2Obj.val(dmSelObj.find("option:selected").text());
        email2Obj.addClass("read_only_int");
    }
}

//처음 화면이 열렸을 때 domain과 연결되지 않은 우편번호 항목들 mapping
//우편번호체계 변경으로 인한 수정
function fn_uscm_loadPostNoForms() {

    var postNo1Obj  = $("#roadPostNo1");
//    var postNo2Obj  = $("#roadPostNo2");

    // 우편번호 load
    var zipCodeVal  = $("#roadPostNo").val();
    if(isEmpty(zipCodeVal) == false){

          postNo1Obj.val(zipCodeVal);
//        var zipCodeArry = zipCodeVal.split("-");
//        if(zipCodeArry.length == 2){
//            postNo2Obj.val(zipCodeArry[1]);
//        }
    }
}

/////////////////////////////////////////////////////////
//우편번호 검색 관련 샘플
/////////////////////////////////////////////////////////

function openDaumPostcode() {

 var args = {
         oncomplete: function(data) {

             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
             // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
        	 fn_uscm_setAddressForms(data);

             /*
        	 $('#roadPostNo1'   ).val(data.postcode1     );
        	 $('#roadPostNo2'   ).val(data.postcode2     );
        	 $('#roadAddress1'   ).val(data.address      );
             $('#addrType').val(data.addressType   );
             $('#addr'    ).val(data.address1       );
             $('#addr2'   ).val(data.address2      );
             $('#engAddr' ).val(data.addressEnglish);
             $('#relAddr' ).val(data.relatedAddress);
             */

             //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
             //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
             //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
             //document.getElementById('addr').value = addr;

             $('#roadAddr5'  ).focus();

         }
     };

 // DAUM 우편번호 팝업 열기.
 (new daum.Postcode(args)).open();

}

//우편번호 검색 팝업에서 주소 설정을 위해 호출하는 함수.
function fn_uscm_setAddressForms(data){

    var addressVal    = data.address;
//    var oldAddressVal = data.oldAddress;

    var roadPostNo1Obj  = $("#roadPostNo1");
    var roadPostNo2Obj  = $("#roadPostNo2");
    var roadPostNoObj   = $("#roadPostNo");
    var roadAddress1Obj = $("#roadAddress1");
    var roadAddr1Obj    = $("#roadAddr1");
    var roadAddr2Obj    = $("#roadAddr2");
    var roadAddr3Obj    = $("#roadAddr3");
    var roadAddr4Obj    = $("#roadAddr4");
    var roadAddr5Obj    = $("#roadAddr5");
//    var address1Obj     = $("#address1");
//    var addr1Obj        = $("#addr1");
//    var addr2Obj        = $("#addr2");
//    var addr3Obj        = $("#addr3");
//    var addr4Obj        = $("#addr4");
//    var addr5Obj        = $("#addr5");

    //-------------------------------
    // 우편번호 적용.
    //-------------------------------
    roadPostNo1Obj.val(data.postcode1);
    roadPostNo2Obj.val(data.postcode2);
    roadPostNoObj.val(trim(data.postcode1)+"-"+trim(data.postcode2));

    //-------------------------------
    // 주소 설정
    //-------------------------------

    var convAddrData    = bizutils.getParseAddressData(addressVal);
//    var convOldAddrData = bizutils.getParseAddressData(oldAddressVal);

    // 도로명 주소 설정
    roadAddress1Obj.val(convAddrData.addr1 + " " + convAddrData.addr2 + " " + convAddrData.addr3 + " " + convAddrData.addr4);
    roadAddr1Obj.val(convAddrData.addr1);
    roadAddr2Obj.val(convAddrData.addr2);
    roadAddr3Obj.val(convAddrData.addr3);
    roadAddr4Obj.val(convAddrData.addr4);
    roadAddr5Obj.val(convAddrData.addr5);

//    // 구지번 주소 설정
//    address1Obj.val(convOldAddrData.addr1 + " " + convOldAddrData.addr2 + " " + convOldAddrData.addr3 + " " + convOldAddrData.addr4);
//    addr1Obj.val(convOldAddrData.addr1);
//    addr2Obj.val(convOldAddrData.addr2);
//    addr3Obj.val(convOldAddrData.addr3);
//    addr4Obj.val(convOldAddrData.addr4);
//    addr5Obj.val(convOldAddrData.addr5);

}

//우편번호 클릭 이벤트 연결
function jusoCallBack(addrInfo){

    var roadPostNo1Obj  = $("#roadPostNo1");
    var roadPostNo2Obj  = $("#roadPostNo2");
    var roadPostNoObj   = $("#roadPostNo");
    var roadAddress1Obj = $("#roadAddress1");
    var roadAddr1Obj    = $("#roadAddr1");
    var roadAddr2Obj    = $("#roadAddr2");
    var roadAddr3Obj    = $("#roadAddr3");
    var roadAddr4Obj    = $("#roadAddr4");
    var roadAddr5Obj    = $("#roadAddr5");

    var mainAddrVal  = addrInfo.roadAddrPart1; // 도로명 주소
    var addedAddrVal = addrInfo.addrDetail +" " + addrInfo.roadAddrPart2;

    // 도로명 주소가 없으면 지번주소로 변경.
    if(isEmpty(mainAddrVal)) {
        mainAddrVal = addrInfo.jibunAddr;
        addedAddrVal = addrInfo.addrDetail;
    }

    if(!isEmpty(mainAddrVal) ) {

        // 주소 분석 분리 작업.
        var convAddrData = bizutils.getParseAddressData(mainAddrVal);
        // addr5 : 분석5번째 + 사용자입력 + (참고주소)
        var addr5Val     = addedAddrVal;

//      var zipNo = addrInfo.zipNo.split("-");  주소체계가 5자리로 변경되어 삭제처리
        var zipNo = addrInfo.zipNo;

        //-------------------------------
        // 우편번호 적용.
        //-------------------------------
        // 주소체계가 5자리로 변경되어 삭제처리
        //roadPostNo1Obj.val(zipNo[0]);
        //roadPostNo2Obj.val(zipNo[1]);
        roadPostNo1Obj.val(zipNo);
        roadPostNoObj.val(trim(addrInfo.zipNo));

        // 도로명 주소 설정
        roadAddress1Obj.val(trim(addrInfo.roadAddrPart1));
        roadAddr1Obj.val(convAddrData.addr1);
        roadAddr2Obj.val(convAddrData.addr2);
        roadAddr3Obj.val(convAddrData.addr3);
        roadAddr4Obj.val(convAddrData.addr4);
        roadAddr5Obj.val(addr5Val);



//        var tagtRow = postBtn.parents("tr")
//        // 우편번호 적용
//        tagtRow.find("input[name=arrBusiFcltFcltPostNo]").val(addrInfo.zipNo);
//        tagtRow.find("input[name=arrBusiFcltFcltAddress]").val( trim(addrInfo.roadAddrPart1) +" "+addedAddrVal);
//        tagtRow.find("input[name=arrBusiFcltFlctAddr1]").val(convAddrData.addr1);
//        tagtRow.find("input[name=arrBusiFcltFlctAddr2]").val(convAddrData.addr2);
//        tagtRow.find("input[name=arrBusiFcltFlctAddr3]").val(convAddrData.addr3);
//        tagtRow.find("input[name=arrBusiFcltFlctAddr4]").val(convAddrData.addr4);
//        tagtRow.find("input[name=arrBusiFcltFlctAddr5]").val(addr5Val);
    }
    // 주소 적용 오류 메시지.
    else {
        // MSG : 주소 검색 적용중 오류가 발생했습니다.
        msgAlert(MSG_TODE_M017);
    }
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//validation 관련
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/**
 * 기본정보 부분 검사.
 *
 * @param areaId 검사 영역 id 값.
 * @param addNotRequiredNmsArray 입력 필수 항목명 추가
 *
 * @returns {Boolean}
 */
function fn_validationUscmArea(areaId, addNotRequiredNmsArray) {

    var isValid = true;

    //--------------
    // 기존정보 검사
    //--------------

    var passwdVal = "";

    fn_getCheckObjects($("#"+areaId)).each(function(){

        var chkObj = $(this);
        var chkObjNm = chkObj.attr("name");
        var chkObjTitle = chkObj.attr("title");

        // 입력 필수 값 검사.
        var notRequiredNms = "|email3";
        if(addNotRequiredNmsArray != undefined && addNotRequiredNmsArray != null && addNotRequiredNmsArray.length > 0) {
            for(var i=0;i<addNotRequiredNmsArray.length;i++){
                notRequiredNms += "|"+addNotRequiredNmsArray;
            }
        }

        // 입력 필수 검사.
        if(notRequiredNms.indexOf(chkObjNm) < 0) {
	        if(fn_checkRequired(chkObj) == false)           { isValid = false; return false; }
        }

        // 타입 검사.
        if(fn_checkType(chkObj) == false)           { isValid = false; return false; }

        // 사용자 id 검사.
        if(isValid && chkObjNm == "userId") {

            // 중복검사 여부 확인
            var etcChkObj = chkObj.parent().find("input:hidden[name=userIdDuplChkYn]");
            if(isEmpty(etcChkObj.val()) == true) {
                //message : chkObjTitle + " 중복검사를 수행하세요."
                msgAlert(chkObjTitle + MSG_MEMB_A004);
                chkObj.focus();
                isValid = false; return false;
            }
        } else if(isValid && chkObjNm == "passwd") {
            passwdVal = chkObj.val();
        } else if(isValid && chkObjNm == "passwdCfrm") {
            if(passwdVal != chkObj.val()){
                // message:"비밀번호가 일치하지 않습니다."
                msgAlert(MSG_MEMB_A005);
                chkObj.focus();
                isValid = false; return false;
            }
        } else if(isValid && chkObjNm == "email2") {
            var emailObj = chkObj.parent().find("input:hidden[name=email]");
            if(fn_checkEmail(emailObj,"E-mail2") == false){
                chkObj.focus();
                isValid = false;
                return false;
            }
        }

    });

    return isValid;
}

//2013.12.04 지자체 선택추가
function fn_uscm_initCityauth( args ) {

    if (!args ||
        !args.cityauth)
        return;

	CITYAUTH_CONFIG = args.cityauth;
	CITYAUTH_CONFIG.sidoName   = CITYAUTH_CONFIG.sidoName || 'cityauthCd1'  ;
	CITYAUTH_CONFIG.cityName   = CITYAUTH_CONFIG.cityName || 'cityauthCd'   ;
	CITYAUTH_CONFIG.initName   = CITYAUTH_CONFIG.initName || 'cityauthCdVal';
    CITYAUTH_CONFIG.postYn     = CITYAUTH_CONFIG.postYn   || 'Y';
    CITYAUTH_CONFIG.loading    = CITYAUTH_CONFIG.loading  || false;

    var sidoName = CITYAUTH_CONFIG.sidoName;
    var cityName = CITYAUTH_CONFIG.cityName;
    var initName = CITYAUTH_CONFIG.initName;
    var loading  = CITYAUTH_CONFIG.loading ;

    //시도선택 COMBO가 없으면 SKIP
    if (!$("#"+sidoName).length)
       return;

    //시도 선택시 지자체(구군) 검색
    comutils.changeCityAuth({
        loading : loading,
        citysido: sidoName,
        cityauth: cityName,
        initcity: initName
    });
}

//사용자구분에 따라 화면 변화
function fn_uscm_loadDisplayChg(args){

	var objType = args.uscmType;

	if(isEmpty(objType) ==false){
		var uscmType = objType.uscmType
		var loading  = objType.loading;
		var chkObj = $("#"+uscmType);
		var chkVal = chkObj.val();
	}

	//사용자가 selectbox 체인지 했을경우만 초기화
	if(!loading)
		//값 초기화시켜줌
		valueInit();

	//사용자정보에 따라 화면 off
	if(chkVal == 'U2'){
		$('._localGoverArea').hide();
		$('._investorArea').show();
	}else if(chkVal == 'U3'){
		$('._investorArea').hide();
		$('._localGoverArea').show();
		$("#cityauthCd").hide();
	}else if(chkVal == 'U4'){
		$('._investorArea').hide();
		$('._localGoverArea').show();
		$("#cityauthCd").show();
	}else if(chkVal == 'U7' || chkVal == 'U8'){
		$('._investorArea').hide();
		$('._localGoverArea').hide();
		$("._mcstArea, ._default").show();
	}else{
		$('._investorArea, ._localGoverArea').hide();
		$("._default").show();
	}
}

//값 초기화
function valueInit(){
	$("._localGoverArea, ._investorArea").find(":input").each(function(){
		var chkObj = $(this);
		chkObj.val("");
	});
}

//Retrieve validation target items in the area object
function fn_getCheckObjects(areaObj) {

    return areaObj.find(":input:not(input:hidden):not(input:checkbox):not(:disabled):not(input:button)");
}

function fn_deptChg(){
	var depNmObj = $("#deptNm");
	if(isEmpty($("#deptCd").val()) == true){
		depNmObj.prop("readOnly", false);
		depNmObj.removeClass("read_only_int");
	}else{
		depNmObj.prop("readOnly", true);
		depNmObj.val("");
		depNmObj.addClass("read_only_int");
    }
}
