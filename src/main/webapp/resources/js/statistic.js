<!-- 차트 색상 셋 -->
const colorSet = ['#7cdad8',
    '#f79194',
    '#faa871',
    '#FED877',
    '#eba066',
    '#CBDEA6',
    '#87a7ff'];

<!-- 현재 클릭한 탭 설정 -->
let tabType = null;

<!-- Init Chart-->
let userChart = null;
let alertChart = null;
let requestChart = null;

const alertTp = {
    'A': 'Activity',
    'F': 'Falls',
    'H': 'Heart Rate',
    'SL': 'Sleep',
    'B': 'Blood Oxygen',
    'T': 'Temperature',
    'ST': 'Stress'
};

const requestTp = {
    'N': 'Nursing',
    'A': 'Ambulance',
    'T': 'Consultation'
};

<!-- 날짜 변경 관련 -->
function openCalendar(dateInputId) {
    document.getElementById(dateInputId).showPicker();
}

function updateDate(dateInputId, displayId) {
    const dateValue = document.getElementById(dateInputId).value;
    document.getElementById(displayId).value = dateValue;

    if(displayId === 'searchEndDe') {
        endDt = dateValue;
    } else {
        startDt = dateValue;
    }

    $('.periodBtn.active').removeClass('active');
    $('#'+displayId).trigger('change');
}

<!-- Search Function -->
function getStatisticData(callback) {
    let param = {'startDt' : startDt, 'endDt' : moment(endDt).format('YYYY-MM-DD')};
    let url = '';

    switch(tabType) {
        case 'user' :
            url = '/statistic/selectUserCnt'
            break;
        case 'healthAlert' :
            url = '/statistic/selectHealthAlertCnt'
            break;
        case 'serviceRequest' :
            url = '/statistic/selectServiceRequestCnt'
            break;
        default :
            break;
    }
    return $.ajax({
        type: 'POST',
        url: url,
        data: JSON.stringify(param),
        contentType: 'application/json; charset=utf-8',
        datatype: 'json',
        success : function(response) {
            callback(response);
        }
    })
}

function getDatesInRange(startMoment, endMoment) {
    const dates = [];
    const current = startMoment.clone();
    while (current.isSameOrBefore(endMoment, 'day')) {
        dates.push(current.format('YYYY-MM-DD'));
        current.add(1, 'days');
    }
    return dates;
}

function randomColor() {
    const r = Math.floor(Math.random() * 155) + 100;
    const g = Math.floor(Math.random() * 155) + 100;
    const b = Math.floor(Math.random() * 155) + 100;
    return `rgb(`+r+`,`+g+`,`+b+`)`;
}

async function drawChart(searchData) {

    const labels = getDatesInRange(moment(startDt), moment(endDt));

    var types = Object.values(tabType === 'healthAlert' ? alertTp : requestTp);

    var dataMap = {};
    for (var i = 0; i < searchData.length; i++) {
        var item = searchData[i];
        var fullName = (tabType === 'healthAlert' ? alertTp : requestTp)[item.tp];
        if (fullName) {
            dataMap[item.dt + '_' + fullName] = item.cnt;
        }
    }

    var datasets = types.map(function(typeName, index) {
        var data = labels.map(function(date) {
            var cnt = dataMap[date + '_' + typeName];
            return cnt != null ? cnt : 0;
        });
        return {
            label: typeName,
            data: data,
            borderColor: colorSet[index],
            pointBackgroundColor : colorSet[index],
            pointRadius: 4,
            pointHoverRadius : 6
        };
    });

    const newChart = new Chart($('#chart'), {
        type: 'line',
        data: {
            labels,
            datasets,
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                },
            }
        },
    });

    if(tabType === 'healthAlert') {
        alertChart = newChart;
    } else {
        requestChart = newChart;
    }
}

async function drawUserChart(searchData) {
    console.log(searchData);
    const labels = searchData.map(item => item.dt);
    const userCnt = searchData.map(item => item.user_cnt);

    const minValue = Math.floor(Math.min(...userCnt) / 100) * 100;
    const maxValue = Math.ceil(Math.max(...userCnt) / 100) * 100;

    const newChart = new Chart($('#chart'), {
        type: 'line',
        data: {
            labels : labels,
            datasets: [{
                label : 'User Amount',
                data : userCnt,
                borderColor: 'rgba(58, 130, 247, 1)',
                pointRadius: 4,
                pointHoverRadius : 6
            }],
        },
        options : {
            responsive: true,
            scale : {
                x : {
                    title : {
                        display: true,
                        text : "date"
                    }
                },
                y : {
                    title : {
                        display: true,
                        text : 'user count'
                    },
                    min: minValue,
                    max: maxValue,
                }
            }
        }
    })
    userChart = newChart;
}

$(document).on('click', '.periodBtn', function(){
    $('.periodBtn').removeClass('active');
    $(this).addClass('active');

    var period = $(this).data('period');
    if(period === 'all') {
        $('#searchBgnDe').val('');
    } else if(period === 'today') {
        $('#searchBgnDe').val(moment().format('YYYY-MM-DD'));
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'))
    } else {
        var pDay = parseInt(period.replaceAll('-day',''));
        $('#searchEndDe').val(moment().format('YYYY-MM-DD'));

        var calcDt = moment().subtract(pDay, 'days').format('YYYY-MM-DD');
        $('#searchBgnDe').val(calcDt);
    }
    startDt = $('#searchBgnDe').val();
    endDt = $('#searchEndDe').val();

    $('#searchBgnDe').trigger('change');
});

$(document).on('change', '#searchBgnDe, #searchEndDe', function(){
    let param = {'startDt' : startDt, 'endDt' : moment(endDt).format('YYYY-MM-DD')};
    let url = '';

    switch(tabType) {
        case 'user' :
            url = '/statistic/selectUserCnt'
            break;
        case 'healthAlert' :
            url = '/statistic/selectHealthAlertCnt'
            break;
        case 'serviceRequest' :
            param.tp = '';
            url = '/statistic/selectServiceRequestCnt'
            break;
        default :
            break;
    }

    $.ajax({
        type: 'POST',
        url: url,
        data: JSON.stringify(param),
        contentType: 'application/json; charset=utf-8',
        datatype: 'json',
        success: function (data) {
            if(tabType === 'user') {
                updateUserChart(data);
            } else {
                updateChart(data.resultList);
            }
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
        }
    })
})

function updateChart(searchData) {

    var labels = getDatesInRange(moment(startDt), moment(endDt));

    var types = Object.values(tabType === 'healthAlert' ? alertTp : requestTp);
    var dataMap = {};
    for (var i = 0; i < searchData.length; i++) {
        var item = searchData[i];
        console.log(item);
        var fullName = (tabType === 'healthAlert' ? alertTp : requestTp)[item.tp];
        if (fullName) {
            dataMap[item.dt + '_' + fullName] = item.cnt;
        }
    }

    var datasets = types.map(function(typeName, index) {
        var data = labels.map(function(date) {
            var cnt = dataMap[date + '_' + typeName];
            return cnt != null ? cnt : 0;
        });
        return {
            label: typeName,
            data: data,
            borderColor: colorSet[index],
            backgroundColor: colorSet[index],
            pointRadius: 4,
            pointHoverRadius : 6
        };
    });

    var targetChart = tabType === 'healthAlert' ? alertChart : requestChart;

    if (targetChart) {
        targetChart.data.labels = labels;
        targetChart.data.datasets = datasets;
        targetChart.update();
    }
}

function updateUserChart(data){
    var newData = data.resultList;

    const newLabels = newData.map(item => item.dt);
    const newUserCounts = newData.map(item => item.user_cnt);

    const newMinValue = Math.floor(Math.min(...newUserCounts) / 100) * 100;
    const newMaxValue = Math.ceil(Math.max(...newUserCounts) / 100) * 100;

    userChart.data.labels = newLabels;
    userChart.data.datasets[0].data = newUserCounts;

    userChart.options.scales.y.min = newMinValue;
    userChart.options.scales.y.max = newMaxValue;

    userChart.update();
}

$(document).on('click','.alertBtns', function(){
    if($('.alertBtns.active').length === 1 && $('.alertBtns.active')[0] == this){
        return;
    }

    if(this.dataset['filter'] === 'all') {
        $('.alertBtns').removeClass('active');
        $('.alertBtns').removeClass('point-chart-01');
        $('.alertBtns').removeClass('point-chart-02');
        $('.alertBtns').removeClass('point-chart-03');
        $('.alertBtns').removeClass('point-chart-04');
        $('.alertBtns').removeClass('point-chart-05');
        $('.alertBtns').removeClass('point-chart-06');
        $('.alertBtns').removeClass('point-chart-07');

        $(this).addClass('active');
    } else {
        var index = $(this).index('.alertBtns');

        $('[data-filter="all"]').removeClass('active');
        $(this).toggleClass('active');
        $(this).toggleClass('point-chart-0'+index)
    }

    const selectedLabels = $('.alertBtns.active').map(function() {
        return $(this).text();
    }).get();
    showOnlySelectedDatasets(tabType === "healthAlert" ? alertChart : requestChart, selectedLabels);
})

function showOnlySelectedDatasets(chart, labelNames) {
    chart.data.datasets.forEach((dataset, index) => {
        const meta = chart.getDatasetMeta(index);
        if (labelNames.includes(dataset.label)) {
            meta.hidden = false;  // 표시
        } else {
            meta.hidden = true;   // 숨김
        }

        if(labelNames.includes('All')) {
            meta.hidden = false;
        }
    });
    chart.update();
}
