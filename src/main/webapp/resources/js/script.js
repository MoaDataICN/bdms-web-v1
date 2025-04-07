function limitLength(element, maxLength) {
    if (element.value.length > maxLength) {
        element.value = element.value.slice(0, maxLength); // 길이 제한 초과 시 잘라내기
    }
}