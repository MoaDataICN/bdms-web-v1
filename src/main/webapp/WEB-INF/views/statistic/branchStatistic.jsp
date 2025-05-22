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
			<button type="button" class="second-tap-btn tabBtn" id="userTab" data-url="/statistic/user">User</button>
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
                    if(tabType === 'user') {
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
        $('#userTab').click();
    })
</script>