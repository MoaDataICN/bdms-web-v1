<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglibs.jsp" %>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <%@ include file="../../../commons/meta.jsp" %>
    <title>Welcome, I am the BDMS administrator.</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Manrope:wght@200..800&family=Noto+Sans+KR:wght@100..900&display=swap"
            rel="stylesheet">

    <!-- icons -->
    <script src="https://unpkg.com/@phosphor-icons/web"></script>

    <!-- CSS -->
    <link rel="stylesheet" href="../../resources/css/bdms_common.css">
    <link rel="stylesheet" href="../../resources/css/bdms_style.css">
    <link rel="stylesheet" href="../../resources/css/bdms_color.css">
    <link rel="stylesheet" href="../../resources/css/jqgrid_custom.css">

    <!-- JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.js"
            integrity="sha512-8Z5++K1rB3U+USaLKG6oO8uWWBhdYsM3hmdirnOEWp8h2B1aOikj5zBzlXs8QOrvY9OxEnD2QDkbSKKpfqcIWw=="
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${contextPath}/resources/bootstrap/js/plugins/jqGrid/ui.jqgrid.css">
    <link rel="stylesheet" href="${contextPath}/resources/bootstrap/js/plugins/jquery_confirm/jquery_confirm.css">
    <script src="${contextPath}/resources/js/script.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/plugins/jqGrid/grid.locale-kr.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/plugins/jqGrid/jquery.jqgrid.min.js"></script>
    <script src="${contextPath}/resources/js/grid/pager.js"></script>
    <script src="${contextPath}/resources/js/moment.min.js"></script>
    <script src="${contextPath}/resources/js/jquery.cookie.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/plugins/jquery_confirm/jquery_confirm.js"></script><!-- Confirm -->
    <script src="${contextPath}/resources/bootstrap/js/jquery.serialize-object.js"></script><!-- Confirm -->
<style>
    .jc-bs3-container{
        justify-content : center !important;
        background-color: unset !important;
    }
</style>
<script>
    // logout
    $(document).on('click','.logout_icon30', function() {
        window.location.href='<c:url value="/login/logout"/>';
    })
</script>
</head>
<body>
    <header>
        <!-- head -->
        <tiles:insertAttribute name="header" />
    </header>
    <div class="container">
        <!-- sideMenu -->
        <tiles:insertAttribute name="sideMenu" />
        <!-- body -->
        <tiles:insertAttribute name="body" />
        <tiles:insertAttribute name="message" />
    </div>
</body>
</html>
