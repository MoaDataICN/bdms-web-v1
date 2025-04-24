<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 일반 팝업 Popup -->
<div class="popup-wrapper" id="chargeSearchOnSlideWrapper">
    <div class="popup-modal" id="chargeSearchOnSlidePopup">
        <div class="popup-show">
            <div class="popup-title mt-8px">
                <spring:message code='chargeSearchOnSlidePopup.title'/>
            </div>

            <!-- 닫기 버튼 -->
            <button class="popup-close" id="chargeSearchOnSlide_closeBtn">
                <img src="/resources/images/close-icon.svg" class="icon22">
            </button>

            <div class="popup-content mt-20px">
                <!-- 검색창 -->
                <div class="popup-search-bar d-flex">
                    <div class="row-input">
                        <input type="text" class="input-txt02 mr-12px" id="inchargeSearchOnSlideInput"
                               placeholder="<spring:message code='common.placeholder.pleaseEnter'/>">
                    </div>
                    <button type="button" id="chargeSearchOnSlideBtn" class="point-submit-btn">
                        <spring:message code='chargeSearchOnSlidePopup.btn.search'/>
                    </button>
                </div>

                <!-- 담당자 목록 -->
                <div class="popup-scroll-list">
                    <ul class="incharge-list">
                        <c:forEach var="item" items="${inChargeNmList}">
                            <li class="incharge-item" data-id="${item.inChargeId}" data-name="${item.inChargeNm}">
                                ${item.inChargeNm}
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="no-result-msg" style="display: none;">
                        No matching person in charge found.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 스타일 -->
<style>
    .popup-search-bar {
        display: flex;
        align-items: center;
    }

    .popup-search-bar .input-txt02 {
        flex: 1;
        min-width: 0;
    }

    .popup-search-bar .point-submit-btn {
        white-space: nowrap;
    }

    .popup-scroll-list {
        height: 300px;
        overflow-y: auto;
        margin: 16px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 10px;
        background-color: #fff;
        position: relative;
    }

    .incharge-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .incharge-item {
        padding: 10px 10px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .incharge-item:hover {
        background-color: #f0f0f0;
    }

    .no-result-msg {
        display: none;
        height: 100%;
        color: #999;
        font-size: 14px;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>

<!-- 스크립트 -->
<script type="text/javascript">
    // 항목 클릭 시 콘솔 출력
    $(document).on('click', '.incharge-item', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');

        console.log("✅ 선택된 담당자 ID:", id);
        console.log("✅ 선택된 담당자 이름:", name);

        const $dropdown = $('#general_inChargeNm');
        const $textNode = $dropdown.contents().filter(function () {
            return this.nodeType === 3; // 텍스트 노드만 필터링
        }).first();

        if ($textNode.length > 0) {
            $textNode[0].nodeValue = name + ' ';
        } else {
            $dropdown.prepend(document.createTextNode(name + ' '));
        }

        inChargeId = id;
        inChargeNm = name;

        general_checkDataChanged();
        closechargeSearchOnSlidePopup();
    });

    function closechargeSearchOnSlidePopup() {
        $('#chargeSearchOnSlidePopup').fadeOut();
        $(".charge-search-popup-general-container").empty();
    }

    // 닫기 버튼
    $(document).on('click', '#chargeSearchOnSlide_closeBtn', function () {
        closechargeSearchOnSlidePopup();
    });

    // 실시간 필터링 (결과 없을 경우 메시지 노출)
    $(document).on('input', '#inchargeSearchOnSlideInput', function () {
        const keyword = $(this).val().toLowerCase();
        let matchCount = 0;

        $('.incharge-item').each(function () {
            const rawName = $(this).data('name');
            const name = (rawName || '').toString().toLowerCase();
            const isMatch = name.includes(keyword);

            $(this).toggle(isMatch);
            if (isMatch) matchCount++;
        });

        if (matchCount === 0) {
            $('.incharge-list').hide();
            $('.no-result-msg').show();
        } else {
            $('.incharge-list').show();
            $('.no-result-msg').hide();
        }
    });

    // chargeSearchOnSlideBtn : 담당자 목록 갱신
    $(document).on('click', '#chargeSearchOnSlideBtn', function () {
        let inChargeNm = $('#inchargeSearchOnSlideInput').val().trim();

        fetch('/user/selectInChargeNmList', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ inChargeNm })
        })
        .then(response => {
            if (!response.ok) throw new Error('❌ Error : /user/selectInChargeNmList');
            return response.json();
        })
        .then(data => {
            const $list = $('.incharge-list');
            $list.empty();  // 이전 목록 삭제

            if (data && Array.isArray(data) && data.length > 0) {
                $('.no-result-msg').hide();
                $list.show();

                data.forEach(item => {
                    const $li = $('<li></li>')
                        .addClass('incharge-item')
                        .attr('data-id', item.inChargeId)
                        .attr('data-name', item.inChargeNm)
                        .text(item.inChargeNm);
                    $list.append($li);
                });
            } else {
                $list.hide();
                $('.no-result-msg').show();
            }
        })
        .catch(error => {
            $.confirm({
                title: 'Error',
                content: 'Failed to fetch the charge list.',
                type: 'red',
                typeAnimated: true,
                buttons: {
                    OK: {
                        btnClass: 'btn-red',
                        action: function(){ console.error(error); }
                    }
                }
            });
        });
    });
</script>