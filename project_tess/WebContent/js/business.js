//*****************************************************************************
// 2013.10.11 업무 공통 함수 정의
//   ex) 팝업 호출 함수, 코드 AJAX 함수 등
//
//*****************************************************************************

var comutils = {}; //공통유틸
var bizutils = {}; //업무용

//시도 선택시 지자체 검색 및 설정
comutils.changeCityAuth = function( args ) {

    if (!args) {
        alert('[comutils.changeCityAuth] : 함수인자가 정의되지 않았습니다.');
        return;
    }
    if (!args.citysido) {
        alert('[comutils.changeCityAuth] : 시도선택 콤보박스(citysido) ID는 필수입니다.');
        return;
    }
    if (!args.cityauth) {
        alert('[comutils.changeCityAuth] : 구군선택 콤보박스(cityauth) ID는 필수입니다.');
        return;
    }
    var loading = args.loading;//초기로딩여부
    var sidoid = args.citysido;
    var authid = args.cityauth;
    var initid = args.initcity;//지자체 최초 선택값 ID
	var initid2 = args.initcity2;
    var initfn = args.init;    //지자체 최초 선택시 실행함수
    var prntCd = "COMM.CITYAUTH";

    var sidoObj = $("#"+sidoid);
    var cityObj = $("#"+authid);

    //시도 초기선택값
    var initSidoVal = false;
    var initObj = false;
    var initVal = false;

    //시도 있을 경우
    if (!isEmpty(sidoObj.val())) {
        initSidoVal = sidoObj.val();
    }

    if (initid) {
        initObj = $("#"+initid);
        initVal = initObj.val();
        if (!isEmpty(initVal)) {
            initSidoVal = (initSidoVal ? initSidoVal : initVal.substring(0,2)+"00");
        }
    }
    
    //초기 로딩시
    if (loading) {
        //공통코드 AJAX
        bizutils.findCode({
            params: {parentCode:prntCd},
            fn: function(result) {
                if (result != null) {
                    sidoObj.loadSelect(result);

                    if (initSidoVal) {
                        sidoObj.val(initSidoVal);
                        sidoObj.trigger('change');
                        initSidoVal = false;
                    }
					

                }
            }
        });
    }

    //시도 선택시 지자체 검색
    sidoObj.change(function() {
        var sidoVal = $(this).val();
        cityObj.emptySelect();

        if (!isEmpty(sidoVal)){
            //공통코드 AJAX
            bizutils.findCode({
                params: {parentCode:prntCd, addCol1: sidoVal},
                fn: function(result) {
                    if(result != null) {
                        cityObj.loadSelect(result);
						
						if (initid) {
                            if (!isEmpty($("#"+initid).val())) {
                                cityObj.val($("#"+initid).val());
                                $("#"+initid).val("");
                            }
                        }
                        if (initfn)
                            initfn();
                    }
                }
            });
        }
    });
    //시도 있을 경우
    if (!isEmpty(sidoObj.val())) {
        sidoObj.trigger('change');
    }
};

// 2023.11.07 LHB 시도/시군구 셀렉트 박스 함수 (법정동 코드)
comutils.changeCityBjd = function( args ) {

    if (!args) {
        alert('[comutils.changeCityBjd] : 함수인자가 정의되지 않았습니다.');
        return;
    }
    if (!args.citysido) {
        alert('[comutils.changeCityBjd] : 시도선택 콤보박스(citysido) ID는 필수입니다.');
        return;
    }
    if (!args.cityauth) {
        alert('[comutils.changeCityBjd] : 구군선택 콤보박스(cityauth) ID는 필수입니다.');
        return;
    }
    var loading = args.loading;//초기로딩여부
    var sidoid = args.citysido;
    var authid = args.cityauth;
	var sidoidorg = args.citySidoI;	// INPUT에 담긴 기본값
	var authidorg = args.cityAuthI;	// INPUT에 담긴 기본값

    var initid = args.initcity;//지자체 최초 선택값 ID
    var initfn = args.init;    //지자체 최초 선택시 실행함수
    var prntCd = "COMM.CITYAUTH";

    var sidoObj = $("#"+sidoid);
    var cityObj = $("#"+authid);

	var sidoValue = sidoObj.data('value');
	var cityValue = cityObj.data('value');

	var callbackFn = args.callback;
	var firstTime = true;

    //시도 초기선택값
    var initSidoVal = false;
    var initObj = false;
    var initVal = false;

    //시도 있을 경우
    if (!isEmpty(sidoObj.val())) {
        initSidoVal = sidoObj.val();
    }

    if (initid) {
        initObj = $("#"+initid);
        initVal = initObj.val();
        if (!isEmpty(initVal)) {
            initSidoVal = (initSidoVal ? initSidoVal : initVal.substring(0,2)+"00");
        }
    }
    
    //초기 로딩시
    if (loading) {
        //공통코드 AJAX
        bizutils.findBjd({
            params: {type: 'SD'},
            fn: function(result) {
                if (result != null) {
                    sidoObj.loadSelect(result);

                    if (initSidoVal) {
                        sidoObj.val(initSidoVal);
                        sidoObj.trigger('change');
                        initSidoVal = false;
                    }

					if (sidoValue) {
						sidoObj.val(sidoValue);
                        sidoObj.trigger('change');
					}

                }
            }
        });
    }

    //시도 선택시 지자체 검색
    sidoObj.change(function() {
        var sidoVal = $(this).val();
        cityObj.emptySelect();
        if (!isEmpty(sidoVal)){
            //공통코드 AJAX
            bizutils.findBjd({
                params: {type: 'SGG', parentCode: sidoVal},
                fn: function(result) {
                    if(result != null) {
                        cityObj.loadSelect(result);

                        if (initid) {
                            if (!isEmpty($("#"+initid).val())) {
                                cityObj.val($("#"+initid).val());
                                $("#"+initid).val("");
                            }
                        }

						if (cityValue) {
							cityObj.val(cityValue);
						}

                        if (initfn)
                            initfn();
                    }
                }
            });
        }
    });
    //시도 있을 경우
    if (!isEmpty(sidoObj.val())) {
        sidoObj.trigger('change');
    }

	if (callbackFn) {
		callbackFn();
	}
};

/**
 * 공통코드 목록 호출 AJAX 함수
 *
 * << 인자항목 >>
 * args.params : 검색조건
 * args.fn     : 결과처리함수
 *
 *
 * << 사용예 >>
 *    bizutils.findCode({
 *        params: {
 *            parentCode: ''
 *        },
 *        fn: function(result) {
 *        }
 *    });
 *
 */
bizutils.findCode = function( args ) {

	if (!args) {
		alert('[bizutils.findCode] : 함수인자가 정의되지 않았습니다.');
		return;
	}
	if (!args.fn || !$.isFunction(args.fn)) {
		alert('[bizutils.findCode] : 결과처리함수가 정의되지 않았습니다.');
		return;
	}
	var params = args.params || {};
	var fn = args.fn;

    $.ajax({
        url: ROOT_PATH +"/comm/findCodeAjax.do",
        data:params,
        dataType:"json",
        contentType:"application/json; text/html; charset=utf-8",
        success:fn,
        error:function(request, status, error) {
        	alert('error');
        }
    });
};

bizutils.findBjd = function( args ) {

	if (!args) {
		alert('[bizutils.findCode] : 함수인자가 정의되지 않았습니다.');
		return;
	}
	if (!args.fn || !$.isFunction(args.fn)) {
		alert('[bizutils.findCode] : 결과처리함수가 정의되지 않았습니다.');
		return;
	}
	var params = args.params || {};
	var fn = args.fn;

    $.ajax({
        url: ROOT_PATH +"/comm/findBjdCodeAjax.do",
        data:params,
        dataType:"json",
        contentType:"application/json; text/html; charset=utf-8",
        success:fn,
        error:function(request, status, error) {
			console.log(request);
			console.log(status);
			console.log(error)
        	alert('error');
        }
    });
};

/**
 * 주소 문자열을 받아서 업무구성에 맞게 5개 값으로 분리하는 method
 *
 * << 인자항목 >>
 * args : 주소 문자열 (예: "경기도 고양시 덕양구 토당동 845 파워프라자")
 *
 * return : {addr1:"경기도",addr2:"고양시",addr3:"덕양구",addr4:"토당동",addr5:845 파워프라자}
 */
bizutils.getParseAddressData = function( args ){

    var address = args;

    var convArr = ["","","","",""];
    var arrIdx  = 0;

    var addrArr = address.split(" ");

    for(var i=0;i<addrArr.length;i++) {
        
        if(curVal == "") continue;

        var curVal = trim(addrArr[i])+"";

        // 현재 값이 empty 상태면 통과
        if( curVal==null || curVal=="" || curVal.length == 0 ) continue;

        if(arrIdx == 3){
            var repCurVal = curVal.replace("-","").replace(" ","").replace("~","");
            var isValid = false;

            //예) 토당동 845, 세종로 17, 부근리 474, 삽교읍 47, 상성길 119
            if(isNaN( parseInt(repCurVal) ) == true){
                // 마지막 1글자 (리/동/로/길 중에 하나면 true
                var lastStr = repCurVal.substring(repCurVal.length-1);
                if("리|동|로|길".indexOf(lastStr) >= 0) {isValid = true;}
            }

            if(isValid == true) {
                // true이면 현재 index(3)에 저장
                convArr[arrIdx] = curVal;
                arrIdx ++;
            }else{
                // false이면 다음 index(4)에 저장
                arrIdx ++;
                convArr[arrIdx] = curVal;
            }
        }else if(arrIdx == 4){
                convArr[arrIdx] += (" " + curVal);
        }else{
            // addr1 ~ addr3는 모두 기본으로 값 입력.
            convArr[arrIdx] = curVal;
            arrIdx ++;
        }
    }

    var convData = {
            addr1:convArr[0]
           ,addr2:convArr[1]
           ,addr3:convArr[2]
           ,addr4:convArr[3]
           ,addr5:trim(convArr[4])
    };

    return convData;
};

/**
 * 파일 다운로드 function
 * << 인자항목 >>
 * 1) pk값만 전달.
 * args.fileNo : 파일테이블 pk 값.
 *
 * 2)파일 path를 전달할 때
 * args.filePath : 파일이 존재하는 directory의 full path
 * args.fileName : 실제 서버에 저장된 파일명
 * args.orgFileName : 원래 파일명 (다운로드되는 파일명이기도 함)
 *
 *
 */
comutils.fileDownload = function(args) {

    var filePath    = args.filePath;
    var fileName    = args.fileName;
    var orgFileName = args.orgFileName;
    var fileNo      = args.fileNo;

    if( fileNo != null && isNaN(fileNo) == false) {
        fileNo = fileNo.toString();
    }
    var param = "";

    if( fileNo != undefined && fileNo != null && fileNo.length > 0 ) {
        param = "?fileNo="+fileNo;
        document.location.href = ROOT_PATH +"/comm/fileDownload.do"+param;
    }else{
        param = "?orgFileName="+orgFileName+"&filePath="+filePath+"&fileName="+fileName;
        document.location.href = ROOT_PATH +"/comm/fileDownload.do"+param;
    }

};

/*
 * 2023.11.14 LHB 접기 공통 기능 구현
 * 접기 버튼으로 사용할 엘리먼트에 collapsable-btn 클래스 추가, data-clapsid 값 삽입
 * 접힐 엘리먼트에 clapsid 값으로 뒤에 -trgt 접미사 붙이기
 */

comutils.enableCollapse = function(args) {
	
	const openText	= (args && args.openText)  ? args.openText  : '펼치기';
	const closeText	= (args && args.closeText) ? args.closeText : '접기';
	
	$(".collapsable-btn").on('click', function() {
		const clapsid	= $(this).data('clapsid');
		const trgt		= $("[data-clapsid='" + clapsid + "-trgt']");
		const trgtStat	= trgt.data('clapStat');
		console.log(clapsid, trgt, trgtStat);
		
		if (trgtStat == 'on') {
			trgt.slideDown();
			$(this).text(closeText);
			trgt.data('clapStat', '');
		} else {
			trgt.slideUp();
			$(this).text(openText);
			trgt.data('clapStat', 'on');
		}
	});
}