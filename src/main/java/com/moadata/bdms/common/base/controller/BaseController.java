package com.moadata.bdms.common.base.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.Locale;

/**
 * 조회 및 등록,수정,삭제를 위한 Web Controller의 부모 클래스<br/>
 * 모든 Controller는 본 클래스를 상속받는다
 */
public abstract class BaseController {
	/**
	 * 모든 상속 클래스를 위한 로그
	 */
	protected final Logger LOGGER = LoggerFactory.getLogger(this.getClass().getCanonicalName());
	
	@Autowired
	protected MessageSource messageSource = null;
	
	/**
	 * RequestAttrribute내의 해당 키에 해당되는 클래스가 존재여부 조회
	 *
	 * @param key 조회대상 RequestAttrribute Key
	 * @return 존재여부
	 */
	public Object getModelAttribute(String key) {
		return RequestContextHolder.currentRequestAttributes().getAttribute(key, RequestAttributes.SCOPE_REQUEST);
	}
	
	/**
	 * RequestAttrribute내의 해당 키에 해당되는 클래스가 존재여부 조회
	 *
	 * @param key 조회대상 RequestAttrribute Key
	 * @return 존재여부
	 */
	public void setModelAttribute(String key, Object object) {
		RequestContextHolder.currentRequestAttributes().setAttribute(key, object, RequestAttributes.SCOPE_REQUEST);
	}
	
	/**
	 * 리소스번들에서 메시지 값 조회
	 * 
	 * @param messageCode 리소스번들의 코드값
	 * @param messageParameters array of arguments that will be filled in for
	 *            params within the message (params look like "{0}", "{1,date}",
	 *            "{2,time}" within a message)
	 * @param defaultMessage 리소스번들 조회 실패시 기본 제공 메시지
	 * @return 코드값에 해당하는 리소스 값
	 */
	public String getMessage(String messageCode, Object[] messageParameters, String defaultMessage) {
		Locale locale = Locale.getDefault();
		return this.messageSource.getMessage(messageCode, messageParameters, defaultMessage, locale);
	}
	
	/**
	 * 리소스번들에서 메시지 값 조회
	 * 
	 * @param messageCode 리소스번들의 코드값
	 * @param messageParameters array of arguments that will be filled in for
	 *            params within the message (params look like "{0}", "{1,date}",
	 *            "{2,time}" within a message)
	 * @param defaultMessage 리소스번들 조회 실패시 기본 제공 메시지
	 * @param locale 로케일
	 * @return 코드값에 해당하는 리소스 값
	 */
	public String getMessage(String messageCode, Object[] messageParameters, String defaultMessage, Locale locale) {
		return this.messageSource.getMessage(messageCode, messageParameters, defaultMessage, locale);
	}
	
	/**
	 * WebApplicationContext를 반환<br/>
	 * 
	 * @return
	 */
	public WebApplicationContext getWebApplicationContext() {
		return ContextLoader.getCurrentWebApplicationContext();
	}
	
	/**
	 * 세션에 저장된 Attribute를 반환<br/>
	 * Attribute를 가져오는 예시<br/>
	 * 
	 * <pre>
	 * <code>
	 * // Session에 저장된 Object를 가져오기. 만일 HttpSession에 Member객체를 'member' 라는 name으로 넣었을 경우
	 * Member member = (Member)getRequestAttribute("member");
	 * </code>
	 * </pre>
	 * 
	 * @param name - Attribute name
	 * @return
	 */
	public Object getRequestAttribute(String name) {
		return RequestContextHolder.currentRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
	}
	
	/**
	 * 세션에 Attribute를 저장</br> Attribute를 저장하는 예시<br/>
	 * 
	 * <pre>
	 * <code>
	 * // Session에 Member Object를 'member'라는 name으로 저장할 경우
	 * setRequestAttribute("member",member);
	 * </code>
	 * </pre>
	 * 
	 * @param name - Attribute name
	 * @param value - Attribute value
	 */
	public void setRequestAttribute(String name, Object value) {
		RequestContextHolder.currentRequestAttributes().setAttribute(name, value, RequestAttributes.SCOPE_SESSION);
	}
}