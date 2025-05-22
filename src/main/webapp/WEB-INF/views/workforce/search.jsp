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
    #workforcePager {
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
        <spring:message code="common.menu.wf_srch"/>
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
                        <input type="text" class="input-txt02" id="wrkfrcNm" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.wrkfrcNb"/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02" id="wrkfrcNmbr" placeholder="Please enter"
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
                        <input type="text" class="input-txt02" id="wrkfrcMobile" placeholder="Please enter(ex.012-3456-7890)"
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
                        <spring:message code="common.sex"/>
                    </div>
                    <div class="dropdown">
                        <button class="dropdown-search" id="wrkfrcSx"><spring:message code="common.all"/><span><img class="icon20" alt=""
                                                                      src="/resources/images/arrow-gray-bottom.svg"></span></button>
                        <div class="dropdown-content">
                            <a onclick="$('#wrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.all"/></a>
                            <a onclick="$('#wrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.sex.f"/></a>
                            <a onclick="$('#wrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.sex.m"/></a>
                        </div>
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.birthDt"/>
                    </div>
                    <div class="row-input">
                        <div class="p-r">
                            <input type="text" class="date-input input-txt02" id="dateDisplay1"
                                   placeholder="ALL" readonly>
                            <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
                                 onclick="openCalendar('wrkfrcBrthDt')" alt="달력 아이콘">
                            <input type="date" id="wrkfrcBrthDt" class="hidden-date"
                                   onchange="updateDate('wrkfrcBrthDt', 'dateDisplay1')">
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.serviceTp"/>
                    </div>
                    <div class="row-input">
                        <div class="day-button-wrap02">
                            <button class="data-select-btn svcBtns active" data-filter="all"><spring:message code="common.all"/></button>
                            <button class="data-select-btn svcBtns" data-filter="N"><spring:message code="common.serviceTp.N"/></button>
                            <button class="data-select-btn svcBtns" data-filter="A"><spring:message code="common.serviceTp.A"/></button>
                            <button class="data-select-btn svcBtns" data-filter="T"><spring:message code="common.serviceTp.T"/></button>
                            <button class="data-select-btn svcBtns" data-filter="H"><spring:message code="common.serviceTp.H"/></button>
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
                <table id="workforceList"></table>
                <div id="workforcePager"></div>
                <div id="customPager" class="page-group mb-22px mt-10px"></div>
            </div>
        </div>
    </div>

    <form name="excelForm" method="POST">
        <input type="hidden" id="sortColumn" name="sortColumn" value="dctDt"/>
        <input type="hidden" id="sord" name="sord" value="DESC"/>
    </form>

    <!-- 우측 슬라이드 팝업 -->
    <!-- 반투명 배경 -->
    <div class="slide-overlay" id="slide-overlay"></div>

    <!-- 우측에서 슬라이드되는 팝업 -->
    <div class="customer-popup" id="customerPopup">
        <div class="popup-header">
            <div class="second-title">
                Workforce Add
            </div>
            <button type="button" class="closePopup">
                <img src="/resources/images/close-icon.svg" class="icon24">
            </button>
        </div>

        <div class="slide-popup-container">
            <div class="second-container mt-18px">
                <div class="content-row">
                    <!-- 좌측 입력폼 그룹 -->
                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                User Name
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02" placeholder="Please enter" id="addWrkfrcNm"
                                       oninput="limitLength(this, 30);">
                            </div>
                        </div>
                        <div class="row-wrap">
                            <div class="input-label01">
                                Workforce Number
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02" placeholder="Please enter" id="addWrkfrcNmbr"
                                       oninput="limitLength(this, 30);">
                            </div>
                        </div>
                    </div>

                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                Phone
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02" placeholder="Please enter(ex.012-3456-7890)" id="addWrkfrcMobile"
                                       oninput="limitLength(this, 30);">
                            </div>
                        </div>
                        <div class="row-wrap">
                            <div class="input-label01">
                                Group
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02" placeholder="Please enter" id="addWrkfrcGrpId"
                                       oninput="limitLength(this, 30);">
                            </div>
                        </div>
                    </div>

                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                Sex
                            </div>
                            <div class="dropdown">
                                <button class="dropdown-search" id="addWrkfrcSx">
                                    Female
                                    <span>
                                        <img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg">
                                    </span>
                                </button>
                                <input type="hidden" id="addWrkfrcSxVal" value="F"/>
                                <div class="dropdown-content">
                                    <a data-sx="F" onclick="$('#addWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSxVal').val($(this).data('sx'))">Female</a>
                                    <a data-sx="M" onclick="$('#addWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSxVal').val($(this).data('sx'))">Man</a>
                                </div>
                            </div>
                        </div>
                        <div class="row-wrap">
                            <div class="input-label01">
                                Date of birth
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02 datePicker" placeholder="Please Select" id="addWrkfrcBrthDt"
                                       oninput="limitLength(this, 30);" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                Service Type
                            </div>
                            <div class="dropdown">
                                <button class="dropdown-search" id="addWrkfrcSvcTp">Nursing<span><img class="icon20" alt=""
                                                                                  src="/resources/images/arrow-gray-bottom.svg"></span></button>
                                <input type="hidden" id="addWrkfrcSvcTpVal" value="N"/>
                                <div class="dropdown-content">
                                    <a data-tp="N" onclick="$('#addWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSvcTpVal').val($(this).data('tp'))">Nursing</a>
                                    <a data-tp="A" onclick="$('#addWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSvcTpVal').val($(this).data('tp'))">Ambulance</a>
                                    <a data-tp="T" onclick="$('#addWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSvcTpVal').val($(this).data('tp'))">Consultation</a>
                                    <a data-tp="H" onclick="$('#addWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSvcTpVal').val($(this).data('tp'))">Health Manager</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-col-100 mb-16px">
                        <div class="input-label01 mb-4px">
                            Memo
                        </div>
                        <div class="wrap-form">
                                    <textarea class="input-area" id="addWrkfrcMemo"
                                              placeholder="Please enter a note."></textarea>
                        </div>
                    </div>

                </div>

            </div>
            <div class="content-submit-ui mt-22px">
                <div class="submit-ui-wrap">
                </div>
                <div class="submit-ui-wrap">
                    <button type="button" class="gray-submit-btn" id="addResetBtn" onclick="resetWorkforce()">
                        <img src="/resources/images/reset-icon.svg" class="icon22">
                        <span>Reset</span>
                    </button>

                    <button type="button" class="point-submit-btn" id="addConfirmBtn" onclick="saveWorkforce()">
                        <img src="/resources/images/save-icon.svg" class="icon22">
                        <span>Add</span>
                    </button>
                </div>
            </div>
            <!-- 스페이스 빈공간 -->
            <div class="space-20"></div>
        </div>
    </div>
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
            wrkfrcNm : $('#wrkfrcNm').val(),
            wrkfrcNmbr : $('#wrkfrcNmbr').val(),
            wrkfrcMobile : $('#wrkfrcMobile').val(),
            wrkfrcSx : $('#wrkfrcSx').text() != "All" ? $('#wrkfrcSx').text().slice(0,1) : "ALL",
            wrkfrcBrthDt : $('#wrkfrcBrthDt').val(),
            grpTp : $('#grpNm').text() != "All" ? $('#grpNm').text() : "",
            svcTp : $('.svcBtns.active').data('filter') != 'all' ? $('.svcBtns.active')
                .map(function() {
                    return "\"" + $(this).data('filter') + "\"";
                })
                .get()
                .join(',') : "'N','A','T','H'"
        };
    }

    function fnClear() {
        $('#wrkfrcNm').val('');
        $('#wrkfrcNmbr').val('');
        $('#wrkfrcMobile').val('');
        $('#wrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('All');
        $('#wrkfrcBrthDt').val('');
        $('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('All');
        $('.svcBtns.active').removeClass('active');
        $('.svcBtns')[0].classList.add('active');
    }

    function fnSearch(){
        $('#workforceList').jqGrid('setGridParam', {
            url: 'selectWorkforceList',
            datatype: 'json',
            postData : setSearchParam()
        });
        $('#workforceList').trigger('reloadGrid', [{page:1, current:true}]);
    }

    $(document).ready(function() {
        $('.datePicker').datepicker({
            dateFormat: 'yy-mm-dd',
            autoclose: true,
            todayHighlight:true
        });

        $('#workforceList').jqGrid({
            url : '${contextPath}/workforce/selectWorkforceList',
            mtype : "POST",
            datatype: "json",
            jsonReader : {repeatitems: false},
            postData: setSearchParam(),
            colModel : [
                { label: 'Workforce Number', name: 'wrkfrcNmbr', width:200, sortable : true},
                { label: 'Name', name: 'wrkfrcNm', width:130, sortable : false},
                { label: 'Phone', name: 'wrkfrcMobile', width:130, sortable : false, formatter: function(cellValue, options, rowObject) {
                        var cleaned = ('' + cellValue).replace(/\D/g, '');
                        var match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
                        if (match) {
                            return match[1] + '-' + match[2] + '-' + match[3];
                        }
                        return cellValue;
                    }},
                { label: 'Sex', name: 'wrkfrcSx', width:60, sortable : true, formatter: function(cellValue, options, rowObject) {
                        if(cellValue === 'M') {
                            return '<img src="/resources/images/man-icon.svg" class="icon24 img-c">'
                        } else {
                            return '<img src="/resources/images/girl-icon.svg" class="icon24 img-c">';
                        }
                    }},
                { label: 'Date Of Birth', name: 'wrkfrcBrthDt', width:130, sortable : false},
                { label: 'Group', name: 'grpTp', width:130, sortable : true},
                { label: 'Service Type', name: 'svcTp', width:130, sortable : true, formatter: function(cellValue, options, rowObject) {
                        switch(cellValue) {
                            case 'N' :
                                return 'Nursing';
                                break;
                            case 'A' :
                                return 'Ambulance';
                                break;
                            case 'T' :
                                return 'Consultation';
                                break;
                            case 'H' :
                                return 'Health Manager';
                                break;
                            default :
                                return cellValue;
                                break;
                        }
                    }},
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
            sortname : 'wrkfrcNmbr',
            sortorder : 'DESC',
            shrinkToFit: true,
            rownumbers: true,
            loadonce : false,
            pager : '#workforcePager',
            viewrecords: true,
            loadComplete: function(data) {
                console.log(data);
                $('#totalResultsCnt').text(data.records);
                $('#currentRowsCnt').text(data.rows.length);
                createCustomPager('workforceList');
                $(this).jqGrid('setLabel', 'rn', 'No.');
            },
            gridComplete: function() {
                createCustomPager('workforceList');
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
        jQuery("#workforceList").jqGrid('setGridWidth', $(".table-wrap").width());
    })

    $(document).on('click','.svcBtns', function(){
        if($('.svcBtns.active').length === 1 && $('.svcBtns.active')[0] == this){
            return;
        }
        $(this).toggleClass('active');
        if(this.dataset['filter'] === 'all') {
            $('.svcBtns').not('[data-filter="all"]').removeClass('active');
        } else {
            if($('.svcBtns.active').not('[data-filter="all"]').length == 4) {
                $('.svcBtns').removeClass('active');
                $('.svcBtns[data-filter="all"]').toggleClass('active');
            } else {
                $('[data-filter="all"]').removeClass('active');
            }
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
        $('#gridDropdownBtn').contents().filter(function() {
            return this.nodeType === 3;
        }).first().replaceWith($(this).text());
        $("#workforceList").setGridParam({ rowNum: cnt });
        fnSearch();
    })

    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            fnSearch();
        }
    });

    function showModal() {
        if($('#jstree').length != 0) {
            openLayer();
        } else {
            $.ajax({
                type: 'POST',
                url: '/group/popup/groupSelectPopup',
                contentType: 'application/json',
                dataType: 'html',
                data: JSON.stringify(groupData),
                success: function (data) {
                    $('.main').prepend(data);

                    openLayer();
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
                }
            });
        }
    }

    function closeModal() {
        closeLayer('layerPop1')
    }
</script>

<!-- 우측에서 나타나는 슬라이드 팝업 -->
<script>
    function openPopup() {
        document.getElementById('customerPopup').classList.add('active');
        document.getElementById('slide-overlay').classList.add('active');
        document.body.classList.add('no-scroll');  // ✅ 본문 스크롤 막기
    };

    function closePopup() {
        document.getElementById('customerPopup').classList.remove('active');
        document.getElementById('slide-overlay').classList.remove('active');
        document.body.classList.remove('no-scroll');  // ✅ 본문 스크롤 복구
    };
    document.getElementById('closePopup').addEventListener('click', closePopup);
    document.getElementById('slide-overlay').addEventListener('click', closePopup);
</script>

<script>
    /* Workforce Add Form */
    function valdation(param) {
        for (const key in param) {
            if (param.hasOwnProperty(key)) {
                const value = param[key];
                if (key !== 'memo' && (value === null || value.trim() === '')) {
                    return false;
                }
            }
        }

        const mobileRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!mobileRegex.test(param.wrkfrcMobile)) {
            return false;
        }

        const birthDateRegex = /^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/;
        if (!birthDateRegex.test(param.wrkfrcBrthDt)) {
            return false;
        }

        return true;
    }


    function saveWorkforce() {
        var param = {
            "userId" : "${sessionScope.user.userId}",
            "wrkfrcNm" : $('#addWrkfrcNm').val(),
            "wrkfrcNmbr" : $('#addWrkfrcNmbr').val(),
            "wrkfrcMobile" : $('#addWrkfrcMobile').val(),
            "grpId" : $('#addWrkfrcGrpId').val(),
            "wrkfrcSx" : $('#addWrkfrcSxVal').val(),
            "wrkfrcBrthDt" : $('#addWrkfrcBrthDt').val(),
            "svcTp" : $('#addWrkfrcSvcTpVal').val(),
            "memo" : $('#addWrkfrcMemo').val()
        };

        if(valdation(param)) {
            $.ajax({
                type: 'POST',
                url: '/workforce/save',
                data: param,
                datatype: 'json',
                success: function (data) {
                    console.log(data);
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
                }
            });

        } else {
            alert('validation Fail')
        }
    }

    function resetWorkforce() {
        $('#addWrkfrcNm').val('');
        $('#addWrkfrcNmbr').val('');
        $('#addWrkfrcMobile').val('');
        $('#addWrkfrcGrpId').val('');
        $('#addWrkfrcSxVal').val('F');
        $('#addWrkfrcSx').text('Female');
        $('#addWrkfrcBrthDt').val('');
        $('#addWrkfrcSvcTpVal').val('N');
        $('#addWrkfrcSvcTp').text('Nursing');
        $('#addWrkfrcMemo').val('');
    }

    $(document).on('click', '#groupSelectBtn', function(){
        $('#addWrkfrcGrpId').val($('#selectedNodeIdVal').val());
        closeModal();
    })
    $('#addWrkfrcGrpId').on('focus', function(){
        showModal();
    })
</script>