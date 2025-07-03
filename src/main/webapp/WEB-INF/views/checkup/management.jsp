<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="/resources/js/script.js"></script>
<script src="/resources/js/jquery-ui.js"></script>
<script src="/resources/js/common/utils/calcUtil.js"></script>
<script src="/resources/js/dropzone-min.js"></script>

<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/bdms_common.css">
<link rel="stylesheet" href="/resources/css/bdms_style.css">
<link rel="stylesheet" href="/resources/css/bdms_color.css">
<link rel="stylesheet" href="/resources/css/dropzone.css">

<style>
    .cbox {
        display: inline-block;
        width: auto;
        min-height: 24px;
        height: auto;
        line-height: 24px;
        padding: 0;
        border: 0;
    }

    .cbox:before {
        content: "";
        display: inline-block;
        vertical-align: top;
        width: 23px;
        height: 23px;
        background: url('/resources/images/rect-check2.svg') 0 -23px no-repeat; /* 체크되지 않은 상태의 이미지 */
        background-size: 20px 48px;
    }

    /* 체크된 상태의 체크박스 */
    .cbox:checked:before {
        background: url('/resources/images/rect-check2.svg') 0 0px no-repeat; /* 체크된 상태의 이미지 */
        background-size: 20px 48px;
    }

    #checkupPager {
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
    <!-- Area map 위치 텍스트 -->
    <div class="area-map active mr-4px">
        <a href="#">
            <img src="/resources/images/home-map.svg" class="icon14">
            <span>Home</span>
        </a>
        <a href="#">
            <img src="/resources/images/arrow-right-gray.svg" class="icon14">
            <span>Checkup Management</span>
        </a>
    </div>
    <!-- 대시보드 타이틀 -->
    <div class="second-title">
        Checkup Management
    </div>

    <div class="second-container mt-18px">
        <div class="content-row">
            <div class="second-title02">
                Upload Checkup Data
                <button class="data-select-btn" onClick="downform();">Download the form in CSV format</button>
            </div>
            <div id="drop-area" class="mt-14px">
                <form class="dropzone" id="dropzone-file" name="dropzone-file" method="post" enctype="multipart/form-data">
                    <input type="file" value="" id="file" name="file" style="width:0px;">      <!-- multiple="true" -->
                    <img src="/resources/images/drap-icon.png" class="icon80">
                    <p class="mt-10px drop-text">Drag And Drop File Here</p>
                </form>
            </div>
        </div>
    </div>

    <div class="content-submit-ui mt-22px">
        <div class="submit-ui-wrap">
        </div>
        <div class="submit-ui-wrap">
            <button type="button" class="gray-submit-btn" id="delete" onclick="fnDelete()">
                <img src="/resources/images/del-line-icon.svg" class="icon22">
                <span><spring:message code="common.btn.delete"/></span>
            </button>
            <button type="button" class="gray-submit-btn" id="saveall" onclick="fnSaveAll()">
                <img src="/resources/images/add-line-icon.svg" class="icon22">
                <span><spring:message code="common.btn.saveall"/></span>
            </button>
        </div>
    </div>

    <div class="table-wrap mt-36px">
        <div class="w-line01 mt-8px"></div>
        <div class="main-table">
            <div class="tableWrapper">
                <table id="checkupList"></table>
                <div id="checkupPager"></div>
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
    var dropzoneFile;
    var rowNumsVal;
    var validData;
    var prevCell = { rowId: null, iCol: null };

    function selectMainMaxValue(){
        $.ajax({
            type: 'POST',
            url: '${contextPath}/user/selectValidMinMax',
            data: {},
            dataType: 'json',
            success: function(data) {
                if(data.isError){
                    $.alert(data.message);
                    console.log('ERROR', data.message);
                }else{
                    console.log('SUCCESS', data.row);
                    validData = data.row;
                }
            }
        });
    }

    function fnDelete() {
        var selectIds = $("#checkupList").getGridParam('selarrrow')
        var searchType = false;
        if(selectIds.length > 0){
            for(var i =0; i< selectIds.length; i++){
                var selectRowData =  $("#checkupList").jqGrid("getRowData",selectIds[i]);

                if(i === 0 && selectRowData.preEditType === "S"){
                    searchType = true;
                }

                if(searchType){
                    delParamList.push($("#checkupList").jqGrid("getRowData",selectIds[i]));
                }else{
                    $("#checkupList").delRowData(selectIds[i]);
                    i--;
                }
            }
            if(delParamList.length > 0){
                var message="<spring:message code="common.confirm.delete"/>";

                $.confirm({
                    title: '',
                    content: message,
                    buttons: {
                        OK: function () {
                            $("#checkupList").jqGrid("resetSelection");
                        },
                        Cancel: function () {
                            delParamList = []; //초기화.
                        }
                    }
                });
            }
        }else{
            $.alert("<spring:message code="common.msg.delete"/>");
        }
    }

    function fnSaveAll() {
        var selectIds = null;
        var insertParamList = [];

        selectIds = $("#checkupList").getDataIDs();
        if(selectIds.length > 0){
            for(var i = 0; i< selectIds.length; i++){
                var tempData = $("#checkupList").jqGrid("getRowData",selectIds[i]);
                if(tempData.valid === "passed"){
                    insertParamList.push(tempData);
                } else {
                    $.alert('<spring:message code="common.confirm.save.invalid"/>');
                    return;
                }
            }
            console.log("params ::", insertParamList);

            if(insertParamList.length > 0){
                var params = {
                    paramList: insertParamList
                };

                $.ajax({
                    url : "${contextPath}/checkup/checkupSave",
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    dataType : "json",
                    data : params,
                    cache : false,
                    type : 'post',
                    success: function(data) {
                        console.log("## data :: ", data);
                        if (data.isError) {
                            $.alert(data.message);
                        } else {
                            if(data.message === "error."){
                                $.alert(data.message);
                            }else{
                                $.alert('<spring:message code="common.confirm.save"/>');
                                //grid 초기화
                                $("#checkupList").jqGrid('clearGridData', true);
                                //drag & drop 초기화
                                Dropzone.forElement("#dropzone-file").removeAllFiles(true);
                            }
                            $("#checkupList").jqGrid("resetSelection");
                        }
                    }
                });
            }else{
                $.alert('<spring:message code="common.confirm.save.reconfirm"/>');
            }

        }else{
            $.alert('<spring:message code="common.confirm.save.data"/>')
        }
    }

    function downform(){
        let _url = "${contextPath}/checkup/downform";
        let _jsonData = {
            name: 'moadata',
            url: 'www.moadata.co.kr'
        };

        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                let _data = this.response;
                let _blob = new Blob([_data], {type : 'text/csv'});
                let link = document.createElement('a');
                link.href = window.URL.createObjectURL(_blob);
                link.download = 'twalk_MultiDownData.csv';
                link.click();
            };
        };
        xhr.open('POST', _url);
        xhr.responseType = 'blob';
        xhr.setRequestHeader('Content-type', 'application/json');
        xhr.send(_jsonData);
    }

    function initDropzone() {
        if ($("#dropzone-file").length === 0) {
            console.warn("#dropzone-file 요소 없음. Dropzone 초기화 생략.");
            return;
        }

        // 이미 Dropzone이 초기화되어 있다면 중복 방지
        if (Dropzone.instances.length > 0) {
            Dropzone.instances.forEach(instance => instance.destroy());
        }

        dropzoneFile = new Dropzone("#dropzone-file",{
            url:'${contextPath}/checkup/getChckUpExcelImportMulti',
            maxFilesize:5000000,
            parallelUploads:2,          //한번에 올릴 파일 수
            //addRemoveLinks:  true,    //업로드 후 삭제 버튼
            timeout:300000,	            //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정해주자
            maxFiles:5,                 //업로드 할 최대 파일 수
            paramName:"file",           //파라미터로 넘길 변수명 default는 file
            acceptedFiles: ".csv,.CSV", // 허용 확장자
            autoQueue:true,	            //드래그 드랍 후 바로 서버로 전송
            createImageThumbnails:true,	//파일 업로드 썸네일 생성
            uploadMultiple:true,	    //멀티파일 업로드
            dictRemoveFile:'remove',    //삭제 버튼의 텍스트 설정
            //dictDefaultMessage:'PREVIEW', //미리보기 텍스트 설정
            accept:function(file,done){
                done();
            },
            init:function(){
                this.on('success',function(file,responseText) {
                    //제목의 길이 체크
                    console.log('responseText', responseText);
                    if (responseText.isError == true) {
                        $.alert(responseText.errorMessage);
                        if (this.getAcceptedFiles().length >= 1) {
                            let files = this.getAcceptedFiles();
                            this.removeFile(files[0]);
                        }
                    } else {
                        let rsize = responseText.resultList.size;
                        let tlen = responseText.resultList[0].length;
                        var resultData = responseText.resultList;

                        $('#checkupList').jqGrid("clearGridData");
                        $("#checkupList")[0].addJSONData(resultData);

                        if ($("#cb_checkupList").is(":checked")) {
                            //헤더 CheckBox에 체크가 되어 있으면 해제 후 다시 체크한다.
                            $("#cb_checkupList").trigger("click");
                        }
                    }
                });

                this.on("drop", function(e) {
                    if (this.getAcceptedFiles().length >= 1) {
                        let files = this.getAcceptedFiles();
                        this.removeFile(files[0]);
                    }
                });
            }
        });
    }

    $(document).ready(function() {
        initDropzone();
        fnInitGrid();
        selectMainMaxValue();
    })

    $(window).off("resize").on("resize", function () {
        $("#checkupList").jqGrid('setGridWidth', $(".table-wrap").width());
    });

    function fnInitGrid(){
        $('#checkupList').jqGrid({
            url : '${contextPath}/checkup/selectNoneCheckupList',
            mtype : "POST",
            datatype: "json",
            jsonReader : {repeatitems: false},
            postData: '',
            colModel : [
                { label: 'UID',                           name: 'userId',   width:250, sortable : false, cellattr:tmemo, edittype: "text"},
                { label: 'User Name',                     name: 'userNm',   width:150, sortable : true,  cellattr:tmemo, edittype: "text"},
                { label: 'Validation',                    name: 'valid',    width:80,  sortable : false, cellattr:tmemo, edittype: "text"},
                { label: 'Date of Birth',                 name: 'brthDt',   width:120, sortable : false, cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Checkup Date',                  name: 'chckDt',   width:150, sortable : false, cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Checkup Center',                name: 'chckHspt', width:150, sortable : true,  cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Doctor',                        name: 'chckDctr', width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Gender',                        name: 'gender',   width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Height(cm)',                    name: 'hght',     width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Weight(kg)',                    name: 'wght',     width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Waist circumference(cm)',       name: 'wst',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Systolic Blood Pressure(mmHg)', name: 'sbp',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Diastolic Blood Pressure(mmHg)',name: 'dbp',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Fasting Blood Sugar(mg/dL)',    name: 'fbs',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'HbA1C(%)',                      name: 'hba1c',    width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"}, //function () { return ' title="Here is my tooltip on colCell!"'; }},   //cellattr: function () { return ' title="Here is my tooltip on colCell!"'; }},
                { label: 'Total Cholesterol(mg/dL)',      name: 'tc',       width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'HDL(mg/dL)',                    name: 'hdl',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'LDL(mg/dL)',                    name: 'ldl',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Triglyceride(mg/dL)',           name: 'trgly',    width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Serum Creatinine(mg/dL)',       name: 'sc',       width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'GFR',                           name: 'gfr',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Uric Acid(mg/dL)',              name: 'urAcd',    width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'BUN(mg/dL)',                    name: 'bun',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'ALT(IU/L)',                     name: 'alt',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'ast: AST(IU/L)',                name: 'ast',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'γ-GTP(IU/L)',                   name: 'gtp',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Total Protein(g/dL)',           name: 'tprtn',    width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Bilirubin(g/dL)',               name: 'blrbn',    width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'ALP(IU/L)',                     name: 'alp',      width:100, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'comment',                       name: 'comment',  width:250, hidden : false,   cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Medical Checkup Type',          name: 'mct',      width:100, hidden : true,    cellattr:tmemo, editable: true, edittype: "text"},
                { label: 'Checkup result',                name: 'cr',       width:100, hidden : true,    cellattr:tmemo, editable: true, edittype: "text"}
            ],
            autowidth: true,
            shrinkToFit: false,
            multiselect: true,
            loadonce : false,
            viewrecords: true,
            rownumbers: true,
            cellEdit: true,
            loadComplete: function(data) {
            },ondblClickRow: function (rowid, iRow, iCol,e) {
                $('.popup-title').html("Modify Admin Account");
                const rowData = $("#checkupList").getRowData(rowid);
                var usrId = rowData.userId;
                //selectAdminRowId(usrId);
            },gridComplete : function(){ // 그리드가 완전히 모든 작업을 완료한 후 발생하는 이벤트
                $(this).jqGrid('setLabel', 'rn', 'No.');
                console.log("loadComplete");

                //전체 색상 초기화 필요!
                var ids = $("#checkupList").getDataIDs();
                // Grid Data Get!
                $.each(ids,function(idx, rowId){
                    rowData = $("#checkupList").getRowData(rowId);

                    var len = Object.keys(rowData).length;
                    for (var k = 0; k < len; k++) {
                        let keynm = Object.keys(rowData)[k];
                        let keyval  = Object.values(rowData)[k];
                        let gubun  = -1;
                        if (keynm.trim().indexOf("brthDt") >= 0 || keynm.trim().indexOf("chckDt") >= 0) {gubun = 0;} else {gubun = 1;}
                        validation(rowId, keynm, keyval, gubun);
                    }

                    var chkstatus = false;
                    for (var k = 0; k < len; k++) {
                        let keynm = Object.keys(rowData)[k];
                        let keyval  = Object.values(rowData)[k];
                        if (keynm.trim().indexOf("valid") < 0) {
                            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + keynm + "']");
                            if (cell && cell.hasClass('point-chart-08')) {
                                let validcell = $("#" + rowId + " td[aria-describedby='checkupList_valid']");
                                validcell.attr("title", "failed");
                                $('#checkupList').jqGrid('setCell', rowId, 'valid', 'failed');
                                $('#checkupList').jqGrid('setCell', rowId, 'valid', '', 'point-chart-08');
                                validcell.removeClass('point-chart-09');
                                chkstatus = true;
                                break;
                            }
                        }
                    }

                    if (chkstatus == false) {
                        let validcell = $("#" + rowId + " td[aria-describedby='checkupList_valid']");
                        $('#checkupList').jqGrid('setCell', rowId, 'valid', 'passed');
                        $('#checkupList').jqGrid('setCell', rowId, 'valid', '', 'point-chart-09');
                        validcell.removeClass('point-chart-08');
                    }
                });
            },afterSaveCell: function (rowId, cellName, value, indexRow, indexCol) {
                var gubun  = -1;
                if (cellName.trim().indexOf("brthDt") >= 0 || cellName.trim().indexOf("chckDt") >= 0) {gubun = 0;} else {gubun = 1;}
                validation(rowId, cellName, value, gubun);

                var rowData = $("#checkupList").jqGrid("getRowData", rowId);
                var len = Object.keys(rowData).length;
                var chkstatus = false;
                for (var k = 0; k < len; k++) {
                    let keynm = Object.keys(rowData)[k];
                    let keyval = Object.values(rowData)[k];
                    if (keynm.trim().indexOf("valid") < 0) {
                        let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + keynm + "']");
                        if (cell && cell.hasClass('point-chart-08')) {
                            let validcell = $("#" + rowId + " td[aria-describedby='checkupList_valid']");
                            validcell.attr("title", "failed");
                            $('#checkupList').jqGrid('setCell', rowId, 'valid', 'failed');
                            $('#checkupList').jqGrid('setCell', rowId, 'valid', '', 'point-chart-08');
                            validcell.removeClass('point-chart-09');
                            chkstatus = true;
                            break;
                        }
                    }
                }

                if (chkstatus == false) {
                    let validcell = $("#" + rowId + " td[aria-describedby='checkupList_valid']");
                    $('#checkupList').jqGrid('setCell', rowId, 'valid', 'passed');
                    $('#checkupList').jqGrid('setCell', rowId, 'valid', '', 'point-chart-09');
                    validcell.removeClass('point-chart-08');
                }

                var cellObj = new Object();
                cellObj.name = cellName;
                var $input = $("#" + rowId + " td[aria-describedby='checkupList_" + cellName + "']");

                var tstr = '';
                tstr = tmemo(rowId, value, null, cellObj);
                tstr = tstr.replace("title=\"", "");
                tstr = tstr.replace("\"", "");
                ($input).attr("title", tstr);

            }, beforeSaveCell: function (rowId, cellName, value, indexRow, indexCol) {
                console.log("value : " + value);
            }, onCellSelect: function(rowId, iCol, value, e) {
                console.log("이전 셀 정보 → rowId:", prevCell.rowId, "iCol:", prevCell.iCol);
                setTimeout(function() {
                    if (value.indexOf("<input type=") >= 0) {return;}
                    var colModel = $("#checkupList").jqGrid("getGridParam", "colModel");
                    var colName = colModel[iCol].name;
                    var $input = $("#" + rowId + " td[aria-describedby='checkupList_" + colName + "']");

                    // 현재 선택된 cell 값에 대한 tooltip 변경
                    var cellObj = new Object();
                    cellObj.name = colName;
                    var tstr = '';
                    tstr = tmemo(rowId, value, null, cellObj);
                    tstr = tstr.replace("title=\"", "");
                    tstr = tstr.replace("\"", "");
                    ($input).attr("title", tstr);

                    // 이전 선택되었던 cell 값에 대한 tooltip 변경
                    if ((prevCell.rowId != null && prevCell.iCol != null) && (prevCell.rowId !== rowId || prevCell.iCol !== iCol)) {
                        colName = colModel[prevCell.iCol].name;
                        var cell = $("#" + prevCell.rowId + " td[aria-describedby='checkupList_" + colName + "']");
                        cellObj.name = colName;
                        var prevValue = $("#checkupList").jqGrid("getCell", prevCell.rowId, colName);
                        if (prevValue.indexOf("<input type=") >= 0) {return;}
                        tstr = tmemo(prevCell.rowId, prevValue, null, cellObj);
                        tstr = tstr.replace("title=\"", "");
                        tstr = tstr.replace("\"", "");
                        cell.attr("title", tstr);
                        prevCell = {rowId: rowId, iCol: iCol};
                    } else if (prevCell.rowId == null || prevCell.iCol == null) {
                        prevCell = {rowId: rowId, iCol: iCol};
                    }
                }, 0);
            }
        })
    }

    function validation(rowId, nm, val, gubun){  //gubun : 0 date, gubun : 1 string

        if (validData == null || validData.length == 0) {
            selectMainMaxValue();
        }

        //Health Checkup Date Format check
        if (nm == 'chckDt' && !isValidDateDate(val)){
            $('#checkupList').jqGrid('setCell', rowId, 'chckDt', '', 'point-chart-08');
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            cell.removeClass('point-chart-09');
        } else if (nm == 'chckDt' && isValidDateDate(val)){
            $('#checkupList').jqGrid('setCell', rowId, 'chckDt', '', 'point-chart-09');
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            cell.removeClass('point-chart-08');
        }

        //Date Of Birth Format check
        if (nm == 'brthDt' && !isValidDateDate(val)){
            $('#checkupList').jqGrid('setCell', rowId, 'brthDt', '', 'point-chart-08');
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            cell.removeClass('point-chart-09');
        } else if (nm == 'brthDt' && isValidDateDate(val)){
            $('#checkupList').jqGrid('setCell', rowId, 'brthDt', '', 'point-chart-09');
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            cell.removeClass('point-chart-08');
        }

        // gender check
        if (nm == 'gender' && (val == null || (val != 'F' && val != 'M'))){
            $('#checkupList').jqGrid('setCell', rowId, 'gender', '', 'point-chart-08');
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            cell.removeClass('point-chart-09');
        } else if (nm == 'gender' && (val == 'F' || val == 'M')){
            $('#checkupList').jqGrid('setCell', rowId, 'gender', '', 'point-chart-09');
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            cell.removeClass('point-chart-08');
        }

        //Height validation
        if (gubun == 1 && nm == 'hght' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[0].valid_min) ||
                Number(val) > Number(validData[0].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'hght', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'hght', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Weight validation
        if (gubun == 1 && nm == 'wght' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[1].valid_min) ||
                Number(val) > Number(validData[1].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'wght', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'wght', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Waist Circumference validation
        if (gubun == 1 && nm == 'wst' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[2].valid_min) ||
                Number(val) > Number(validData[2].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'wst', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'wst', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Systolic Blood Pressure
        if (gubun == 1 && nm == 'sbp' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[3].valid_min) ||
                Number(val) > Number(validData[3].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'sbp', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'sbp', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Diastolic Blood Pressure
        if (gubun == 1 && nm == 'dbp' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[4].valid_min) ||
                Number(val) > Number(validData[4].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'dbp', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'dbp', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Fasting Blood Sugar
        if (gubun == 1 && nm == 'fbs' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[19].valid_min) ||
                Number(val) > Number(validData[19].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'fbs', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'fbs', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //HbA1C
        if (gubun == 1 && nm == 'hba1c' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[20].valid_min) ||
                Number(val) > Number(validData[20].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'hba1c', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'hba1c', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Total Cholesterol
        if (gubun == 1 && nm == 'tc' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[15].valid_min) ||
                Number(val) > Number(validData[15].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'tc', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'tc', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //HDL-C
        if (gubun == 1 && nm == 'hdl' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[16].valid_min) ||
                Number(val) > Number(validData[16].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'hdl', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'hdl', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //LDL-C
        if (gubun == 1 && nm == 'ldl' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[17].valid_min) ||
                Number(val) > Number(validData[17].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'ldl', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'ldl', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Triglyceride
        if (gubun == 1 && nm == 'trgly' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[18].valid_min) ||
                Number(val) > Number(validData[18].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'trgly', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'trgly', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Serum Creatinine
        if (gubun == 1 && nm == 'sc' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[5].valid_min) ||
                Number(val) > Number(validData[5].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'sc', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'sc', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //GFR (Glomerular Filtration Rate)
        if (gubun == 1 && nm == 'gfr' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[6].valid_min) ||
                Number(val) > Number(validData[6].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'gfr', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'gfr', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Uric Acid
        if (gubun == 1 && nm == 'urAcd' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[7].valid_min) ||
                Number(val) > Number(validData[7].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'urAcd', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'urAcd', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //BUN
        if (gubun == 1 && nm == 'bun' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[8].valid_min) ||
                Number(val) > Number(validData[8].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'bun', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'bun', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //ALT
        if (gubun == 1 && nm == 'alt' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[10].valid_min) ||
                Number(val) > Number(validData[10].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'alt', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'alt', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //AST
        if (gubun == 1 && nm == 'ast' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[9].valid_min) ||
                Number(val) > Number(validData[9].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'ast', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'ast', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //γ-GTP
        if (gubun == 1 && nm == 'gtp' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[11].valid_min) ||
                Number(val) > Number(validData[11].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'gtp', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'gtp', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Total Protein
        if (gubun == 1 && nm == 'tprtn' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[12].valid_min) ||
                Number(val) > Number(validData[12].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'tprtn', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'tprtn', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //Bilirubin
        if (gubun == 1 && nm == 'blrbn' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[13].valid_min) ||
                Number(val) > Number(validData[13].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'blrbn', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'blrbn', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }

        //ALP(Alkaline Phosphatase)
        if (gubun == 1 && nm == 'alp' && val != null && val != "") {
            let cell = $("#" + rowId + " td[aria-describedby='checkupList_" + nm + "']");
            if (Number(val) < Number(validData[14].valid_min) ||
                Number(val) > Number(validData[14].valid_max)) {
                $('#checkupList').jqGrid('setCell', rowId, 'alp', '', 'point-chart-08');
                cell.removeClass('point-chart-09');
            } else {
                $('#checkupList').jqGrid('setCell', rowId, 'alp', '', 'point-chart-09');
                cell.removeClass('point-chart-08');
            }
        }
        return true;
    }

    function isNum(value) {
        var pattern = /^[0-9]+$/g;
        return pattern.test(value);
    }

    function isValidDateDate(yyyymmdd) {
        var r = true;
        try {
            var date = [];
            if (yyyymmdd.length == 8) {
                if (isNum(yyyymmdd)) {
                    date[0] = yyyymmdd.substring(0, 4);
                    date[1] = yyyymmdd.substring(4, 6);
                    date[2] = yyyymmdd.substring(6, 8);
                } else {
                    r = false;
                }
            } else if (yyyymmdd.length > 8) {
                date = yyyymmdd.split("-");
            }

            if (date[0].length != 4 || date[1].length != 2 || date[2].length != 2) {r = false;  return r;}
            var yyyy = parseInt(date[0], 10);
            var mm = parseInt(date[1], 10);
            var dd = parseInt(date[2], 10);

            var dateRegex = /^(?=\d)(?:(?:31(?!.(?:0?[2469]|11))|(?:30|29)(?!.0?2)|29(?=.0?2.(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(?:\x20|$))|(?:2[0-8]|1\d|0?[1-9]))([-.\/])(?:1[012]|0?[1-9])\1(?:1[6-9]|[2-9]\d)?\d\d(?:(?=\x20\d)\x20|$))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
            r = dateRegex.test(dd + '-' + mm + '-' + yyyy);
        } catch (err) {
            r = false;
        }
        return r;
    }

    function tmemo(row_id, cellvalue, options, cellObj){
        var str     =  '';

        if (validData == null || validData.length == 0) {
            selectMainMaxValue();
        }

        if (cellObj.name == 'gender' && (cellvalue == null || (cellvalue != 'F' && cellvalue != 'M'))) {
            str = "Fail! ";
            str += "For Gender, Enter M for male and F for female.";
        }

        //Health Checkup Date Format check
        if (cellObj.name == 'chckDt' && !isValidDateDate(cellvalue)) {
            str = "Fail! ";
            str = str + "Health Checkup Date is invalid. Please input a valid date.(YYYY-MM-DD)";
        }

        //Date Of Birth Format check
        if (cellObj.name == 'brthDt' && !isValidDateDate(cellvalue)) {
            str = "Fail! ";
            str = str + "Date Of Birth is invalid. Please input a valid date.(YYYY-MM-DD)";
        }

        //Height validation
        if (cellObj.name == 'hght' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[0].valid_min) ||
                Number(cellvalue) > Number(validData[0].valid_max)) {
                str = memohtml('Fail', 'Height must be between', validData[0].valid_min, validData[0].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Weight validation
        if (cellObj.name == 'wght' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[1].valid_min) ||
                Number(cellvalue) > Number(validData[1].valid_max)) {
                str = memohtml('Fail', 'Weight must be between', validData[1].valid_min, validData[1].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Waist Circumference validation
        if (cellObj.name == 'wst' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[2].valid_min) ||
                Number(cellvalue) > Number(validData[2].valid_max)) {
                str = memohtml('Fail', 'Waist Circumference must be between', validData[2].valid_min, validData[2].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Systolic Blood Pressure
        if (cellObj.name == 'sbp' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[3].valid_min) ||
                Number(cellvalue) > Number(validData[3].valid_max)) {
                str = memohtml('Fail', 'Systolic Blood Pressure must be between', validData[3].valid_min, validData[3].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Diastolic Blood Pressure
        if (cellObj.name == 'dbp' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[4].valid_min) ||
                Number(cellvalue) > Number(validData[4].valid_max)) {
                str = memohtml('Fail', 'Diastolic Blood Pressure must be between', validData[4].valid_min, validData[4].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Fasting Blood Sugar
        if (cellObj.name == 'fbs' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[19].valid_min) ||
                Number(cellvalue) > Number(validData[19].valid_max)) {
                str = memohtml('Fail', 'Fasting Blood Sugar must be between', validData[19].valid_min, validData[19].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //HbA1C
        if (cellObj.name == 'hba1c' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[20].valid_min) ||
                Number(cellvalue) > Number(validData[20].valid_max)) {
                str = memohtml('Fail', 'HbA1C must be between', validData[20].valid_min, validData[20].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Total Cholesterol
        if (cellObj.name == 'tc' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[15].valid_min) ||
                Number(cellvalue) > Number(validData[15].valid_max)) {
                str = memohtml('Fail', 'Total Cholesterol must be between', validData[15].valid_min, validData[15].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //HDL-C
        if (cellObj.name == 'hdl' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[16].valid_min) ||
                Number(cellvalue) > Number(validData[16].valid_max)) {
                str = memohtml('Fail', 'HDL-C must be between', validData[16].valid_min, validData[16].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //LDL-C
        if (cellObj.name == 'ldl' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[17].valid_min) ||
                Number(cellvalue) > Number(validData[17].valid_max)) {
                str = memohtml('Fail', 'LDL-C must be between', validData[17].valid_min, validData[17].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Triglyceride
        if (cellObj.name == 'trgly' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[18].valid_min) ||
                Number(cellvalue) > Number(validData[18].valid_max)) {
                str = memohtml('Fail', 'Triglyceride must be between', validData[18].valid_min, validData[18].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Serum Creatinine
        if (cellObj.name == 'sc' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[5].valid_min) ||
                Number(cellvalue) > Number(validData[5].valid_max)) {
                str = memohtml('Fail', 'Serum Creatinine must be between', validData[5].valid_min, validData[5].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //GFR (Glomerular Filtration Rate)
        if (cellObj.name == 'gfr' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[6].valid_min) ||
                Number(cellvalue) > Number(validData[6].valid_max)) {
                str = memohtml('Fail', 'GFR must be between', validData[6].valid_min, validData[6].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Uric Acid
        if (cellObj.name == 'urAcd' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[7].valid_min) ||
                Number(cellvalue) > Number(validData[7].valid_max)) {
                str = memohtml('Fail', 'Uric Acid must be between', validData[7].valid_min, validData[7].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //BUN
        if (cellObj.name == 'bun' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[8].valid_min) ||
                Number(cellvalue) > Number(validData[8].valid_max)) {
                str = memohtml('Fail', 'BUN must be between', validData[8].valid_min, validData[8].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //ALT
        if (cellObj.name == 'alt' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[10].valid_min) ||
                Number(cellvalue) > Number(validData[10].valid_max)) {
                str = memohtml('Fail', 'ALT must be between', validData[10].valid_min, validData[10].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //AST
        if (cellObj.name == 'ast' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[9].valid_min) ||
                Number(cellvalue) > Number(validData[9].valid_max)) {
                str = memohtml('Fail', 'AST must be between', validData[9].valid_min, validData[9].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //γ-GTP
        if (cellObj.name == 'gtp' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[11].valid_min) ||
                Number(cellvalue) > Number(validData[11].valid_max)) {
                str = memohtml('Fail', 'γ-GTP must be between', validData[11].valid_min, validData[11].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Total Protein
        if (cellObj.name == 'tprtn' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[12].valid_min) ||
                Number(cellvalue) > Number(validData[12].valid_max)) {
                str = memohtml('Fail', 'Total Protein must be between', validData[12].valid_min, validData[12].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //Bilirubin
        if (cellObj.name == 'blrbn' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[13].valid_min) ||
                Number(cellvalue) > Number(validData[13].valid_max)) {
                str = memohtml('Fail', 'Bilirubin must be between', validData[13].valid_min, validData[13].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        //ALP(Alkaline Phosphatase)
        if (cellObj.name == 'alp' && cellvalue != null && cellvalue != ""){
            if (Number(cellvalue) < Number(validData[14].valid_min) ||
                Number(cellvalue) > Number(validData[14].valid_max)) {
                str = memohtml('Fail', 'ALP must be between', validData[14].valid_min, validData[14].valid_max);
            } else {
                //str = cellvalue;
            }
        }

        if (str == "") {str = cellvalue;}
        return 'title="'+str+'"';
    }

    function memohtml(t1, t2, t3, t4){
        var lstr = "";

        lstr = t1 + "! " + t2 + " " + t3 + " and " + t4 + ".";
        return lstr;
    }

    $(window).on('resize.jqGrid', function() {
        jQuery("#checkupList").jqGrid('setGridWidth', $(".table-wrap").width());
    })

    <!-- 달력 스크립트 -->
    // 달력 아이콘 클릭 시, date input 활성화
    function openCalendar(dateInputId) {
        document.getElementById(dateInputId).showPicker();
    }

    // 날짜 선택 시, 표시할 입력 필드 업데이트
    function updateDate(dateInputId, displayId) {
        const dateValue = document.getElementById(dateInputId).value;
        document.getElementById(displayId).value = dateValue;
    }

    $('.table-wrap .dropdown-content a').click(function(){
        let cnt = $(this).data('cnt');

        rowNumsVal = cnt;
        $('#gridDropdownBtn').text($(this).text());
        $("#checkupList").setGridParam({ rowNum: cnt });
        fnSearch();
    })

    $('.input-txt02').keyup(function(e){
        if(e.keyCode == '13'){
            fnSearch();
        }
    });
</script>