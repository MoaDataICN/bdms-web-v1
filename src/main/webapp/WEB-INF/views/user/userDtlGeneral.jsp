<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn active" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
    <button type="button" class="second-tap-btn" data-tab="checkup-result"><spring:message code='common.tapMenu.checkupResult'/></button>
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
                    <input type="text" class="input-txt02 hold" id="general_userNm" value="<c:out value='${userDtlGeneral.userNm}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.loginId'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_emailId" value="<c:out value='${userDtlGeneral.emailId}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.phone'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_mobile" value="<c:out value='${userDtlGeneral.mobile}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="1">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.uid'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_userId" value="<c:out value='${userDtlGeneral.userId}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.sex'/>
                </div>
                <div class="dropdown">
                    <button class="dropdown-search" id="general_sxDropdown">
                        <c:choose>
                            <c:when test="${userDtlGeneral.sx == 'F'}">
                                <spring:message code='common.sex.f'/>
                            </c:when>
                            <c:when test="${userDtlGeneral.sx == 'M'}">
                                <spring:message code='common.sex.m'/>
                            </c:when>
                            <c:otherwise>
                                <spring:message code='common.select'/>
                            </c:otherwise>
                        </c:choose>
                        <span>
                            <img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg">
                        </span>
                    </button>
                    <div class="dropdown-content">
                        <a href="#">
                            <spring:message code='common.sex.f'/>
                        </a>
                        <a href="#">
                            <spring:message code='common.sex.m'/>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.inCharge'/>
                </div>
                <c:choose>
                    <%-- GRP_LV 1 : 담당자 변경 가능 --%>
                    <c:when test="${grpLv == 1}">
                        <div class="dropdown">
                            <button class="dropdown-search" id="general_inChargeNm">
                                ${userDtlGeneral.inChargeNm}
                            </button>
                        </div>
                        <%--
                        <div class="dropdown">
                            <button class="dropdown-search" id="general_inChargeNmDropdown">
                                 <c:choose>
                                    <c:when test="${not empty userDtlGeneral.inChargeNm}">
                                        ${userDtlGeneral.inChargeNm}
                                    </c:when>
                                    <c:otherwise>
                                        <spring:message code='common.select'/>
                                    </c:otherwise>
                                </c:choose>
                                <span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span>
                            </button>
                            <div class="dropdown-content">
                                <c:forEach var="item" items="${inChargeNmList}">
                                    <a href="#">
                                        ${item.inChargeNm}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                        --%>
                    </c:when>
                    <%-- GRP_LV 2 : 담당자 열람 가능 --%>
                    <c:otherwise>
                        <div class="dropdown">
                            <button class="dropdown-search readonly-dropdown" id="general_inChargeNm">
                                ${userDtlGeneral.inChargeNm}
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.birthDt'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 datePicker" id="general_brthDt" value="<c:out value='${userDtlGeneral.brthDt}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="2">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.group'/>
                </div>
                <div class="dropdown">
                    <button class="dropdown-search" id="general_grpTpDropdown">
                    <c:choose>
                        <c:when test="${not empty userDtlGeneral.grpTp}">
                            ${userDtlGeneral.grpTp}
                        </c:when>
                        <c:otherwise>
                            <spring:message code='common.select'/>
                       </c:otherwise>
                    </c:choose>
                    <span><img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
                    <div class="dropdown-content">
                        <a href="#"><spring:message code='common.group.1'/></a>
                        <a href="#"><spring:message code='common.group.2'/></a>
                        <a href="#"><spring:message code='common.group.3'/></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.height'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_height" value="<c:out value='${userDtlGeneral.height}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="3">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01 hold">
                    <spring:message code='common.regDt'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_registDt" value="<c:out value='${userDtlGeneral.registDt}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.weight'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_weight" value="<c:out value='${userDtlGeneral.weight}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="4">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.lastAccess'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_lastAccess" value="<c:out value='${userDtlGeneral.lastAccess}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.address'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_addr" value="<c:out value='${userDtlGeneral.addr}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="5">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.accountDeletionRequestDate'/>
                </div>
                <div class="row-input">
                    <input type="hidden" id="general_wdDt" value="${userDtlGeneral.wdDt}" />
                    <input type="text" class="input-txt02 hold" id="deletionReqDateInput" value="<c:out value='${userDtlGeneral.wdDt}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.accountStatus'/>
                </div>
                <div class="dropdown">
                    <button class="dropdown-search" id="general_statusDropdown">
                        <c:choose>
                            <c:when test="${userDtlGeneral.wdYn eq 'N'}">
                                <spring:message code="common.active"/>
                            </c:when>
                            <c:when test="${userDtlGeneral.wdYn eq 'S'}">
                                <spring:message code="common.suspended"/>
                            </c:when>
                            <c:when test="${userDtlGeneral.wdYn eq 'Y'}">
                                <spring:message code="common.readyToDelete"/>
                            </c:when>
                            <c:otherwise>
                                <spring:message code="common.select"/>
                            </c:otherwise>
                        </c:choose>
                        <span>
                            <img class="icon20" alt="" src="/resources/images/arrow-gray-bottom.svg">
                        </span>
                    </button>
                    <div class="dropdown-content">
                        <a href="#"><spring:message code='common.active'/></a>
                        <a href="#"><spring:message code='common.suspended'/></a>
                        <a href="#"><spring:message code='common.readyToDelete'/></a>
                    </div>
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.deletionDate'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold mr-4px" id="deletionDate" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt04 hold mx-w250" id="deletionDateCnt" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>

        <div class="row-col-100 mb-16px">
            <div class="input-label01 mb-4px">
                <spring:message code='common.memo'/>
            </div>
            <div class="wrap-form">
                <textarea class="input-area" id="general_mmo" placeholder="Please enter a note." tabindex="6"><c:out value='${userDtlGeneral.mmo}' default=''/></textarea>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.lastEdited'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_uptDt" value="<c:out value='${userDtlGeneral.uptDt}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.editedBy'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_uptId" value="<c:out value='${userDtlGeneral.uptId}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);" tabindex="-1">
                </div>
            </div>
        </div>
    </div>
</div>

<div class="content-submit-ui mt-22px" id="editButtons">
    <div class="submit-ui-wrap">
        <button type="button" id="editBtn" class="point-submit-btn">
            <span><spring:message code='common.edit'/></span>
        </button>
    </div>
</div>

<div class="content-submit-ui mt-22px hidden" id="actionButtons">
    <div class="submit-ui-wrap">
        <button type="button" id="resetPwBtn" class="gray-submit-btn">
            <img src="/resources/images/reset-pass-icon.svg" class="icon22">
            <span><spring:message code='common.resetPassword'/></span>
        </button>
    </div>

    <div class="submit-ui-wrap">
        <button type="button" class="gray-submit-btn" onclick="general_fnClear()">
            <img src="/resources/images/reset-icon.svg" class="icon22">
            <span><spring:message code='common.reset'/></span>
        </button>
        <button type="button" id="general_saveChangesBtn" class="hold-submit-btn" disabled>
            <img src="/resources/images/save-icon.svg" class="icon22">
            <span><spring:message code='common.saveChanges'/></span>
        </button>
    </div>
</div>

<!-- 팝업 삽입 영역 -->
<div class="charge-search-popup-general-container">
</div>

<div class="space-30"></div>

<script type="text/javascript">
    var userDtlGeneral_messages = {
        f: "<spring:message code='common.sex.f'/>",
        m: "<spring:message code='common.sex.m'/>",
        active: "<spring:message code='common.active'/>",
        suspended: "<spring:message code='common.suspended'/>",
        readyToDelete: "<spring:message code='common.readyToDelete'/>",
        all: "<spring:message code='common.all'/>",
        select: "<spring:message code='common.select'/>"
    };

    // userDtlGeneral : 기존 값 저장
    if (typeof userDtlGeneral === 'undefined') {
        var userDtlGeneral = {};
    }

    function extractUserDtlGeneralFromDOM() {
        userDtlGeneral = {
            userNm: $("#general_userNm").val() || "-",
            emailId: $("#general_emailId").val() || "-",
            mobile: $("#general_mobile").val() || "",
            userId: $("#general_userId").val() || "-",
            inChargeNm: $('#general_inChargeNm').text().trim() || "-",
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
            }).text().trim() || userDtlGeneral_messages.select,
            /*
            inChargeNm: $("#general_inChargeNmDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userDtlGeneral_messages.select,
            */
            grpTp: $("#general_grpTpDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userDtlGeneral_messages.select,
            wdYn: $("#general_statusDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || userDtlGeneral_messages.select
        };
    }

    // 입력창 잠금
    function general_readonly() {
        $('#customerPopup input, #customerPopup textarea').attr('disabled', true);
        $('#customerPopup .dropdown-search, #customerPopup .dropdown-content a').addClass('hold');
    }

    // 입력창 해제
    function general_write() {
        $('#customerPopup input:not(.hold), #customerPopup textarea:not(.hold)').removeAttr('disabled');
        $('#customerPopup .dropdown-search, #customerPopup .dropdown-content a').not('.readonly-dropdown').removeClass('hold');
        $("#general_brthDt").prop("disabled", false);

        $("#general_mobile").focus();
    }

    // editBtn : 사용자 정보 변경 버튼
    $(document).on('click', '#editBtn', function () {
        general_write();

        $('#editButtons').addClass('hidden');
        $('#actionButtons').removeClass('hidden');
    });

    // resetPwBtn : 비밀번호 변경 버튼
    $(document).on("click", "#resetPwBtn", function () {
        $("#customerPopup .reset-pw-popup-container").load("/user/resetPwStartPopup", function () {
            $('#resetPwStartPopup').fadeIn();
        });
    });

    $(document).on("click", "#resetPwStartPopup #nextBtn", function () {
        $("#customerPopup .reset-pw-popup-container").load("/user/resetPwConfirmPopup", function () {
            $('#resetPwConfirmPopup').fadeIn();
        });
    });

    // 비밀번호 재설정 팝업 외부 요소 클릭 시 팝업 닫기 처리
    $(document).on("click", ".popup-modal .popup-close, .popup-modal #goBackBtn, .popup-modal #cancelBtn", function () {
        if ($("#resetPwStartPopup").is(":visible")) {
            $("#resetPwStartPopup").fadeOut();
            $("#customerPopup .reset-pw-popup-container").empty();
        }

        if ($("#resetPwConfirmPopup").is(":visible")) {
            $("#resetPwConfirmPopup").fadeOut();
            $("#customerPopup .reset-pw-popup-container").empty();
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
                                // 확인 눌렀을 때 실행할 동작
                            }
                        }
                    }
                });

                $("#resetPwConfirmPopup").fadeOut();
                $("#customerPopup .reset-pw-popup-container").empty();
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

    // 사용자 정보 입력 초기화
    function general_fnClear() {
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
        $("#general_inChargeNm").text(userDtlGeneral.inChargeNm);
        $("#general_brthDt").val(userDtlGeneral.brthDt);
        $("#general_height").val(userDtlGeneral.height);
        $("#general_registDt").val(userDtlGeneral.registDt);
        $("#general_weight").val(userDtlGeneral.weight);
        $("#general_lastAccess").val(userDtlGeneral.lastAccess);
        $("#general_addr").val(userDtlGeneral.addr);
        $("#general_wdDt").val(userDtlGeneral.wdDt);
        $("#general_mmo").val(userDtlGeneral.mmo);

        // 드롭다운 복원
        resetDropdownText("general_sxDropdown", userDtlGeneral.sx || userDtlGeneral_messages.select);
        //resetDropdownText("general_inChargeNmDropdown", userDtlGeneral.inChargeNm || userDtlGeneral_messages.select);
        resetDropdownText("general_statusDropdown", userDtlGeneral.wdYn || userDtlGeneral_messages.select);
        resetDropdownText("general_grpTpDropdown", userDtlGeneral.grpTp || userDtlGeneral_messages.select);

        general_checkDataChanged();
    }

    // 최초 한 번만 선언되도록 if로 감싸기
    if (typeof calculatedWdDt === 'undefined') {  // 변경 될 삭제 예정일
        var calculatedWdDt = "";
    }
    // 최초 한 번만 선언되도록 if로 감싸기
    if (typeof calculatedWdYn === 'undefined') {  // 변경 될 탈퇴 상태
        var calculatedWdYn = "";
    }

    function updateDeletionDateInfo() {
        let wdYn = $("#general_statusDropdown").contents().filter(function () {
            return this.nodeType === 3;
        }).text().trim();

        let wdDtCopy = $("#general_wdDt").val();

        let $deletionDateInput = $("#deletionDate");
        let $deletionDateCntInput = $("#deletionDateCnt");

        if (wdYn === userDtlGeneral_messages.active) {  // 'Active' 상태
            $deletionDateInput.val('-');
            $deletionDateCntInput.val('-');

            calculatedWdYn = 'N';
            return;
        } else if (wdYn === userDtlGeneral_messages.suspended) {  // 'Suspended' 상태
            $deletionDateInput.val('-');
            $deletionDateCntInput.val('-');

            calculatedWdYn = 'S';
            return;
        } else if (wdYn === userDtlGeneral_messages.readyToDelete) {  // 'Ready to delete' 상태
            let targetDate;

            if (wdDtCopy) {
                targetDate = new Date(wdDtCopy);
            } else {
                // wdDtCopy 없을 경우 → 오늘 기준 30일 후로 설정
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

        console.log("🔽 Dropdown clicked : " + selectedText);

        // 텍스트 노드 교체
        $button.contents().filter(function () {
            return this.nodeType === 3;
        }).first().replaceWith(selectedText + " ");

        // 상태 드롭다운일 경우 처리
        if ($button.attr("id") === "general_statusDropdown") {
            updateDeletionDateInfo();
        }

        general_checkDataChanged();
    });

    // 변경사항 확인
    function general_checkDataChanged() {
        let editedValues = {
            mobile: $("#general_mobile").val()?.trim() || '',
            inChargeNm : $("#general_inChargeNm").text().trim() || '',
            brthDt: $("#general_brthDt").val()?.trim() || '',
            height: $("#general_height").val()?.trim() || '',
            weight: $("#general_weight").val()?.trim() || '',
            addr: $("#general_addr").val()?.trim() || '',
            mmo: $("#general_mmo").val()?.trim() || '',
            sx: $("#general_sxDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim(),
            /*
            inChargeNm: $("#general_inChargeNmDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim(),
            */
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

            $('#general_saveChangesBtn')
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

            // inChargeNm은 버튼 안의 텍스트와 비교
            if (key === 'inChargeNm') {
                const inChargeText = $('#general_inChargeNm').text().trim();

                return inChargeText !== initialValue;
            }

            return currentValue !== initialValue;
        });

        if (isChanged) {
            $('#general_saveChangesBtn')
                .removeClass('hold-submit-btn')
                .addClass('red-submit-btn')
                .prop("disabled", false);
        } else {
            $('#general_saveChangesBtn')
                .removeClass('red-submit-btn')
                .addClass('hold-submit-btn')
                .prop("disabled", true);
        }
    }

    $(document).on('input', '#general_mobile, #general_brthDt, #general_height, #general_weight, #general_addr, #general_mmo', general_checkDataChanged);

    function general_setUserUpdateParam() {
        return {
            mobile: $("#general_mobile").val()?.trim() || "",
            sx: (() => {
                const text = $("#general_sxDropdown").contents().filter(function () {
                    return this.nodeType === 3;
                }).text().trim();

                if (text === userDtlGeneral_messages.f) return "F";
                if (text === userDtlGeneral_messages.m) return "M";
                return "";
            })(),
            /*
            inChargeNm: $("#general_inChargeNmDropdown").contents().filter(function () {
                return this.nodeType === 3;
            }).text().trim() || "",
            */
            inChargeNm: $('#general_inChargeNm').text().trim() || "",
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

    // 담당자명 팝업 열기
    $(document).on('click', '#general_inChargeNm', function () {
        $(".charge-search-popup-general-container").load("/user/chargeSearchOnSlidePopup", function () {
            $('#chargeSearchOnSlidePopup').fadeIn();
        });
    });

    // general_saveChangesBtn : 사용자 정보 변경 요청 버튼
    $(document).on("click", "#general_saveChangesBtn", function () {
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

    $(document).off("click", "#checkEditBtn").on("click", "#checkEditBtn", function () {
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

    function updateUserGeneralInfo() {
        let updateData = general_setUserUpdateParam();

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
            $.confirm({
                title: 'Success',
                content: 'User information has been successfully updated.',
                type: 'green',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-green',
                        action: function(){
                            $(".open-slide-btn[data-uid='" + userDtlGeneral.userId + "']").click();
                        }
                    }
                }
            });

            // 버튼 상태 복원
            $("#general_saveChangesBtn")
                .removeClass("red-submit-btn")
                .addClass("hold-submit-btn")
                .prop("disabled", true);
        })
        .catch(error => {
            $.confirm({
                title: 'Error',
                content: error.message || 'An error occurred while updating user information.',
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
</script>
