////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////

/**
 * 페이지 속성 상수.
 */
var PageConsts = {
    mode         : false,
};

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////


$(function() {
	
    // 화면 기본 설정값 loading
    EVALUComm.loadPage({
        mode        : $("#mode").val(),
    });
    
    //+++++++++++++++++++++++++++++++
    // 화면 구성.
    //+++++++++++++++++++++++++++++++
    
    //+++++++++++++++++++++++++++++++
    // 각 페이지의 loading 함수 수행
    //+++++++++++++++++++++++++++++++
    
    // 각 페이지에서 loadInitPage 함수를 자동 수행 한다.
    if( BIZComm.getFuncObj("loadInitPage") != null ){
        loadInitPage();
    }
    
    //+++++++++++++++++++++++++++++++
    // 공통 스타일 
    //+++++++++++++++++++++++++++++++
    
    // 초기 공통 스타일 설정.
    fn_initTode_Style();
    
    // 리턴 메시지 처리. (in common.js)
    BIZComm.rtnMsg();
    
});

// 스타일 설정 함수
function fn_initTode_Style(){
    
    // 숫자 항목 서정
    $(":input._number").css({
                        "text-align" : "right"
                    }).toNumberField();
    $("span._number").css({
                        "display": "inline-block",
                        "width"  : "100%",
                        "text-align" : "right"
                    });
    
    // 숫자 항목 서정
    $(":input._float").css({
                        "text-align" : "right"
                    }).toFloatField();
    $("span._float").css({
                        "display": "inline-block",
                        "width"  : "100%",
                        "text-align" : "right"
                    });
    
    // 비활성화 객체(disabled,readonly) 스타일 적용.
    $(":input:disabled,:input:not(:not([readonly]))").css({
        "background":"#f6f6f6"
    });
    
    // 기능버튼과 컨트롤 버튼의 링크 속성 변경.
    $("[id^=prcBtn], [id^=ctlBtn], ._dyFileBtnAddCls, ._dyFileBtnRemvCls").find("a").attr("href", "javascript:");
}

////////////////////////////////////////////////////////////////////////////////
// 비지니스 로직 관련 유틸.
////////////////////////////////////////////////////////////////////////////////

var EVALUComm = {
        
    //----------------------
    //사업관리 공통 상수 관리
    //----------------------
    mode : {
        view    : "view",
        regi    : "regi",
        updt    : "updt",
        delt    : "delt",
    },
    stat : {
        success : "success",
        failure : "failure"
    },
        
    /**
     * Page load할때 상수 설정
     * @param args
     */
    loadPage : function ( args ) {
        
        for (var p in args) {
            PageConsts[p] = args[p];
        }
    },
    
    //===========================================
    // 이벤트 연결 공통 함수
    //===========================================
    
    //사업의 구분 콤보 change 이벤트 연결.
    //  - [사업의 구분]을 변경하면 [사업의 유형] 항목 콤보가 새로 구성되게 하는 이벤트
    bindChangeBusiType : function(args){
        
        var busiTypeId = false;
        var busiCateId = false;
        
        if(args != undefined && args != null && args != "") {
            busiTypeId = (args.busiTypeId)? args.busiTypeId : false;
            busiCateId = (args.busiCateId)? args.busiCateId : false;
        }
        
        if(busiTypeId && busiCateId){
            
            var busiTypeObj = $("#"+busiTypeId);   // 사업의 구분
            var busiCateObj = $("#"+busiCateId);   // 사업의 유형
            
            if(busiTypeObj.size() > 0){
                
                busiTypeObj.change(function(){
                    
                    busiCateObj.emptySelect();
                    
                    if(!isEmpty(busiTypeObj.val())) {
                        bizutils.findCode({
                            params: {parentCode:busiTypeObj.val()},
                            fn    : function(result){
                                
                                // '세부시설 유형' 콤보 구성.
                                if(result != null && busiCateObj.size() == 1) {
                                    busiCateObj.loadSelect(result);
                                }
                            }
                        });
                    }
                });
            }
            
        }// end of if
        
    }
    ,
    
bindChangeFieldType : function(args){
        
        var fieldTypeId = false;
        var fieldDetailId = false;
        
        if(args != undefined && args != null && args != "") {
        	fieldTypeId = (args.fieldTypeId)? args.fieldTypeId : false;
        	fieldDetailId = (args.fieldDetailId)? args.fieldDetailId : false;
        }
        
        if(fieldTypeId && fieldDetailId){
            
            var fieldTypeObj = $("#"+fieldTypeId);   // 필드 구분
            var fieldDetailObj = $("#"+fieldDetailId);   // 세부 필드
            
            if(fieldTypeObj.size() > 0){
                
            	fieldTypeObj.change(function(){
                    
            		fieldDetailObj.emptySelect();
                    
                    if(!isEmpty(fieldTypeObj.val())) {
                        bizutils.findCode({
                            params: {parentCode:fieldTypeObj.val()},
                            fn    : function(result){
                                
                                // '세부 분야' 콤보 구성.
                                if(result != null && fieldDetailObj.size() == 1) {
                                	fieldDetailObj.loadSelect(result);
                                }
                            }
                        });
                    }
                });
            }
            
        }// end of if
    }
    
    ,
    //===========================================
    // 파일관련
    //===========================================
    
    /**
     * form 객체내의 file 객체들의 속성에 필요한 작업 수행
     *  - file-name을 upfile0,1,3,... 으로 일괄 변경.
     *  - docuType과 atthType 속성을 위한 hidden 객체를 생성.
     * @param formObj
     */
    buildUpfilePropObjs : function (formObj){
        
        // file 객체 명 일괄 변경 및 필요한 파일정보 parameter 신규 생성.
        var fileIdx = 0;
        formObj.find("input:file").each(function(){
            
            var fileObj = $(this);
            
            //-------------------------
            // file 객체 name 항목 변경.
            //-------------------------
            fileObj.attr("name", "upfile"+fileIdx);
            fileIdx++;
            
            //-------------------------
            // file의 속성 추가 처리.
            //-------------------------
            var docuTypeVal = fileObj.attr("_docuType");
            var atthTypeVAl = fileObj.attr("_atthType");
            
            // 추가된 속성 객체가 존재하면 먼저 제거함.
            fileObj.parent().find("._fileTmpProp").remove();
            // 속성 객체 추가.
            fileObj.after("<input type='hidden' name='arrFileDocuType' value='"+docuTypeVal+"' class='_fileTmpProp'/>");
            fileObj.after("<input type='hidden' name='arrFileAtthType' value='"+atthTypeVAl+"' class='_fileTmpProp'/>");
        })
    },
    /**
     * 첨부파일의 정합성 검사.
     * @param fileObj
     * @returns {Boolean}
     */
    validFileObj : function (fileObj, allowedExts, imgAllowedExts){

        var isValid = true;
        var fullFileNm = fileObj.val();
        var docuType   = fileObj.attr("_docuType");
        
        // 허용된 첨부파일 확장자
        var allowedFileExts = null;
        if("AREA" == docuType) {
            // 사업대상지 정보는 이미지 파일만 가능
            allowedFileExts = imgAllowedExts;
            if(imgAllowedExts == undefined || isEmpty(imgAllowedExts)){
                allowedFileExts = "jpg, png, gif, bmp";
            }
        }
        else{
            allowedFileExts = allowedExts;
            if(allowedExts == undefined || isEmpty(allowedExts)){
                allowedFileExts = "doc, docx, xls, xlsx, ppt, pptx, pdf, jpg, jpeg, png, gif, bmp, txt, zip, rar, gz";
            }
        }

        // 허용된 파일 타입 (_ALLOWED_FILE_EXTS : jsp에 정의)
        if(isAtthAllowedFileType(fullFileNm, allowedFileExts) == false){
            // msg : "첨부한 파일이 허용된 파일 유형이 아닙니다."
            msgAlert(MSG_TODE_M014);
            isValid = false;
        }

        return isValid ;
    },
    /**
     * 관광계발사업(TODE) 파일 다운로드
     * @param todeFileNo
     */
    fileDownload : function(todeFileNo){
        BIZComm.dySubmit({
            url       : ROOT_PATH+"/tode/todeFileDownload.do",
            userParam : {todeFileNo : todeFileNo}
        });
    },
    
    
    //===========================================
    // 파일관련(단일)
    //===========================================
    
    /**
     * form 객체내의 file 객체들의 속성에 필요한 작업 수행
     *  - file-name을 upfile0,1,3,... 으로 일괄 변경.
     *  - docuType과 atthType 속성을 위한 hidden 객체를 생성.
     * @param formObj
     */
    buildUpfilePropObjs02 : function (type){
        
        // file 객체 명 일괄 변경 및 필요한 파일정보 parameter 신규 생성.
        var fileIdx = 0;
            
        var fileObj = $("#" + type);
        
        //-------------------------
        // file 객체 name 항목 변경.
        //-------------------------
        fileObj.attr("name", "upfile"+fileIdx);
        fileIdx++;
        
        //-------------------------
        // file의 속성 추가 처리.
        //-------------------------
        var docuTypeVal = fileObj.attr("_docuType");
        var atthTypeVAl = fileObj.attr("_atthType");
        
        // 추가된 속성 객체가 존재하면 먼저 제거함.
        fileObj.parent().find("._fileTmpProp").remove();
        // 속성 객체 추가.
        fileObj.after("<input type='hidden' name='arrFileDocuType' value='"+docuTypeVal+"' class='_fileTmpProp'/>");
        fileObj.after("<input type='hidden' name='arrFileAtthType' value='"+atthTypeVAl+"' class='_fileTmpProp'/>");
    }
}

