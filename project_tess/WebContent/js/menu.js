/**
 *  메뉴
 *
 * @author LSZ
 * @version 1.0 2018-11-26
 */

////////////////////////////////////////////////////////////////////////////////
// Loading
////////////////////////////////////////////////////////////////////////////////

$(document).ready(function(){
	
	// 드롭메뉴
	$(".evtdss-menu > li").click(function(){
		var a = $(this).hasClass("dropdown");
		
		if(a == true) {
			if($(this).hasClass("open") == false) {
				$(this).addClass("open");
			} else {
				$(this).removeClass("open");
			}
		}
	});
});;
	



