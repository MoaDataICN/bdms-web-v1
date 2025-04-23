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

</style>

<!-- 주요콘텐츠 영역-->
<main class="main">
    <!-- Area map 위치 텍스트 -->
    <div class="area-map active mr-4px">
        <a href="#">
            <img src="/resources/images/home-map.svg" class="icon14">
            <span>Home</span>
        </a>
        <a href="#">
            <img src="/resources/images/arrow-right-gray.svg" class="icon14">
            <span>user Management</span>
        </a>
    </div>
    <!-- 대시보드 타이틀 -->
    <div class="second-title">
        User detail
    </div>

    <div class="second-tap-menu mt-12px">
        <button type="button" class="second-tap-btn active">General</button>
        <button type="button" class="second-tap-btn">Health Alerts</button>
        <button type="button" class="second-tap-btn">Service Requests</button>
        <button type="button" class="second-tap-btn">Input Checkup Data</button>
        <button type="button" class="second-tap-btn">Checkup Results</button>
    </div>

    <div class="mt-16px table-data-wrap">
        <p class="second-title-status">(000001) Sara Woranㅣ1940-02-11ㅣFㅣ089-527-0101ㅣ123 Sukhumvit Road, Khlong
            Toei, Bangkok 10110, Thailand</p>
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
                    <!--<p class="drop-text02">OR</p>-->
                    <!--<input type="file" id="fileElem" style="display:none" onchange="handleFiles(this.files)">-->
                    <!--<button type="button" class="drag-btn mt-6px" onclick="document.getElementById('fileElem').click()">Browse File</button>-->
                </form>
            </div>
        </div>
    </div>

    <!-- 입력폼 그룹 -->
    <div class="second-container mt-18px">
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
                            1. Health Checkup Date
                        </div>
                        <div class="input-img-wrap">
                            <input type="text" class="input-txt02" placeholder="Health Checkup Date"
                                   oninput="limitLength(this, 30);" id="inputCheckup_chckDt">
                            <button type="button" class="input-text-del">
                                <img src="/resources/images/text-del-icon.svg" class="icon20">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="row-wrap02">
                    <div class="row-input f-x-c">
                        <div class="input-label03 mb-4px">
                            2. Date Of Birth
                        </div>
                        <div class="input-img-wrap">
                            <input type="text" class="input-txt02" placeholder="Date Of Birth"
                                   oninput="limitLength(this, 30);" id="inputCheckup_brthDt">
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
                            3. Gender
                        </div>
                        <div class="gender-btn-group">
                            <input type="hidden" id="inputCheckup_gender">
                            <button type="button" class="sex-btn">Male</button>
                            <button type="button" class="sex-btn-f">Female</button>
                        </div>
                    </div>
                </div>
                <div class="row-wrap02">
                    <div class="row-input f-x-c">
                        <div class="input-label03 mb-4px">
                            4.Height(cm)
                        </div>
                        <div class="input-img-wrap">
                            <input type="number" class="input-txt02" placeholder="cm"
                                   oninput="limitLength(this, 3);" id="inputCheckup_hght" min="100" max="250">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_wght" min="25" max="250">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_wst" min="40" max="150">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_sbp" min="50" max="250">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_dbp" min="30" max="150">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_fbs" min="40" max="500">
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
                                   oninput="limitLength(this, 2);" id="inputCheckup_hba1c" min="3" max="15">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_tc" min="50" max="500">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_hdl" min="5" max="150">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_ldl" min="10" max="300">
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
                                   oninput="limitLength(this, 4);" id="inputCheckup_trgly" min="20" max="1000">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_sc" min="0.1" max="30">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_gfr" min="0" max="150">
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
                                   oninput="limitLength(this, 2);" id="inputCheckup_urAcd" min="1" max="15">
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
                                   oninput="limitLength(this, 3);" id="inputCheckup_bun" min="1" max="300">
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
                                   oninput="limitLength(this, 4);" id="inputCheckup_alt" min="0" max="5000">
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
                                   oninput="limitLength(this, 4);" id="inputCheckup_ast" min="0" max="5000">
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
                                   oninput="limitLength(this, 4);" id="inputCheckup_gtp" min="0" max="5000">
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
                                   oninput="limitLength(this, 2);" id="inputCheckup_tprtn" min="3" max="12">
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
                                   oninput="limitLength(this, 2);" id="inputCheckup_blrbn" min="0" max="50">
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
                                   oninput="limitLength(this, 4);" id="inputCheckup_alp" min="10" max="2000">
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
                    <textarea class="input-area" id="inputCheckup_comment" placeholder="Input checkup comment。" oninput="limitLength(this, 1000);"></textarea>
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
</main>

<script type="text/javascript">
    function downform(){
        var _url = "${contextPath}/user/downform";
        var _jsonData = {
            name: 'moadata',
            url: 'www.moadata.co.kr'
        };

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var _data = this.response;
                var _blob = new Blob([_data], {type : 'text/csv'});

                var link = document.createElement('a');
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

    var dropzoneFile=new Dropzone("#dropzone-file",{
        url:'${contextPath}/user/getChckUpExcelImport',
        maxFilesize:5000000,
        parallelUploads:2,              //한번에 올릴 파일 수
        //addRemoveLinks:  true,        //업로드 후 삭제 버튼
        timeout:300000,	                //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정해주자
        maxFiles:5,                     //업로드 할 최대 파일 수
        paramName:"file",               //파라미터로 넘길 변수명 default는 file
        acceptedFiles: ".csv,.CSV",     //허용 확장자
        autoQueue:true,	                //드래그 드랍 후 바로 서버로 전송
        createImageThumbnails:true,	    //파일 업로드 썸네일 생성
        uploadMultiple:true,	        //멀티파일 업로드
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
                var tlen = responseText.resultList[0].length;
                var vlen = responseText.resultList[1].length;

                if (tlen == vlen){
                    for(var k = 0; k < vlen; k++){
                        var resval = responseText.resultList[0][k]+"";
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
                    var files = this.getAcceptedFiles();
                    this.removeFile(files[0]);
                }
            });
        }
    });

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
            userId     : 'user01',
            chckType   : $("#inputCheckup_chckType").val(),
            chckResult : $("#inputCheckup_chckResult").val(),
            chckCt     : $("#inputCheckup_chckCt").val(),
            chckDctr   : $("#inputCheckup_chckDctr").val(),
            chckDt : $("#inputCheckup_chckDt").val(),
            brthDt : $("#inputCheckup_brthDt").val(),
            gender : $("#inputCheckup_gender").val(),
            chckDt : $('#inputCheckup_chckDt').val(),
            brthDt : $('#inputCheckup_brthDt').val(),
            gender : $('#inputCheckup_gender').val(),
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
            comment: $('#inputCheckup_comment').val()
        };
    }

    var validData;
    $(document).ready(function() {
        inputCheckup_fnClear();

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
    })

    function validation(){
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

    $('.sex-btn-f').click(function(){
        if($(this).hasClass('active')){
            $(this).removeClass('active');
            $("#inputCheckup_gender").val('M');
            $('.sex-btn').addClass('active');
        } else {
            $(this).addClass('active');
            $("#inputCheckup_gender").val('F');
            $('.sex-btn').removeClass('active');
        }
    })

    $('.sex-btn').click(function(){
        if($(this).hasClass('active')){
            $(this).removeClass('active');
            $("#inputCheckup_gender").val('F');
            $('.sex-btn-f').addClass('active');
        } else {
            $(this).addClass('active');
            $("#inputCheckup_gender").val('M');
            $('.sex-btn-f').removeClass('active');
        }
    })
</script>