<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 일반 팝업 Popup-->
<div class="popup-modal">
	<div class="popup-show popup-w726">
		<div class="popup-title mt-8px">Detail of Message</div>
		<div class="second-container02 mt-20px">
			<div class="content-row">
				<!-- 좌측 입력폼 그룹 -->
				<div class="row-md-100">
					<div class="row-wrap">
						<div class="input-label02">
							Send Time
						</div>
						<div class="row-input">
							<input type="text" class="input-txt02" placeholder="-"
							       oninput="limitLength(this, 30);" readonly value="${message.sndDt}">
						</div>
					</div>
					
					<div class="row-wrap">
						<div class="input-label02">
							From
						</div>
						<div class="row-input">
							<input type="text" class="input-txt02" placeholder="-"
							       oninput="limitLength(this, 30);" readonly value="${message.sndNm}">
						</div>
					</div>
				</div>
				
				<div class="row-md-100">
					<div class="row-wrap">
						<div class="input-label02">
							To whom
						</div>
						<div class="row-input">
							<input type="text" class="input-txt02" placeholder="-"
							       oninput="limitLength(this, 30);" readonly value="${message.tgTp == 0 ? 'workforce only' : message.tgTp == 1 ? 'User only' :message.tgTp == 2 ? 'workforce and user' :message.tgTp == 3 ? 'specific people' :'Unknown'}">
						</div>
					</div>
					
					<div class="row-wrap">
						<div class="input-label02">
							Group
						</div>
						<div class="row-input">
							<input type="text" class="input-txt02" placeholder="-"
							       oninput="limitLength(this, 30);" readonly value="${message.grpNm}">
						</div>
					</div>
				</div>
				
				<div class="row-md-100">
					
					<div class="row-wrap">
						<div class="input-label02">
							Recipient
						</div>
						<div class="wrap-form">
                                        <textarea class="input-area02"
                                                  placeholder="-" readonly>${message.rcptNm}</textarea>
						</div>
					</div>
				</div>
				
				<div class="row-md-100">
					<div class="row-wrap">
						<div class="input-label02">
							Title
						</div>
						<div class="row-input">
							<input type="text" class="input-txt02" placeholder="-"
							       oninput="limitLength(this, 30);" readonly value="${message.title}">
						</div>
					</div>
				</div>
				
				<div class="row-col-100 mb-16px">
					<div class="input-label02 mb-4px">
						Memo
					</div>
					<div class="wrap-form">
                                    <textarea class="input-area"
                                              placeholder="-" readonly>${message.cont}</textarea>
					</div>
				</div>
			</div>
		
		</div>
		<button class="popup-close"><img src="/resources/images/close-icon.svg" class="icon22 closePopup"></button>
		<div class="popup-footer">
			<div></div>
			<div class="btn-group">
				<button type="button" class="gray-submit-btn closePopup">
					Close
				</button>
			</div>
		</div>
	</div>
</div>