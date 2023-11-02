// Make by 김은기 
// Update Date : 13-06-11 16:56
document.writeln('<script src="common/js/excanvas.compiled.js" type="text/javascript"></script>');
var quizt = [];
var falsecnt, correctInclude;
var dialogTimeHandle;
var objFocus;
var lineQuizComplete = false;
$(document).ready(function () {
    //*****************************************
    //      경고창 문구
    //*****************************************
    var alert_arr = [
		 "문제를 푸셨습니다. 다음으로 이동하세요!"			//정답
		, "틀렸습니다. 다시 한번 잘 생각해 보세요!"			//오답
		, "먼저 문제를 푸신 후 확인 버튼을 클릭해 주세요."	//미 선택
    ];

    

    //.parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
    $("#moviePopup").dialog({
        autoOpen: false,
        show: {
            effect: "slide",
            duration: 1000
        },
        hide: {
            effect: "slide",
            duration: 1000
        },
        height: 'auto',
        width: 'auto',
        position: { my: "center", at: "center", of: $('form') },
        resizable: false,
        open: function () {
            //if (jQuery.browser.msie) {
            //    movie.play();
            //} else {
            //    $('#movie param[name="autostart"]').attr('value', true);
            //}
            $('#btnPlay').click();
        },
        beforeClose: function () {
            $('#btnStop').click();
        }
    });
    

    $('.answer').bind('click', function () {
        if ($(this).hasClass('checkbox')) {
            var obj = $(this).parents('form').find('.quiz_confirm');
            var qi;     // QuizIndex
            $('.quiz_confirm').each(function (index) {
                if ($('.quiz_confirm').eq(index).is(obj)) {
                    qi = index;
                }
            });
            if ($(this).parent().parent().find('.checkbox.select').length > quizt[qi][0].length - 1 && !$(this).hasClass('select')) {
                $("#alert p").text(quizt[qi][0].length + '개 초과로 선택하실 수 없습니다.');
                $("#alert").dialog('open');
            } else {
                $(this).toggleClass('select');
            }
        } else if ($(this).hasClass('radiobutton')) {
            $(this).parent().parent().find('.radiobutton.select').removeClass('select');
            $(this).addClass('select');
        }
        
        
    });
    $('.inputText').bind('change', function () {
        if ($(this).val() == "") {
            $(this).removeClass('select');
        } else {
            $(this).addClass('select');
        }

    });
    $('.quiz_confirm').bind('click', function () {
        clearTimeout(dialogTimeHandle);
        $("#alert").dialog('close');
        var obj = $(this);
        var confirm = 0;    // 정답여부
        var qi;     // QuizIndex
        $('.quiz_confirm').each(function (index) {
            if ($('.quiz_confirm').eq(index).is(obj)) {
                qi = index;
            }
        });
        
        
        if (quizt[qi] != null) {
            if ($(obj).parents('form').find('.answer').is('.radiobutton, .checkbox')) {
                $(obj).parents('form').find('.crt').remove();
                if (($(obj).parents('form').find('.checkbox').length == 0 && $(obj).parents('form').find('.select').length == quizt[qi].length)
                    || ($(obj).parents('form').find('.checkbox').length > 0 && $(obj).parents('form').find('.select').length == quizt[qi][0].length)) {
                    var quiztObject;
                    if ($(obj).parents('form').find('.checkbox').length > 0) {
                        quiztObject = quizt[qi][0];
                    } else {
                        quiztObject = quizt[qi];
                    }
                    $(obj).parents('form').find('.radiobutton.select, .checkbox.select').each(function (index) {
                        var imgSrc, topPosition, leftPosition, returnValue = true;
                        if ($(this).is('.n1, .n2, .n3, .n4')) {
                            imgSrc = 'img/ch_bu_corec.gif';
                            topPosition = $(obj).parents('form').find('.answer').eq(quiztObject[index] - 1).position().top;
                            leftPosition = $(obj).parents('form').find('.answer').eq(quiztObject[index] - 1).position().left - 9;
                        } else if ($(this).is('.check_o, .check_x')) {
                            imgSrc = 'img/ch_ox_o.gif';
                            topPosition = $(obj).parents('form').find('.answer').eq(quiztObject[index] - 1).position().top - 11
                            + (parseInt($(obj).parents('form').find('.answer').eq(quiztObject[index] - 1).css('margin-top'), 10) || 0);
                            leftPosition = $(obj).parents('form').find('.answer').eq(quiztObject[index] - 1).position().left
                            + (parseInt($(obj).parents('form').find('.answer').eq(quiztObject[index] - 1).css('margin-left'), 10) || 0) - 1;
                        } else if ($(this).is('.check_o_small, .check_x_small')) {
                            imgSrc = 'img/ch_bu_corec.gif';
                            topPosition = $(obj).parents('form').find('.answer.select').eq(index).parent().parent().find('.answer').eq(quiztObject[index] - 1).position().top - 2
                            + (parseInt($(obj).parents('form').find('.answer.select').eq(index).parent().parent().find('.answer').eq(quiztObject[index] - 1).css('margin-top'), 10) || 0);
                            leftPosition = $(obj).parents('form').find('.answer.select').eq(index).parent().parent().find('.answer').eq(quiztObject[index] - 1).position().left
                                + (parseInt($(obj).parents('form').find('.answer.select').eq(index).parent().parent().find('.answer').eq(quiztObject[index] - 1).css('margin-left'), 10) || 0) - 6;
                        }
                     
                        $(obj).parents('form').append('<p class="crt"><img src=' + imgSrc + ' alt="정답"/></p>')
                        $(obj).parents('form').find('.crt').hide();
                        $(obj).parents('form').find('.crt').eq(index).css({
                            'top': topPosition,
                            'left': leftPosition + 1
                        });
                        if (($(this).parent().index() + 1) != quiztObject[index]) returnValue = false;
                        if (!returnValue) confirm = 1;
                    });
                    falsecnt--;
                } else { confirm = 2; }
                

            } else if ($(obj).parents('form').find('.answer').hasClass('text') || $(obj).parents('form').find('.answer').hasClass('inputText')) {
                
                for (var i in quizt[qi]) {
                    confirm = 1;
                    if ($(obj).parents('form').find('.text, .inputText').eq(i).val().replace(/\s/g, "") == "") {
                        confirm = 2;
                        break;
                    } else {
                        if (typeof (quizt[qi][i]) == "object") {
                            for (var ii in quizt[qi][i]) {
                                if (correctInclude) {
                                    if ($(obj).parents('form').find('.text, .inputText').eq(i).val().replace(/\s/g, "").toUpperCase().indexOf(quizt[qi][i][ii].toUpperCase()) > -1) {
                                        confirm = 0;
                                    }
                                } else {
                                    if ($(obj).parents('form').find('.text, .inputText').eq(i).val().replace(/\s/g, "").toUpperCase() == quizt[qi][i][ii].toUpperCase()) {
                                        confirm = 0;
                                    }
                                }
                            }
                        } else {
                            if (correctInclude) {
                                if ($(obj).parents('form').find('.text, .inputText').eq(i).val().replace(/\s/g, "").toUpperCase().indexOf(quizt[qi][i].toUpperCase()) > -1) {
                                    confirm = 0;
                                }
                            } else {
                                if ($(obj).parents('form').find('.text, .inputText').eq(i).val().replace(/\s/g, "").toUpperCase() == quizt[qi][i].toUpperCase()) {
                                    confirm = 0;
                                }
                            }
                            
                        }
                    };
                    
                }
                falsecnt = confirm == 2 ? falsecnt : falsecnt - 1;
            };
        } else if ($(obj).hasClass('line_quiz')) {
            confirm = 2;
            if (lineQuizComplete) { confirm = 0; }
        } else {
            confirm = 2;
            if (quizt[qi] == null) {
                $(obj).parents('form').find('.inputText, .text').each(function () {
                    if ($(this).val().replace(/\s/g, "") == "") { confirm = 2; return false; } else { confirm = 0; }
                });

            }
        }

        $("#alert p").text(alert_arr[confirm]);
        
            if (confirm == 0) {
                $("body").append('<embed src="data/o.wav" hidden="true" autostart="true" />');
            } else if (confirm == 2) {
            } else {
                $("body").append('<embed src="data/x.wav" hidden="true" autostart="true" />');
            }
        
        if (confirm == 0 || falsecnt < 1) {
            $(obj).parents('form').find('.answer').unbind('click');
            $(obj).parents('form').find('.answer, .quiz_confirm').attr('disabled', true);
            $(obj).parents('form').find('.answer, .quiz_confirm').addClass('disabled');
            $(obj).parents('form').find('.answer, .quiz_confirm').children().addClass('disabled');
            $(obj).parents('form').find('.crt').show();
            $(obj).parents('form').siblings('.box_answer').find('.cmt').hide();
            $(obj).parents('form').siblings('.box_answer').find('.correct').fadeIn(800);
            if ($('#moviePopup').length > 0) {
                videoPlayerPopup();
            }
            falsecnt = false_cnt;
        } else {
            $("#alert").dialog('open');
        }
    });
    function GetQuizCorrect() {
        try {
            falsecnt = false_cnt;
        }
        catch (e) {
            falsecnt = 1;
        }
        try {
            correctInclude = correct_Include;
        }
        catch (e) {
            correctInclude = true;
        }
        
        for (var qi = 0; qi < $('.correctanswer').length; qi++) {
            if ($('.correctanswer').eq(qi).hasClass('noAnswer')) {
                quizt[qi] = null;
            } else {
                quizt[qi] = [];
                if ($('.correctanswer').eq(qi).find('.correctSub').length > 0) {
                    $('.correctanswer').eq(qi).find('.correctSub').each(function (indexJ) {
                        quizt[qi][indexJ] = [];
                        if ($(this).find('.correctSame').length > 0) {
                    
                            $(this).find('.correctSame').each(function (indexK) {
                                quizt[qi][indexJ][indexK] = replacePattern($(this).text());
                            });
                        } else {
                            quizt[qi][indexJ][0] = replacePattern($(this).text());
                        }
                    });
                } else {
                    quizt[qi][0] = replacePattern($('.correctanswer').eq(qi).text());
                }

            }


        }


    };
    GetQuizCorrect();

    function replacePattern(text) {
        text = text.replace("①", "1");
        text = text.replace("②", "2");
        text = text.replace("③", "3");
        text = text.replace("④", "4");
        text = text.replace("⑤", "5");
        text = text.replace(/\s/g, "");
        if (text == "O" || text == "o") {
            text = 1;
        } else if (text == "X" || text == "x") {
            text = 2;
        };
        return text;
    }

    var tooltip = $('<div class="tooltip"/>').css('zIndex',10000000).hide();
    
    var dragValue,tooltipOpen=false;
    
    $("[drag_value]").each(function(){
        $(this).draggable({
            revert: "invalid",
            revertDuration: 200,
            containment: $(this).parents('.dragdrop_containment'),
            start: function (event, ui) {
                dragValue = $(this).attr('drag_value');
                tooltip.text("틀렸습니다.");
                $(this).addClass('on');
                if ($(this).hasClass('dragvalue_true')) return false;
            },
            stop: function (event, ui) {
                $(this).removeClass('on');
                if (tooltipOpen) {
                    tooltip.css('top', event.clientY - 30);
                    tooltip.css('left', event.clientX);
                    tooltip.show('clip', 200).delay(500).hide('clip', 200);
                }
                tooltipOpen = false;
                
            }
        });
    })
    //$('.dragdrop_containment').parent().append(tooltip);
    $('body').append(tooltip);
    $("[drop_value]").droppable({

        drop: function (event, ui) {
            if ($(this).attr('drop_value') == dragValue) {
                ui.draggable.draggable("option", "revert", false);
                ui.draggable.addClass('dragvalue_true');
                var offset = $(this).offset();
                offset.top += 1;
                offset.left += 1;
                ui.draggable.offset(offset);
                $(this).removeClass('ui-droppable');
                tooltip.text("정답입니다.");
                tooltipOpen = true;
                if ($(this).parent().find('.ui-droppable').length == 0) {
                    var index = $('.dragdrop_containment').index($(this).parents('.dragdrop_containment'));
                    $('.dropResult').eq(index).show();
                }
                $("body").append('<embed src="data/o.wav" hidden="true" autostart="true" />');
                
            } else {
                ui.draggable.draggable("option", "revert", true);
                tooltipOpen = true;
                $("body").append('<embed src="data/x.wav" hidden="true" autostart="true" />');
            }
            
        }
    });


    //function videoPlayerPopup() {
    //    $('#moviePopup').load('./movie_intro.html');
    //    $('#moviePopup').dialog('open');

    //};



});


window.onload = function () {
    if ($('#cv').length > 0) {
        var mouseDown = false;
        var movePoint;
        var clickLayer = 0;
        var offset = $('#cv').offset();
        var pointListRight = [];
        var pointListTemp = [];
        for (var k in canvasConfig.pointPosition) {
            pointListRight[k] = new Object;
            pointListTemp[k] = new Object;
            pointListTemp[k].x = pointList[k].x;
            pointListTemp[k].y = pointList[k].y;
            pointListRight[k].x = pointList2[canvasConfig.pointPosition[k] - 1].x;
            pointListRight[k].y = pointList2[canvasConfig.pointPosition[k] - 1].y;
            pointListRight[k].ok = false;
        };

        $('#cv').mousedown(function (event) {

            for (var i = 0; i < pointList.length; i++) {
                var objPoint = pointList[i];
                if (((objPoint.x + offset.left - $('#cv_frame').scrollLeft()) < (event.pageX + 11) && (objPoint.x + offset.left - $('#cv_frame').scrollLeft()) > (event.pageX - 9))
                    && ((objPoint.y + offset.top - $('#cv_frame').scrollTop()) < (event.pageY + 11) && (objPoint.y + offset.top - $('#cv_frame').scrollTop()) > (event.pageY - 9))) {
                    mouseDown = true;
                    clickLayer = i;
                    break;
                }
            }
        });
        $('#cv').mousemove(function (event) {

            for (var i = 0; i < pointList.length; i++) {
                var objPoint = pointList[i];
                if (((objPoint.x + offset.left - $('#cv_frame').scrollLeft()) < (event.pageX + 11) && (objPoint.x + offset.left - $('#cv_frame').scrollLeft()) > (event.pageX - 9))
                    && ((objPoint.y + offset.top - $('#cv_frame').scrollTop()) < (event.pageY + 11) && (objPoint.y + offset.top - $('#cv_frame').scrollTop()) > (event.pageY - 9))) {
                    $(this).css('cursor', 'pointer');
                    break;
                } else {
                    $(this).css('cursor', 'default');
                }
            }

            if (mouseDown) {

                pointList[clickLayer].x = event.pageX - offset.left + $('#cv_frame').scrollLeft();
                pointList[clickLayer].y = event.pageY - offset.top + $('#cv_frame').scrollTop();

                ctx.clearRect(0, 0, 500, 500);
                draw();
            }

        });
        $('#cv').mouseup(function (event) {
            if (clickLayer > -1) {
                var returnPosition = true;
                var objPoint = pointListRight[clickLayer];

                if (((objPoint.x + offset.left - $('#cv_frame').scrollLeft()) < (event.pageX + 28) && (objPoint.x + offset.left - $('#cv_frame').scrollLeft()) > (event.pageX - 14))
                    && ((objPoint.y + offset.top - $('#cv_frame').scrollTop()) < (event.pageY + 28) && (objPoint.y + offset.top - $('#cv_frame').scrollTop()) > (event.pageY - 14))) {
                    returnPosition = false;
                }
                mouseDown = false;
                if (returnPosition) {
                    pointList[clickLayer].x = pointListTemp[clickLayer].x;
                    pointList[clickLayer].y = pointListTemp[clickLayer].y;
                    ctx.clearRect(0, 0, 500, 500);
                    draw(true);
                    $("body").append('<embed src="data/x.wav" hidden="true" autostart="true" />');
                } else {
                    pointList[clickLayer].x = pointListRight[clickLayer].x;
                    pointList[clickLayer].y = pointListRight[clickLayer].y;
                    pointListRight[clickLayer].ok = true;
                    for (var i in pointListRight) {
                        if (pointListRight[i].ok) {
                            quizComplete = true;
                        } else {
                            quizComplete = false;
                            break;
                        }
                    }
                    ctx.clearRect(0, 0, 500, 500);
                    draw(true);
                    $("body").append('<embed src="data/o.wav" hidden="true" autostart="true" />');
                };
            }



        });
        var ctx = document.getElementById('cv').getContext('2d');
        var ctx2 = document.getElementById('cv').getContext('2d');
        var ctx3 = document.getElementById('cv').getContext('2d');
        var ctx4 = document.getElementById('cv').getContext('2d');
        var ctx5 = document.getElementById('cv').getContext('2d');



        function draw(drop) {

            ctx2.beginPath();
            ctx2.fillStyle = canvasConfig.backColor2;
            for (var i in pointListRight) {
                ctx2.moveTo(pointListRight[i].x, pointListRight[i].y);
                ctx2.arc(pointListRight[i].x, pointListRight[i].y, canvasConfig.circleSize2, 0 * Math.PI, 2 * Math.PI);
            }
            ctx2.fill();


            ctx5.lineWidth = canvasConfig.lineWidth1;
            ctx5.strokeStyle = canvasConfig.backColor5;
            for (var i in pointListRight) {
                ctx5.beginPath();
                ctx5.arc(pointListTemp[i].x, pointListTemp[i].y, canvasConfig.circleSize2, 0 * Math.PI, 2 * Math.PI, false);
                ctx5.closePath();
                ctx5.stroke();
            };

            ctx4.beginPath();
            ctx4.lineWidth = canvasConfig.lineWidth2;
            ctx4.strokeStyle = canvasConfig.backColor4;
            for (var k in pointList) {
                if (pointList[k].x == pointListRight[k].x && pointList[k].y == pointListRight[k].y) {
                    ctx4.moveTo(pointListTemp[k].x, pointListTemp[k].y);
                    ctx4.lineTo(pointList[k].x, pointList[k].y);
                }
            }
            ctx4.stroke();

            if (mouseDown) {
                var maxX = pointList[clickLayer].x - pointListTemp[clickLayer].x;
                var maxY = pointList[clickLayer].y - pointListTemp[clickLayer].y;
                ctx3.beginPath();
                ctx3.lineWidth = 2;
                ctx3.strokeStyle = canvasConfig.backColor3;
                ctx3.moveTo(pointListTemp[clickLayer].x, pointListTemp[clickLayer].y);
                for (var i = 0; i < maxX; i = i + 5) {
                    if (i % 10 == 0) {
                        ctx3.lineTo(pointListTemp[clickLayer].x + i, pointListTemp[clickLayer].y + ((maxY / maxX) * i));
                    } else {
                        ctx3.moveTo(pointListTemp[clickLayer].x + i, pointListTemp[clickLayer].y + ((maxY / maxX) * i));

                    }

                };
                ctx3.stroke();
            }


            ctx.beginPath();
            ctx.fillStyle = canvasConfig.backColor1;
            for (var i in pointList) {
                ctx.moveTo(pointList[i].x, pointList[i].y);
                ctx.arc(pointList[i].x, pointList[i].y, canvasConfig.circleSize1, 0 * Math.PI, 2 * Math.PI);
            }
            ctx.fill();
            if (drop) { clickLayer = -1; }
        }
        draw();
    }


}