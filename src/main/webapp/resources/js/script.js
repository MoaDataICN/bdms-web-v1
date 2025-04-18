function limitLength(element, maxLength) {
    if (element.value.length > maxLength) {
        element.value = element.value.slice(0, maxLength); // 길이 제한 초과 시 잘라내기
    }
}

function showToast(message, type, duration = 3000) {

    const $toast = $(`<div class="push-wrap"><div class="push-message `+type+`">`+message+`</div>`)

    // main 영역이나 body에 추가
    $('main').append($toast);

    // 브라우저 렌더링 이후 슬라이드 효과 적용
    setTimeout(() => {
        $toast.addClass('show');
    }, 10); // 약간의 딜레이로 transition 동작 유도

    // duration 이후 자동 제거
    setTimeout(() => {
        $toast.removeClass('show');
        setTimeout(() => $toast.remove(), 400); // transition 끝나고 제거
    }, duration);
}