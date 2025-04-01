package com.moadata.bdms.common.exception.aspect;

import java.util.Locale;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.dao.DataAccessException;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import com.moadata.bdms.common.exception.BaseException;
import com.moadata.bdms.common.exception.ProcessException;
import com.moadata.bdms.common.exception.manager.ExceptionHandlerService;

/**
 * Exception 발생시 AOP(after-throwing) 에 의해 후처리로직 연결고리 역할 수행하는 클래스이다.
 * 
 * <p><b>NOTE:</b> Exception 종류를 ProcessException, RuntimeException(DataAccessException 포함),
 * 나머지 Exception 으로 나누고 있으며, 후처리로직은 ProcessException, RuntimeException 에서만 동작한다.
 * 그리고 나머지 Exception 의 경우 Exception 을 BaseException (메세지: fail.common.msg)으로 재생성하여 변경 던진다. 
 * 따라서 fail.common.msg 메세지키가 Message Resource 에 정의 되어 있어야 한다.</b>
 */

public class ExceptionTransfer {
	private static final Logger LOGGER = LoggerFactory.getLogger(ExceptionTransfer.class);

	@Resource(name = "messageSource")
	private MessageSource messageSource;

	private ExceptionHandlerService[] exceptionHandlerServices;

	/**
	 * 디볼트로 패턴 매칭은 ANT 형태로 비교한다.
	 */
	private PathMatcher pm = new AntPathMatcher();

	/**
	 * ExceptionHandlerService을 여러개 지정한다.
	 * @param exceptionHandlerServices array of HandlerService
	 */
	public void setExceptionHandlerService(ExceptionHandlerService[] exceptionHandlerServices) {
		this.exceptionHandlerServices = exceptionHandlerServices;
		if (this.exceptionHandlerServices != null)
			LOGGER.debug(" count of ExceptionHandlerServices = " + exceptionHandlerServices.length);
	}
	
	/**
	 * ExceptionHandlerService을 여러개 지정한다.
	 * @return int ExceptionHandlerService 갯수 
	 */
	public int countOfTheExceptionHandlerService() {
		return (exceptionHandlerServices != null) ? exceptionHandlerServices.length : 0;
	}
	
	/**
	 * 발생한 Exception 에 따라 후처리 로직이 실행할 수 있도록 연결하는 역할을 수행한다.
	 * @param thisJoinPoint joinPoint 객체
	 * @param exception 발생한 Exception 
	 */
	public void transfer(JoinPoint thisJoinPoint, Exception exception) throws Exception {
		//LOGGER.debug("execute ExceptionTransfer.transfer ");

		Class clazz = thisJoinPoint.getTarget().getClass();
		Signature signature = thisJoinPoint.getSignature();

		Locale locale = LocaleContextHolder.getLocale();
		/**
		 * BizException 을 구분하여 후처리로직을 수행하려 했으나 고려해야 할 부분이 발생.
		 * Exception 구분하여 후처리 로직을 발생하려면 설정상에 Exception의 상세 설정이 필요하게된다.
		 * 하지만 실제 현장에서 그렇게 나누는 경우는 없다. 
		 * 클래스 정보로만 패턴 분석을 통해 Handler 로 연결해주는 고리 역할 수행을 하게 된다.
		 */
		// ProcessException 발생
		if (exception instanceof ProcessException) {
			LOGGER.debug("Exception case :: ProcessException ");

			ProcessException be = (ProcessException) exception;
			// wrapp 된 Exception 있는 경우 error 원인으로 출력해준다.
			if(be.getWrappedException() != null) {
				Throwable _throwable = be.getWrappedException();
				getLog(clazz).error(be.getMessage(), _throwable);
			} else {
				getLog(clazz).error(be.getMessage(), be.getCause());
			}

			// Exception Handler 에 발생된 Package 와 Exception 설정. (runtime 이 아닌 ExceptionHandlerService를 실행함)
			processHandling(clazz, signature.getName(), be, pm, exceptionHandlerServices);
			
			LOGGER.debug("=====================================           END          ======================================\n");
			throw be;

			// RuntimeException 발생시 내부에서 DataAccessException 인 경우 는 별도록 throw 하고 있다.
		} else if (exception instanceof RuntimeException) {
			LOGGER.debug("Exception case :: RuntimeException ");

			RuntimeException be = (RuntimeException) exception;
			getLog(clazz).error(be.getMessage(), be.getCause());

			// Exception Handler 에 발생된 Package 와 Exception 설정.
			processHandling(clazz, signature.getName(), exception, pm, exceptionHandlerServices);

			if (be instanceof DataAccessException) {
				LOGGER.debug("RuntimeException case :: DataAccessException ");
				DataAccessException sqlEx = (DataAccessException) be;
				
				LOGGER.debug("=====================================           END          ======================================\n");
				throw sqlEx;
			}
			
			LOGGER.debug("=====================================           END          ======================================\n");
			throw be;
			
			// 실행환경 확장모듈에서 발생한 Exception (요청: 공통모듈) :: 후처리로직 실행하지 않음.
		} /*else if (exception instanceof FdlException) {
			LOGGER.debug("FdlException case :: FdlException ");

			FdlException fe = (FdlException) exception;
			getLog(clazz).error(fe.getMessage(), fe.getCause());

			throw fe;

		} */else {
			//그외에 발생한 Exception 을  BaseException (메세지: fail.common.msg) 로  만들어 변경 던진다. 
			//:: 후처리로직 실행하지 않음.
			LOGGER.debug("case :: Exception ");

			getLog(clazz).error(exception.getMessage(), exception.getCause());

			throw processException(clazz, "fail.common.msg", new String[] {}, exception, locale);

		}
	}

	protected Exception processException(final Class clazz, final String msgKey, final String[] msgArgs,
	                                     final Exception e, Locale locale) {
		return processException(clazz, msgKey, msgArgs, e, locale, null);
	}

	protected Exception processException(final Class clazz, final String msgKey, final String[] msgArgs,
	                                     final Exception e, final Locale locale, ExceptionCreator exceptionCreator) {
		getLog(clazz).error(messageSource.getMessage(msgKey, msgArgs, locale), e);
		ExceptionCreator eC = null;
		if (exceptionCreator == null) {
			eC = new ExceptionCreator() {
				public Exception processException(MessageSource messageSource) {
					return new BaseException(messageSource, msgKey, msgArgs, locale, e);
				}
			};
		}
		return eC.processException(messageSource);
	}

	protected interface ExceptionCreator {
		Exception processException(MessageSource messageSource);
	}

	protected Log getLog(Class clazz) {
		return LogFactory.getLog(clazz);
	}

	/**
	 * 발생한 Exception 에 따라 후처리 로직이 실행할 수 있도록 연결하는 역할을 수행한다.
	 * 
	 * @param clazz Exception 발생 클래스 
	 * @param methodName Exception 발생 메소드명 
	 * @param exception 발생한 Exception 
	 * @param pm 발생한 PathMatcher(default : AntPathMatcher) 
	 * @param exceptionHandlerServices[] 등록되어 있는 ExceptionHandlerService 리스트
	 */
	protected void processHandling(Class clazz, String methodName, Exception exception, PathMatcher pm,
	                               ExceptionHandlerService[] exceptionHandlerServices) {
		try {
			for (ExceptionHandlerService ehm : exceptionHandlerServices) {

				if (!ehm.hasReqExpMatcher())
					ehm.setReqExpMatcher(pm);
				ehm.setPackageName(clazz.getCanonicalName()+"."+methodName);
				ehm.run(exception);

			}
		} catch (Exception e) {
		}
	}
}