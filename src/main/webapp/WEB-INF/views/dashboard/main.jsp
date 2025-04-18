<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="../../resources/js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="../../resources/js/chart/doughnutChart.js"></script>

<style>
    .ui-jqgrid-htable {
        width:100% !important;
    }

    #alertGrid {
        width: 100% !important;
    }

    #customPager {
        text-align:center;
        margin-top:24px;
        display:flex;
        gap: 6px;
        justify-content:center;
    }

    #alertGridPager {
        display:none;
    }

    .nav-btn:disabled {
        color: rgb(209 209 209 / 50%);
    }

    .page-btn:hover,.nav-btn:hover {
        cursor:pointer;
    }

    #rowNumSelect {
        width:124px;
        height:24px;
        border:1px solid rgba(208,215,223,1);
        border-radius:3px;
        text-align:center;
        font-size : 12px;
        color: rgba(96,96,97,1);
    }
</style>

<!-- 주요콘텐츠 영역-->
<main class="main">
    <!-- 대시보드 타이틀 -->
    <div class="board-title">
        <spring:message code="board.title.dashboard"/>
        <p class="board-title-sub"><spring:message code="board.title.sub"/></p>
    </div>
    <!-- Tracking 현황 -->
    <div class="tracking-grid mt-16px">
        <!-- Health Alerts -->
        <div class="tracking-group">
            <div class="board-title02 point-bg-01">
                <spring:message code="board.tracking.health"/>
            </div>
            <div class="board-data-group">
                <div class="board-icon-box point-bg-05">
                    <img src="../../resources/images/calendar-icon.png" class="icon32">
                </div>
                <div class="data-title01" id="HA_total">
                    0
                </div>
                <c:set var="alert_sum_0" value="0" />
                <c:set var="alert_sum_1" value="0" />

                <c:forEach var="entry" items="${healthAlertCntMap}">
                    <c:set var="innerMap" value="${entry.value}" />

                    <c:if test="${innerMap['0'] != null}">
                        <c:set var="alert_sum_0" value="${alert_sum_0 + innerMap['0']}" />
                    </c:if>

                    <c:if test="${innerMap['1'] != null}">
                        <c:set var="alert_sum_1" value="${alert_sum_1 + innerMap['1']}" />
                    </c:if>
                </c:forEach>
                <div class="data-group">
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.unprocessed"/>
                        </div>
                        <div class="data-stats" id="HA_0">${alert_sum_0}</div>
                    </div>
                    <div class="w-line01 mt-10px mb-10px"></div>
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.processed"/>
                        </div>
                        <div class="data-stats" id="HA_1">${alert_sum_1}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Ambulance service -->
        <div class="tracking-group">
            <div class="board-title02 point-bg-02">
                <spring:message code="board.tracking.ambulance"/>
            </div>
            <div class="board-data-group">
                <div class="board-icon-box point-bg-06">
                    <img src="../../resources/images/ambulance-icon.png" class="ambulance-img">
                </div>
                <div class="data-title01" id="A_total">
                    0
                </div>
                <div class="data-group">
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.processed"/>
                        </div>
                        <div class="data-stats" id="A_1">
                            <c:choose>
                                <c:when test="${not empty userRequestCntMap['A'] && not empty userRequestCntMap['A']['1']}">
                                    ${userRequestCntMap['A']['1']}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="w-line01 mt-10px mb-10px"></div>
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.unprocessed"/>
                        </div>
                        <div class="data-stats" id="A_0">
                            <c:choose>
                                <c:when test="${not empty userRequestCntMap['A'] && not empty userRequestCntMap['A']['0']}">
                                    ${userRequestCntMap['A']['0']}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Nursing service -->
        <div class="tracking-group">
            <div class="board-title02 point-bg-03">
                <spring:message code="board.tracking.nursing"/>
            </div>
            <div class="board-data-group">
                <div class="board-icon-box point-bg-07">
                    <img src="../../resources/images/nurse-icon.png" class="nursing-img">
                </div>
                <div class="data-title01" id="N_total">
                    0
                </div>
                <div class="data-group">
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.unprocessed"/>
                        </div>
                        <div class="data-stats" id="N_1">
                            <c:choose>
                                <c:when test="${not empty userRequestCntMap['N'] && not empty userRequestCntMap['N']['1']}">
                                    ${userRequestCntMap['N']['1']}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="w-line01 mt-10px mb-10px"></div>
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.processed"/>
                        </div>
                        <div class="data-stats" id="N_0">
                            <c:choose>
                                <c:when test="${not empty userRequestCntMap['N'] && not empty userRequestCntMap['N']['0']}">
                                    ${userRequestCntMap['N']['0']}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Telehealth Service -->
        <div class="tracking-group">
            <div class="board-title02 point-bg-04">
                <spring:message code="board.tracking.telehealth"/>
            </div>
            <div class="board-data-group">
                <div class="board-icon-box point-bg-08">
                    <img src="../../resources/images/phone-icon.png" class="icon29">
                </div>
                <div class="data-title01" id="T_total">
                    0
                </div>
                <div class="data-group">
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.unprocessed"/>
                        </div>
                        <div class="data-stats" id="T_1">
                            <c:choose>
                                <c:when test="${not empty userRequestCntMap['T'] && not empty userRequestCntMap['T']['1']}">
                                    ${userRequestCntMap['T']['1']}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="w-line01 mt-10px mb-10px"></div>
                    <div class="data-detail">
                        <div class="data-title02">
                            <span class="circle-5px"></span>
                            <spring:message code="common.processed"/>
                        </div>
                        <div class="data-stats" id="T_0">
                            <c:choose>
                                <c:when test="${not empty userRequestCntMap['T'] && not empty userRequestCntMap['T']['0']}">
                                    ${userRequestCntMap['T']['0']}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- clients status 묶음 -->
    <div class="client-wrap mt-30px">
        <div class="title-group">
            <div class="board-title03">
                <c:choose>
                    <c:when test="${not empty statusList[0].IN_CHARGE_ID}">
                        <spring:message code="board.subtitle.admin"/>
                    </c:when>
                    <c:otherwise>
                        <spring:message code="board.subtitle.client"/>
                    </c:otherwise>
                </c:choose>

                <p class="title-status"><spring:message code="board.comment.responsible" arguments="${fn:length(statusList)}" /></p>
            </div>
            <div class="client-label mr-12px">
                <div class="client-label-text">
                    <span class="alerted-circle02"></span>
                    <spring:message code="common.alerted"/>
                </div>
                <div class="client-label-text">
                    <span class="requested-circle02"></span>
                    <spring:message code="common.requested"/>
                </div>
            </div>
        </div>
        <div class="client-group mt-12px">
            <button type="button" class="client-more">
                <img src="../../resources/images/arrow-bottom.svg" class="arrow-bottom">
            </button>
            <div class="client-grid">
                <c:if test="${fn:length(statusList) > 0}">
                    <c:forEach var="member" items="${statusList}">
                        <a href="#">
                            <div class="client-item <c:if test="${member.ALT_YN eq 'Y' && member.REQ_YN eq 'Y'}">client-r-bold client-bg-bold</c:if>">
                                <c:if test="${member.REQ_YN eq 'Y'}">
                                    <div class="circle-red">
                                        <div class="requested-circle"></div>
                                    </div>
                                </c:if>
                                <c:if test="${member.ALT_YN eq 'Y'}">
                                    <div class="circle-yellow">
                                        <div class="alerted-circle"></div>
                                    </div>
                                </c:if>

                                    <!-- 클라이언트 사진 들어가는 곳-->
                                <c:choose>
                                    <c:when test="${not empty member.ATTCH_ID && member.ATTCH_ID ne ''}">
                                        <div class="client-photo">
                                            <img src="/api/image?attchId=${member.ATTCH_ID}" class="icon48 client-photo-round">
                                        </div>
                                        <div class="client-name">
                                                ${member.USER_NM}
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="client-name" style="height: 48px;">
                                            ${member.USER_NM}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </c:forEach>
                </c:if>


                <!-- 아이템 라운드 진하게 하려면 'client-r-bold' bg블루색상도 적용 'client-bg-bold' 클래스 적용-->
                <!--
                <a href="#">
                    <div class="client-item client-r-bold client-bg-bold">
                        <div class="circle-red">
                            <div class="requested-circle"></div>
                        </div>
                        <div class="circle-yellow">
                            <div class="alerted-circle"></div>
                        </div>
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample1.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            Michael William no1
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item">
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample2.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            James
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item">
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample3.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            Robert
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item">
                        <div class="circle-yellow">
                            <div class="alerted-circle"></div>
                        </div>
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample4.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            William
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item">
                        <div class="circle-yellow">
                            <div class="alerted-circle"></div>
                        </div>
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample5.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            Emily
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item">
                        <div class="circle-yellow">
                            <div class="alerted-circle"></div>
                        </div>
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample6.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            Jessica
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item client-r-bold client-bg-bold">
                        <div class="circle-red">
                            <div class="requested-circle"></div>
                        </div>
                        <div class="circle-yellow">
                            <div class="alerted-circle"></div>
                        </div>
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample7.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            Jennife
                        </div>
                    </div>
                </a>

                <a href="#">
                    <div class="client-item">
                        <div class="client-photo">
                            <img src="../../resources/images/user-sample8.jpg" class="icon48 client-photo-round">
                        </div>
                        <div class="client-name">
                            Nursing
                        </div>
                    </div>
                </a>
                -->
            </div>
        </div>
    </div>

    <!-- Today's health alerts staus 묶음 -->
    <div class="alerts-wrap mt-30px">
        <div class="title-group">
            <div class="board-title03">
                <spring:message code="board.subtitle.alert"/>
            </div>
            <p class="title-status mr-12px"><spring:message code="board.comment.description" arguments="${alert_sum_0 + alert_sum_1}" /></p>
        </div>

        <div class="alerts-grid mt-12px">
            <!-- Today's health-chart-->
            <div class="alerts-chart" style="overflow:visible !important">
                <!--
                <img src="../../resources/images/board-alerts-chart.png" class="mt-12px alerts-chart-size">
                -->
                <canvas id="myChart" height="310" style="overflow:visible !important"></canvas>
            </div>
            <!-- Today's health-chart 우측 아이템 묶음-->
            <div class="alerts-grid02">
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/activity-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.activity"/>
                        </div>
                        <div class="alerts-item-text02">
                            ${healthAlertCntMap.A["0"] + healthAlertCntMap.A["1"]}
                        </div>
                    </div>
                </div>
                <!-- 아이템 -->
                <div class="alerts-item">
                    <div class="alerts-icon-box">
                        <img src="../../resources/images/activity-icon.svg">
                    </div>
                    <div class="alerts-text-group">
                        <div class="alerts-item-text01">
                            <spring:message code="common.fall"/>
                        </div>
                        <div class="alerts-item-text02">
                            ${healthAlertCntMap.F["0"] + healthAlertCntMap.F["1"]}
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
                        <div class="alerts-item-text02">
                            <c:out value="${healthAlertCntMap.H['0'] + healthAlertCntMap.H['1']}" default="0"></c:out>
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
                        <div class="alerts-item-text02">
                            <c:out value="${healthAlertCntMap.SL['0'] + healthAlertCntMap.SL['1']}" default="0"></c:out>
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
                        <div class="alerts-item-text02">
                            <c:out value="${healthAlertCntMap.B['0'] + healthAlertCntMap.B['1']}" default="0"></c:out>
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
                        <div class="alerts-item-text02">
                            <c:out value="${healthAlertCntMap.T['0'] + healthAlertCntMap.T['1']}" default="0"></c:out>
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
                        <div class="alerts-item-text02">
                            <c:out value="${healthAlertCntMap.ST['0'] + healthAlertCntMap.ST['1']}" default="0"></c:out>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Today Health alerts status - 버튼 묶음-->
        <div class="alerts-table-ui mt-28px" >
            <div class="buttonWrapper" style="width:100%; display:flex; gap: 6px;">
                <button type="button" class="round-gray-btn alertBtns active" data-filter="all">All</button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="A"><spring:message code="common.activity"/></button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="F"><spring:message code="common.fall"/></button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="H"><spring:message code="common.heartrate"/></button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="SL"><spring:message code="common.sleep"/></button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="B"><spring:message code="common.bloodoxygen"/></button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="T"><spring:message code="common.temperature"/></button>
                <button type="button" class="round-gray-btn alertBtns" data-filter="ST"><spring:message code="common.stress"/></button>
            </div>
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

        <!-- Today health board Table -->
        <div class="table-wrap mt-14px" style="width:100%;">
            <table id="alertGrid" style="width:100%;"></table>
            <div id="alertGridPager"></div>
            <div id="customPager" class="page-group mb-22px mt-10px"></div>
        </div>
    </div>

    <!-- footer copyright -->
    <div class="copyright mt-12px"><spring:message code="common.copyright"/></div>
</main>

<script type="text/javascript">

    const today = moment().format('YYYY-MM-DD');

    <!-- Alert & Service Summation S -->
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

    var HA_total = Number($('#HA_0').text()) + Number($('#HA_1').text());
    var A_total = Number($('#A_0').text()) + Number($('#A_1').text());
    var N_total = Number($('#N_0').text()) + Number($('#N_1').text());
    var T_total = Number($('#T_0').text()) + Number($('#T_1').text());

    calc('HA_total', HA_total);
    calc('A_total', A_total);
    calc('N_total', N_total);
    calc('T_total', T_total);

    <!-- Alert & Service Summation E -->

    <!-- Chart S -->

    let healthAlerts = {
        'Activity': <c:out value="${
        (healthAlertCntMap.A['0'] != null ? healthAlertCntMap.A['0'] : 0) +
        (healthAlertCntMap.A['1'] != null ? healthAlertCntMap.A['1'] : 0)
    }" default="0" />,

        'Falls': <c:out value="${
        (healthAlertCntMap.F['0'] != null ? healthAlertCntMap.F['0'] : 0) +
        (healthAlertCntMap.F['1'] != null ? healthAlertCntMap.F['1'] : 0)
    }" default="0" />,

        'Heart Rate': <c:out value="${
        (healthAlertCntMap.H['0'] != null ? healthAlertCntMap.H['0'] : 0) +
        (healthAlertCntMap.H['1'] != null ? healthAlertCntMap.H['1'] : 0)
    }" default="0" />,

        'Sleep': <c:out value="${
        (healthAlertCntMap.SL['0'] != null ? healthAlertCntMap.SL['0'] : 0) +
        (healthAlertCntMap.SL['1'] != null ? healthAlertCntMap.SL['1'] : 0)
    }" default="0" />,

        'Blood Oxygen': <c:out value="${
        (healthAlertCntMap.B['0'] != null ? healthAlertCntMap.B['0'] : 0) +
        (healthAlertCntMap.B['1'] != null ? healthAlertCntMap.B['1'] : 0)
    }" default="0" />,

        'Temperature': <c:out value="${
        (healthAlertCntMap.T['0'] != null ? healthAlertCntMap.T['0'] : 0) +
        (healthAlertCntMap.T['1'] != null ? healthAlertCntMap.T['1'] : 0)
    }" default="0" />,

        'Stress': <c:out value="${
        (healthAlertCntMap.ST['0'] != null ? healthAlertCntMap.ST['0'] : 0) +
        (healthAlertCntMap.ST['1'] != null ? healthAlertCntMap.ST['1'] : 0)
    }" default="0" />
    };

    let sum = 0;

    function summation(arr) {
        let sum = 0;
        arr.forEach((num) => { sum += num; })
        return sum
    }

    let myCt = document.getElementById('myChart');
    let myChart = new Chart(myCt, {
        type: 'doughnut',
        data: {
            labels: Object.keys(healthAlerts),
            datasets: [
                {
                    label: '',
                    data: Object.values(healthAlerts),
                    backgroundColor: ['rgba(0, 0, 0, 1)', 'rgba(82, 158, 232, 1)', 'rgba(160, 205, 255, 1)', 'rgba(255, 202, 134, 1)','rgba(238, 147, 144, 1)','rgba(251, 228, 137, 1)','rgba(216, 216, 216, 1)']
                }
            ]
        },
        options: {
            borderColor: 'transparent',
            borderWidth: 0,
            maintainAspectRatio: false,
            responsive: true,
            cutout : '70%',
            layout: {
                padding: {
                    right: 50,
                    bottom: 10,
                    top: 10,
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: "right",
                    labels: {
                        boxWidth: 26,
                        boxHeight:26,
                        padding: 14,
                        usePointStyle: true,
                        pointStyle: 'rectRounded',
                        font: {
                            size: 14
                        },
                        generateLabels: (chart) => {
                            const datasets = chart.data.datasets;
                            return datasets[0].data.map((data, i) => ({
                                text: chart.data.labels[i] + '('+data+')',
                                strokeStyle: 'rgba(0,0,0,0)',
                                lineWidth: 0,
                                fillStyle: datasets[0].backgroundColor[i],
                                index: i,
                                pointStyle: 'rectRounded',
                            }))
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
                    color: function (ctx) {
                        const value = ctx.dataset.data[ctx.dataIndex]
                        if (ctx.dataIndex === 0) {
                            return '#ffffff';
                        } else {
                            return 'rgba(86, 86, 86, 1)';
                        }
                    },
                    font: {
                        size: 16,
                        weight: 'bold'
                    },
                    formatter: (value, ctx) => {
                        return value != 0 ? value : '';
                    }
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
    <!-- Chart E -->


    <!-- Grid S -->
    // 조회 대상 컬럼 전체 등록
    var expectedResult = ["attchId", "attchMngId", "attchSt", "crId", "attchSize", "originalFileName"];

    // Grid 하단 페이저 숫자
    const pageSize = 10;
    let currentPageGroup = 1;

    // 기본 Items 개수
    var rowNumsVal = 10;

    var inChargeList = new Array();
    <c:forEach items="${inChargeList}" var="item">
        inChargeList.push("'${item.userId}'")
    </c:forEach>

    var inChargeId = "${inChargeId}";

    // JQGRID INIT
    $(document).ready(function () {
        var grid = $("#alertGrid").jqGrid({
            url: '${contextPath}/tracking/selectHealthAlert',
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
            pager: "#alertGridPager",
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
                createCustomPager('alertGrid');
                console.log(data);
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createCustomPager('alertGrid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            }
        });
    });
    <!-- Grid E -->

    function fnSearch(){
        $('#alertGrid').jqGrid('setGridParam', {
            url: '${contextPath}/tracking/selectHealthAlert',
            datatype: 'json',
            postData : setSearchParam()
        });
        $('#alertGrid').trigger('reloadGrid', [{page:1, current:true}]);
    }

    function setSearchParam() {
        return {
            searchBgnDe : today,
            inChargeId : inChargeId != null && inChargeId != '' ? inChargeId : null,
            inChargeIds : inChargeList.length > 0 ? '('+inChargeList.join()+')' : null,
            altTp : $('.alertBtns.active').data('filter') != 'all' ? $('.alertBtns.active')
                .map(function() {
                    return "\"" + $(this).data('filter') + "\"";
                })
                .get()
                .join(',') : "'A','F','H','SL','B','T','ST'"
        };
    }

    <!-- Grid Filter Toggle -->
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

        fnSearch();
    })

    $('.dropdown-content a').click(function(){
        let cnt = $(this).data('cnt');

        rowNumsVal = cnt;
        $('#gridDropdownBtn').text($(this).text());
        $("#alertGrid").setGridParam({ rowNum: cnt });
        fnSearch();
    })

    //logout 임다.
    <%--$(document).on('click','.logout_icon30', function(){--%>
    <%--    window.location.href='<c:url value="/login/logout"/>';--%>
    <%--})--%>

</script>