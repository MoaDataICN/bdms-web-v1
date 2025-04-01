/* Pager 커스텀 S */
function createCustomPager(grid) {
    const totalRecords = $("#"+grid).getGridParam('records');
    const rowNum = $("#"+grid).getGridParam('rowNum');
    const totalPages = Math.ceil(totalRecords / rowNum);
    const currentPage = $("#"+grid).getGridParam('page');

    const maxPageGroup = Math.ceil(totalPages / pageSize);
    const startPage = (currentPageGroup - 1) * pageSize + 1;
    let endPage = startPage + pageSize - 1;

    if (endPage > totalPages) {
        endPage = totalPages;
    }

    let pagerHtml = '';
    let selectHtml = '';

    pagerHtml += `<button class="page-num-box nav-btn" type="button" data-action="prev" data-grid="`+grid+`"+`+(currentPageGroup === 1 ? 'disabled' : '')+`>
                            <img src="../../resources/images/arrow-num-left.svg" class="icon16">
                    </button>`


    for (let i = startPage; i <= endPage; i++) {
        if (i === currentPage) {
            pagerHtml += `<button class="page-num-box active" data-page="`+i+`" data-grid="`+grid+`">`+i+`</button> `;
        } else {
            pagerHtml += `<button class="page-num-box page-btn" data-page="`+i+`" data-grid="`+grid+`">`+i+`</button> `;
        }
    }

    pagerHtml += `<button class="page-num-box nav-btn" type="button" data-action="next" data-grid="`+grid+`"+`+(currentPageGroup === maxPageGroup ? 'disabled' : '')+`>
                            <img src="../../resources/images/arrow-num-right.svg" class="icon16">
                    </button>`

    selectHtml += `<div style="width:100%; text-align:right;"><select id="rowNumSelect" style="margin-left: 10px;" data-grid="\`+grid+\`">`
    selectHtml += `<option value="10" `+ (rowNum === 10 ? 'selected' : '')+`>View 10 items</option>`
    selectHtml += `<option value="20" `+ (rowNum === 20 ? 'selected' : '')+`>View 20 items</option>`
    selectHtml += `<option value="30" `+ (rowNum === 30 ? 'selected' : '')+`>View 30 items</option>`
    selectHtml += `</select></div>`;

    $('#customPager').html(pagerHtml);

    if($('#rowNumSelect').length == 0) {
        $('#tableWrapper').prepend(selectHtml);
    }
}

$(document).on('change', '#rowNumSelect', function() {
    const newRowNum = parseInt($(this).val(), 10);
    rowNumsVal = newRowNum;
    $("#testGrid").setGridParam({
        rowNum: newRowNum,
        page: 1,
        size : newRowNum
    }).trigger("reloadGrid");

    currentPageGroup = 1;
});

// 숫자 버튼 클릭
$(document).on('click', '.page-btn', function() {
    const selectedPage = parseInt($(this).data('page'), 10);
    const target = this.dataset['grid']
    $("#"+target).setGridParam({ rowNum: rowNumsVal, page: selectedPage, size: rowNumsVal }).trigger("reloadGrid");
});

// 화살표 버튼 클릭
$(document).on('click', '.nav-btn', function() {
    const action = $(this).data('action');
    console.log(action);
    const target = this.dataset['grid'];
    const totalRecords = $("#"+target).getGridParam('records');
    const rowNum = $("#"+target).getGridParam('rowNum');
    const totalPages = Math.ceil(totalRecords / rowNum);
    const maxPageGroup = Math.ceil(totalPages / pageSize);

    switch (action) {
        case 'first':
            currentPageGroup = 1;
            $("#"+target).setGridParam({ rowNum: rowNumsVal, page: 1 }).trigger("reloadGrid");
            break;
        case 'prev':
            if (currentPageGroup > 1) {
                currentPageGroup--;
                const prevPage = (currentPageGroup - 1) * pageSize + 1;
                console.log('here')
                console.log(prevPage);
                $("#"+target).setGridParam({ rowNum: rowNumsVal, page: prevPage }).trigger("reloadGrid");
            }
            break;
        case 'next':
            if (currentPageGroup < maxPageGroup) {
                currentPageGroup++;
                const nextPage = (currentPageGroup - 1) * pageSize + 1;
                $("#"+target).setGridParam({ rowNum: rowNumsVal, page: nextPage }).trigger("reloadGrid");
            }
            break;
        case 'last':
            currentPageGroup = maxPageGroup;
            const lastPage = (currentPageGroup - 1) * pageSize + 1;
            $("#"+target).setGridParam({ rowNum: rowNumsVal, page: lastPage }).trigger("reloadGrid");
            break;
    }
});
/* Pager 커스텀 E */