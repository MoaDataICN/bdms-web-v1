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

</script>
<div class="console-login">
	<div class="login-form">
		<div class="mb-5">
	        <img id="logo_img" src="/resources/images/logo_incheonAP.png" alt="logo">
		</div>
		<div class="login-form-inner">
			<div class="login-title">
				<h2>로그인</h2>
				<p>아이디 / 비밀번호를 입력하시고 로그인 하십시오.</p>
			</div>
			<form name="loginForm" id="loginForm" class="full-panel-form" data-toggle="validator" role="form" action="<c:url value='/login/login'/>" method="post" onsubmit="return false">
				<div class="console-form-body">
					<div class="row">
						<div class="col-lg-12 col-md-12">
							<div class="form-group  has-feedback">
								<label>아이디</label>
								<div class="input-group">
									<div class="input-group-prepend"><span class="input-group-text user_id"><i class="fa fa-user"></i></span></div>
									<input type="text" id="userId" name="userId" class="form-control" placeholder="ID" required>
								</div>
								<div class="help-block with-errors"></div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12">
							<div class="form-group  has-feedback">
								<label class="flex">비밀번호</label>
								<div class="input-group">
									<div class="input-group-prepend"><span class="input-group-text user_pw"><i class="fa fa-key"></i></span></div>
									<input type="password" id="userPw" name="userPw" class="form-control" placeholder="Password" required>
								</div>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
						<div class="con-separator con-separator--border-dashed con-separator--space-md"></div>
						<div class="row">
						<div class="col-lg-12 col-md-12">
							<div class="flex">
								<p>사용자 등록을 요청하시겠습니까?  <a href="<c:url value="/login/loginUserRegisterForm"/>" title="">Signup</a></p>
								<button class="btn btn-primary btn-outline ml-auto" type="submit" onclick="goLogin()">Login</button>
							</div>
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="idSaveCheck">
								<label class="custom-control-label" for="idSaveCheck">아이디 저장</label>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>	
</div><!-- Console Login -->
<!---------------- node modal ------------------>

<div class="modal" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog agent_enrollment" role="document">
        <div class="modal-content" style="max-height:1%; margin-top:127px" id="loginModalContent">
	
        </div>
    </div>
</div>




