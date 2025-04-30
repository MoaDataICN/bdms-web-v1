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
    <button type="button" class="second-tap-btn" data-tab="checkup-results"><spring:message code='common.tapMenu.checkupResults'/></button>
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
                                <button class="data-select-btn" data-period="today">Today</button>
                                <button class="data-select-btn active" data-period="7-day">7day</button>
                                <button class="data-select-btn" data-period="30-day">30day</button>
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

<script type="text/javascript">


    let healthAlertsChart = null;

    function drawHealthAlertsChart(period) {
        let healthAlertsCtx = document.getElementById('healthAlerts_myChart');
        if (!healthAlertsCtx) {
            console.warn("Canvas with id 'healthAlerts_myChart' not found.");
            return;
        }

        // 기존 차트가 있다면 파괴
        if (healthAlertsChart) {
            healthAlertsChart.destroy();
        }

        let healthAlertsChartUrl = period === 'all'
            ? '/user/healthAlertsCnt/all'
            : '/user/healthAlertsCnt/last24h';

        $.ajax({
            url: healthAlertsChartUrl,
            method: 'POST',
            data: { userId: userDtlGeneral.userId },
            success: function (response) {
                let healthAlertsCntMap = response.healthAlertsCntMap;

                console.log("✅ healthAlertsCntMap");
                console.log(healthAlertsCntMap);

                $("#healthAlerts_cntTotal").text((healthAlertsCntMap['A'] || 0) + (healthAlertsCntMap['F'] || 0) +
                                                (healthAlertsCntMap['H'] || 0) + (healthAlertsCntMap['SL'] || 0) +
                                                (healthAlertsCntMap['B'] || 0) + (healthAlertsCntMap['T'] || 0) +
                                                (healthAlertsCntMap['ST'] || 0));
                $("#healthAlerts_cntAF").text((healthAlertsCntMap['A'] || 0) + (healthAlertsCntMap['F'] || 0));
                $("#healthAlerts_cntH").text(healthAlertsCntMap['H'] || 0);
                $("#healthAlerts_cntSL").text(healthAlertsCntMap['SL'] || 0);
                $("#healthAlerts_cntB").text(healthAlertsCntMap['B'] || 0);
                $("#healthAlerts_cntT").text(healthAlertsCntMap['T'] || 0);
                $("#healthAlerts_cntST").text(healthAlertsCntMap['ST'] || 0);

                healthAlertsChart = new Chart(healthAlertsCtx, {
                    type: 'doughnut',
                    data: {
                        labels: Object.keys(healthAlertsCntMap),
                        datasets: [
                            {
                                label: '',
                                data: Object.values(healthAlertsCntMap),
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
            },
            error: function (error) {
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
            }
        });
    }

    // initHealthAlertsGrid S
    function initHealthAlertsGrid() {
        $('#healthAlertsBgnDe').val(moment().subtract(7,'days').format('YYYY-MM-DD'))
        $('#healthAlertsEndDe').val(moment().format('YYYY-MM-DD'))

        let healthAlerts_grid = $("#healthAlerts_grid").jqGrid({
            url: '/user/selectUserDtlHealthAlerts',
            datatype: 'json',
            jsonReader: {repeatitems: false},
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
                { label: 'Alert Reason', name: 'altRmrk', width:130, sortable : false},
                { label: 'Group', name: 'grpNm', width:130, sortable : true},
                { label: 'In Charge', name: 'inChargeNm', width:130, sortable : false},
                {
                    label: 'Check',
                    name: 'altStt',
                    width: 100,
                    sortable: false,
                    formatter: function(cellValue, options, rowObject) {
                        if (cellValue === 0 || cellValue === '0') {
                            return `
                                <button type="button" class="detail-btn alt-check-btn" data-tid="` + rowObject.trkId + `" data-stt="0">
                                    <span>unconfirmed</span>
                                </button>
                            `;
                        } else if (cellValue === 1 || cellValue === '1') {
                            return `
                                <button type="button" class="detail-btn alt-check-btn active" data-tid="` + rowObject.trkId + `" data-stt="1">
                                    <span>confirmed</span>
                                </button>
                            `;
                        } else {
                            return `<button type="button" class="detail-btn"><span>-</span></button>`;
                        }
                    }
                },
            ],
            page: 1,
            autowidth : true,
            height: 'auto',
            rowNum: gridPagingState.healthAlerts_grid.rowNumsVal,
            rowList: [10, 50, 100],
            sortable : true,
            sortname : 'dctDt',
            sortorder : 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            pager: "#healthAlerts_pager",
            postData: healthAlerts_setSearchParam(),
            viewrecords: true,
            loadComplete: function(data) {
                $('#healthAlertsTotalResultsCnt').text(data.records);
                $('#healthAlertsCurrentRowsCnt').text(data.rows.length);
                createUserDtlCustomPager('healthAlerts_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createUserDtlCustomPager('healthAlerts_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            onSortCol: function (index, columnIndex, sortOrder) {
                //alert(index);
                $("#healthAlerts_sortColumn").val(index);
                $("#healthAlerts_sord").val(sortOrder);
            }
        });
    };
    // initHealthAlertsGrid E

    function healthAlerts_fnSearch(){
        $('#healthAlerts_grid').jqGrid('setGridParam', {
            url: '/user/selectUserDtlHealthAlerts',
            datatype: 'json',
            postData: healthAlerts_setSearchParam()
        });
        $('#healthAlerts_grid').trigger('reloadGrid', [{page:1, current:true}]);
    }

    function healthAlerts_setSearchParam() {
        let healthAlerts_startDate = $('#healthAlertsBgnDe').val();
        let healthAlerts_endDate = $('#healthAlertsEndDe').val();

        //("healthAlerts_startDate : " + healthAlerts_startDate);
        //console.log("healthAlerts_endDate : " + healthAlerts_endDate);

        let altTp = $('#healthAlerts_altTp .data-select-btn.active').map(function () {
                return '"' + $(this).data('filter') + '"';
            }).get().join(',');

            // alertTpAll이면 전체 알림으로 처리
            if (altTp.includes('"alertTpAll"')) {
                altTp = '"A","F","H","SL","B","T","ST"';
            } else if (altTp.includes('"AF"')) {
                altTp = '"A","F"';
            }

        return {
            userId: userDtlGeneral.userId,
            searchBgnDe: $('#healthAlertsBgnDe').val() + ' 00:00:00',
            searchEndDe: $('#healthAlertsEndDe').val() + ' 23:59:59',
            altTp: altTp
        };
    }

    function healthAlerts_fnClear() {
        $('#healthAlertsBgnDe').val('');
        $('#healthAlertsEndDe').val('');
        $('#healthAlerts_date .data-select-btn')[1].click();
        $('#healthAlerts_altTp .data-select-btn')[0].click();

        // 차트 리셋
        if (healthAlertsChart) {
            healthAlertsChart.destroy();
            healthAlertsChart = null;
        }

        // 차트와 그리드 새로 불러오기
        drawHealthAlertsChart('all');
        healthAlerts_fnSearch();
    }

    $(document).on('click', '#healthAlerts_date .data-select-btn', function () {
        //console.log('✅ healthAlerts data-select-btn clicked!');
        $('#healthAlerts_date .data-select-btn').removeClass('active');
        $(this).addClass('active');

        let period = $(this).data('period');

        if (period === 'today') {
            $('#healthAlertsBgnDe').val(moment().format('YYYY-MM-DD'));
            $('#healthAlertsEndDe').val(moment().format('YYYY-MM-DD'));
        } else {
            let pDay = parseInt(period.replace('-day', ''), 10);

            $('#healthAlertsEndDe').val(moment().format('YYYY-MM-DD'));

            let calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
            $('#healthAlertsBgnDe').val(calcDt);
        }
    });

    // healthAlerts_altTp : 다중 선택
    $(document).on("click", "#healthAlerts_altTp .data-select-btn", function() {
        if($("#healthAlerts_altTp .data-select-btn.active").length === 1 && $("#healthAlerts_altTp .data-select-btn.active")[0] == this) {
            return;
        }

        if(this.dataset['filter'] === 'alertTpAll') {
            $('#healthAlerts_altTp .data-select-btn').removeClass("active");

            $(this).addClass("active");
        } else {
            $('[data-filter="alertTpAll"]').removeClass("active");
            $(this).toggleClass("active");
        }

        healthAlerts_fnSearch();
    });

    $(document).on('click', '#healthAlertsChartAllBtn', function () {
        console.log("✅ healthAlertsChartAllBtn");

        if ($(this).hasClass('active')) return;

        $(this).addClass('active');
        $('#healthAlertsChartLast24Btn').removeClass('active');

        drawHealthAlertsChart('all');
    });

    $(document).on('click', '#healthAlertsChartLast24Btn', function () {
        console.log("✅ healthAlertsChartLast24Btn");

        if ($(this).hasClass('active')) return;

        $(this).addClass('active');
        $('#healthAlertsChartAllBtn').removeClass('active');

        drawHealthAlertsChart('last24h');
    });


    $('.table-wrap #healthAlerts_viewCntDropdown a').click(function(){
        let cnt = $(this).data('cnt');

        gridPagingState['healthAlerts_grid'].rowNumsVal = cnt;
        $('#healthAlerts_gridDropdownBtn').text($(this).text());
        $("#healthAlerts_grid").setGridParam({ rowNum: cnt });
        healthAlerts_fnSearch();
    })

    $(document).on("click", ".detail-btn.alt-check-btn", function () {
        let $btn = $(this);
        let trkId = $btn.attr("data-tid");
        let altStt = $btn.attr("data-stt");
        let newAltStt = altStt === "0" ? "1" : "0";

        fetch("/user/updateAltStt", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ trkId, newAltStt })
        })
        .then(response => {
            if (!response.ok) throw new Error("❌ Error : /user/updateAltStt");
            return response.json();
        })
        .then(data => {
            if (data.success) {
                $btn.attr("data-stt", newAltStt);

                if (newAltStt === "1") {
                    $btn.addClass("active");
                    $btn.html('<span>confirmed</span>');
                } else {
                    $btn.removeClass("active");
                    $btn.html('<span>unconfirmed</span>');
                }
            } else {
                $.confirm({
                    title: 'Error',
                    content: 'Failed to update alert status',
                    type: 'red',
                    typeAnimated: true,
                    buttons: {
                        OK: {
                            btnClass: 'btn-red',
                            action: function(){ console.error(data.message); }
                        }
                    }
                });
            }
        })
        .catch(error => {
            $.confirm({
                title: 'Error',
                content: error.message || 'A network error has occurred.',
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

/* 바로 검색
    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            healthAlerts_fnSearch();
        }
    });
*/
</script>