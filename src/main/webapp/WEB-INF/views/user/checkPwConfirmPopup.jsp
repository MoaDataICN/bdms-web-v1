<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 일반 팝업 Popup-->
<div class="popup-wrapper" id="checkPwConfirmWrapper">
    <div class="popup-modal" id="checkPwConfirmPopup">
        <div class="popup-show">
            <div class="popup-title mt-8px">
                <spring:message code='checkPwConfirmPopup.title'/>
            </div>

            <div class="popup-text">
                <spring:message code='checkPwConfirmPopup.content'/>
            </div>

            <div class="row-input fx-c mt-16px">
                <input type="password" class="input-txt02" id="checkPwInput" placeholder="<spring:message code='checkPwConfirmPopup.placeholder'/>"
                    oninput="limitLength(this, 10);">
            </div>

            <button class="popup-close"><img src="/resources/images/close-icon.svg" class="icon22"></button>

            <div class="popup-footer mt-16px">
                <div></div>
                <div class="btn-group">
                    <button type="button" id="cancelBtn" class="gray-submit-btn">
                        <spring:message code='checkPwConfirmPopup.btn.cancel'/>
                    </button>
                    <button type="button" id="checkEditBtn" class="hold-submit-btn">
                        <spring:message code='checkPwConfirmPopup.btn.edit'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>