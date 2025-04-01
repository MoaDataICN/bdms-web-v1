package com.moadata.bdms.common.exception.handler;

/**
 * Exception 발생시 실행되는 Handler 인터페이스이다.
 * 구현체는 occur 메소드만 구현해주고 설정해주면 실행된다.
 */
public interface ExceptionHandler {

	/**
	 * occur 메소드
	 * @param exception 실제로 발생한 Exception 
	 * @param packageName Exception 발생한 클래스 패키지정보
	 */
	public void occur(Exception exception, String packageName);
}