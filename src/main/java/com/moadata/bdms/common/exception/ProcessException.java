package com.moadata.bdms.common.exception;

import java.text.MessageFormat;
import java.util.Locale;

import org.springframework.context.MessageSource;

/**
 * ProcessException : 비즈니스 서비스 구현체에서 발생시키는 Exception 
 */
public class ProcessException extends BaseException {
    private static final long serialVersionUID = 1L;

    /**
     * ProcessException 생성자
     */
    public ProcessException() {
        this("BaseException without message", null, null);
    }

    /**
     * ProcessException 생성자
     * @param defaultMessage 메세지 지정
     */
    public ProcessException(String defaultMessage) {
        this(defaultMessage, null, null);
    }
    
    /**
     * ProcessException 생성자
     * @param defaultMessage 메세지 지정
     * @param wrappedException 발생한 Exception 내포함
     */
    public ProcessException(String defaultMessage, Exception wrappedException) {
        this(defaultMessage, null, wrappedException);
    }

    /**
     * ProcessException 생성자
     * @param defaultMessage 메세지 지정(변수지정)
     * @param messageParameters 치환될 메세지 리스트
     * @param wrappedException 발생한 Exception 내포함.
     */
    public ProcessException(String defaultMessage, Object[] messageParameters, Exception wrappedException) {
        String userMessage = defaultMessage;
        if (messageParameters != null) {
            userMessage = MessageFormat.format(defaultMessage, messageParameters);
        }
        this.message = userMessage;
        this.wrappedException = wrappedException;
    }
    
    /**
     * ProcessException 생성자
     * @param messageSource 메세지 리소스
     * @param messageKey 메세지키값
     */
    public ProcessException(MessageSource messageSource, String messageKey) {
        this(messageSource, messageKey, null, null, Locale.getDefault(), null);
    }
    
    /**
     * ProcessException 생성자
     * @param messageSource 메세지 리소스
     * @param messageKey 메세지키값
     * @param wrappedException 발생한 Exception 내포함.
     */
    public ProcessException(MessageSource messageSource, String messageKey, Exception wrappedException) {
        this(messageSource, messageKey, null, null, Locale.getDefault(), wrappedException);
    }

    public ProcessException(MessageSource messageSource, String messageKey, Locale locale, Exception wrappedException) {
        this(messageSource, messageKey, null, null, locale, wrappedException);
    }

    public ProcessException(MessageSource messageSource, String messageKey, Object[] messageParameters, Locale locale,
            Exception wrappedException) {
        this(messageSource, messageKey, messageParameters, null, locale, wrappedException);
    }

    public ProcessException(MessageSource messageSource, String messageKey, Object[] messageParameters,
            Exception wrappedException) {
        this(messageSource, messageKey, messageParameters, null, Locale.getDefault(), wrappedException);
    }

    public ProcessException(MessageSource messageSource, String messageKey, Object[] messageParameters,
            String defaultMessage, Exception wrappedException) {
        this(messageSource, messageKey, messageParameters, defaultMessage, Locale.getDefault(), wrappedException);
    }

    public ProcessException(MessageSource messageSource, String messageKey, Object[] messageParameters,
            String defaultMessage, Locale locale, Exception wrappedException) {
        this.messageKey = messageKey;
        this.messageParameters = messageParameters;
        this.message = messageSource.getMessage(messageKey, messageParameters, defaultMessage, locale);
        this.wrappedException = wrappedException;
    }
}