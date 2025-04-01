package com.moadata.bdms.userGroup.service;

import java.util.List;

import com.moadata.bdms.model.vo.UserGroupVO;
import com.moadata.bdms.model.vo.UserVO;

/**
 * UserGroup Service Interface
 */
public interface UserGroupService {
	
	/**
	 * 사용자그룹 목록
	 * 
	 * @param userGroup
	 * @return
	 */
	public List<UserGroupVO> selectUserGroupCodeList();
	
	/**
	 * 사용자그룹 목록
	 * 
	 * @param userGroup
	 * @return
	 */
	public List<UserGroupVO> selectUserGroupList(UserGroupVO userGroup);
	
	/**
	 * 사용자 목록 - 사용자 그룹 아이디
	 * 
	 * @param user
	 * @return
	 */
	public List<UserVO> selectUserListByUserGroupId(UserVO user);
	
	/**
	 * 미등록 사용자 목록 
	 * 
	 * @param user
	 * @return
	 */
	public List<UserVO> selectUserListByUnUserGroup(UserVO user); 
	
	/**
	 * 사용자그룹 상세
	 * 
	 * @param userGroupId
	 * @return
	 */
	public UserGroupVO selectUserGroupInfo(String userGroupId);
	
	/**
	 * 사용자그룹 등록
	 * 
	 * @param userGroup
	 */
	public void insertUserGroup(UserGroupVO userGroup) throws Exception;
	
	/**
	 * 사용자그룹 수정
	 * 
	 * @param userGroup
	 */
	public void updateUserGroup(UserGroupVO userGroup);
	
	/**
	 * 사용자그룹 사용자 수정
	 * 
	 * @param userGroup
	 */
	public void userGroupUserUpdate(UserGroupVO userGroup);
	
	/**
	 * 사용자그룹 에이전트 그룹 수정
	 * 
	 * @param userGroup
	 */
	public void userGroupAgentGroupUpdate(UserGroupVO userGroup);
	
	/**
	 * 사용자그룹 메뉴 수정
	 * 
	 * @param userGroup
	 */
	public void userGroupMenuUpdate(UserGroupVO userGroup);
	
	/**
	 * 사용자그룹 삭제
	 * 
	 * @param userGroup
	 */
	public void deleteUserGroupList(UserGroupVO userGroup);
}