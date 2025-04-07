package com.moadata.bdms.login.service;

import javax.annotation.Resource;

import com.moadata.bdms.model.vo.LoginVO;
import org.springframework.stereotype.Service;

import com.moadata.bdms.login.repository.LoginDao;
import com.moadata.bdms.model.vo.LoginVO;

/**
 * Login Service 구현
 */
@Service(value = "loginService")
public class LoginServiceImpl implements LoginService {
	@Resource(name="loginDao")
	private LoginDao loginDao;
	
	/**
	 * 로그인 확인
	 */
	@Override
	public LoginVO selectLoginInfo(String userId) {
		return loginDao.selectLoginInfo(userId);
	}
	
	/**
	 * 로그인 일자 갱신
	 */
	@Override
	public void updateLoginDt(String userId) {
		loginDao.updateLoginDt(userId);
	}
	
	/**
	 * 로그인 실패 횟수 등록 확인 추가 22.08.23
	 */
	@Override
	public void updateLoginUser(LoginVO login) {
		loginDao.updateLoginUser(login);
		loginDao.updateLockUser(login);
	}
	
	/**
	 * 연속 5회 패스워드 실패 시 10분간 로그인 차단 추가 22.08.24	 	
	 */
	@Override
	public int selectLoginLockCk(String userId) {
		return loginDao.selectLoginLockCk(userId);
	}	
	
	/**
	 * 로그인 유저 비밀번호 변경 추가 22.08.29
	 */
	@Override
	public void updateLoginUserPw(LoginVO login) {
		loginDao.updateLoginUserPw(login);
	}	
}
