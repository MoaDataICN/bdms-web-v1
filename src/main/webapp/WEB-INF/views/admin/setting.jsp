<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="/resources/js/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/bdms_common.css">
<link rel="stylesheet" href="/resources/css/bdms_style.css">
<link rel="stylesheet" href="/resources/css/bdms_color.css">

<style>

    .cbox {
        display: inline-block;
        width: auto;
        min-height: 24px;
        height: auto;
        line-height: 24px;
        padding: 0;
        border: 0;
    }

    .cbox:before {
        content: "";
        display: inline-block;
        vertical-align: top;
        width: 23px;
        height: 23px;
        background: url('/resources/images/rect-check2.svg') 0 -23px no-repeat; /* 체크되지 않은 상태의 이미지 */
        background-size: 20px 48px;
    }

    /* 체크된 상태의 체크박스 */
    .cbox:checked:before {
        background: url('/resources/images/rect-check2.svg') 0 0px no-repeat; /* 체크된 상태의 이미지 */
        background-size: 20px 48px;
    }

    #adminPager {
		display:none;
	}

	.ui-state-default.ui-corner-top.ui-jqgrid-hdiv {
		background: transparent !important;
	}

	.ui-state-default.ui-th-column.ui-th-ltr {
		background : transparent !important;
	}

	.ui-jqgrid-jquery-ui td {
		background-color : transparent !important
	}

	.ui-widget.ui-widget-content, .ui-state-default.ui-corner-top.ui-jqgrid-hdiv {
		border : none !important;
	}

	.ui-jqgrid-btable tr.ui-state-hover {
		background: var(--gray-05) !important;
	}

	.ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
		background: var(--gray-05) !important;
	}

	.calendar-icon {
		z-index: 1;
	}

	table {
		width: 100% !important;
	}
</style>

<main class="main">
	<!-- Area map 위치 텍스트 -->
	<div class="area-map active mr-4px">
		<a href="#">
			<img src="/resources/images/home-map.svg" class="icon14">
			<span>Home</span>
		</a>
		<a href="#">
			<img src="/resources/images/arrow-right-gray.svg" class="icon14">
			<span>Admin Setting</span>
		</a>
	</div>
	<!-- 대시보드 타이틀 -->
	<div class="second-title">
		Account Setting
	</div>

	<!-- 주요 콘텐츠 시작 -->
	<div class="second-container mt-18px">
		<div class="content-row">
			<!-- 좌측 입력폼 그룹 -->
			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						<spring:message code="common.userNm"/>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="userNm" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						<spring:message code="common.loginId"/>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="userId" placeholder="Please enter"
							   oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						<spring:message code="common.phone"/>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="mobile" placeholder="Please enter(ex.012-3456-7890)"
							   oninput="limitLength(this, 30);">
					</div>
				</div>

				<div class="row-wrap">
					<div class="input-label01">
						<spring:message code="Admin.Type"/>
					</div>
					<div class="dropdown">
						<button class="dropdown-search" id="userTpNm">Select Admin Type<span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a onclick="$('#userTpNm').text($(this).text()); $('#userTpNm').val('N');"><spring:message code="Admin.Type.Nursing"/></a>
							<a onclick="$('#userTpNm').text($(this).text()); $('#userTpNm').val('A');"><spring:message code="Admin.Type.Ambulance"/></a>
							<a onclick="$('#userTpNm').text($(this).text()); $('#userTpNm').val('T');"><spring:message code="Admin.Type.Telehealth"/></a>
							<a onclick="$('#userTpNm').text($(this).text()); $('#userTpNm').val('H');"><spring:message code="Admin.Type.HealthManager"/></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="content-submit-ui mt-22px">
		<div class="submit-ui-wrap">
		</div>
		<div class="submit-ui-wrap">
			<button type="button" class="gray-submit-btn" id="add" onclick="fnAdd()">
				<img src="/resources/images/add-line-icon.svg" class="icon22">
				<span><spring:message code="common.btn.add"/></span>
			</button>

			<button type="button" class="gray-submit-btn" id="delete" onclick="fnDelete()">
				<img src="/resources/images/del-line-icon.svg" class="icon22">
				<span><spring:message code="common.btn.delete"/></span>
			</button>

			<button type="button" class="gray-submit-btn" id="reset" onclick="fnClear()">
				<img src="/resources/images/reset-icon.svg" class="icon22">
				<span><spring:message code="common.btn.reset"/></span>
			</button>

			<button type="button" class="point-submit-btn" id="search" onclick="fnSearch()">
				<img src="/resources/images/search-icon.svg" class="icon22">
				<span><spring:message code="common.btn.search"/></span>
			</button>
		</div>
	</div>

	<div class="table-wrap mt-36px">
		<div class="mt-16px table-data-wrap">
			<p class="second-title-status">
				<span class="bold-t-01" id="currentRowsCnt">0</span>
				<spring:message code="common.outOf"/>
				<span class="bold-t-01" id="totalResultsCnt">0</span>
				<spring:message code="common.results"/>
			</p>
			<div class="table-option-wrap">
				<div class="dropdown02">
					<button class="dropdown-search input-line-b" id="gridDropdownBtn"><spring:message code="common.viewResults" arguments="10" /> <span><img class="icon20"
																																							 alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
					<div class="dropdown-content">
						<a data-cnt="100"><spring:message code="common.viewResults" arguments="100" /></a>
						<a data-cnt="50"><spring:message code="common.viewResults" arguments="50" /></a>
						<a data-cnt="10"><spring:message code="common.viewResults" arguments="10" /></a>
					</div>
				</div>
			</div>
		</div>
		<div class="w-line01 mt-8px"></div>
		<div class="main-table">
			<div class="tableWrapper">
				<table id="adminList"></table>
				<div id="adminPager"></div>
				<div id="customPager" class="page-group mb-22px mt-10px"></div>
			</div>
		</div>
	</div>

	<!-- 일반 팝업 Popup-->
	<div class="popup-modal" id="add_popup" style="display:none">
		<div class="popup-show">

			<div class="popup-title mt-8px">Create Admin Account</div>

			<div class="popup-text">
				Please accurately enter the necessary details for the administrator registration.
			</div>

			<div class="admin-wrap">
				<div class="row-wrap">
					<div class="input-label02">
						Admin ID<span class="red-point-color">*</span>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="adminid" placeholder="Enter admin ID" oninput="limitLength(this, 30);">
					</div>
				</div>

				<div class="row-wrap">
					<div class="input-label02">
						Password<span class="red-point-color">*</span>
					</div>
					<div class="row-input">
						<input type="password" class="input-txt02" id="adminpw" placeholder="Enter password" oninput="limitLength(this, 30);">
					</div>
				</div>

				<div class="row-wrap">
					<div class="input-label02">
						Authority Type<span class="red-point-color">*</span>
					</div>
					<div class="dropdown">
						<button class="dropdown-search" id="au">Select Authority Type<span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a onclick="$('#au').text($(this).text()); $('#au').val('1');"><spring:message code="Admin.Authority.Type.system"/></a>
							<a onclick="$('#au').text($(this).text()); $('#au').val('2');"><spring:message code="Admin.Authority.Type.manager"/></a>
							<a onclick="$('#au').text($(this).text()); $('#au').val('3');"><spring:message code="Admin.Authority.Type.staff"/></a>
						</div>
					</div>
				</div>

				<div class="row-wrap">
					<c:if test="${fn:length(groupList) > 0}">
						<div class="input-label02">
							Assignment
						</div>
						<div class="dropdown">
							<button class="dropdown-search" id="grpId">Select Admin Assignment<span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
							<div class="dropdown-content">
								<c:forEach var="group" items="${groupList}">
									<a onclick="$('#grpId').text($(this).text()); $('#grpId').val('${group.GRP_ID}');" value="${group.GRP_ID}">${group.GRP_NM}</a>
								</c:forEach>
							</div>
						</div>
					</c:if>
				</div>

				<div class="row-wrap">
					<div class="input-label02">
						Admin Type<span class="red-point-color">*</span>
					</div>
					<div class="dropdown">
						<button class="dropdown-search" id="tpNm">Select Admin Type<span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a onclick="$('#tpNm').text($(this).text()); $('#tpNm').val('N');"><spring:message code="Admin.Type.Nursing"/></a>
							<a onclick="$('#tpNm').text($(this).text()); $('#tpNm').val('A');"><spring:message code="Admin.Type.Ambulance"/></a>
							<a onclick="$('#tpNm').text($(this).text()); $('#tpNm').val('T');"><spring:message code="Admin.Type.Telehealth"/></a>
							<a onclick="$('#tpNm').text($(this).text()); $('#tpNm').val('H');"><spring:message code="Admin.Type.HealthManager"/></a>
						</div>
					</div>
				</div>

				<div class="row-wrap">
					<div class="input-label02">
						Admin Name<span class="red-point-color">*</span>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="adminnm" placeholder="Enter Admin name who use it" oninput="limitLength(this, 30);">
					</div>
				</div>

				<div class="row-wrap">
					<div class="input-label02">
						Admin Phone<span class="red-point-color">*</span>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="adminphone" placeholder="Enter Phone who use it" oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>

			<button class="popup-close"><img src="/resources/images/close-icon.svg" class="icon22" id="adm_close"></button>
			<div class="popup-footer mt-16px">
				<div></div>
				<div class="btn-group">
					<button type="button" class="gray-submit-btn" id="adm_cancel">
						Cancel
					</button>
					<button type="button" class="point-submit-btn" id="adm_create">
						Save
					</button>
				</div>
			</div>
			<input type="hidden" id="showType" name="showType"/>
		</div>
	</div>

	<form name="excelForm" method="POST">
		<input type="hidden" id="sortColumn" name="sortColumn" value="reqDt"/>
		<input type="hidden" id="sord" name="sord" value="DESC"/>
	</form>

</main>

<script type="text/javascript">
	const inChargeId = '${inChargeId}';

	// Grid 하단 페이저 숫자
	const pageSize = 10;
	let currentPageGroup = 1;

	// 기본 Items 개수
	var rowNumsVal = 10;

	function fnClear() {
		$('#userNm').val('');
		$('#userId').val('');
		$('#mobile').val('');
		$('#userTpNm').val('');
		$('#userTpNm').text('Select Admin Type');
		setClearAddParam();
	}

	function setSearchParam() {
		return {
			userNm  : $('#userNm').val(),
			userId  : $('#userId').val(),
			phoneNo : $('#mobile').val().replaceAll('-',''),
			tpNm    : $('#userTpNm').val()
		};
	}

	function setAddParam(showType) {
		return {
			showType: showType,
			userId  : $('#adminid').val(),
			userPw  : $('#adminpw').val(),
			grpLv   : $('#au').val(),
			grpId   : $('#grpId').val(),
			userNm  : $('#adminnm').val(),
			tpNm    : $('#tpNm').val(),
			phoneNo : $('#adminphone').val().replaceAll('-','')
		};
	}

	function setClearAddParam() {
		$('#adminid').val('');
		$('#adminpw').val('');
		$('#adminphone').val('');
		$('#adminnm').val('');
		$('#grpId').val('');
		$('#grpId').text('Select Admin Assignment');
		$('#tpNm').val('');
		$('#tpNm').text('Select Admin Type');
		$('#au').val('');
		$('#au').text('Select Authority Type');
		$('#adminid').removeClass('hold');
		$('#adminpw').removeClass('hold');
		$("#adminpw").removeAttr("disabled");
		$("#adminid").removeAttr("disabled");
	}

	function fnSearch(){
		$('#adminList').jqGrid('setGridParam', {
			url: '${contextPath}/admin/settingList',
			datatype: 'json',
			postData : setSearchParam()
		});
		$('#adminList').trigger('reloadGrid', [{page:1, current:true}]);
	}

	$(document).ready(function() {
		$('#add_popup').hide();

		$('#adminList').jqGrid({
			url : '${contextPath}/admin/settingList',
			mtype : "POST",
			datatype: "json",
			jsonReader : {repeatitems: false},
			postData: setSearchParam(),
			colModel : [
				{ label: 'Name', name: 'userNm', width:230, sortable : false},
				{ label: 'Login ID', name: 'userId', width:200, sortable : false},
				{ label: 'Phone', name: 'phoneNo', width:200, sortable : false, formatter: function(cellValue, options, rowObject) {
						var cleaned = ('' + cellValue).replace(/\D/g, '');
						var match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
						if (match) {
							return match[1] + '-' + match[2] + '-' + match[3];
						}
						return cellValue;
				 }},
				{ label: 'Group', name: 'tpNm', width:150, sortable : true, formatter: function(cellValue, options, rowObject) {
						switch(cellValue) {
							case 'N' :
								return 'Nursing';
								break;
							case 'A' :
								return 'Ambulance';
								break;
							case 'T' :
								return 'Telehealth';
								break;
							case 'H' :
								return 'Health Manager';
								break;
							default :
								return '';
								break;
						}
				}},
				{ label: 'Last Login', name: 'loginDt', width:180, sortable : false},
				{ label: 'Creator', name: 'registId', width:180, sortable : true},
				{ label: 'Creation Date', name: 'registDt', width:180, sortable : false},
			],
			page: 1,
			autowidth: true,
			height: 'auto',
			rowNum : rowNumsVal,
			rowList:[10,50,100],
			sortable : true,
			sortname : 'registDt',
			sortorder : 'DESC',
			shrinkToFit: true,
			rownumbers: true,
			multiselect: true,
			loadonce : false,
			pager : '#adminPager',
			viewrecords: true,
			loadComplete: function(data) {
				$('#totalResultsCnt').text(data.records);
				$('#currentRowsCnt').text(data.rows.length);
				createCustomPager('adminList');
				$(this).jqGrid('setLabel', 'rn', 'No.');
			},
			gridComplete: function() {
				createCustomPager('adminList');
				$(this).jqGrid('setLabel', 'rn', 'No.');
			},
			onSortCol: function (index, columnIndex, sortOrder) {
				$("#sortColumn").val(index);
				$("#sord").val(sortOrder);
			},
			ondblClickRow: function (rowid, iRow, iCol,e) {
				$('.popup-title').html("Modify Admin Account");
				const rowData = $("#adminList").getRowData(rowid);
				var usrId = rowData.userId;
				selectAdminRowId(usrId);
			}
		})
	})

	$(window).on('resize.jqGrid', function() {
		jQuery("#adminList").jqGrid('setGridWidth', $(".table-wrap").width());
	})

	$(document).on('click','#adm_cancel', function(){
		fnClear();
		$('#add_popup').hide();
	})

	$(document).on('click','#adm_close', function(){
		fnClear();
		$('#add_popup').hide();
	})

	function validation(){
		//Admin ID Validation
		if ($('#adminid').val() != null && $('#adminid').val() != "") {
			if ($('#adminid').val().length < 4) {
				$.alert("Admin Id must have at least 4 characters.");
				return false;
			}
		} else {
			$.alert("Admin Id must have at least 4 characters.");
			return false;
		}
		//Password Validation
		if ($('#adminpw').val() != null && $('#adminpw').val() != "") {
			if ($('#adminpw').val().length < 4) {
				$.alert("Password must have at least 4 characters.");
				return false;
			}
		} else {
			$.alert("Password must have at least 4 characters.");
			return false;
		}
        //Authority Type Validation
		if ($('#au').val() == null || $('#au').val() == "") {
			$.alert("You must select an Authority Type.");
			return false;
		}
        //Admin Type Validation
		if ($('#tpNm').val() == null || $('#tpNm').val() == "") {
			$.alert("You must select an Admin Type.");
			return false;
		}
        //Admin Name Validation
		if ($('#adminnm').val() != null && $('#adminnm').val() != "") {
			if ($('#adminnm').val().length < 2) {
				$.alert("Admin Name must have at least 2 characters.");
				return false;
			}
		} else {
			$.alert("Admin Name must have at least 2 characters.");
			return false;
		}
		//Admin Phone Validation
		if ($('#adminphone').val() != null && $('#adminphone').val() != "") {
			if ($('#adminphone').val().length < 4) {
				$.alert("Admin Phone must have at least 4 characters.");
				return false;
			}
		} else {
			$.alert("Admin Phone must have at least 4 characters.");
			return false;
		}
		return true;
	}

	function selectAdminRowId(userId){
		$.ajax({
			type: 'POST',
			url: '${contextPath}/user/selectAdminById',
			data: {userId : userId},
			dataType: 'json',
			success: function(data) {
				if(data.isError){
					$.alert(data.message);
					console.log('ERROR', data.message);
				}else{
					console.log('SUCCESS', data.row);
					var rowData = data.row;

					$('#adminid').val(rowData.userId);
					$('#adminpw').val(rowData.userPw);

					$("#adminpw").attr("disabled",true);
					$('#adminid').attr("disabled",true);

					$('#adminid').addClass('hold');
					$('#adminpw').addClass('hold');

					$('#au').val(rowData.grpLv);
					if (rowData.grpLv == '1'){
						$('#au').text('<spring:message code="Admin.Authority.Type.system"/>');
					} else if (rowData.grpLv == '2'){
						$('#au').text('<spring:message code="Admin.Authority.Type.manager"/>');
					} else if (rowData.grpLv == '3'){
						$('#au').text('<spring:message code="Admin.Authority.Type.staff"/>');
					}

					$('#grpId').val(rowData.grpId);
					$('#grpId').text(rowData.grpNm);

					$('#adminnm').val(rowData.userNm);
					$('#tpNm').val(rowData.tpNm);
					if (rowData.tpNm == 'N'){
						$('#tpNm').text('<spring:message code="Admin.Type.Nursing"/>');
					} else if (rowData.tpNm == 'A'){
						$('#tpNm').text('<spring:message code="Admin.Type.Ambulance"/>');
					} else if (rowData.tpNm == 'T'){
						$('#tpNm').text('<spring:message code="Admin.Type.Telehealth"/>');
					} else if (rowData.tpNm == 'H'){
						$('#tpNm').text('<spring:message code="Admin.Type.HealthManager"/>');
					}

					$('#adminphone').val(rowData.phoneNo);
					$('#showType').val('M');
					$('#add_popup').show();
				}
			}
		});
	}

	$(document).on('click','#adm_create', function(){
		var msgcontent = "";
		var suburl = '';
		if ($('#showType').val() == 'M') {
			msgcontent = 'Would you like to save an Admin?';
			$("#adminpw").attr("disabled",true);
			$('#adminid').attr("disabled",true);
			suburl = 'adminUpdate';
		} else if ($('#showType').val() == 'A') {
			msgcontent = 'Would you like to add an Admin?';
			$("#adminpw").removeAttr("disabled");
			$("#adminid").removeAttr("disabled");
			suburl = 'adminAdd';
		}
		$.confirm({
			title: '',
			content: msgcontent,
			buttons: {
				OK: function () {
					if (validation()) {
						$.ajax({
							type: 'POST',
							url: '${contextPath}/admin/'+suburl,
							data: setAddParam(),
							dataType: 'json',
							success: function(data) {
								if(data.isError){
									showToast('Processing failed.', 'point');
									console.log('ERROR', data.message);
								}else{
									setClearAddParam();
									showToast('The admin account has been created.');
									$('#add_popup').hide();
									fnSearch();
								}
							}
						});
					}
				},
				Cancel: function () {
				}
			}
		});
	});

	function fnAdd() {
		fnClear();
		$('.popup-title').html("Create Admin Account");
		$('#showType').val('A');
		$('#add_popup').show();
	}

	function fnDelete() {

	}

	<!-- 달력 스크립트 -->
	// 달력 아이콘 클릭 시, date input 활성화
	function openCalendar(dateInputId) {
		document.getElementById(dateInputId).showPicker();
	}

	// 날짜 선택 시, 표시할 입력 필드 업데이트
	function updateDate(dateInputId, displayId) {
		const dateValue = document.getElementById(dateInputId).value;
		document.getElementById(displayId).value = dateValue;
	}

	$('.table-wrap .dropdown-content a').click(function(){
		let cnt = $(this).data('cnt');

		rowNumsVal = cnt;
		$('#gridDropdownBtn').text($(this).text());
		$("#adminList").setGridParam({ rowNum: cnt });
		fnSearch();
	})

	$('.input-txt02').keyup(function(e){
		if(e.keyCode == '13'){
			fnSearch();
		}
	});
</script>