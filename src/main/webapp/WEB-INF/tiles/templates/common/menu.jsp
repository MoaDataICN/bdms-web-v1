<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../../commons/taglibs.jsp"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<!-- 사이드메뉴 영역-->
<aside class="sidebar">
    <div class="menu-btn">
        <img src="../../resources/images/arrow-left-icon.svg" class="icon20">
    </div>
    <div class="head">
        <div class="user-img">
            <img src="../../resources/images/user-img.jpg" alt="user-img">
        </div>
        <div class="user-details">
            <p class="side-name-text"><spring:message code="side.user.greet" arguments="${sessionScope.user.userNm}" /></p>
            <%
                Object userObj = session.getAttribute("user");

                String formattedDate = "";

                if(userObj != null) {
                    try {
                        String dateString = (String) org.apache.commons.beanutils.PropertyUtils.getProperty(userObj, "loginDt");

                        // 문자열 -> Date 객체로 파싱
                        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = inputFormat.parse(dateString);

                        // 원하는 포맷으로 변환
                        SimpleDateFormat outputFormat = new SimpleDateFormat("'logged in on' MMMM d, yyyy (EEEE) 'at' HH:mm:ss.", Locale.ENGLISH);
                        formattedDate = outputFormat.format(date);
                    }catch (Exception e) {
                        formattedDate = "Invalid login date";
                        e.printStackTrace();
                    }
                } else {
                    formattedDate = "User is not logged in";
                }
            %>

            <p class="side-address-text"><%= formattedDate %></p>
        </div>
    </div>
    <div class="nav mt-44px">
        <div class="menu">
            <ul class="wrap">
                <c:if test="${!empty menuList}">
                    <c:forEach var="menu2" items="${menuList}">
                        <c:if test="${menu2.menuLevel == 3}">
                            <li>
                                <c:choose>
                                    <c:when test="${not empty menu2.menuUrl}">
                                        <a href="${menu2.menuUrl}">
                                        <c:if test="${not empty menu2.menuIconNm}">
                                            <img src="../../resources/images/${menu2.menuIconNm}.svg">
                                        </c:if>
                                        <span class="text">${menu2.menuNm}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a>
                                        <c:if test="${not empty menu2.menuIconNm}">
                                            <img src="../../resources/images/${menu2.menuIconNm}.svg">
                                        </c:if>
                                        <span class="text">${menu2.menuNm}</span>
                                        <img src="../../resources/images/arrow-under-icon.svg" class="arrow">
                                    </c:otherwise>
                                </c:choose>

                                </a>
                                <ul id="${menu2.menuId}" class="sub-menu">
                                    <c:forEach var="menu3" items="${menuList}">
                                        <c:if test="${fn:trim(menu3.parMenuId) eq fn:trim(menu2.menuId)}">
                                            <li>
                                                <c:choose>
                                                    <c:when test="${not empty menu3.menuUrl}">
                                                        <a href="${menu3.menuUrl}"><span class="sub-text">${menu3.menuNm}</span></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a>${menu3.menuNm}</a>
                                                        <ul id="${menu3.menuId}" class="sub-menu">
                                                            <c:forEach var="menu4" items="${menuList}">
                                                                <c:if test="${fn:trim(menu4.parMenuId) eq fn:trim(menu3.menuId)}">
                                                                    <li>
                                                                        <a href="${menu4.menuUrl}"><span class="sub-text">${menu4.menuNm}</span></a>
                                                                    </li>
                                                                </c:if>
                                                            </c:forEach>
                                                        </ul>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
        <!-- 사이드 하단 세팅/인포메이션 ui-->
        <div class="menu ui-second mt-90px">
            <ul>
                <li>
                    <a href="#">
                        <img src="../../resources/images/setting-icon.svg" class="icon22">
                        <span class="text"><spring:message code="common.setting"/></span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="../../resources/images/infor-icon.svg" class="icon22">
                        <span class="text"><spring:message code="common.information"/></span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</aside>

<script>
    $(".menu > ul > li").click(function (e) {
        if($($(this).find('a')).attr('href') == null) {
            $(this).siblings().removeClass("active");
            $(this).toggleClass("active");
            $(this).find("ul").slideToggle();
            $(this).siblings().find("ul").slideUp();
            $(this).siblings().find("ul").find("li").removeClass("active")
        }
    });

    $(".menu-btn").click(function () {
        $(".sidebar").toggleClass("active");
    });


    var currentUrl = window.location.pathname;

    $('.menu a').each(function (el, index) {
        if($(index).attr('href') === currentUrl) {
            var current = $(index);

            current.css('color','#454546');
            current.css('background-color', '#f6f6f6')
            console.log(current.closest('ul'))
            if(current.closest('ul').hasClass('wrap')) {
                console.log('yes')
            } else {
                current.closest('ul')[0].style.display='block';
                current.closest('ul')[0].closest('li').classList.add('active')
            }
        }
    })
</script>
