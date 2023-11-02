/**
 * 사업등록 입력화면
 *
 * @author SYM
 * @version 1.0 2015-02-12
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////


/**
 * evaluComm.js에서 자동 호출하는 함수 (페이지 초기 설정 관련 수행)
 * 
 */
function loadInitPage(){

    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
}


////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var SAVE_URL      = ROOT_PATH+"/evalu/saveEvaluMgmtSumm.do" ;
var LIST_URL      = ROOT_PATH+"/evalu/listEvaluMgmt.do" ;

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    
    //컴퍼넌트 속성 설정.(주로 maxlength 설정)
    loadCompProp();
    
    // 시도콤보 load
    loadSidoCombo();
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
    
    //파일 다운로드 이벤트 연결.
    bindFileDownloadLink();
    
    // 파일 객체 change 이벤트 연결
    $("input:file").change(function(){
        changeFile($(this));
    })
    
    //시도 콤보박스 change 이벤트 함수 : 시군구 콤보박스를 재구성함.
    bindChangeSidoCombo();
    $("#cityauth1").trigger("change");
    
    // 사업의 구분 콤보 change 이벤트 연결.
    bindChangeBusiType();
    
    $("#planCityExps, #planDoExps").keydown(function(){
        BIZComm.bindSumInputFormEvent({
            sumObjNm     : "planAreaSumExps",
            inputObjsNms : "planCityExps,planDoExps",		//시비 + 도비 = 합계 2015.01.19
            areaObj      : $("#model")
        });
    });
}

////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

// 컴퍼넌트 속성 설정.(주로 maxlength 설정)
function loadCompProp(){
    
    BIZComm.setPropInObjectList(
        $("input:text:not(:hidden), textarea, select"),
        {
            "evaluBusiNm"                  : {maxlength:100 , required:true},    // 사업명    
            "cityauth1"                   : {required:true},                    // 시도 콤보  
//            "cityauth2"                   : {required:true},                    // 시군구 콤보  
//            "busiAddr5"                   : {maxlength:50  , required:true},    // 상세주소        
//            "totBusiExps"                 : {required:true},                    // 사업기간 시작
//            "busiSttDate"                 : {required:true},                    // 사업기간 시작
//            "busiEndDate"                 : {required:true},                    // 사업기간 종료
//            "busiDevEnty"                 : {maxlength:50  },                   // 사업개발주체       
//            "busiType"                    : {required:true},                    // 사업의 구분
//            "busiCate"                    : {required:true},                    // 사업의 유형
        }
    );
}

// 시도 콤보박스 초기 설정.
function loadSidoCombo(){
    
    var busiAddr1Obj = $("#busiAddr1");
    var sidoComboObj = $("#cityauth1");
    
    if(!isEmpty(busiAddr1Obj.val())){
        
        // 시도 콤보박스 초기값 load
        sidoComboObj.find("option").each(function(){
            if($(this).text() == busiAddr1Obj.val()){
                $(this).attr("selected", "selected");
                return false;   // == break;
            }
        });
    }
    
}

// 시도/시군구 콤보박스 text 값을 db 매핑 객체에 적용.
function setCityauthForms(){
    
    var busiAddr1Obj = $("#busiAddr1");
    var sidoComboObj = $("#cityauth1");
    var busiAddr2Obj = $("#busiAddr2");
    var cityComboObj = $("#cityauth2");
    
    busiAddr1Obj.val( sidoComboObj.find("option:selected").text() );
    busiAddr2Obj.val( cityComboObj.find("option:selected").text() );
}


////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id ) {
    switch( id ) {
        case 'prcBtnSave':            //저장
            doSave();
            break;
        case 'prcBtnList':            //리스트
            goList();
            break;
        case 'ctlBtnAdd':             //추가
        	addPlyyRow();
            break;
        case 'ctlBtnRemv':            //삭제
        	removePlyyRow();
            break;
    }
}

//기능 버튼 클릭이벤트 연결
function bindFuncBtnEvent(){
    
    // ID가 'prcBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=prcBtn]").click(function(){
        onClickButton($(this).attr("id"))
    });
    // ID가 'ctlBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=ctlBtn]").click(function(){
        onClickButton($(this).attr("id"))
    });
    
    // 파일 영역 추가 삭제 버튼 이벤트 연결
    $("._dyFileBtnAddCls, ._dyFileBtnRemvCls").bind({
        click : function(){
            if($(this).hasClass("_dyFileBtnAddCls")){
                addFileObj($(this));
            }
            else{
                removeFileObj($(this));
            }
        }
    });
}


//파일 다운로드 이벤트 연결.
function bindFileDownloadLink(){
    $("a._fileDownCls").attr("href","javascript:").click(function(){
        var evaluFileNoVal = $(this).attr("_evaluFileNo");
        
        if(!isEmpty(evaluFileNoVal)){
            EVALUComm.fileDownload(evaluFileNoVal);
        }
        else
            // msg : "다운로드 정보가 올바르지 않습니다."
            msgAlert(MSG_EVALU_M007);
    });
}

//시도 콤보박스 change 이벤트 함수 : 시군구 콤보박스를 재구성함.
function bindChangeSidoCombo(){
    
    var busiAddr1Obj = $("#busiAddr1");
//    var busiAddr2Obj = $("#busiAddr2");
    var sidoComboObj = $("#cityauth1");
    var cityComboObj = $("#cityauth2");
    var cityauth2ValObj = $("#cityauth2Val");
    
    sidoComboObj.change(function(){
        
        // change 이벤트가 발생하면 시군국콤보를 무조건 초기화
        cityComboObj.emptySelect()
        
        if (!isEmpty(sidoComboObj.val())){
            //공통코드 AJAX
            bizutils.findCode({
                params: {parentCode:"COMM.CITYAUTH", addCol1: sidoComboObj.val()},
                fn: function(result) {
                    
                    if(result != null) {
                        
                        cityComboObj.loadSelect(result);
                        
                        // 값이 없으면 
                        if( isEmpty(cityauth2ValObj.val()) ) {
                            $(this).val("");
                        }
                        // 값이 있을 때
                        else {
                            // 시도 콤보박스 초기값 load
                            cityComboObj.find("option").each(function(){
                                if($(this).text() == cityauth2ValObj.val()){
                                    $(this).attr("selected", "selected");
                                    return false;   // == break;
                                }
                            });
                            // 초기값을 비운다.(비우지 않으면 리스트에 있으면 항상 선택된다)
                            cityauth2ValObj.val("");
                        }
                        
                    }
                }
            });
        }
        
        
    }); // end of 'sidoComboObj.change(function(){'
    
}

// 사업의 구분 콤보 change 이벤트 연결.
function bindChangeBusiType(){
    
    EVALUComm.bindChangeBusiType({
        busiTypeId : "busiType",
        busiCateId : "busiCate"
    });
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

//저장처리
function doSave(){
	
    // 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    
    // 정합성 검사.
    if(!doValidation()) return;
    
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
        
        if(isConfirm){
        	
            // 시도/시군구 콤보박스 text 값을 db 매핑 객체에 적용.
            setCityauthForms();
            
            if(isFileUpload){
                // file 객체 명 일괄 변경 및 필요한 파일정보 parameter 신규 생성.
                EVALUComm.buildUpfilePropObjs($("#model"));
                
                //<년도별 사업계획서>의 atthType 값을 선택된 년도로 일괄 설정.
                setPlyyAtthTypes();
            }
            
            // submit
            BIZComm.submit({
                isFile : isFileUpload ,                        // 파일첨부 form으로 설정.
                url    : ROOT_PATH + SAVE_URL
            });
        }
    });
}

//목록으로 이동 
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}



////////////////////////////////////////////////////////////////////////////////
//콘트롤 함수
////////////////////////////////////////////////////////////////////////////////

//============================
//년도별 사업계획서 컨트록 함수
//============================

//row 추가 컨트롤함수
function addPlyyRow(){ 
	
    DYUtils.actionDyUnit({
        unitType   :"table",
        procType   :"add",
        dyAreaId   :"dyTblPlyy",
        afterAdd   :function(preRow, newRow){
            
            // 기존 row의 불필요 요소를 제거
            resetPlyyRow(newRow);
        }
    });
}

//<년도별 사업계획서>의 atthType 값을 선택된 년도로 일괄 설정.
//- 년도가 파일을 등록할 때 ATTH_TYPE으로 적용됨.
function setPlyyAtthTypes(){
	
    $(":input[name='arrBusiPlyyDocuTypeYearTemp']").each(function(){
        $(this).parents("tr").find("input:hidden[name=arrFileAtthType]").val($(this).val());
    });
    
}

//기존 row의 필요 없는 내용을 저거하거나 초기화 하는 func
//- 비활성화된 년도 combo를 활성화
//- 첨부된 파일 리스트 영역을 제거
//- 년도 combo를 현재 년도로 재구성.
function resetPlyyRow(rowObj) {
 
    // 비활성화되어 있는 combo객체를 활성화 한다.
    rowObj.find("select:disabled").prop("disabled",false).css("background","");
    
    // 첨부된 파일 리스트 영역이 존재하면 제거해야 함
    rowObj.find("._attachedFileArea").remove();
    
//    var selObj = rowObj.find("select[name=arrBusiPlyyDocuTypeYearTemp]");
//     
//    alert(selObj.val());
//    
//    selObj.onChange(function(){
//    	rowObj.find("select[name=arrBusiPlyyDocuTypeYear]").val(selObj.val());
//    });
    
    // 새로 추가된 row의 년도 콤보를 현재년도로 재구성
//    BIZComm.loadEvaluYearCombo({
//        combObj : rowObj.find("select[name=arrBusiPlyyDocuTypeYearTemp]"),
//        stdNm   : "arrBusiPlyyDocuTypeYear"
//    })
}

//row 삭제 컨트롤 함수
function removePlyyRow(){
 
    var deletedRow = null;
    
    deletedRow = DYUtils.actionDyUnit({
        unitType     : "table",
        procType     : "remove",
        dyAreaId     : "dyTblPlyy",
        beforeRemove : function(delRow){
            
            // 삭제되는 첨부된파일의 evaluFileNo를 삭제대상 문자열에 추가
            addDeltDatasInfo("deltPlyyYearDatas", delRow.find("input:hidden[name$=DocuTypeYear]").val() );
            
        },
        noCheckMsg   : MSG_EVALU_M005       // msg : "삭제대상을 선택하세요."
    });
    
    // 삭제됐을 때 리턴되는 객체가 null이 아니면 맨 마지막 row이기 때문
    //  => 남은 form에서 정리할 내용이 존재.
    if(deletedRow != null){
        resetPlyyRow(deletedRow);
    }
}

//============================
//파일객체 컨트롤 버튼 함수
//============================


//파일 객체 추가 이벤트 함수
function addFileObj(fileBtnObj){
 
    var topWrapObj = fileBtnObj.parents("td");
    
    // 객체 추가
    DYUtils.actionDyUnit({
        unitType   :"group",
        procType   :"add",
        dyAreaObj  :topWrapObj.find("._dyFileAreaCls"),
        afterAdd   :function(preGrp, newGrp){
            
            // '추가'를 클릭했을 때 file form이 다음 라인으로 떨어지게 추가.
            //newGrp.before("<br/>");
        },
        // 파일 객체 change 이벤트
        changeFile : function(fileObj){
            changeFile(fileObj);
        }
    });
 
}

//파일객체 제거 이벤트 함수
function removeFileObj(fileBtnObj){
    
    var topWrapObj = fileBtnObj.parents("td");
    
    if(topWrapObj.find("input[name=delChk]:checked").size() == 0) {
        // msg : "삭제대상을 선택하세요."
        msgAlert(MSG_EVALU_M005);
        return;
    }
    
    // 첨부된 파일 객체 제거 로직
    DYUtils.actionDyUnit({
        unitType     :"group",
        procType     :"remove",
        dyAreaObj    :topWrapObj.find("._attachedFileArea"),
        dyGrpClassNm :"_dynamicFileGroup",
        isRemoveLastUnit : true,            // 마지막 unit을 제거하게 함.
        beforeRemove :function(delGrp){
            
            // 삭제되는 첨부된파일의 evaluFileNo를 삭제대상 문자열에 추가
            addDeltDatasInfo("deltFileDatas", delGrp.find("input[name=delChk]").val() );
        }
    });
    // 신규 파일첨부 객체 제거 로직
    DYUtils.actionDyUnit({
        unitType     :"group",
        procType     :"remove",
        dyAreaObj    :topWrapObj.find("._dyFileAreaCls"),
        beforeRemove :function(delGrp){
            
        },
        // 파일 객체 change 이벤트
        changeFile : function(fileObj){
            changeFile(fileObj);
        }
    });
}

//삭제 대상의 pk 또는 고유 분값을 삭제 대상 문자열 form에 추가 처리
//-> 추후 대상을 일괄 삭제 함.
function addDeltDatasInfo(deltDatasId, addVal){
    var deltDatasObj = $("#"+deltDatasId);
    
    // 삭제될 row의 pk를 문자열로 저장.
    var pkDatasStr = deltDatasObj.val();
    if(!isEmpty(addVal)){
        deltDatasObj.val( pkDatasStr + ( isEmpty(pkDatasStr)? "":"," ) + addVal );
    }
}

//파일 객체 change 이벤트 
function changeFile(fileObj){
    
    // file객체의 path정보를 보여주는 input:text 객체
    var upfilePathObj = fileObj.parents("._dynamicGroup").find("input[name=upfilePath]");
    
    // 파일 첨부시 문제가 있으면 파일 객체를 삭제하고 새로 추가하여 파일이 첨부되는 문제를 해결.
    if(!EVALUComm.validFileObj(fileObj, $("#allowedFileExts").val(), $("#allowedImgFileExts").val())) {
        // 파일 객체 재 생성.
        DYCom.reCreateFileObj(fileObj);
        
        // file path  제거 : file 객체가 초기화 되기 때문에 제거 해야 함.
        upfilePathObj.val("");
    }
    else{
        // file path  보여주기
        upfilePathObj.val(fileObj.val());
    }
}


////////////////////////////////////////////////////////////////////////////////
// 정합성 검사 함수
////////////////////////////////////////////////////////////////////////////////

// 저장시 정합성 검사.
function doValidation(){
    
    var isValid = true;
    
    BIZComm.getCheckObjects($("#model")).each(function(){
        
        var chkObj = $(this);
        var chkObjNm = chkObj.attr("name");
        var chkObjTitle = chkObj.attr("title");
        
        // 입력필수이 대상 검사.
        //  setPropInObjectList함수로 설정한 값 중에서 "required:true"로 설정한 대상.
        if(chkObj.attr("_required") == "true" && chkObj.attr("name").indexOf("arr") < 0){
            if( !fn_checkRequired(chkObj) ) { isValid = false; return false; }
        }
        
        // [총사업기간 시작일] 항목 검사
        if("busiSttDate" == chkObjNm) {
        
            // 종료일이 입력됐으면 반드시 시작을 입력해야 함.
            var busiEndDateVal = $("#busiEndDate").val();
            if(isEmpty(chkObj.val()) && !isEmpty(busiEndDateVal) ){
                // msg : "총 사업기간 종료일을 입력했으면 반드시 시작일을 입력해야 합니다."
                msgAlert(MSG_EVALU_M016, chkObj);
                isValid = false; return false;
            } 
        }
        // [총사업기간 종료일] 항목 검사
        else if("busiEndDate" == chkObjNm) {
            
            // 종료일이 시작일 보다 이전인지 검사.
            var busiSttDateVal = $("#busiSttDate").val();
            var busiEndDateVal = $("#busiEndDate").val();
            if(!isEmpty(busiSttDateVal) && !isEmpty(busiEndDateVal) 
                    && busiSttDateVal > busiEndDateVal) {
                // mag : "총 사업기간 종료일이 시작일보다 이전 날짜일 수 없습니다."
                msgAlert(MSG_EVALU_M015, chkObj);
                isValid = false; return false;
            }
            
        }
        else{
        	
            //--------------------------------------------
            // *** [사업 추진단계] 항목 검사 후 '년도별 사업계획서' 검사 함.
            //--------------------------------------------
            if(DYUtils.dyFormValidation({
                checkUnitObjList : $("#dyTblPlyy tbody tr"),
                checkUnitFunc    : function(chkObj){
                    var isValid = true;
                    
                    // 년도를 중복해서 입력했는지 검사.
                    var plyyYearChkStrs = "";
                    $("select[name=arrBusiPlyyDocuTypeYearTemp]").each(function(){
                        var curYearObj = $(this);
                        if(!isEmpty(curYearObj.val())) {
                            
                            if(plyyYearChkStrs.indexOf( curYearObj.val() ) >=0 ) {
                                // msg : "첨부파일 항목이 중복되었습니다."
                                msgAlert(MSG_EVALU_M010, curYearObj);
                                isValid = false; return false;
                            }
                            else{
                                plyyYearChkStrs +=  ( ( ( isEmpty(curYearObj.val()) )? "":"," ) + curYearObj.val() );
                            }
                        }
                    });
                    
                    return isValid;
                }
            }) == false) { isValid = false; return false; }
        }
    });

    return isValid;
}
