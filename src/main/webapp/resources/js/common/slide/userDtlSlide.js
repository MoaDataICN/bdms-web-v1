const userDtlSlide_messages = {
    f: "<spring:message code='common.sex.f'/>",
    m: "<spring:message code='common.sex.m'/>",
    active: "<spring:message code='common.active'/>",
    suspended: "<spring:message code='common.suspended'/>",
    readyToDelete: "<spring:message code='common.readyToDelete'/>",
    all: "<spring:message code='common.all'/>",
    select: "<spring:message code='common.select'/>"
};

// 우측에서 나타나는 슬라이드 팝업 열기
function openPopup() {
    // 다중 컨테이너 제거
    if ($('.slide-popup-container').length > 1) {
        console.warn('다중 slide-popup-container 발견하여 추가 컨테이너를 제거합니다.');
        $('.slide-popup-container').slice(1).remove();
    }
    // 컨테이너가 없으면 오류 로그 출력
    if ($('.slide-popup-container').length === 0) {
        console.error('slide-popup-container가 존재하지 않습니다. HTML 구조를 확인하세요.');
        return;  // 팝업 열기 중단
    }

    console.log('Slide containers in openPopup : ' + $('.slide-popup-container').length);

    $('#customerPopup').addClass('active');
    $('#slideOverlay').addClass('active');
    document.body.classList.add('no-scroll');
}

// 우측에서 나타나는 슬라이드 팝업 닫기
function closePopup() {
    $('#customerPopup').removeClass('active');
    $('#slideOverlay').removeClass('active');
    document.body.classList.remove('no-scroll');
}

// 반투명 오버레이, 팝업 내 닫기 버튼 클릭 시 슬라이드 닫기
$(document).on('click', '#slideOverlay, #closePopup', function () {
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
        $('.slide-popup-container').empty().html(html);

        if (tab === 'general') {
            general_readonly();
            extractUserDtlGeneralFromDOM("#customerPopup .slide-popup-container");
            updateDeletionDateInfo();
        } else if (tab === 'health-alerts') {
            drawHealthAlertsChart('all');
            initHealthAlertsGrid();
        } else if (tab === 'service-requests') {
            drawServiceRequestsChart('all');
            initServiceRequestsGrid();
        } else if (tab === 'input-checkup-data') {
            initDropzone();
            inputCheckup_fnClear();
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
    $('.slide-popup-container').attr('data-uid', userId);

    openPopup();
    loadUserDetailTab('general', userId);  // 기본 탭 로딩
});

$(document).on('click', '.second-tap-btn', function () {
    let userId = $('.slide-popup-container').data('uid');

    $('.second-tap-btn').removeClass('active');
    $(this).addClass('active');

    let tab = $(this).data('tab');  // 'health-alerts', 'service-requests' 등
    loadUserDetailTab(tab, userId);
});
