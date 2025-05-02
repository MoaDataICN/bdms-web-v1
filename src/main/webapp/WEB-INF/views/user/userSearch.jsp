<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="/resources/js/script.js"></script>
<script src="/resources/js/jquery-ui.js"></script>
<script src="/resources/js/grid/pager.js"></script>
<script src="/resources/js/grid/userDtlPager.js"></script>
<script src="/resources/js/common/slide/userDtlSlide.js"></script>
<script src="/resources/js/common/utils/calcUtil.js"></script>
<script src="/resources/js/chart/doughnutChart.js"></script>
<script src="/resources/js/dropzone-min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/dropzone.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/bdms_common.css">
<link rel="stylesheet" href="/resources/css/bdms_style.css">
<link rel="stylesheet" href="/resources/css/bdms_color.css">

<style>
    #userSearch_pager {
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

    .dz-button {
        cursor: pointer;
        pointer-events: auto; /* 꼭 있어야 클릭 가능 */
    }

    .required-input {
        border: 1px solid red !important;
    }

    .required-msg {
        color: red;
        font-size: 12px;
        margin-left: 8px;
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
            <span>
                <spring:message code='common.menu.home'/>
            </span>
        </a>
        <a href="#">
            <img src="/resources/images/arrow-right-gray.svg" class="icon14">
            <span>
                <spring:message code='common.menu.userSearch'/>
            </span>
        </a>
    </div>
    <!-- 대시보드 타이틀 -->
    <div class="second-title">
        <spring:message code='common.menu.userSearch'/>
    </div>

    <!-- 주요 콘텐츠 시작 -->
    <div class="second-container mt-18px">
        <div class="content-row">
            <!-- 좌측 입력폼 그룹 -->
            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.userNm'/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 hold" id="userNm" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.loginId'/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 hold" id="emailId" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.phone'/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02" id="mobile" placeholder="Please enter(ex.012-3456-7890)"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.sex'/>
                    </div>
                    <div class="dropdown">
                        <button class="dropdown-search" id="userSearch_sxDropdown"><spring:message code='common.all'/><span><img class="icon20" alt=""
                                                                              src="/resources/images/arrow-gray-bottom.svg"></span></button>
                        <div class="dropdown-content">
                            <a onclick="userSearch_updateDropdown($('#userSearch_sxDropdown'), $(this).text())"><spring:message code='common.all'/></a>
                            <a onclick="userSearch_updateDropdown($('#userSearch_sxDropdown'), $(this).text())"><spring:message code='common.sex.f'/></a>
                            <a onclick="userSearch_updateDropdown($('#userSearch_sxDropdown'), $(this).text())"><spring:message code='common.sex.m'/></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <c:if test="${fn:length(inChargeNmList) > 0}">
                        <div class="input-label01">
                            <spring:message code='common.inCharge'/>
                        </div>
                        <div class="dropdown">
                            <button class="dropdown-search" id="userSearch_inChargeNm">
                                <spring:message code='common.all'/>
                            </button>
                            <!--
                            <div class="dropdown-content">
                                <a data-inchargeid="All" onclick="userSearch_updateDropdown($('#userSearch_inChargeNmDropdown'), $(this).text())"><spring:message code='common.all'/></a>
                                <c:forEach var="item" items="${inChargeNmList}">
                                    <a data-inchargeid="${item.inChargeId}" onclick="userSearch_updateDropdown($('#userSearch_inChargeNmDropdown'), $(this).text())">${item.inChargeNm}</a>
                                </c:forEach>
                            </div>
                            -->
                        </div>
                    </c:if>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.birthDt'/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 datePicker" id="brthDt" placeholder="Please enter"
                               oninput="limitLength(this, 30);" required>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <c:if test="${fn:length(groupList) > 0}">
                        <div class="input-label01">
                            <spring:message code='common.group'/>
                        </div>
                        <div class="dropdown">
                            <button class="dropdown-search" id="userSearch_grpTpDropdown"><spring:message code='common.all'/><span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                            <div class="dropdown-content">
                                <a data-grpid="All" onclick="userSearch_updateDropdown($('#userSearch_grpTpDropdown'), $(this).text())"><spring:message code='common.all'/></a>
                                <a data-grpid="<spring:message code='common.group.1'/>" onclick="userSearch_updateDropdown($('#userSearch_grpTpDropdown'), $(this).text())"><spring:message code='common.group.1'/></a>
                                <a data-grpid="<spring:message code='common.group.2'/>" onclick="userSearch_updateDropdown($('#userSearch_grpTpDropdown'), $(this).text())"><spring:message code='common.group.2'/></a>
                                <a data-grpid="<spring:message code='common.group.3'/>" onclick="userSearch_updateDropdown($('#userSearch_grpTpDropdown'), $(this).text())"><spring:message code='common.group.3'/></a>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.serviceTp'/>
                    </div>
                    <div class="row-input">
                        <div class="day-button-wrap02" id="userSearch_reqTp">
                            <button class="data-select-btn serviceBtns active" data-filter="serviceTpExists"><spring:message code='common.exists'/></button>
                            <button class="data-select-btn serviceBtns" data-filter="serviceTpNA"><spring:message code='common.serviceTp.NA'/></button>
                            <!--
                            <button class="data-select-btn serviceBtns active" data-filter="serviceTpAll"><spring:message code='common.all'/></button>
                            <button class="data-select-btn serviceBtns" data-filter="N"><spring:message code='common.serviceTp.N'/></button>
                            <button class="data-select-btn serviceBtns" data-filter="A"><spring:message code='common.serviceTp.A'/></button>
                            <button class="data-select-btn serviceBtns" data-filter="T"><spring:message code='common.serviceTp.T'/></button>
                            -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.alertTp'/>
                    </div>
                    <div class="row-input">
                        <div class="day-button-wrap02" id="userSearch_altTp">
                            <button class="data-select-btn active" data-filter="alertTpExists"><spring:message code='common.exists'/></button>
                            <button class="data-select-btn" data-filter="alertTpNA"><spring:message code='common.alertTp.NA'/></button>
                            <!--
                            <button class="data-select-btn active" data-filter="alertTpAll"><spring:message code='common.all'/></button>
                            <button class="data-select-btn" data-filter="A"><spring:message code='common.alertTp.A'/></button>
                            <button class="data-select-btn" data-filter="F"><spring:message code='common.alertTp.F'/></button>
                            <button class="data-select-btn" data-filter="H"><spring:message code='common.alertTp.H'/></button>
                            <button class="data-select-btn" data-filter="SL"><spring:message code='common.alertTp.SL'/></button>
                            <button class="data-select-btn" data-filter="B"><spring:message code='common.alertTp.B'/></button>
                            <button class="data-select-btn" data-filter="T"><spring:message code='common.alertTp.T'/></button>
                            <button class="data-select-btn" data-filter="ST"><spring:message code='common.alertTp.ST'/></button>
                            -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.regDt'/>
                    </div>
                    <div class="row-input">
                        <div class="p-r">
                            <input type="text" class="date-input input-txt02" id="searchBgnDe"
                                   placeholder="ALL" readonly>
                            <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
                                 onclick="openCalendar('datePicker1')" alt="달력 아이콘">
                            <input type="date" id="datePicker1" class="hidden-date"
                                   onchange="updateDate('datePicker1', 'searchBgnDe')">
                        </div>
                        <img src="/resources/images/minus-icon.svg" class="icon14 img-none">
                        <div class="p-r">
                            <input type="text" class="date-input input-txt02" id="searchEndDe"
                                   placeholder="ALL" readonly>
                            <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
                                 onclick="openCalendar('datePicker2')" alt="달력 아이콘">
                            <input type="date" id="datePicker2" class="hidden-date"
                                   onchange="updateDate('datePicker2', 'searchEndDe')">
                        </div>
                        <div class="day-button-wrap" id="userSearch_date">
                            <button class="data-select-btn" data-period="today">Today</button>
                            <button class="data-select-btn active" data-period="7-day">7day</button>
                            <button class="data-select-btn" data-period="30-day">30day</button>
                            <button class="data-select-btn" data-period="90-day">90day</button>
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
            <button type="button" class="gray-submit-btn" onclick="userSearch_fnClear()">
                <img src="/resources/images/reset-icon.svg" class="icon22">
                <span><spring:message code='common.btn.reset'/></span>
            </button>

            <button type="button" class="point-submit-btn" id="search" onclick="userSearch_fnSearch()">
                <img src="/resources/images/search-icon.svg" class="icon22">
                <span><spring:message code='common.btn.search'/></span>
            </button>
        </div>
    </div>

    <div class="table-wrap mt-36px">
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">
                <span class="bold-t-01" id="searchCurrentRowsCnt">0</span>
                <spring:message code='common.outOf'/>
                <span class="bold-t-01" id="searchTotalResultsCnt">0</span>
                <spring:message code='common.results'/>
            </p>
            <div class="table-option-wrap">
                <div class="dropdown02">
                    <button class="dropdown-search input-line-b" id="userSearch_gridDropdownBtn"><spring:message code='common.viewResults' arguments="10" /> <span><img class="icon20"
                                                                                            alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                    <div class="dropdown-content" id="userSearch_viewCntDropdown">
                        <a data-cnt="100"><spring:message code='common.viewResults' arguments="100" /></a>
                        <a data-cnt="50"><spring:message code='common.viewResults' arguments="50" /></a>
                        <a data-cnt="10"><spring:message code='common.viewResults' arguments="10" /></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="w-line01 mt-8px"></div>
        <div class="main-table">
            <div class="tableWrapper">
                <table id="userSearch_grid"></table>
                <div id="userSearch_pager"></div>
                <div id="customPager" class="page-group mb-22px mt-10px"></div>
            </div>
        </div>
    </div>

    <!-- 우측 슬라이드 팝업 -->
    <!-- 슬라이드 팝업 활성화 시 표시되는 반투명 배경 -->
    <div class="slide-overlay" id="slideOverlay"></div>

    <!-- 우측에서 슬라이드 되는 팝업 -->
    <div class="customer-popup" id="customerPopup">
        <!-- 팝업 상단 헤더 -->
        <div class="popup-header">
            <div class="second-title">
                <spring:message code='common.menu.userDetails'/>
            </div>
            <button type="button" class="closePopup">
                <img src="/resources/images/close-icon.svg" class="icon24">
            </button>
        </div>

        <!-- userDetail 탭 삽입 영역 -->
        <div class="userdtl-slide-popup-container" data-uid="">
            <!-- userDtlGeneral.jsp 등 동적 탭 콘텐츠 -->
        </div>

        <!-- 팝업 삽입 영역 -->
        <div class="reset-pw-popup-container">
        </div>

        <div class="check-pw-popup-container">
        </div>
    </div>

    <!-- 팝업 삽입 영역 -->
    <div class="charge-search-popup-container">
    </div>

    <form name="excelForm" method="POST">
        <input type="hidden" id="userSearch_sortColumn" name="sortColumn" value="reqDt"/>
        <input type="hidden" id="userSearch_sort" name="sord" value="DESC"/>
    </form>
</main>

<script type="text/javascript">
    // Grid 하단 페이지 숫자
    let pageSize = 10;
    let currentPageGroup = 1;

    // 기본 Items 개수
    let rowNumsVal = 10;

    const gridPagingState = {
        userSearch_grid: {
            pageSize: 10,
            currentPageGroup: 1,
            rowNumsVal: 10
        },
        healthAlerts_grid: {
            pageSize: 10,
            currentPageGroup: 1,
            rowNumsVal: 10
        },
        serviceRequests_grid: {
            pageSize: 10,
            currentPageGroup: 1,
            rowNumsVal: 10
        }
        // 추가할 그리드는 여기에 계속 추가
    };

    let inChargeId = "";
    let inChargeNm = "";

    // 담당자명 팝업 열기
    $(document).on('click', '#userSearch_inChargeNm', function () {
        $(".charge-search-popup-container").load("/user/chargeSearchPopup", function () {
            $('#chargeSearchPopup').fadeIn();
        });
    });

    function userSearch_updateDropdown($button, newText) {
        const $textNode = $button.contents().filter(function () {
            return this.nodeType === 3; // 텍스트 노드만 선택
        }).first();

        if ($textNode.length) {
            $textNode[0].nodeValue = newText + ' ';
        } else {
            $button.prepend(document.createTextNode(newText + ' '));
        }
    }

    // 검색 조건 초기화
    function userSearch_fnClear() {
        // 텍스트 필드 초기화
        $('#userNm').val('');
        $('#emailId').val('');
        $('#searchBgnDe').val(moment().subtract(7, 'days').format('YYYY-MM-DD'));
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'));
        $('#mobile').val('');
        $('#userSearch_inChargeNm').text("All");
        $('#brthDt').val('');
        //$('#userId').val('');

        // 드롭다운 내부 <a> 클릭으로 All 초기화 (텍스트 & 속성 다 처리됨)
        $('#userSearch_sxDropdown').siblings('.dropdown-content').find('a:contains("All")').click();
        //$('#userSearch_inChargeNmDropdown').siblings('.dropdown-content').find('a[data-inchargeid="All"]').click();
        //$('#userSearch_inChargeNmDropdown').siblings('.dropdown-content').find('a[data-inchargeid="All"]').click();
        $('#userSearch_grpTpDropdown').siblings('.dropdown-content').find('a[data-grpid="All"]').click();

        // 버튼 상태 초기화
        $('#userSearch_reqTp .data-select-btn')[0].click();
        $('#userSearch_altTp .data-select-btn')[0].click();
        $('#userSearch_date .data-select-btn')[1].click();

        // 검색 실행
        userSearch_fnSearch();
    }

    // 검색 조건 설정
    function userSearch_setSearchParam() {
        return {
            //inChargeId : inChargeId != null && inChargeId != '' ? inChargeId : null,
            searchBgnDe : $('#searchBgnDe').val(),
            searchEndDe : $('#searchEndDe').val() + ' 23:59:59',
            userNm : $('#userNm').val(),
            emailId : $('#emailId').val(),
            userId : $('#userId').val(),
            mobile : $('#mobile').val().replaceAll('-',''),
            sx : $('#userSearch_sxDropdown').text().trim() !== "All" ? $('#userSearch_sxDropdown').text().trim().charAt(0) : "",
            brthDt : $('#brthDt').val(),
            inChargeNm : $('#userSearch_inChargeNm').text().trim() !== "All" ? $('#userSearch_inChargeNm').text().trim() : "",
            //inChargeNm: $('#userSearch_inChargeNmDropdown').text().trim() !== "All" ? $('#userSearch_inChargeNmDropdown').text().trim() : "",
            grpTp : $('#userSearch_grpTpDropdown').text().trim() !== "All" ? $('#userSearch_grpTpDropdown').text().trim() : "",
            // 기존 reqTp/altTp → Exists, N/A로 단순화
            reqTp: $('.serviceBtns.active').data('filter') === 'serviceTpExists'
                ? "Exists"
                : "N/A",
            altTp: $('#userSearch_altTp .data-select-btn.active').data('filter') === 'alertTpExists'
                ? "Exists"
                : "N/A"
        };
    }

    // 검색
    function userSearch_fnSearch(){
        $('#userSearch_grid').jqGrid('setGridParam', {
            url: '/user/selectUserSearch',
            datatype: 'json',
            postData: userSearch_setSearchParam()
        });
        $('#userSearch_grid').trigger('reloadGrid', [{page:1, current:true}]);
    }

    $(document).ready(function() {
        $('.datePicker').datepicker({
            dateFormat: 'yy-mm-dd',
            autoclose: true,
            todayHighlight:true
        });

        $('#searchBgnDe').val(moment().subtract(7,'days').format('YYYY-MM-DD'))
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'))

        $('#userSearch_grid').jqGrid({
            url: '/user/selectUserSearch',
            mtype: "POST",
            datatype: "json",
            jsonReader: {repeatitems: false},
            postData: userSearch_setSearchParam(),
            colModel: [
                //{ label: 'UID', name: 'userId', width:300, sortable : true},
                { label: 'Registration Date', name: 'registDt', width: 200, sortable: true,
                    formatter: function(cellValue, options, rowObject) {
                        return cellValue ? cellValue.substring(0, 10) : '-';
                    }
                },
                { label: 'User Name', name: 'userNm', width:130, sortable : false},
                { label: 'Phone', name: 'mobile', width:130, sortable : false, formatter: function(cellValue, options, rowObject) {
                        let cleaned = ('' + cellValue).replace(/\D/g, '');
                        let match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
                        if (match) {
                            return match[1] + '-' + match[2] + '-' + match[3];
                        }
                        return cellValue;
                    }},
                { label: 'Sex', name: 'sx', width:60, sortable : true, formatter: function(cellValue, options, rowObject) {
                        if(cellValue === 'M') {
                            return '<img src="/resources/images/man-icon.svg" class="icon24 img-c">'
                        } else {
                            return '<img src="/resources/images/girl-icon.svg" class="icon24 img-c">';
                        }
                    }},
                { label: 'Login ID', name: 'emailId', width:130, sortable : false},
                { label: 'Date Of Birth', name: 'brthDt', width:130, sortable : false},
                { label: 'Group', name: 'grpTp', width:130, sortable : true},
                { label: 'In Charge', name: 'inChargeNm', width:130, sortable : false},
                { label: 'Requested Type', name: 'reqTp', width:120, sortable: false, formatter: function(value) {
                    switch (value) {
                        case 'Exists': return 'Exists';
                        case 'N': return 'Exists';
                        case 'A': return 'Exists';
                        case 'T': return 'Exists';
                        default: return value || 'N/A';
                    }
                }},
                { label: 'Alert Type', name: 'altTp', width:120, sortable: false, formatter: function(value) {
                    switch (value) {
                        case 'Exists': return 'Exists';
                        case 'A': return 'Exists';
                        case 'F': return 'Exists';
                        case 'H': return 'Exists';
                        case 'SL': return 'Exists';
                        case 'B': return 'Exists';
                        case 'T': return 'Exists';
                        case 'ST': return 'Exists';
                        default: return value || 'N/A';
                    }
                }},
                /* serviceBtns, alertBtns : 다중 선택
                { label: 'Requested Time', name: 'reqDt', width:200, sortable : true},
                { label: 'Requested Type', name: 'reqTp', width:130, sortable : true, formatter: function(cellValue, options, rowObject) {
                        if (cellValue === 'N') {
                            return 'Nursing';
                        } else if(cellValue === 'A'){
                            return 'Ambulance';
                        } else if(cellValue === 'T') {
                            return 'TeleHealth';
                        } else {
                            cellValue;
                        }
                    }},
                {
                    label: 'Alert Type',
                    name: 'altTp',
                    width: 130,
                    sortable: true,
                    formatter: function(cellValue) {
                        switch(cellValue) {
                            case 'A': return 'Activity';
                            case 'F': return 'Falls';
                            case 'H': return 'Heart Rate';
                            case 'SL': return 'Sleep';
                            case 'B': return 'Blood Oxygen';
                            case 'T': return 'Temperature';
                            case 'ST': return 'Stress';
                            default: return cellValue || '-';
                        }
                    }
                },
                */
                {
                    label: 'Details',
                    name: 'details',
                    width: 80,
                    sortable: false,
                    formatter: function(cellValue, options, rowObject) {
                        return `
                            <button type="button" class="detail-btn open-slide-btn" data-uid="` + rowObject.userId + `">
                                <span>detail</span>
                                <img src="/resources/images/arrow-right-nomal.svg" class="icon18">
                            </button>
                        `;
                    }
                }
            ],
            page: 1,
            autowidth: true,
            height: 'auto',
            rowNum: rowNumsVal,
            rowList:[10,50,100],
            sortable: true,
            sortname: 'reqDt',
            sortorder: 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            loadonce: false,
            pager: '#userSearch_pager',
            viewrecords: true,
            loadComplete: function(data) {
                $('#searchTotalResultsCnt').text(data.records);
                $('#searchCurrentRowsCnt').text(data.rows.length);
                createCustomPager('userSearch_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createCustomPager('userSearch_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            onSortCol: function (index, columnIndex, sortOrder) {
                //alert(index);
                $("#userSearch_sortColumn").val(index);
                $("#userSearch_sord").val(sortOrder);
            }
        })
    })

    $(window).on('resize.jqGrid', function() {
        jQuery("#userSearchTable").jqGrid('setGridWidth', $(".table-wrap").width());
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

    // 검색일 계산
    $(document).on('click', '#userSearch_date .data-select-btn', function(){
        //console.log('✅ search data-select-btn clicked!');

        $('#userSearch_date .data-select-btn').removeClass('active');

        $(this).addClass('active');

        let period = $(this).data('period');

        if (period === 'today') {
            $('#searchBgnDe').val(moment().format('YYYY-MM-DD'));
            $('#searchEndDe').val(moment().format('YYYY-MM-DD'));
        } else {
            let pDay = parseInt(period.replaceAll('-day',''), 10);

            $('#searchEndDe').val(moment().format('YYYY-MM-DD'));

            let calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
            $('#searchBgnDe').val(calcDt);
        }
    })

    // serviceBtns : 단일 선택
    $(document).on('click', '#userSearch_reqTp .data-select-btn', function () {
        $('#userSearch_reqTp .data-select-btn').removeClass('active');  // 모든 버튼에서 active 제거
        $(this).addClass('active');  // 클릭된 버튼에만 active 추가
    });

    // #userSearch_altTp .data-select-btn.active : 단일 선택
    $(document).on('click', '#userSearch_altTp .data-select-btn', function () {
        $('#userSearch_altTp .data-select-btn').removeClass('active');  // 모든 버튼에서 active 제거
        $(this).addClass('active');  // 클릭된 버튼에만 active 추가
    });

    $('.table-wrap #userSearch_viewCntDropdown a').click(function(){
        let cnt = $(this).data('cnt');

        rowNumsVal = cnt;
        $('#userSearch_gridDropdownBtn').text($(this).text());
        $("#userSearch_grid").setGridParam({ rowNum: cnt });
        userSearch_fnSearch();
    })

/* 바로 검색
    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            userSearch_fnSearch();
        }
    });
*/

    // logout
    $(document).on('click','.logout_icon30', function() {
        window.location.href='<c:url value="/login/logout"/>';
    });
</script>