//################################################################
//       jqGRID : jqgrid multi save 처리를 위한 함수
//		1. submitAddrow				: 해당 row 등록처리
//		2. submitEditRow			: 해당 row 수정처리
//		3. submitDeleteRow			: 해당 row 삭제처리
//		4. submitSave				: Multi row save 처리
//
//		1) $.jgrid.gridComboObject	: Grid combo 데이터 조회
//		2) $.jgrid.getRowExtData	: 선택 row 정보값 가져옴.
//
//		#. jquery.xml2json.js 다운로드 (현재버전은 jquery1.9 이상)
//		xml2json 에러가 나서 http://www.fyneworks.com/jquery/xml-to-json/ 에서 최신버전 사용하니 됨.
//		사용 jQuery 버전하고 맞아야함.
//
//################################################################

//==================   Grid Action Service  : ntarget  ==================//
function submitAddRow(useropt) {
	var _gridName		= useropt.gridName;
	var _url			= useropt.url;
	var _userData		= useropt.userData;
	var _width			= useropt.width;
	var _rtnFunc		= useropt.rtnFunc;

	var _params			= getGridJsonData(_gridName);

	$(_gridName).jqGrid('editGridRow', 'new', {
		url: ROOT_PATH + _url,
		editData: { returnType:'xmlView', jqGridParams:_params, jqUserParams:_userData },
		recreateForm: true,
		beforeShowForm: function(form) { },
		closeAfterAdd: true,
		//clearAfterAdd:true,
		reloadAfterSubmit:true,
		width: _width,
		modal:true,
		afterSubmit : function(response, postdata)  {
			var result = $.xml2json(response.responseText);
			var errors = "";
			var success = false;

			if (result == null) {
				errors =  MSG_ERR_FAIL;
			} else {
				if (result != undefined && result.success != undefined && (result.success == false || result.success == "false") ) {
						errors =  result.message;
				}  else {
					success = true;
					if (result != undefined && result.message != undefined) {
						$("#dialog").text(result.message);
					} else {
						$("#dialog").text(MSG_COMM_GRD_ADD);
					}
					$("#dialog").dialog({
						title: MSG_TITLE_SUCC,
						modal: true,
						buttons: {"Ok": function()  {
							$(this).dialog("close");}
						}
					});
				}

				if (result.success != undefined) {
					if (result.success == "true")	{
						success = true;
					}
				}

				if (success && _rtnFunc != undefined)	eval(_rtnFunc)(result);
			}

			// only used for adding new records
			var new_id = null;

			return [success, errors, new_id];
		}
	});

}

function submitEditRow(useropt) {
	var _gridName		= useropt.gridName;
	var _url				= useropt.url;
	var _userData		= useropt.userData;
	var _width			= useropt.width;
	var _rtnFunc			= useropt.rtnFunc;

	var row = $(_gridName).jqGrid('getGridParam', 'selrow');

	var _params = getGridJsonData(_gridName);

	if( row != null )  {
		$(_gridName).jqGrid('editGridRow', row, {
			url: ROOT_PATH + _url,
			editData: { returnType:'xmlView', jqGridParams:_params, jqUserParams:_userData  },
			recreateForm: true,
			beforeShowForm: function(form) { },
			closeAfterEdit: true,
			reloadAfterSubmit:true,
			width: _width,
			modal:true,
			afterSubmit : function(response, postdata)  {
				var result = $.xml2json(response.responseText);
				var errors = "";
				var success = false;

				if (result == null) {
					errors =  MSG_ERR_FAIL;
				} else {
					if (result != undefined && result.success != undefined && (result.success == false || result.success == "false") ) {
							errors =  result.message;
					}  else {
						success = true;
						if (result != undefined && result.message != undefined) {
							$("#dialog").text(result.message);
						} else {
							$("#dialog").text(MSG_COMM_GRD_EDT);
						}
						$("#dialog").dialog({
							title: MSG_TITLE_SUCC,
							modal: true,
							buttons: {"Ok": function()  {
								$(this).dialog("close");}
							}
						});
					}

					if (result.success != undefined) {
						if (result.success == "true")	{
							success = true;
						}
					}

					if (success && _rtnFunc != undefined)	eval(_rtnFunc)(result);
				}

				// only used for adding new records
				var new_id = null;

				return [success, errors, new_id];
			}

		});
	}	else {
		$( "#dialogSelectRow" ).dialog();
	}
}

function submitDeleteRow(useropt) {
	var _gridName		= useropt.gridName;
	var _url				= useropt.url;
	var _userData		= useropt.userData;
	var _width			= useropt.width;
	var _rtnFunc			= useropt.rtnFunc;
	var _msg				= useropt.msg;

	var row = $(_gridName).jqGrid('getGridParam','selrow');

	var _params = getGridJsonData(_gridName);

	if ( row != null )
		$(_gridName).jqGrid( 'delGridRow', row, {
			url: ROOT_PATH + _url,
			delData:{returnType:'xmlView', jqGridParams:_params, jqUserParams:_userData},
			//recreateForm: true,
			beforeShowForm: function(form) {},
			reloadAfterSubmit:true,
			closeAfterDelete: true,
			msg:_msg,
			width: _width,
			afterSubmit : function(response, postdata)  {
				var result = $.xml2json(response.responseText);
				var errors = "";
				var success = false;

				if (result == null) {
					errors =  MSG_ERR_FAIL;
				} else {
					if (result != undefined && result.success != undefined && (result.success == false || result.success == "false") ) {
							errors =  result.message;
					}  else {
						success = true;
						if (result != undefined && result.message != undefined) {
							$("#dialog").text(result.message);
						} else {
							$("#dialog").text(MSG_COMM_GRD_DEL);
						}
						$("#dialog").dialog({
							title: MSG_TITLE_SUCC,
							modal: true,
							buttons: {"Ok": function()  {
								$(this).dialog("close");}
							}
						});
					}

					if (result.success != undefined) {
						if (result.success == "true")	{
							success = true;
						}
					}

					if (success && _rtnFunc != undefined)	eval(_rtnFunc)(result);
				}

				// only used for adding new records
				var new_id = null;

				return [success, errors, new_id];
			}
		});
	else $( "#dialogSelectRow" ).dialog();
}


//==================   Ajax Grid Saving [ Grid Multi Data Proccess ]  : ntarget  ==================//
function submitSave(useropt) {
	var _gridName		= useropt.gridName;
	var _url				= useropt.url;
	var _userData		= useropt.userData;
	var _rtnFunc			= useropt.rtnFunc;
	var _submitType	= useropt.submitType;			// default null(undefined)
	var _msg				= useropt.msg;

	var row = $(_gridName).jqGrid('getGridParam','selrow');

	var _params = '';

	if (_submitType && _submitType === 'inline') {
		var prms = [null, ""];
		var prms = getGridJsonInlineData(_gridName);
		row = prms[0];

		_params = prms[1];

		if (prms[0] == null && prms[1] == null) {
			return;
		}
	} else {
		_params = getGridJsonData(_gridName);
	}

	if ( row != null ) {
		$.ajax({
			url:ROOT_PATH + _url,
			data:{jqGridParams:_params, jqUserParams:_userData, submitType:_submitType},
			async: false,
			dataType:"json",
			type:"POST",
			success:function(result) {
				if (result == null) {
					alert(MSG_ERR_FAIL);
				} else {
					if (result != undefined && result.success != undefined && (result.success == false || result.success == "false") ) {
						alert(result.message);
					}  else {
						if (result != undefined && result.message != undefined) {
							$("#dialog").text(result.message);
						} else {
							$("#dialog").text(MSG_SUCCESS);
						}
						$("#dialog").dialog({
							title: MSG_TITLE_SUCC,
							modal: true,
							buttons: {"Ok": function()  {
								$(this).dialog("close");}
							}
						});

						if (_rtnFunc != undefined)	eval(_rtnFunc)(result);
					}
				}

			}
			,error:function(request, status, error) {
				alert(MSG_ERR_FAIL);
				//alert(request.responseText);
			}
		});
	} else {
		$( "#dialogSelectRow" ).dialog();
	}
}


//==================   Grid Form Data To JSON : ntarget  ==================//
// selected row data. [ntarget]
function getGridJsonData(grid) {
	var ids 	= $(grid).jqGrid('getDataIDs');			// all rows
	var id 		= $(grid).getGridParam('selarrrow');	// selected row
	var cols 	= $(grid).getGridParam("colModel");

	var dat = '{"jqGridDatas":[';

	for (var i = 0; i < id.length; i++) {
		$(grid).jqGrid('restoreRow',id[i] );
		dat += "{";

		for (var ii = 0; ii < cols.length; ii++ ) {
			if (cols[ii].name != 'cb') {
				dat += '"'+cols[ii].name+'":';

				//var colValue = $(grid).jqGrid('getCol', cols[ii].name)[id[i]];	// ntarget : 2012/02/15
				var colValue = $(grid).jqGrid('getCol', cols[ii].name)[id[i] - 1];

				if (ii != (cols.length - 1))	dat += '"'+colValue+'",';
				else dat += '"'+colValue+'"';
			}
		}

		if (i != (id.length - 1))	dat += "},";
		else dat += "}";
	}

	dat += ']}';

	return dat;
}

//==================   Grid Form Data To JSON (Inline Edit) : ntarget  ==================//
// Inline Editing get Data. [ntarget]
// Multi save 처리시 사용함.
function getGridJsonInlineData(grid){
	var rows 		= $(grid).find('tr').length;
	var cols 		= $(grid).getGridParam("colModel");
	var editcnt		= null;
	var success 	= true;

	var dat = '{"jqGridDatas":[';

	$(grid).find('tr').each(function(n) {
		var $t = this, nm, val, text, editable, ind, cv;
		var ind = $(grid).jqGrid("getInd", n, true);

		editable = $(ind).attr("editable");

		if (editable==="1") {
			editcnt = 0;
			dat += "{";

			$("td", ind).each(function(i) {
				cm = cols[i];
				nm = cm.name;
				val = '';
				dat += '"'+cm.name+'":';
				if ( nm != 'cb' && nm != 'subgrid' && cm.editable===true && nm != 'rn' && !$(this).hasClass('not-editable-cell')) {
					switch (cm.edittype) {
						case "checkbox":
							var cbv = ["Yes","No"];
							if (cm.editoptions ) {
								cbv = cm.editoptions.value.split(":");
							}
							val = $("input",this).attr("checked") ? cbv[0] : cbv[1];
							break;
						case 'text':
							val = $("input, textarea",this).val();
						case 'password':
						case 'textarea':
						case "button" :
							val = $("input, textarea",this).val();
							break;
						case 'select':
							if(!cm.editoptions.multiple) {
								val	= $("select>option:selected",this).val();
								text	= $("select>option:selected", this).text();
							} else {
								var sel = $("select",this), selectedText = [];
								val = $(sel).val();
								if (val) { val = val.join(","); } else { val =""; }
								$("select > option:selected",this).each(
									function(i,selected){
										selectedText[i] = $(selected).text();
									}
								);
								text = selectedText.join(",");
							}

							if(cm.formatter && cm.formatter == 'select') { text = '';}

							break;
					}
				} else {
					if (nm == 'cb' ) 	{
						var cbv = ["Yes","No"];
						val = $("input", this).attr("checked") ? cbv[0] : cbv[1];
					}

					if ( nm != 'cb' && nm != 'subgrid') {
						val =  $(grid).jqGrid('getCol', cm.name)[n-1];   // 2012.02.21 otamot

						// (2012.04.16) added by otamot
						// different colModel type
						// 1) selectbox
						var subSelect = $(this).find("select");
						if(subSelect.size() > 0) {
						    val = subSelect.val();
						}
					}
				}
				cv = $.jgrid.gridCheckValues(val, i, grid);
				if (cv[0] === false) {
					try {
						$.jgrid.info_dialog($.jgrid.errors.errcap, val+" "+cv[1],$.jgrid.edit.bClose);
						$(grid).jqGrid("restoreCell", n, i);
					} catch (e) {}
					success = false;
					return false;
				}

				if (i != (cols.length - 1))	dat += '"'+val+'",';
				else dat += '"'+val+'"';
			});
			dat += "},";
			editcnt++;
		} else {
			// non edit type ?
		}
	});

	if (dat != "" && editcnt > 0)
	dat = dat.substr(0, dat.length -1);

	dat += ']}';

	if (!success) 		return [null, null];
	else					return [editcnt, dat];
}


//==================   Grid Functions : ntarget  ==================//
$.extend($.jgrid,{
		// Grid combo  데이터 조회.
		gridComboObject: function(url, params) {
				var values = '';

				$.ajax({
					url:ROOT_PATH+url,
					data:params,
					async: false,
					dataType:"json",
					type:"POST",
					success:function(result) {
						if(result == null ){
							alert(MSG_ERR_FAIL);
						} else {
							var totcnt = 	result.combo.length;

							for (var i = 0; i < totcnt; i++) {
								if (i == (totcnt-1)) {
									values += result.combo[i].comboValue+':'+result.combo[i].comboText;
								} else{
									values += result.combo[i].comboValue+':'+result.combo[i].comboText+';';
								}
							}
						}
					}
					,error:function(request, status, error) {
						alert(MSG_ERR_FAIL);
						//alert(request.responseText);
					}
				});

				return values;
		},
		// 선택한 Row 정보값 가져옴.
		getRowExtData : function(grid, n) {
				var cols = $(grid).getGridParam("colModel");
				var $t = this, nm, val, text, editable, ind, rowdata;
				var tmp = {};
				var ind = $(grid).jqGrid("getInd", n, true);
				editable = $(ind).attr("editable");

				if (editable==="1") {
					$("td", ind).each(function(i) {
						cm = cols[i];
						nm = cm.name;
						val = '';

						if ( nm != 'cb' && nm != 'subgrid' && cm.editable===true && nm != 'rn' && !$(this).hasClass('not-editable-cell')) {
							switch (cm.edittype) {
								case "checkbox":
									var cbv = ["Yes","No"];
									if (cm.editoptions ) {
										cbv = cm.editoptions.value.split(":");
									}
									val = $("input",this).attr("checked") ? cbv[0] : cbv[1];
									break;
								case 'text':
									val = $("input, textarea",this).val();
								case 'password':
								case 'textarea':
								case "button" :
									val = $("input, textarea",this).val();
									break;
								case 'select':
									if(!cm.editoptions.multiple) {
										val	= $("select>option:selected",this).val();
										text	= $("select>option:selected", this).text();
									} else {
										var sel = $("select",this), selectedText = [];
										val = $(sel).val();
										if (val) { val = val.join(","); } else { val =""; }
										$("select > option:selected",this).each(
											function(i,selected){
												selectedText[i] = $(selected).text();
											}
										);
										text = selectedText.join(",");
									}

									if(cm.formatter && cm.formatter == 'select') { text = '';}

									break;
							}
						} else {
							if (nm == 'cb' ) 	{
								var cbv = ["Yes","No"];
								val = $("input",this).attr("checked") ? cbv[0] : cbv[1];
							}
							if (nm != 'cb' &&  nm != 'subgrid' ) {
								val =  $(grid).jqGrid('getCol', cm.name)[n-1];                 // 2012.02.21 updated by ntarget
							}
						}
						tmp[cm.name] = val;
					});

					rowdata = tmp;

				}  else {
					rowdata = $(grid).getRowData(n);
				}

				return rowdata;
		},
		gridCheckValues : function(val, valref, grid) {
				var cols = $(grid).getGridParam("colModel");

				var edtrul,i, nm, dft, len;

				if (typeof(customobject) === "undefined") {
					if(typeof(valref)=='string'){
						for( i =0, len=cols.length;i<len; i++){
							if(cols[i].name==valref) {
								edtrul = cols[i].editrules;
								valref = i;
								try { nm = cols[i].formoptions.label; } catch (e) {}
								break;
							}
						}
					} else if(valref >=0) {
						edtrul = cols[valref].editrules;
					}
				} else {
					edtrul = customobject;
					nm = nam===undefined ? "_" : nam;
				}

				if(edtrul) {
					if(!nm) { nm = cols[valref].name; }
					if(edtrul.required === true) {
						if( this.isEmpty(val) )  { return [false,nm+": "+$.jgrid.edit.msg.required,""]; }
					}
					// force required
					var rqfield = edtrul.required === false ? false : true;
					if(edtrul.number === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
							if(isNaN(val)) { return [false,nm+": "+$.jgrid.edit.msg.number,""]; }
						}
					}
					if(typeof edtrul.minValue != 'undefined' && !isNaN(edtrul.minValue)) {
						if (parseFloat(val) < parseFloat(edtrul.minValue) ) { return [false,nm+": "+$.jgrid.edit.msg.minValue+" "+edtrul.minValue,""];}
					}
					if(typeof edtrul.maxValue != 'undefined' && !isNaN(edtrul.maxValue)) {
						if (parseFloat(val) > parseFloat(edtrul.maxValue) ) { return [false,nm+": "+$.jgrid.edit.msg.maxValue+" "+edtrul.maxValue,""];}
					}
					var filter;
					if(edtrul.email === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
						// taken from $ Validate plugin
							filter = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i;
							if(!filter.test(val)) {return [false,nm+": "+$.jgrid.edit.msg.email,""];}
						}
					}
					if(edtrul.integer === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
							if(isNaN(val)) { return [false,nm+": "+$.jgrid.edit.msg.integer,""]; }
							if ((val % 1 !== 0) || (val.indexOf('.') != -1)) { return [false,nm+": "+$.jgrid.edit.msg.integer,""];}
						}
					}
					if(edtrul.date === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
							if(cols[valref].formatoptions && cols[valref].formatoptions.newformat) {
								dft = cols[valref].formatoptions.newformat;
							} else {
								dft = cols[valref].datefmt || "Y-m-d";
							}
							if(!this.checkDate (dft, val)) { return [false,nm+": "+$.jgrid.edit.msg.date+" - "+dft,""]; }
						}
					}
					if(edtrul.time === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
							if(!this.checkTime (val)) { return [false,nm+": "+$.jgrid.edit.msg.date+" - hh:mm (am/pm)",""]; }
						}
					}
					if(edtrul.url === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
							filter = /^(((https?)|(ftp)):\/\/([\-\w]+\.)+\w{2,3}(\/[%\-\w]+(\.\w{2,})?)*(([\w\-\.\?\\\/+@&#;`~=%!]*)(\.\w{2,})?)*\/?)/i;
							if(!filter.test(val)) {return [false,nm+": "+$.jgrid.edit.msg.url,""];}
						}
					}
					if(edtrul.custom === true) {
						if( !(rqfield === false && this.isEmpty(val)) ) {
							if($.isFunction(edtrul.custom_func)) {
								var ret = edtrul.custom_func.call(grid,val,nm);
								if($.isArray(ret)) {
									return ret;
								} else {
									return [false,$.jgrid.edit.msg.customarray,""];
								}
							} else {
								return [false,$.jgrid.edit.msg.customfcheck,""];
							}
						}
					}
				}
				return [true,"",""];
		}

});
