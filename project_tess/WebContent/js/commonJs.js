/* 공통스크립트 */
    
	$( document ).ready(function() {
		
		$( '#nb2sb-nav' ).nb2sb({
			selectors : {
			opener: '.navbar-toggle',
			content: '#leftMenu',	
			closingLinks: 'none'			
			},
			settings: {
				animation: {
					duration: 500,
					easing: 'easeOutQuint'
				},
			    style: {
			    	width: '265',
			    	margin: '56px 0 0',
			    	padding: '0',
                    backgroundColor: '#f9f9f9'
                }					
			}
		});

	      $('.slides').slick({
	          autoplay: true,
	          autoplaySpeed: 6000,
	          arrows: false,
	          dots: true,
	          infinite: true,
	          speed: 800
	      });
	      $('.slides_arrows').slick({
	          autoplay: true,
	          autoplaySpeed: 5000,
	          arrows: true,
	          dots: true,
	          infinite: true,
	          speed: 700
	      });
	      
		    $('.tdHref').click(function(){
		        window.location = $(this).attr('href');
		        return false;
		    });
		
		$(".date-picker").datepicker({
		 	dateFormat: 'yy-mm-dd',
		    changeMonth: true,
		    changeYear: true,
			dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	     	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	     	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	     	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		 });
		 $(".date-picker").on("change", function () {
		    var id = $(this).attr("id");
		    var val = $("label[for='" + id + "']").text();
		    $("#msg").text(val + " changed");
		});
		
	  });
	  
	  
	$(function() {
	  // Dropdown fix
	  $('.dropdown > a[tabindex]').keydown(function(event) {
	    // 13: Return
	
	    if (event.keyCode == 13) {
	      $(this).dropdown('toggle');
	    }
	  });

	  $('.dropdown-submenu > a').submenupicker();
	});
