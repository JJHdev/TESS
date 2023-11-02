var RefreshFooter = function () {
    currentPage.num = FindCurrentPageCount(currentPage.name, currentPage.pageList);
    $(".page_num").children('.current').text(currentPage.num + 1);
    $('#btn_back a, #btn_next a').removeClass('off');
    if (FindCurrentPageCount(currentPage.name, currentPage.pageList) <= 0) {
        $('#btn_back a').addClass('off');
    } else if (FindCurrentPageCount(currentPage.name, currentPage.pageList) >= currentPage.pageList.length - 1) {
        $('#btn_next a').addClass('off');
    }
};
var FindCurrentPageCount = function (a, b) {
    for (var i = 0; i < b.length ; i++) {
        if (b[i].src == a) {
            return i + currentPage.thirdMenuCount;
        }
    }
};
$('#header').load('header.html', function () {
    $('#footer').load('footer.html', function () {

        var currentGNB;
        $("#gnb>li").click(
        function () {

            $("#gnb ul.snb").hide('blind');
            $("ul", this).show('blind');
        });

        $("#gnb>li").hover(
            function () {
                var obj;
                if ($(this).parent('li').length > 0) { obj = $(this).parent(); } else { obj = $(this); }
                $(obj).children('a').addClass('over');
                $("#gnb ul.snb").hide('blind');
                $("ul", obj).show('blind');
            },
            function () {
                var obj;
                if ($(this).parent('li').length > 0) { obj = $(this).parent(); } else { obj = $(this); }
                $(obj).children('a').removeClass('over');
                $("#gnb ul.snb").hide();
            });
        $("#gnb>li>a").hover(function () { $(this).addClass('over'); });

        $('.snb').hover(function () {
            $(this).parent().find('a').addClass('over');
        }, function () {
            $(this).parent().find('a').removeClass('over');
        }
        );
        var cnt = 0;
        for (var i = 0; i < subArr.length ; i++) {
            for (var j = 0; j < subArr[i].length ; j++) {
                var href = subArr[i][j].src;
                if ($('#gnb a').eq(cnt).parent().parent().attr('id') == 'gnb') {
                    $('#gnb a').eq(cnt).attr('href', href);
                    if ($('#gnb a').eq(cnt).siblings('ul').length > 0) { j-- }
                    if (currentPage.name == href) {
                        $('#gnb a').eq(cnt).addClass('on');
                        currentGNB = i;
                    }
                    cnt++;
                } else {
                    $('#gnb a').eq(cnt).attr('href', href);
                    if (currentPage.name == href) {
                        $('#gnb a').eq(cnt).parents('.snb').siblings('a').addClass('on');
                        currentGNB = i;
                        $('#gnb a').eq(cnt).addClass('on');
                    }
                    cnt++;
                }

            }
        }

        for (var i = 0; i < subArr.length ; i++) {
            for (var j = 0; j < subArr[i].length ; j++) {
                if (subArr[i][j].thirdMenu) {
                    for (var k = 0; k < subArr[i][j].thirdMenu ; k++) {
                        currentPage.pageList[currentPage.pageList.length] = new Object;
                        currentPage.pageList[currentPage.pageList.length - 1].src = subArr[i][j].src;
                        currentPage.pageList[currentPage.pageList.length - 1].thirdMenu = k;
                    }
                } else {
                    currentPage.pageList[currentPage.pageList.length] = subArr[i][j];
                }

            }
        }

       
        currentPage.num = FindCurrentPageCount(currentPage.name, currentPage.pageList);
        $(".page_num").html("<span class='current'>" + (currentPage.num + 1) + "</span> / " + currentPage.pageList.length);
        $('#btn_back a').bind('click', function () {
            if (!$(this).hasClass('off')) {
                if ((currentPage.pageList[currentPage.num - 1].src != currentPage.name) && (currentPage.pageList[currentPage.num - 1].thirdMenu)) {
                    location.href = currentPage.pageList[currentPage.num - 1].src + "?pn=" + currentPage.pageList[currentPage.num - 1].thirdMenu;
                } else if ((currentPage.pageList[currentPage.num - 1].src == currentPage.name) && (currentPage.pageList[currentPage.num - 1].thirdMenu >= 0)) {
                    currentPage.num -= 1;
                    $('#slideNum li a,#tabList li a').eq(currentPage.pageList[currentPage.num].thirdMenu).click();
                    RefreshFooter();
                } else {
                    location.href = currentPage.pageList[currentPage.num - 1].src;
                }
            }
        });
        $('#btn_next a').bind('click', function () {
            if (!$(this).hasClass('off')) {
                if ((currentPage.pageList[currentPage.num + 1].thirdMenu) > 0) {
                    currentPage.num += 1;
                    $('#slideNum li a,#tabList li a').eq(currentPage.pageList[currentPage.num].thirdMenu).click();
                    RefreshFooter();
                } else {
                    location.href = currentPage.pageList[currentPage.num + 1].src;
                }
            }

        });
       
        RefreshFooter();
    });
});


