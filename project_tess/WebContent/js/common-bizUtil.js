var BIZComm = {
        
    //----------------------
    //공통 상수 
    //----------------------
    dfFormId     : "model",
        
    //----------------------
    //사업관리 부분 공통 함수
    //----------------------
    /**
     * 입력 검사항 대상 리스트 리턴
     * @param areaObj
     * @returns
     */
    getCheckObjects : function(areaObj) {
        return areaObj.find(":input:not(input:hidden):not(input:checkbox):not(input:file):not(:disabled)");
    },
    
    /**
     * submit
     * @param args
     */
    submit : function (args) {
        
        var url           = false; 
        var formId        = false; 
        var isFile        = false; 
        var method        = false; 
        var target        = false; 
        var submitType    = false; 
        var ajaxSuccessFn = false; 
        var ajaxErrorFn   = false; 
        var userParam     = false; 
        
        if(args != undefined && args != null) {
            url           = args.url;
            formId        = (args.formId)?          args.formId         : BIZComm.dfFormId;    // default: "model"
            isFile        = (args.isFile != null)? args.isFile         : false;
            method        = (args.method)?          args.method         : "post";
            target        = (args.target)?          args.target         : "_self";
            submitType    = (args.submitType)?      args.submitType     : "submit";     // ajax/?
            ajaxSuccessFn = (args.ajaxSuccessFn)?   args.ajaxSuccessFn  : "";
            ajaxErrorFn   = (args.ajaxErrorFn)?     args.ajaxErrorFn    : "";
            userParam     = (args.userParam)?       args.userParam      : false;
        }
        
        // isFile 항목이 true로 넘어오면 multipart 처리 함.
        var enctypeVal = (isFile)?      "multipart/form-data" : "application/x-www-form-urlencoded";
        
        if(!url) {
            alert("[BIZComm.submit] error : empty url!");
            return;
        }
        
        var formObj = $('#'+formId);
        if(formObj.length == 1) {
            
            // upser param을 구성한다.
            // 기존 여러개 존재하는 항목을 설정했으면 오류 처리함.
            var isValidUserParam = BIZComm.dyInsertUserParam(formObj, userParam);
            if(!isValidUserParam) return;
            
            // form 객체 속성 설정.ㅣ
            formObj.attr({
                action  : url,
                method  : method,
                target  : target,
                enctype : enctypeVal});
            
            // submit 처리.
            if(submitType == 'submit') {
                formObj.submit();
            }
            // ajax 일 경우 submit (미완성 부분, 한번소 사용하지 않았음)
            else if(submitType == 'ajax') {
                formObj.ajaxForm({
                    dataType : 'json',
                    success:function(data){
                        var successFnObj = BIZComm.getFuncObj(ajaxSuccessFn);
                        if(successFnObj != null) {
                            successFnObj(formObj, data);
                        }
                    },
                    error : function() {
                        var errorFnObj = BIZComm.getFuncObj(ajaxErrorFn);
                        if(errorFnObj != null) {
                            errorFnObj();
                        }
                    },
                    uploadProgress: function (event, position, total, percentComplete) {
                    },
                    beforeSend: function () {
                    },
                    statusCode: {           
                        400: function() {
                          alert("파일 내용이 잘못되었습니다.");
                        },            
                        500: function() {
                          alert("파일을 업로드할 수 없습니다.");
                        }
                    }
                });
            }
        }
        else{
            alert("[BIZComm.submit] error form object");
        }
    },
    /**
     * form 객체를 새로 생성하여 userParam으로 받은 객체들을 param으로 처리할 수 있게 하는 함수.
     *   -> 화면 이동시 mode등을 main form을 변경해서 submit하면 back했을 때 문제 발생 소지있기 때문에 사용.
     * @param args
     */
    dySubmit : function(args) {
        
        var dyFormNm  = "__dyForm_";
        
        // 임시로 만들어진 form을 제거 한다.
        $("#"+dyFormNm).remove();
        
        // 임시 form 객체 생성. 
        // 브르우저별로 반응
        $("body").after("<div style='width:0px,height:0px;'><form name='"+dyFormNm+"' id='"+dyFormNm+"'></form></div>");
        
        // formId 설정.
        args.formId = dyFormNm;
        // submit 처리
        BIZComm.submit( args );
    },
    /**
     * 새로 정의된 parameter를 hidden 객체로 구성.
     * @param formObj
     * @param userParam
     */
    dyInsertUserParam : function(tagObj, userParam){
        
        if(tagObj && userParam) {
            
            // 해당 tag 객체 내에 child가 없으면 임시로 span를 삽입
            if(tagObj.find(":first-child").length == 0){
                tagObj.html("<span></span>");
            }
            // hidden tag로 삽입.
            for (var prm in userParam) {
                var inputObj = tagObj.find(":input[name="+prm+"]");
                // 이미 객체가 존재하면 해당 값으로 변경.
                if(inputObj.length == 1) {
//                    inputObj.remove(); //제거
                    inputObj.val(userParam[prm]);
                }
                else if(inputObj.length > 1) {
                    alert( "[ERROR-BIZComm.dyInsertUserParam] '"+prm+"' 항목이 여러개 존재합니다. 확인바랍니다.");
                    return false;
                }
                else{
                    tagObj.find(":first-child").before("<input type='hidden' name='"+prm+"' value='"+userParam[prm]+"'/>");
                }
            }
        }
        
        return true;
    },
 
    /**
     * 함수명으로 함수 객체 return
     * @param funcNm
     * @returns
     */
    getFuncObj : function (funcNm) {
        var funcObj = null;
        if(funcNm != undefined && funcNm != null && funcNm.length > 0) {
            
            if( typeof funcNm == "string"){
                funcObj = eval(funcNm);
            }
            else if( typeof funcNm == "function"){
                funcObj = funcNm;
            }
            
            return funcObj;
        }
    },
    rtnMsg : function() {
        if (PROC_FLAG != "" && PROC_FLAG != null && PROC_FLAG != "null")  {
            msgAlert(PROC_FLAG);
        }
    },
    
    //===========================================
    // 입력 객체 속성 설정 : validation 관련
    //===========================================
    
    // object 리스트의 객체들의 속성설정.
    setPropInObjectList : function(objList, objProps){
        
        if(objList && objProps) {
            
            objList.each(function(){
                
                var obj     = $(this);
                var objName = obj.attr("name");
                
                if(objProps[objName]){
                    BIZComm.setObjectProp(obj, objProps[objName]);
                }
            });
        }
        
    },
    // 해당 객체의 속성을 설정.
    setObjectProp : function (obj, args){
        
        var requiredMark = true;
        
        if(obj && args){
            
            requiredMark = (args.requiredMark != null )? args.requiredMark : true;
            
            //-----------------------
            // maxlength 속성 설정 
            //   input:text 경우 : maxlength 속성으로 설정.
            //   textarea   경우 : toByteLimitField 이벤트 설정.
            //-----------------------
            if(args.maxlength){
                // input객체이면 maxlength 속성을 설정.
                if(obj.prop("tagName") == "INPUT") {
                    var intMaxLen = parseInt(args.maxlength)/2;
                    obj.attr("maxlength", intMaxLen+"");
                }
                // textarea이면 toByteLimitField 설정.
                else if(obj.prop("tagName") == "TEXTAREA"){
                    obj.toByteLimitField({limit:args.maxlength});
                }
            }
            
            //-----------------------
            // 입력 필수(required) 설정
            //    "_required" attribute를 표시
            //    title에 입력필수 표시.
            //-----------------------
            if(args.required){
                
                if(requiredMark) {
                    
                    var titleObj = null;
                    
                    var prevObj = obj.parents("td").prev();
                    // 입력 table 형태 일 때 : 입력항목의 title이 바로 앞에 <th>태그로 구성된 형태
                    if(prevObj.prop("tagName") == "TH"){
                        titleObj = prevObj;
                    }
                    // 리스트형 table일 때 (title이 최 상단의 row한 줄에 <th>형태로 구성)
                    else {
                        var tdIndex = obj.parents("tr").find("td").index(obj.parents("td"));
                        titleObj    = obj.parents("table").find("thead tr:first th:eq('"+tdIndex+"')");
                    }
                    
                    // 입력필수항목 mark 표시.
                    if(titleObj) {
                        titleObj.find("._reqedChk").remove();
                        titleObj.html(titleObj.html() + " <span class='_reqedChk' style='font-weight:bold; color:red;'>*</span>");
                    }
                }
                // 해당 객체에 입력필수 라고 표시.
                obj.attr("_required", "true");
            }
        }
    },
    
    //===========================================
    // 년도 달력 관련
    //===========================================
    
    /**
     * 년도 콤보 설정 함수
     *   - 선택하는 년도에 따라 combo 내용이 변경됨. (이전 10년 이후 10년 : scaleNum 기준으로..)
     */
    loadEvaluYearCombo : function (args) {
        
        var combObj    = false;
        var stdNm      = false;
        var scaleNum   = false;    // 기준 년도기준으로 이전 년도 이후년도 얼마나할 지 입력
        var isEmptyOpt = false;    // 빈값의 option 존재 여부 (default : true)
        
        if(args != undefined && args != null) {
            combObj    = (args.combObj)?    args.combObj    : false;
            stdNm      = (args.stdNm)?      args.stdNm      : false;
            scaleNum   = (args.scaleNum)?   args.scaleNum   : 7;
            isEmptyOpt = (args.isEmptyOpt != undefined && args.isEmptyOpt != null)? args.isEmptyOpt : true;
        }
        
        if(combObj){
            
            var itemObj = combObj.parents("tr").find("input[name="+stdNm+"]");
            
            var yearArr = [];
            var curDate = new Date();
            
            // 기준 년도 : 기준 객체가 빈값이면 현재년도 있으면 해당 년도 기준.
            var stdYear = (isEmpty(itemObj.val()))? curDate.getFullYear() : itemObj.val();
            stdYear     = parseInt(stdYear);
            
            // 배열 구성.
            for(var i=(stdYear-scaleNum);i<=(stdYear+scaleNum);i++) {
                yearArr.push({code:i, codeNm:i});
            }
            
            // 콤보 구성.
            combObj.emptySelect();
            combObj.loadSelect(yearArr);
            if(!isEmptyOpt){
                // 최초의 empty option을 제거한다.
                //combObj.find("option:eq(0)").remove();
                combObj.find(":first-child").remove();
            }
            
            // 기본값 설정.
            combObj.val(itemObj.val());
            
            // change 이벤트 설정.
            combObj.unbind("change");
            combObj.bind({
                change : function() {
                    
                    itemObj.val($(this).val());
                    BIZComm.loadEvaluYearCombo({
                        combObj    :$(this),
                        stdNm      : stdNm,
                        isEmptyOpt : isEmptyOpt
                    });
                    $(this).val(itemObj.val());
                }
            })
        }
    },
    
    //===========================================
    // 이미지 팝업 관련
    //===========================================
    
    /**
     * jqueryUI의 dialog 위젯을 이용하여 이미지뷰어용 레이어팝업을 여는 함수
     */
    openImageDialog : function( args ){
        
        var imgSrc     = false;     // image 소스 path
        var maxWidth   = false;     // 이미지 보여주는 최대 가로 크기
        var maxHeight  = false;     // 이미지 보여주는 최대 세로 크기
        var title      = false;     // 레이어 dialog의 title 설정
        var clickImgFn = false;     // 레이어 이미지를 클릭했을 때 처리할 이벤트 
        var rtn        = true;
        
        if(args != undefined && args != null) {
            
            imgSrc     = (args.imgSrc)?     args.imgSrc     : false;
            maxWidth   = (args.maxWidth)?   args.maxWidth   : 1000;
            maxHeight  = (args.maxHeight)?  args.maxHeight  : 800;
            title      = (args.title)?      args.title      : "이미지 보기";
            clickImgFn = (args.clickImgFn)? args.clickImgFn : false;
            
            
            if(imgSrc) {
                
                // 기존 이미지 dialog 레이어 객체를 제거함.
                $("#imgView-dialog").remove();
                // 신규 이미지 dialog 레이어 객체 추가.
                $("body").after("<div id='imgView-dialog' title='"+title+"'></div>");
                
                // 삽입할 이미지 태그 설정.
                var imgHtmlStr = "<img src='"+imgSrc+"' style='max-width:"+maxWidth+"px;max-height:"+maxHeight+"px'/>";
                
                // dialog객체에 이미지 태그 삽입
                $("#imgView-dialog").html(imgHtmlStr);
                
                $("#imgView-dialog").dialog({
                    modal     : true,   // 모달로 설정
                    draggable : false,  // draggable설정하면 문제있음.
                    resizable : false,  // 사이즈 조정 못하게 설정.
                    width     : "*",    // 자동설정
                    show      :{
                        effect : "fade",
                        duration : 500
                    },
                    hide      :{
                        effect : "fade",
                        duration : 500
                    }
                });
                
                // 팝업에서 이미지 클릭 이벤트 수행.
                if(clickImgFn){
                    var dialogImgObj = $("#imgView-dialog img");    // dialog의 이미지 객체 전달
                    var dialogObj    = $("#imgView-dialog");        // dialog의 div 객체 전달.
                    dialogImgObj.css({cursor:"pointer"})            // 이미지 클릭이벤트가 설정되어 있으면 마우스 over시 손보양으로 표현 
                    .click(function(){                  // 클릭이벤트 연결
                        clickImgFn(dialogObj, dialogImgObj);
                    });
                }
            }   // end of 'if(imgSrc) {'
            else {
                // 이미지 연결에 오류가 있을 때 false;
                rtn = false;
            }
            return rtn;
            
        }
        
        
    },
    //===========================================
    // 입력 form action 이벤트 관련
    //===========================================
    
    /**
     * 다수의 숫자 입력 form들에서 숫자를입력하면 대상 객체에 sum을 적용하는 event 연결
     */
    bindSumInputFormEvent : function (args) {
        
        var selType      = false;   // jquery 셀렉터 - 해당 name이 어떻게 적용되는지 filtering (없음:같다, *:포함, ^:시작, $:끝)
        var sumObjNm     = false;   // 합계가 표시될 object 명 (selType 적용됨)
        var inputObjsNms = false;   // 합계할 대상 object 명을 ','로 연결한 문자열 (selType 적용됨)
        var areaObj      = false;   // 합계에 포함되는 모든 object를 포함하는 영역 object 객체
        var tagtAttr     = false;   // 대상 attribute : 기본이 name이고 선택할 수 있음.
        var afterSumFn   = false;
        
        selType      = (args.selType)?      args.selType      : "";
        sumObjNm     = (args.sumObjNm)?     args.sumObjNm     : "";
        inputObjsNms = (args.inputObjsNms)? args.inputObjsNms : "";
        areaObj      = (args.areaObj)?      args.areaObj      : null;
        tagtAttr     = (args.tagtAttr)?     args.tagtAttr     : "name";
        afterSumFn   = (args.afterSumFn)?   args.afterSumFn   : false;
        
        if(args == undefined || args == null) {
            alert("[ERROR-sumInputForms] : argument 오류");
            return;
        }
        if(areaObj == null || areaObj.length == 0) {
            alert("[ERROR-sumInputForms] : 대상을 포함하는 영역 오류");
            return;
        }
        
        // 합계 결과가 표시될 object
        var sumObj = areaObj.find("input["+tagtAttr+selType+"="+sumObjNm+"]");
        if(isEmpty(sumObj.val()))
            sumObj.val("0");
        
        // 합계 대상 object명 배열변환
        var inputObjsNmArr = inputObjsNms.split(",");
        
        // 합계 대상 object명 배열 기준으로 loop를 수행하여 각 객체에 keyup 이벤트 적용.
        for(var i=0;i<inputObjsNmArr.length;i++){
            
            var evtTargetObj = areaObj.find("input["+tagtAttr+selType+"="+inputObjsNmArr[i]+"]");
            evtTargetObj.unbind("keyup");
            evtTargetObj.bind({
                
                keyup : function(){
                    
                    var sumVal = 0;
                    // 대상 객체들의 값을 읽어서 합계를 냄 
                    for(var j=0;j<inputObjsNmArr.length;j++){
                        // getFloat() : common.js 에 포함.
                        sumVal += areaObj.find("input["+tagtAttr+selType+"="+inputObjsNmArr[j]+"]").getFloat();
                    }
                    // 합계 객체에 표시.
                    sumObj.val(sumVal);
                    sumObj.trigger("keyup");    // setMask를 적용시키기 위해서 강제로 이벤트 수행.(하지 않으면 숫자 format가 적용되지 않음)
                    
                    // 합계처리 후 수행하는 함수
                    if(afterSumFn){
                        var fnObj = BIZComm.getFuncObj(afterSumFn);
                        if(fnObj != null){
                            fnObj(sumObj, sumVal);
                        }
                    }
                }
            });
            
            // 이벤트를 걸고나서 keyup을 강제로 발생해서 합계 계산을 한번 수행하게 처리.
            evtTargetObj.trigger("keyup");
        }
    },
    
  //테이블 ROW 합치는 함수
   tableRowSpanning: function(arg) {
	   
	    var tableObj = arg.table;
	    var rowIdxObj = arg.spanning_row_index;
	    var attrTagObj = arg.attrTag;
	    var repTxtObj = arg.repTxt;	
	    
        var RowspanTd = false;
        var RowspanText = false;
        var RowspanCount = 0;
        var Rows = $('tr', tableObj);

        $.each(Rows, function () {
            var This = $(attrTagObj, this)[rowIdxObj];
            var text = $(This).text();
     
            if (RowspanTd == false) {
                RowspanTd = This;
                RowspanText = text;
                RowspanCount = 1;
            }
            else if (RowspanText != text) {
                $(RowspanTd).attr('rowSpan', RowspanCount);
                if(RowspanCount > 1){
                	if(!isEmpty(repTxtObj))
                		$(RowspanTd).text(repTxtObj);
                }

                RowspanTd = This;
                RowspanText = text;
                RowspanCount = 1;
            	
            }
            else {
                $(This).remove();
                RowspanCount++;
            }
        });
         

        // 반복 종료 후 마지막 rowspan 적용
        if(RowspanCount > 1){
            $(RowspanTd).attr('rowSpan', RowspanCount);
            $(RowspanTd).text(repTxtObj);
        }
    }
    
}