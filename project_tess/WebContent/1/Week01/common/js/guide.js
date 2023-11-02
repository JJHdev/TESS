/*  edit-jian  */

$(window).load(function() {
 
  var $liTab= $('ul.list > li').attr('id', function(i) { return "tab" + (i + 1) });
  var licount = $liTab.length; 
  $('ul.list li').on('click', function(){    
    tab_bar("_tb"+onlyNum($(this).attr('id')),licount);
  });

}); //end load 




// 탭 관련 
function tab_bar(select_tb,su){
	for(i=1 ; i<=su ; i++){
		var obj = document.all["screen_tb"+i];
		var k="tab"+i;
    $("#"+k).find('a').removeClass("on");
		obj.style.display="none";
	}
	var s=onlyNum(select_tb);
	var selc="tab"+s;
  $("#"+selc).find('a').addClass("on");
	show_screen(select_tb);
}

function show_screen(su){
	var obj = document.all["screen"+su];
	obj.style.display="";
}

//선택탭 표시
function onlyNum(my_commaStr) {
  var valid ="1234567890"
	var temp;
	var OneSi="";
	for (var i=0; i<my_commaStr.length; i++) {
	  temp = "" + my_commaStr.substring(i, i+1);
	  if (valid.indexOf(temp) != "-1") {
			OneSi = OneSi + temp;
	  }//end if
  }//end for			
	return parseInt(OneSi);
}//end fn


//ie setAttribute("className","") netscape setAttribute("class","")
function MM_showHideLayers() { //v6.0 
  var i,p,v,obj,args=MM_showHideLayers.arguments; 
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2]; 
    if (obj.style){obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; } 
    obj.visibility=v;} 
} 

onclick="MM_showHideLayers('Layer1','','show')" 


