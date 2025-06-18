<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="../../resources/js/grid/pager.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">


<style>
    #uploadStatusPager {
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
	<!-- 대시보드 타이틀 -->
	<div class="second-title" style="display:flex; justify-content:space-between;">
		Upload Status
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
						UID
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="userId" placeholder="Please enter"
						       oninput="limitLength(this, 40);">
					</div>
				</div>
			</div>
			
			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Entered By
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="enteredBy" placeholder="Please enter"
						       oninput="limitLength(this, 30);">
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						Group
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="grpNm" placeholder="Please enter"
						       oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>
			
			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						<spring:message code="common.sex"/>
					</div>
					<div class="dropdown">
						<button class="dropdown-search" id="gender"><spring:message code="common.all"/><span><img class="icon20" alt=""
						                                                                                            src="/resources/images/arrow-gray-bottom.svg"></span></button>
						<div class="dropdown-content">
							<a onclick="$('#gender').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.all"/></a>
							<a onclick="$('#gender').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.sex.f"/></a>
							<a onclick="$('#gender').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.sex.m"/></a>
						</div>
					</div>
				</div>
				<div class="row-wrap">
					<div class="input-label01">
						<spring:message code='common.birthDt'/>
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02 datePicker" id="brthDt" placeholder="Please enter"
						       oninput="limitLength(this, 30);" tabindex="4" required>
					</div>
				</div>
			</div>
			
			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Checkup Center
					</div>
					<div class="row-input">
						<input type="text" class="input-txt02" id="chckHspt" placeholder="Please enter"
						       oninput="limitLength(this, 30);">
					</div>
				</div>
			</div>
			
			<div class="row-md-100">
				<div class="row-wrap">
					<div class="input-label01">
						Checkup Date
					</div>
					<div class="row-input">
						<div class="p-r">
							<input type="text" class="date-input input-txt02" id="searchBgnDe"
							       placeholder="ALL" tabindex="6" readonly>
							<img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
							     onclick="openCalendar('datePicker1')" alt="달력 아이콘">
							<input type="date" id="datePicker1" class="hidden-date"
							       onchange="updateDate('datePicker1', 'searchBgnDe')">
						</div>
						<img src="/resources/images/minus-icon.svg" class="icon14 img-none">
						<div class="p-r">
							<input type="text" class="date-input input-txt02" id="searchEndDe"
							       placeholder="ALL" tabindex="7" readonly>
							<img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
							     onclick="openCalendar('datePicker2')" alt="달력 아이콘">
							<input type="date" id="datePicker2" class="hidden-date"
							       onchange="updateDate('datePicker2', 'searchEndDe')">
						</div>
						<div class="day-button-wrap">
							<button class="data-select-btn periodBtn" data-period="today">Today</button>
							<button class="data-select-btn periodBtn active" data-period="7-day">7day</button>
							<button class="data-select-btn periodBtn" data-period="30-day">30day</button>
							<button class="data-select-btn periodBtn" data-period="90-day">90day</button>
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
				<table id="uploadStatusList"></table>
				<div id="uploadStatusPager"></div>
				<div id="customPager" class="page-group mb-22px mt-10px"></div>
			</div>
		</div>
	</div>
	
	<form name="excelForm" method="POST">
		<input type="hidden" id="sortColumn" name="sortColumn" value="dctDt"/>
		<input type="hidden" id="sord" name="sord" value="DESC"/>
	</form>
</main>

<script type="text/javascript">
    const inChargeId = '${inChargeId}';

    var groupData = [
        <c:forEach var="group" items="${groupList}" varStatus="status">
        {
            "grpId": "${group.grpId}",
            "pgrpId": "${group.pgrpId}",
            "grpTp": "${group.grpNm}",
            "registDt": "${group.registDt}",
            "registId": "${group.registId}",
            "uptDt": "${group.uptDt}",
            "uptId": "${group.uptId}"
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // Grid 하단 페이저 숫자
    const pageSize = 10;
    let currentPageGroup = 1;

    // 기본 Items 개수
    var rowNumsVal = 10;

    function setSearchParam() {
        return {
            inChargeId : inChargeId != null && inChargeId != '' ? inChargeId : null,
            userId : $('#userId').val(),
            userNm : $('#userNm').val(),
            enteredBy : $('#enteredBy').val(),
            gender : $('#gender').text() != "All" ? $('#gender').text().slice(0,1) : "",
            brthDt : $('#brthDt').val(),
	        chckCt : $('#chckHspt').val(),
            searchBgnDe : $('#searchBgnDe').val()+' 00:00:00',
            searchEndDe : $('#searchEndDe').val()+' 23:59:59',
        };
    }

    function fnClear() {
        $('#searchBgnDe').val('');
        $('#searchEndDe').val('');
        $('#userNm').val('');
        $('#userId').val('');
        $('#enteredBy').val('');
        $('#grpNm').val('');
        $('#gender').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('All');
        $('#brthDt').val('');
        $('#chckHspt').val('');
        $('.periodBtn')[1].click();
    }

    function fnSearch(){
        $('#uploadStatusList').jqGrid('setGridParam', {
            url: 'selectUploadList',
            datatype: 'json',
            postData : setSearchParam()
        });
        $('#uploadStatusList').trigger('reloadGrid', [{page:1, current:true}]);
    }

    $(document).ready(function() {
        $('.datePicker').datepicker({
            dateFormat: 'yy-mm-dd',
            autoclose: true,
            todayHighlight:true
        });

        $('#searchBgnDe').val(moment().subtract(6,'days').format('YYYY-MM-DD'))
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'))

        $('#uploadStatusList').jqGrid({
            url : '${contextPath}/user/selectUploadList',
            mtype : "POST",
            datatype: "json",
            jsonReader : {repeatitems: false},
            postData: setSearchParam(),
            colModel : [
                { label: 'UID', name: 'userId', width:300, sortable : true},
                { label: 'User Name', name: 'userNm', width:130, sortable : false},
                { label: 'Sex', name: 'gender', width:60, sortable : true, formatter: function(cellValue, options, rowObject) {
                        if(cellValue === 'M') {
                            return '<img src="/resources/images/man-icon.svg" class="icon24 img-c">'
                        } else {
                            return '<img src="/resources/images/girl-icon.svg" class="icon24 img-c">';
                        }
                    }},
                { label: 'Date Of Birth', 	name: 'brthDt', 	width:130, sortable : false},
                { label: 'Checkup Date', 	name: 'chckDt', 	width:130, sortable : true},
                { label: 'Checkup Center', 	name: 'chckCt', 	width:130, sortable : true},
                { label: 'Entered By', 		name: 'enteredBy',  width:100, sortable : false},
                { label: 'Interfaced', 		name: 'grpcYn', 	width:60,  sortable : true, formatter: function(cellValue, options, rowObject) {
                        if(cellValue == null || cellValue === 'Y') {
                            return 'Y'
                        } else {
                            return 'N';
                        }
                    }
				},
				{ label: 'Height(cm)',                    name: 'hght',     width:100},
				{ label: 'Weight(kg)',                    name: 'wght',     width:100},
				{ label: 'Waist circumference(cm)',       name: 'wst',      width:100},
				{ label: 'Systolic Blood Pressure(mmHg)', name: 'sbp',      width:100},
				{ label: 'Diastolic Blood Pressure(mmHg)',name: 'dbp',      width:100},
				{ label: 'Fasting Blood Sugar(mg/dL)',    name: 'fbs',      width:100},
				{ label: 'HbA1C(%)',                      name: 'hba1c',    width:100},
				{ label: 'Total Cholesterol(mg/dL)',      name: 'tc',       width:100},
				{ label: 'HDL(mg/dL)',                    name: 'hdl',      width:100},
				{ label: 'LDL(mg/dL)',                    name: 'ldl',      width:100},
				{ label: 'Triglyceride(mg/dL)',           name: 'trgly',    width:100},
				{ label: 'Serum Creatinine(mg/dL)',       name: 'sc',       width:100},
				{ label: 'GFR',                           name: 'gfr',      width:100},
				{ label: 'Uric Acid(mg/dL)',              name: 'urAcd',    width:100},
				{ label: 'BUN(mg/dL)',                    name: 'bun',      width:100},
				{ label: 'ALT(IU/L)',                     name: 'alt',      width:100},
				{ label: 'ast: AST(IU/L)',                name: 'ast',      width:100},
				{ label: 'γ-GTP(IU/L)',                   name: 'gtp',      width:100},
				{ label: 'Total Protein(g/dL)',           name: 'tprtn',    width:100},
				{ label: 'Bilirubin(g/dL)',               name: 'blrbn',    width:100},
				{ label: 'ALP(IU/L)',                     name: 'alp',      width:100},
				{ label: 'comment',                       name: 'comment',  width:250},
				{ label: 'Medical Checkup Type',          name: 'mct',      width:100, hidden : true},
				{ label: 'Checkup result',                name: 'cr',       width:100, hidden : true},
				{ label: 'Regist Date',                   name: 'registDt', width:10,  hidden : true}
            ],
            page: 1,
            autowidth: true,
            height: 'auto',
            rowNum : rowNumsVal,
            rowList:[10,50,100],
            jsonReader: {
                root: "rows",             // 데이터 리스트
                page: "page",             // 현재 페이지
                total: "total",
                records: "records"        // 전체 개수
            },
            sortable : true,
            sortname : 'registDt',
            sortorder : 'DESC',
            shrinkToFit: false,
            rownumbers: true,
            loadonce : false,
            pager : '#uploadStatusPager',
            viewrecords: true,
            loadComplete: function(data) {
                console.log(data);
                $('#totalResultsCnt').text(data.records);
                $('#currentRowsCnt').text(data.rows.length);
                createCustomPager('uploadStatusList');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createCustomPager('uploadStatusList');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            onSortCol: function (index, columnIndex, sortOrder) {
                $("#sortColumn").val(index);
                $("#sord").val(sortOrder);
            }
        })
    })

    $(window).on('resize.jqGrid', function() {
        console.log('resize')
        jQuery("#uploadStatusList").jqGrid('setGridWidth', $(".table-wrap").width());
    })

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
        $('#gridDropdownBtn').contents().filter(function() {
            return this.nodeType === 3;
        }).first().replaceWith($(this).text());
        $("#uploadStatusList").setGridParam({ rowNum: cnt });
        fnSearch();
    })

    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            fnSearch();
        }
    });

    $(document).on('click', '.periodBtn', function(){
        $('.periodBtn').removeClass('active');

        $(this).addClass('active');

        var period = $(this).data('period');

        if(period === 'all') {
            $('#searchBgnDe').val('');
        } else if(period === 'today') {
            $('#searchBgnDe').val(moment().format('YYYY-MM-DD'));
            $('#searchEndDe').val(moment().format('YYYY-MM-DD'))
        } else {
            var pDay = parseInt(period.replaceAll('-day',''));

            $('#searchEndDe').val(moment().format('YYYY-MM-DD'));

            var calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
            $('#searchBgnDe').val(calcDt);
        }
    })
</script>
