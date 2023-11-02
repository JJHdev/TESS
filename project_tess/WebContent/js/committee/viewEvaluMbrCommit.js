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


$(document).ready(function(){
//  // Set disable 'back' event at next page
//  window.history.forward(0);

  //---------------------------------
  // load init
  //---------------------------------
  
  // 사용자 id 중복 검사 버튼 이벤트 연결
  $(".userChkDuplBtn").click(function(){
      checkDuplUserId();
  });
  
  // 최종 확인 처리 버튼 이벤트 
  $("#cnfmBtn,  #cnclBtn").click(function(){
      doAction($(this));
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
  
  $("#postPopBtn").click(function(){
//  	openDaumPostcode();
  	//우편번호 검색방법 변경으로 인한 메소드 변경	2014-12-11 SYM
      openFindJuso();  // common.js
  });
 
  
  // 이메일 입력 이벤트 연결.
  $("#email1,#email2").change(function(){
      fn_uscm_setFullDomain();
  });
  // 이메일 도메인 combo 이벤트
  $("#email3").change(function(){
      //fn_uscm_setEmailDomain($(this));
      fn_uscm_setFullDomain();
  });
  
//휴대폰 번호 입력 이벤트 연결
  $("#cellphoneNo1,#cellphoneNo2,#cellphoneNo3").change(function(){
      fn_uscm_setFullCellphoneNo();
  });
  
  
  
  
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var GRID_URL 		= ROOT_PATH+"/committee/getEvaluBusiList.do" ;
var REGI_URL		= ROOT_PATH+"/evalu/viewEvaluBudtMgmt2.do";
var UPDATE_URL      = ROOT_PATH+"/committee/updateCommitMembInfo.do" ;
var SAVE_FIELD_URL = ROOT_PATH+"/committee/saveCommitMembField.do" ;
var LIST_URL      = ROOT_PATH+"/committee/listEvaluMbrMgmt.do" ;

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
 // 그리드 로드
    loadGrid();
    
    // 공통 이벤트 설정
    //fn_uscm_setEvent();
    
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	fn_uscm_setFullCellphoneNo();
}


//그리등 paramter 구성.
function getSearchPostData(){
	var userId = $("#userId").val();
	var postData = {
			evaluUserId : userId
    };
	
    return postData;
    
}

////////////////////////////////////////////////////////////////////////////////
//Grid 관련
////////////////////////////////////////////////////////////////////////////////

var colNames = null;
var colModel = null;
var captionTitle = "";

function loadGrid() {
 // 메뉴 구분에 따라 col정보 설정.
 setGridInfoByMenu();
 $(GRID_NAME).jqGrid({
     url          : GRID_URL,
     datatype     : 'json',
     mtype        : 'POST',
     caption      : captionTitle,
     colNames     : colNames,
     postData     : getSearchPostData(),
     colModel     :colModel,
     rowNum:10,
     rowList:[5,10,15],
     height: 260,
     rownumbers: true,
     rownumWidth:40,
     autowidth: true,
     pager: '#pager',
     //sortname: 'join_date',
     //sortorder: 'DESC',
     viewrecords : true,
     multiselect : true,
     multiboxonly: true,
     shrinkToFit : false,
     jsonReader      : {
         root        : "rows",
         page        : "page",
         total       : "total",
         records     : "records",
         repeatitems : false,
         cell        : "cell",
         id          : "id"
     },
     afterInsertRow : function(rowid, rowdata, rowelem) {
     },
     onSelectRow: function(rowid, status) {
     },
     ondblClickRow: function (rowid) {
     },
     onCellSelect : function(rowid, iCol, cellcontent, e){
         grid_onCellSelect(rowid, iCol, cellcontent, e)
     },
     loadComplete: function(data) {
     },
     //multiselect : true 시 헤더 체크박스를 눌렀을 경우 동작하는 함수
     onSelectAll: function(rowid,status){
     },
     loadError : function(xhr,st,err) {
       $("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
     }
 });

}


//메뉴 구분에 따라 col정보 설정.
function setGridInfoByMenu(){
     
	colNames = ["지역", "사업명", "사업의 유형", "평가단계", "최종평가결과코드", "최종평가결과", "평가일", "관광개발사업번호", "사업상태코드", "사업유형코드", "평가단계 코드"];
    colModel = [
                {name:'cityauthNm',     index:'cityauthNm' ,     width:120, editable:false, sortable:false, align:"center"},
                {name:'evaluBusiNm',     index:'evaluBusiNm',     width:210, editable:false, align:"left"},
                {name:'busiCateNm',     index:'busiCateNm',       width: 120, editable:false, align:"center"}, 
                {name:'evaluStageNm',    index:'evaluStageNm',    width: 90, editable:false, align:"center"},
                {name:'convFinalEvaluFnd',     index:'convFinalEvaluFnd',       width: 80, editable:false, hidden:true}, 
                {name:'convEvaluFndValue1',     index:'convEvaluFndValue1',       width: 80, editable:false, align:"center"},
                {name:'convEvaluDate',    index:'convEvaluDate',    width: 90, editable:false, align:"center"},
                {name:'evaluBusiNo',     index:'evaluBusiNo',     width: 50, editable:false, align:"right" , hidden:true},
                {name:'apprStat',     index:'appr_stat'   ,     width: 50, editable:false, align:"center", hidden:true},
                {name:'busiCateNm',     index:'busiCateNm'   ,     width: 50, editable:false, align:"center", hidden:true},
                {name:'evaluStage'  ,     index:'evalu_stage'   ,     width: 50, editable:false, align:"center", hidden:true},
                ];
    captionTitle = "평가대상 리스트";


}

////////////////////////////////////////////////////////////////////////////////
//그리드 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

//row 클릭 이벤트 함수
function grid_onCellSelect(rowid, iCol, cellcontent, e){
    var colModel = $(GRID_NAME).jqGrid('getGridParam', 'colModel'); // 컬럼명을 배열형태로 가져온다.  
    var colName = colModel[iCol]['name'];
    
    var rowdata = $(GRID_NAME).getRowData(rowid);
    var evaluBusiNo = rowdata.evaluBusiNo;
    var evaluStage = rowdata.evaluStage;
    var evaluUserId = $("#userId").val();
    // checkbox 이후 col을 클릭 했을 때 처리.
    if(iCol >= 2) {
        // 상세화면 이동.
        goView(evaluBusiNo, evaluStage, evaluUserId);
    }
}


// 평가 대상 화면으로 이동
function goView(evaluBusiNo, evaluStage, evaluUserId){
    
    BIZComm.submit({
        url : ROOT_PATH+ REGI_URL,
        userParam : {
            evaluBusiNo : evaluBusiNo,
            evaluStage : evaluStage,
            evaluUserId : evaluUserId
        }
    });
}

/*
// 그리등 paramter 구성.
function getSearchPostData(){
    var postData = {
            srchBusiAddr1  : $("#srchBusiAddr1" ).val(),
            srchBusiAddr2  : $("#srchBusiAddr2" ).val(),
            srchBusiType   : $("#srchBusiType"  ).val(),
            srchBusiCate   : $("#srchBusiCate"  ).val(),
            srchEvaluBusiNm : $("#srchEvaluBusiNm").val(),
            srchBusiStage : $("#srchBusiStage").val(),
            srchEvaluDate : $("#srchEvaluDate").val()
    }
    
    return postData;
}
*/



/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
   
    
}


//아이디 중복검사
function checkDuplUserId(){
    
    var userIdObj = $("#userId");
    var orgUserIdObj = $("#orgUserId");
    
    fn_checkUserIdDuplAjax();
}


//이메일 설정.
function fn_uscm_setFullDomain() {

	var email1Val = $("#email1").val();
    var email2Val = $("#email2").val();

    $("#email").val(email1Val + "@" + email2Val);
    
}

//휴대포 번호 설정.
function fn_uscm_setFullCellphoneNo() {
    var phoneNo1Val = $("#cellphoneNo1").val();
    var phoneNo1Va2 = $("#cellphoneNo2").val();
    var phoneNo1Va3 = $("#cellphoneNo3").val();

    $("#cellphoneNo").val(phoneNo1Val+"-"+phoneNo1Va2+"-"+phoneNo1Va3);
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
            addStahRow();
            break;
        case 'ctlBtnRemv':            //삭제
            removeStahRow();
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

function setFieldList(){
	var cultCheckboxes = document.getElementsByName('culture');
	var artCheckboxes = document.getElementsByName('art');
	var indstCheckboxes = document.getElementsByName('industry');
	var travCheckboxes = document.getElementsByName('travel');
	var etcCheckboxes = document.getElementsByName('etc');
	var fieldList = [cultCheckboxes, artCheckboxes, indstCheckboxes, travCheckboxes, etcCheckboxes];
	var fieldSelected = [];
	
	for(var i=0; i< fieldList.length; i++) {
		for (var j=0; j<fieldList[i].length; j++) {
			if(fieldList[i][j].checked) {
				fieldSelected.push(fieldList[i][j].value);
			}
		}
	}
	$("#fieldList").val(fieldSelected.toString());
	
}
////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

//저장처리
function doSave(){
    // 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    // 필드 
    setFieldList();
    // 정합성 검사.
    if(!doValidation()) return;
    
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
    	if(isConfirm){
            // submit
            BIZComm.submit({
                url    : ROOT_PATH + UPDATE_URL
            });
        
        	//goList();
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

    $("input:hidden[name=arrBusiPlyyDocuTypeYear]").each(function(){
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
    
    // 새로 추가된 row의 년도 콤보를 현재년도로 재구성
    BIZComm.loadEvaluYearCombo({
        combObj : rowObj.find("select[name=arrBusiPlyyDocuTypeYearTemp]"),
        stdNm   : "arrBusiPlyyDocuTypeYear"
    })
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
        if(chkObj.attr("_required") == "true"){
            if( !fn_checkRequired(chkObj) ) { isValid = false; return false; }
        }
        if(chkObjNm == "passwd") {
        	if(!fn_checkType(chkObj, chkObjNm)){isValid = false; return false; };
        }
        if(chkObjNm=="userId"){ 
        	if(!fn_checkType(chkObj, chkObjNm)){isValid = false; return false; };
        }
        if(chkObjNm=="cellphoneNo2"){ 
        	if(!fn_checkType(chkObj, chkObjNm)){isValid = false; return false; };
        }
        if(chkObjNm=="cellphoneNo3"){ 
        	if(!fn_checkType(chkObj, chkObjNm)){isValid = false; return false; };
        }
        if(chkObjNm == "email2") {
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
