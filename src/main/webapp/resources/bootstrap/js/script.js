$(function() {
	if(typeof isLoading === "undefined") {
		isLoading = false;
	}
	$.ajaxSetup({
		beforeSend: function(xmlHttpRequest) {
			xmlHttpRequest.setRequestHeader("AJAX", "true");
			if(isLoading) {
				$.LoadingOverlay("show");
			}
		},
		complete: function(xhr,status) {
			$.LoadingOverlay("hide");
			isLoading = false;
		},
		error: function(xhr, textStatus, errorThrown) {
			$.LoadingOverlay("hide");
			isLoading = false;
			if(xhr.status == 901) {
				window.location.href = getContextRootPath();
			} else {
				//$.alert("작업 중 에러가 발생했습니다. 관리자에게 문의해주세요. \n"+"Status: " + xhr.status + "; Error message: " + errorThrown);
			}
		}
	});
});

var timex;
//timeOut 연장을  위해서
$(window).on("click", function() {
    timex = true;
}); //finish on click

$(window).on("load", function() {
	$.LoadingOverlay("hide");
	
	if(!isEmpty($.cookie("GRID_DRAG"))){
		$.cookie("GRID_DRAG") == 'true' ? $('#draggable').prop("checked", true) : $('#draggable').prop("checked", false);
	}
	
	if(!isEmpty($.cookie("GRID_RESIZE"))){
		$.cookie("GRID_RESIZE") == 'true' ? $('#resizable').prop("checked", true) : $('#resizable').prop("checked", false);
	}
	// ========== header common ============ //
	$('.header-toggle').on('click', function(){
		let $div = $(this).children('div.dropdown-menu');
		if($div.hasClass('show')){
			$div.removeClass('show');
		}else{
			$div.addClass('show');
		}
	});
	
	$(".tui-grid-scrollbar-right-top").css('display','none');
	
	$(' .header-toggle > div.dropdown-menu').mouseleave(function(){
		$(this).removeClass('show');
	});
	
	$('.header-theme').on("click", function(){
		$('.triangle-isosceles').toggle();
	});	
	
	$('.triangle-isosceles').mouseleave(function(){
		$('.triangle-isosceles').toggle();
	});
	//SOLARWINDS HEADER
	$('input[name=headerTheme]').click(function() {
		// Header Theme
		headerThemeEv($(this).attr('id'));
	});
	//OLD HEADER DRAGABLE - SOLARWINDS HEADER
	$('.switch input:checkbox').on("change", function(){
		var checked = $(this)[0].checked, 
			id = $(this).attr('id'),
			grid = $('.grid-stack').data('gridstack'),
			option = {
				domain: document.domain,
				expires: 365,
				path: '/'
			};
		
		if(id=='draggable'){
			$.cookie("GRID_DRAG", checked, option);
			if(!isEmpty(grid)) grid.movable('.grid-stack-item', checked); //.grid.nodes.length>0 
		}else{
			$.cookie("GRID_RESIZE", checked, option);
			if(!isEmpty(grid)) grid.resizable('.grid-stack-item', checked);
		}
	});

	$(document).on("change", '#select_toparea', function() {
		let selected = $(this).find(':selected').val();
		if(selected) {
			if(selected === 'DSH_900000000000') {
				window.location = contextPath +'/dash/groupDash?dashId=' + selected;
			} else if(selected === 'DSH_900000000001') {
				window.location = contextPath +'/dash/agentDash?dashId=' + selected;
			} else {
				window.location = contextPath +'/dash/dash?dashId=' + selected;
			}
		}
		return false;
	});

	// ========== MultiSelect - 개별 select시 order 적용 가능 ============ //
	globalSortSelectedNodes = ( typeof globalSortSelectedNodes != 'undefined' && globalSortSelectedNodes instanceof Array ) ? globalSortSelectedNodes : []
	if(!isEmpty(globalSortSelectedNodes)) {
		$.each(globalSortSelectedNodes, function(el) {
			$.each(globalSortSelectedNodes[el].node, function(o) {
				globalSortSelectedNodes[el].target.multiSelect("select", String(globalSortSelectedNodes[el].node[o].nodeId));
			});
		});
	}
	globalSortSelectedGroups = ( typeof globalSortSelectedGroups != 'undefined' && globalSortSelectedGroups instanceof Array ) ? globalSortSelectedGroups : []
	if(!isEmpty(globalSortSelectedGroups)) {
		$.each(globalSortSelectedGroups, function(el) {
			$.each(globalSortSelectedGroups[el].group, function(o) {
				globalSortSelectedGroups[el].target.multiSelect("select", String(globalSortSelectedGroups[el].group[o].gid));
			});
		});
	}
	globalSortInfraSelectedGroups = ( typeof globalSortInfraSelectedGroups != 'undefined' && globalSortInfraSelectedGroups instanceof Array ) ? globalSortInfraSelectedGroups : []
	if(!isEmpty(globalSortInfraSelectedGroups)) {
		$.each(globalSortInfraSelectedGroups, function(el) {
			$.each(globalSortInfraSelectedGroups[el].group, function(o) {
				globalSortInfraSelectedGroups[el].target.multiSelect("select", String(globalSortInfraSelectedGroups[el].group[o].gid));
			});
		});
	}
	
	// ===== 무선 인프라 관리 =====//
	$('body').on('click', '.infra_bt', function(e) {
		$(this).next(".infra_table").slideToggle( "slow" );
	});
	
	// ===== Layout Option Modify Start =====//
	$('body').on('click', '.layoutOptionModifyBtn', function(e) {
		var $gridItem = $(this).parents('.grid-stack-item'),
			$dropdownItem = $(this).parents('.dropdown-menu'),
			nodeData = [],
			tagData = [],
			protocolData = [],
			typeData = [],
			deviceData = [],
			groupData = [];
		
		var widgetParam = {};
		$dropdownItem.find("input[type=text]").each(function() {
			if(!isUndefined($(this).attr('name'))) {
				widgetParam[$(this).attr('name')] = $(this).val();
			}
		});
		$dropdownItem.find("input[type=number]").each(function() {
			widgetParam[$(this).attr('name')] = $(this).val();
		});
		$dropdownItem.find(".console_sumoselect option:selected").each(function(index) {
			var selectName = $(this).closest('.console_sumoselect').attr('name');
			if(selectName == 'hour') {
				// 트래픽 현황, 응답시간 현황, 네트워크 서비스 사용현황
				widgetParam["time"] = parseInt($(this).val());
			} else if(selectName == 'hostname[]') {
				// 응답시간 현황
				nodeData.push({nodeId:$(this).val()});
			} else if(selectName == 'tagname[]') {
				// Log 발생 현황
				tagData.push({tagId:$(this).val()});
			} else if(selectName == 'protocol[]') {
				// 네트워크 서비스 사용현황
				protocolData.push({protocolId:$(this).val()});
			} else if(selectName == 'type') {
				// 프로토콜 사용현황
				widgetParam[selectName] = $(this).val();
			} else if(selectName == 'typename[]') {
				// IP SLA 운영현황
				typeData.push({typeId:$(this).val()});
			} else if(selectName == 'device') {
				var deviceInfo = $(this).val().split('::');
				var agentOId = deviceInfo[0];
				// 상세
				var paramData = getJsonParseData($gridItem.data("widgetParam"));
				if(!isEmpty(paramData)) {
					$.each(paramData.devices, function(index, item) {
						if(item.agentOId != agentOId) {
							deviceData.push({agentOId:item.agentOId,device:item.device});
						}
					});
				}
				deviceData.push({agentOId:agentOId,device:deviceInfo[1]});
			} else {
				widgetParam[selectName] = $(this).val();
			}
		});
		
		// 트래픽 현황
		var selectedInterfaceNode = $dropdownItem.find(".interfaceTree").jstree(true);
		if(selectedInterfaceNode) {
			$.each(selectedInterfaceNode.get_selected('full', true), function(index, item) {
				if($(item).attr('parent') != '#') {
					nodeData.push({nodeId:$(item).attr('li_attr')['nodeId'],interfaceNm:$(item).attr('li_attr')['interfaceNm']});
				}
			});
		}
		
		var wfn = $gridItem.attr("data-gs-fn"),
			maxSize = 0,
			dataLength = 0,
			validateCheck = true;
		if(wfn == 'cpuMemWidget') {
			// 주요장비 운영현황
			$dropdownItem.find("div.ms-selection li.ms-selected").each(function(index) {
				nodeData.push({nodeId:$(this).attr("ref"),seq:index+1});
			});
			
			maxSize = 9;
			dataLength = nodeData.length;
		} else if(wfn == 'ifRateWidget' || wfn == 'respTimeWidget') {
			// 트래픽 현황, 응답시간 현황
			maxSize = 6;
			dataLength = nodeData.length;
		} else if(wfn == 'groupWidget' || wfn == 'dgeGroupWidget' || wfn == 'groupNoBoardWidget' || wfn == 'infraWidget') {
			// 그룹 운영현황
			// 그룹 운영현황 - V2
			$dropdownItem.find("div.ms-selection li.ms-selected").each(function(index) {
				groupData.push({gid:$(this).attr("ref"),seq:index+1});
			});
			
			maxSize = groupCnt;
			dataLength = groupData.length;
		} else if(wfn == 'protocolTrafficWidget') {
			// 네트워크 서비스 사용현황
			maxSize = 6;
			dataLength = protocolData.length;
		} else if(wfn == 'ipSlaWidget') {
			// IP SLA 운영현황
			maxSize = 6;
			dataLength = typeData.length;
		} else if(wfn == 'logCustomWidget') {
			// Log 발생 현황
			maxSize = 5;
			dataLength = tagData.length;
		} else {
			validateCheck = false;
		}
		
		if(validateCheck) {
			if(dataLength > maxSize) {
				$.alert("최대 선택 가능한 갯수는 " + maxSize + "개 입니다.");
				return false;
			}
			if(dataLength == 0) {
				$.alert("1개 이상 선택하셔야 합니다.");
				return false;
			}
		}
		
		// node
		if(!isEmpty(nodeData)) {
			widgetParam["nodes"] = nodeData;
		}
		// tag
		if(!isEmpty(tagData)) {
			widgetParam["tags"] = tagData;
		}
		// protocol
		if(!isEmpty(protocolData)) {
			widgetParam["protocols"] = protocolData;
		}
		// type
		if(!isEmpty(typeData)) {
			widgetParam["types"] = typeData;
		}
		// device
		if(!isEmpty(deviceData)) {
			widgetParam["devices"] = deviceData;
		}
		// group
		if(!isEmpty(groupData)) {
			widgetParam["groups"] = groupData;
		}

		//console.log("widgetParam", JSON.stringify(widgetParam));
		$gridItem.data("widgetParam", JSON.stringify(widgetParam));

		// close dropdown
		$dropdownItem.removeClass("show");

		// redraw
		window[$gridItem.attr("data-gs-fn")]($gridItem);

		// update
		var node = $gridItem.data('_gridstack_node');
		$.ajax({
			type: 'POST',
			url: contextPath + '/dash/dashLayoutOptionUpdate',
			data: {
				layoutId: $gridItem.attr("data-gs-id"),
				widgetId: $gridItem.attr("data-gs-wid"),
				widgetX: node.x,
				widgetY: node.y,
				widgetWidth: node.width,
				widgetHeight: node.height,
				widgetParam: $gridItem.data("widgetParam")
			},
			dataType: 'json',
			success: function(data) {
				if(!data.isError) {
					$.alert(data.message);
				} else {
					$.confirm({
						title: '대시보드 저장',
						content: data.message,
						buttons: {
							저장: function () {
								saveDash('U', '');
							},
							취소: {
							}
						}
					});
				}
			}
		});
	});
	// ===== Layout Option Modify End =====//
	
	// ========== Panel Switch Full Screen ============ //
	$("body").on("click",".switch-full", function() {
		let parent = $(this).parents('.console-panel');
		parent.toggleClass('fullscreen');
		parent.hasClass('fullscreen') ? $(this).find("i").attr('class','icon dripicons-contract-2') : $(this).find("i").attr('class','icon dripicons-expand-2');
		parent.hasClass('fullscreen') ? $(".content-area").addClass('fullscreen-active') : $(".content-area").removeClass('fullscreen-active');
		return false;
	});

	// ========== Collapse Panel ============ //
	$("body").on("click",".collapse-panel", function() {
		$(this).attr('class','expand-panel').find('i').attr('class','icon dripicons-chevron-down');
		let parent = $(this).parents('.grid-stack-item');
		let currentHeight = $(parent).attr('data-gs-height');
		parent.attr('data-heighthistory',currentHeight);
	
		let minHeight = $(parent).attr('data-gs-min-height');
		if(parent.attr('data-gs-min-height')) {
			parent.attr('data-minheighthistory',minHeight);
		}
		
		var grid = $('.grid-stack').data('gridstack');
		grid.minHeight(parent , '', 3);
		grid.resize(parent , '', 3);
		grid.resizable(parent,false);
		parent.find('.console-panel-body').slideUp();
		parent.find('.console-footer').slideUp();
		return false;
	});

	// ========== Uncollapse Panel ============ //
	$("body").on("click",".expand-panel", function() {
		$(this).attr('class','collapse-panel').find('i').attr('class','icon dripicons-chevron-up');
		let parent = $(this).parents('.grid-stack-item');
		var grid = $('.grid-stack').data('gridstack');
		if (parent.attr('data-heighthistory')) {
			let heightHistory = parseInt(parent.attr('data-heighthistory'));
			grid.resize(parent , '', heightHistory);
		} else {
			grid.resize(parent , '', 20);
		}
		
		if(parent.attr('data-minheighthistory')) {
			let minHeight = parseInt(parent.attr('data-minheighthistory'));
			grid.minHeight(parent, minHeight)
		}
		
		grid.resizable(parent,true);
		parent.find('.console-panel-body').slideDown();
		parent.find('.console-footer').slideDown();
		return false;
	});

	// ========== Resize Grid ============ //
	if($("body").find('.grid-stack').length > 0) {
		$('.grid-stack').on('resizestop', function(event, ui) {
			var element = event.target;
			var container = $(element).find(".console-panel-body").get(0);
			// Dispatch Grid Resize Custom event
			setTimeout(function() {
				container.dispatchEvent(new Event('gridResize'));
			}, 200);
			
		});
	}
	
	// ========== Remove Panel ============ //
	$("body").on("click",".removeWidget", function() {
		let _this = this;
		let parent = $(this).parents('.grid-stack-item');
		$.confirm({
			theme: 'bootstrap',
			title: '삭제하시겠습니까?',
			content: '대시보드 저장 시 반영됩니다.',
			buttons: {
				confirm:{
					text: '삭제',
					btnClass: 'btn-blue',
					keys: ['enter', 'shift'],
					action: function() {
						var grid = $('.grid-stack').data('gridstack');
						var intervalId = $(parent).attr('data-gs-id');
						$(_this).parents('.console-panel').slideUp("complete", (function() {
							grid.removeWidget(parent, true);
							// delete interval
							deleteInterval(intervals, intervalId);
						}));
						$.alert('삭제되었습니다.');
					}
				},
				취소: function () {
				}
			}
		});
		return false;
	});
	
	/*=== Filter Close ===*/
	$("body").on("click", 'a.filter-close', function(){
		$(this).parents('.console-filters').addClass(`slideOut`);
	});
	$("body").on("click", 'a.filter-open', function(){
		$(this).next('.console-filters').removeClass(`slideOut`);
	});

	/*=== Tooltip ===*/
	$('[data-rel="tooltip"]').tooltip({
		container: 'body'
	});

	 // ========== Panel Header Background Color ============ //
    if($("body").find('.cp').length > 0){
          var colorpick = $('.cp');
          colorpick.colorpickerplus()
          colorpick.on("click", function(){
                return false;
          });
          $("body").on("click",".colorpickerplus",function(){
                return false;
          })
          colorpick.on('changeColor', function(e,color){
                if(color==null) {
                      //when select transparent color
                      $('.color-fill-icon', $(this)).addClass('colorpicker-color');
                } else {
                      $('.color-fill-icon', $(this)).removeClass('colorpicker-color');
                      $('.color-fill-icon', $(this)).css('background-color', color);
                      if($(this).prop('tagName')=='INPUT'){//yj 추가
                    	  $(this).prev('.color-fill').css('background-color', color);  
                      }else if($(this).prop('tagName')=='DIV'){
                    	  $(this).css('background-color', color); 
                      }
                      $(this).parents('.console-panel-header').css('background-color', color);
                }
                return false;
          });
    }

    /* 대시보드에서 Grid 클릭 시 call 되는 부분 */
	$('.tui-grid-row-odd, .tui-grid-row-even').on("click", function(){
	   var gridobj = $(this).find('.tui-grid-cell');
	   var ipDt = "", pIpDt = "";
	   $.each(gridobj, function(el) {
	       var dtcolnm = $(gridobj[el]).attr('data-column-name');
	       if (dtcolnm == 'IP_ADDR') {
	          ipDt = $(gridobj[el]).find('.tui-grid-cell-content')[0].textContent;
	       } else if (dtcolnm == 'PST_IP_ADDR'){
		      pIpDt = $(gridobj[el]).find('.tui-grid-cell-content')[0].textContent;
	       }
	   });

       var memnuchk = false;
       let contents = $('.sidebar > .sidebar-wrapper > .scroll-content').find('.sidebar-normal');
       if (ipDt != "") {
		  for (var k=0; k < contents.length; k++){
		     var htmltxt = contents[k].innerHTML;
			 if (htmltxt == '충돌 정보') {
			    memnuchk = true;
				contents[k].parentElement.click();
				break;
			 }
		  }
		  if (memnuchk == false){
		     $.alert('충돌 정보 메뉴가 존재하지 않습니다. 필요시 관리자에게 문의하세요.');
	         return false;
		  }
       }

       memnuchk = false;
       if (pIpDt != "") {
		  for (var k=0; k < contents.length; k++){
		     var htmltxt = contents[k].innerHTML;
			 if (htmltxt == '별정접수') {
			    memnuchk = true;
                var hrefStr = contents[k].parentElement.href;
                if (hrefStr.indexOf("ipaddr") < 0) { 
				   contents[k].parentElement.href = contents[k].parentElement.href + "?ipaddr="+pIpDt;
	            }
				contents[k].parentElement.click();
				break;
			 }
		  }
		  if (memnuchk == false){
		     $.alert('별정접수 메뉴가 존재하지 않습니다. 필요시 관리자에게 문의하세요.');	
		  }
       }
	});

});

function headerChkStatus(){
	$.ajax({
		type: 'POST',
		url: contextPath + '/widget/chkStatus?timex='+timex,
		data : JSON.stringify({'ps01': ''}),
		dataType: 'json',
		contentType: "application/json; charset=UTF-8",
		success: function(data) {
			if(data.isError) {
			   console.log('!ERROR:' + data.message);
			}else{
			   //time 처리를 하고 왔으므로 최기화 false로 한다.
			   timex = false;
               if (data.isAlarm == true){
				  for (var i = 0; i < $('.login > .dropdown-menu > .dropdown-item').length; i++) {
				     if ($('.login > .dropdown-menu > .dropdown-item')[i].text == "Logout") {
				         $('.login > .dropdown-menu > .dropdown-item')[i].click();
					 }
				  }	
			   }

               var chkprs1 = 0, chkprs2 = 0;
               data.statusList.forEach(function(item){
	              if (item.BATCH_TYPE == 'HT02' && item.PRSS_TYPE == 'HS02') { //별정 에서 실패가 발생한 경우
					   option = $(".haeder-right").find(".beacon_option").find(".beacon")[0];
		               $(option).removeClass("up");
                       $(option).addClass("danger");
					   $(option).find(".light").find(".light-bulb").css('display','block');
					   $(option).find(".light").find(".light-spinner").css('display','block');
					   $(option).find(".light").find(".light-front").css('display','block');  
					   $(option).find(".beam-triangle").css('display','block');
		               $(option).attr("title","별정정보수집 - 실패하였습니다.");

		               $(option).find(".light").click(function() {
		                    detailHisClickForAlarm(this,'HT02','HS02');
		               });
                       chkprs1 = 1; 
	              } 
                  if (item.BATCH_TYPE == 'HT06' && item.PRSS_TYPE == 'HS02') { //솔라윈즈에서 실패가 발생한 경우
					   option = $(".haeder-right").find(".beacon_option").find(".beacon")[1];
				       $(option).removeClass("up");
                       $(option).addClass("danger");
					   $(option).find(".light").find(".light-bulb").css('display','block');
					   $(option).find(".light").find(".light-spinner").css('display','block');
					   $(option).find(".light").find(".light-front").css('display','block');
					   $(option).find(".beam-triangle").css('display','block');
		               $(option).attr("title","내부/외부망 IP정보수집을 실패하였습니다.");

		               $(option).find(".light").click(function() {
		                    detailHisClickForAlarm(this,'HT06','HS02');
		               });
                       chkprs2 = 1;
	              }
                  if (item.BATCH_TYPE == 'HT02' && item.PRSS_TYPE == 'HS01') { //별정 에서 성공이 발생한 경우
					   option = $(".haeder-right").find(".beacon_option").find(".beacon")[0];
				       $(option).removeClass("danger");
		               $(option).addClass("up");
					   $(option).find(".light").find(".light-bulb").css('display','none');
					   $(option).find(".light").find(".light-spinner").css('display','none');
					   $(option).find(".light").find(".light-front").css('display','block');  
					   $(option).find(".beam-triangle").css('display','none');
		               $(option).attr("title","별정정보수집 - 성공하였습니다.");
		
		               $(option).find(".light").click(function() {
		                    detailHisClickForAlarm(this,'HT02','HS01');
		               });
                       chkprs1 = 1; 
	              }
                  if (item.BATCH_TYPE == 'HT06' && item.PRSS_TYPE == 'HS01') { //솔라윈즈에서 성공이 발생한 경우
					   option = $(".haeder-right").find(".beacon_option").find(".beacon")[1];
				       $(option).removeClass("danger");
		               $(option).addClass("up");
					   $(option).find(".light").find(".light-bulb").css('display','none');
					   $(option).find(".light").find(".light-spinner").css('display','none');
					   $(option).find(".light").find(".light-front").css('display','block');
					   $(option).find(".beam-triangle").css('display','none');
		               $(option).attr("title","내부/외부망 IP정보수집을 성공하였습니다.");

		               $(option).find(".light").click(function() {
		                    detailHisClickForAlarm(this,'HT06','HS01');
		               });
                       chkprs2 = 1;
	              }
			   });
               
               if (chkprs1 == 0) {
				   option = $(".haeder-right").find(".beacon_option").find(".beacon")[0];
			       $(option).removeClass("danger");
	               $(option).addClass("up");
				   $(option).find(".light").find(".light-bulb").css('display','none');
				   $(option).find(".light").find(".light-spinner").css('display','none');
				   $(option).find(".light").find(".light-front").css('display','block');  
				   $(option).find(".beam-triangle").css('display','none');
	               $(option).attr("title","별정정보수집 - 성공하였습니다.");

	               $(option).find(".light").click(function() {
	                    detailHisClickForAlarm(this,'HT02','HS01');
	               });
               }
               if (chkprs2 == 0) {
				   option = $(".haeder-right").find(".beacon_option").find(".beacon")[1];
			       $(option).removeClass("danger");
	               $(option).addClass("up");
				   $(option).find(".light").find(".light-bulb").css('display','none');
				   $(option).find(".light").find(".light-spinner").css('display','none');
				   $(option).find(".light").find(".light-front").css('display','block');
				   $(option).find(".beam-triangle").css('display','none');
	               $(option).attr("title","내부/외부망 IP정보수집을 성공하였습니다.");

	               $(option).find(".light").click(function() {
	                    detailHisClickForAlarm(this,'HT06','HS01');
	               });
               } 
			} //else
		} // success
	});
}