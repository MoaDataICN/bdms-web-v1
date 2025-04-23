<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #serviceRequests_pager {
        display:none;
    }
</style>

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn active" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
</div>

    <div class="alerts-wrap mt-30px">
        <!-- Mini userDtlGeneral -->
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">(${userDtlGeneral.userId}) ${userDtlGeneral.userNm}ㅣ${userDtlGeneral.brthDt}ㅣ${userDtlGeneral.sx}ㅣ${userDtlGeneral.mobile}ㅣ${userDtlGeneral.addr}</p>
            <p class="title-status mr-12px">-<span class="bold-t-01" id="serviceRequests_cntTotal">{0}</span><spring:message code="serviceRequestsTap.description"/></p>
        </div>

        <div class="alerts-grid mt-12px">
            <!-- Today's health-chart -->
            <div class="alerts-chart" style="overflow:visible !important">
                <!--
                <img src="../../resources/images/board-alerts-chart.png" class="mt-12px alerts-chart-size">
                -->
                <canvas id="serviceRequests_myChart" height="310" style="overflow:visible !important"></canvas>
                <div class="chart-tap-group">
                    <button type="button" class="chart-tap-btn left active" id="serviceRequestsChartAllBtn">All</button>
                    <button type="button" class="chart-tap-btn right" id="serviceRequestsChartLast24Btn">Last 24h</button>
                </div>
            </div>
            <!-- 아이템 묶음-->
            <div class="alerts-grid04">
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="/resources/images/nurse-line-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            Nursing
                        </div>
                        <div class="alerts-item-text02" id="serviceRequests_cntN">
                            20
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="/resources/images/ambulance-line-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            Ambulance
                        </div>
                        <div class="alerts-item-text02" id="serviceRequests_cntA">
                            38
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="/resources/images/consultation-line-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            TeleHealth
                        </div>
                        <div class="alerts-item-text02" id="serviceRequests_cntT">
                            72
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
                                <input type="text" class="date-input input-txt02" id="serviceRequestsBgnDe" placeholder="ALL" readonly="">
                                <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('serviceRequests_datePicker1')" alt="달력 아이콘">
                                <input type="date" id="serviceRequests_datePicker1" class="hidden-date" onchange="updateDate('serviceRequests_datePicker1', 'serviceRequestsBgnDe')">
                            </div>
                            <img src="/resources/images/minus-icon.svg" class="icon14 img-none">
                            <div class="p-r">
                                <input type="text" class="date-input input-txt02" id="serviceRequestsEndDe" placeholder="ALL" readonly="">
                                <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('serviceRequests_datePicker2')" alt="달력 아이콘">
                                <input type="date" id="serviceRequests_datePicker2" class="hidden-date" onchange="updateDate('serviceRequests_datePicker2', 'serviceRequestsEndDe')">
                            </div>
                            <div class="day-button-wrap" id="serviceRequests_date">
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
                            Service Type
                        </div>
                        <div class="row-input">
                            <div class="day-button-wrap02" id="serviceRequests_reqTp">
                                <button class="data-select-btn active" data-filter="reqTpAll">All</button>
                                <button class="data-select-btn" data-filter="N">Nursing</button>
                                <button class="data-select-btn" data-filter="A">Ambulance</button>
                                <button class="data-select-btn" data-filter="T">TeleHealth</button>
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
                <button type="button" class="gray-submit-btn" onclick="serviceRequests_fnClear()">
                    <img src="/resources/images/reset-icon.svg" class="icon22">
                    <span>Reset</span>
                </button>
        
                <button type="button" class="point-submit-btn" onclick="serviceRequests_fnSearch()">
                    <img src="/resources/images/search-icon.svg" class="icon22">
                    <span>Search</span>
                </button>
            </div>
        </div>

    <div class="table-wrap mt-36px">
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">
                <span class="bold-t-01" id="serviceRequestsCurrentRowsCnt">0</span>
                <spring:message code="common.outOf"/>
                <span class="bold-t-01" id="serviceRequestsTotalResultsCnt">0</span>
                <spring:message code="common.results"/>
            </p>
            <div class="table-option-wrap">
                <div class="dropdown02">
                    <button class="dropdown-search input-line-b" id="serviceRequests_gridDropdownBtn"><spring:message code="common.viewResults" arguments="10" /> <span><img class="icon20"
                                                                                            alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                    <div class="dropdown-content" id="serviceRequests_viewCntDropdown">
                        <a data-cnt="100"><spring:message code="common.viewResults" arguments="100" /></a>
                        <a data-cnt="50"><spring:message code="common.viewResults" arguments="50" /></a>
                        <a data-cnt="10"><spring:message code="common.viewResults" arguments="10" /></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- userDtlServiceRequests Grid -->
        <div class="table-wrap mt-14px" style="width:100%;">
            <div class="w-line01 mt-8px"></div>
            <div class="main-table">
                <div class="tableWrapper">
                    <table id="serviceRequests_grid" style="width:100%;"></table>
                    <div id="serviceRequests_pager"></div>
                    <div id="userDtlCustomPager" class="page-group mb-22px mt-10px"></div>
                </div>
            </div>
        </div>

        <form name="excelForm" method="POST">
            <input type="hidden" id="serviceRequests_sortColumn" name="sortColumn" value="reqDt"/>
            <input type="hidden" id="serviceRequests_sord" name="sord" value="DESC"/>
        </form>
    </div>

<div class="space-30"></div>
