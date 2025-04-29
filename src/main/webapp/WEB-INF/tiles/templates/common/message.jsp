<%@ page contentType="text/html; charset=UTF-8"%>
<style>
	.slide-popup-container {
		padding: 0 20px 20px 20px;
	}
	
	#messageContainer .second-container {
		cursor: pointer;
		display:none;
		margin-top: 16px;
	}
	
	#messageContainer .second-container.on {
		display:flex;
	}
	
	.customer-popup-message .type-button-wrap {
		padding: 16px 20px 16px 20px;
        display: flex;
        flex-wrap: wrap;
        gap: 4px;
	}
	
	.customer-popup-message .type-button-wrap button {
        border-radius: 100px;
	}
	
	.type-select-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 6px 12px;
        border-radius: 6px;
        background: var(--bg-white);
        border: 1px solid var(--gray-21);
        color: var(--gray-24);
        font-size: 14px;
        font-weight: 500;
        line-height: 16px;
        letter-spacing: -0.28px;
        min-width: 60px;
        transition: all 0.2s;
	}

    .type-select-btn.active {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 6px 12px;
        border-radius: 6px;
        border: 1px solid var(--gray-25);
        background: var(--gray-25);
        color: var(--bg-white);
        font-size: 14px;
        font-weight: 500;
        line-height: 16px;
        letter-spacing: -0.28px;
        min-width: 60px;
    }

</style>
<!-- 우측 슬라이드 팝업 -->
<!-- 반투명 배경 -->
<div class="slide-overlay" id="slide-overlay-message"></div>

<!-- 우측에서 슬라이드되는 팝업 -->
<div class="customer-popup-message" id="customerPopup-message">
  <div class="popup-header message-title-bg">
    <div class="second-title message-color-text">
      Message
    </div>
    <button type="button" id="closePopup-message">
      <img src="/resources/images/close-white-icon.svg" class="icon24">
    </button>
  </div>
	
	<div class="type-button-wrap">
		<button class="type-select-btn active" data-filter="all">ALL</button>
		<button class="type-select-btn" data-filter="alert">Health Alerts</button>
		<button class="type-select-btn" data-filter="request">Service requests</button>
		<button class="type-select-btn" data-filter="message">Other</button>
	</div>

  <div class="slide-popup-container" id="messageContainer">
  </div>
</div>

<div id="messagePopupArea"></div>

<script>
    function openMessagePopup() {
      document.getElementById('customerPopup-message').classList.add('active');
      document.getElementById('slide-overlay-message').classList.add('active');
      $('.type-select-btn').removeClass('active');
      document.getElementsByClassName('type-select-btn')[0].classList.add('active');
      document.body.classList.add('no-scroll');
    }

    function closeMessagePopup() {
      document.getElementById('customerPopup-message').classList.remove('active');
      document.getElementById('slide-overlay-message').classList.remove('active');
      document.body.classList.remove('no-scroll');
    }

    function convertAlertTp(value) {
        switch (value) {
            case 'A': return 'Activity';
            case 'F': return 'Falls';
            case 'H': return 'Heart Rate';
            case 'SL': return 'Sleep';
            case 'B': return 'Blood Oxygen';
            case 'T': return 'Temperature';
            case 'ST': return 'Stress';
            default: return value;
        }
    }
    
    $('#messageBtn').click(function(){

      $.ajax({
        type: 'POST',
        url: '${contextPath}/announcement/selectUserMessage',
        data: {"userId" : '${sessionScope.user.userId}'},
        dataType: 'json',
        success: function (data) {
            console.log(data);
          $('#messageContainer').empty();

          // 3종류의 리스트 통합
            const convertedMessages = data.messageList.map(msg => ({
                id: msg.annId,
                userNm: msg.userNm,
                dt: msg.sndDt,
                title: msg.title,
                cont: msg.cont,
	            type: 'message'
            }));

            const convertedAlerts = data.alertList.map(alert => ({
                id: "",
                userNm: alert.userNm,
                dt: alert.dctDt,
                title: convertAlertTp(alert.altTp),
                cont: alert.altRmrk,
	            type: 'alert'
            }));

            const convertedRequests = data.requestList.map(request => ({
                id: "",
                userNm: request.userNm,
                dt: request.reqDt,
                title: request.reqTp === 'A' ? 'Ambulance' : request.reqTp === 'N' ? 'Nursing' : request.reqTp === 'T' ? 'Telehealth' : '',
                cont: request.reqTp === 'A' ? 'Ambulance' : request.reqTp === 'N' ? 'Nursing' : request.reqTp === 'T' ? 'Telehealth' : '',
	            type: 'request'
            }));

            const combinedList = [...convertedMessages, ...convertedAlerts, ...convertedRequests];
            combinedList.sort((a, b) => {
                return new Date(b.dt) - new Date(a.dt);
            });
            console.log(combinedList);
            
          var i = 0;
            combinedList.forEach(function(msg) {

            var messageEl = `<div class="second-container on `+(i != 0 ? `mt-16px` : ``)+`" data-id="`+msg.id+`" data-tp="`+msg.type+`">
                        <div class="message-row">
                            <!-- 좌측 입력폼 그룹 -->
                            <div class="message-text01">
                                `+msg.userNm+`
                            </div>

                            <div class="message-text01">
                                `+msg.dt+`
                            </div>
                            <!-- 라인 1px -->
                            <div class="w-line02"></div>
                            <div class="message-text02">
                                `+msg.title+`
                            </div>
                            <!-- 메시지 내용들-->
                            <div class="message-round-wrap">
                                <span>
                                    `+msg.cont+`
                                </span>
                            </div>
                        </div>
                    </div>`
              i++;
              $('#messageContainer').append(messageEl);
          });
          var spacer = `<div class="space-20"></div>`;
          $('#messageContainer').append(spacer);
        }
      });

      openMessagePopup();
    })

    $('#closePopup-message,#slide-overlay-message').click(function(){
      closeMessagePopup();
    })
    
    $(document).on('click', '#messageContainer .second-container, .message-detail-btn', function(){
        var id = $(this).data('id');

        if(id != null && id != '' && id != 'undefined') {
            $.ajax({
                type: 'GET',
                url: '${contextPath}/announcement/messagePopup',
                data: {"annId" : id, "userId" : '${sessionScope.user.userId}'},
                dataType: 'html',
                success: function (data) {
                    if(data) {
                        closeMessagePopup();

                        $('#messagePopupArea').append(data)
                    }
                }
            })
        }
    })
    
    $(document).on('click', '.closePopup', function(){
        $('#messagePopupArea').empty();
    })
    
    $(document).on('click', '.popup-modal', function(e){
        if(!e.target.closest('.popup-show')) {
            $('#messagePopupArea').empty();
        }
    })
    
    $(document).on('click', '.type-select-btn', function(){
        $('.type-select-btn').removeClass('active');
		$(this).addClass('active');
        
        var type = $(this).data('filter');
        
        if(type === 'all') {
            $('#messageContainer .second-container').removeClass('on')
            $('#messageContainer .second-container').addClass('on');
        } else {
	        $('#messageContainer .second-container').removeClass('on')
            $('#messageContainer .second-container[data-tp="'+type+'"]').addClass('on');
        }
    })
</script>