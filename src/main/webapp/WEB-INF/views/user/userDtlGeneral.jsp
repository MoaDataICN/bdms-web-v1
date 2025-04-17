<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn active" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
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
                    <input type="text" class="input-txt02 hold" id="general_userNm" value="<c:out value='${userDtlGeneral.userNm}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.loginId'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_emailId" value="<c:out value='${userDtlGeneral.emailId}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.phone'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_mobile" value="<c:out value='${userDtlGeneral.mobile}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.uid'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_userId" value="<c:out value='${userDtlGeneral.userId}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
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
                    </c:when>
                    <%-- GRP_LV 2 : 담당자 열람 가능 --%>
                    <c:otherwise>
                        <div class="dropdown">
                            <button class="dropdown-search readonly-dropdown" id="general_inChargeNmDropdown">
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
                    <input type="text" class="input-txt02" id="general_brthDt" value="<c:out value='${userDtlGeneral.brthDt}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
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
                    <input type="text" class="input-txt02" id="general_height" value="<c:out value='${userDtlGeneral.height}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01 hold">
                    <spring:message code='common.regDt'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_registDt" value="<c:out value='${userDtlGeneral.registDt}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.weight'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_weight" value="<c:out value='${userDtlGeneral.weight}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.lastAccess'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_lastAccess" value="<c:out value='${userDtlGeneral.lastAccess}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.address'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02" id="general_addr" value="<c:out value='${userDtlGeneral.addr}' default=''/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.accountDeletionRequestDate'/>
                </div>
                <div class="row-input">
                    <input type="hidden" id="general_wdDt" value="${userDtlGeneral.wdDt}" />
                    <input type="text" class="input-txt02 hold" id="deletionReqDateInput" value="<c:out value='${userDtlGeneral.wdDt}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
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
                    <input type="text" class="input-txt02 hold mr-4px" id="deletionDate" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt04 hold mx-w250" id="deletionDateCnt" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
        </div>

        <div class="row-col-100 mb-16px">
            <div class="input-label01 mb-4px">
                <spring:message code='common.memo'/>
            </div>
            <div class="wrap-form">
                <textarea class="input-area" id="general_mmo" placeholder="Please enter a note."><c:out value='${userDtlGeneral.mmo}' default=''/></textarea>
            </div>
        </div>

        <div class="row-md-100">
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.lastEdited'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_uptDt" value="<c:out value='${userDtlGeneral.uptDt}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
                </div>
            </div>
            <div class="row-wrap">
                <div class="input-label01">
                    <spring:message code='common.editedBy'/>
                </div>
                <div class="row-input">
                    <input type="text" class="input-txt02 hold" id="general_uptId" value="<c:out value='${userDtlGeneral.uptId}' default='-'/>" placeholder="<spring:message code='common.placeholder.pleaseEnter'/>" oninput="limitLength(this, 30);">
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
        <button type="button" id="resetBtn" class="gray-submit-btn">
            <img src="/resources/images/reset-icon.svg" class="icon22">
            <span><spring:message code='common.reset'/></span>
        </button>
        <button type="button" id="saveChangesBtn" class="hold-submit-btn" disabled>
            <img src="/resources/images/save-icon.svg" class="icon22">
            <span><spring:message code='common.saveChanges'/></span>
        </button>
    </div>
</div>

<div class="space-30"></div>
