package com.moadata.bdms.common.exception.handler;

/**  
 * @Class Name : ServiceExceptionHandler.java
 * @Description : ServiceExceptionHandler Class
 * @Modification Information  
 */
public class ServiceExceptionHandler implements ExceptionHandler {
	//@Resource(name = "otherSSLMailSender")
	//private SimpleSSLMail mailSender;
	//protected Log log = LogFactory.getLog(this.getClass());
	
	public void occur(Exception ex, String packageName) {
		//log.debug(" ServiceExceptionHandler run...............");

		try {
			// 발생한 Exception 메일 발송
			//mailSender.send(ex, packageName);
			//log.debug(" ServiceExceptionHandler try ");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}