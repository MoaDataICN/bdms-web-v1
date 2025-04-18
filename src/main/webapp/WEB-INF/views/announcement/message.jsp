<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="../../resources/js/grid/pager.js"></script>

<style>
    .editable {
        max-width: 100%;
        -webkit-appearance: none;
        writing-mode: horizontal-tb !important;
        padding-block: 1px;
        padding-inline: 8px;
        box-sizing: border-box;
        padding-inline-end: 0;
        line-height: 3rem;
        display:flex;
    }

    [contenteditable="true"]:empty:before {
        content: attr(placeholder);
    }

    .pasteItem {
        padding: 0 10px;
        border: 1px solid #d5d5d5;
        margin: 0 5px;
        border-radius: 12px;
    }

    .pasteItem.admin {
        background: rgba(0, 255, 0, 0.1);
    }

    .pasteItem.user {
        background-color: rgba(255, 0, 0, 0.1);
    }

</style>

<main class="main">
    <!-- 대시보드 타이틀 -->
    <div class="second-title">
        <spring:message code="announcement.message"/>
    </div>

    <!-- 주요 콘텐츠 시작 -->
    <div class="second-container mt-18px">
        <div class="content-row">
            <!-- 좌측 입력폼 그룹 -->
            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="announcement.message.channel"/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02 hold" value="PUSH" readonly>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="announcement.message.channel"/>
                    </div>
                    <div class="dropdown">
                        <input type="hidden" id="tgTp" value="2">
                        <button class="dropdown-search" id="tgTpBtn"><spring:message code="announcement.message.tp2"/><span><img class="icon20" alt=""
                                                                                                              src="/resources/images/arrow-gray-bottom.svg"></span></button>
                        <div class="dropdown-content">
                            <a data-tp="0" onclick="changeTarget(this)"><spring:message code="announcement.message.tp0"/></a>
                            <a data-tp="1" onclick="changeTarget(this)"><spring:message code="announcement.message.tp1"/></a>
                            <a data-tp="2" onclick="changeTarget(this)"><spring:message code="announcement.message.tp2"/></a>
                            <a data-tp="3" onclick="changeTarget(this)"><spring:message code="announcement.message.tp3"/></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.group"/>
                    </div>
                    <div class="dropdown">
                        <button class="dropdown-search" id="grpTp">All<span><img class="icon20" alt=""
                                                                                               src="/resources/images/arrow-gray-bottom.svg"></span></button>
                        <div class="dropdown-content">
                            <a onclick="$('#grpTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.all"/></a>
                            <a onclick="$('#grpTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.group.A"/></a>
                            <a onclick="$('#grpTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.group.B"/></a>
                            <a onclick="$('#grpTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(this).text())"><spring:message code="common.group.C"/></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.recipient"/>
                    </div>
                    <div class="row-input">
                        <div class="input-txt02 hold editable" id="rcpt" value="" readonly style="max-width: 100%;"><spring:message code="announcement.message.selectInfo"/></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="second-container mt-36px">
        <div class="content-row">
            <div class="row-md-100">
                <div class="row-wrap">
                    <div class="input-label01">
                        <spring:message code="common.title"/>
                    </div>
                    <div class="row-input">
                        <input type="text" class="input-txt02" id="title" value="" style="max-width: 100%;">
                    </div>
                </div>
            </div>

            <div class="row-md-100 mt-24px">
                <div class="input-label01">
                    <spring:message code="common.message"/>
                </div>
                <div class="wrap-form">
                                    <textarea class="input-area" id="cont"
                                              placeholder="Please enter a message." style="height: 240px;"></textarea>
                </div>
            </div>
        </div>


    </div>
    <div class="content-submit-ui mt-22px">
        <div class="submit-ui-wrap">
        </div>
        <div class="submit-ui-wrap">
            <button type="button" class="gray-submit-btn">
                <span><spring:message code="common.btn.reset"/></span>
            </button>

            <button type="button" class="point-submit-btn" onclick="sendMessage()">
                <span><spring:message code="common.btn.send"/></span>
            </button>
        </div>
    </div>
    <!-- 스페이스 빈공간 -->
    <div class="space-20"></div>
</main>

<script>
    const message = {
        specificInput : "<spring:message code='announcement.message.specificInput'/>",
        selectInfo : "<spring:message code='announcement.message.selectInfo'/>",
        messageSend : "<spring:message code='toast.messageSend'/>",
        failed : "<spring:message code='toast.failed'/>",
        selectTp : "<spring:message code='announcement.message.tp2'/>",
        all : "<spring:message code='common.all'/>",
    }
</script>

<script>
    function changeTarget(target) {
        $('#tgTpBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith($(target).text());

        var tp = $(target).data('tp');
        $('#tgTp').val(tp);

        console.log(tp);
        if(tp === 3) {
            $('#rcpt').removeClass('hold');
            $('#rcpt').attr('contenteditable', true);
            $('#rcpt').text('')
            $('#rcpt').attr('placeholder', message.specificInput)
        } else {
            $('#rcpt').addClass('hold');
            $('#rcpt').attr('contenteditable', false)
            $('#rcpt').text(message.selectInfo)
        }
    }

    const input = document.getElementById('rcpt');

    input.addEventListener('keydown', (e) => {
        if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'v') {
            return;
        } else {
            e.preventDefault();
        }
        e.preventDefault();
    });

    input.addEventListener('drop', (e) => {
        e.preventDefault();
    });

    input.addEventListener('input', (e) => {
        e.preventDefault();
        console.log(e);
    });

    input.addEventListener('paste', (e) => {
        const pasteData = e.clipboardData.getData('text');

        // 정규식 -> 걸리는 케이스는 사용자로 판단
        const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

        // paste 문자열 변환
        const items = pasteData.split(",").map(item => item.trim());

        const userIds = [];
        const adminIds = [];

        items.forEach(item => {
            if (uuidRegex.test(item)) {
                userIds.push(item);
            } else {
                adminIds.push(item);
            }
        });

        var param = {"userList" : userIds, "adminList" : adminIds};

        $.ajax({
            type: 'POST',
            url: '/api/getNamesByIds',
            data: JSON.stringify(param),
            contentType: 'application/json; charset=utf-8',
            datatype: 'json',
            success: function (data) {
                console.log(data);
                data.adminList.forEach((item, index, arr2) => {
                    if(item != null && item.userId != null && item.userId != "") {
                        var pasteItem = `<div data-id="`+item.userId+`" class="pasteItem admin" contenteditable="false">`+item.userNm+`<button type=button class="removeBtn"><img src="/resources/images/close-icon.svg" style="width:12px; height:12px; margin-left:4px;"></button></div>`
                        $(input).append(pasteItem);
                    }
                })

                data.userList.forEach((item, index, arr2) => {
                    if(item != null && item.userId != null && item.userId != '') {
                        var pasteItem = `<div data-id="`+item.userId+`" class="pasteItem user" contenteditable="false">`+item.userNm+`<button type=button class="removeBtn"><img src="/resources/images/close-icon.svg" style="width:12px; height:12px; margin-left:4px;"></button></div>`
                        $(input).append(pasteItem);
                    }
                })
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
            }
        });

        e.preventDefault();
        // //input.value = pasteData;
        //
        // adminIds.forEach((item,index,arr2) => {
        //     var pasteItem = `<div data-id="`+item+`" class="pasteItem admin" contenteditable="false">`+item+`<button type=button class="removeBtn"><img src="/resources/images/close-icon.svg" style="width:12px; height:12px; margin-left:4px;"></button></div>`
        //     $(input).append(pasteItem);
        // })
        //
        // userIds.forEach((item,index,arr2) => {
        //     var pasteItem = `<div data-id="`+item+`" class="pasteItem user" contenteditable="false">`+item+`<button type=button class="removeBtn"><img src="/resources/images/close-icon.svg" style="width:12px; height:12px; margin-left:4px;"></button></div>`
        //     $(input).append(pasteItem);
        // })
    });

    $(document).on('click', '.removeBtn', function(){
        $(this.parentNode).remove();
    })


    function sendMessage() {
        let adminIds;
        let userIds;
        let allIds;
        if($('#tgTp').val() === '3') {
            adminIds = $('.pasteItem.admin').map(function() {
                return $(this).data('id');
            }).get();

            userIds = $('.pasteItem.user').map(function() {
                return $(this).data('id');
            }).get();

            allIds = [...adminIds, ...userIds].join(', ');
        }
        const userId = '${sessionScope.user.userId}';

        let param = {'sndId':userId,'tgTp' : $('#tgTp').val(), 'grpNm' : $('#grpTp').text(), 'rcpt' : allIds, 'title' : $('#title').val(), 'cont' : $('#cont').val(), 'adminList' : adminIds, 'userList' : userIds}

        $.ajax({
            type: 'POST',
            url: '/announcement/sendMessage',
            data: param,
            datatype: 'json',
            success: function (data) {
                console.log(data);
                if(!data.isError) {
                    showToast(message.messageSend)
                    clear();
                } else {
                    showToast(message.failed, 'point')
                }

            },
            error: function (request, status, error) {
                showToast(message.failed, 'point')
                console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
            }
        });
    }

    function clear() {
        $('#rcpt').empty();
        $('#rcpt').text(message.selectInfo);
        $('#tgTp').val('2');
        $('#tgTpBtn').contents().filter(function() {return this.nodeType === 3}).first().replaceWith(message.selectTp);
        $('#grpTp').contents().filter(function() {return this.nodeType === 3}).first().replaceWith(message.all);


        $('#title').val('');
        $('#cont').val('');
    }
</script>