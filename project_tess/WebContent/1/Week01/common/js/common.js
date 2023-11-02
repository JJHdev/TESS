// Update by 김은기 
// Update Date : 13-06-12 09:11

document.writeln('<script src="common/js/jquery-1.10.0.min.js" type="text/javascript"></script>');
document.writeln('<script src="common/js/jquery-migrate-1.2.1.js" type="text/javascript"></script>');
document.writeln('<link  href="common/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css"/>');
document.writeln('<link  href="common/css/initcommon.css" rel="stylesheet" type="text/css"/>');
document.writeln('<script src="common/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>');
document.writeln('<script src="js/map.js" type="text/javascript"></script>');
var locationHref = location.href.substring(location.href.lastIndexOf('/') + 1, location.href.length).replace("#", "");
if (locationHref.indexOf("?pn=") > -1) {
    locationHref = locationHref.substring(0, locationHref.indexOf("?pn="));
};
if (locationHref.indexOf("?pbn=") > -1) {
    locationHref = locationHref.substring(0, locationHref.indexOf("?pbn="));
};
if (locationHref.indexOf("&backtime=") > -1) {
    locationHref = locationHref.substring(0, locationHref.indexOf("&backtime="));
};
var currentPage = {
    name: locationHref,
    num: 0,
    thirdMenuCount: 0,
    pageList: []
};
document.ready = function () {

    var GNB_POS = null;
    $('form').bind('submit', function () { return false; });
    $("#alert").dialog({
        autoOpen: false,
        show: {
            effect: "bounce",
            duration: 300

        },
        hide: {
            effect: "blind",
            duration: 300
        },
        focus: function () {
            $(document).bind('click', function (e) {
                objFocus = e.target;
                $("#alert").dialog('close');
                $(objFocus).focus();
            });
        },
        open: function () {
            dialogTimeHandle = setTimeout(function () {
                $("#alert").dialog('close');
            }, 3000);
        },

        beforeClose: function () {
            $(document).unbind('click');
            $('form .checkbox.select').removeClass('select');
        },
        height: '160',
        width: '315',
        position: { my: "center", at: "center", of: $('#content') },
        resizable: false
    });
    $("#dialog").dialog({
        autoOpen: false,
        show: {
            effect: "bounce",
            duration: 300

        },
        hide: {
            effect: "blind",
            duration: 300
        },
        
        height: '160',
        width: '315',
        position: { my: "center", at: "center", of: $('#content') },
        resizable: true
    });

    $("textarea").hover(
        function () {
            $(this).addClass('hover');
        },
        function () {
            $(this).removeClass('hover');
        });

    //유틸 함수
    utils = {
        //콘솔
        log: function (message) {
            try {
                console.log(message);
            } catch (e) {
                alert(message);
            }
        }
        // null check
		, isNull: function (val1) {
		    if (typeof (val1) == "undefined" || val1 == null)
		        return true;
		    return false;
		}
        // empty check
		, isEmpty: function (val1) {
		    if (typeof (val1) == "undefined" || val1 == null || val1 == "")
		        return true;
		    return false;
		}
        //문서 저장
		, save_file: function (obj) {
		    save_file.document.open("text/html", "replace");
		    save_file.document.write(obj.val());
		    save_file.document.close();
		    save_file.focus();
		    save_file.document.execCommand('SaveAs', true, obj.attr("id") + ".txt");
		}
    }

    $("#btn_hint").hover(function () {  //힌트보기
        $(".answer").show()
    },
        function () {
            $(".answer").hide()
        });

    $("#sum04view").click(function () { //요약하기 
        var obj = $(this).parent().find("textarea");
        if ($.trim(obj.val()) != "") {
            $(".sum04_r").find('textarea').show()
        }
        else { alert("내용을 입력한 뒤 요약내용 보기 버튼을 클릭하세요") }
    });

    //Q&A 슬라이드 메뉴
    $("#qna dd").hide();
    $("#qna dt").click(function () {
        $(this).next("dd").slideToggle('slow').siblings("dd").slideUp('fast')
        $(this).toggleClass('active')
        $(this).siblings("dt").removeClass("active")
    })


    //문서저장
    $('<iframe id="save_file" style="display:none"></iframe>').appendTo("body");
    $(".save_btn").click(function () {
        var obj = $(this).parent().find("textarea");
        if ($.trim(obj.val()) != "") {
            utils.save_file(obj);
        } else {
            $("#alert p").text("글을 작성해 주세요.");
            $("#alert").dialog('open');
        };
    });//문서저장
  
    $('.inputText, .text').val(null);



    if ($('#tabContent').length > 0) { $('#tabContent').children().addClass('display_none'); $('#tabContent').children().first().removeClass('display_none'); }
    $('#tabList li a').bind('click', function () {
        var obj = $(this);
        $('#tabList .on').removeClass('on');
        $(obj).addClass('on');
        if ($('.tabvalue').length > 0) $('.tabvalue').text($(obj).attr('value'));
        $('#tabContent').children().addClass('display_none');
        currentPage.thirdMenuCount = $(obj).parent().index();
        setTimeout(function () {
            $('#tabContent').children().eq($(obj).parent().index()).removeClass('display_none');
            RefreshFooter();
        }, 1);
        
        RefreshFooter();
    });

    $('#slideNum li a').bind('click', function () {
        if ($(this).hasClass('on')) return false;
        $(this).parents('#slideNum').find('.on').removeClass('on');
        $(this).addClass('on');
        var width = $('#roll').children().first().width() * ($(this).parent().index());
        currentPage.thirdMenuCount = $(this).parent().index();
        var offset = $('#roll').offset();
        $('#roll').animate({
            left: -width
        }, $('#slideNum').attr('data-slideTime'));
        $('#roll').offset(offset);
        RefreshFooter();
    });
     

    if ($('.click_layer').length > 0) {
        $('.click_layer').each(function () {
            $(this).children('span').addClass('layer_img');
            $(this).children('span').width($(this).width() - 4);
            $(this).children('span').height($(this).height() + 15);
            $(this).children('span').css('top', -13);
            
        }); 
        $('.clickLayerSplit').each(function () {
            var bigNum;
            $(this).children().each(function (index) {
                if ($(this).find('span').width() > $(this).parent().children().eq(bigNum).find('span').width()) {
                    bigNum = index;
                }
                $(this).find('span').removeClass('layer_img');
            });

            $(this).children().eq(bigNum).find('span').addClass('layer_img');
        });
        $('.click_layer span').bind('click', function () {
            if ($(this).parents('.clickLayerSplit').length > 0) {
                $(this).parents('.clickLayerSplit').find('.click_layer span').each(function () {
                    $(this).hide();
                });
            } else {
                $(this).hide();
            }
            
        });
    }

    $(".accordion").accordion({
        collapsible: true,
        heightStyle: "content"
    });

    if (location.href.indexOf("?pn=") > -1) {
        var pn = location.href.substring(location.href.indexOf("?pn=") + 4, location.href.indexOf("?pn=") + 5);
        currentPage.thirdMenuCount = Number(pn);
        $('#slideNum li a,#tabList li a').eq(pn).click();
    }
    if (location.href.indexOf("&backtime=") > -1) {
        var backnum = location.href.substring(location.href.indexOf("&backtime=") + 10, location.href.indexOf("&backtime=") + 21);
        if (CalcTime(backnum,false) > 0) {
            $('.back_display').removeClass('display_none');
            player0.controls.currentPosition = CalcTime(backnum, false);
            $('.back_display').bind('click', function () {
                location.href = $('.back_display').attr('src') + "?pn=" + location.href.substring(location.href.indexOf("?pbn=") + 5, location.href.indexOf("?pbn=") + 6);
            });
        }
    }
};
var OpenDialog = function (html,width,height) {
    $("#dialog").dialog({ 'width': width, 'height': height });
    $("#dialog").load(html);
    $("#dialog").dialog('open');
};

function VisibleLayer(objID,visible,effect,direction) {
    eval("$('#" + objID + "')." + visible + "('" + effect + "',{ direction: '" + direction + "' });");
};

function CalcTime(time, type, hour) {
    if ($('.sync').eq(0).width() >= 100) {
        hour = true;
    }
    if (time.length < 11) time += ".00";
    if (type) {
        var hh = parseInt((time / 3600), 10);
        var mm = parseInt((time % 3600 / 60), 10);
        var ss = parseInt((time % 3600 % 60), 10);
        var timeStr = "";
        if (hour) {
            if (hh < 10) hh = "0" + hh;
            timeStr += hh + ":";
        }
        if (mm < 10) mm = "0" + mm;
        if (ss < 10) ss = "0" + ss;
        timeStr += mm + ":" + ss;
        return timeStr;
    } else {
        if (hour) {
            var duration = 0;
            duration += (parseInt(time.substring(0, 2), 10) * 3600) + (parseInt(time.substring(3, 5), 10) * 60) + parseInt(time.substring(6, 8), 10) + parseFloat(time.substring(8, 11), 10);
        } else {
            duration += (parseInt(time.substring(0, 2), 10) * 60) + parseInt(time.substring(3, 5), 10) + parseFloat(time.substring(5, 8), 10)
        }
        return duration;
    }

};

function MakeFlashString(source, id, width, height, wmode, otherParam) {
    return "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,22,0\" width=" + width + " height=" + height + " id=" + id + "><param name=wmode value=" + wmode + " /><param name=movie value=" + source + " /><param name=quality value=high />" + otherParam + "<embed src=" + source + " quality=high wmode=" + wmode + " type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/shockwave/download/index.cgi?p1_prod_version=shockwaveflash\" width=" + width + " height=" + height + "></embed></object>";
}

// Direct Write Type
function DocumentWrite(src) {
    document.write(src);
}


function MM_openBrWindow(theURL, winName, features) { //v2.0
    window.open(theURL, winName, features);
}

function MM_preloadImages() { //v3.0
    var d = document; if (d.images) {
        if (!d.MM_p) d.MM_p = new Array();
        var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
            if (a[i].indexOf("#") != 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
    }
}

function MM_findObj(n, d) { //v4.01
    var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
        d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
    }
    if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
    for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
    if (!x && d.getElementById) x = d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
    var i, img, nbArr, args = MM_nbGroup.arguments;
    if (event == "init" && args.length > 2) {
        if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
            img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
            if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
            nbArr[nbArr.length] = img;
            for (i = 4; i < args.length - 1; i += 2) if ((img = MM_findObj(args[i])) != null) {
                if (!img.MM_up) img.MM_up = img.src;
                img.src = img.MM_dn = args[i + 1];
                nbArr[nbArr.length] = img;
            }
        }
    } else if (event == "over") {
        document.MM_nbOver = nbArr = new Array();
        for (i = 1; i < args.length - 1; i += 3) if ((img = MM_findObj(args[i])) != null) {
            if (!img.MM_up) img.MM_up = img.src;
            img.src = (img.MM_dn && args[i + 2]) ? args[i + 2] : ((args[i + 1]) ? args[i + 1] : img.MM_up);
            nbArr[nbArr.length] = img;
        }
    } else if (event == "out") {
        for (i = 0; i < document.MM_nbOver.length; i++) {
            img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up;
        }
    } else if (event == "down") {
        nbArr = document[grpName];
        if (nbArr)
            for (i = 0; i < nbArr.length; i++) { img = nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
        document[grpName] = nbArr = new Array();
        for (i = 2; i < args.length - 1; i += 2) if ((img = MM_findObj(args[i])) != null) {
            if (!img.MM_up) img.MM_up = img.src;
            img.src = img.MM_dn = (args[i + 1]) ? args[i + 1] : img.MM_up;
            nbArr[nbArr.length] = img;
        }
    }
}

function MM_swapImgRestore() { //v3.0
    var i, x, a = document.MM_sr; for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
}

function MM_swapImage() { //v3.0
    var i, j = 0, x, a = MM_swapImage.arguments; document.MM_sr = new Array; for (i = 0; i < (a.length - 2) ; i += 3)
        if ((x = MM_findObj(a[i])) != null) { document.MM_sr[j++] = x; if (!x.oSrc) x.oSrc = x.src; x.src = a[i + 2]; }
}


function MakeFlashString(source, id, width, height, wmode, otherParam) {
    return "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,22,0\" width=" + width + " height=" + height + " id=" + id + "><param name=wmode value=" + wmode + " /><param name=movie value=" + source + " /><param name=quality value=high />" + otherParam + "<embed src=" + source + " quality=high wmode=" + wmode + " type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/shockwave/download/index.cgi?p1_prod_version=shockwaveflash\" width=" + width + " height=" + height + "></embed></object>";
}


/* 인쇄하기 */
var win = null;
function printPositionInit(obj) {
    var temp = $(obj).clone();
    $(temp).find('.position_init').css('left', '0px');
    $(temp).children().css('display', 'block');
    printIt($(temp).html());
}
function printIt() {

    var printThis = printIt.arguments;

    // printme 
    var stripTags = new RegExp();
    var stripTags2 = new RegExp();

    var content;
    content = printThis[0].replace(stripTags, "");

    // 타이틀설정
    var main_title = document.getElementById("main_title").value;
    var sub_title = document.getElementById("sub_title").value;

    //인쇄하기 페이지 설정
    var str_html = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml' xml:lang='ko' lang='ko'><head><meta http-equiv='X-UA-Compatible' content='IE=8'/><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><meta http-equiv='Content-Style-Type' content='text/css' /><meta http-equiv='Content-Script-Type' content='text/javascript' />";
    str_html += "<title>인쇄하기</title>";
    str_html += "<link  href='css/default.css' rel='stylesheet' type='text/css' /><link  href='css/print.css' rel='stylesheet' type='text/css'/></head>";
    str_html += "<body><div class='wrapper'><h1>한국방송통신대학교</h1><h2><img src='img/print_title01.gif' />&nbsp;" + main_title + "</h2><h3><img src='img/print_title02.gif' />&nbsp;" + sub_title + "</h3>";
    str_html += "<div class='cont'><table sellspacing='0' cellpadding='0'><tbody><tr><td class='style21'>" + content + "</td></tr></tbody></table></div>";
    str_html += "<div class='footer'></div>";
    str_html += "</div></body></html>";
    win = window.open();
    self.focus();
    win.document.open();
    win.document.write(str_html);
    win.document.close();
    win.print();
    //win.close();
}

/*  동영상 배속 */
function my_speed(n) {
    obj = document.getElementById("knouvvd");
    obj.settings.rate = n;
}

