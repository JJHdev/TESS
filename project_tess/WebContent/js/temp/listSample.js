
/////////////////////////////////////////////////////////
// SCRIPT 파일 INCLUDE 처리.
/////////////////////////////////////////////////////////

//$.getScript(ROOT_PATH+'/js/common-dyUtil.js', function(){
//
//    // script가 모두 load되면 초기화 수행 시작.
//    loadPage();
//    
//});

$(document).ready(function(){
    loadPage();
});


/////////////////////////////////////////////////////////
// LOGIC 구현 예
/////////////////////////////////////////////////////////

function loadPage(){

    //------------------------
    // mask 적용 예제
    //------------------------
    $("#calMask").toCalendarField({
        initToday   : true, // 오늘날짜 초기 설정 여부
        isSetCalBtn : true  // 달력버튼 생성 여부
    });
    $("#floatMask").toFloatField();
    $("#buzRegNoMask").toBizRegNoField();
    $("#usrRegNoMask").toUsrRegNoField();
    $("#phoneNoMask").toPhoneNoField();
    
    // 기본 달력객체 설정.
    DYCom.createDatePicker( $("input._calendar") );
    
    // group 추가하는 부분에서maskDate 적용 테스트
    // 해당 input객체에 class를 '_calendar'로 적용하고 달력 객체는 따로 설정해야 함.
    $("#dateMask1").toCalendarField();
}


// Search
function fn_search(page) {
	var form = $("#form1");

    $("input[name=page]").val(page);

	form.prop("action", ROOT_PATH+"/temp/listSample.do");
	form.submit();
}

function onClickButton(mode) {
	var form = $("#form1");

	switch(mode.toUpperCase()) {
		case "SEARCH":
        	form.prop("action", ROOT_PATH+"/temp/listSample.do");
        	form.submit();
			break;
		case "EXCELDOWN":
			fn_excelDown();
			break;
		case "REGIOPEN":
			document.location.href = ROOT_PATH + '/temp/openRegiSample.do';
			break;
		case "ADD":
		    addRow();
		    break;
		case "DELETE":
		    deleteRow();
		    break;
		case "ADDGRP":
		    addGrp();
		    break;
		case "DELETEGRP":
		    deleteGrp();
		    break;
	}
}

// Dynamic row 관련 함수

function addRow(){
//    DYUtils.addRow({
    DYUtils.actionDyUnit({
        unitType   :"table",
        procType   :"add",
        
        dyAreaId   :"dytbl1",
        afterAdd   :afterAddRow,
        changeFile :changeFileRow
        });
}

function afterAddRow(preRow, newRow){
    alert("추가되었습니다.");
}

function changeFileRow(fileObj){
    alert("첨부파일 크기 : "+fileObj.get(0).files[0].size);
}

function deleteRow(){
//    DYUtils.removeCheckRow({
    DYUtils.actionDyUnit({
        unitType   :"table",
        procType   :"remove",
        
        dyAreaId        : "dytbl1",
        beforeRemove    : beforeRemoveRow,
        changeFile      : changeFileRow,
        noCheckMsg      : "삭제대상을 선택하세요."
        });
}

function beforeRemoveRow(delRow){
    alert("ID가 "+delRow.find("input[name=id]").val() + "인 Row가 삭제됩니다.");
}

//Dynamic groups 관련 함수

function addGrp(){

//    DYUtils.addDyGrpInArea({
    DYUtils.actionDyUnit({
        unitType   :"group",
        procType   :"add",
        
        dyAreaId     :"DyArea",
        afterAdd     :afterAddDyGrp,
        changeFile   :changeFileRow
        });
}

function afterAddDyGrp(preGrp, newGrp){
    alert("추가되었습니다.");
}

function deleteGrp(){
//    DYUtils.removeCheckDyGrp({
    DYUtils.actionDyUnit({
        unitType   :"group",
        procType   :"remove",
        
        dyAreaId         :"DyArea",
        beforeRemove     :beforeRemoveDyGrp,
        noCheckMsg       : "삭제대상을 선택하세요.",
        changeFile       :changeFileRow
        });
}

function beforeRemoveDyGrp(delGrp){
    alert("Group이 삭제됩니다.");
}

/////////////////////////////////////////////////////////
// 우편번호 검색 관련 샘플
/////////////////////////////////////////////////////////

function openDaumPostcode() {
    
    var args = {
            oncomplete: function(data) {
                
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
                $('#post1'   ).val(data.postcode1     );
                $('#post2'   ).val(data.postcode2     );
                $('#addrType').val(data.addressType   );
                $('#addr'    ).val(data.address       );
                $('#addr1'   ).val(data.address1      );
                $('#addr2'   ).val(data.address2      );
                $('#engAddr' ).val(data.addressEnglish);
                $('#relAddr' ).val(data.relatedAddress);

                //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
                //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
                //document.getElementById('addr').value = addr;

                $('#addrDetail'  ).focus();
                
            }
        };
    
    // DAUM 우편번호 팝업 열기.
    (new daum.Postcode(args)).open();
    
}


function foldDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    $("#wrap").hide();
}

function expandDaumPostcode() {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 우편번호와 주소 및 영문주소 정보를 해당 필드에 넣는다.
            $('#post1'   ).val(data.postcode1     );
            $('#post2'   ).val(data.postcode2     );
            $('#addrType').val(data.addressType   );
            $('#addr'    ).val(data.address       );
            $('#addr1'   ).val(data.address1      );
            $('#addr2'   ).val(data.address2      );
            $('#engAddr' ).val(data.addressEnglish);
            $('#relAddr' ).val(data.relatedAddress);
            
            // iframe을 넣은 element를 안보이게 한다.
            $("#wrap").hide();
            
            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size) {
            $("#wrap").css("height", size.height+"px");
            
//            var innerIframe = $("#wrap iframe").contents().find("iframe");
//            innerIframe.contents().find(".link_findaddress").html("");
        },
        width : '100%',
        height : '100%'
    }).embed($("#wrap").get(0));

    // iframe을 넣은 element를 보이게 한다.
    $("#wrap").show();
}

/////////////////////////////////////////////////////////
// juso.go.kr 우편번호 테스트
/////////////////////////////////////////////////////////


function goPopup(){
    // 주소검색을 수행할 팝업 페이지를 호출합니다.
    // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
//    var pop = window.open("/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
    openFindJuso()  // common.js
}


function jusoCallBack(addrInfo){
    // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
    $("#roadFullAddr" ).val(addrInfo.roadFullAddr);     //도로명주소 전체(포멧)
    $("#roadAddrPart1").val(addrInfo.roadAddrPart1);    //도로명주소
    $("#roadAddrPart2").val(addrInfo.roadAddrPart2);    //참고주소
    $("#addrInputDetail"   ).val(addrInfo.addrDetail);       //고객입력 상세주소
    $("#engJusoAddr"      ).val(addrInfo.engAddr);          //영문 도로명주소
    $("#jibunAddr"    ).val(addrInfo.jibunAddr);        //지번 주소
    $("#zipNo"        ).val(addrInfo.zipNo);            //우편번호
    $("#admCd"        ).val(addrInfo.admCd);            //행정구역코드
    $("#rnMgtSn"      ).val(addrInfo.rnMgtSn);          //도로명코드
    $("#bdMgtSn"      ).val(addrInfo.bdMgtSn);          //건물관리번호
}


