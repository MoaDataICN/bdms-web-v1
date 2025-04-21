<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<style>
  table {
    width: 100% !important;
  }

  #messageHistoryPager {
    display:none;
  }

  .ui-state-default.ui-corner-top.ui-jqgrid-hdiv {
    background: transparent !important;
  }

  .ui-state-default.ui-th-column.ui-th-ltr {
    background : transparent !important;
  }

  .ui-jqgrid-jquery-ui td {
    background-color : transparent !important
  }

  .ui-widget.ui-widget-content, .ui-state-default.ui-corner-top.ui-jqgrid-hdiv {
    border : none !important;
  }

  .ui-jqgrid-btable tr.ui-state-hover {
    background: var(--gray-05) !important;
  }

  .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
    background: var(--gray-05) !important;
  }

  .calendar-icon {
    z-index: 1;
  }

  table {
    width: 100% !important;
  }
</style>

<main class="main">
  <!-- 대시보드 타이틀 -->
  <div class="second-title">
    <spring:message code="announcement.history"/>
  </div>

  <div class="table-wrap mt-36px">
    <div class="mt-16px table-data-wrap">
      <p class="second-title-status">
        <span class="bold-t-01" id="currentRowsCnt">0</span>
        <spring:message code="common.outOf"/>
        <span class="bold-t-01" id="totalResultsCnt">0</span>
        <spring:message code="common.results"/>
      </p>
      <div class="table-option-wrap">
        <div class="dropdown02">
          <button class="dropdown-search input-line-b" id="gridDropdownBtn"><spring:message code="common.viewResults" arguments="10" /> <span><img class="icon20"
                                                                                                                                                   alt="" src="/resources/images/arrow-gray-bottom.svg"></span></button>
          <div class="dropdown-content">
            <a data-cnt="100"><spring:message code="common.viewResults" arguments="100" /></a>
            <a data-cnt="50"><spring:message code="common.viewResults" arguments="50" /></a>
            <a data-cnt="10"><spring:message code="common.viewResults" arguments="10" /></a>
          </div>
        </div>
      </div>
    </div>
    <div class="w-line01 mt-8px"></div>
    <div class="main-table">
      <div class="tableWrapper">
        <table id="messageHistoryList"></table>
        <div id="messageHistoryPager"></div>
        <div id="customPager" class="page-group mb-22px mt-10px"></div>
      </div>
    </div>
  </div>

  <form name="excelForm" method="POST">
    <input type="hidden" id="sortColumn" name="sortColumn" value="reqDt"/>
    <input type="hidden" id="sord" name="sord" value="DESC"/>
  </form>
</main>

<script type="text/javascript">
  // Grid 하단 페이저 숫자
  const pageSize = 10;
  let currentPageGroup = 1;

  // 기본 Items 개수
  var rowNumsVal = 10;

  function setSearchParam() {
    return {};
  }

  $(document).ready(function() {
    $('#messageHistoryList').jqGrid({
      url : '${contextPath}/announcement/selectMessageHistory',
      mtype : "POST",
      datatype: "json",
      jsonReader : {repeatitems: false},
      postData: setSearchParam(),
      colModel : [
        { label: 'Send Time', name: 'sndDt', width:200, sortable : true},
        { label: 'To whom', name: 'tgTp', width:100, sortable : true, formatter: function(cellValue, options, rowObject) {
            if (cellValue === '0') {
              return 'Workforce Only';
            } else if(cellValue === '1'){
              return 'User Only';
            } else if(cellValue === '2') {
              return 'Workforce And User';
            } else {
              return 'Specific People';
            }
          }},
        { label: 'Group', name: 'grpNm', width:80, sortable : true},
        { label: 'Recipient', name: 'rcpt', width:300, sortable : false, formatter: function(cellValue, options, rowObject) {
            return cellValue != null && cellValue != '' ? cellValue : "-"
          }},
        { label: 'Title', name: 'title', width:200, sortable : false},
        { label: 'Text', name: 'cont', width:200, sortable : false},
        { label: 'From', name: 'sndId', width:60, sortable : true},
        { label: 'Details', name: 'annId', width:80, sortable : false, formatter : function(cellValue, options, rowObject){
            return `<button type="button" class="detail-btn" data-id="`+cellValue+`"><span>detail</span><img src="/resources/images/arrow-right-nomal.svg" class="icon18"></button>`
          }},
      ],
      page: 1,
      autowidth: true,
      height: 'auto',
      rowNum : rowNumsVal,
      rowList:[10,50,100],
      sortable : true,
      sortname : 'reqDt',
      sortorder : 'DESC',
      shrinkToFit: true,
      rownumbers: true,
      loadonce : false,
      pager : '#messageHistoryPager',
      viewrecords: true,
      loadComplete: function(data) {
        $('#totalResultsCnt').text(data.records);
        $('#currentRowsCnt').text(data.rows.length);
        createCustomPager('messageHistoryList');
        $(this).jqGrid('setLabel', 'rn', 'No.');
      },
      gridComplete: function() {
        createCustomPager('messageHistoryList');
        $(this).jqGrid('setLabel', 'rn', 'No.');
      },
      onSortCol: function (index, columnIndex, sortOrder) {
        //alert(index);
        $("#sortColumn").val(index);
        $("#sord").val(sortOrder);
      }
    })
  })

  $(window).on('resize.jqGrid', function() {
    jQuery("#messageHistoryList").jqGrid('setGridWidth', $(".table-wrap").width());
  })

  $(document).on('click', '.detail-btn', function(){
    showToast('퍼블리싱 작업 중인 기능입니다.')
  })
</script>