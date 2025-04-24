/**
 * 숫자 카운팅 애니메이션
 * @param {string} targetEl - ID selector (e.g. 'HA_total')
 * @param {number} val - 최종 숫자
 */
function calc(targetEl, val) {
    $({ val : 0 }).animate({ val : val }, {
        duration: 500,
        step: function() {
            const num = numberWithCommas(Math.floor(this.val));
            $("#" + targetEl).text(num);
        },
        complete: function() {
            const num = numberWithCommas(Math.floor(this.val));
            $("#" + targetEl).text(num);
        }
    });
}

/**
 * 숫자를 천단위 콤마로 포맷팅
 * @param {number|string} x
 * @returns {string}
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * 배열 합계
 * @param {number[]} arr
 * @returns {number}
 */
function summation(arr) {
    return arr.reduce((acc, cur) => acc + cur, 0);
}
