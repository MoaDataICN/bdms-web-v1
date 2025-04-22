package com.moadata.bdms.admin.service;

import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserVO;

import java.util.List;
import java.util.Map;

public interface AdminService {
	public List<UserVO> selectAdminList(UserVO userVO);
	public void insertAdmin(UserVO user) throws Exception;
	public int selectAdminIdCnt(String userId);
	public List<Map> selectManagerGroupList(String grpId);
	public void updateAdmin(UserVO user);
}