package com.moadata.bdms.login.repository;

import org.springframework.stereotype.Repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.LoginVO;

/**
 * Login Dao
 */
@Repository("loginDao")
public class LoginDao extends BaseAbstractDao {
	public LoginVO selectLoginInfo(String userId) {
		return (LoginVO) selectOne("login.selectLoginInfo", userId);
	}
	public void updateLoginDt(String userId) {
		update("login.updateLoginDt", userId);
	}
	//로그인 실패 기록 추가 22.08.23
	public void updateLoginUser(LoginVO login) {
		update("login.updateLoginUser", login);
	}
	//로그인 3개월 초과된 id 잠금 
	public void updateLockUser(LoginVO login) {
		update("login.updateLockUser", login);
	}	
	//연속 5회 패스워드 실패 시 10분간 로그인 차단 22.08.23
	public int selectLoginLockCk(String userId) {
		return (int) selectOne("login.selectLoginLockCkCnt", userId);
	}
	
	//로그인 유저 비밀번호 변경 추가 22.08.29
	public void updateLoginUserPw(LoginVO login) {
		update("login.updateLoginUserPw", login);
	}	
}