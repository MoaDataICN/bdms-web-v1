<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglibs.jsp"%>

<script type="text/javascript">
var pwFlag = '<%=(String)session.getAttribute("pwFlag")%>';
var pwCkUserId = '<%=(String)session.getAttribute("pwCkUserId")%>';
(function($) {
	goLogin = function() {
		var arr = ["userId", "userPw"];
		var check = true;
		$.each(arr, function() {
			if($.trim($("#" + this).val()) == "") {
				$("#" + this).focus();
				check = false;
				return false;
			}
		});
		if(check) {
			var domain = document.domain;
			var option = {
				domain: domain,
				expires: 365,
				path: '/'
			}
			var id = $("#userId").val();
			
			if($("#idSaveCheck").prop("checked")) {
				$.cookie("LOGIN_SAVEID", id, option);
			} else {
				$.cookie("LOGIN_SAVEID", "", option);
			}
			
			$("#loginForm")[0].submit();
		}
	};


	$(document).ready(function() {
		<c:if test="${!empty errorMessage}">
		$.alert('${fn:replace(fn:escapeXml(errorMessage), LF, '<br />')}');
		$('#loginBtn').before(`<div class="login-message mt-4px">ID or password is wrong.</div>`)
		</c:if>
		<c:if test="${!empty param.error}">
			<c:choose>
				<c:when test = "${param.error eq '2'}">
					$.alert("<spring:message code="login.expire.msg" />");
					if(opener) {
						opener.top.window.location.href='<c:url value="/login/loginForm"/>';
						self.close();
					} else {
						top.window.location.href='<c:url value="/login/loginForm"/>';
					}
				</c:when>
			</c:choose>
		</c:if>
		
		$("input[name=userId]").val($.cookie("LOGIN_SAVEID"));
		
		if($.cookie("LOGIN_SAVEID") != "" && $.cookie("LOGIN_SAVEID") != null) {
			$("#idSaveCheck").attr('checked', true);
		}
		
		$("#userPw").on('keypress',function(){
			if(event.which == 13) {
				goLogin();
			}
		});
		
		var agent = navigator.userAgent.toLowerCase();
		if (agent.indexOf("chrome") != -1) {
			$(".f2").hide();
		}		
		
		if(pwFlag == "Y"){
			fnPwChangePop();
		}				
		
	});
	
	
})(jQuery);

	function fnPwChangePop() {
	 	
		$.ajax({
		    type: 'GET',        
		    url: '${contextPath}/login/userPwChangeView',
		    dataType: 'html',
		    data: {
		    	userId: pwCkUserId,
            },
		    success: function (data) {
		        $('#loginModalContent').html(data);
		        $('#loginModal').show()		              
		    },
		    error: function (request, status, error) {
		        console.log("code:" + request.status + "\n" + "error:" + error); //+"message:"+request.responseText+"\n"
		    }
		});
		
};

function limitLength(element, maxLength) {
	if (element.value.length > maxLength) {
		element.value = element.value.slice(0, maxLength); // 길이 제한 초과 시 잘라내기
	}
}
</script>

<div class="login-left-panel">
	<img src="/resources/images/logo-black.png" class="login-logo">
	<div class="login-subtitle mt-14px">
		Welcome! This is the medical support system.
	</div>
	<form name="loginForm" id="loginForm" class="full-panel-form" data-toggle="validator" role="form" action="<c:url value='/login/login'/>" method="post" onsubmit="return false">
		<div class="login-input mt-42px">
			<input type="text" id="userId" name="userId"class="input-txt05" placeholder="Enter Member ID" oninput="limitLength(this, 12);" required>
			<div class="img-left">
				<img src="/resources/images/login-mail-icon.svg" class="icon24">
				<div class="h-line"></div>
			</div>
		</div>
		<div class="login-input mt-20px">
			<input type="password" id="userPw" name="userPw" class="input-txt05" placeholder="Enter Password" oninput="limitLength(this, 12);" required>
			<div class="img-left">
				<img src="/resources/images/login-lock-icon.svg" class="icon24">
				<div class="h-line"></div>
			</div>
		</div>
		<button type="button" type="submit" id="loginBtn" class="point-login-btn mt-34px" onclick="goLogin()">LOGIN</button>
	</form>
	<div class="login-w-line mt-42px"></div>
	<div class="login-copyright mt-20px">Copyright © 2025 MOAdata. All rights reserved.</div>
</div>
<img src="/resources/images/login-left-img.png" class="login-bg-img">

<div class="login-right-panel">
	<img src="/resources/images/login-img.png">
</div>

<!---------------- node modal ------------------>

<div class="modal" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog agent_enrollment" role="document">
        <div class="modal-content" style="max-height:1%; margin-top:127px" id="loginModalContent">
	
        </div>
    </div>
</div>




