package com.moadata.bdms.login.service;

import com.moadata.bdms.model.vo.LoginVO;

/**
 * Login Service Interface
 */
public interface LoginService {
	/**
	 * 로그인 확인
	 *
	 * @param userId
	 * @return
	 */
	public LoginVO selectLoginInfo(String userId);
	
	/**
	 * 로그인 일자 갱신
	 * 
	 * @param userId
	 */
	public void updateLoginDt(String userId);
	
	/**
     * 로그인 실패 기록 추가 22.08.23
     *
     * @param login
     */
	void updateLoginUser(LoginVO login);
	
	/**
	 * 연속 5회 패스워드 실패 시 10분간 로그인 차단 추가 22.08.24
	 * 
	 * @param userId
	 * @return 
	 */
	public int selectLoginLockCk(String userId);	
	
	
	/**
	 * 로그인 유저 비밀번호 변경 추가 22.08.29
	 */
	public void updateLoginUserPw(LoginVO login);		

}