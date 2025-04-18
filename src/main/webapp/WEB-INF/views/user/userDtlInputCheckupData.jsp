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

<div class="second-tap-menu mt-12px">
    <button type="button" class="second-tap-btn" data-tab="general"><spring:message code='common.tapMenu.general'/></button>
    <button type="button" class="second-tap-btn" data-tab="health-alerts"><spring:message code='common.tapMenu.healthAlerts'/></button>
    <button type="button" class="second-tap-btn" data-tab="service-requests"><spring:message code='common.tapMenu.serviceRequests'/></button>
    <button type="button" class="second-tap-btn active" data-tab="input-checkup-data"><spring:message code='common.tapMenu.inputCheckupData'/></button>
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
                <input type="file" value="" id="file" name="file" multiple="true" style="width:0px;">
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
                               oninput="limitLength(this, 30);" id="chckCt">
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
                               oninput="limitLength(this, 30);" id="chckDctr">
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
                        <input type="text" class="input-txt02" placeholder="cm"
                               oninput="limitLength(this, 30);" id="inputCheckup_hght">
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
                        <input type="text" class="input-txt02" placeholder="kg"
                               oninput="limitLength(this, 30);" id="inputCheckup_wght">
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
                        <input type="text" class="input-txt02" placeholder="cm"
                               oninput="limitLength(this, 30);" id="inputCheckup_wst">
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
                        <input type="text" class="input-txt02" placeholder="mmHg"
                               oninput="limitLength(this, 30);" id="inputCheckup_sbp">
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
                        <input type="text" class="input-txt02" placeholder="mmHg"
                               oninput="limitLength(this, 30);" id="inputCheckup_dbp">
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
                        <input type="text" class="input-txt02" placeholder="mmHg"
                               oninput="limitLength(this, 30);" id="inputCheckup_fbs">
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
                        <input type="text" class="input-txt02" placeholder="%"
                               oninput="limitLength(this, 30);" id="inputCheckup_hba1c">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_tc">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_hdl">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_ldl">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_trgly">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_sc">
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
                        <input type="text" class="input-txt02" placeholder="ml"
                               oninput="limitLength(this, 30);" id="inputCheckup_gfr">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_urAcd">
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
                        <input type="text" class="input-txt02" placeholder="mg/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_bun">
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
                        <input type="text" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 30);" id="inputCheckup_alt">
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
                        <input type="text" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 30);" id="inputCheckup_ast">
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
                        <input type="text" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 30);" id="inputCheckup_gtp">
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
                        <input type="text" class="input-txt02" placeholder="g/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_tprtn">
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
                        <input type="text" class="input-txt02" placeholder="g/dL"
                               oninput="limitLength(this, 30);" id="inputCheckup_blrbn">
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
                        <input type="text" class="input-txt02" placeholder="IU/L"
                               oninput="limitLength(this, 30);" id="inputCheckup_alp">
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
