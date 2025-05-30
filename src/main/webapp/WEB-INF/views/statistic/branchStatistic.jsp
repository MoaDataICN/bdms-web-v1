<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="../../../resources/js/statistic.js"></script>

<style>
	.board-data-group {
		gap: 4%;
	}

    .data-title01 {
	    justify-content: unset;
	    margin-left:20px;
	    width:unset;
    }
    
    .add-btn {
	    height: auto;
    }
</style>

<main class="main">
	<!-- 대시보드 타이틀 -->
	<div class="board-title">
		<spring:message code="board.title.dashboard"/>
		<p class="board-title-sub"><spring:message code="board.title.sub"/></p>
	</div>
	
	<!-- Tracking 현황 -->
	<div class="tracking02-grid mt-16px">
		<!-- 2025 Branch Amount -->
		<div class="tracking-group">
			<div class="board-title02 point-bg-01">
				2025 Branch Amount
			</div>
			<div class="board-data-group02">
				<div class="data-title03">
					132
				</div>
				<div class="data-group02">
					<div class="data-detail02">
						<div class="data-stats02">
							59
							<div class="data-name">Operational</div>
						</div>
					</div>
					<div class="data-detail02">
						<div class="data-stats02">
							23
							<div class="data-name">Not operational</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 2025 User Amount -->
		<div class="tracking-group">
			<div class="board-title02 point-bg-02">
				2025 User Amount
			</div>
			<div class="board-data-group02">
				<div class="data-title03">
					${userCntMap.y_count + userCntMap.n_count}
				</div>
				<div class="data-group02">
					<div class="data-detail02">
						<div class="data-stats02">
							${userCntMap.n_count}
							<div class="data-name">active</div>
						</div>
					</div>
					<div class="data-detail02">
						<div class="data-stats02">
							${userCntMap.y_count}
							<div class="data-name">inactive</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 2025 Branches with the most users -->
		<div class="tracking-group">
			<div class="board-title04 point-bg-03">
				2025 Branches with the most users
			</div>
			<div class="board-data-group03 f-x-c02">
				<div class="branchname-wrap mb-4px">Branch Name</div>
				<div class="data-title03">
					132
				</div>
			</div>
		</div>
		
		<!-- 2025 Total revenue -->
		<div class="tracking-group">
			<div class="board-title02 point-bg-04">
				2025 Total revenue
			</div>
			<div class="board-data-group02">
				<div class="data-title04">
					$4.94M
				</div>
			</div>
		</div>
	</div>
	
	<div class="second-tap-menu mt-30px" >
		<div class="buttonWrapper" style="width:100%; display:flex; gap: 6px;">
			<button type="button" class="second-tap-btn tabBtn" id="userAmountTab" data-url="/statistic/user">User</button>
			<button type="button" class="second-tap-btn tabBtn" id="healthAlertTab" data-url="/statistic/healthAlert">Health Alerts</button>
			<button type="button" class="second-tap-btn tabBtn" id="serviceRequestTab" data-url="/statistic/serviceRequest">Service Request</button>
		</div>
	</div>
	
	<div id="tab-content" class="mt-28px;">
	
	</div>
</main>


<script>
    <!-- Initialize Default Date -->
    let startDt = moment().subtract(6, 'days').format('YYYY-MM-DD');
    let endDt = moment().format('YYYY-MM-DD');
	
    $(document).on('click','.buttonWrapper button', function(){
        
        if($(this).hasClass('active')) {
            return;
        }
        $('.buttonWrapper button.active').removeClass('active');
        $(this).toggleClass('active');

        tabType = $(this).attr('id').replace('Tab', '');
        
        loadTabContent($(this).data('url'));
    })
    
    function setDate(){
        $('#datePicker1').val(startDt);
        $('#searchBgnDe').val(startDt);
        
        $('#datePicker2').val(endDt);
        $('#searchEndDe').val(endDt);
    }

    function resetDate() {
        startDt = moment().subtract(6, 'days').format('YYYY-MM-DD');
        endDt = moment().format('YYYY-MM-DD');
        
        $('#datePicker1').val(startDt);
        $('#searchBgnDe').val(startDt);

        $('#datePicker2').val(endDt);
        $('#searchEndDe').val(endDt);
    }
    
    function loadTabContent(url) {
        $('#tab-content').empty();
        $.ajax({
	        url: url,
	        type: 'GET',
	        dataType: 'html',
	        success: function(response) {
                $('#tab-content').html(response);
                resetDate();
                
                getStatisticData(function(data) {
                    if(tabType === 'userAmount') {
                        drawUserChart(data.resultList);
                    } else {
                        drawChart(data.resultList);
                    }
                })
	        },
	        error : function() {
                //...
	        }
        })
    }
    
    $(document).ready(function(){
        $('#userAmountTab').click();
    })
</script>

<script>
	$(document).on('click', '.excelBtn', function(){
        
        const payload = {
            startDt: startDt,
            endDt : endDt,
            type: $('.tabBtn.active').attr('id').replace('Tab', '')
        };
        
        const diffDate = moment(endDt).diff(moment(startDt), "days");
        console.log(diffDate);
        if(diffDate > 10) {
            if(payload.type === 'userAmount' && diffDate <= 90) {
                openLoading();
                exportExcel(payload);
            } else {
                showToast('There is a wide range of start and end dates. Please set it within 10 days', 'point', 5000)
            }
        } else {
            openLoading();
            exportExcel(payload);
        }
	})
	
    function exportExcel(payload) {
        fetch("/statistic/exportStatisticExcel", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(payload)
        })
            .then(res => {
                if (!res.ok) throw new Error("*.csv creation failure");
                return res.blob();
            })
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement("a");
                a.href = url;
                a.download = $('.tabBtn.active').attr('id').replace('Tab','')+'_'+startDt+'_'+endDt+".xlsx";
                document.body.appendChild(a);
                a.click();
                a.remove();
                window.URL.revokeObjectURL(url);
                closeLoading();
            })
            .catch(err => {
                alert(err.message);
                closeLoading();
            });
    }

    function openLoading() {
        let maskHeight = $(document).height();
        let maskWidth = window.document.body.clientWidth;

        let mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
        let loadingImg = '';
        loadingImg += "<div id='easy-pop-wrap' style='position:absolute; top: calc(50% - (100px / 2)); width:100%; z-index:99999999;'>";
        loadingImg += "<img src='/resources/images/loding.gif' style='position: relative; display: block; width: 127px; height: 91px; margin: 0px auto;' />";
        loadingImg += "<div class='easy-pop-txt02 mt-24px' style='margin-top: 24px !important;, font-weight: 500px !important;, font-size: 16px !important;, line-height: 20px !important; text-align: center; color: #fff !important; position: relative; display: block; margin: 0px auto;'>Loading...</div>";
        loadingImg += "</div>";

        $('body').append(mask).append(loadingImg);

        $('#mask').css({
            'width': maskWidth,
            'height': maskHeight,
            'opacity': '0.3'
        });

        $('#mask').show();
        $('#easy-pop-wrap').show();
    }

    // 로딩 화면 닫기
    function closeLoading() {
        $('#mask, #easy-pop-wrap').hide();
        $('#mask, #easy-pop-wrap').empty();
    }
</script>