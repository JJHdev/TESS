// GPLv2 http://www.gnu.org/licenses/gpl-2.0-standalone.html
(function ($) {
		 
    $.fn.nb2sb = function (options) {
        var sbw, navDefStyle, plugStyle, $sb, $sbWrapper, sbwStyle, $sUl, sUlClasses, nClick, nsbw, animationStart, animationReset, rsbw, rwWidth,
            //defaults options
            defaults = {
                selectors: {
                    opener: undefined,
                    content: undefined,
                    closingLinks: undefined
                },
                settings: {
                    dataName: 'nb2sb',
                    gap: 0,
                    animation: {
                        duration: 400,
                        easing: 'swing'
                    },
                    style: {
                        width: 300,
                        padding: '1em',
                    }
                },
                ajax: {}
            },
            cfg = $.extend(true, defaults, options),
            //selectors
            $nav = this,
            $btn = $(cfg.selectors.opener),
            $ctn = $(cfg.selectors.content),
            $links = $( cfg.selectors.closingLinks ),
            //settings
            dataName = cfg.settings.dataName,
            gap = cfg.settings.gap,
            duration = cfg.settings.animation.duration,
            easing = cfg.settings.animation.easing,
            //custom sidebar style
            custStyle = cfg.settings.style,
            sbStyle = {},
            //other
            wWidth = $(window).width(),
            clicks = 0;

        //defining Sidebar style
        if (custStyle.width >= (wWidth - gap)) {
            sbw = wWidth - gap;
        } else {
            sbw = custStyle.width;
        }
        //
        //Navbar default style
        navDefStyle = {
            minHeight: $nav.css('min-height'),
            backgroundColor: $nav.css('background-color'),
            zIndex: $nav.css('z-index')
        };
        //
        //Sidebar Plugin Style
        plugStyle = {
            position: 'fixed',
            top: parseInt(navDefStyle.minHeight),
            left: -sbw,
            bottom: 0,
            zIndex: navDefStyle.zIndex - 1,
            maxWidth: sbw,
            backgroundColor: navDefStyle.backgroundColor
        };
        //
        //Sidebar final Style
        $.extend(true, sbStyle, plugStyle, custStyle);
        //
        //SubWrapper style
        sbwStyle = {
            width: '100%',
            height: '100%',
            overflow: 'auto'
        };

        //creating and defining the sidebar
        $('body').append('<div data-' + dataName + '="sidebar"><div data-' + dataName + '="sub-wrapper"></div></div>');
        //
        $sb = $('body').children().filter(function () {
            return $(this).data(dataName) === 'sidebar';
        });
        //allowing overflow
        $sbWrapper = $sb.children().filter(function () {
            return $(this).data(dataName) === 'sub-wrapper';
        });
        //style and copying $ctn to the new sidebar
        $sb.css(sbStyle).hide();
        //overriding custom width
        $sb.css('width', sbw);
        //subwrapper style and appending content
        $sbWrapper.css(sbwStyle).append($ctn.html());

        //resetting new $ctn on sidebar
        $sUl = $sbWrapper.children();
        //
        sUlClasses = $sUl.prop('class');
        //
        $sUl.removeClass(sUlClasses).addClass('nav nav-pills nav-stacked nb2sb-active');

        //hiding $ctn on small devices according to Bootstrap
        if (768 > wWidth) {
            $ctn.hide();
            $sb.show();
        } else {
            $ctn.show();
            $sb.hide();
        }

        //triggering the animations.
        //
        $btn.click(function () {
            nsbw = $sb.outerWidth();
            clicks++;
            nClick = function (e) {
                return (e % 2 === 0) ? true : false;
            };

            animationStart = {
                left: 0,
            };
            animationReset = {
                left: -nsbw
            };

            if (false === nClick(clicks)) {
                $sb.animate(animationStart, {
                    duration: duration,
                    easing: easing
                });
                $(".navbar-toggle").addClass("active");
                $(".overlay").addClass("active");
                $("body").addClass("not_scroll");
                
            } else if (true === nClick(clicks)) {
                $sb.animate(animationReset, {
                    duration: duration,
                    easing: easing
                });
                $(".navbar-toggle").removeClass("active");
                $(".overlay").removeClass("active");
                $("body").removeClass("not_scroll");
            }
        });
        //
        //closing sidebar when a link is clicked	
        $sb.on('click', $links, function () {
            nsbw = $sb.outerWidth();
            animationReset = {
                right: -nsbw
            };

            $sb.animate(animationReset, {
                duration: duration,
                easing: easing
            });

            clicks = 1; //navbar-toggle
        });

        //adding responsiveness
        //
        $(window).resize(function () {
            //redefining variables
            rwWidth = $(window).width();
			
            if (custStyle.width >= (rwWidth - gap)) {
                rsbw = rwWidth - gap;
            } else {
                rsbw = custStyle.width;
            }

            animationReset = {
                right: -rsbw
            };
			
            //redefining style
            $sb.css('max-width', rsbw);

            //hiding $ctn on small devices according to Bootstrap
            if (768 > rwWidth) {
                $ctn.hide();
                $sb.show();
            } else {
                $ctn.show();
                $sb.hide()
               .animate(animationReset, {
                   duration: duration,
                   easing: easing,
                   complete: function () {
                   clicks = 1; //navbar-toggle
                   }
        	 	});
        	 	$(".overlay").removeClass("active");
                $("body").removeClass("not_scroll");

			  }
      	});
			
        return this;
    };
})(jQuery);
