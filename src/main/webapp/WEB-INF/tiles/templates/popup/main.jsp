<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglibs.jsp" %>
<!DOCTYPE html>
<html lang='ko'>
<head>
	<%@ include file="../../../commons/meta.jsp" %>
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
	<script src="${contextPath}/resources/js/script.js"></script>
	<script src="${contextPath}/resources/bootstrap/js/plugins/jqGrid/grid.locale-kr.js"></script>
	<script src="${contextPath}/resources/bootstrap/js/plugins/jqGrid/jquery.jqgrid.min.js"></script>
	<script src="${contextPath}/resources/js/grid/pager.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
</head>
<style>
	#wrapper_popup div[id ^= 'modal-layer'] {width:100%;min-height:400px;left:40%;margin:10px;max-width:500px;position:absolute; padding:20px 30px; background:#fff; z-index:100000;border-radius:5px;overflow:auto;display:none}
	#wrapper_popup div[id ^= 'modal-layer'] h2 {display:block;margin:10px 0 0;padding-bottom:15px;border-bottom:1px #d8d8d8 solid;font-size:1.1em;font-weight:bold}
	#wrapper_popup div[id ^= 'modal-layer'] p {display:block;padding:20px 0 0;margin:0;font-size:1.0em;line-height:1.5em}
	#wrapper_popup div[id ^= 'modal-layer'] .hour-close {display:inline-block;padding:8px 20px;background:#f2f2f2;color:#666;border:1px #d8d8d8 solid;border-radius:5px;margin-top:15px}
	#wrapper_popup div[id ^= 'modal-layer'] .hour-close:hover {background:#54A94C;color:#f8f8f8}
	#wrapper_popup div[id ^= 'modal-layer'] img.cancel {position:absolute; right:10px;top:10px;zoom:1;filter: alpha(opacity=50);opacity: 0.7}
	#wrapper_popup div[id ^= 'modal-layer'] img.cancel:hover {zoom:1;filter: alpha(opacity=100);opacity: 1.0}
	#wrapper_popup .b-area {width:100%;text-align:right;margin-top:20px;border-top:1px #ccc solid}
	#wrapper_popup .c-green {color:green !important}
	#wrapper_popup .c-blue {color:blue !important}
	#wrapper_popup .c-red {color:red !important}
	.layer-shadow {box-shadow: 0px 3px 15px 0px rgba(0,0,0,0.74);-webkit-box-shadow: 0px 3px 15px 0px rgba(0,0,0,0.74);-moz-box-shadow: 0px 3px 15px 0px rgba(0,0,0,0.74);}
</style>
<tiles:insertAttribute name="body" ignore="true"/>
</html>
