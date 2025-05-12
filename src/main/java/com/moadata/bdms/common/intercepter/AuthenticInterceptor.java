package com.moadata.bdms.common.intercepter;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.moadata.bdms.common.exception.ProcessException;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.support.menu.service.MenuService;

public class AuthenticInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(AuthenticInterceptor.class);
    
    private static final String SESSION_EXPIRE_URI = "/login/loginForm?error=2";
    //private static final String SESSION_EXPIRE_URI = "/login/loginForm";

    private static final int AJAX_HTTP_TIMEOUTME = 901;
    
	private String sessionTimeout="1800";
    
    @Resource(name = "menuService")
    private MenuService menuService;
    
    @SuppressWarnings("unused")
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String requestURI = request.getRequestURI();

        if (requestURI.startsWith("/resources/") || requestURI.contains("api")) {
            return true;
        }

        if(log.isDebugEnabled()) {
            //log.debug("======================================          START         ======================================");
            log.debug("Request URI \t:  " + requestURI);
            printParameter(request);
        }
        
        HttpSession session = request.getSession(false);
        
        if(session == null) {
            String ajaxFlag = (String) request.getHeader("AJAX");
            
            if("true".equals(ajaxFlag)) {
                response.sendError(AJAX_HTTP_TIMEOUTME, "sessiontimeout");
            } else {
                response.sendRedirect(request.getContextPath() + SESSION_EXPIRE_URI);
            }
            
            return false;
        } else {
            UserVO user = (UserVO) session.getAttribute("user");
            
            if(user == null) {
                response.sendRedirect(request.getContextPath() + SESSION_EXPIRE_URI);
                return false;
            } else {
                //////////////////////////////////////////
            	// session 체크를 위한 로직 추가 2022.12.06 start
            	//////////////////////////////////////////
    			if (user == null) {
    				response.sendRedirect(request.getContextPath() + SESSION_EXPIRE_URI);
    				return false;
    			} else {
    				if ("/dashboard/".equals(requestURI)) {
    					response.sendRedirect(request.getContextPath() + "/dashboard/main");
    					return true;
    				}

                    /*
    				String userId = user.getUserId();
    				if (requestURI.equals("/widget/chkStatus")) { // Max Count 얻어오기 위한 url 호출
     					boolean timechk = false;
    					if (request.getParameter("timex") == null)
    						timechk = false;
    					else
    						timechk = Boolean.parseBoolean(request.getParameter("timex"));

    					if (timechk) {
    						setInitCookie(response, "IC_"+session.getId(), "1", -1);
    						request.setAttribute("gAlarm", false);
    					} else {
    						request.setAttribute("gAlarm", false);
    						Map<String, Object> myMap = new HashMap<String, Object>();
    						myMap.put("userId", userId);
    						myMap.put("sessionId", session.getId());

    						int curCntMin = 1;
    						Cookie[] cookie = request.getCookies();
    						String jsessionId = "";
    						boolean chkcookie = false;

    						if (cookie != null) {
    							for (int k = 0; k < cookie.length; k++) {
    								if (cookie[k].getName().equals("JSESSIONID")) {
    									jsessionId = "IC_"+cookie[k].getValue();
    									break;
    								}
    							}

    							if (!"".equals(jsessionId)) {
    								for (int k = 0; k < cookie.length; k++) {
    									if (cookie[k].getName().equals(jsessionId)) {
    										if (cookie[k].getValue() == null || cookie[k].getValue().equals("")
    												|| Integer.parseInt((String) cookie[k].getValue()) < 0) {
    											setInitCookie(response, jsessionId, "1", -1);
    										} else {
    											curCntMin = Integer.parseInt(((String) cookie[k].getValue()));
    										}
    										chkcookie = true;
    										break;
    									}
    								}
    								if (chkcookie == false) {
    									setInitCookie(response, jsessionId, "1", -1);
    									curCntMin = 1;
    								}
    							} else {
    								// 쿠키예 JSESSIONID의 값이 없을 수 없음
    								// exception 처리 필요
    							}
    						}

    						int stimeOutSec = Integer.parseInt(sessionTimeout); // 관리자가 설정한 session 유지시간

    						// 정상적인 session time 설정 (무제한 제외, 1분 이하 제외)
    						if (stimeOutSec > 60) {
    							int stimeOutMin = stimeOutSec / 60 / 5; //5분씩 구동되므로  5분의로 count 생성 

    							if (stimeOutMin - 1 < curCntMin) { // timeout 3분전에 안내 메시지 제공 (1부터 시작하고 로그인후 바로 1번 호출되므로 1를 더 빼야함) 1로 설정
    								request.setAttribute("gAlarm", true);
    							} else { // 1회 추가
    								for (int k = 0; k < cookie.length; k++) {
    									if (cookie[k].getName().equals(jsessionId)) {
    										if (cookie[k].getValue() == null || cookie[k].getValue().equals("")
    												|| Integer.parseInt((String) cookie[k].getValue()) < 0) {
    											setInitCookie(response, jsessionId, "1", -1);
    										} else {
    											int jsessioncnt = Integer.parseInt(cookie[k].getValue()) + 1;
    											setInitCookie(response, jsessionId, Integer.toString(jsessioncnt), -1);
    										}
    										break;
    									}
    								}
    							}
    						} else { // 무제한이나 1분 이하 인경우
    							request.setAttribute("gAlarm", false);
    						}
    					}
    				} else if (!requestURI.equals("/widget/chkStatus") && 
    						   !requestURI.equals("/dash/receiveProcessList") &&  
    						   !requestURI.equals("/dash/receiveProcessCnt") &&
    						   !requestURI.equals("/dash/selectMainIPOperateCnt") &&
    						   requestURI.indexOf("/widget/data/") < 0) { // 일반적인 호출일때 초기화
    					if (session.getId() != null) {
    						setInitCookie(response, "IC_"+session.getId(), "1", -1);
    					}
    					request.setAttribute("gAlarm", false);
    				}
                    */

                    //////////////////////////////////////////
                	// session 체크를 위한 로직 추가 2022.12.06 end
                	//////////////////////////////////////////
                    /*
                    if(handler instanceof HandlerMethod == true) {
                       HandlerMethod handlerMethod = (HandlerMethod) handler;
                       if(!requestURI.contains("/dash/detail") && !requestURI.contains("/user/userPwChange")) {
                           Map<String, Object> map = new HashMap<String, Object>();
                           map.put("menuUrl", requestURI);
                           //원본소스 주석처리 22.08.23
                           //유저그룹 아이디에서 유저 uid로 변경 주석 처리 나중에 적용 22.08.23
                           map.put("groupId", user.getUid());
                            
                           int menuCnt = menuService.selectMenuIdCnt(map);
                           //메뉴별 권한 수정. 22.09.02
                           int AuthCnt = menuService.selectMenuIdCntByAuth(map);
                           if(menuCnt == 0) {
                               throw new ProcessException("권한이 없습니다.");
                           }else {
                           	   //메뉴별 권한 저장. 22.08.25
                           	   request.setAttribute("AuthCnt", AuthCnt);
                           }
                       }
                   }
                   */
    			}
            }
        }

        return super.preHandle(request, response, handler);
    }
    
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// MENU AUTH
	}
    
    private void printParameter(HttpServletRequest request) throws Exception {
        Enumeration<?> paramNames = request.getParameterNames();
        
        while (paramNames.hasMoreElements()) {
            String name = (String) paramNames.nextElement();
            String[] values = request.getParameterValues(name);
            if(values==null || values.length==0) {
                return;
            }
            for(String value : values) {
                String paramlog = String.format("req.getParameter(\"%s\") = %s", name, value);
                if(values.length > 1) {
                    paramlog = String.format("req.getParameter(\"%s[]\") = %s", name, value);
                }
                log.debug("["+this.getClass().getSimpleName()+"][printParameter] paramlog : " + paramlog);
            }
        }
    }
    
	private void setInitCookie(HttpServletResponse response, String key, String value, int val) {
		Cookie ck = new Cookie(key, value);
		ck.setMaxAge(val);
		ck.setPath("/");
		if (val == 0) {
			ck.setSecure(false);
		}
		response.addCookie(ck);
	}
}