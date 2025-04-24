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

function loadUserDetailTab(tab = 'general') {
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
        $('.slide-popup-container').html(html);

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
    userId = $(this).data("uid");

    openPopup();
    loadUserDetailTab('general');  // 기본 탭 로딩
});

$(document).on('click', '.second-tap-btn', function () {
    $('.second-tap-btn').removeClass('active');
    $(this).addClass('active');

    let tab = $(this).data('tab');  // 'health-alerts', 'service-requests' 등
    loadUserDetailTab(tab);
});
