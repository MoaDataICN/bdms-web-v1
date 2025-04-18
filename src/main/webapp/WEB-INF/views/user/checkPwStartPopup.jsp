<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 일반 팝업 Popup-->
<div class="popup-wrapper" id="checkPwStartWrapper">
    <div class="popup-modal" id="checkPwStartPopup">
        <div class="popup-show">
            <div class="popup-title mt-8px">
                <spring:message code='checkPwStartPopup.title'/>
            </div>

            <div class="popup-text">
                <spring:message code='checkPwStartPopup.content'/>
            </div>

            <button class="popup-close"><img src="/resources/images/close-icon.svg" class="icon22"></button>

            <div class="popup-footer mt-16px">
                <div></div>
                <div class="btn-group">
                    <button type="button" id="goBackBtn" class="gray-submit-btn">
                        <spring:message code='checkPwStartPopup.btn.goBack'/>
                    </button>
                    <button type="button" id="nextBtn" class="point-submit-btn">
                        <spring:message code='checkPwStartPopup.btn.next'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>