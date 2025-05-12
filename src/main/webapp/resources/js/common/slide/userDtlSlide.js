function disableTabFocus() {
    $('.search-container').find('input, button, a, textarea, select')
        .attr('tabindex', '-1');
}

function enableTabFocus() {
    $('.search-container').find('input, button, a, textarea, select')
        .removeAttr('tabindex');

    $('#userNm').attr('tabindex', '1').focus().blur();
    $('#emailId').attr('tabindex', '2');
    $('#mobile').attr('tabindex', '3');
    $('#brthDt').attr('tabindex', '4');
    $('#searchBgnDe').attr('tabindex', '5');
    $('#searchEndDe').attr('tabindex', '6');
}

// 우측에서 나타나는 슬라이드 팝업 열기
function openPopup() {
    // 다중 컨테이너 제거
    if ($('.userdtl-slide-popup-container').length > 1) {
        console.warn('다중 userdtl-slide-popup-container 발견하여 추가 컨테이너를 제거합니다.');
        $('.userdtl-slide-popup-container').slice(1).remove();
    }
    // 컨테이너가 없으면 오류 로그 출력
    if ($('.userdtl-slide-popup-container').length === 0) {
        console.error('userdtl-slide-popup-container가 존재하지 않습니다. HTML 구조를 확인하세요.');
        return;  // 팝업 열기 중단
    }

    console.log('Slide containers in openPopup : ' + $('.userdtl-slide-popup-container').length);

    $('#customerPopup').addClass('active');
    $('#slideOverlay').addClass('active');
    document.body.classList.add('no-scroll');
}

// 우측에서 나타나는 슬라이드 팝업 닫기
function closePopup() {
    $('.userdtl-slide-popup-container').empty();  // 내부 컨텐츠 제거
    $('#customerPopup').removeClass('active');
    $('#slideOverlay').removeClass('active');
    document.body.classList.remove('no-scroll');

    enableTabFocus();
}

// 반투명 오버레이, 팝업 내 닫기 버튼 클릭 시 슬라이드 닫기
$(document).on('click', '#slideOverlay, .closePopup', function () {
    // popup-modal이 떠 있을 경우에는 slideOverlay를 클릭해도 안 닫힘
    if ($('.popup-modal').is(':visible')) {
        return;
    }

    closePopup();
});

function loadUserDetailTab(tab = 'general', userId) {
    fetch("/user/detail/" + tab, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({ userId })
    })
    .then(response => {
        if (!response.ok) throw new Error('❌ Error : ' + tab);
        return response.text();
    })
    .then(html => {
        $('.userdtl-slide-popup-container').empty().html(html);

        if (tab === 'general') {
            general_readonly();
            extractUserDtlGeneralFromDOM("#customerPopup .userdtl-slide-popup-container");
            updateDeletionDateInfo();

            disableTabFocus();
            $("#general_brthDt").datepicker({
                dateFormat: 'yy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }).prop("disabled", true);
        } else if (tab === 'health-alerts') {
            drawHealthAlertsChart('all');
            initHealthAlertsGrid();
        } else if (tab === 'service-requests') {
            drawServiceRequestsChart('all');
            initServiceRequestsGrid();
        } else if (tab === 'input-checkup-data') {
            initDropzone();
            inputCheckup_fnClear();
        } else if (tab === 'checkup-result') {
            initcheckUpResultGrid();
        }
    })
    .catch(error => {
        $.confirm({
            title: 'Error',
            content: 'Failed to load tab content.',
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
}

$(document).on("click", ".detail-btn.open-slide-btn", function () {
    let userId = $(this).data("uid");
    $('.userdtl-slide-popup-container').attr('data-uid', userId);

    openPopup();
    loadUserDetailTab('general', userId);  // 기본 탭 로딩

   console.log("1 : " + userId);
});

$(document).on('click', '.second-tap-btn', function () {
    let userId = $('.userdtl-slide-popup-container').data('uid');

    $('.second-tap-btn').removeClass('active');
    $(this).addClass('active');

    let tab = $(this).data('tab');  // 'health-alerts', 'service-requests' 등
    loadUserDetailTab(tab, userId);

    console.log("2 : " + userId);
});
