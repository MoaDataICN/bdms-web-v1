<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="/resources/js/jquery-ui.js"></script>
<script src="/resources/js/dropzone-min.js"></script>

<link rel="stylesheet" href="/resources/css/dropzone.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/bdms_common.css">
<link rel="stylesheet" href="/resources/css/bdms_style.css">
<link rel="stylesheet" href="/resources/css/bdms_color.css">

<style>
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

    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
</style>

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn active" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
    <button type="button" class="second-tap-btn" data-tab="checkup-results"><spring:message code='common.tapMenu.checkupResults'/></button>
</div>

<div class="mt-16px table-data-wrap">
    <p class="second-title-status">(${userDtlGeneral.userId}) ${userDtlGeneral.userNm}ㅣ${userDtlGeneral.brthDt}ㅣ${userDtlGeneral.sx}ㅣ${userDtlGeneral.mobile}ㅣ${userDtlGeneral.addr}</p>
</div>

<!-- 주요 콘텐츠 시작 -->
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
                <!--  <p class="drop-text02">OR</p>  -->
                <!--  <input type="file" id="fileElem" style="display:none" onchange="handleFiles(this.files)">  -->
                <!--  <button type="button" class="drag-btn mt-6px" onclick="document.getElementById('fileElem').click()">Browse File</button>  -->
            </form>
        </div>
    </div>
</div>

<!-- 입력폼 그룹 -->
<div class="second-container mt-18px" id="inputCheckup_dataFields">
    <div class="content-row">
        <div class="second-title02">
            Input Checkup Information
        </div>

        <div class="row-md-100 mt-22px">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        1. Medical Checkup Type
                    </div>
                    <div class="input-img-wrap">
                        <input type="text" class="input-txt02" placeholder="Input Checkup Type"
                               oninput="limitLength(this, 30);" id="inputCheckup_chckType">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        2. Checkup result
                    </div>
                    <div class="input-img-wrap">
                        <input type="text" class="input-txt02" placeholder="Input Checkup result"
                               oninput="limitLength(this, 30);" id="inputCheckup_chckResult">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        3. Checkup center
                    </div>
                    <div class="input-img-wrap">
                        <input type="text" class="input-txt02" placeholder="Input Checkup center"
                               oninput="limitLength(this, 30);" id="inputCheckup_chckCt">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        4. Doctor
                    </div>
                    <div class="input-img-wrap">
                        <input type="text" class="input-txt02" placeholder="Input Doctor Name"
                               oninput="limitLength(this, 30);" id="inputCheckup_chckDctr">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="second-container mt-18px">
    <div class="content-row">
        <div class="second-title02">
            Input Checkup Data
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100 mt-22px">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        1. Health Checkup Date(YYYY-MM-DD)
                    </div>
                    <div class="p-r">
                        <input type="text" class="date-input input-txt02" id="inputCheckup_chckDt"
                               placeholder="Health Checkup Date" pattern="^[0-9_]" maxlength="10">
                        <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
                             onclick="openCalendar('chkup_datePicker1')" alt="달력 아이콘">
                        <input type="date" id="chkup_datePicker1" class="hidden-date"
                               onchange="updateDate('chkup_datePicker1', 'inputCheckup_chckDt')">
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        2. Date Of Birth(YYYY-MM-DD)
                    </div>
                    <div class="p-r">
                        <input type="text" class="date-input input-txt02" id="inputCheckup_brthDt"
                               placeholder="Date Of Birth" pattern="^[0-9_]" maxlength="10">
                        <img src="/resources/images/calendar-icon.svg" class="icon22 calendar-icon"
                             onclick="openCalendar('chkup_datePicker2')" alt="달력 아이콘">
                        <input type="date" id="chkup_datePicker2" class="hidden-date"
                               onchange="updateDate('chkup_datePicker2', 'inputCheckup_brthDt')">
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        3. Gender
                    </div>
                    <div class="gender-btn-group">
                        <input type="hidden" id="inputCheckup_gender">
                        <!--<button type="button" class="sex-btn active" >Male</button>-->
                        <button type="button" class="sex-btn">Male</button>
                        <button type="button" class="sex-btn-f">Female</button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        4. Height(cm)
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="cm"
                               oninput="limitLength(this, 3);" id="inputCheckup_hght">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        5. Weight(kg)
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="kg"
                               oninput="limitLength(this, 3);" id="inputCheckup_wght">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        6. Waist Circumference(cm)
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="cm"
                               oninput="limitLength(this, 3);" id="inputCheckup_wst">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        7. Systolic Blood Pressure
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mmHg"
                               oninput="limitLength(this, 3);" id="inputCheckup_sbp">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        8. Diastolic Blood Pressure
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mmHg"
                               oninput="limitLength(this, 3);" id="inputCheckup_dbp">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        9. Fasting Blood Sugar
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mmHg"
                               oninput="limitLength(this, 3);" id="inputCheckup_fbs">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        10. HbA1C
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="%"
                               oninput="limitLength(this, 2);" id="inputCheckup_hba1c">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        11. Total Cholesterol
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 3);" id="inputCheckup_tc">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        12. HDL-C
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 3);" id="inputCheckup_hdl">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        13. LDL-C
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 3);" id="inputCheckup_ldl">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        14. Triglyceride
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 4);" id="inputCheckup_trgly">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        15. Serum Creatinine
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 3);" id="inputCheckup_sc">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        16. GFR (Glomerular Filtration Rate)
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="ml"
                               oninput="limitLength(this, 3);" id="inputCheckup_gfr">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        17. Uric Acid
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 2);" id="inputCheckup_urAcd">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        18. BUN
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 3);" id="inputCheckup_bun">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        19. ALT
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 4);" id="inputCheckup_alt">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        20. AST
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 4);" id="inputCheckup_ast">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        21. γ-GTP
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 4);" id="inputCheckup_gtp">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        22. Total Protein
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="g/dL"
                               oninput="limitLength(this, 2);" id="inputCheckup_tprtn">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입력폼 그룹 -->
        <div class="row-md-100">
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        23. Bilirubin
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="g/dL"
                               oninput="limitLength(this, 2);" id="inputCheckup_blrbn">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="row-wrap02">
                <div class="row-input f-x-c">
                    <div class="input-label03 mb-4px">
                        24. ALP(Alkaline Phosphatase)
                    </div>
                    <div class="input-img-wrap">
                        <input type="number" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 4);" id="inputCheckup_alp">
                        <button type="button" class="input-text-del">
                            <img src="/resources/images/text-del-icon.svg" class="icon20">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row-col-100 mb-16px">
            <div class="input-label01 mb-4px">
                25. Comment
            </div>
            <div class="wrap-form">
                <textarea class="input-area" id="inputCheckup_comment" placeholder="Input checkup comment。"></textarea>
            </div>
        </div>
    </div>
</div>

<div class="content-submit-ui mt-22px">
    <div class="submit-ui-wrap">
    </div>
    <div class="submit-ui-wrap">
        <button type="button" class="gray-submit-btn" id="checkupreset">
            <img src="/resources/images/reset-icon.svg" class="icon22">
            <span>Reset</span>
        </button>

        <button type="button" class="point-submit-btn" id="checkupsave">
            <img src="/resources/images/save-icon.svg" class="icon22">
            <span>Save</span>
        </button>
    </div>
</div>

<div class="space-30"></div>

<script type="text/javascript">
    function downform(){
        let _url = "${contextPath}/user/downform";
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
                link.download = 'twalk_downData.csv';
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

        let dropzoneFile = new Dropzone("#dropzone-file",{
            url:'${contextPath}/user/getChckUpExcelImport',
            maxFilesize:5000000,
            parallelUploads:2,     //한번에 올릴 파일 수
            //addRemoveLinks:  true, //업로드 후 삭제 버튼
            timeout:300000,	     //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정해주자
            maxFiles:5,            //업로드 할 최대 파일 수
            paramName:"file",      //파라미터로 넘길 변수명 default는 file
            acceptedFiles: ".csv,.CSV",   // 허용 확장자
            autoQueue:true,	     //드래그 드랍 후 바로 서버로 전송
            createImageThumbnails:true,	//파일 업로드 썸네일 생성
            uploadMultiple:true,	 //멀티파일 업로드
            dictRemoveFile:'remove',	    //삭제 버튼의 텍스트 설정
            //dictDefaultMessage:'PREVIEW', //미리보기 텍스트 설정
            accept:function(file,done){
                done();
            },
            init:function(){
                this.on('success',function(file,responseText){
                    console.log("responseText Start : ");
                    console.log(responseText);
                    console.log("responseText End.");

                    //제목의 길이 체크
                    let tlen = responseText.resultList[0].length;
                    let vlen = responseText.resultList[1].length;

                    if (tlen == vlen){
                        for(let k = 0; k < vlen; k++){
                            let resval = responseText.resultList[0][k]+"";
                            if (resval.trim().indexOf("hght") >= 0){$("#inputCheckup_hght").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("wght") >= 0){$("#inputCheckup_wght").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("wst")>= 0){$("#inputCheckup_wst").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("sbp")>= 0){$("#inputCheckup_sbp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("dbp")>= 0){$("#inputCheckup_dbp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("fbs") >= 0){$("#inputCheckup_fbs").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("hba1c")>= 0){$("#inputCheckup_hba1c").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("tc") >= 0){$("#inputCheckup_tc").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("hdl") >= 0){$("#inputCheckup_hdl").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("ldl")>= 0){$("#inputCheckup_ldl").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("trgly")>= 0){$("#inputCheckup_trgly").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("sc")>= 0){$("#inputCheckup_sc").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("gfr") >= 0){$("#inputCheckup_gfr").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("urAcd")>= 0){$("#inputCheckup_urAcd").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("bun")>= 0){$("#inputCheckup_bun").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("alt") >= 0){$("#inputCheckup_alt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("ast")>= 0){$("#inputCheckup_ast").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("gtp") >= 0){$("#inputCheckup_gtp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("tprtn")>= 0){$("#inputCheckup_tprtn").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("blrbn")>= 0){$("#inputCheckup_blrbn").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("alp")>= 0){$("#inputCheckup_alp").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("comment")>= 0){$("#inputCheckup_comment").val(responseText.resultList[1][k])}
                            //기본정보
                            if (resval.trim().indexOf("Medical Checkup Type")>= 0){$("#inputCheckup_chckType").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Checkup result")>= 0){$("#inputCheckup_chckResult").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Checkup center")>= 0){$("#inputCheckup_chckCt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Doctor")>= 0){$("#inputCheckup_chckDctr").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Health Checkup Date")>= 0){$("#inputCheckup_chckDt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Date Of Birth")>= 0){$("#inputCheckup_brthDt").val(responseText.resultList[1][k])}
                            if (resval.trim().indexOf("Gender")>= 0){
                                $("#inputCheckup_gender").val(responseText.resultList[1][k])
                                if (responseText.resultList[1][k] == 'M'){
                                    $('.sex-btn-f').removeClass('active');
                                    $('.sex-btn').addClass('active');
                                } else {
                                    $('.sex-btn-f').addClass('active');
                                    $('.sex-btn').removeClass('active');
                                }
                            }
                        }
                    }
                });

                // Dropzone에 이미지가 추가되면 업로드 버튼 활성화
                this.on("addedfile", function () {
                });
                this.on("removedfile", function(file) {
                });
                this.on("complete", function(file) {
                });
                this.on("dragover", function(e) {
                });
                this.on("drop", function(e) {
                    console.log("count : " + this.getAcceptedFiles().length);
                    if (this.getAcceptedFiles().length >= 1) {
                        let files = this.getAcceptedFiles();
                        this.removeFile(files[0]);
                    }
                });
            }
        });
    }

    function inputCheckup_fnClear() {
        $("#inputCheckup_chckType").val(''); $("#inputCheckup_chckResult").val(''); $("#inputCheckup_chckDt").val(''); $("#inputCheckup_chckDctr").val('');
        $("#inputCheckup_brthDt").val('');   $("#inputCheckup_gender").val('');     $('#inputCheckup_chckDt').val(''); $('#inputCheckup_brthDt').val(''); $('#inputCheckup_chckCt').val('');
        $('#inputCheckup_hght').val('');     $('#inputCheckup_wght').val('');       $('#inputCheckup_wst').val('');    $('#inputCheckup_sbp').val('');    $('#inputCheckup_dbp').val('');
        $('#inputCheckup_fbs').val('');      $('#inputCheckup_hba1c').val('');      $('#inputCheckup_tc').val('');     $('#inputCheckup_hdl').val('');    $('#inputCheckup_ldl').val('');
        $('#inputCheckup_trgly').val('');    $('#inputCheckup_sc').val('');         $('#inputCheckup_gfr').val('');    $('#inputCheckup_urAcd').val('');  $('#inputCheckup_bun').val('');
        $('#inputCheckup_alt').val('');      $('#inputCheckup_ast').val('');        $('#inputCheckup_gtp').val('');    $('#inputCheckup_tprtn').val('');  $('#inputCheckup_blrbn').val('');
        $('#inputCheckup_alp').val('');      $('#inputCheckup_comment').val('');
        $('.sex-btn-f').removeClass('active');
        $('.sex-btn').removeClass('active');
    }

    function inputCheckup_setAddParam() {
        return {
            userId : userDtlGeneral.userId,
            chckType : $("#inputCheckup_chckType").val(),
            chckResult : $("#inputCheckup_chckResult").val(),
            chckCt : $("#inputCheckup_chckCt").val(),
            chckDctr : $("#inputCheckup_chckDctr").val(),
            chckDt : $("#inputCheckup_chckDt").val(),
            brthDt : $("#inputCheckup_brthDt").val(),
            gender : $("#inputCheckup_gender").val(),
            hght   : $('#inputCheckup_hght').val(),
            wght   : $('#inputCheckup_wght').val(),
            wst    : $('#inputCheckup_wst').val(),
            sbp    : $('#inputCheckup_sbp').val(),
            dbp    : $('#inputCheckup_dbp').val(),
            fbs    : $('#inputCheckup_fbs').val(),
            hba1c  : $('#inputCheckup_hba1c').val(),
            tc     : $('#inputCheckup_tc').val(),
            hdl    : $('#inputCheckup_hdl').val(),
            ldl    : $('#inputCheckup_ldl').val(),
            trgly  : $('#inputCheckup_trgly').val(),
            sc     : $('#inputCheckup_sc').val(),
            gfr    : $('#inputCheckup_gfr').val(),
            urAcd  : $('#inputCheckup_urAcd').val(),
            bun    : $('#inputCheckup_bun').val(),
            alt    : $('#inputCheckup_alt').val(),
            ast    : $('#inputCheckup_ast').val(),
            gtp    : $('#inputCheckup_gtp').val(),
            tprtn  : $('#inputCheckup_tprtn').val(),
            blrbn  : $('#inputCheckup_blrbn').val(),
            alp    : $('#inputCheckup_alp').val(),
            comment: $('#inputCheckup_comment').val(),
            locale: '<c:out value="${pageContext.request.locale.language}"/>'
        };
    }

    var validData;

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

    $(document).ready(function() {
        inputCheckup_fnClear();
        selectMainMaxValue();
    })

    function validation(){

        if (validData == null || validData.length == 0) {
            selectMainMaxValue();
        }
        //DATE Format check
        if (!isValidDateDate($('#inputCheckup_chckDt').val())){
            $.alert("Health Checkup Date is invalid. Please input a valid date.(YYYY-MM-DD)");
            return false;
        }

        if (!isValidDateDate($('#inputCheckup_brthDt').val())){
            $.alert("Date Of Birth is invalid. Please input a valid date.(YYYY-MM-DD)");
            return false;
        }

        if(!$(".sex-btn-f").hasClass('active') && !$(".sex-btn").hasClass('active')){
            $.alert("Choice Gender type");
            return false;
        }

        //Height validation
        if ($('#inputCheckup_hght').val() != null && $('#inputCheckup_hght').val() != "") {
            if (Number($('#inputCheckup_hght').val()) < Number(validData[0].valid_min) ||
                Number($('#inputCheckup_hght').val()) > Number(validData[0].valid_max)) {
                $.alert("Height must be between " + validData[0].valid_min + " and " + validData[0].valid_max + ".");
                return false;
            }
        }

        //Weight validation
        if ($('#inputCheckup_wght').val() != null && $('#inputCheckup_wght').val() != "") {
            if (Number($('#inputCheckup_wght').val()) < Number(validData[1].valid_min) ||
                Number($('#inputCheckup_wght').val()) > Number(validData[1].valid_max)) {
                $.alert("Weight must be between " + validData[1].valid_min + " and " + validData[1].valid_max + ".");
                return false;
            }
        }

        //Waist Circumference validation
        if ($('#inputCheckup_wst').val() != null && $('#inputCheckup_wst').val() != "") {
            if (Number($('#inputCheckup_wst').val()) < Number(validData[2].valid_min) ||
                Number($('#inputCheckup_wst').val()) > Number(validData[2].valid_max)) {
                $.alert("Waist Circumference must be between " + validData[2].valid_min + " and " + validData[2].valid_max + ".");
                return false;
            }
        }

        //Systolic Blood Pressure
        if ($('#inputCheckup_sbp').val() != null && $('#inputCheckup_sbp').val() != "") {
            if (Number($('#inputCheckup_sbp').val()) < Number(validData[3].valid_min) ||
                Number($('#inputCheckup_sbp').val()) > Number(validData[3].valid_max)) {
                $.alert("Systolic Blood Pressure must be between " + validData[3].valid_min + " and " + validData[3].valid_max + ".");
                return false;
            }
        }

        //Diastolic Blood Pressure
        if ($('#inputCheckup_dbp').val() != null && $('#inputCheckup_dbp').val() != "") {
            if (Number($('#inputCheckup_dbp').val()) < Number(validData[4].valid_min) ||
                Number($('#inputCheckup_dbp').val()) > Number(validData[4].valid_max)) {
                $.alert("Diastolic Blood Pressure must be between " + validData[4].valid_min + " and " + validData[4].valid_max + ".");
                return false;
            }
        }

        //Fasting Blood Sugar
        if ($('#inputCheckup_fbs').val() != null && $('#inputCheckup_fbs').val() != "") {
            if (Number($('#inputCheckup_fbs').val()) < Number(validData[19].valid_min) ||
                Number($('#inputCheckup_fbs').val()) > Number(validData[19].valid_max)) {
                $.alert("Fasting Blood Sugar must be between " + validData[19].valid_min + " and " + validData[19].valid_max + ".");
                return false;
            }
        }

        //HbA1C
        if ($('#inputCheckup_hba1c').val() != null && $('#inputCheckup_hba1c').val() != "") {
            if (Number($('#inputCheckup_hba1c').val()) < Number(validData[20].valid_min) ||
                Number($('#inputCheckup_hba1c').val()) > Number(validData[20].valid_max)) {
                $.alert("HbA1C must be between " + validData[20].valid_min + " and " + validData[20].valid_max + ".");
                return false;
            }
        }

        //Total Cholesterol
        if ($('#inputCheckup_tc').val() != null && $('#inputCheckup_tc').val() != "") {
            if (Number($('#inputCheckup_tc').val()) < Number(validData[15].valid_min) ||
                Number($('#inputCheckup_tc').val()) > Number(validData[15].valid_max)) {
                $.alert("Total Cholesterol must be between " + validData[15].valid_min + " and " + validData[15].valid_max + ".");
                return false;
            }
        }

        //HDL-C
        if ($('#inputCheckup_hdl').val() != null && $('#inputCheckup_hdl').val() != "") {
            if (Number($('#inputCheckup_hdl').val()) < Number(validData[16].valid_min) ||
                Number($('#inputCheckup_hdl').val()) > Number(validData[16].valid_max)) {
                $.alert("HDL-C must be between " + validData[16].valid_min + " and " + validData[16].valid_max + ".");
                return false;
            }
        }

        //LDL-C
        if ($('#inputCheckup_ldl').val() != null && $('#inputCheckup_ldl').val() != "") {
            if (Number($('#inputCheckup_ldl').val()) < Number(validData[17].valid_min) ||
                Number($('#inputCheckup_ldl').val()) > Number(validData[17].valid_max)) {
                $.alert("LDL-C must be between " + validData[17].valid_min + " and " + validData[17].valid_max + ".");
                return false;
            }
        }

        //Triglyceride
        if ($('#inputCheckup_trgly').val() != null && $('#inputCheckup_trgly').val() != "") {
            if (Number($('#inputCheckup_trgly').val()) < Number(validData[18].valid_min) ||
                Number($('#inputCheckup_trgly').val()) > Number(validData[18].valid_max)) {
                $.alert("Triglyceride must be between " + validData[18].valid_min + " and " + validData[18].valid_max + ".");
                return false;
            }
        }

        //Serum Creatinine
        if ($('#inputCheckup_sc').val() != null && $('#inputCheckup_sc').val() != "") {
            if (Number($('#inputCheckup_sc').val()) < Number(validData[5].valid_min) ||
                Number($('#inputCheckup_sc').val()) > Number(validData[5].valid_max)) {
                $.alert("Serum Creatinine must be between " + validData[5].valid_min + " and " + validData[5].valid_max + ".");
                return false;
            }
        }

        //GFR (Glomerular Filtration Rate)
        if ($('#inputCheckup_gfr').val() != null && $('#inputCheckup_gfr').val() != "") {
            if (Number($('#inputCheckup_gfr').val()) < Number(validData[6].valid_min) ||
                Number($('#inputCheckup_gfr').val()) > Number(validData[6].valid_max)) {
                $.alert("GFR(Glomerular Filtration Rate) must be between " + validData[6].valid_min + " and " + validData[6].valid_max + ".");
                return false;
            }
        }

        //Uric Acid
        if ($('#inputCheckup_urAcd').val() != null && $('#inputCheckup_urAcd').val() != "") {
            if (Number($('#inputCheckup_urAcd').val()) < Number(validData[7].valid_min) ||
                Number($('#inputCheckup_urAcd').val()) > Number(validData[7].valid_max)) {
                $.alert("Uric Acid must be between " + validData[7].valid_min + " and " + validData[7].valid_max + ".");
                return false;
            }
        }

        //BUN
        if ($('#inputCheckup_bun').val() != null && $('#inputCheckup_bun').val() != "") {
            if (Number($('#inputCheckup_bun').val()) < Number(validData[8].valid_min) ||
                Number($('#inputCheckup_bun').val()) > Number(validData[8].valid_max)) {
                $.alert("BUN must be between " + validData[8].valid_min + " and " + validData[8].valid_max + ".");
                return false;
            }
        }

        //ALT
        if ($('#inputCheckup_alt').val() != null && $('#inputCheckup_alt').val() != "") {
            if (Number($('#inputCheckup_alt').val()) < Number(validData[10].valid_min) ||
                Number($('#inputCheckup_alt').val()) > Number(validData[10].valid_max)) {
                $.alert("ALT must be between " + validData[10].valid_min + " and " + validData[10].valid_max + ".");
                return false;
            }
        }

        //AST
        if ($('#inputCheckup_ast').val() != null && $('#inputCheckup_ast').val() != "") {
            if (Number($('#inputCheckup_ast').val()) < Number(validData[9].valid_min) ||
                Number($('#inputCheckup_ast').val()) > Number(validData[9].valid_max)) {
                $.alert("AST must be between " + validData[9].valid_min + " and " + validData[9].valid_max + ".");
                return false;
            }
        }

        //γ-GTP
        if ($('#inputCheckup_gtp').val() != null && $('#inputCheckup_gtp').val() != "") {
            if (Number($('#inputCheckup_gtp').val()) < Number(validData[11].valid_min) ||
                Number($('#inputCheckup_gtp').val()) > Number(validData[11].valid_max)) {
                $.alert("γ-GTP must be between " + validData[11].valid_min + " and " + validData[11].valid_max + ".");
                return false;
            }
        }

        //Total Protein
        if ($('#inputCheckup_tprtn').val() != null && $('#inputCheckup_tprtn').val() != "") {
            if (Number($('#inputCheckup_tprtn').val()) < Number(validData[12].valid_min) ||
                Number($('#inputCheckup_tprtn').val()) > Number(validData[12].valid_max)) {
                $.alert("Total Protein must be between " + validData[12].valid_min + " and " + validData[12].valid_max + ".");
                return false;
            }
        }

        //Bilirubin
        if ($('#inputCheckup_blrbn').val() != null && $('#inputCheckup_blrbn').val() != "") {
            if (Number($('#inputCheckup_blrbn').val()) < Number(validData[13].valid_min) ||
                Number($('#inputCheckup_blrbn').val()) > Number(validData[13].valid_max)) {
                $.alert("Bilirubin must be between " + validData[13].valid_min + " and " + validData[13].valid_max + ".");
                return false;
            }
        }

        //ALP(Alkaline Phosphatase)
        if ($('#inputCheckup_alp').val() != null && $('#inputCheckup_alp').val() != "") {
            if (Number($('#inputCheckup_alp').val()) < Number(validData[14].valid_min) ||
                Number($('#inputCheckup_alp').val()) > Number(validData[14].valid_max)) {
                $.alert("ALP(Alkaline Phosphatase) must be between " + validData[14].valid_min + " and " + validData[14].valid_max + ".");
                return false;
            }
        }
        return true;
    }

    $(document).on('click','#checkupreset', function(){
        inputCheckup_fnClear();
    });

    $(document).on('click','#checkupsave', function(){
        $.confirm({
            title: '',
            content: 'Would you like to save an checkup data?',
            buttons: {
                OK: function () {
                    if (validation()) {
                        $.ajax({
                            type: 'POST',
                            url: '${contextPath}/user/checkupAdd',
                            data: inputCheckup_setAddParam(),
                            dataType: 'json',
                            success: function(data) {
                                if(data.isError){
                                    $.alert(data.message);
                                    console.log('ERROR', data.message);
                                }else{
                                    inputCheckup_fnClear();
                                    $.alert(data.message);
                                }
                            }
                        });
                    }
                },
                Cancel: function () {
                }
            }
        });
    });

    $(document).on('click', '.sex-btn-f', function() {
        if($(this).hasClass('active')){
            $(this).removeClass('active');
            $("#inputCheckup_gender").val('M');
            $('.sex-btn').addClass('active');
        } else {
            $(this).addClass('active');
            $("#inputCheckup_gender").val('F');
            $('.sex-btn').removeClass('active');
        }
    });

    $(document).on('click', '.sex-btn', function() {
        if($(this).hasClass('active')){
            $(this).removeClass('active');
            $("#inputCheckup_gender").val('F');
            $('.sex-btn-f').addClass('active');
        } else {
            $(this).addClass('active');
            $("#inputCheckup_gender").val('M');
            $('.sex-btn-f').removeClass('active');
        }
    });

    // 날짜 선택 시, 표시할 입력 필드 업데이트
    function updateDate(dateInputId, displayId) {
        const dateValue = document.getElementById(dateInputId).value;
        document.getElementById(displayId).value = dateValue;
    }

    // 달력 아이콘 클릭 시, date input 활성화
    function openCalendar(dateInputId) {
        document.getElementById(dateInputId).showPicker();
    }

    function isValidDateDate(yyyymmdd) {
        var r = true;

        try {
            var date = [];
            if (yyyymmdd.length == 8) {
                date[0] = yyyymmdd.substring(0, 4);
                date[1] = yyyymmdd.substring(4, 6);
                date[2] = yyyymmdd.substring(6, 8);
            } else if (yyyymmdd.length > 8) {
                date = yyyymmdd.split("-");
            }
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
</script>
