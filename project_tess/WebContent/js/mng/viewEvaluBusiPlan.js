/**
 * 사업평가관리 평가계획 등록
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

var GRID_NAME       = "#grid";
var GRID_PAGER_NAME = "#pager";
var GRID_SEARCH_URL      = ROOT_PATH+"/evalu/getEvaluCommit.do" ;

var SEARCH_URL      = ROOT_PATH + "/evalu/getBusiEvaluItem.do" ;
var POPUP_URL 	   = ROOT_PATH+"/evalu/openSelEvaluCommit.do";
var SAVE_URL 	   = ROOT_PATH+"/evalu/saveEvaluStgMgmt.do";
var LIST_URL      = ROOT_PATH+"/mng/listEvaluBusiMgmt.do" ;
var REGI_URL      = ROOT_PATH+"/mng/regiEvaluCommit.do" ;
var DELT_URL      = ROOT_PATH+"/mng/deltEvaluCommit.do" ;
var VIEW_URL      = ROOT_PATH+"/mng/viewEvaluBusiPlan.do" ;
var UPDT_URL		= ROOT_PATH+"/mng/updtEvaluPlanState.do";

var PLAN_SAVE_URL	= ROOT_PATH+"/mng/getEvaluDetailPlan.do";
//var PLAN_DELT_URL	= ROOT_PATH+"/mng/deltEvaluDetailPlan.do";

var GUIDE_URL		= ROOT_PATH+"/mng/viewEvaluBusiGuide.do" ;
var HIST_URL 		= ROOT_PATH+"/mng/viewEvaluBusiHist.do" ;
var PLAN_URL		= ROOT_PATH+"/mng/viewEvaluBusiPlan.do" ;

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

$(function () {
    $('#datetimepicker_ds01_stt').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
    $('#datetimepicker_ds01_end').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
    $('#datetimepicker_ds02_stt').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
    $('#datetimepicker_ds02_end').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
    $('#datetimepicker_ds03_stt').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
    $('#datetimepicker_ds04_stt').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
    $('#datetimepicker_ds05_stt').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        showClose: true
        //defaultDate: new Date()
    });
});


/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
	loadCompProp();
	
    // 그리드 로드
    loadGrid();
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 지역1만 선택했을 때 지역2콤보가 0번째에 오도록 처리
    //  => 뒤로가기 눌렀을 때 지역 콤보가 초기화되는 문제해결을 위해 추가
    var srchBusiAddrVal = $("#srchBusiAddr2").val();
    if(isEmpty(srchBusiAddrVal)){
        srchBusiAddrVal = $("#srchBusiAddr1").val();
    }
    $("#srchBusiAddrVal").val(srchBusiAddrVal);
    
    
    
    // 지역 검색조건 combo loading
    loadBusiAddrCombo();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    //기능 버튼 클릭이벤트 연결
    bindFuncBtnEvent();
    
    //평가항목 별로 트리 조회
    bindChangevaluItemCombo();
    
    //트리 chage 이벤트 함수
    treeOptChg();
    
    $("#cityauth1").trigger("change");
    
}

////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////

//컴퍼넌트 속성 설정.(주로 maxlength 설정)
function loadCompProp(){
    
    BIZComm.setPropInObjectList(
        $("input:text:not(:hidden), textarea, select"),
        {
            "evaluItem"                  : {required:true},    					// 평가대상항목    
//            "evaluSttDate"               : {required:true},                     // 평가일  
            "evaluCommNm1"             : {required:true},    				// 평가위원1        
//            "evaluCommNm2"             : {required:true},             		// 평가위원2 
//            "evaluCommNm3"             : {required:true},             		// 평가위원3
            "evaluItemDiv"                 : {required:true},                  // 평가항목 tree
        }
    );
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////


//버튼 클릭 이벤트 처리
function onClickButton( id , targetId) {
    switch( id ) {
        case 'prcBtnSave':            //저장
            doSave();
            break;
        case 'prcBtnList':            //리스트
//          doReset();
            goList();
            break;
        case 'ctlBtnCommAdd':
        	addCommRow();
        	break;
        case 'ctlBtnCommDel':
        	delCommRow();
        	break;
        case 'selBtnCommit':             //평가위원 선택 팝업
        	newCommitPop(targetId);
            break;
        case 'prcBtnSrch':            // 검색
            doSearch();
            break;
        case 'prcBtnSect':            // 평가위원 선택
            goSelect();
            break;    
        case 'prcBtnCnle':            // 평가위원 선택 팝업 닫기
            goCancle();
            break;    
    }
}

//기능 버튼 클릭이벤트 연결
function bindFuncBtnEvent(){
    
    // ID가 'prcBtn'으로 시작하는 기능버튼에 클릭이벤트 연결.
    $("[id^=prcBtn]").click(function(){
    	
        onClickButton($(this).attr("id"))
    });
    $("[id^=ctlBtn]").click(function(){
    	
    	onClickButton($(this).attr("id"))
    });
    
    $("[id^=selBtn]").click(function(){
    	
    	var targetId= $(this).parent().parent().find("._objCommId").attr("id");
    	
    	onClickButton($(this).attr("id"), targetId)
    });
}

//평가항목 별로 트리 조회
function bindChangevaluItemCombo(){
	
	var evaluItemObj = $("#evaluItem");
	var evaluGubunObj = $("#evaluGubun");
	
	evaluItemObj.change(function(){
		if(evaluItemObj.val() == ""){
			alert("평가대상항목을 선택해 주세요.");
			return;
		}
		if(evaluGubunObj.val() == ""){
			alert("평가년도를 선택해 주세요.");
			return;
		}
		treeOptChg();
	});
	evaluGubunObj.change(function(){
		if(evaluItemObj.val() == ""){
			alert("평가대상항목을 선택해 주세요.");
			return;
		}
		if(evaluGubunObj.val() == ""){
			alert("평가년도를 선택해 주세요.");
			return;
		}
		treeOptChg();
	});
	
}

//트리 chage 이벤트 함수
function treeOptChg(){
	
	var evaluItemObj = $("#evaluItem");
	var evaluGubunObj = $("#evaluGubun");
	var divObj = $("#evaluItemDiv");
    
	var evaluItemVal = evaluItemObj.val();
	var evaluGubunVal = evaluGubunObj.val();
	
	params = {evalu_item: evaluItemVal, evaluGubun: evaluGubunVal};
	$.ajax({  
        url: SEARCH_URL,
        type: "POST",
        data:params, 
        dataType:"json", 
//	            contentType:"application/json; text/html; charset=utf-8",
        success:function(result) {
        	var reusltList = result.evaluItemCdComboList;
        	var parentCode;
        	var maxLen = reusltList.length;
        	
        	var arrIndi = $("#arrIndi").val();
        	
        	
        	//트리 만들기 시작
        	var liHtml = "<ul>"; 
        	
        	for ( var i in reusltList) {
        		
        		if((Number(i)+1) <reusltList.length){
            		var num = (Number(i)+1); 
            		var nextLvl = reusltList[num].lvl;
        		}
        		
        		var currLvl = reusltList[i].lvl;
        		var currOrd = reusltList[i].codeOrd;
        		var parentCode = reusltList[i].parentCode;
        		var evaluItemId = reusltList[i].code;

// 최종의견 조건때문에 수정        		
//        		var liClass;
//        		if(parentCode == 'EVALU_INPT' || parentCode == 'EVALU_FINL'){
//        			liClass = "level"+(currLvl+1);
//        		}else {
//        			liClass = "level"+ currLvl;
//        		}
 
        		var liClass;
        		if(parentCode == 'EVALU_DPTH'){
        			liClass = "level"+(currLvl+1);
        		}else {
        			liClass = "level"+ currLvl;
        		}        		
        		
        		//입력항목 트리에 체크
        		if(arrIndi.indexOf(evaluItemId) > -1	){
        			liClass = liClass + " jstree-checked";
        		}
        		
        		liHtml += "<li id='"+evaluItemId+"' class='"+ liClass +"'> <a href='#'>" + reusltList[i].codeNm  + "</a>";
        		
        		if(evaluItemObj.val() == "EVALU_INTR"){
        			
        			if(parentCode == 'EVALU_INPT'){ // || parentCode == 'EVALU_FINL'){ //최종의견 조건때문에 수정
        				if((currLvl == 2 && nextLvl == 1 )){
        					liHtml += "</li></ul></li>"
        				}else{
        					liHtml += "</li>";
        				}         
        				
        			}else {
        				if((currLvl == 3 && nextLvl == 2) || (currLvl == 4 && nextLvl == 3)){
        					liHtml += "</li></ul></li>";
        				}else if((currLvl == 3 && nextLvl == 1) || (currLvl == 4 && nextLvl == 2)){
        					liHtml += "</li></ul></li></ul></li>";
        				}else if((currLvl == 4 && nextLvl == 1)){
        					liHtml += "</li></ul></li></ul></li></ul></li>";
        				}else if((currLvl == 4)){
        					liHtml += "</li>";
        				}
        			}
        			
        		}else{
        			
        			if(parentCode == 'EVALU_INPT'){ // || parentCode == 'EVALU_FINL'){ //최종의견 조건때문에 수정
        				if((currLvl == 2 && nextLvl == 1 )){
        					liHtml += "</li></ul></li>"
        				}else{
        					liHtml += "</li>";
        				}         
        				
        			}else {
        				if((currLvl == 3 && nextLvl == 2) || (currLvl == 4 && nextLvl == 3)){
        					liHtml += "</li></ul></li>";
        				}else if((currLvl == 3 && nextLvl == 1) || (currLvl == 4 && nextLvl == 2) || (currLvl == 4 && nextLvl == 1)){
        					liHtml += "</li></ul></li></ul></li>";
        				}else if((currLvl == 4)){
        					liHtml += "</li>";
        				}
        			}
        			
        		}
        		
        		if((currLvl < nextLvl) &&  (nextLvl== 2 || nextLvl== 3 || nextLvl== 4)){
        			liHtml += "<ul>"
        		}
        		
			}
        	liHtml +="</ul>";
        	
        	$(divObj).html(liHtml);  
        	
        	//트리 load 함수
        	jsTreeInit();
        	
//        	 안되서 방식을 바꿈    	
//        	var arrIndi = $("#arrIndi").val();
//    	 
//	     	if(!isEmpty(arrIndi)){
//	     		
//	     		var arrStr = arrIndi.split(",");
//	     		
//	     		for ( var i in arrStr) { 
//	     			
//	     			$("#evaluItemDiv").jstree("is_selected", $("#"+arrStr[i]) );
//	     			$("#"+arrStr[i]).addClass("jstree-checked");
//	     		}
//	     	}
        }
        ,error:function(request, status, error) {
            alert("ERROR");
            alert(request.responseText);
        }
    });
}

//트리 load 함수
function jsTreeInit(){
	
	$("#evaluItemDiv").jstree({ 
		"plugins" : [ "themes", "html_data", "checkbox", "sort", "ui" ]
	});
	
	//트리 자동으로 펼쳐지게
	 $("#evaluItemDiv").bind("loaded.jstree", function(e, data){
		 data.inst.open_all();
	 })
	 
	 $("#evaluItemDiv").css("background-color", 'white');
	 
}

//평가위원 선택 팝업창
function newCommitPop(targetId){
	
	var winNm = "newCommit";
	$("#targetId").val(targetId);
	
	fn_search(1);
	
//    // 빈 popup열기
//    newWindow('', winNm, 650, 550, "auto");
//    
//    var form = $("#model");
//    var url = POPUP_URL;
//    
//    form.attr({
//    	"target" : winNm 
//       ,"method" :"post" 
//       ,"action" :ROOT_PATH + url 
//   });
//  form.submit(); 
    
}

//평가위원 row 추가 컨트롤함수
function addCommRow(){
    DYUtils.actionDyUnit({
        unitType   :"table",
        procType   :"add",
        dyAreaId   :"dyTblStah",
        afterAdd   :function (preRow, newRow){
            // row를 재 설정한다.
            resetCommRow(newRow);
        },
        // 파일 객체 change 이벤트
        changeFile : function(fileObj){
//            changeFile(fileObj);
        }
    }); 
}

//평가위원 row 삭제 컨트롤함수
function delCommRow(){
    DYUtils.actionDyUnit({
        unitType     : "table",
        procType     : "remove",
        dyAreaId     : "dyTblStah",
        stdDelRow : 6,
        beforeRemove : function (delRow){
        	
            // 삭제하는 파일 pk를 등록.
            var deltDatasObj = $("#deltEvaluCommId");
            var seqVal = delRow.find("input[name^=evaluCommId]").val();
            var pkDatasStr = deltDatasObj.val();
            if(!isEmpty(seqVal)){
                deltDatasObj.val( pkDatasStr + ( isEmpty(pkDatasStr)? "":"," ) + seqVal );
            }
            
            // row를 재 설정한다.
        	resetCommRow(delRow);
        },
        // 파일 객체 change 이벤트
        changeFile : function(fileObj){
//            changeFile(fileObj);
        },
        noCheckMsg   : MSG_EVALU_M005            //msg : "삭제대상을 선택하세요."
    });
}

function removeFileObj(){
	
}

function resetCommRow(newRow){
	var newRow = newRow;
	var commRowNm = newRow.find("._objCommNm").attr("name");
	
	var newCommRowNm = "evaluCommNm" + (parseInt( commRowNm.replace( /[^0-9]/g, '') )+1);
	var newCommRowId = "evaluCommId" + (parseInt( commRowNm.replace( /[^0-9]/g, '') )+1);
	
	newRow.find("._objCommNm").attr({"name" : newCommRowNm, "id": newCommRowNm });
	newRow.find("._objCommId").attr({"name" : newCommRowId, "id": newCommRowId });
	
	var tdRows = $("._commTr").find("td").length;
	
	$("._commTr").prev().find("th").prop("rowspan", tdRows+1);
	
	var newCommRowNm = ""+newCommRowNm+""; 
	
    BIZComm.setPropInObjectList(
            $("input:text:not(:hidden), textarea, select"),
            { 
            	newCommRowNm                : {required:true},    					//  추가 평가위원 필수체크
            }
    );
	
} 


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

//저장처리
function doSave(){
    
    // 파일첨부 submit 할지 여부.
    var isFileUpload = true;
    var paramevaluItem = "";
    var isValid = true;
    var evaluGubunVal = $("#evaluGubun").val();
    
    var evaluItem = $("#evaluItem").val();
    
    if(evaluGubunVal == "PREV"){
    	//2014년 이전
    	$("#"+evaluItem).find(".level3").each(function(){
    		if($("#evaluItemDiv").jstree("get_checked", this)){
    			if($(this).hasClass("jstree-undetermined") || $(this).hasClass("jstree-checked")){
    				var chkId = this.id; 
    				paramevaluItem += (paramevaluItem.length<1) ? chkId : ","+chkId;    		
    			}
    		};
    	});
    }else if(evaluGubunVal == "AFTER"){
    	//2015년 이후
    	$("#"+evaluItem).find(".level4").each(function(){
    		if($("#evaluItemDiv").jstree("is_checked", this)){
    			var chkId = this.id; 
    			paramevaluItem += (paramevaluItem.length<1) ? chkId : ","+chkId;    		
    		};
    	});
    }else{
    	//2016년
    	$("#"+evaluItem).find(".level3").each(function(){
    		if($("#evaluItemDiv").jstree("get_checked", this)){
    			if($(this).hasClass("jstree-undetermined") || $(this).hasClass("jstree-checked")){
    				var chkId = this.id; 
    				paramevaluItem += (paramevaluItem.length<1) ? chkId : ","+chkId;    		
    			}
    		};
    	});
    }
    
    $("#EVALU_INPT, #EVALU_FINL").find(".level2").each(function(){
    	if($("#evaluItemDiv").jstree("is_checked", this)){
        	var chkId = this.id; 
        	paramevaluItem += (paramevaluItem.length<1) ? chkId : ","+chkId;    		
    	};
    });
    
//    $("#evaluItemDiv").find(".level3").each(function(){ 	//level2단계인 데이터만 for문
//    	
//    	if($("#evaluItemDiv").jstree("is_checked", this)){		//check 되어있는지 확인
//        	var chkId = this.id; 
//        	paramevaluItem += (paramevaluItem.length<1) ? chkId : ","+chkId;
//    	}
//    });
    
//    if(paramevaluItem.indexOf("FN30", 0) < 0){
//        $("#FN30").find("li").each(function(){
//        	if($("#evaluItemDiv").jstree("is_checked", this)){		//check 되어있는지 확인
//            	paramevaluItem += ","+"FN30";
//            	return false;
//        	}
//        });
//    }
    
    
    // 저장시 정합성 검사.
    BIZComm.getCheckObjects($("#model")).each(function(){
    	
        var chkObj = $(this);
        var chkObjNm = chkObj.attr("name");
        var chkObjTitle = chkObj.attr("title");
        
        // 입력필수이 대상 검사.
        //  setPropInObjectList함수로 설정한 값 중에서 "required:true"로 설정한 대상.
        if(chkObj.attr("_required") == "true" && chkObj.attr("name").indexOf("arr") < 0){
            if( !fn_checkRequired(chkObj) ) { isValid = false; return false; }
        }
    });
    
	if(!isValid) {
		return;
	}else{
	    if(paramevaluItem.length<1){
	    	msgAlert('평가항목을 체크해주세요');
	    	return;
	    }else{
	    	$("#paramEvaluItem").val(paramevaluItem);
	    }
	}
	
	var tdRows = $("._commTr").find("td").length;
	
	var arrEvaluCommId = "";
	
	$("input[name^=evaluCommId]").each(function(){
		var evaluCommId = this.value;
		arrEvaluCommId += ( isEmpty(arrEvaluCommId)? "":"," ) + evaluCommId;
	});
	
	
	$("#regiEvaluCommId").val(arrEvaluCommId);
		
    // msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
        
        if(isConfirm){
            // submit
            BIZComm.submit({
                url    : ROOT_PATH + SAVE_URL,
            });
        }
    });
    
}

//목록으로 이동	신규 추가 2015.01.21 
function goList(){
    
    BIZComm.submit({
        url : ROOT_PATH + LIST_URL
    });
}


////////////////////////////////////////////////////////////////////////////////
//Grid 관련
////////////////////////////////////////////////////////////////////////////////

var colNames = null;
var colModel = null;
var captionTitle = "";
var params;

function loadGrid() {
	
 // 메뉴 구분에 따라 col정보 설정.
 setGridInfoByMenu();
 
 $(GRID_NAME).jqGrid({
     url          : GRID_SEARCH_URL,
     datatype     : 'json',
     mtype        : 'POST',
     caption      : captionTitle,
     colNames     : colNames,
     postData     : getSearchPostData(),
     colModel     :colModel,
     rowNum:10,
     rowList:[5,10,15],
     height: 276,
     rownumbers: true,
     rownumWidth:40,
     autowidth: true,
     pager: '#pager',
     //sortname: 'join_date',
     //sortorder: 'DESC',
     viewrecords : true,
     multiselect : true,
     multiboxonly: false,
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
     	params = fn_onSelectRow(rowid,status);
     },
     ondblClickRow: function (rowid) {
     },
     onCellSelect : function(rowid, iCol, cellcontent, e){
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
  
     colNames = ["평가위원명", "지역", "분야", "소속", "평가위원 아이디"];
     colModel = [
                 {name:'userNm',     index:'user_nm' ,     width:100, editable:false, sortable:false, align:"center"},
                 {name:'busiAddr12',     index:'evalu_busi_nm',     width:150, editable:false, align:"left"},
                 {name:'attach', index:'attach', width:150, editable:false, align:"center"},
                 {name:'occupa',     index:'occupa',       width: 120, editable:false, align:"center"}, 
                 {name:'userId',     index:'user_id',       width: 120, editable:false, align:"center", hidden:true}, 
                 ];
     captionTitle = "평가위원 리스트"; 

}

//그리등 paramter 구성.
function getSearchPostData(){
 var postData = {
         srchBusiAddr1  : $("#srchBusiAddr1" ).val(),
         srchBusiAddr2  : $("#srchBusiAddr2" ).val(),
         srchBusiType   : $("#srchBusiType"  ).val(),
         srchEvaluCommNm : $("#srchEvaluCommNm").val(),
 }
 
 return postData;
}

////////////////////////////////////////////////////////////////////////////////
//컴포넌트 구성 함수
////////////////////////////////////////////////////////////////////////////////



//지역 검색조건 combo loading
function loadBusiAddrCombo(){
  
  //시도 선택시 지자체(구군) 검색
  comutils.changeCityAuth({
      loading : true,
      citysido: "srchBusiAddr1Temp",
      cityauth: "srchBusiAddr2Temp",
      initcity: "srchBusiAddrVal",
      init    : function(){
          
          // hidden 검색조건에 동기화
          setSearchCond();
          
          var srchBusiAddrVal = $("#srchBusiAddr2").val();
          if(isEmpty(srchBusiAddrVal)){
              srchBusiAddrVal = $("#srchBusiAddr1").val();
          }

          if(!isEmpty(srchBusiAddrVal) && srchBusiAddrVal.substring(2,4) == "00"){
              $("#srchBusiAddr2Temp option:eq(1)").attr("selected", "selected");
              $("#srchBusiAddr2Temp").val("");
          }
          
      }
  });
}

//검색 수행
function doSearch(){
	
    //hidden 검색조건에 동기화
    setSearchCond();
    
    fn_search(1);
}

//hidden 검색조건에 동기화
function setSearchCond(){
    
    $("#srchBusiAddr1" ).val($("#srchBusiAddr1Temp" ).val());
    $("#srchBusiAddr2" ).val($("#srchBusiAddr2Temp" ).val());
    $("#srchBusiType"  ).val($("#srchBusiTypeTemp"  ).val());
    $("#srchEvaluCommNm").val($("#srchEvaluCommNmTemp").val());
    
    var srchBusiAddrVal = $("#srchBusiAddr2").val();
    if(isEmpty(srchBusiAddrVal)){
        srchBusiAddrVal = $("#srchBusiAddr1").val();
    }
    $("#srchBusiAddrVal").val(srchBusiAddrVal);
}

function fn_search(page) {
	
    var optionData = {
            postData:getSearchPostData(), 
         };
    
    if(page){
        optionData.page = page;
    }
    
    $(GRID_NAME).jqGrid( 'setGridParam'
            ,optionData
           ).trigger("reloadGrid");
}

//평가위원 선택
function goSelect(){
	
	var objParams = params;
	var objCommId = $("#targetId").val();
	var objCommNm = objCommId.replace("Id", "Nm");
	
	if(params != null){

		var flag =  objParams.flag;

		var rowData = params.rowdata;
		
		
		if(flag){
			nAlert("평가위원을 한명씩 선택해 주세요");
		    // REFRESH 처리
		    $(GRID_NAME).trigger('reloadGrid');
		    params = null;
		}else{
			
			var commitNm = rowData.userNm;
			var commitId = rowData.userId;
			
			var arrEvaluComm = "";
//			$(opener.document).find("._objCommId").each(function(){			popup에서 레이어 popup으로 변경으로 수정
			$("._objCommId").each(function(){
				var evaluComm  = this.value;
				if(!isEmpty(evaluComm)){
					arrEvaluComm +=(isEmpty(arrEvaluComm))? evaluComm : ","+evaluComm;
				}
			});
			
//			var arrEvaluComm = $(opener.document).find("#evaluCommId1").val()+","+$(opener.document).find("#evaluCommId2").val()+","+$(opener.document).find("#evaluCommId3").val();
			var isCnfm = false;
			
			if(arrEvaluComm.length < 1){
				arrEvaluComm = commitId;
				isCnfm = true;
			}else{
				
				if(arrEvaluComm.indexOf(commitId)<0){
					isCnfm = true;
				}else{
					nAlert("중복된 평가위원을 선택 할 수 없습니다.")
					isCnfm = false;
				    $(GRID_NAME).trigger('reloadGrid');
				    params = null;
				}
			}
			
			if(isCnfm){
				console.log(objCommId);
				console.log(objCommNm);
				console.log(commitNm);
				console.log(commitId);
//				$(opener.document).find("#"+objCommNm).val(commitNm);
//				$(opener.document).find("#"+objCommId).val(commitId);
//				$(opener.document).find("#arrEvaluComm").val(arrEvaluComm);
//				window.close();
				$("#"+objCommNm).val(commitNm);
				$("#"+objCommId).val(commitId);
				
				$("#prcBtnCnle").click();
				$("#myModal").bPopup().close();
			}
		}
	}else {
		nAlert("평가위원을 선택해 주세요");
	}
}

////////////////////////////////////////////////////////////////////////////////
//콘트롤 함수
////////////////////////////////////////////////////////////////////////////////

function fn_onSelectRow(rowid) {

	var flag = null;
	var arrData = new Array();
	var rowdata = null;

	//체크박스를 선택한 rowid를 구함
	var arrRowId = $(GRID_NAME).getGridParam('selarrrow');
	
	if(arrRowId.length==1){
		rowdata = $.jgrid.getRowExtData(GRID_NAME, arrRowId);
		params = {
				rowdata: rowdata,				//Rowdata
				flag: false		//1개 TRUE, 1개이상 FALSE
		    };
	}else if(arrRowId.length>1){
		params = {
				rowdata: rowdata,				//Rowdata
				flag: true		//1개 TRUE, 1개이상 FALSE
		    };
	}else{
		params = null;
	}

	return params;
}





function modal_open() {
	
	$("#myModal").bPopup({
		modalClose: false
	});
}

// 평가위원 저장
function commit_save(index) {
	
	var evaluBusiNo = $("#evaluBusiNo").val();
	var evaluStage = $("#evaluStage").val();
	var evaluGubun = $("#evaluGubun").val();
	var userId = $("#evaluCommId"+index).val();
	
	// msg : "저장하겠습니까?"
    nConfirm(MSG_EVALU_M008, null, function(isConfirm){
    	if(isConfirm){
    		
    		var params = {"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "userId" : userId};
			
			$.ajax({
		        url: REGI_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//			            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	//window.location.href = VIEW_URL;
		        	BIZComm.submit({
		                url : ROOT_PATH + VIEW_URL
		            });
		        }
			});
    	};
    });
}

//평가위원 삭제
function commit_delt(index) {
	
	var evaluBusiNo = $("#evaluBusiNo").val();
	var evaluStage = $("#evaluStage").val();
	var evaluGubun = $("#evaluGubun").val();
	var userId = $("#evaluCommId"+index).val();
	
	console.log(index);
	console.log(userId);
	
	// msg : "정말 삭제하겠습니까?"
    nConfirm("정말 삭제하시겠습니까?", null, function(isConfirm){
    	if(isConfirm){
    		
    		var params = {"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "userId" : userId};
			
			$.ajax({
		        url: DELT_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//			            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	//window.location.href = VIEW_URL;
		        	BIZComm.submit({
		                url : ROOT_PATH + VIEW_URL
		            });
		        }
			});
    	};
    });
}
    
    
    

function submission_btn(val) {
	
	var evaluBusiNo = $("#evaluBusiNo").val();
	var evaluStage = $("#evaluStage").val();
	var evaluGubun = $("#evaluGubun").val();
	
	if(val == "Y") {
		
			nConfirm("정말 제출 하시겠습니까?", null, function(isConfirm){
		    	if(isConfirm){
		    		var params = {"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "useYN" : val};
				
					$.ajax({
				        url: UPDT_URL,
				        type: "POST",
				        data:params, 
				        dataType:"json", 
		//			            contentType:"application/json; text/html; charset=utf-8",
				        success:function(result) {
				        	
				        	window.location.href = LIST_URL;
				        }
					});
			    }
			});
	} else {
		nConfirm("정말 제출 취소 하시겠습니까?", null, function(isConfirm){
	    	if(isConfirm){
	    		var params = {"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "useYN" : val};
	    		
	    		$.ajax({
			        url: UPDT_URL,
			        type: "POST",
			        data:params, 
			        dataType:"json", 
	//				            contentType:"application/json; text/html; charset=utf-8",
			        success:function(result) {
			        	
			        	window.location.href = LIST_URL;
			        }
				});
	    	}
		});
	}
}


function goCancle() {
	
	$("#myModal").bPopup().close();
}
    
//탭 함수
function goTab(page) {
	var evaluBusiNo = $("input[name=evaluBusiNo]").val();
	var evaluStage = $("input[name=evaluStage]").val();
	var evaluGubun = $("input[name=evaluGubun]").val();
	
	var page_url = "";
	
	if(page == "hist") {
		page_url = HIST_URL;
	} else if(page == "guide") {
		page_url = GUIDE_URL;
	} else if(page == "plan") {
		page_url = PLAN_URL;
	}
	
	BIZComm.submit({
        url: page_url,
        userParam: {
            evaluBusiNo: evaluBusiNo,
            evaluStage: evaluStage,
            evaluGubun: evaluGubun
        }
    });
}

//평가일정 저장
function savePlan() {
	
	var evaluBusiNo = $("#evaluBusiNo").val();
	var evaluStage = $("#evaluStage").val();
	var evaluGubun = $("#evaluGubun").val();
	var userId = $("#userId").val();
	
	var ds01_stt_date = $("#datetimepicker_ds01_stt input").val();
	var ds01_end_date = $("#datetimepicker_ds01_end input").val();
	var ds02_stt_date = $("#datetimepicker_ds02_stt input").val();
	var ds02_end_date = $("#datetimepicker_ds02_end input").val();
	var ds03_stt_date = $("#datetimepicker_ds03_stt input").val();
	var ds04_stt_date = $("#datetimepicker_ds04_stt input").val();
	var ds05_stt_date = $("#datetimepicker_ds05_stt input").val();
	
	console.log("ds01_stt_date : " + ds01_stt_date);
	console.log("ds01_end_date : " + ds01_end_date);
	
	if(ds01_stt_date != "" && ds01_end_date == "" || ds01_stt_date == "" && ds01_end_date != "") {
		jAlert("서면검토 일정을 설정해주세요.");
		return false;
	} else {
		if(Number(ds01_stt_date.replace(/-/gi, "")) > Number(ds01_end_date.replace(/-/gi, ""))) {
			jAlert("서면검토 일정을 다시 설정해주세요.");
			return false;
		}
	}
	if(ds02_stt_date != "" && ds02_end_date == "" || ds02_stt_date == "" && ds02_end_date != "") {
		jAlert("현장실사 일정을 설정해주세요.");
		return false;
	} else {
		if(Number(ds02_stt_date.replace(/-/gi, "")) > Number(ds02_end_date.replace(/-/gi, ""))) {
			jAlert("현장실사 일정을 다시 설정해주세요.");
			return false;
		}
	}
	
	var params = {"ds01_stt_date" : ds01_stt_date, "ds01_end_date" : ds01_end_date, "ds02_stt_date" : ds02_stt_date, "ds02_end_date" : ds02_end_date,
					"ds03_stt_date" : ds03_stt_date, "ds04_stt_date" : ds04_stt_date, "ds05_stt_date" : ds05_stt_date,
					"evaluBusiNo" : evaluBusiNo, "evaluStage" : evaluStage, "evaluGubun" : evaluGubun, "userId" : userId
				};
	
	nConfirm("저장 하시겠습니까?", null, function(isConfirm){
		if(isConfirm){
			$.ajax({
		        url: PLAN_SAVE_URL,
		        type: "POST",
		        data:params, 
		        dataType:"json", 
//					            contentType:"application/json; text/html; charset=utf-8",
		        success:function(result) {
		        	
		        	BIZComm.submit({
		                url: PLAN_URL,
		                userParam: {
		                    evaluBusiNo: evaluBusiNo,
		                    evaluStage: evaluStage,
		                    evaluGubun: evaluGubun
		                }
		            });
		        }
			});
		}
	});
};

// 일정 초기화
function planReset() {
	$("#datetimepicker_ds01_stt input").val("");
	$("#datetimepicker_ds01_end input").val("");
	$("#datetimepicker_ds02_stt input").val("");
	$("#datetimepicker_ds02_end input").val("");
	$("#datetimepicker_ds03_stt input").val("");
	$("#datetimepicker_ds04_stt input").val("");
	$("#datetimepicker_ds05_stt input").val("");
}