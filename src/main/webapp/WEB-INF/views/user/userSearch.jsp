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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bdms_common.css">

<script src="../../resources/js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="../../resources/js/chart/doughnutChart.js"></script>

<script src="/resources/js/jquery-ui.js"></script>
<script src="/resources/js/dropzone-min.js"></script>
<link rel="stylesheet" href="/resources/css/dropzone.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/bdms_common.css">
<link rel="stylesheet" href="/resources/css/bdms_style.css">
<link rel="stylesheet" href="/resources/css/bdms_color.css">

<style>
    #userRequestPager {
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
                        <spring:message code='common.uid'/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 hold" id="userId" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.sex'/>
                    </div>
                    <div class="dropdown">
                        <button class="dropdown-search" id="sx"><spring:message code='common.all'/><span><img class="icon20" alt=""
                                                                              src="/resources/images/arrow-gray-bottom.svg"></span></button>
                        <div class="dropdown-content">
                            <a onclick="$('#sx').text($(this).text())"><spring:message code='common.all'/></a>
                            <a onclick="$('#sx').text($(this).text())"><spring:message code='common.sex.f'/></a>
                            <a onclick="$('#sx').text($(this).text())"><spring:message code='common.sex.m'/></a>
                        </div>
                    </div>
                </div>
                <div class="row-wrap">
                    <c:if test="${fn:length(inChargeNmList) > 0}">
                        <div class="input-label01">
                            <spring:message code='common.inCharge'/>
                        </div>
                        <div class="dropdown">
                            <button class="dropdown-search" id="inChargeNm"><spring:message code='common.all'/><span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                            <div class="dropdown-content">
                                <a data-inchargeid="All" onclick="$('#inChargeNm').text($(this).text())"><spring:message code='common.all'/></a>
                                <c:forEach var="item" items="${inChargeNmList}">
                                    <a data-inchargeid="${item.inChargeId}" onclick="$('#inChargeNm').text($(this).text())">${item.inChargeNm}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.birthDt'/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 datePicker" id="brthDt" placeholder="Please enter"
                               oninput="limitLength(this, 30);" required>
                    </div>
                </div>
                <div class="row-wrap">
                    <c:if test="${fn:length(groupList) > 0}">
                        <div class="input-label01">
                            <spring:message code='common.group'/>
                        </div>
                        <div class="dropdown">
                            <button class="dropdown-search" id="grpTp"><spring:message code='common.all'/><span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                            <div class="dropdown-content">
                                <a data-grpid="All" onclick="$('#grpTp').text($(this).text())"><spring:message code='common.all'/></a>
                                <a data-grpid="<spring:message code='common.group.1'/>" onclick="$('#grpTp').text($(this).text())"><spring:message code='common.group.1'/></a>
                                <a data-grpid="<spring:message code='common.group.2'/>" onclick="$('#grpTp').text($(this).text())"><spring:message code='common.group.2'/></a>
                                <a data-grpid="<spring:message code='common.group.3'/>" onclick="$('#grpTp').text($(this).text())"><spring:message code='common.group.3'/></a>
                            </div>
                        </div>
                    </c:if>
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
                        <div class="day-button-wrap" id="search_date">
                            <button class="data-select-btn" data-period="all">All</button>
                            <button class="data-select-btn" data-period="today">Today</button>
                            <button class="data-select-btn" data-period="7-day">7day</button>
                            <button class="data-select-btn active" data-period="30-day">30day</button>
                            <button class="data-select-btn" data-period="90-day">90day</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code='common.serviceTp'/>
                    </div>
                    <div class="row-input">
                        <div class="day-button-wrap02">
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
                        <div class="day-button-wrap02">
                            <button class="data-select-btn alertBtns active" data-filter="alertTpExists"><spring:message code='common.exists'/></button>
                            <button class="data-select-btn alertBtns" data-filter="alertTpNA"><spring:message code='common.alertTp.NA'/></button>
                            <!--
                            <button class="data-select-btn alertBtns active" data-filter="alertTpAll"><spring:message code='common.all'/></button>
                            <button class="data-select-btn alertBtns" data-filter="A"><spring:message code='common.alertTp.A'/></button>
                            <button class="data-select-btn alertBtns" data-filter="F"><spring:message code='common.alertTp.F'/></button>
                            <button class="data-select-btn alertBtns" data-filter="H"><spring:message code='common.alertTp.H'/></button>
                            <button class="data-select-btn alertBtns" data-filter="SL"><spring:message code='common.alertTp.SL'/></button>
                            <button class="data-select-btn alertBtns" data-filter="B"><spring:message code='common.alertTp.B'/></button>
                            <button class="data-select-btn alertBtns" data-filter="T"><spring:message code='common.alertTp.T'/></button>
                            <button class="data-select-btn alertBtns" data-filter="ST"><spring:message code='common.alertTp.ST'/></button>
                            -->
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
            <button type="button" class="gray-submit-btn" id="reset" onclick="search_fnClear()">
                <img src="/resources/images/reset-icon.svg" class="icon22">
                <span><spring:message code='common.btn.reset'/></span>
            </button>

            <button type="button" class="point-submit-btn" id="search" onclick="search_fnSearch()">
                <img src="/resources/images/search-icon.svg" class="icon22">
                <span><spring:message code='common.btn.search'/></span>
            </button>
        </div>
    </div>

    <div class="table-wrap mt-36px">
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">
                <span class="bold-t-01" id="currentRowsCnt">0</span>
                <spring:message code='common.outOf'/>
                <span class="bold-t-01" id="totalResultsCnt">0</span>
                <spring:message code='common.results'/>
            </p>
            <div class="table-option-wrap">
                <div class="dropdown02">
                    <button class="dropdown-search input-line-b" id="gridDropdownBtn"><spring:message code='common.viewResults' arguments="10" /> <span><img class="icon20"
                                                                                            alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                    <div class="dropdown-content" id="search_viewCntDropdown">
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
                <table id="userSearchTable"></table>
                <div id="userRequestPager"></div>
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
            <button type="button" id="closePopup">
                <img src="/resources/images/close-icon.svg" class="icon24">
            </button>
        </div>

        <!-- fetch로 로드된 userDetail 탭 삽입 영역 -->
        <div class="slide-popup-container">
            <!-- userDtlGeneral.jsp 등 동적 탭 콘텐츠 -->
        </div>

        <!-- 팝업 삽입 영역 -->
        <div class="reset-pw-popup-container">
        </div>

        <div class="check-pw-popup-container">
        </div>
    </div>

    <form name="excelForm" method="POST">
        <input type="hidden" id="sortColumn" name="sortColumn" value="reqDt"/>
        <input type="hidden" id="sord" name="sord" value="DESC"/>
    </form>
</main>

<script type="text/javascript">
    const userSearch_messages = {
        f: "<spring:message code='common.sex.f'/>",
        m: "<spring:message code='common.sex.m'/>",
        active: "<spring:message code='common.active'/>",
        suspended: "<spring:message code='common.suspended'/>",
        readyToDelete: "<spring:message code='common.readyToDelete'/>",
        select: "<spring:message code='common.select'/>"
    };

    // Grid 하단 페이지 숫자
    let pageSize = 10;
    let currentPageGroup = 1;

    // 기본 Items 개수
    var rowNumsVal = 10;

    let reqId = "${reqId}";
    let inChargeId = "${inChargeId}";

    // userDtlGeneral : 기존 값 저장
    let userDtlGeneral = {};

    function extractUserDtlGeneralFromDOM() {
        userDtlGeneral = {
            userNm: $("#general_userNm").val() || "-",
            emailId: $("#general_emailId").val() || "-",
            mobile: $("#general_mobile").val() || "",
            userId: $("#general_userId").val() || "-",
            brthDt: $("#general_brthDt").val() || "",
            height: $("#general_height").val() || "",
            registDt: $("#general_registDt").val() || "-",
            weight: $("#general_weight").val() || "",
            lastAccess: $("#general_lastAccess").val() || "-",
            addr: $("#general_addr").val() || "",
            wdDt: $("#general_wdDt").val() || "",
            mmo: $("#general_mmo").val() || "",
            uptDt: $("#general_uptDt").val() || "-",
            uptId: $("#general_uptId").val() || "-",
            sx: $("#general_sxDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userSearch_messages.select,
            inChargeNm: $("#general_inChargeNmDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userSearch_messages.select,
            grpTp: $("#general_grpTpDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userSearch_messages.select,
            wdYn: $("#general_statusDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userSearch_messages.select
        };
    }

    // 검색 조건 초기화
    function search_fnClear() {
        $('#searchBgnDe').val('');
        $('#searchEndDe').val('');
        $('#userNm').val('');
        $('#emailId').val('');
        $('#userId').val('');
        $('#mobile').val('');
        $("#sx").text('All');
        $('#brthDt').val('');
        $('#inChargeNm').text('All');
        $('#grpTp').text('All');
        $('.serviceBtns.active').removeClass('active');
        $('.serviceBtns')[0].classList.add('active');
        $('.alertBtns.active').removeClass('active');
        $('.alertBtns')[0].classList.add('active');
        $('#search_date .data-select-btn.active')[3].click();
    }

    // 검색 조건 설정
    function search_setSearchParam() {
        return {
            inChargeId : inChargeId != null && inChargeId != '' ? inChargeId : null,
            searchBgnDe : $('#searchBgnDe').val()+' 00:00:00',
            searchEndDe : $('#searchEndDe').val()+' 23:59:59',
            userNm : $('#userNm').val(),
            emailId : $('#emailId').val(),
            userId : $('#userId').val(),
            mobile : $('#mobile').val().replaceAll('-',''),
            sx : $('#sx').text() != "All" ? $('#sx').text().slice(0,1) : "ALL",
            brthDt : $('#brthDt').val(),
            inChargeNm: $('#inChargeNm').text().trim() !== "All" ? $('#inChargeNm').text().trim() : "",
            grpTp : $('#grpTp').text().trim() !== "All" ? $('#grpTp').text().trim() : "",
            // 기존 reqTp/altTp → Exists, N/A로 단순화
            reqTp: $('.serviceBtns.active').data('filter') === 'serviceTpExists'
                ? "Exists"
                : "N/A",
            altTp: $('.alertBtns.active').data('filter') === 'alertTpExists'
                ? "Exists"
                : "N/A",
            /* serviceBtns, alertBtns : 다중 선택
            reqTp : $('.serviceBtns.active').data('filter') != 'serviceTpAll' ? $('.serviceBtns.active')
                .map(function() {
                    return "\"" + $(this).data('filter') + "\"";
                })
                .get()
                .join(',') : "'N','A','T'",
            altTp : $('.alertBtns.active').data('filter') != 'alertTpAll' ? $('.alertBtns.active')
                .map(function() {
                    return "\"" + $(this).data('filter') + "\"";
                })
                .get()
                .join(',') : ""
            */
        };
    }

    // 검색
    function search_fnSearch(){
        $('#userSearchTable').jqGrid('setGridParam', {
            url: '/user/selectUserSearch',
            datatype: 'json',
            postData : search_setSearchParam()
        });
        $('#userSearchTable').trigger('reloadGrid', [{page:1, current:true}]);
    }

    $(document).ready(function() {
        $('.datePicker').datepicker({
            dateFormat: 'yy-mm-dd',
            autoclose: true,
            todayHighlight:true
        });

        $('#searchBgnDe').val(moment().subtract(30,'days').format('YYYY-MM-DD'))
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'))

        $('#userSearchTable').jqGrid({
            url : '/user/selectUserSearch',
            mtype : "POST",
            datatype: "json",
            jsonReader : {repeatitems: false},
            postData: search_setSearchParam(),
            colModel : [
                { label: 'UID', name: 'userId', width:300, sortable : true},
                { label: 'Registration Date', name: 'registDt', width:200, sortable : true},
                { label: 'User Name', name: 'userNm', width:130, sortable : false},
                { label: 'Phone', name: 'mobile', width:130, sortable : false, formatter: function(cellValue, options, rowObject) {
                        var cleaned = ('' + cellValue).replace(/\D/g, '');
                        var match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
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
                            <button type="button" class="detail-btn open-slide-btn" data-reqid="` + rowObject.reqId + `">
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
            rowNum : rowNumsVal,
            rowList:[10,50,100],
            sortable : true,
            sortname : 'reqDt',
            sortorder : 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            loadonce : false,
            pager : '#userRequestPager',
            viewrecords: true,
            loadComplete: function(data) {
            console.log("전체 데이터 rows : " + data.rows);
                $('#totalResultsCnt').text(data.records);
                $('#currentRowsCnt').text(data.rows.length);
                createCustomPager('userSearchTable');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createCustomPager('userSearchTable');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            onSortCol: function (index, columnIndex, sortOrder) {
                //alert(index);
                $("#sortColumn").val(index);
                $("#sord").val(sortOrder);
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
    $(document).on('click', '#search_date .data-select-btn', function(){
        console.log('✅ search data-select-btn clicked!');
        $('#search_date .data-select-btn').removeClass('active');

        $(this).addClass('active');

        let period = $(this).data('period');

        if(period === 'all') {
            $('#searchBgnDe').val('');
        } else if(period === 'today') {
            $('#searchBgnDe').val(moment().format('YYYY-MM-DD'));
            $('#searchEndDe').val(moment().format('YYYY-MM-DD'))
        } else {
            var pDay = parseInt(period.replaceAll('-day',''), 10);

            $('#searchEndDe').val(moment().format('YYYY-MM-DD'));

            var calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
            $('#searchBgnDe').val(calcDt);
        }
    })

    // serviceBtns : 단일 선택
    $(document).on('click', '.serviceBtns', function () {
        $('.serviceBtns').removeClass('active');  // 모든 버튼에서 active 제거
        $(this).addClass('active');  // 클릭된 버튼에만 active 추가
    });

    // alertBtns : 단일 선택
    $(document).on('click', '.alertBtns', function () {
        $('.alertBtns').removeClass('active');  // 모든 버튼에서 active 제거
        $(this).addClass('active');  // 클릭된 버튼에만 active 추가
    });

    /* serviceBtns, alertBtns : 다중 선택
    $(document).on('click','.serviceBtns', function(){
        if($('.serviceBtns.active').length === 1 && $('.serviceBtns.active')[0] == this){
            return;
        }

        if(this.dataset['filter'] === 'serviceTpAll') {
            $('.serviceBtns').removeClass('active');

            $(this).addClass('active');
        } else {
            $('[data-filter="serviceTpAll"]').removeClass('active');
            $(this).toggleClass('active');
        }
    })

    $(document).on('click','.alertBtns', function(){
        if($('.alertBtns.active').length === 1 && $('.alertBtns.active')[0] == this){
            return;
        }

        if(this.dataset['filter'] === 'alertTpAll') {
            $('.alertBtns').removeClass('active');

            $(this).addClass('active');
        } else {
            $('[data-filter="alertTpAll"]').removeClass('active');
            $(this).toggleClass('active');
        }
    })
    */

    $('.table-wrap #search_viewCntDropdown a').click(function(){
        let cnt = $(this).data('cnt');

        rowNumsVal = cnt;
        $('#gridDropdownBtn').text($(this).text());
        $("#userSearchTable").setGridParam({ rowNum: cnt });
        search_fnSearch();
    })

    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            search_fnSearch();
        }
    });

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////// slide ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // 우측에서 나타나는 슬라이드 팝업 열기
    function openPopup() {
        $('#customerPopup').addClass('active');
        $('#slideOverlay').addClass('active');
        document.body.classList.add('no-scroll');
    }

    // 우측에서 나타나는 슬라이드 팝업 닫기
    function closePopup() {
        $('#customerPopup').removeClass('active');
        $('#slideOverlay').removeClass('active');
        document.body.classList.remove('no-scroll');
    }

    // 반투명 오버레이, 팝업 내 닫기 버튼 클릭 시 슬라이드 닫기
    $(document).on('click', '#slideOverlay, #closePopup', function () {
        closePopup();
    });

function loadUserDetailTab(tab = 'general') {
    fetch("/user/detail/" + tab, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({ reqId })
    })
    .then(response => {
        if (!response.ok) throw new Error('❌ Error : ' + tab);
        return response.text();
    })
    .then(html => {
        $('.slide-popup-container').html(html);

        if (tab === 'general') {
            readonly();
            extractUserDtlGeneralFromDOM("#customerPopup .slide-popup-container");
            updateDeletionDateInfo();
        } else if (tab === 'health-alerts') {
            healthAlerts_fnSearch();
            drawHealthAlertChart();
            initHealthAlertGrid();
        } else if (tab === 'service-requests') {
            drawServiceRequestsChart();
        } else if (tab === 'input-checkup-data') {
            initDropzone();
            initInputCheckupDataTab();
        }

    })
    .catch(error => {
        $.confirm({
            title: 'Error',
            content: 'Failed to load tab content.',
            type: 'red',
            typeAnimated: true,
            buttons: {
                OK: {
                    btnClass: 'btn-red',
                    action: function(){ console.error(error); }
                }
            }
        });
    });
}

$(document).on("click", ".open-slide-btn", function () {
    reqId = $(this).data("reqid");

    openPopup();
    loadUserDetailTab('general');  // 기본 탭 로딩
});


$(document).on('click', '.second-tap-btn', function () {
    $('.second-tap-btn').removeClass('active');
    $(this).addClass('active');

    let tab = $(this).data('tab');  // 'health-alerts', 'service-requests' 등
    loadUserDetailTab(tab);
});

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////// General ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // 입력창 잠금
    function readonly() {
        $('#customerPopup input, #customerPopup textarea').attr('readonly', true);
        $('#customerPopup .dropdown-search, #customerPopup .dropdown-content a').addClass('hold');
    }

    // 입력창 해제
    function write() {
        $('#customerPopup input:not(.hold), #customerPopup textarea:not(.hold)').removeAttr('readonly');
        $('#customerPopup .dropdown-search, #customerPopup .dropdown-content a').not('.readonly-dropdown').removeClass('hold');
    }

/* 삭제
    $(document).on("click", ".open-slide-btn", function () {
        reqId = $(this).data("reqid");

        fetch("/user/detail/general", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ reqId })  // form-urlencoded 형식으로 전송
        })
        .then(response => {
            if (!response.ok) throw new Error("❌ Error : open-slide-btn");

            return response.text();  // JSP 렌더링 결과가 HTML이니까
        })
        .then(html => {
            document.querySelector("#customerPopup .slide-popup-container").innerHTML = html;

            openPopup();
            readonly();

            extractUserDtlGeneralFromDOM("#customerPopup .slide-popup-container");

            updateDeletionDateInfo();
        })
        .catch(error => {
            $.alert({
                title: 'Error',
                content: 'Failed to load tab content.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-red'
                    }
                }
            });
        });
    });
*/

    // editBtn : 사용자 정보 변경 버튼
    $(document).on('click', '#editBtn', function () {
        write();

        $('#editButtons').addClass('hidden');
        $('#actionButtons').removeClass('hidden');
    });

    // resetPwBtn : 비밀번호 변경 버튼
    $(document).on("click", "#resetPwBtn", function () {
        $(".reset-pw-popup-container").load("/user/resetPwStartPopup", function () {
            $('#resetPwStartPopup').fadeIn();
        });
    });

    $(document).on("click", "#resetPwStartPopup #nextBtn", function () {
        $(".reset-pw-popup-container").load("/user/resetPwConfirmPopup", function () {
            $('#resetPwConfirmPopup').fadeIn();
        });
    });

    // 비밀번호 재설정 팝업 외부 요소 클릭 시 팝업 닫기 처리
    $(document).on("click", "#slideOverlay, .popup-close, .popup-modal #goBackBtn, .popup-modal #cancelBtn", function () {
        if ($("#resetPwStartPopup").is(":visible")) {
            $("#resetPwStartPopup").fadeOut();
            $(".reset-pw-popup-container").empty();
        }

        if ($("#resetPwConfirmPopup").is(":visible")) {
            $("#resetPwConfirmPopup").fadeOut();
            $(".reset-pw-popup-container").empty();
        }

        if ($("#checkPwStartPopup").is(":visible")) {
            $("#checkPwStartPopup").fadeOut();
            $(".check-pw-popup-container").empty();
        }

        if ($("#checkPwConfirmPopup").is(":visible")) {
            $("#checkPwConfirmPopup").fadeOut();
            $(".check-pw-popup-container").empty();
        }
    });

    // resetPwStartPopup / resetPwConfirmPopup 외부 요소 클릭 시 팝업 닫기
    $(document).on("click", "#resetPwStartWrapper, #resetPwConfirmWrapper, #checkPwStartWrapper, #checkPwConfirmWrapper", function (e) {
        const wrapperId = e.currentTarget.id;
        let popupId;

        switch (wrapperId) {
            case "resetPwStartWrapper":
                popupId = "resetPwStartPopup";
                break;
            case "resetPwConfirmWrapper":
                popupId = "resetPwConfirmPopup";
                break;
            case "checkPwStartWrapper":
                popupId = "checkPwStartPopup";
                break;
            case "checkPwConfirmWrapper":
                popupId = "checkPwConfirmPopup";
                break;
            default:
                return;
        }

        const popup = document.getElementById(popupId);

        console.log("✅ wrapper 클릭됨 : " + wrapperId);
        console.log("👉 클릭 대상 : " + e.target);

        if (e.target.closest('.popup-show')) {
            console.log("🚫 팝업 내부 클릭 : 닫기 무시");
            return;
        } else {
            console.log("✅ 팝업 외부 클릭 : 닫기 실행");
            $('.popup-close').click();
        }
    });

    // resetPwInput : 입력 값 확인
    $(document).on('input', '#resetPwInput', function () {
        let value = $(this).val().trim();

        if (value.length > 0) {
            $('#resetApprovalBtn')
                .removeClass('hold-submit-btn')
                .addClass('red-submit-btn')
                .prop("disabled", false);
        } else {
            $('#resetApprovalBtn')
                .removeClass('red-submit-btn')
                .addClass('hold-submit-btn')
                .prop("disabled", true);
        }
    });

    // resetApprovalBtn : 관리자에 의한 사용자 비밀번호 초기화
    $(document).on("click", "#resetApprovalBtn", function () {
        fetch("/user/resetPwByAdmin", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({
                userId: $("#general_userId").val().trim(),
                newPw: $("#resetPwInput").val().trim()
            })
        })
        .then(response => response.json())
        .then(({ success, message }) => {
            if (success) {
                $.confirm({
                    title: 'Success',
                    content: 'The password has been successfully reset.',
                    type: 'green',
                    typeAnimated: true,
                    buttons: {
                        OK: {
                            btnClass: 'btn-green',
                            action: function(){
                                // 확인 눌렀을 때 실행할 동작 (필요 시)
                            }
                        }
                    }
                });

                $("#resetPwConfirmPopup").fadeOut();
                $(".reset-pw-popup-container").empty();
            } else {
                $.confirm({
                    title: 'Error',
                    content: message || 'Failed to reset the password.',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        OK: {
                            btnClass: 'btn-red',
                            action: function(){}
                        }
                    }
                });
            }
        })
        .catch(error => {
            $.confirm({
                title: 'Error',
                content: message || 'An error occurred during password reset.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-red',
                        action: function(){}
                    }
                }
            });
        });
    });

    // resetBtn : 전체 필드 복원 버튼
    $(document).on("click", "#resetBtn", function () {
        function resetDropdownText(id, value) {
            $("#" + id).contents().filter(function () {
                return this.nodeType === 3;
            }).first().replaceWith(value + " ");
        }

        // 텍스트 필드 복원
        $("#general_userNm").val(userDtlGeneral.userNm);
        $("#general_emailId").val(userDtlGeneral.emailId);
        $("#general_mobile").val(userDtlGeneral.mobile);
        $("#general_userId").val(userDtlGeneral.userId);
        $("#general_brthDt").val(userDtlGeneral.brthDt);
        $("#general_height").val(userDtlGeneral.height);
        $("#general_registDt").val(userDtlGeneral.registDt);
        $("#general_weight").val(userDtlGeneral.weight);
        $("#general_lastAccess").val(userDtlGeneral.lastAccess);
        $("#general_addr").val(userDtlGeneral.addr);
        $("#general_wdDt").val(userDtlGeneral.wdDt);
        $("#general_mmo").val(userDtlGeneral.mmo);

        // 드롭다운 복원
        resetDropdownText("general_sxDropdown", userDtlGeneral.sx || userSearch_messages.select);
        resetDropdownText("general_inChargeNmDropdown", userDtlGeneral.inChargeNm || userSearch_messages.select);
        resetDropdownText("general_statusDropdown", userDtlGeneral.wdYn || userSearch_messages.select);
        resetDropdownText("general_grpTpDropdown", userDtlGeneral.grpTp || userSearch_messages.select);
    });

    let calculatedWdDt = "";  // 변경 될 삭제 예정일
    let calculatedWdYn = "";  // 변경 될 탈퇴 상태

    function updateDeletionDateInfo() {
        let wdYn = $("#general_statusDropdown").contents().filter(function () {
            return this.nodeType === 3;
        }).text().trim();

        let wdDtCopy = $("#general_wdDt").val();

        let $deletionDateInput = $("#deletionDate");
        let $deletionDateCntInput = $("#deletionDateCnt");

        if (wdYn === userSearch_messages.active) {  // 'Active' 상태
            $deletionDateInput.val('-');
            $deletionDateCntInput.val('-');

            calculatedWdYn = 'N';
            return;
        } else if (wdYn === userSearch_messages.suspended) {  // 'Suspended' 상태
            $deletionDateInput.val('-');
            $deletionDateCntInput.val('-');

            calculatedWdYn = 'S';
            return;
        }

        // ✅ 'Ready to delete' 상태일 때
        if (wdYn === userSearch_messages.readyToDelete) {
            let targetDate;

            if (wdDtCopy) {
                targetDate = new Date(wdDtCopy);
            } else {
                // 🆕 wdDtCopy 없을 경우 → 오늘 기준 30일 후로 설정
                targetDate = new Date();
                targetDate.setDate(targetDate.getDate() + 30);

                // wdDtCopy 설정
                let yyyy = targetDate.getFullYear();
                let mm = String(targetDate.getMonth() + 1).padStart(2, '0');
                let dd = String(targetDate.getDate()).padStart(2, '0');
                wdDtCopy = yyyy + "-" + mm + "-" + dd;;
            }

            // 계산 후 반영
            let today = new Date();
            let diffTime = targetDate - today;
            let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

            $("#deletionReqDateInput").val(new Date().toISOString().slice(0, 19).replace('T', ' '));
            $deletionDateInput.val(wdDtCopy);
            $deletionDateCntInput.val(diffDays > 0 ? diffDays : '-');

            calculatedWdDt = wdDtCopy;
            calculatedWdYn = 'Y';

            console.log("📌 wdDtCopy : " + wdDtCopy, "남은 일수 : " + diffDays);
        }
    }

    $(document).on("click", ".dropdown-content a", function () {
        const $dropdown = $(this).closest('.dropdown');
        const $button = $dropdown.find('button.dropdown-search');
        const selectedText = $(this).text().trim();

        console.log("🔽 드롭다운 클릭됨 : " + selectedText);

        // 텍스트 노드 교체
        $button.contents().filter(function () {
            return this.nodeType === 3;
        }).first().replaceWith(selectedText + " ");

        // 상태 드롭다운일 경우 처리
        if ($button.attr("id") === "general_statusDropdown") {
            updateDeletionDateInfo();
        }

        checkIfUserDataChanged();
    });

    // 변경사항 확인
    function checkIfUserDataChanged() {
        let editedValues = {
            mobile: $('#general_mobile').val()?.trim() || '',
            brthDt: $('#general_brthDt').val()?.trim() || '',
            height: $('#general_height').val()?.trim() || '',
            weight: $('#general_weight').val()?.trim() || '',
            addr: $('#general_addr').val()?.trim() || '',
            mmo: $('#general_mmo').val()?.trim() || '',
            sx: $("#general_sxDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim(),
            inChargeNm: $("#general_inChargeNmDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim(),
            grpTp: $("#general_grpTpDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim(),
            wdYn: $("#general_statusDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim()
        };

        if (!editedValues.brthDt) {
            $('#general_brthDt')
                .addClass('required-input');

            $('#saveChangesBtn')
                .removeClass('red-submit-btn')
                .addClass('hold-submit-btn')
                .prop("disabled", true);

            return;
        } else {
            $('#general_brthDt')
                .removeClass('required-input')
                .addClass('required-input')
        }

        let isChanged = Object.keys(editedValues).some(key => {
            let initialValue = userDtlGeneral[key] ? String(userDtlGeneral[key]).trim() : '';
            let currentValue = editedValues[key] || '';
            return currentValue !== initialValue;
        });

        if (isChanged) {
            $('#saveChangesBtn')
                .removeClass('hold-submit-btn')
                .addClass('red-submit-btn')
                .prop("disabled", false);
        } else {
            $('#saveChangesBtn')
                .removeClass('red-submit-btn')
                .addClass('hold-submit-btn')
                .prop("disabled", true);
        }
    }

    $(document).on('input', '#general_mobile, #general_brthDt, #general_height, #general_weight, #general_addr, #general_mmo', checkIfUserDataChanged);

    function setUserUpdateParam() {
        return {
            mobile: $("#general_mobile").val()?.trim() || "",
            sx: (() => {
                const text = $("#general_sxDropdown").contents().filter(function () {
                    return this.nodeType === 3;
                }).text().trim();

                if (text === userSearch_messages.f) return "F";
                if (text === userSearch_messages.m) return "M";
                return "";
            })(),
            inChargeNm: $("#general_inChargeNmDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || "",
            brthDt: $("#general_brthDt").val()?.trim() || "",
            grpTp: $("#general_grpTpDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || "",
            height: $("#general_height").val()?.trim() || "",
            weight: $("#general_weight").val()?.trim() || "",
            addr: $("#general_addr").val()?.trim() || "",
            wdDt: calculatedWdDt || "",
            wdYn: calculatedWdYn || "",
            mmo: $("#general_mmo").val()?.trim() || "",
            uptDt: $("#general_uptDt").val()?.trim() || "",
            uptId: $("#general_uptId").val()?.trim() || "",
            userId: $("#general_userId").val()?.trim() || ""
        };
    }

    // saveChangesBtn : 사용자 정보 변경 요청 버튼
    $(document).on("click", "#saveChangesBtn", function () {
        $(".check-pw-popup-container").load("/user/checkPwStartPopup", function () {
            $('#checkPwStartPopup').fadeIn();
        });
    });

    $(document).on("click", "#checkPwStartPopup #nextBtn", function () {
        $(".check-pw-popup-container").load("/user/checkPwConfirmPopup", function () {
            $('#checkPwConfirmPopup').fadeIn();
        });
    });

    // checkPwInput : 입력 값 확인
    $(document).on('input', '#checkPwInput', function () {
        let value = $(this).val().trim();

        if (value.length > 0) {
            $('#checkEditBtn')
                .removeClass('hold-submit-btn')
                .addClass('red-submit-btn')
                .prop("disabled", false);
        } else {
            $('#checkEditBtn')
                .removeClass('red-submit-btn')
                .addClass('hold-submit-btn')
                .prop("disabled", true);
        }
    });

    $(document).on("click", "#checkEditBtn", function () {
        const checkPassword = $("#checkPwInput").val().trim();

        fetch("/user/checkPassword", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ checkPassword })
        })
        .then(res => res.json())
        .then(({ status, message }) => {
            switch (status) {
                case "success":
                    console.log("✅ 비밀번호 확인 성공");
                    updateUserGeneralInfo();

                    $("#checkPwConfirmPopup").fadeOut();
                    $(".check-pw-popup-container").empty();

                    closePopup();

                    break;
                case "fail":
                    $.confirm({
                        title: 'Error',
                        content: message || 'The password does not match.',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            OK: {
                                btnClass: 'btn-red',
                                action: function(){}
                            }
                        }
                    });
                    break;
                default:
                    $.confirm({
                        title: 'Error',
                        content: message || 'A server error has occurred.',
                        type: 'red',
                        typeAnimated: true,
                        buttons: {
                            OK: {
                                btnClass: 'btn-red',
                                action: function(){}
                            }
                        }
                    });
            }
        })
        .catch(error => {
            $.confirm({
                title: 'Error',
                content: message || 'A network error has occurred.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-red',
                        action: function(){}
                    }
                }
            });
        });
    });

    function updateUserGeneralInfo() {
        const updateData = setUserUpdateParam();

        console.log(updateData);

        fetch("/user/updateGeneral", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams(updateData)
        })
        .then(response => {
            if (!response.ok) throw new Error("❌ Error : /user/updateGeneral");

            return response.json();
        })
        .then(response => {
            console.log("✅ 사용자 정보 수정 결과 : " + response);

            $.confirm({
                title: 'Success',
                content: 'User information has been successfully updated.',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-green',
                        action: function(){
                            $(".open-slide-btn[data-reqid='" + reqId + "']").click();
                        }
                    }
                }
            });

            // 버튼 상태 복원
            $("#saveChangesBtn")
                .removeClass("red-submit-btn")
                .addClass("hold-submit-btn")
                .prop("disabled", true);
        })
        .catch(error => {
            $.confirm({
                title: 'Error',
                content: message || 'An error occurred while updating user information.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-red',
                        action: function(){
                            console.error(error);
                        }
                    }
                }
            });
        });
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// healthAlerts /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Alert & Service Summation S
function calc(targetEl, val) {
    $({ val : 0 }).animate({ val : val }, {
        duration: 500,
        step: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#"+targetEl).text(num);
        },
        complete: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#"+targetEl).text(num);
        }
    });
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// Alert & Service Summation E

let sum = 0;

function summation(arr) {
    let sum = 0;
    arr.forEach((num) => { sum += num; })
    return sum
}

function drawHealthAlertChart() {
    let myCt = document.getElementById('healthAlerts_myChart');
    if (!myCt) {
        console.warn("Canvas with id 'healthAlerts_myChart' not found.");
        return;
    }

    let healthAlerts = extractUserDtlHealthAlertFromDOM("#customerPopup .slide-popup-container");

    new Chart(myCt, {
        type: 'doughnut',
        data: {
            labels: Object.keys(healthAlerts),
            datasets: [
                {
                    label: '',
                    data: Object.values(healthAlerts),
                    backgroundColor: [
                        'rgba(82, 158, 232, 1)',
                        'rgba(160, 205, 255, 1)',
                        'rgba(255, 202, 134, 1)',
                        'rgba(238, 147, 144, 1)',
                        'rgba(251, 228, 137, 1)',
                        'rgba(216, 216, 216, 1)'
                    ]
                }
            ]
        },
        options: {
            borderColor: 'transparent',
            borderWidth: 0,
            maintainAspectRatio: false,
            responsive: true,
            cutout: '70%',
            layout: {
                padding: {
                    right: 50,
                    bottom: 10,
                    top: 10
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: "right",
                    labels: {
                        boxWidth: 26,
                        boxHeight: 26,
                        padding: 14,
                        usePointStyle: true,
                        pointStyle: 'rectRounded',
                        font: {
                            size: 14
                        },
                        generateLabels: (chart) => {
                            const datasets = chart.data.datasets;
                            return datasets[0].data.map((data, i) => ({
                                text: chart.data.labels[i] + '(' + data + ')',
                                strokeStyle: 'rgba(0,0,0,0)',
                                lineWidth: 0,
                                fillStyle: datasets[0].backgroundColor[i],
                                index: i,
                                pointStyle: 'rectRounded'
                            }));
                        },
                        borderWidth: 0
                    },
                    fullSize: true,
                    align: "center"
                },
                tooltip: {
                    enabled: false,
                    position: 'nearest',
                    external: externalTooltipHandler
                },
                datalabels: {
                    color: 'rgba(86, 86, 86, 1)',
                    font: {
                        size: 12,
                        weight: 'bold'
                    },
                    formatter: (value) => value
                },
                shadowCirclePlugin: {
                    shadowColor: 'rgba(0, 0, 0, 0.1)',
                    shadowBlur: 3,
                    shadowOffsetX: 5,
                    shadowOffsetY: 3,
                    shadowFill: '#fff'
                }
            }
        },
        plugins: [doughnutLabel, ChartDataLabels, shadowCirclePlugin]
    });
}

// Grid S
// 조회 대상 컬럼 전체 등록
var expectedResult = ["attchId", "attchMngId", "attchSt", "crId", "attchSize", "originalFileName"];

// 기본 Items 개수
var rowNumsVal = 10;

var inChargeList = new Array();
<c:forEach items="${inChargeList}" var="item">
    inChargeList.push("'${item.userId}'")
</c:forEach>

// JQGRID INIT
function initHealthAlertGrid() {
    var grid = $("#healthAlerts_alertGrid").jqGrid({
        url: '/tracking/selectHealthAlert',
        datatype: 'json',
        mtype: 'POST',
        colModel : [
            { label: 'Detected Time', name: 'dctDt', width:240, sortable : true},
            { label: 'Alert Type', name: 'altTp', width:130, sortable : true, formatter: function(cellValue, options, rowObject) {
                    switch(cellValue) {
                        case 'A' :
                            return 'Activity';
                            break;
                        case 'F' :
                            return 'Falls';
                            break;
                        case 'H' :
                            return 'Heart Rate';
                            break;
                        case 'SL' :
                            return 'Sleep';
                            break;
                        case 'B' :
                            return 'Blood Oxygen';
                            break;
                        case 'T' :
                            return 'Temperature';
                            break;
                        case 'ST' :
                            return 'Stress';
                            break;
                        default :
                            return cellValue;
                            break;
                    }
                }},
            { label: 'UID', name: 'userId', width:300, sortable : true},
            { label: 'User Name', name: 'userNm', width:130, sortable : false},
            { label: 'Phone', name: 'mobile', width:130, sortable : false, formatter: function(cellValue, options, rowObject) {
                    var cleaned = ('' + cellValue).replace(/\D/g, '');
                    var match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
                    if (match) {
                        return match[1] + '-' + match[2] + '-' + match[3];
                    }
                    return cellValue;
                }},
            { label: 'Date Of Birth', name: 'brthDt', width:130, sortable : false},
            { label: 'Sex', name: 'sx', width:60, sortable : true, formatter: function(cellValue, options, rowObject) {
                    if(cellValue === 'M') {
                        return '<img src="/resources/images/man-icon.svg" class="icon24 img-c">'
                    } else {
                        return '<img src="/resources/images/girl-icon.svg" class="icon24 img-c">';
                    }
                }},
            { label: 'Group', name: 'grpNm', width:130, sortable : true},
            { label: 'In Charge', name: 'inChargeNm', width:130, sortable : false},
            { label: 'Details', name: 'userId', width:100, sortable : false, formatter : function(cellValue, options, rowObject){
                    return `<button type="button" class="detail-btn" data-id="`+cellValue+`"><span>detail</span><img src="/resources/images/arrow-right-nomal.svg" class="icon18"></button>`
                }},
        ],
        viewrecords: true,
        autowidth : true,
        shrinkToFit: true,
        height: 'auto',
        rowNum: rowNumsVal,
        rownumbers: true,
        pager: "#healthAlerts_alertGridPager",
        jsonReader: {
            root: "rows",          // 데이터 리스트
            page: "page",          // 현재 페이지
            total: "total",
            records: "records"        // 전체 개수
        },
        sortable : true,
        sortname : 'dctDt',
        sortorder : 'DESC',
        postData: {
            page: 1,
            size: rowNumsVal,
            searchBgnDe: today,
            altTp : "'A','F','H','SL','B','T','ST'",
            inChargeId : inChargeId != null && inChargeId != '' ? inChargeId : null,
            inChargeIds : inChargeList.length > 0 ? '('+inChargeList.join()+')' : null,
        },
        loadComplete: function(data) {
            createCustomPager('healthAlerts_alertGrid');
            console.log(data);
            $(this).jqGrid('setLabel', 'rn', 'No.');
        },
        gridComplete: function() {
            createCustomPager('healthAlerts_alertGrid');
            $(this).jqGrid('setLabel', 'rn', 'No.');
        }
    });
};
// Grid E


function extractUserDtlHealthAlertFromDOM() {
    return {
        'Activify/Falls': Number($("#healthAlerts_cntAF").text().replace(/,/g, "")) || 0,
        'Heart Rate': Number($("#healthAlerts_cntH").text().replace(/,/g, "")) || 0,
        'Sleep': Number($("#healthAlerts_cntSL").text().replace(/,/g, "")) || 0,
        'Blood Oxygen': Number($("#healthAlerts_cntB").text().replace(/,/g, "")) || 0,
        'Temperature': Number($("#healthAlerts_cntT").text().replace(/,/g, "")) || 0,
        'Stress': Number($("#healthAlerts_cntST").text().replace(/,/g, "")) || 0
    };
}
</script>

<script type="text/javascript">

    //const today = moment().format('YYYY-MM-DD');
    var today = '2025-03-24';

function healthAlerts_fnSearch(){
    $('#healthAlerts_alertGrid').jqGrid('setGridParam', {
        url: '${contextPath}/tracking/selectHealthAlert',
        datatype: 'json',
        postData : healthAlerts_setSearchParam()
    });
    $('#healthAlerts_alertGrid').trigger('reloadGrid', [{page:1, current:true}]);
}

function healthAlerts_setSearchParam() {
    let startDate = $('#healthAlerts_dateDisplay1').val();
    let endDate = $('#healthAlerts_dateDisplay2').val();

console.log("healthAlerts_startDate" + startDate);
console.log("healthAlerts_endDate" + endDate);

    let altTpVal = $('#healthAlerts_altTp .data-select-btn.active').data('filter');

    return {
        searchBgnDe: startDate || null,
        searchEndDe: endDate || null,
        altTp : $('#healthAlerts_altTp .data-select-btn.active').data('filter') != 'alertTpAll'
            ? '"' + $('#healthAlerts_altTp .data-select-btn.active').data('filter') + '"'
            : "'AF','H','SL','B','T','ST'",
        reqId : reqId,
        inChargeId: inChargeId != null && inChargeId !== '' ? inChargeId : null,
        inChargeIds: inChargeList.length > 0 ? '(' + inChargeList.join() + ')' : null
    };
}

$(document).on('click', '#healthAlerts_date .data-select-btn', function () {
    console.log('✅ healthAlerts healthAlerts clicked!');
    $('#healthAlerts_date .data-select-btn').removeClass('active');
    $(this).addClass('active');

    let period = $(this).data('period');

    if (period === 'all') {
        $('#healthAlerts_dateDisplay1').val('');
        $('#healthAlerts_dateDisplay2').val('');
    } else if (period === 'today') {
        $('#healthAlerts_dateDisplay1').val(today);
        $('#healthAlerts_dateDisplay2').val(today);
    } else {
        let pDay = parseInt(period.replace('-day', ''), 10);

        let baseDate = moment(today, 'YYYY-MM-DD');
        let endDate = baseDate.format('YYYY-MM-DD');
        let calcDt = baseDate.clone().subtract(pDay, 'days').format('YYYY-MM-DD');

        $('#healthAlerts_dateDisplay1').val(calcDt);    // 시작일
        $('#healthAlerts_dateDisplay2').val(endDate);   // 종료일
    }
});


$(document).on('click', '#healthAlerts_altTp .data-select-btn', function () {
    $('#healthAlerts_altTp .data-select-btn').removeClass('active');
    $(this).addClass('active');
});


    // Grid Filter Toggle
    $(document).on('click','.alerts-table-ui .buttonWrapper button', function(){
        if($('.alerts-table-ui .buttonWrapper button.active').length === 1 && $('.alerts-table-ui .buttonWrapper button.active')[0] == this){
            return;
        }

        if(this.dataset['filter'] === 'all') {
            $('.alerts-table-ui .buttonWrapper button').removeClass('active');

            $(this).addClass('active');
        } else {
            $('[data-filter="all"]').removeClass('active');
            $(this).toggleClass('active');
        }

        healthAlerts_fnSearch();
    })




$('.dropdown-content a').click(function(){
    let cnt = $(this).data('cnt');

    rowNumsVal = cnt;
    $('#gridDropdownBtn').text($(this).text());
    $("#healthAlerts_alertGrid").setGridParam({ rowNum: cnt });
    healthAlerts_fnSearch();
})

//logout 임다.
$(document).on('click','.logout_icon30', function(){
    window.location.href='<c:url value="/login/logout"/>';
})
</script>

<script type="text/javascript">
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// inputCheckUpData ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function downform(){
        var _url = "${contextPath}/user/downform";
        var _jsonData = {
            name: 'moadata',
            url: 'www.moadata.co.kr'
        };

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var _data = this.response;
                var _blob = new Blob([_data], {type : 'text/csv'});

                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(_blob);
                link.download = 'twalk_downData.csv';
                link.click();
            };
        };

        xhr.open('POST', _url);
        xhr.responseType = 'blob';
        xhr.setRequestHeader('Content-type', 'application/json');
        xhr.send(_jsonData);
    }

    function initDropzone() {
        if ($("#dropzone-file").length === 0) {
            console.warn("#dropzone-file 요소 없음. Dropzone 초기화 생략.");
            return;
        }

        // 이미 Dropzone이 초기화되어 있다면 중복 방지
        if (Dropzone.instances.length > 0) {
            Dropzone.instances.forEach(instance => instance.destroy());
        }

        var dropzoneFile=new Dropzone("#dropzone-file",{
            url:'${contextPath}/user/getChckUpExcelImport',
            maxFilesize:5000000,
            parallelUploads:2,     //한번에 올릴 파일 수
            //addRemoveLinks:  true, //업로드 후 삭제 버튼
            timeout:300000,	     //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정해주자
            maxFiles:5,            //업로드 할 최대 파일 수
            paramName:"file",      //파라미터로 넘길 변수명 default는 file
            acceptedFiles: ".csv,.CSV",   // 허용 확장자
            autoQueue:true,	     //드래그 드랍 후 바로 서버로 전송
            createImageThumbnails:true,	//파일 업로드 썸네일 생성
            uploadMultiple:true,	 //멀티파일 업로드
            dictRemoveFile:'remove',	    //삭제 버튼의 텍스트 설정
            //dictDefaultMessage:'PREVIEW', //미리보기 텍스트 설정
            accept:function(file,done){
                done();
            },
            init:function(){
                this.on('success',function(file,responseText){
                    console.log("responseText Start : ");
                    console.log(responseText);
                    console.log("responseText End.");

                    //제목의 길이 체크
                    var tlen = responseText.resultList[0].length;
                    var vlen = responseText.resultList[1].length;

                    if (tlen == vlen){
                        for(var k = 0; k < vlen; k++){
                            var resval = responseText.resultList[0][k]+"";
                            if (resval.trim().indexOf("hght") >= 0){$("#inputCheckup_hght").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("wght") >= 0){$("#inputCheckup_wght").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("wst")>= 0){$("#inputCheckup_wst").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("sbp")>= 0){$("#inputCheckup_sbp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("dbp")>= 0){$("#inputCheckup_dbp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("fbs") >= 0){$("#inputCheckup_fbs").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("hba1c")>= 0){$("#inputCheckup_hba1c").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("tc") >= 0){$("#inputCheckup_tc").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("hdl") >= 0){$("#inputCheckup_hdl").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("ldl")>= 0){$("#inputCheckup_ldl").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("trgly")>= 0){$("#inputCheckup_trgly").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("sc")>= 0){$("#inputCheckup_sc").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("gfr") >= 0){$("#inputCheckup_gfr").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("urAcd")>= 0){$("#inputCheckup_urAcd").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("bun")>= 0){$("#inputCheckup_bun").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("alt") >= 0){$("#inputCheckup_alt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("ast")>= 0){$("#inputCheckup_ast").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("gtp") >= 0){$("#inputCheckup_gtp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("tprtn")>= 0){$("#inputCheckup_tprtn").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("blrbn")>= 0){$("#inputCheckup_blrbn").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("alp")>= 0){$("#inputCheckup_alp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("comment")>= 0){$("#inputCheckup_comment").val(responseText.resultList[1][k])}
                            //기본정보
                            if (resval.trim().indexOf("Medical Checkup Type")>= 0){$("#inputCheckup_chckType").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Checkup result")>= 0){$("#inputCheckup_chckResult").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Checkup center")>= 0){$("#chckCt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Doctor")>= 0){$("#chckDctr").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Health Checkup Date")>= 0){$("#inputCheckup_chckDt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Date Of Birth")>= 0){$("#inputCheckup_brthDt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Gender")>= 0){
                                $("#inputCheckup_gender").val(responseText.resultList[1][k])
                                if (responseText.resultList[1][k] == 'M'){
                                    $('.sex-btn-f').removeClass('active');
                                    $('.sex-btn').addClass('active');
                                } else {
                                    $('.sex-btn-f').addClass('active');
                                    $('.sex-btn').removeClass('active');
                                }
                            }
                        }
                    }
                });

                // Dropzone에 이미지가 추가되면 업로드 버튼 활성화
                this.on("addedfile", function () {
                });
                this.on("removedfile", function(file) {
                });
                this.on("complete", function(file) {
                });
                this.on("dragover", function(e) {
                });
                this.on("drop", function(e) {
                    console.log("count : " + this.getAcceptedFiles().length);
                    if (this.getAcceptedFiles().length >= 1) {
                        var files = this.getAcceptedFiles();
                        this.removeFile(files[0]);
                    }
                });
            }
        });
    }

    function inputCheckup_fnClear() {
        $("#inputCheckup_chckType").val(''); $("#inputCheckup_chckResult").val(''); $("#inputCheckup_chckDt").val(''); $("#chckDctr").val('');
        $("#inputCheckup_brthDt").val(''); $("#inputCheckup_gender").val(''); $('#inputCheckup_chckDt').val(''); $('#inputCheckup_brthDt').val(''); $('#chckCt').val('');
        $('#inputCheckup_hght').val(''); $('#inputCheckup_wght').val(''); $('#inputCheckup_wst').val(''); $('#inputCheckup_sbp').val(''); $('#inputCheckup_dbp').val('');
        $('#inputCheckup_fbs').val(''); $('#inputCheckup_hba1c').val(''); $('#inputCheckup_tc').val(''); $('#inputCheckup_hdl').val(''); $('#inputCheckup_ldl').val('');
        $('#inputCheckup_trgly').val(''); $('#inputCheckup_sc').val(''); $('#inputCheckup_gfr').val(''); $('#inputCheckup_urAcd').val(''); $('#inputCheckup_bun').val('');
        $('#inputCheckup_alt').val(''); $('#inputCheckup_ast').val(''); $('#inputCheckup_gtp').val(''); $('#inputCheckup_tprtn').val(''); $('#inputCheckup_blrbn').val('');
        $('#inputCheckup_alp').val(''); $('#inputCheckup_comment').val('');
        $('.sex-btn-f').removeClass('active');
        $('.sex-btn').removeClass('active');
    }

    function inputCheckup_setAddParam() {
        return {
            userId : userDtlGeneral.userId,
            chckType : $("#inputCheckup_chckType").val(),
            chckResult : $("#inputCheckup_chckResult").val(),
            chckCt : $("#inputCheckup_chckDt").val(),
            chckDctr : $("#chckDct").val(),
            chckDt : $("#inputCheckup_chckDt").val(),
            brthDt : $("#inputCheckup_brthDt").val(),
            gender : $("#inputCheckup_gender").val(),
            chckDt : $('#inputCheckup_chckDt').val(),
            brthDt : $('#inputCheckup_brthDt').val(),
            gender : $('#inputCheckup_gender').val(),
            hght   : $('#inputCheckup_hght').val(),
            wght   : $('#inputCheckup_wght').val(),
            wst    : $('#inputCheckup_wst').val(),
            sbp    : $('#inputCheckup_sbp').val(),
            dbp    : $('#inputCheckup_dbp').val(),
            fbs    : $('#inputCheckup_fbs').val(),
            hba1c  : $('#inputCheckup_hba1c').val(),
            tc     : $('#inputCheckup_tc').val(),
            hdl    : $('#inputCheckup_hdl').val(),
            ldl    : $('#inputCheckup_ldl').val(),
            trgly  : $('#inputCheckup_trgly').val(),
            sc     : $('#inputCheckup_sc').val(),
            gfr    : $('#inputCheckup_gfr').val(),
            urAcd  : $('#inputCheckup_urAcd').val(),
            bun    : $('#inputCheckup_bun').val(),
            alt    : $('#inputCheckup_alt').val(),
            ast    : $('#inputCheckup_ast').val(),
            gtp    : $('#inputCheckup_gtp').val(),
            tprtn  : $('#inputCheckup_tprtn').val(),
            blrbn  : $('#inputCheckup_blrbn').val(),
            alp    : $('#inputCheckup_alp').val(),
            comment: $('#inputCheckup_comment').val()
        };
    }

    $(document).ready(function() {
        inputCheckup_fnClear();
    })

    function validation(){
        return true;
    }

function initInputCheckupDataTab() {
    // 초기화
    inputCheckup_fnClear();

    // 이벤트 바인딩 (중복 방지 위해 off로 제거 후 다시 on)
    $(document).off('click', '#checkupreset').on('click', '#checkupreset', function () {
        inputCheckup_fnClear();
    });

    $(document).off('click', '#checkupsave').on('click', '#checkupsave', function () {
console.log(inputCheckup_setAddParam());

        $.confirm({
            title: '',
            content: 'Would you like to save an checkup data?',
            buttons: {
                OK: function () {
                    if (validation()) {
                        $.ajax({
                            type: 'POST',
                            url: '${contextPath}/user/checkupAdd',
                            data: inputCheckup_setAddParam(),
                            dataType: 'json',
                            success: function (data) {
                                if (data.isError) {
                                    $.alert(data.message);
                                    console.log('ERROR', data.message);
                                } else {
                                    inputCheckup_fnClear();
                                    $.alert(data.message);
                                    healthAlerts_fnSearch();
                                }
                            }
                        });
                    }
                },
                Cancel: function () {}
            }
        });
    });
}

    $('.table-wrap .dropdown-content a').click(function(){
        let cnt = $(this).data('cnt');

        rowNumsVal = cnt;
        $('#gridDropdownBtn').text($(this).text());
        $("#healthAlertList").setGridParam({ rowNum: cnt });
        healthAlerts_fnSearch();
    })

    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            healthAlerts_fnSearch();
        }
    });

$(document).on('click', '.sex-btn-f', function() {
    console.log("여자");
    if($(this).hasClass('active')){
        $(this).removeClass('active');
        $("#inputCheckup_gender").val('M');
        $('.sex-btn').addClass('active');
    } else {
        $(this).addClass('active');
        $("#inputCheckup_gender").val('F');
        $('.sex-btn').removeClass('active');
    }
});

$(document).on('click', '.sex-btn', function() {
    console.log("남자");
    if($(this).hasClass('active')){
        $(this).removeClass('active');
        $("#inputCheckup_gender").val('F');
        $('.sex-btn-f').addClass('active');
    } else {
        $(this).addClass('active');
        $("#inputCheckup_gender").val('M');
        $('.sex-btn-f').removeClass('active');
    }
});

/* 실시간으로 모든 필드의 입력 값이 있으면 버튼을 바꿈
$(document).on('click', '#inputCheckup_dataFields input', function() {
    let isAllFilled = true;

    $('#inputCheckup_dataFields input').each(function () {
        if (!$(this).val()?.trim()) {
            isAllFilled = false;
            return false;
        }
    });

    if (isAllFilled) {
        $('#checkupsave')
            .removeClass('gray-submit-btn')
            .addClass('point-submit-btn')
            .prop('disabled', false);
    } else {
        $('#checkupsave')
            .removeClass('point-submit-btn')
            .addClass('gray-submit-btn')
            .prop('disabled', true);
    }
});
*/

</script>

<script type="text/javascript">
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////// temp /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    $(document).on('click', '.temp-block-wrap button:not(.data-select-btn)', function () {
        $.confirm({
            title: 'This feature is under preparation.',
            content: ' ',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                OK: {
                    btnClass: 'btn-blue',
                    action: function(){
                        // 확인 눌렀을 때 실행할 동작 (필요 시)
                    }
                }
            }
        });
    });

function drawServiceRequestsChart() {
    let ctx = document.getElementById('serviceRequests_myChart');
    if (!ctx) {
        console.warn("Canvas with id 'serviceChart' not found.");
        return;
    }

    let labels = ['Nursing', 'Ambulance', 'Consultation'];
    let data = [
        Math.floor(Math.random() * 30) + 10,
        Math.floor(Math.random() * 30) + 10,
        Math.floor(Math.random() * 30) + 10
    ];

    $("#temp-item-01").text(data[0]);
    $("#temp-item-02").text(data[1]);
    $("#temp-item-03").text(data[2]);
    $("#temp-item-sum").text(data.reduce((a, b) => a + b, 0));

    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '',
                    data: data,
                    backgroundColor: [
                        'rgba(82, 158, 232, 1)',   // Nursing
                        'rgba(255, 202, 134, 1)',  // Ambulance
                        'rgba(238, 147, 144, 1)'   // Consultation
                    ]
                }
            ]
        },
        options: {
            borderColor: 'transparent',
            borderWidth: 0,
            maintainAspectRatio: false,
            responsive: true,
            cutout: '70%',
            layout: {
                padding: {
                    right: 50,
                    bottom: 10,
                    top: 10
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: "right",
                    labels: {
                        boxWidth: 26,
                        boxHeight: 26,
                        padding: 14,
                        usePointStyle: true,
                        pointStyle: 'rectRounded',
                        font: {
                            size: 14
                        },
                        generateLabels: (chart) => {
                            let datasets = chart.data.datasets;
                            return datasets[0].data.map((data, i) => ({
                                text: chart.data.labels[i] + '(' + data + ')',
                                strokeStyle: 'rgba(0,0,0,0)',
                                lineWidth: 0,
                                fillStyle: datasets[0].backgroundColor[i],
                                index: i,
                                pointStyle: 'rectRounded'
                            }));
                        },
                        borderWidth: 0
                    },
                    fullSize: true,
                    align: "center"
                },
                tooltip: {
                    enabled: false,
                    position: 'nearest',
                    external: externalTooltipHandler // 네가 쓰던 툴팁 있으면 그대로 써!
                },
                datalabels: {
                    color: 'rgba(86, 86, 86, 1)',
                    font: {
                        size: 12,
                        weight: 'bold'
                    },
                    formatter: (value) => value
                },
                shadowCirclePlugin: {
                    shadowColor: 'rgba(0, 0, 0, 0.1)',
                    shadowBlur: 3,
                    shadowOffsetX: 5,
                    shadowOffsetY: 3,
                    shadowFill: '#fff'
                }
            }
        },
        plugins: [doughnutLabel, ChartDataLabels, shadowCirclePlugin]
    });
}

$(document).on('click', '#serviceRequests_reqTp .data-select-btn', function () {
    $('#serviceRequests_reqTp .data-select-btn').removeClass('active');
    $(this).addClass('active');

    let selected = $(this).data('filter');
});

</script>