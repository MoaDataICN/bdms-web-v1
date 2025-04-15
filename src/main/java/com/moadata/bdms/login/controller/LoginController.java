package com.moadata.bdms.login.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.common.util.DateUtil;
import com.moadata.bdms.common.util.StringUtil;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.login.service.LoginService;
import com.moadata.bdms.model.vo.LoginVO;
import com.moadata.bdms.model.vo.UserGroupVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.support.code.service.CodeService;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.service.UserService;
import com.moadata.bdms.userGroup.service.UserGroupService;
/**
 * Login
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController extends BaseController {

	@Resource(name = "loginService")
	private LoginService loginService;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "userGroupService")
	private UserGroupService userGroupService;
	
	@Resource(name = "menuService")
	private MenuService menuService;

	// @Value("#{session.sessionTimeout}")
	private String sessionTimeout = "1800";

	// @Value("#{user.adminId}")
	private String adminId = "ipadmin"; //관리자 아이디 config.properties에 추가.
	
	@Resource(name = "codeService")
	private CodeService codeService;
	
	/**
	 * home
	 * 
	 * 메뉴권한을 아무것도 부여하지 않았을경우
	 * 에러페이지로 전환되며 로그아웃도 할수 없음에
	 * 임시로 만든 페이지임
	 * 
	 * @return
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home() {
		return "login/petaon/home";
	}
	
	/**
	 * 로그인 페이지
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm(ModelMap model,HttpServletRequest request,HttpServletResponse response) {
		UserVO user = (UserVO) getRequestAttribute("user");
		
		if(user != null) {
			String redirectUrl = "/dashboard/main";
			Assert.notNull(redirectUrl, "등록된 메뉴에 대한 권한이 없습니다. 관리자에게 문의하여 주시기 바랍니다.");
			return "redirect:" + redirectUrl;
		}
		
		String path = "";
		return "login" + path + "/loginForm";
	}
	
	/**
	 * 로그인 체크 함수
	 * 
	 * @param loginVO
	 * @param request
	 * @param redirectAttr
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, RedirectAttributes redirectAttr) throws Exception {
		// 로그인한 사용자 정보
		LoginVO loginUser = loginService.selectLoginInfo(loginVO.getUserId());
		String errorMessage = null;
		int diffDt = 0;
		int loginCkDt = 0; //로그인 시간 체크.
		int pwFailCnt = 0;
		
		if(loginUser == null) {
			errorMessage = getMessage("login.user.noexists", null, "");
			LOGGER.debug(errorMessage);
			redirectAttr.addFlashAttribute("errorMessage", errorMessage);
			
			return "redirect:/login/loginForm";
		} else {
			String encryptPassword = EncryptUtil.encryptSha(loginVO.getUserPw());
			diffDt = DateUtil.getTwoDatesDifference(loginUser.getPwModifyDt(), loginUser.getToday());		
			
			String currLoginIp = StringUtil.getServerIP(request);
			/*
			if ((!StringUtil.nvl(loginUser.getConnectIp1(),"").equals(currLoginIp) &&
				 !StringUtil.nvl(loginUser.getConnectIp2(),"").equals(currLoginIp) &&
				 !StringUtil.nvl(loginUser.getConnectIp3(),"").equals(currLoginIp)) && !currLoginIp.equals("0:0:0:0:0:0:0:1") && !loginUser.getUserId().equals("ipadmin")) {
				
				errorMessage = "접근정보가 잘못되었습니다.";
				
				//이력 남기기  - 로그인 실패- 로그인 IP 불일치
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT10");
				param.put("batchId", "");
				param.put("prssType", "HS04");
				param.put("hisEndDt", "");
				param.put("prssUsrId", loginUser.getUserId());
				String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} (Login IP : " +currLoginIp + ")" +"  접근정보 불일치";
				param.put("msgEtc", tempMsg);
				//historyInfoService.commInsertHistory(param,"");
				
				redirectAttr.addFlashAttribute("errorMessage", errorMessage);
				return "redirect:/login/loginForm";
			} else { //정상
			*/
				// authentication check
				if(!encryptPassword.equals(loginUser.getUserPw())) {// 패스워드가 같지 않을때
					//패스워드 불일치 카운트
					pwFailCnt = (loginUser.getPwFailCnt())+1;

					String logFailMsg = "";
					if (pwFailCnt < 5) {
					   logFailMsg = "아이디 또는 비밀번호가 일치하지 않습니다. (" + pwFailCnt + "회)" ;
					} else {
					   logFailMsg = "계정이 잠김 상태로 변경되었습니다. 관리자에게 문의 하세요.";
					}
					
					LOGGER.debug(logFailMsg);
					redirectAttr.addFlashAttribute("errorMessage", logFailMsg);
					
					//이력 남기기  -로그인 실패
					if (pwFailCnt <= 5 ) {
						Map<String,String> param = new HashMap<String,String>();
						param.put("hisType", "HT10");
						param.put("batchId", "");
						param.put("prssType", "HS04");
						param.put("hisEndDt", "");
						param.put("prssUsrId", loginUser.getUserId());
						String loginIp = StringUtil.getServerIP(request);
						String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} ("+pwFailCnt+"회) (Login IP : " +loginIp + ")";
						param.put("msgEtc", tempMsg);
						
						//historyInfoService.commInsertHistory(param,"");
					} else {
						Map<String,String> param = new HashMap<String,String>();
						param.put("hisType", "HT10");
						param.put("batchId", "");
						param.put("prssType", "HS05");
						param.put("hisEndDt", "");
						param.put("prssUsrId", loginUser.getUserId());
						String loginIp = StringUtil.getServerIP(request);
						String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} (Login IP : " +loginIp + ")";
						param.put("msgEtc", tempMsg);
						
						//historyInfoService.commInsertHistory(param,"");
					}
					
					loginVO.setPwFailCnt(pwFailCnt);
					if (pwFailCnt >= 5) {
						loginVO.setLockYn("Y");
					}
					loginService.updateLoginUser(loginVO);
				
					return "redirect:/login/loginForm";
				} else { //패스워드가 같을때 
					int logLockChCnt = 0;
					pwFailCnt = (loginUser.getPwFailCnt()); 				
					if(loginUser.getUseYn().equals("N")) { //사용가능자가 아닌자
						errorMessage = getMessage("login.user.use", null, "");
						LOGGER.debug(errorMessage);
						redirectAttr.addFlashAttribute("errorMessage", errorMessage);
						
						//이력 남기기  -로그인 실패
						if (pwFailCnt <= 5 ) {
							Map<String,String> param = new HashMap<String,String>();
							param.put("hisType", "HT10");
							param.put("batchId", "");
							param.put("prssType", "HS04");
							param.put("hisEndDt", "");
							param.put("prssUsrId", loginUser.getUserId());
							String loginIp = StringUtil.getServerIP(request);
							String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} ("+pwFailCnt+"회) (Login IP : " +loginIp + ")";
							param.put("msgEtc", tempMsg);
							
							//historyInfoService.commInsertHistory(param,"");
						} else {
							Map<String,String> param = new HashMap<String,String>();
							param.put("hisType", "HT10");
							param.put("batchId", "");
							param.put("prssType", "HS05");
							param.put("hisEndDt", "");
							param.put("prssUsrId", loginUser.getUserId());
							String loginIp = StringUtil.getServerIP(request);
							String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} (Login IP : " +loginIp + ")";
							param.put("msgEtc", tempMsg);
							
							//historyInfoService.commInsertHistory(param,"");
						}
						return "redirect:/login/loginForm";
					}else if(loginUser.getLockYn().equals("Y")) {// 락이 걸린자
						errorMessage = getMessage("login.user.lock", null, "");
						LOGGER.debug(errorMessage);
						redirectAttr.addFlashAttribute("errorMessage", errorMessage);
						
						//이력 남기기  -로그인 잠김
						Map<String,String> param = new HashMap<String,String>();
						param.put("hisType", "HT10");
						param.put("batchId", "");
						param.put("prssType", "HS05");
						param.put("hisEndDt", "");
						param.put("prssUsrId", loginUser.getUserId());
						String loginIp = StringUtil.getServerIP(request);
						String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} (Login IP : " +loginIp + ")";
						param.put("msgEtc", tempMsg);
						
						//historyInfoService.commInsertHistory(param,"");
						
						return "redirect:/login/loginForm";
					} else if(loginUser.getLockYn().equals("N")) {// 락이 안걸린자
						if (pwFailCnt > 5 ) {
							//로그인 실패 횟수가 5번 이상이면 10분간 로그인 차단.
							logLockChCnt = loginService.selectLoginLockCk(loginUser.getUserId()); //로그인 한지 10분이 지나면 logLockChCnt 값은 1
							if(logLockChCnt == 0) {								
								String message = "로그인 실패 5회가 넘어서 10분간 로그인을 할 수 없습니다.";
								LOGGER.debug(message);
								
								//이력 남기기  -로그인 잠김
								Map<String,String> param = new HashMap<String,String>();
								param.put("hisType", "HT10");
								param.put("batchId", "");
								param.put("prssType", "HS05");
								param.put("hisEndDt", "");
								param.put("prssUsrId", loginUser.getUserId());
								String loginIp = StringUtil.getServerIP(request);
								String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} (Login IP : " +loginIp + ")";
								param.put("msgEtc", tempMsg);
								
								//historyInfoService.commInsertHistory(param,"");
								
								redirectAttr.addFlashAttribute("errorMessage", message);
								return "redirect:/login/loginForm";	
							}
					    }
						
						//관리자계정을 제외한 사용자 계정은 p/w 90일 경과 후 로그인 시 패스워드 변경 팝업 및 변경 후 로그인 가능 22.08.24
						if(!StringUtil.isEmpty(loginUser.getPwModifyDt())) {
							if((90) < diffDt) {
								if(loginUser.getUserId().equals(adminId)) {
									//로그인 아이디가 관리자 이면 패스워드 변경 메시지만 출력
									String message = "패스워드 변경후 90일이 경과하였습니다. 패스워드를 변경해주세요.";						
									redirectAttr.addFlashAttribute("errorMessage", message);						
								}else {
									//일반 사용자이면 페스워드 변경 팝업 활성화. 패스워드 변경 팝업화면 추가후 수정.
									HttpSession session = request.getSession(true);	
									session.setAttribute("pwCkUserId", loginVO.getUserId());
									session.setAttribute("pwFlag", "Y");
									return "redirect:/login/loginForm";	
								}				
							}			
						}
						
					}else {
						//관리자계정을 제외한 사용자 계정은 p/w 90일 경과 후 로그인 시 패스워드 변경 팝업 및 변경 후 로그인 가능 22.08.24
						if(!StringUtil.isEmpty(loginUser.getPwModifyDt())) {
							if((90) < diffDt) {
								if(loginUser.getUserId().equals(adminId)) {
									//로그인 아이디가 관리자 이면 패스워드 변경 메시지만 출력
									String message = "패스워드 변경후 90일이 경과하였습니다. 패스워드를 변경해주세요.";						
									redirectAttr.addFlashAttribute("errorMessage", message);						
								}else {
									//일반 사용자이면 페스워드 변경 팝업 활성화. 패스워드 변경 팝업화면 추가후 수정.
									HttpSession session = request.getSession(true);	
									session.setAttribute("pwCkUserId", loginVO.getUserId());
									session.setAttribute("pwFlag", "Y");
									return "redirect:/login/loginForm";	
								}				
							}			
						}
					}
				}
			//}
			
			
		}
		
		//로그인 일자 체크 관리자를 제외한 일반 사용자 우선 관리자 아이디는 admin으로 향후 수정 22.08.5 => 관리자 아이디가 admin에서 ipadmin으로 변경되어 수정.
		if(!loginUser.getUserId().equals(adminId)) {
			loginCkDt = DateUtil.getTwoDatesDifference(loginUser.getLoginDt(), loginUser.getToday());
			if(90 < loginCkDt) {				
				String message = "최종 로그인 이후 90일이 경과되어 자동 계정잠금처리 되었습니다. 관리자에게 문의하세요.";						
				redirectAttr.addFlashAttribute("errorMessage", message);	
				loginVO.setLockYn("Y");				
				loginService.updateLoginUser(loginVO);
				
				//로그인 이력 추가. 계정 잠김이력 추가.			
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT10");
				param.put("batchId", "");
				param.put("prssType", "HS05");
				param.put("hisEndDt", "");
				param.put("prssUsrId", loginUser.getUserId());
				String loginIp = StringUtil.getServerIP(request);
				String tempMsg = "사용자 " + loginUser.getUserId() + " - " + "{0} (Login IP : " +loginIp + ")";
				param.put("msgEtc", tempMsg);
				
				//historyInfoService.commInsertHistory(param,"");
		
				return "redirect:/login/loginForm";							
			}			
		}

		// 로그인 일자 갱신
		//loginService.updateLoginDt(loginUser.getUserId());
		loginVO.setPwFailCnt(0);
		loginService.updateLoginUser(loginVO);
		
		// Session 정보
		//authenticationSuccess(request, loginUser.getUserId());
		HttpSession session = request.getSession(true);	
		
		// 사용자 상세 정보 조회 
		UserVO user = userService.selectUserInfo(loginUser.getUserId());
		//user.setPhoneNo(EncryptUtil.decryptText(user.getPhoneNo()));
		//user.setUserNm(EncryptUtil.decryptText(user.getUserNm()));
		//user.setEmailAddr(EncryptUtil.decryptText(user.getEmailAddr()));
		session.setAttribute("user", user);
		
		// 사용자 그룹 정보		
		UserGroupVO usergroup = userGroupService.selectUserGroupInfo(user.getUsergroupId());
		session.setAttribute("usergroup", usergroup);
		
		//세션 유지시간 설정
		//session.setMaxInactiveInterval(600); // 600 = 60s*10 (10분)
		session.setMaxInactiveInterval(Integer.parseInt(sessionTimeout));
		// Locale 설정
		Locale.setDefault(LocaleContextHolder.getLocale());
		
		session.setAttribute("pwFlag", "N");
		
		String redirectUrl = "/dashboard/main";
		
		//로그인 이력 추가.
		Map<String,String> param = new HashMap<String,String>();
		param.put("hisType", "HT10");
		param.put("batchId", "");
		param.put("prssType", "HS03");
		param.put("hisEndDt", "");
		param.put("prssUsrId", user.getUserId());
		String loginIp = StringUtil.getServerIP(request);
		String tempMsg = "사용자 " + user.getUserId() + " - " + "{0} (Login IP : " +loginIp + ")";
		param.put("msgEtc", tempMsg);
		
		//historyInfoService.commInsertHistory(param,"");
		
		//로그인 시 IP 세션에 추가. 22.12.19
		RequestContextHolder.currentRequestAttributes().setAttribute("loginIp", loginIp,RequestAttributes.SCOPE_SESSION);//사용자 IP 추가.
		
		return "redirect:" + redirectUrl;
	}
	
	/**
	 * 로그아웃
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		if (request.getSession() != null) {
			setInitSessionCookie(response, request, null, 0);
		}
		return "redirect:/login/loginForm";
	}
	
	/**
	 * 회원가입 페이지
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loginUserRegisterForm", method = RequestMethod.GET)
	public String loginUserRegisterForm(ModelMap model) {
		String path = "";
	    model.addAttribute("wkType",codeService.selectCodeList("WK00"));//근무형태
		return "login" + path + "/loginUserRegisterForm";
	}
	
	/**
	 * 회원가입
	 * 
	 * @param user
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/loginUserRegister", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginUserRegister(@ModelAttribute("user") UserVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		boolean isError = false;
		
		try {
			// 중복 체크
			//UserVO checkUser = userService.selectUserInfo(user.getUserId());
			int checkUser = userService.selectUserIdCnt(user.getUserId());
			
			//if(checkUser != null) {
			if(checkUser > 0) {
				isError = true;
				message = "이미 등록된 아이디입니다.";
			} else {
				String encryptPassword = EncryptUtil.encryptSha(user.getUserPw());
				user.setUserPw(encryptPassword);
				
				//사용자 이름, 핸드폰번호 암호와				
				String userNm = EncryptUtil.encryptText(user.getUserNm());
				String phoneNo = EncryptUtil.encryptText(user.getPhoneNo());
				String emailAddr = EncryptUtil.encryptText(user.getEmailAddr());
				
				user.setUserNm(userNm);			
				user.setPhoneNo(phoneNo);
				user.setEmailAddr(emailAddr);
				user.setRegistId(user.getUserId()); 
				user.setModifyId(user.getUserId()); 
				userService.insertUser(user);
				
				message = "관리자에게 사용 승인을 요청하세요.";
				
				//이력 추가.
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT16");
				param.put("batchId", "");
				param.put("prssType", "HS06");
				param.put("hisEndDt", "");
				param.put("prssUsrId", user.getUserId());				
				String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 성공 하였습니다.";
				param.put("msgEtc", tempMsg);
				
				//historyInfoService.commInsertHistory(param,"");
				
			}
		} catch(Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = "등록에 실패했습니다.";
			
			//이력 추가.
			Map<String,String> param = new HashMap<String,String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS06");
			param.put("hisEndDt", "");
			param.put("prssUsrId", user.getUserId());				
			String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 실패 하였습니다.";
			param.put("msgEtc", tempMsg);
			
			//historyInfoService.commInsertHistory(param,"");
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
	
	/**
	 * session 갱신
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/continueLogin", method = RequestMethod.POST)  
	@ResponseBody
	public void continueLogin(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.setMaxInactiveInterval(120*60);
		}
	}
	
	/**
	 * 사용자 비밀번호 변경 팝업창(관리자 제외)
	 * 
	 * param request
	 * param userLoginId
	 */	
	@RequestMapping(value = "/userPwChangeView", method = RequestMethod.GET )
	public String userPwChange(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) {		
		UserVO user = (UserVO) getRequestAttribute("user");	
		model.addAttribute("userId", loginVO.getUserId());		
		return "login/petaon/userPwChange";
	}
		
	/**
     * 비밀번호 변경 체크 함수
     *
     * @param loginVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/userPwChange", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> userPwChange(@RequestBody LoginVO loginVO,  HttpServletRequest request) throws Exception {
        Map<String, Object> map = new HashMap<>();

        boolean isError = false;     
        
        LoginVO loginUser = loginService.selectLoginInfo(loginVO.getUserId());
		String errorMessage = null;
		
		if(loginUser == null) {
			errorMessage = getMessage("login.user.noexists", null, "");
			LOGGER.debug(errorMessage);			
			map.put("isError", isError);
		    map.put("errorMessage", errorMessage);
		    return map;
			
		} else {
					
			String encryptPassword = EncryptUtil.encryptSha(loginVO.getCurrentPw());
			
			// authentication check
			if(!encryptPassword.equals(loginUser.getUserPw())) {				
								
				errorMessage = "현재 비밀번호가 일치하지 않습니다." ;				
				LOGGER.debug(errorMessage);
				map.put("isError", isError);
			    map.put("errorMessage", errorMessage);
			    return map;
			} 
		}
		
		String encryptPassword = EncryptUtil.encryptSha(loginVO.getUserPw());
		loginVO.setUserPw(encryptPassword);
		isError = true;
		loginService.updateLoginUserPw(loginVO);
		
		HttpSession session = request.getSession(true);	
		session.setAttribute("pwFlag", "N");
		
        map.put("isError", isError);
        map.put("errorMessage", errorMessage);
        return map;
    }
    
    /**
     * timeOut 설정 초기화
     *
     * @param request
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/initTimeoutUpdate")
    public Map<String, Object> initTimeoutUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();

        String message = "";
        boolean isError = false;

        try {
            Map<String, Object> myMap = new HashMap<String, Object>();
            HttpSession session = request.getSession(false);
            UserVO user = (UserVO) session.getAttribute("user");
            if (session.getId() != null) {

                Cookie ck = new Cookie(session.getId(), "1");
                ck.setMaxAge(-1);
                ck.setPath("/");
                response.addCookie(ck);

                message = "연장되었습니다.";
            } else {
                message = "";
            }
        } catch (Exception e) {
            LOGGER.error(e.toString());
            isError = true;
            message = e.getMessage();
        }

        map.put("isError", isError);
        map.put("message", message);
        return map;
    }
    
	/**
	 * 쿠키 제거
	 *
	 *
	 * void
	 */
	private void setInitSessionCookie(HttpServletResponse response,HttpServletRequest request, String value, int val) {

		HttpSession session = request.getSession(false);

		Cookie ck = new Cookie(session.getId(), value);
		ck.setMaxAge(val);
		ck.setPath("/");
		if (val == 0) {
			ck.setSecure(false);
		}
		response.addCookie(ck);
		
		Cookie[] cookie = request.getCookies();
		if (cookie != null) {
		    for (int k = 0; k < cookie.length; k++) {
		   	   if (cookie[k].getName().indexOf("IC_") >= 0) {
		   		   cookie[k].setMaxAge(val);
		   		   cookie[k].setPath("/");
		   		   
		   		   if (val == 0) {
		   			  cookie[k].setSecure(false);
				   }
				   response.addCookie(cookie[k]);		   		   
			   }
		    }
		}		
		request.getSession().invalidate(); // 세션 초기화
	}
}