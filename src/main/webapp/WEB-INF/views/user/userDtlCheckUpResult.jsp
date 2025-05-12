<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #checkUpResult_pager {
        display:none;
    }
</style>

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
    <button type="button" class="second-tap-btn active" data-tab="checkup-result"><spring:message code='common.tapMenu.checkupResult'/></button>
</div>

<div class="alerts-wrap mt-30px">
    <!-- Mini userDtlGeneral -->
    <div class="mt-16px table-data-wrap">
        <p class="second-title-status">(${userDtlGeneral.userId}) ${userDtlGeneral.userNm}ㅣ${userDtlGeneral.brthDt}ㅣ${userDtlGeneral.sx}ㅣ${userDtlGeneral.mobile}ㅣ${userDtlGeneral.addr}</p>
    </div>

    <!-- 검색 영역 -->
    <div class="second-container mt-18px">
        <div class="content-row">
            <!-- 좌측 입력폼 그룹 -->
            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        Checkup Date
                    </div>
                    <div class="row-input">
                        <div class="p-r">
                            <input type="text" class="date-input input-txt02" id="checkUpResultBgnDe" placeholder="ALL" readonly="">
                            <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('checkUpResult_datePicker1')" alt="달력 아이콘">
                            <input type="date" id="checkUpResult_datePicker1" class="hidden-date" onchange="updateDate('checkUpResult_datePicker1', 'checkUpResultBgnDe')">
                        </div>
                        <img src="/resources/images/minus-icon.svg" class="icon14 img-none">
                        <div class="p-r">
                            <input type="text" class="date-input input-txt02" id="checkUpResultEndDe" placeholder="ALL" readonly="">
                            <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('checkUpResult_datePicker2')" alt="달력 아이콘">
                            <input type="date" id="checkUpResult_datePicker2" class="hidden-date" onchange="updateDate('checkUpResult_datePicker2', 'checkUpResultEndDe')">
                        </div>
                        <div class="day-button-wrap" id="checkUpResult_date">
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
                        Checkup Type
                    </div>
                    <div class="row-input">
                        <div class="day-button-wrap02" id="checkUpResult_reqTp">
                            <button class="data-select-btn active" data-filter="A">All</button>
                            <button class="data-select-btn" data-filter="PU">Public</button>
                            <button class="data-select-btn" data-filter="PE">Personal</button>
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
            <button type="button" class="gray-submit-btn" onclick="checkUpResult_fnClear()">
                <img src="/resources/images/reset-icon.svg" class="icon22">
                <span>Reset</span>
            </button>

            <button type="button" class="point-submit-btn" onclick="checkUpResult_fnSearch()">
                <img src="/resources/images/search-icon.svg" class="icon22">
                <span>Search</span>
            </button>
        </div>
    </div>

    <div class="table-wrap mt-36px">
        <div class="mt-16px table-data-wrap">
            <p class="second-title-status">
                <span class="bold-t-01" id="checkUpResultCurrentRowsCnt">0</span>
                <spring:message code="common.outOf"/>
                <span class="bold-t-01" id="checkUpResultTotalResultsCnt">0</span>
                <spring:message code="common.results"/>
            </p>
            <div class="table-option-wrap">
                <div class="dropdown02">
                    <button class="dropdown-search input-line-b" id="checkUpResult_gridDropdownBtn"><spring:message code="common.viewResults" arguments="10" /> <span><img class="icon20"
                                                                                                                                                                             alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                    <div class="dropdown-content" id="checkUpResult_viewCntDropdown">
                        <a data-cnt="100"><spring:message code="common.viewResults" arguments="100" /></a>
                        <a data-cnt="50"><spring:message code="common.viewResults" arguments="50" /></a>
                        <a data-cnt="10"><spring:message code="common.viewResults" arguments="10" /></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- userDtlcheckUpResult Grid -->
        <div class="table-wrap mt-14px" style="width:100%;">
            <div class="w-line01 mt-8px"></div>
            <div class="main-table">
                <div class="tableWrapper">
                    <table id="checkUpResult_grid" style="width:100%;"></table>
                    <div id="checkUpResult_pager"></div>
                    <div id="userDtlCustomPager" class="page-group mb-22px mt-10px"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="space-30"></div>
</div>

<script type="text/javascript">

    // initcheckUpResultGrid S
    function initcheckUpResultGrid() {
        $('#checkUpResultBgnDe').val(moment().subtract(7,'days').format('YYYY-MM-DD'))
        $('#checkUpResultEndDe').val(moment().format('YYYY-MM-DD'))

        let checkUpResult_grid = $("#checkUpResult_grid").jqGrid({
            url: '/user/selectCheckUpResult',
            datatype: 'json',
            jsonReader: {repeatitems: false},
            mtype: 'POST',
            colModel : [
                { label: 'Checkup Date', name: 'chckDate', width:200, sortable : true},
                { label: 'Checkup Type', name: 'chckKind', width:170, sortable : true},
                { label: 'Result', name: 'chckJudge', width:170, sortable : true},
                { label: 'Checkup Center', name: 'chckHspt', width:170, sortable : true},
                { label: 'Doctor', name: 'chckDoctor', width:170, sortable : true},
                { label: 'Biological Age', name: 'badVal', width:150, sortable : true}
            ],
            page: 1,
            autowidth : true,
            height: 'auto',
            rowNum: gridPagingState.checkUpResult_grid.rowNumsVal,
            rowList: [10, 50, 100],
            sortable : true,
            sortname : 'chckDate',
            sortorder : 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            pager: "#checkUpResult_pager",
            postData: checkUpResult_setSearchParam(),
            viewrecords: true,
            loadComplete: function(data) {
                $('#checkUpResultTotalResultsCnt').text(data.records);
                $('#checkUpResultCurrentRowsCnt').text(data.rows.length);
                createUserDtlCustomPager('checkUpResult_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createUserDtlCustomPager('checkUpResult_grid');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            onSortCol: function (index, columnIndex, sortOrder) {
                //alert(index);
                $("#checkUpResult_sortColumn").val(index);
                $("#checkUpResult_sord").val(sortOrder);
            }
        });
    };
    // initcheckUpResultGrid E

    function checkUpResult_fnSearch(){
        $('#checkUpResult_grid').jqGrid('setGridParam', {
            url: '/user/selectCheckUpResult',
            datatype: 'json',
            postData: checkUpResult_setSearchParam()
        });
        $('#checkUpResult_grid').trigger('reloadGrid', [{page:1, current:true}]);
    }

    function checkUpResult_setSearchParam() {
        let checkUpResult_startDate = $('#checkUpResultBgnDe').val();
        let checkUpResult_endDate = $('#checkUpResultEndDe').val();

        let reqTp = $('#checkUpResult_reqTp .data-select-btn.active').map(function () {
            return '"' + $(this).data('filter') + '"';
        }).get().join(',');

        // A이면 전체 알림으로 처리
        if (reqTp.includes('"A"')) {
            //reqTp = '"PU","PE"';
            reqTp = '';
        }

        return {
            userId: userDtlGeneral.userId,
            //searchBgnDe: $('#checkUpResultBgnDe').val() + ' 00:00:00',
            //searchEndDe: $('#checkUpResultEndDe').val() + ' 23:59:59',
            searchBgnDe: $('#checkUpResultBgnDe').val(),
            searchEndDe: $('#checkUpResultEndDe').val(),
            chckKind: reqTp
        };
    }

    function checkUpResult_fnClear() {
        $('#checkUpResultBgnDe').val('');
        $('#checkUpResultEndDe').val('');
        $('#checkUpResult_date .data-select-btn')[1].click();
        $('#checkUpResult_reqTp .data-select-btn')[0].click();

        checkUpResult_fnSearch();
    }

    $(document).on('click', '#checkUpResult_date .data-select-btn', function () {
        //console.log('✅ checkUpResult data-select-btn clicked!');

        $('#checkUpResult_date .data-select-btn').removeClass('active');
        $(this).addClass('active');

        let period = $(this).data('period');

        if (period === 'today') {
            $('#checkUpResultBgnDe').val(moment().format('YYYY-MM-DD'));
            $('#checkUpResultEndDe').val(moment().format('YYYY-MM-DD'));
        } else {
            let pDay = parseInt(period.replace('-day', ''), 10);

            $('#checkUpResultEndDe').val(moment().format('YYYY-MM-DD'));

            let calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
            $('#checkUpResultBgnDe').val(calcDt);
        }
    });

    // checkUpResult_reqTp : 다중 선택
    $(document).on("click", "#checkUpResult_reqTp .data-select-btn", function() {
        if($("#checkUpResult_reqTp .data-select-btn.active").length === 1 && $("#checkUpResult_reqTp .data-select-btn.active")[0] == this) {
            return;
        }

        if(this.dataset['filter'] === 'A') {
            $('#checkUpResult_reqTp .data-select-btn').removeClass("active");
            $(this).addClass("active");
        } else {
            $('[data-filter="A"]').removeClass("active");
            $(this).toggleClass("active");
        }

        checkUpResult_fnSearch();
    });

    $('.table-wrap #checkUpResult_viewCntDropdown a').click(function(){
        let cnt = $(this).data('cnt');

        gridPagingState['checkUpResult_grid'].rowNumsVal = cnt;
        $('#checkUpResult_gridDropdownBtn').text($(this).text());
        $("#checkUpResult_grid").setGridParam({ rowNum: cnt });
        checkUpResult_fnSearch();
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
</script>