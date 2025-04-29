<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    long lastAccessedTime = session.getLastAccessedTime();
    int maxInactiveInterval = session.getMaxInactiveInterval();
    long expireTime = lastAccessedTime + (maxInactiveInterval * 1000L);
%>

<!-- JS에서도 사용할 수 있도록 hidden input 또는 JS 변수로 전달 -->
<script>
    const expireAt = new Date(<%= expireTime %>);

    function pad(n) {
        return n < 10 ? '0' + n : n;
    }

    const countdown = setInterval(() => {
        const now = new Date();
        const diff = expireAt - now;
        if (diff <= 0) {
            clearInterval(countdown);
            location.reload();
        } else {
            const totalSeconds = Math.floor(diff / 1000);
            const minutes = Math.floor(totalSeconds / 60);
            const seconds = totalSeconds % 60;
            $('#sessionTimeout').text(pad(minutes)+':'+pad(seconds));
        }
    }, 1000);


    function continueLogin() {
        $.ajax({
            url: '/login/continueLogin',
            method: 'POST',
            success: function(response) {
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("에러 발생: ", error);
            }
        });
    }
</script>
<!-- 헤더 영역-->
<header class="header">
    <!-- 로고 -->
    <div class="header-logo">
        <img src="../../resources/images/logo.png" class="logo-size" alt="logo">
    </div>
    <!-- 헤더 우측 UI-->
    <div class="header-ui">
	    <div class="header-time header-time-text mr-6px">
            <img src="../../resources/images/time-svg.svg" class="icon22">
            <p class="header-time-text">session out <span id="sessionTimeout">--:--</span></p>
        </div>
        <button type="button" class="reflesh-btn" onclick="continueLogin()">
            <img src="../../resources/images/reflesh-icon.png" class="icon26">
        </button>
	    <button type="button" class="header-btn" id="messageBtn" style="position: relative;">
	        <c:if test="${not empty annSt and annSt ne '0'}">
		        <span class="requested-circle02" style="position: absolute;top: 0;right: 0;width: 12px;height: 12px;"></span>
	        </c:if>
	        <img src="../../resources/images/bell-icon.svg" class="icon30">
        </button>
        <!--
        <button type="button" class="header-btn">
            <img src="../../resources/images/user-icon.svg" class="icon30">
        </button>
        -->
        <button type="button" class="header-btn">
            <img src="../../resources/images/logout-icon.svg" class="logout_icon30">
        </button>
    </div>
</header>