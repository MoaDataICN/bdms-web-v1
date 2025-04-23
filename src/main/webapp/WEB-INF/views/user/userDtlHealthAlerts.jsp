<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #healthAlerts_pager {
        display:none;
    }
</style>

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn active" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
</div>

    <div class="alerts-wrap mt-30px">
        <!-- Mini userDtlGeneral -->
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">(${userDtlGeneral.userId}) ${userDtlGeneral.userNm}ㅣ${userDtlGeneral.brthDt}ㅣ${userDtlGeneral.sx}ㅣ${userDtlGeneral.mobile}ㅣ${userDtlGeneral.addr}</p>
            <p class="title-status mr-12px">-<span class="bold-t-01" id="healthAlerts_cntTotal">{0}</span><spring:message code="healthAlertsTap.description"/></p>
        </div>

        <div class="alerts-grid mt-12px">
            <!-- userDtlHealthAlerts Chart -->
            <div class="alerts-chart" style="overflow:visible !important">
                <!--
                <img src="../../resources/images/board-alerts-chart.png" class="mt-12px alerts-chart-size">
                -->
                <canvas id="healthAlerts_myChart" height="310" style="overflow:visible !important"></canvas>
                <div class="chart-tap-group">
                    <button type="button" class="chart-tap-btn left active" id="healthAlertsChartAllBtn">All</button>
                    <button type="button" class="chart-tap-btn right" id="healthAlertsChartLast24Btn">Last 24h</button>
                </div>
            </div>
            <!-- 아이템 묶음-->
            <div class="alerts-grid02">
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/activity-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.activity"/> / <spring:message code="common.fall"/>
                        </div>
                        <div class="alerts-item-text02" id="healthAlerts_cntAF">
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/heart-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.heartrate"/>
                        </div>
                        <div class="alerts-item-text02" id="healthAlerts_cntH">
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/sleep-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.sleep"/>
                        </div>
                        <div class="alerts-item-text02" id="healthAlerts_cntSL">
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/blood-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.bloodoxygen"/>
                        </div>
                        <div class="alerts-item-text02" id="healthAlerts_cntB">
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/temperature-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.temperature"/>
                        </div>
                        <div class="alerts-item-text02" id="healthAlerts_cntT">
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/stress-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.stress"/>
                        </div>
                        <div class="alerts-item-text02" id="healthAlerts_cntST">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 검색 영역 -->
        <div class="second-container mt-18px">
            <div class="content-row">
                <!-- 좌측 입력폼 그룹 -->
                <div class="row-md-100">
                    <div class="row-wrap">
                        <div class="input-label01">
                            Inquiry Period
                        </div>
                        <div class="row-input">
                            <div class="p-r">
                                <input type="text" class="date-input input-txt02" id="healthAlertsBgnDe" placeholder="ALL" readonly="">
                                <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('healthAlerts_datePicker1')" alt="달력 아이콘">
                                <input type="date" id="healthAlerts_datePicker1" class="hidden-date" onchange="updateDate('healthAlerts_datePicker1', 'healthAlertsBgnDe')">
                            </div>
                            <img src="/resources/images/minus-icon.svg" class="icon14 img-none">
                            <div class="p-r">
                                <input type="text" class="date-input input-txt02" id="healthAlertsEndDe" placeholder="ALL" readonly="">
                                <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('healthAlerts_datePicker2')" alt="달력 아이콘">
                                <input type="date" id="healthAlerts_datePicker2" class="hidden-date" onchange="updateDate('healthAlerts_datePicker2', 'healthAlertsEndDe')">
                            </div>
                            <div class="day-button-wrap" id="healthAlerts_date">
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
                    <div class="row-wrap mb-0px">
                        <div class="input-label01">
                            Alert type
                        </div>
                        <div class="row-input">
                            <div class="day-button-wrap02" id="healthAlerts_altTp">
                                <button class="data-select-btn active" data-filter="alertTpAll">All</button>
                                <button class="data-select-btn" data-filter="AF">Activity/Falls</button>
                                <button class="data-select-btn" data-filter="H">Heart rate</button>
                                <button class="data-select-btn" data-filter="SL">Sleep</button>
                                <button class="data-select-btn" data-filter="B">Blood oxygen</button>
                                <button class="data-select-btn" data-filter="T">Temperature</button>
                                <button class="data-select-btn" data-filter="ST">Stress</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- submit 버튼 묶음-->
        <div class="content-submit-ui mt-22px">
            <div class="submit-ui-wrap">
            </div>
            <div class="submit-ui-wrap">
                <button type="button" class="gray-submit-btn" onclick="healthAlerts_fnClear()">
                    <img src="/resources/images/reset-icon.svg" class="icon22">
                    <span><spring:message code='common.reset'/></span>
                </button>
        
                <button type="button" class="point-submit-btn" onclick="healthAlerts_fnSearch()">
                    <img src="/resources/images/search-icon.svg" class="icon22">
                    <span>Search</span>
                </button>
            </div>
        </div>

    <div class="table-wrap mt-36px">
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">
                <span class="bold-t-01" id="healthAlertsCurrentRowsCnt">0</span>
                <spring:message code="common.outOf"/>
                <span class="bold-t-01" id="healthAlertsTotalResultsCnt">0</span>
                <spring:message code="common.results"/>
            </p>
            <div class="table-option-wrap">
                <div class="dropdown02">
                    <button class="dropdown-search input-line-b" id="healthAlerts_gridDropdownBtn"><spring:message code="common.viewResults" arguments="10" /> <span><img class="icon20"
                                                                                            alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                    <div class="dropdown-content" id="healthAlerts_viewCntDropdown">
                        <a data-cnt="100"><spring:message code="common.viewResults" arguments="100" /></a>
                        <a data-cnt="50"><spring:message code="common.viewResults" arguments="50" /></a>
                        <a data-cnt="10"><spring:message code="common.viewResults" arguments="10" /></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- userDtlHealthAlerts Grid -->
        <div class="table-wrap mt-14px" style="width:100%;">
            <div class="w-line01 mt-8px"></div>
            <div class="main-table">
                <div class="tableWrapper">
                    <table id="healthAlerts_grid" style="width:100%;"></table>
                    <div id="healthAlerts_pager"></div>
                    <div id="userDtlCustomPager" class="page-group mb-22px mt-10px"></div>
                </div>
            </div>
        </div>

        <form name="excelForm" method="POST">
            <input type="hidden" id="healthAlerts_sortColumn" name="sortColumn" value="reqDt"/>
            <input type="hidden" id="healthAlerts_sord" name="sord" value="DESC"/>
        </form>
    </div>

<div class="space-30"></div>
