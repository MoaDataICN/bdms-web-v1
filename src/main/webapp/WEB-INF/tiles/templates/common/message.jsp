<%@ page contentType="text/html; charset=UTF-8"%>

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

  <div class="slide-popup-container" id="messageContainer">
  </div>
</div>

<script>
    function openMessagePopup() {
      document.getElementById('customerPopup-message').classList.add('active');
      document.getElementById('slide-overlay-message').classList.add('active');
      document.body.classList.add('no-scroll');  // ✅ 본문 스크롤 막기
    }

    function closeMessagePopup() {
      document.getElementById('customerPopup-message').classList.remove('active');
      document.getElementById('slide-overlay-message').classList.remove('active');
      document.body.classList.remove('no-scroll');  // ✅ 본문 스크롤 복구
    }

    $('#messageBtn').click(function(){

      $.ajax({
        type: 'POST',
        url: '${contextPath}/announcement/selectUserMessage',
        data: {"userId" : '${sessionScope.user.userId}'},
        dataType: 'json',
        success: function (data) {
          $('#messageContainer').empty();

          var i = 0;
          data.messageList.forEach(function(msg) {

            var messageEl = `<div class="second-container `+(i != 0 ? `mt-16px` : ``)+`">
                        <div class="message-row">
                            <!-- 좌측 입력폼 그룹 -->
                            <div class="message-text01">
                                `+msg.userNm+`
                            </div>

                            <div class="message-text01">
                                `+msg.sndDt+`
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
</script>