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

<script type="text/javascript">
    let serviceRequestsChart = null;

    function drawServiceRequestsChart(period) {
        let serviceRequestsCtx = document.getElementById('serviceRequests_myChart');
        if (!serviceRequestsCtx) {
            console.warn("Canvas with id 'serviceChart' not found.");
            return;
        }

        // 기존 차트가 있다면 파괴
        if (serviceRequestsChart) {
            serviceRequestsChart.destroy();
        }

        let serviceRequestsChartUrl = period === 'all'
            ? '/user/serviceRequestsCnt/all'
            : '/user/serviceRequestsCnt/last24h';

        $.ajax({
            url: serviceRequestsChartUrl,
            method: 'POST',
            data: { userId: userDtlGeneral.userId },
            success: function (response) {
                let serviceRequestsCntMap = response.serviceRequestsCntMap;

                console.log("✅ serviceRequestsCntMap");
                console.log(serviceRequestsCntMap);

                $("#serviceRequests_cntTotal").text((serviceRequestsCntMap['N'] || 0) +
                                                    (serviceRequestsCntMap['A'] || 0) +
                                                    (serviceRequestsCntMap['T'] || 0));
                $("#serviceRequests_cntN").text(serviceRequestsCntMap['N'] || 0);
                $("#serviceRequests_cntA").text(serviceRequestsCntMap['A'] || 0);
                $("#serviceRequests_cntT").text(serviceRequestsCntMap['T'] || 0);

                serviceRequestsChart = new Chart(serviceRequestsCtx, {
                    type: 'doughnut',
                    data: {
                        labels: Object.keys(serviceRequestsCntMap),
                        datasets: [
                            {
                                label: '',
                                data: Object.values(serviceRequestsCntMap),
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

    // initServiceRequestsGrid S
    function initServiceRequestsGrid() {
        $('#serviceRequestsBgnDe').val(moment().subtract(7,'days').format('YYYY-MM-DD'))
        $('#serviceRequestsEndDe').val(moment().format('YYYY-MM-DD'))

        let serviceRequests_grid = $("#serviceRequests_grid").jqGrid({
            url: '/user/selectUserDtlServiceRequests',
            datatype: 'json',
            jsonReader: {repeatitems: false},
            mtype: 'POST',
            colModel : [
                { label: 'Requested Time', name: 'reqDt', width:240, sortable : true},
                { label: 'Service Type', name: 'reqTp', width:130, sortable : true, formatter: function(cellValue, options, rowObject) {
                    switch(cellValue) {
                        case 'N' :
                            return 'Nursing';
                            break;
                        case 'A' :
                            return 'Ambulance';
                            break;
                        case 'T' :
                            return 'TeleHealth';
                            break;
                        default :
                            return cellValue;
                            break;
                    }
                }},
                { label: 'Group', name: 'grpNm', width:130, sortable : true},
                { label: 'In Charge', name: 'inChargeNm', width:130, sortable : false},
                {
                    label: 'Check',
                    name: 'reqStt',
                    width: 100,
                    sortable: false,
                    formatter: function(cellValue, options, rowObject) {
                        if (cellValue === 0 || cellValue === '0') {
                             return `
                                <button type="button" class="detail-btn req-check-btn" data-rid="` + rowObject.reqId + `" data-stt="0">
                                    <span>unconfirmed</span>
                                </button>
                            `;
                        } else if (cellValue === 1 || cellValue === '1') {
                            return `
                                <button type="button" class="detail-btn req-check-btn active" data-rid="` + rowObject.reqId + `" data-stt="1">
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
            rowNum: gridPagingState.serviceRequests_grid.rowNumsVal,
            rowList: [10, 50, 100],
            sortable : true,
            sortname : 'reqDt',
            sortorder : 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            pager: "#serviceRequests_pager",
            postData: serviceRequests_setSearchParam(),
            viewrecords: true,
            loadComplete: function(data) {
                $('#serviceRequestsTotalResultsCnt').text(data.records);
                $('#serviceRequestsCurrentRowsCnt').text(data.rows.length);
                createUserDtlCustomPager('serviceRequests_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createUserDtlCustomPager('serviceRequests_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            onSortCol: function (index, columnIndex, sortOrder) {
                //alert(index);
                $("#serviceRequests_sortColumn").val(index);
                $("#serviceRequests_sord").val(sortOrder);
            }
        });
    };
    // initServiceRequestsGrid E

    function serviceRequests_fnSearch(){
        $('#serviceRequests_grid').jqGrid('setGridParam', {
            url: '/user/selectUserDtlServiceRequests',
            datatype: 'json',
            postData: serviceRequests_setSearchParam()
        });
        $('#serviceRequests_grid').trigger('reloadGrid', [{page:1, current:true}]);
    }

    function serviceRequests_setSearchParam() {
        let serviceRequests_startDate = $('#serviceRequestsBgnDe').val();
        let serviceRequests_endDate = $('#serviceRequestsEndDe').val();

        //console.log("serviceRequests_startDate : " + serviceRequests_startDate);
        //console.log("serviceRequests_endDate : " + serviceRequests_endDate);

        let reqTp = $('#serviceRequests_reqTp .data-select-btn.active').map(function () {
                return '"' + $(this).data('filter') + '"';
            }).get().join(',');

            // reqTpAll이면 전체 알림으로 처리
            if (reqTp.includes('"reqTpAll"')) {
                reqTp = '"N","A","T"';
            }

        return {
            userId: userDtlGeneral.userId,
            searchBgnDe: $('#serviceRequestsBgnDe').val() + ' 00:00:00',
            searchEndDe: $('#serviceRequestsEndDe').val() + ' 23:59:59',
            reqTp: reqTp
        };
    }

    function serviceRequests_fnClear() {
        $('#serviceRequestsBgnDe').val('');
        $('#serviceRequestsEndDe').val('');
        $('#serviceRequests_date .data-select-btn')[1].click();
        $('#serviceRequests_reqTp .data-select-btn')[0].click();

        // 차트 리셋
        if (serviceRequestsChart) {
            serviceRequestsChart.destroy();
            serviceRequestsChart = null;
        }

        // 차트와 그리드 새로 불러오기
        drawServiceRequestsChart('all');
        serviceRequests_fnSearch();
    }

    $(document).on('click', '#serviceRequests_date .data-select-btn', function () {
        //console.log('✅ serviceRequests data-select-btn clicked!');

        $('#serviceRequests_date .data-select-btn').removeClass('active');
        $(this).addClass('active');

        let period = $(this).data('period');

        if (period === 'today') {
            $('#serviceRequestsBgnDe').val(moment().format('YYYY-MM-DD'));
            $('#serviceRequestsEndDe').val(moment().format('YYYY-MM-DD'));
        } else {
            let pDay = parseInt(period.replace('-day', ''), 10);

            $('#serviceRequestsEndDe').val(moment().format('YYYY-MM-DD'));

            let calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
            $('#serviceRequestsBgnDe').val(calcDt);
        }
    });

    // serviceRequests_reqTp : 다중 선택
    $(document).on("click", "#serviceRequests_reqTp .data-select-btn", function() {
        if($("#serviceRequests_reqTp .data-select-btn.active").length === 1 && $("#serviceRequests_reqTp .data-select-btn.active")[0] == this) {
            return;
        }

        if(this.dataset['filter'] === 'reqTpAll') {
            $('#serviceRequests_reqTp .data-select-btn').removeClass("active");

            $(this).addClass("active");
        } else {
            $('[data-filter="reqTpAll"]').removeClass("active");
            $(this).toggleClass("active");
        }

        serviceRequests_fnSearch();
    });

    $(document).on('click', '#serviceRequestsChartAllBtn', function () {
        console.log("✅ serviceRequestsChartAllBtn");

        if ($(this).hasClass('active')) return;

        $(this).addClass('active');
        $('#serviceRequestsChartLast24Btn').removeClass('active');

        drawServiceRequestsChart('all');
    });

    $(document).on('click', '#serviceRequestsChartLast24Btn', function () {
        console.log("✅ serviceRequestsChartLast24Btn");

        if ($(this).hasClass('active')) return;

        $(this).addClass('active');
        $('#serviceRequestsChartAllBtn').removeClass('active');

        drawServiceRequestsChart('last24h');
    });

    $('.table-wrap #serviceRequests_viewCntDropdown a').click(function(){
        let cnt = $(this).data('cnt');

        gridPagingState['serviceRequests_grid'].rowNumsVal = cnt;
        $('#serviceRequests_gridDropdownBtn').text($(this).text());
        $("#serviceRequests_grid").setGridParam({ rowNum: cnt });
        serviceRequests_fnSearch();
    })

    $(document).on("click", ".detail-btn.req-check-btn", function () {
        let $btn = $(this);
        let reqId = $btn.attr("data-rid");
        let reqStt = $btn.attr("data-stt");
        let newReqStt = reqStt === "0" ? "1" : "0";

        fetch("/user/updateReqStt", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ reqId, newReqStt })
        })
        .then(response => {
            if (!response.ok) throw new Error("❌ Error : /user/updateReqStt");
            return response.json();
        })
        .then(data => {
            if (data.success) {
                $btn.attr("data-stt", newReqStt);

                if (newReqStt === "1") {
                    $btn.addClass("active");
                    $btn.html('<span>confirmed</span>');
                } else {
                    $btn.removeClass("active");
                    $btn.html('<span>unconfirmed</span>');
                }
            } else {
                $.confirm({
                    title: 'Error',
                    content: 'Failed to update request status',
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
            serviceRequests_fnSearch();
        }
    });
*/
</script>
