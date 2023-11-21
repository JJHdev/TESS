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

/**
 * 2023.11.17 샘플 파일 다운로드 function
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
comutils.fileSampleDownload = function(args) {
    var fileNo      = args.fileNo;
    var param = "";

	param = "?fileNo="+fileNo;
	document.location.href = ROOT_PATH +"/comm/fileDownloadSample.do"+param;
};

/**
 * 2023.11.19 평가 지표 목록 생성 함수
 * @params
 * args.evaluYear	: 평가연도
 * args.evaluStage	: 평가단계
 * args.mode		: 모드 (VIEW, REGI)
 * args.evaluHistSn	: 평가사업 일련번호
 * args.id			: 생성할 id 값
 * args.url			: 평가 지표 항목 호출 URL
 * args.finalUse	: 종합의견 생성 유무
 */
comutils.makeEvlIxList = function(args) {
	if (!args) {
		console.error('[comutils.makeEvlIxList] 함수인자가 정의되지 않았습니다.');
		return false;
	}
	
	if (!args.evaluYear || !args.evaluStage) {
		console.error('[comutils.makeEvlIxList] 평가연도와 단계는 필수 항목입니다.');
		return false;
	}
	
	if (!args.id) {
		console.error('[comutils.makeEvlIxList] 생성될 위치가 정의되지 않았습니다.');
		return false;
	}
	
	const modeList = ['VIEW', 'REGI', 'UPDT'];
	// mode 기본값 VIEW
	var mode = modeList.indexOf(args.mode) > -1 ? args.mode : modeList[0];
	if (mode && mode == 'VIEW' && !args.evaluHistSn) {
		console.error('[comutils.makeEvlIxList] 평가사업 일련번호가 정의되지 않았습니다.');
		return false;
	}
	
	var target = $("#" +args.id);
	var url = args.url ? args.url : ROOT_PATH + '/ix/listEvlIxList.do';
	
	// TODO AJAX로 평가연도와 평가단계에 해당하는 지표값 호출함, ixList에 담겨있다고 가정
	$.ajax({
		url: url,
		data: {
			mode: mode,
			evaluYear: args.evaluYear,
			evaluStage: args.evaluStage,
			evaluHistSn: args.evaluHistSn,
		},
		dataType:"json",
		success: function(result) {
			if (!result || !result.code || result.code <= 0) {
				nAlert('[comutils.makeEvlIxList]' + result.msg);
			} else {
				const data = result.data;
				
				const lvl1List = data.filter(function(e) { return e.evlIxLevel == 1; });
				const lvl2List = data.filter(function(e) { return e.evlIxLevel == 2; });
				const lvl3List = data.filter(function(e) { return e.evlIxLevel == 3; });
				
				// 클래스 정리
				const tableCls		= 'evtdss-form-table';
				const trCls			= 'content-box';
				const textAreaCls	= 'ix-textarea'; 
				
				let html = '';
				
				// 대분류
				lvl1List.forEach(function (e1, i1) {
					const currLvl2List = lvl2List.filter(function(e) { return e1.evlIxArtclSn == e.upEvlIxArtclSn; });
					//const lvl1AllotVlMax = currLvl2List.filter(function(e) { return e.allotVlMax; }).reduce(function(sum, curr) { return sum + curr; });
					html += '<ul class="pl-5px"><li>' + (i1+1) + '.' + e1.artclNm + ' <span class="allotVlMax1_" + ' + (e1+1) + ' fc-red"></span>';
					
					html += '<ul class="node pl-5px">';
					let lvl1AllotVlSum = 0;
					if (e1.addCol02 == 'MINUS' || e1.addCol02 == 'PLUS') {
						const vlText = (e1.addCol02 == 'PLUS') ? '가점' : '감점';
						// 대분류가 감점 혹은 가점 항목일 경우
						html += '<table class="' + tableCls + '">';
						html += '<tbody>';
						
						html += '<tr><th class="ta-center">' + e1.artclNm + ' <span class="fc-red">(' + vlText + ')</span></th>';
						html += '<td class=ta-left">' + e1.addCol01 + '</td></tr>'
						
						const allotNmList = e1.allotNm.split(',');
						const allotVlList = e1.allotVl.split(',');
						const allotSnList = e1.allotSn.split(',');
						
						html += '<tr><td colspan="2">'
						
						html += '<div class="ix-div">';
						html += '<span class="ix-span ta-center">구분</span>';
						for (let i=0 ; i<allotNmList.length ; i++) {
							html += '<span class="ix-span ta-center">' + allotNmList[i] + '</span>';
						}
						html += '</div>';
						
						html += '<div class="ix-div">';
						html += '<span class="ix-span ta-center">점수</span>';
						for (let i=0 ; i<allotVlList.length ; i++) {
							html += '<span class="ix-span ta-center">' + allotVlList[i] + '</span>';
						}
						html += '</div>';
						
						html += '<div class="ix-div">';
						html += '<span class="ix-span ta-center">답변</span>';
						for (let i=0 ; i<allotVlList.length ; i++) {
							html += '<span class="ix-span ta-center"><input type="radio" name="allotVl_' + e1.evlIxArtclSn + '" value="' + allotSnList[i] + '"/></span>';
						}
						html += '</div>';
						html += '</td></tr>';
						
						html += '<tr class="' + trCls + '"><td colspan="2"><span>판단의견</span><textarea class="' + textAreaCls + '" name="dcsOpnn_' + e1.evlIxArtclSn + '"></textarea></td></tr>';
						html += '<tr class="' + trCls + '"><td colspan="2"><span>개선사항</span><textarea class="' + textAreaCls + '" name="ipmNote_' + e1.evlIxArtclSn + '"></textarea></td></tr>';
						
						html += '</tbody>';
						html += '</table>';
						
						html += '</li></ul></li></ul>';
						return;
					}
					
					currLvl2List.forEach(function(e2, i2) {
						const currLvl3List = lvl3List.filter(function(e) { return e2.evlIxArtclSn == e.upEvlIxArtclSn; });
						const lvl2AllotVlMax = currLvl3List.map(function(e) { return e.allotVlMax; }).reduce(function(sum, curr) { return sum + curr; });
						lvl1AllotVlSum += lvl2AllotVlMax;
						html += '<li>' + (i2+1) + ')' + e2.artclNm + ' (' + lvl2AllotVlMax + ')';
						
						currLvl3List.forEach(function (e3, i3) {
							html += '<table class="' + tableCls + '">';
							html += '<tbody>';
							
							html += '<tr><th class="ta-center">' + e3.artclNm + ' <span class="fc-red">(' + e3.allotVlMax + ')</span></th>';
							html += '<td class=ta-left">' + e3.addCol01 + '</td></tr>'
							
							const allotNmList = e3.allotNm.split(',');
							const allotVlList = e3.allotVl.split(',');
							const allotSnList = e3.allotSn.split(',');
							
							html += '<tr><td colspan="2">'
							
							html += '<div class="ix-div">';
							html += '<span class="ix-span ta-center">구분</span>';
							for (let i=0 ; i<allotNmList.length ; i++) {
								html += '<span class="ix-span ta-center">' + allotNmList[i] + '</span>';
							}
							html += '</div>';
							
							html += '<div class="ix-div">';
							html += '<span class="ix-span ta-center">점수</span>';
							for (let i=0 ; i<allotVlList.length ; i++) {
								html += '<span class="ix-span ta-center">' + allotVlList[i] + '</span>';
							}
							html += '</div>';
							
							html += '<div class="ix-div">';
							html += '<span class="ix-span ta-center">답변</span>';
							for (let i=0 ; i<allotVlList.length ; i++) {
								html += '<span class="ix-span ta-center"><input type="radio" name="allotVl_' + e3.evlIxArtclSn + '" value="' + allotSnList[i] + '"/></span>';
							}
							html += '</div>';
							html += '</td></tr>';
							
							html += '<tr class="' + trCls + '"><td colspan="2"><span>판단의견</span><textarea class="' + textAreaCls + '" name="dcsOpnn_' + e3.evlIxArtclSn + '"></textarea></td></tr>';
							html += '<tr class="' + trCls + '"><td colspan="2"><span>개선사항</span><textarea class="' + textAreaCls + '" name="ipmNote_' + e3.evlIxArtclSn + '"></textarea></td></tr>';
							
							html += '</tbody>';
							html += '</table>';
						});
						
						html += '</li>';
					});
					html += '</ul>';
					
					html += '</li></ul>';
					e1.allotVlMax = lvl1AllotVlSum;
				});
				
				if (args.finalUse) {
					html += '<table class="' + tableCls + '">';
					html += '<tbody>';
					html += '<tr><th>구분</th><th>내용</th></tr>';
				}
				
				target.html(html);
				lvl1List.forEach(function(e, i) { $(".allotVlMax1_"+i).text(e.allotVlMax); });
			}
		},
		error: function (xhr, request, error) {
			nAlert('시스템 에러가 발생했습니다.\n 관리자에게 문의해주세요.');
		}
	});
}

/**
 * 2023.11.19 평가 지표 목록 저장 함수
 * @params
 * args.id			: form 객체 ID
 * args.url			: 평가 지표 항목 저장 URL
 */
comutils.saveEvlIxList = function(args) {
	
	var url = args.url ? args.url : ROOT_PATH + '/ix/saveEvlIxList.do';
	
	if (!args) {
		console.error('[comutils.saveEvlIxList] 함수인자가 정의되지 않았습니다.');
		return false;
	}
	
	if (!args.id) {
		console.error('[comutils.saveEvlIxList] form 객체 ID가 정의되지 않았습니다.');
		return false;
	}
	
	const formObj	= $("#" + args.id);
	const formArr	= formObj.serializeArray();
	console.log(formArr);
	
	const params = {};
	
	formArr.forEach(function (e, i) {
		const name	= e.name;
		const value	= e.value;
		
		if (name.indexOf('_') > -1) {
			// 지표 입력값 관련
			const key	= name.split('_')[0];
			const sn	= name.split('_')[1];
			
			if (params[sn]) {
				params[sn].push(value);
			} else {
				params[sn] = [value];
			}
		} else {
			params[name] = value;
		}
	});
	
	// 선택되지 않은 점수 빈 값 삽입
	Object.keys(params).forEach(function(e, i) {
		if (Array.isArray(params[e])) {
			if (params[e].length == 2) {
				params[e].unshift('');
			}
		}
	});
	
	console.log(params);
	
	$.ajax({
		url: url,
		data: {
			data: JSON.stringify(params)
		},
		dataType:"json",
		success: function(result) {
			if (result) {
				const code = result.code;
				const msg = result.code;	
			} else {
				nAlert('시스템 에러가 발생했습니다.\n 관리자에게 문의해주세요.');
			}
		},
		error: function (xhr, request, error) {
			nAlert('시스템 에러가 발생했습니다.\n 관리자에게 문의해주세요.');
		}
	})
	
}