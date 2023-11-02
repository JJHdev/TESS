var playState = [];
var playbarClick = [];
var playObject = 0;

for (var i in videoInfo) {
    playState[i] = false;
    playbarClick[i] = false;
    eval('player' + i).url = videoInfo[i].src;
    eval('player' + i).width = videoInfo[i].width;
    eval('player' + i).height = videoInfo[i].height;
    eval('player' + i).uiMode = 'none';
    if (i != 0) eval('player' + i).controls.stop();
}

$('.movie').each(function () {
    $(this).width(videoInfo.width);
    $(this).height(videoInfo.height);
});

if (!jQuery.browser.msie) {
    var str = '<video src="' + $('#player param[name=url]').val() + '" id="player" width="' + $('#player').attr('width') + '" height="' + $('#player').attr('height') + '" style="' + $(player).attr('style') + '"></video>'
    $('.movie').empty();
    $('.movie').append(str);
};

function slideValueHandler(index) {
    if (playbarClick[index]) {
        if (jQuery.browser.msie) { eval('player' + index).controls.currentPosition = $(".playBar").eq(index).slider("value"); } else { eval('player' + index).currentTime = $(".playBar").eq(index).slider("value"); };
        PlayTimeSyncList(index);
        playbarClick[index] = false;
    }
}

function VolumeHandler(index,value) {
    if (jQuery.browser.msie) { eval('player' + index).settings.volume = value; } else { eval('player' + index).volume = value / 100; }
}
function PlayTimeSyncList(index) {
    var current = jQuery.browser.msie ? CalcTime(eval('player' + index).controls.currentPosition, true) : CalcTime(eval('player' + index).currentTime, true);
    $('.playtime').eq(index).text(current);
    $('[data-time]').each(function (index) {
        var secondIf = false;
        if ((($('[data-time]').length - 1) == index) || (CalcTime($('[data-time]').eq(index + 1).attr('data-time'), false) >= CalcTime(current, false))) secondIf = true;
        if ((CalcTime($('[data-time]').eq(index).attr('data-time'), false) <= CalcTime(current, false)) && secondIf) {
            $('[data-time]').removeClass('select');
            $(this).addClass('select');
            return false;
        }
    });
}
$(function () {
    //$(player).bind('contextmenu', function () { return false; });
    var tooltip = [];
    var volumeTooltip = [];
    var speedTooltip = [];
    for (var index in videoInfo) {
         tooltip[index] = $('<div class="tooltip" />').css({
            position: 'absolute',
            top: 4,
            left: 15,
            fontSize: 10,
            color: '#000000',
            background: '#f3f3f3',
            border: '1px solid #ddd',
            padding: '1px 4px'
        }).hide();
         volumeTooltip[index] = $('<div class="volumeTooltip" />').css({
            position: 'absolute',
            top: -15,
            left: -5,
            fontSize: 10,
            color: '#000000',
            background: '#f3f3f3',
            border: '1px solid #ddd',
            padding: '1px 4px'
        }).hide();
         speedTooltip[index] = $('<div class="speedTooltip" />').css({
            position: 'absolute',
            top: 44,
            left: 330,
            fontSize: 14,
            color: '#f00'
         }).hide();
         $(".playBar").eq(index).slider({
             orientation: "horizontal",
             range: "min",
             max: 255,
             value: 0,
             stop: function () {
                 var index = $(this).parents('[playernum]').attr('playernum');
                 playbarClick[index] = true;
                 slideValueHandler(index);
             },
             slide: function (event, ui) {
                 var index = $(this).parents('[playernum]').attr('playernum');
                 playbarClick[index] = true;
                 tooltip[index].text(CalcTime(ui.value, true));
             },
             change: function () { slideValueHandler($(this).parents('[playernum]').attr('playernum')); }
         }).find(".ui-slider-handle").append(tooltip[index]).mousedown(function () {
             var index = $(this).parents('[playernum]').attr('playernum');
             playbarClick[index] = true;
             tooltip[index].show();
         });
         $(".volumeSlide").eq(index).slider({
             orientation: "horizontal",
             range: "min",
             max: 100,
             value: 0,
             slide: function (event, ui) {
                 var index = $(this).parents('[playernum]').attr('playernum');
                 volumeTooltip[index].text(ui.value);
                 VolumeHandler(index, ui.value);
             },
             change: function (event, ui) {
                 VolumeHandler($(this).parents('[playernum]').attr('playernum'), ui.value);
             }
         }).find(".ui-slider-handle").append(volumeTooltip[index]).mousedown(function () {
             volumeTooltip[$(this).parents('[playernum]').attr('playernum')].show();
         });
    }
    
    $(document).mouseup(function () {
        for (var index in videoInfo) {
            tooltip[index].hide();
            volumeTooltip[index].hide();
            playbarClick[index] = false;
        };
    });
    


    $('.btnSpeedDown,.btnSpeedUp,.btnSpeedDefault').click(function () {
        var index = $(this).parents('[playernum]').attr('playernum');
        var rate = jQuery.browser.msie ? eval('player' + index).settings.rate.toFixed(1) : eval('player' + index).playbackRate.toFixed(1);
        if($(this).hasClass('btnSpeedDown')) {
            if (Number(rate) > 0.6) {
                if (Number(rate) <= 0.8) {
                    $(this).attr('disabled', true).addClass('off');
                }
                jQuery.browser.msie ? eval('player' + index).settings.rate -= 0.2 : eval('player' + index).playbackRate -= 0.2; rate = (Number(rate) - 0.2).toFixed(1);
            }
            $('.btnSpeedUp').eq(index).removeAttr('disabled').removeClass('off');
        }else if($(this).hasClass('btnSpeedDefault')){
            jQuery.browser.msie ? eval('player' + index).settings.rate = 1.0 : eval('player' + index).playbackRate = 1.0;
            rate = '1.0';
            $('.btnSpeedUp').eq(index).removeAttr('disabled').removeClass('off');
            $('.btnSpeedDown').eq(index).removeAttr('disabled').removeClass('off');
        }else if($(this).hasClass('btnSpeedUp')){
            if (Number(rate) < 2.0) {
                if (Number(rate) >= 1.8) {
                    $(this).attr('disabled', true).addClass('off');
                }
                jQuery.browser.msie ? eval('player' + index).settings.rate += 0.2 : eval('player' + index).playbackRate += 0.2; rate = (Number(rate) + 0.2).toFixed(1);
            } 
            $('#btnSpeedDown').eq(index).removeAttr('disabled').removeClass('off');

        }
        $('.current_sp').eq(index).text(rate);
    });

    $(".playBar").slider("value", 0);
    for (var i in videoInfo) {
        try {
            $(".volumeSlide").eq(i).slider("value", videoInfo[i].volume);
        } catch (e) {
            $(".volumeSlide").slider("value", 80);
        }
    }
    
    $(".playBar").removeClass('ui-widget-content');
    $(".playBar, .ui-slider-handle").removeClass('ui-corner-all');
    for (var index in videoInfo) {
        var element = document.getElementById('player' + index);
        if (jQuery.browser.msie) {
            element.attachEvent('playStateChange', function (newState) {
                switch (newState) {
                    case 8:
                        $(".playBar").eq(playObject).slider('value', $(".playBar").eq(playObject).slider('option', 'max'));
                        $('.playtime').eq(playObject).text($('.fullTime').eq(playObject).text());
                    case 1:
                        $('.btnPlay').eq(playObject).removeClass('pause');
                        playState[playObject] = false;
                        $('.btnSpeed10').eq(playObject).click();
                        break;
                    case 2:
                        $('.btnPlay').eq(playObject).removeClass('pause').addClass('replay'); playState[playObject] = false; break;
                    case 3:
                        $(".playBar").eq(playObject).attr('title', null);
                        $('.btnPlay').eq(playObject).addClass('pause');
                        playState[playObject] = true;
                        $('.fullTime').eq(playObject).text(CalcTime(eval('player' + playObject).controls.currentItem.duration, true));
                        $(".playBar").eq(playObject).slider("option", "max", eval('player' + playObject).controls.currentItem.duration);
                        PlayTimeSyncList(playObject);
                        SetPlayTime(playObject);
                        break;
                    default: break;
                }
            });
        } else {
            //element.addEventListener('play', function () {
            //    $('#btnPlay').removeClass('replay').addClass('pause');
            //    playState = true;
            //    $('#fullTime').text(CalcTime(player.duration, true));
            //    $(".playBar").slider("option", "max", player.duration);
            //    PlayTimeSyncList();
            //    SetPlayTime();
            //}, false);
            //element.addEventListener('pause', function () {
            //    if (player.currentTime > 0 && player.currentTime < player.duration) {
            //        $('#btnPlay').addClass('replay');
            //    } else {
            //        $('#btnPlay').removeClass('replay');
            //    }
            //    $('#btnPlay').removeClass('pause');
            //    playState = false;
            //}, false);
            //element.addEventListener('ended', function () {
            //    $('#btnPlay').removeClass('pause').removeClass('replay'); playState = false;
            //    $('#btnSpeed10').click();
            //}, false);
        };
    }
    
});
playState[0] = true;
function SetPlayTime(index) {

    if (playState[index]) {
        var current = jQuery.browser.msie ? CalcTime(eval("player" + index).controls.currentPosition, true) : CalcTime(eval("player" + index).currentTime, true);
        $('.playtime').eq(index).text(current||'00:00');
        if (!playbarClick[index]) $(".playBar").eq(index).slider("value", jQuery.browser.msie ? eval("player" + index).controls.currentPosition : eval("player" + index).currentTime);
        if ($('[data-time*="' + current + '"]').length > 0) {
            $('[data-time]').removeClass('select');
            $('[data-time*="' + current + '"]').addClass('select');
        }
        setTimeout("SetPlayTime(" + index + ");", 500);
    }

}
$('.btnPlay,.btnStop,.btnRewind10,.btnRewind30,.btnRewind60,.btnFullScreen,.btnSpeedDefault,.btnSpeedDown,.btnSpeedUp').bind('mousedown', function () {
    $(this).addClass('select');
}).bind('mouseup', function () {
    $(this).removeClass('select');
}).bind('mouseout', function () {
    $(this).removeClass('select');
});

$('.btnPlay,.btnStop,.btnRewind10,.btnRewind30,.btnRewind60,.btnFullScreen').bind('click', function () {
    var index = $(this).parents('[playernum]').attr('playernum');
    if ($(this).hasClass('btnPlay')) {
        if ($(this).hasClass('pause')) {
            $(this).removeClass('pause');
            jQuery.browser.msie ? eval("player" + index).controls.pause() : eval("player" + index).pause();
        } else {
            $(this).addClass('pause');
            jQuery.browser.msie ? eval("player" + index).controls.play() : eval("player" + index).play();
        };
    } else if ($(this).hasClass('btnStop')) {
        $('.btnPlay').eq(index).removeClass('pause').removeClass('replay');
        $(".playBar").eq(index).slider("value", 0);
        if (jQuery.browser.msie) { eval("player" + index).controls.stop() } else { eval("player" + index).currentTime = 0; eval("player" + index).pause(); };
        $('.btnSpeed10').eq(index).click();
    } else if ($(this).hasClass('btnRewind10')) {
        jQuery.browser.msie ? eval("player" + index).controls.currentPosition -= 10 : eval("player" + index).currentTime -= 10;
        $('.playtime').eq(index).text(jQuery.browser.msie ? CalcTime(eval("player" + index).controls.currentPosition, true) || '00:00' : CalcTime(eval("player" + index).currentTime, true));
        if (!playbarClick[index]) $(".playBar").slider("value", jQuery.browser.msie ? eval("player" + index).controls.currentPosition : eval("player" + index).currentTime);
    } else if ($(this).hasClass('btnRewind30')) {
        jQuery.browser.msie ? eval("player" + index).controls.currentPosition -= 30 : eval("player" + index).currentTime -= 30;
        $('.playtime').eq(index).text(jQuery.browser.msie ? CalcTime(eval("player" + index).controls.currentPosition, true) || '00:00' : CalcTime(eval("player" + index).currentTime, true));
        if (!playbarClick[index]) $(".playBar").slider("value", jQuery.browser.msie ? eval("player" + index).controls.currentPosition : eval("player" + index).currentTime);
    } else if ($(this).hasClass('btnRewind60')) {
        jQuery.browser.msie ? eval("player" + index).controls.currentPosition -= 60 : eval("player" + index).currentTime -= 60;
        $('.playtime').eq(index).text(jQuery.browser.msie ? CalcTime(eval("player" + index).controls.currentPosition, true) || '00:00' : CalcTime(eval("player" + index).currentTime, true));
        if (!playbarClick[index]) $(".playBar").slider("value", jQuery.browser.msie ? eval("player" + index).controls.currentPosition : eval("player" + index).currentTime);
    } else if ($(this).hasClass('btnFullScreen')) {
        if (jQuery.browser.msie) {
            eval("player" + index).fullScreen = true;
        } else {
            var elem = document.getElementById("player" + index);
            if (elem.requestFullscreen) {
                elem.requestFullscreen();
            } else if (elem.mozRequestFullScreen) {
                elem.mozRequestFullScreen();
            } else if (elem.webkitRequestFullscreen) {
                elem.webkitRequestFullscreen();
                var fullscreenElement = document.fullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement;
                var fullscreenEnabled = document.fullscreenEnabled || document.mozFullScreenEnabled || document.webkitFullscreenEnabled;
                $(fullscreenElement).bind('contextmenu', function () { return false; });
            }
        };
    }

});
    $('[data-time]').bind('click', function () {
        if ($(this).attr('data-time')) {
            $('[data-time]').removeClass('select');
            $(this).addClass('select');
            var duration = CalcTime($(this).attr('data-time').replace(/\s/g, ""));
            if (player0.playState != 3) player0.controls.play();
            jQuery.browser.msie ? player0.controls.currentPosition = duration : player0.currentTime = duration;
            $('#playtime').text(jQuery.browser.msie ? CalcTime(player0.controls.currentPosition,true) : CalcTime(player0.currentTime, true));
            if (!playbarClick[0]) $(".playBar").eq(0).slider("value", duration);
            PlayTimeSyncList(0);
        }
    });

    $('.playerMulti li a').bind('click', function () {
        for (var index in videoInfo) {
            $('.btnStop').click();
        }
        playObject = $(this).parent().index();
        $('.btnPlay').eq(playObject).click();
    });
