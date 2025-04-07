package com.moadata.bdms.common.intercepter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
	private static final Logger LOGGER = LoggerFactory.getLogger(LoggerInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("======================================          START         ======================================");
			LOGGER.debug(" Request URI \t:  " + request.getRequestURI());
			printParameter(request);
		}
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("=====================================           END          ======================================\n");
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("=====================================           FINALLY          ======================================\n");

		}
	}

	private void printParameter(HttpServletRequest request) throws Exception {
		Enumeration<?> paramNames = request.getParameterNames();
		while(paramNames.hasMoreElements()) {
			String name = (String) paramNames.nextElement();
			String[] values = request.getParameterValues(name);
			if(values == null || values.length == 0) {
				return;
			}
			
			for(String value : values) {
				String paramlog = "";
				if(!name.toUpperCase().contains("PASSWORD") && !name.toUpperCase().contains("PWD") && !name.toUpperCase().contains("USERPW")) {
					paramlog = String.format("%s=%s", name, value);
					if(values.length > 1) {
						paramlog = String.format("%s[]=%s", name, value);	
					}
				} else {
					String tmpPwd = "";
					for(int i = 0; i < value.length(); i++) {
						tmpPwd += "*";
					}
					paramlog = String.format("%s=%s", name, tmpPwd);
				}
				LOGGER.debug("Param => " + paramlog);
			}
		}
	}
}