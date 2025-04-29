<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<script src="../../../resources/js/chart/chartjs/chart.umd.js"></script>

<div class="client-group02 mt-16px">
	<!-- 타이틀 -->
	<div class="second-title03 f-x">
		Service Request Amount
		<button class="add-btn ml-10px" onclick="showToast(`It's in the process of development.`)">Download the meta data
			<img src="/resources/images/down-icon.svg" class="icon20">
		</button>
	</div>
	
	<!-- 날짜 검색 -->
	<div class="row-wrap mt-16px">
		<div class="row-input">
			<div class="p-r">
				<input type="text" class="date-input input-txt02" id="searchBgnDe" placeholder="ALL" readonly="">
				<img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('datePicker1')" alt="달력 아이콘">
				<input type="date" id="datePicker1" class="hidden-date" onchange="updateDate('datePicker1', 'searchBgnDe')">
			</div>
			<img src="/resources/images/minus-icon.svg" class="icon14 img-none">
			<div class="p-r">
				<input type="text" class="date-input input-txt02" id="searchEndDe" placeholder="ALL" readonly="">
				<img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon" onclick="openCalendar('datePicker2')" alt="달력 아이콘">
				<input type="date" id="datePicker2" class="hidden-date" onchange="updateDate('datePicker2', 'searchEndDe')">
			</div>
			<div class="day-button-wrap">
				<button class="data-select-btn periodBtn active" data-period="6-day">7day</button>
				<button class="data-select-btn periodBtn" data-period="29-day">30day</button>
				<button class="data-select-btn periodBtn" data-period="89-day">90day</button>
			</div>
		</div>
	</div>
	<div class="row-wrap">
		<div class="input-label01">
			<spring:message code="common.alertTp"/>
		</div>
		<div class="row-input">
			<div class="day-button-wrap02">
				<button class="data-select-btn alertBtns active" data-filter="all"><spring:message code="common.all"/></button>
				<button class="data-select-btn alertBtns" data-filter="N"><spring:message code="common.serviceTp.N"/></button>
				<button class="data-select-btn alertBtns" data-filter="A"><spring:message code="common.serviceTp.A"/></button>
				<button class="data-select-btn alertBtns" data-filter="T"><spring:message code="common.serviceTp.T"/></button>
			</div>
		</div>
	</div>
	
	<div class="chartWrapper" style="width:100%;">
		<canvas id="chart"></canvas>
	</div>
</div>
