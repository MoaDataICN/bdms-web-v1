<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 일반 팝업 Popup-->
<div class="popup-wrapper" id="resetPwConfirmWrapper">
    <div class="popup-modal" id="resetPwConfirmPopup">
        <div class="popup-show">
            <div class="popup-title mt-8px">
                <spring:message code='resetPwConfirmPopup.title'/>
            </div>

            <div class="popup-text">
                <spring:message code='resetPwConfirmPopup.content'/>
            </div>

            <div class="row-input fx-c mt-16px">
                <input type="password" class="input-txt02" id="resetPwInput" placeholder="<spring:message code='resetPwConfirmPopup.placeholder'/>"
                    oninput="limitLength(this, 10);">
            </div>

            <button class="popup-close"><img src="/resources/images/close-icon.svg" class="icon22"></button>

            <div class="popup-footer mt-16px">
                <div></div>
                <div class="btn-group">
                    <button type="button" id="cancelBtn" class="gray-submit-btn">
                        <spring:message code='resetPwConfirmPopup.btn.cancel'/>
                    </button>
                    <button type="button" id="resetApprovalBtn" class="hold-submit-btn">
                        <spring:message code='resetPwConfirmPopup.btn.approval'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>