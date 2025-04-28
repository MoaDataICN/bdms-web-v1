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
    table {
        width: 100%; !important;
    }

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
    <div class="second-title f-x">
        Workforce editing
        <c:if test="${sessionScope.user.grpLv eq '1'}">
            <button class="add-btn ml-10px" id="addBtn" onclick="openPopup('workforceAddPopup')">Workfoce Add
                <img src="/resources/images/plus-icon.svg" class="icon20">
            </button>
        </c:if>
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
                        <input type="text" class="input-txt02 hold" id="wrkfrcNm" placeholder="Please enter"
                               oninput="limitLength(this, 30);">
                    </div>
                </div>
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.wrkfrcNb"/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 hold" id="wrkfrcNmbr" placeholder="Please enter"
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
                                <a data-grptp="All" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text());"><spring:message code="common.all"/></a>
                                <a data-grptp="Group A" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text());">Group A</a>
                                <a data-grptp="Group B" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text());">Group B</a>
                                <a data-grptp="Group C" onclick="$('#grpNm').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text());">Group C</a>
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
    <div class="customer-popup" id="workforceAddPopup">
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
                            <div class="dropdown">
                                <input type="hidden" id="addWrkfrcGrpId" value="Group A">
                                <button class="dropdown-search" id="addWrkfrcGrpIdBtn">
                                    Group A
                                    <span>
                                        <img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg">
                                    </span>
                                </button>
                                <div class="dropdown-content">
                                    <a data-grptp="Group A" onclick="$('#addWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcGrpId').val($(this).data('grptp'))">Group A</a>
                                    <a data-grptp="Group B" onclick="$('#addWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcGrpId').val($(this).data('grptp'))">Group B</a>
                                    <a data-grptp="Group C" onclick="$('#addWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcGrpId').val($(this).data('grptp'))">Group C</a>
                                </div>
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
                                <div class="p-r">
                                    <input type="text" class="date-input input-txt02" id="dateDisplay2" placeholder="YYYY-MM-DD" readonly="">
                                    <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('addWrkfrcBrthDt')" alt="달력 아이콘">
                                    <input type="date" id="addWrkfrcBrthDt" class="hidden-date" onchange="updateDate('addWrkfrcBrthDt', 'dateDisplay2')">
                                </div>
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
                                    <a data-tp="T" onclick="$('#addWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#addWrkfrcSvcTpVal').val($(this).data('tp'))">Telehealth</a>
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
                        <span><spring:message code="common.btn.reset"/></span>
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

    <div class="customer-popup" id="workforceEditPopup">
        <div class="popup-header">
            <div class="second-title">
                Workforce Editing
            </div>
            <button type="button" id="closeEditPopup" class="closePopup">
                <img src="/resources/images/close-icon.svg" class="icon24">
            </button>
        </div>

        <div class="slide-popup-container">
            <div class="second-container mt-18px">
                <div class="content-row">
                    <input type="hidden" id="editWrkfrcId">
                    <!-- 좌측 입력폼 그룹 -->
                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                User Name
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02" placeholder="Please enter" id="editWrkfrcNm"
                                       oninput="limitLength(this, 30);">
                            </div>
                        </div>
                        <div class="row-wrap">
                            <div class="input-label01">
                                Workforce Number
                            </div>
                            <div class="row-input">
                                <input type="text" class="input-txt02" placeholder="Please enter" id="editWrkfrcNmbr"
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
                                <input type="text" class="input-txt02" placeholder="Please enter(ex.012-3456-7890)" id="editWrkfrcMobile"
                                       oninput="limitLength(this, 30);">
                            </div>
                        </div>
                        <div class="row-wrap">
                            <div class="input-label01">
                                Group
                            </div>
                            <div class="dropdown">
                                <input type="hidden" id="editWrkfrcGrpId" value="Group A">
                                <button class="dropdown-search" id="editWrkfrcGrpIdBtn">
                                    Group A
                                    <span>
                                        <img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg">
                                    </span>
                                </button>
                                <div class="dropdown-content">
                                    <a data-grptp="Group A" onclick="$('#editWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcGrpId').val($(this).data('grptp'))">Group A</a>
                                    <a data-grptp="Group B" onclick="$('#editWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcGrpId').val($(this).data('grptp'))">Group B</a>
                                    <a data-grptp="Group C" onclick="$('#editWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcGrpId').val($(this).data('grptp'))">Group C</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                Sex
                            </div>
                            <div class="dropdown">
                                <button class="dropdown-search" id="editWrkfrcSx">
                                    Female
                                    <span>
                                        <img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg">
                                    </span>
                                </button>
                                <input type="hidden" id="editWrkfrcSxVal" value="F"/>
                                <div class="dropdown-content">
                                    <a data-sx="F" onclick="$('#editWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcSxVal').val($(this).data('sx'))">Female</a>
                                    <a data-sx="M" onclick="$('#editWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcSxVal').val($(this).data('sx'))">Man</a>
                                </div>
                            </div>
                        </div>
                        <div class="row-wrap">
                            <div class="input-label01">
                                Date of birth
                            </div>

                            <div class="row-input">
                                <div class="p-r">
                                    <input type="text" class="date-input input-txt02" id="dateDisplay3" placeholder="YYYY-MM-DD" readonly="">
                                    <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('editWrkfrcBrthDt')" alt="달력 아이콘">
                                    <input type="date" id="editWrkfrcBrthDt" class="hidden-date" onchange="updateDate('editWrkfrcBrthDt', 'dateDisplay3')">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-md-100">
                        <div class="row-wrap">
                            <div class="input-label01">
                                Service Type
                            </div>
                            <div class="dropdown">
                                <button class="dropdown-search" id="editWrkfrcSvcTp">Nursing<span><img class="icon20" alt=""
                                                                                                       src="/resources/images/arrow-gray-bottom.svg"></span></button>
                                <input type="hidden" id="editWrkfrcSvcTpVal" value="N"/>
                                <div class="dropdown-content">
                                    <a data-tp="A" onclick="$('#editWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcSvcTpVal').val($(this).data('tp'))">Ambulance</a>
                                    <a data-tp="T" onclick="$('#editWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcSvcTpVal').val($(this).data('tp'))">Telehealth</a>
                                    <a data-tp="H" onclick="$('#editWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcSvcTpVal').val($(this).data('tp'))">Health Manager</a>
                                    <a data-tp="N" onclick="$('#editWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text()); $('#editWrkfrcSvcTpVal').val($(this).data('tp'))">Nursing</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-col-100 mb-16px">
                        <div class="input-label01 mb-4px">
                            Memo
                        </div>
                        <div class="wrap-form">
                                    <textarea class="input-area" id="editWrkfrcMemo"
                                              placeholder="Please enter a note."></textarea>
                        </div>
                    </div>

                </div>

            </div>
            <div class="content-submit-ui mt-22px">
                <div class="submit-ui-wrap">
                </div>
                <div class="submit-ui-wrap">
                    <button type="button" class="gray-submit-btn" id="editResetBtn" onclick="reloadEditWorkforce()">
                        <img src="/resources/images/reset-icon.svg" class="icon22">
                        <span><spring:message code="common.btn.reset"/></span>
                    </button>

                    <button type="button" class="point-submit-btn" id="editConfirmBtn" onclick="editWorkforce()">
                        <img src="/resources/images/save-icon.svg" class="icon22">
                        <span>Save</span>
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
            wrkfrcMobile : $('#wrkfrcMobile').val().replaceAll('-',''),
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

    function fnSearch() {
        $('#workforceList').jqGrid('setGridParam', {
            url: 'selectWorkforceList',
            datatype: 'json',
            postData: setSearchParam()
        });
        $('#workforceList').trigger('reloadGrid', [{page: 1, current: true}]);
    }

    $(document).ready(function () {
        $('.datePicker').datepicker({
            dateFormat: 'yy-mm-dd',
            autoclose: true,
            todayHighlight: true
        });

        $('#workforceList').jqGrid({
            url: '${contextPath}/workforce/selectWorkforceList',
            mtype: "POST",
            datatype: "json",
            jsonReader: {repeatitems: false},
            postData: setSearchParam(),
            colModel: [
                {label: 'Workforce Number', name: 'wrkfrcNmbr', width:200, sortable : true},
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
                                return 'Telehealth';
                                break;
                            case 'H' :
                                return 'Health Manager';
                                break;
                            default :
                                return cellValue;
                                break;
                        }
                    }},
                { label: 'Details', name: 'wrkfrcId', width:100, sortable : false, formatter : function(cellValue, options, rowObject){
                        return `<button type="button" class="detail-btn" data-id="`+cellValue+`"><span>detail</span><img src="/resources/images/arrow-right-nomal.svg" class="icon18"></button>`
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
        jQuery("#workforceList").jqGrid('setGridWidth', $(".table-wrap").width());
    })

    $(document).on('click','.svcBtns', function(){
        if($('.svcBtns.active').length === 1 && $('.svcBtns.active')[0] == this){
            return;
        }

        if(this.dataset['filter'] === 'all') {
            $('.svcBtns').removeClass('active');

            $(this).addClass('active');
        } else {
            $('[data-filter="all"]').removeClass('active');
            $(this).toggleClass('active');
        }
    })

    function loadWrkfrcDetail(wrkfrcId) {
        $.ajax({
            type: 'POST',
            url: '/workforce/selectWorkforceDetail',
            contentType: 'application/json',
            data: wrkfrcId,
            success: function (data) {
                if(!data.isError && data.workforce != null) {
                    console.log(data);
                    resetEditWorkforce();

                    $('#editWrkfrcId').val(data.workforce.wrkfrcId);
                    $('#editWrkfrcNm').val(data.workforce.wrkfrcNm);
                    $('#editWrkfrcNmbr').val(data.workforce.wrkfrcNmbr);
                    $('#editWrkfrcMobile').val(data.workforce.wrkfrcMobile);
                    $('#editWrkfrcGrpId').val(data.workforce.grpTp);
                    $('#editWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith(data.workforce.grpTp);
                    $('#editWrkfrcSxVal').val(data.workforce.wrkfrcSx);
                    $('#editWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith(data.workforce.wrkfrcSx === 'F' ? 'Female' : 'Male');
                    $('#editWrkfrcBrthDt').val(data.workforce.wrkfrcBrthDt);
                    $('#dateDisplay3').val(data.workforce.wrkfrcBrthDt);
                    $('#editWrkfrcSvcTpVal').val(data.workforce.svcTp);
                    $('#editWrkfrcSvcTp').text(data.workforce.svcTp == 'N' ? 'Nursing' : data.workforce.svcTp == 'A' ? 'Ambulance' : data.workforce.svcTp == 'T' ? 'Telehealth' : data.workforce.svcTp == 'H' ? 'Health Manager' : '' );
                    $('#editWrkfrcMemo').val(data.workforce.memo);
                }
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
            }
        });
    }

    $(document).on('click', '.detail-btn', function(){
        loadWrkfrcDetail($(this).data('id'))

        openPopup('workforceEditPopup');
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
    function openPopup(id) {
        document.getElementById(id).classList.add('active');
        document.getElementById('slide-overlay').classList.add('active');
        document.body.classList.add('no-scroll');  // ✅ 본문 스크롤 막기
    };

    function closePopup() {
        $('.customer-popup.active').removeClass('active');
        document.getElementById('slide-overlay').classList.remove('active');
        document.body.classList.remove('no-scroll');  // ✅ 본문 스크롤 복구
    };

    $('.closePopup').on('click', function(){
        closePopup();
    })
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

        /*
        const mobileRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!mobileRegex.test(param.wrkfrcMobile)) {
            return false;
        }*/

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
            "wrkfrcMobile" : $('#addWrkfrcMobile').val().replaceAll('-',''),
            "grpTp" : $('#addWrkfrcGrpId').val(),
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
                    if(!data.isError) {
                        showToast('New Workforce has been created.')
                        closePopup();
                        fnSearch();
                    } else {
                        showToast('Processing failed.', 'point')
                    }
                },
                error: function (request, status, error) {
                    showToast('Processing failed.', 'point')
                    console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
                }
            });

        } else {
            alert('validation Fail')
        }
    }

    function editWorkforce() {
        var param = {
            "userId" : "${sessionScope.user.userId}",
            "wrkfrcId" : $('#editWrkfrcId').val(),
            "wrkfrcNm" : $('#editWrkfrcNm').val(),
            "wrkfrcNmbr" : $('#editWrkfrcNmbr').val(),
            "wrkfrcMobile" : $('#editWrkfrcMobile').val().replaceAll('-',''),
            "grpTp" : $('#editWrkfrcGrpId').val(),
            "wrkfrcSx" : $('#editWrkfrcSxVal').val(),
            "wrkfrcBrthDt" : $('#editWrkfrcBrthDt').val(),
            "svcTp" : $('#editWrkfrcSvcTpVal').val(),
            "memo" : $('#editWrkfrcMemo').val()
        };

        if(valdation(param)) {
            $.ajax({
                type: 'POST',
                url: '/workforce/update',
                data: param,
                datatype: 'json',
                success: function (data) {
                    if(!data.isError) {
                        showToast('Workforce has been updated.')
                        closePopup();
                        fnSearch();
                    } else {
                        showToast('Processing failed.', 'point')
                    }
                },
                error: function (request, status, error) {
                    showToast('Processing failed.', 'point')
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
        $('#addWrkfrcGrpId').val('Group A');
        $('#addWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('Group A');
        $('#addWrkfrcSxVal').val('F');
        $('#addWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('Female');
        $('#addWrkfrcBrthDt').val('');
        $('#addWrkfrcSvcTpVal').val('N');
        $('#addWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('Nursing');
        $('#addWrkfrcMemo').val('');
    }

    $(document).on('click', '#groupSelectBtn', function(){
        $('#addWrkfrcGrpId').val($('#selectedNodeIdVal').val());
        closeModal();
    })
    $('#addWrkfrcGrpId').on('focus', function(){
        showModal();
    })

    function resetEditWorkforce() {
        $('#editWrkfrcNm').val('');
        $('#editWrkfrcNmbr').val('');
        $('#editWrkfrcMobile').val('');
        $('#editWrkfrcGrpId').val('Group A');
        $('#editWrkfrcGrpIdBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('Group A');
        $('#editWrkfrcSxVal').val('F');
        $('#editWrkfrcSx').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('Female');
        $('#editWrkfrcBrthDt').val('');
        $('#editWrkfrcSvcTpVal').val('N');
        $('#editWrkfrcSvcTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith('Nursing');
        $('#editWrkfrcMemo').val('');
    }

    function reloadEditWorkforce() {
        loadWrkfrcDetail($('#editWrkfrcId').val());
    }
</script>