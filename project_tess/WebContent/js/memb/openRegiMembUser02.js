/*
 * @(#)openRegiMembUser02.js 1.0 2014/10/02
 * 
 * COPYRIGHT (C) 2006 CUBES CO., INC.
 * ALL RIGHTS RESERVED.
 */

/**
 * 회원관리 2단계 - 사용자정보 입력페이지
 *
 * @author SYM
 * @version 1.0 2014/10/02
 */


//---------------------------------
// Global 변수
//---------------------------------

// 첨부 허용 파일 확장명
var _ALLOWED_FILE_EXTS = "";


//---------------------------------
// 
//---------------------------------
$(document).ready(function(){
	
	/*if($("#gubunUser").val().trim() == "null" || $("#gubunUser").val().trim() == ""){
		
		alert("회원구분 선택을 다시 해주세요.")
		
		var form = document.model;
		form.action = "/memb/openRegiMembUser00.do";
		form.target = "_self";
		form.submit();
	}*/
    
//    // Set disable 'back' event at next page
//    window.history.forward(0);

    //---------------------------------
    // load init
    //---------------------------------
	
    // 공통 loading 호출
    fn_uscm_load({
        cityauth: {
            sidoName: "cityauthCd1",
            cityName: "cityauthCd",
            initName: "cityauthCdVal",
            loading: true
        }
    });

    //---------------------------------
    // event
    //---------------------------------

    // 공통 이벤트 설정
    fn_uscm_setEvent();
    
    //부서명 처리
    fn_deptChg();
    
    fn_uscm_loadDisplayChg({
    	uscmType: {
    		uscmType: "uscmType",
    		loading: false
    	}
    });
    
    // 사용자 id 중복 검사 버튼 이벤트 연결
    $(".userChkDuplBtn").click(function(){
        checkDuplUserId();
    });
    
    // 최종 확인 처리 버튼 이벤트 
    $("#cnfmBtn,  #cnclBtn").click(function(){
        //doAction($(this));
    	cnfmBtn();
    });
    
    // 부서명코드 이벤트
    $("#deptCd").change(function(){
    	fn_deptChg();
    }); 
    
    //사용자구분에 따라 화면 변화
    $("#uscmType").change(function(){
    	fn_uscm_loadDisplayChg({
        	uscmType: {
        		uscmType: "uscmType",
        		loading: false
        	}
        });
    });
    
});

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//화면 처리 관련 및 이벤트
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// action 로직
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

var REGI_PROC_URL        = "/memb/regiMembUser02.do";
var INIT_PROC_URL        = "/memb/openRegiMembUser01.do";

// 화면 이동 및 처리 method
/*function doAction(actObj) {
    var form = $("#form1");
    var actObjId = actObj.attr("id");
    var url = "";
    
    if(actObjId == "cnfmBtn") {
    	if(validation() == true) {
            // msg : "회원 등록 요청하시겠습니까?"
        	nConfirm(MSG_MEMB_A007, null, function(isConfirm){
	            if(isConfirm){ 
	            	 url = REGI_PROC_URL;
	            	 
            	    form.attr({
            	         "method" :"post" 
            	        ,"action" :ROOT_PATH + url
            	    });
            	   form.submit(); 
	            }
        	});
    	}else{
    		return false;
    	}
    }else if(actObjId == "cnclBtn"){
    	 url = INIT_PROC_URL;
    	 
    	    form.attr({
    	         "method" :"post" 
    	        ,"action" :ROOT_PATH + url
    	    });
    	   form.submit(); 
    }

}*/

//아이디 중복검사
function checkDuplUserId(){
    
    var userIdObj = $("#userId");
    var userIdObjCheck = $("#userIdCheck");
    var orgUserIdObj = $("#orgUserId");
    
    fn_checkUserIdDuplAjax();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Validation 처리 관련
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function validation() {

    var isValid = true;

 //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 // 기본정보 검사		2015.01.28 화면변경요청으로 인해 수정
 //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
    
    var addNotRequiredNmArry = null;
//    var addNotRequiredNmArry = ["userId", "passwd", "passwdCfrm", "userNm", "telNo1", "telNo2", "telNo3", "cellphoneNo1", "cellphoneNo2", "cellphoneNo3", "email1", "email2"];

    if($('#uscmType').val() == 'U2'){
    	addNotRequiredNmArry = ["cityauthCd1", "cityauthCd", "uscmRole", "deptCd", "deptNm"];
    }else if($('#uscmType').val() == 'U3'){  
        if(isEmpty($("#deptCd").val())==true){
        	addNotRequiredNmArry = ["cityauthCd", "deptCd","ownerNm", "roadPostNo1", "roadPostNo2", "roadAddress1", "roadAddr5"];
        }else{
        	addNotRequiredNmArry = ["cityauthCd", "deptNm", "ownerNm", "roadPostNo1", "roadPostNo2", "roadAddress1", "roadAddr5"];
        }
    }else if($('#uscmType').val() == 'U4'){
        if(isEmpty($("#deptCd").val())==true){
        	addNotRequiredNmArry = ["deptCd", "ownerNm", "roadPostNo1", "roadPostNo2", "roadAddress1", "roadAddr5"];
        }else{
        	addNotRequiredNmArry = ["deptNm", "ownerNm", "roadPostNo1", "roadPostNo2", "roadAddress1", "roadAddr5"];
        }
    }else{				
    	addNotRequiredNmArry = ["cityauthCd1", "cityauthCd", "uscmRole", "uscmNm", "ownerNm", "deptCd", "deptNm"];
    }
    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 기본정보 검사
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~        
    
    isValid = fn_validationUscmArea("_baseArea", addNotRequiredNmArry);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  추가정보 검사
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    if(isValid == true) {
        
        isValid = fn_validationUscmArea("_uscmArea", addNotRequiredNmArry);
    }

    return isValid;
}


//회원등록
function cnfmBtn(){
	
	var form = document.model;
	
	//아이디
	if($("#userIdDuplChkYn").val() == "N" || $("#userIdDuplChkYn").val() == "") {
		alert("ID 중복확인을 해주세요.");
		$("#strNumCheck").focus();
		return;
	}
	
	//아이디
	if($("#userId").val() != $("#userIdCheck").val()) {
		alert("ID 중복확인을 해주세요.");
		$("#strNumCheck").focus();
		return;
	}
	
	//비밀번호 체크
	if($("#passwd").val() == ""){
		alert("비밀번호를 입력해 주세요.");
		$("#passwd").focus();
		return;
	}
	 
	if(!fnCheckPassword($.trim($("#passwd").val()))){
		$("#passwd").focus();
		return;
	}
	 
	if($("#passwdCfrm").val() == ""){
		alert("비밀번호 확인란을 입력해 주세요.");
		$("#passwdCfrm").focus();
		return;
	}
	 
	if($.trim($("#passwd").val()) != $.trim($("#passwdCfrm").val())){
		alert("비밀번호를 동일하게 입력해 주세요.");
		$("#passwdCfrm").val("");
		$("#passwdCfrm").focus();
		return;
	}
	 
	//전화번호
	//if($("#telNo1").val() == "") {
	//	alert("전화 번호를 확인하여 주시기 바랍니다.");
	//	$("#telNo1").focus();
	//	return;
	//}
	//if(!/^[0-9]{4}$/.test($("#telNo2").val())){ 
	//	alert("전화 번호를 확인하여 주시기 바랍니다.");
	//	$("#telNo2").focus();
	//	return;
	//}
	//if(!/^[0-9]{4}$/.test($("#telNo3").val())){ 
	//	alert("전화 번호를 확인하여 주시기 바랍니다.");
	//	$("#telNo3").focus();
	//	return;
	//}
	 
	//핸드폰 번호
	//if($("#cellphoneNo1").val() == "") {
	//	alert("핸드폰 번호를 확인하여 주시기 바랍니다.");
	//	$("#cellphoneNo1").focus();
	//	return;
	//}
	//if(!/^[0-9]{4}$/.test($("#cellphoneNo2").val())){ 
	//	alert("핸드폰 번호를 확인하여 주시기 바랍니다.");
	//	$("#cellphoneNo2").focus();
	//	return;
	//}
	//if(!/^[0-9]{4}$/.test($("#cellphoneNo3").val())){ 
	//	alert("핸드폰 번호를 확인하여 주시기 바랍니다.");
	//	$("#cellphoneNo3").focus();
	//	return;
	//}
	
	//사용자 명
	if($("#userNm").val().trim() == "") {
		alert("사용자명을 입력해주세요.");
		$("#userNm").focus();
		return;
	}
	
	//이메일
	if($("#email1").val().trim() == "") {
		alert("이메일을 입력해주세요.");
		$("#email1").focus();
		return;
	}
	
	if(!/[^@가-힣-ㄱ-ㅎ ㅏ-ㅣ]$/.test($("#email1").val())){ 
	    alert('한글 또는 @가 들어갈수 없습니다.');
	    $("#email1").focus();
	    return;
	}
	
	re = /[A-Za-z0-9_-]+[.]+[A-Za-z]+/;
	
	if (!re.test($("#email2").val())) {
		 alert('잘못된 이메일 형식입니다.');
		 $("#email2").focus();
		return;
	}
	
	/*//추가정보 입력
	if($('#uscmType').val() == 'U5' || $('#uscmType').val() == 'U6' || $('#uscmType').val() == 'U1' || $('#uscmType').val() == 'U10'){
		
		if($("#roadAddr5").val().trim() == "") {
			alert("주소를 입력해 주세요.");
			$("#roadAddr5").focus();
			return;
		}
		
	}else if($('#uscmType').val() == 'U2'){ //민간투자자
		
		if($("#uscmNm").val().trim() == "") {
			alert("기관(업체)명 을 입력해주세요");
			$("#uscmNm").focus();
			return;
		}
		
		if($("#ownerNm").val().trim() == "") {
			alert("대표자명 을 입력해주세요");
			$("#ownerNm").focus();
			return;
		}
		
		if($("#roadAddr5").val().trim() == "") {
			alert("주소를 입력해 주세요.");
			$("#roadAddr5").focus();
			return;
		}
		
	}else*/ 
	
	if($('#uscmType').val() == 'U3'){ //시도
		
		//지자체
		if($("#cityauthCd1").val() == "") {
			alert("지자체 소속을 선택해 주시기 바랍니다.");
			$("#cityauthCd1").focus();
			return;
		}
		//담당업무명
		if($("#uscmRole").val().trim() == "") {
			alert("담당하고 계신 업무명을 적어주시기 바랍니다.");
			$("#uscmRole").focus();
			return;
		}
		//기관(업체)명
		if($("#uscmNm").val().trim() == "") {
			alert("기관(업체)의 명칭을 적어주시기 바랍니다.");
			$("#uscmNm").focus();
			return;
		}
		//부서명
		if($("#deptCd").val() == "" && $("#deptNm").val().trim() == "") {
			alert("부서명을 선택해 주시기 바랍니다.");
			$("#deptCd").focus();
			return;
		}
		
	}else if($('#uscmType').val() == 'U4'){ //시군구
		
		//지자체
		if($("#cityauthCd1").val() == "") {
			alert("지자체 소속을 선택해 주시기 바랍니다.");
			$("#cityauthCd1").focus();
			return;
		}
		if($("#cityauthCd").val() == "") {
			alert("지자체 소속을 선택해 주시기 바랍니다.");
			$("#cityauthCd").focus();
			return;
		}
		//담당업무명
		if($("#uscmRole").val().trim() == "") {
			alert("담당하고 계신 업무명을 적어주시기 바랍니다.");
			$("#uscmRole").focus();
			return;
		}
		//기관(업체)명
		if($("#uscmNm").val().trim() == "") {
			alert("기관(업체)의 명칭을 적어주시기 바랍니다.");
			$("#uscmNm").focus();
			return;
		}
		//부서명
		if($("#deptCd").val() == "" && $("#deptNm").val().trim() == "") {
			alert("부서명을 선택해 주시기 바랍니다.");
			$("#deptCd").focus();
			return;
		}
		
		
	}
	
	setFieldList();
	
	var msg = confirm("회원 등록 요청하시겠습니까?");
	
	if(msg){
		
		form.telNo.value = $("#telphoneNo1").val() + "-" + $("#telphoneNo2").val() + "-" + $("#telphoneNo3").val();
		form.cellphoneNo.value = $("#cellphoneNo1").val() + "-" + $("#cellphoneNo2").val() + "-" + $("#cellphoneNo3").val();
		form.email.value = $("#email1").val() + "@" + $("#email2").val(); 
		
		/*if($('#uscmType').val() == 'U4' || $('#uscmType').val() == 'U3'){ // 시도 시군구 일때만
			form.cityauthCdVal.value = $("#cityauthCd1").val() + " " + $("#cityauthCd").val(); 
		}*/
		
		form.action = "/memb/regiMembUser02.do";
		form.target = "_self";
		form.submit();
	}
	
}

//가입취소
function joinCancel(){
	var form = document.model;
	form.action = "/memb/openRegiMembUser00.do";
	form.target = "_self";
	form.submit();
}



//회원등록 취소
/*function cnclBtn(){
	var form = $("#form1");
	var url = "";
	url = INIT_PROC_URL;
	 
    form.attr({
         "method" :"post" 
        ,"action" :ROOT_PATH + url
    });
   form.submit(); 
}*/



function fnCheckPassword(upw) {
    if(!/^[0-9a-zA-Z!@#$%^&*()]{6,12}$/.test(upw))
    { 
        alert('비밀번호는 영문,숫자,특수문자 혼합 6자~12자까지 입력 가능. 특수문자(!,@,#,$,%,^,&,*,(,))만 가능.'); 
        return false;
    }
  
    var chk_num = upw.search(/[0-9]/g); 
    var chk_eng = upw.search(/[a-z]/ig); 

    if(chk_num < 0 || chk_eng < 0)
    { 
        alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.'); 
        return false;
    }

    return true;
}


function setFieldList(){
	var travCheckboxes = document.getElementsByName('travel');
	var econCheckboxes = document.getElementsByName('economy');
	var cultCheckboxes = document.getElementsByName('culture');
	var contCheckboxes = document.getElementsByName('content');
	var enviCheckboxes = document.getElementsByName('environment');
	var consCheckboxes = document.getElementsByName('construct');
	var fieldList = [travCheckboxes, econCheckboxes, cultCheckboxes, contCheckboxes, enviCheckboxes, consCheckboxes];
	var fieldCodeSelected = [];
	var fieldParentCodeSelected = [];
	var fieldDetailContSelected = [];
	
	for(var i=0; i< fieldList.length; i++) {
		for (var j=0; j<fieldList[i].length; j++) {
			if(fieldList[i][j].checked) {
				var parent_code = $(fieldList[i][j]).closest(".evtdss-form-table-incell").attr("id");
				var code = fieldList[i][j].value;
				var detail_field = $(fieldList[i][j]).closest(".field_tr").find("input[name=detailSubField]").val();
				
				fieldCodeSelected.push(code);
				fieldParentCodeSelected.push(parent_code);
				if(detail_field == null) {
					fieldDetailContSelected.push("null1");
					console.log("옹오");
				} else {
					fieldDetailContSelected.push(detail_field);
				}
				
				//console.log($(fieldList[i][j]).parents().find(".evtdss-form-table-incell").attr("id"));
				//console.log($(fieldList[i][j]).closest(".evtdss-form-table-incell").attr("id"));
				//console.log($(fieldList[i][j]).closest(".field_tr").find("input[name=detailSubField]").val());
				
				//fieldSelected.push({"parentCode": parent_code, "code": code, "detail_field": detail_field});
			}
		}
	}
	$("#fieldCodeList").val(fieldCodeSelected.toString());
	$("#fieldParentCodeList").val(fieldParentCodeSelected.toString());
	$("#fieldDetailContList").val(fieldDetailContSelected.toString());
	
	console.log(fieldDetailContSelected.toString());
	
}