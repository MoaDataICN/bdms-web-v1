<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="/resources/js/grid/pager.js"></script>
<script src="/resources/js/grid/userDtlPager.js"></script>
<script src="/resources/js/chart/doughnutChart.js"></script>
<script src="/resources/js/common/slide/userDtlSlide.js"></script>
<script src="/resources/js/common/utils/calcUtil.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

<style>
    #healthAlertPager {
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
    <!-- 대시보드 타이틀 -->
    <div class="second-title">
        <spring:message code="common.menu.health_alert"/>
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
                        <input type="text" class="input-txt02 hold" id="userNm" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.loginId"/>
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
                        <spring:message code="common.phone"/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02" id="mobile" placeholder="Please enter(ex.012-3456-7890)"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.uid"/>
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
                        <spring:message code="common.sex"/>
                    </div>
                    <div class="dropdown">
                        <button class="dropdown-search" id="sx"><spring:message code="common.all"/><span><img class="icon20" alt=""
                                                                      src="/resources/images/arrow-gray-bottom.svg"></span></button>
                        <div class="dropdown-content">
                            <a onclick="$('#sx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.all"/></a>
                            <a onclick="$('#sx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.sex.f"/></a>
                            <a onclick="$('#sx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.sex.m"/></a>
                        </div>
                    </div>
                </div>
                <div class="row-wrap">
                    <c:if test="${fn:length(inChargeList) > 0}">
                        <div class="input-label01">
                            <spring:message code="common.inCharge"/>
                        </div>
                        <div class="dropdown">
                            <button class="dropdown-search" id="inChargeNm"><spring:message code="common.all"/><span><img class="icon20" alt=""
                                                                              src="/resources/images/arrow-gray-bottom.svg"></span></button>
                            <div class="dropdown-content">
                                <a data-inchargeid="All" onclick="$('#inChargeNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.all"/></a>
                                <c:forEach var="inCharge" items="${inChargeList}">
                                    <a data-inchargeid="${inCharge.userId}" onclick="$('#inChargeNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())">${inCharge.userNm}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.birthDt"/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 datePicker" id="brthDt" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <c:if test="${fn:length(groupList) > 0}">
                        <div class="input-label01">
                            <spring:message code="common.group"/>
                        </div>
                        <div class="dropdown">
                            <button class="dropdown-search" id="grpNm"><spring:message code="common.all"/><span><img class="icon20" alt=""
                                                                             src="/resources/images/arrow-gray-bottom.svg"></span></button>
                            <div class="dropdown-content">
                                <a data-grpid="All" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3 }).first().replaceWith($(this).text())"><spring:message code="common.all"/></a>
                                <a data-grpid="Group A" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())">Group A</a>
                                <a data-grpid="Group B" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())">Group B</a>
                                <a data-grpid="Group C" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())">Group C</a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.regDt"/>
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
                        <div class="day-button-wrap">
                            <button class="data-select-btn periodBtn" data-period="today">Today</button>
                            <button class="data-select-btn periodBtn active" data-period="7-day">7day</button>
                            <button class="data-select-btn periodBtn" data-period="30-day">30day</button>
                            <button class="data-select-btn periodBtn" data-period="90-day">90day</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.alertTp"/>
                    </div>
                    <div class="row-input">
                        <div class="day-button-wrap02">
                            <button class="data-select-btn alertBtns active" data-filter="all"><spring:message code="common.all"/></button>
                            <button class="data-select-btn alertBtns" data-filter="A"><spring:message code="common.alertTp.A"/></button>
                            <button class="data-select-btn alertBtns" data-filter="F"><spring:message code="common.alertTp.F"/></button>
                            <button class="data-select-btn alertBtns" data-filter="H"><spring:message code="common.alertTp.H"/></button>
                            <button class="data-select-btn alertBtns" data-filter="SL"><spring:message code="common.alertTp.SL"/></button>
                            <button class="data-select-btn alertBtns" data-filter="B"><spring:message code="common.alertTp.B"/></button>
                            <button class="data-select-btn alertBtns" data-filter="T"><spring:message code="common.alertTp.T"/></button>
                            <button class="data-select-btn alertBtns" data-filter="ST"><spring:message code="common.alertTp.ST"/></button>
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
                <table id="healthAlertList"></table>
                <div id="healthAlertPager"></div>
                <div id="customPager" class="page-group mb-22px mt-10px"></div>
            </div>
        </div>
    </div>

    <form name="excelForm" method="POST">
        <input type="hidden" id="sortColumn" name="sortColumn" value="dctDt"/>
        <input type="hidden" id="sord" name="sord" value="DESC"/>
    </form>

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
        <div class="slide-popup-container">
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
</main>

<script type="text/javascript">
    const inChargeId = '${inChargeId}';

    // Grid 하단 페이저 숫자
    const pageSize = 10;
    let currentPageGroup = 1;

    // 기본 Items 개수
    var rowNumsVal = 10;

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

    function setSearchParam() {
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
            inChargeNm : $('#inChargeNm').text() != "All" ? $('#inChargeNm').text() : "",
            grpTp : $('#grpNm').text() != "All" ? $('#grpNm').text() : "",
            altTp : $('.alertBtns.active').data('filter') != 'all' ? $('.alertBtns.active')
                .map(function() {
                    return "\"" + $(this).data('filter') + "\"";
                })
                .get()
                .join(',') : "'A','F','H','SL','B','T','ST'"
        };
    }

    function fnClear() {
        $('#searchBgnDe').val('');
        $('#searchEndDe').val('');
        $('#userNm').val('');
        $('#emailId').val('');
        $('#userId').val('');
        $('#mobile').val('');
        $('#sx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('All');
        $('#brthDt').val('');
        $('#inChargeNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('All');
        $('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('All');
        $('.alertBtns.active').removeClass('active');
        $('.alertBtns')[0].classList.add('active');
        $('.periodBtn')[3].click();
    }

    function fnSearch(){
        $('#healthAlertList').jqGrid('setGridParam', {
            url: 'selectHealthAlert',
            datatype: 'json',
            postData : setSearchParam()
        });
        $('#healthAlertList').trigger('reloadGrid', [{page:1, current:true}]);
    }

    $(document).ready(function() {
        $('.datePicker').datepicker({
            dateFormat: 'yy-mm-dd',
            autoclose: true,
            todayHighlight:true
        });

        $('#searchBgnDe').val(moment().subtract(6,'days').format('YYYY-MM-DD'))
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'))


        $('#healthAlertList').jqGrid({
            url : '${contextPath}/tracking/selectHealthAlert',
            mtype : "POST",
            datatype: "json",
            jsonReader : {repeatitems: false},
            postData: setSearchParam(),
            colModel : [
                { label: 'Detected Time', name: 'dctDt', width:200, sortable : true},
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
            rowNum : rowNumsVal,
            rowList:[10,50,100],
            jsonReader: {
                root: "rows",          // 데이터 리스트
                page: "page",          // 현재 페이지
                total: "total",
                records: "records"        // 전체 개수
            },
            sortable : true,
            sortname : 'dctDt',
            sortorder : 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            loadonce : false,
            pager : '#healthAlertPager',
            viewrecords: true,
            loadComplete: function(data) {
                $('#totalResultsCnt').text(data.records);
                $('#currentRowsCnt').text(data.rows.length);
                createCustomPager('healthAlertList');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createCustomPager('healthAlertList');
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
        console.log('resize')
        jQuery("#healthAlertList").jqGrid('setGridWidth', $(".table-wrap").width());
    })


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


    $(document).on('click','.alertBtns', function(){
        if($('.alertBtns.active').length === 1 && $('.alertBtns.active')[0] == this){
            return;
        }

        if(this.dataset['filter'] === 'all') {
            $('.alertBtns').removeClass('active');

            $(this).addClass('active');
        } else {
            $('[data-filter="all"]').removeClass('active');
            $(this).toggleClass('active');
        }
    })

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
        $("#healthAlertList").setGridParam({ rowNum: cnt });
        fnSearch();
    })

    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            fnSearch();
        }
    });
</script>