package com.moadata.bdms.userGroup.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.UserGroupVO;
import com.moadata.bdms.model.vo.UserVO;

/**
 * UserGroup Dao
 */
@Repository("userGroupDao")
@SuppressWarnings("unchecked")
public class UserGroupDao extends BaseAbstractDao {
	public List<UserGroupVO> selectUserGroupCodeList() {
		return selectList("userGroup.selectUserGroupCodeList");
	}
	
	public List<UserGroupVO> selectUserGroupList(UserGroupVO userGroup) {
		List<UserGroupVO> list = selectList("userGroup.selectUserGroupList", userGroup);
		if(list.size() > 0) {
			list.get(0).setCnt((int)selectOne("userGroup.selectTotalRecords"));
		}
		return list;
	}
	
	public List<UserVO> selectUserListByUserGroupId(UserVO user) {
		List<UserVO> list = selectList("userGroup.selectUserListByUserGroupId", user);
		if(list.size() > 0) {
			list.get(0).setCnt((int)selectOne("userGroup.selectTotalRecords"));
		}
		return list;
	}
	
	public List<UserVO> selectUserListByUnUserGroup(UserVO user) {
		List<UserVO> list = selectList("userGroup.selectUserListByUnUserGroup", user);
		if(list.size() > 0) {
			list.get(0).setCnt((int)selectOne("userGroup.selectTotalRecords"));
		}
		return list;
	}
	
	public UserGroupVO selectUserGroupInfo(String userGroupId) {
		return (UserGroupVO) selectOne("userGroup.selectUserGroupInfo", userGroupId);
	}
	
	public int selectUserGroupIdCnt(String groupId) {
		return (int) selectOne("userGroup.selectUserGroupIdCnt", groupId);
	}
	
	public void insertUserGroup(UserGroupVO userGroup) {
		insert("userGroup.insertUserGroup", userGroup);
	}
	
	public void updateUserGroup(UserGroupVO userGroup) {
		update("userGroup.updateUserGroup", userGroup);
	}
	
	public void deleteUserGroup(String userGroupId) {
		delete("userGroup.deleteUserGroup", userGroupId);
	}
	
	public void deleteUserGroupMenu(String userGroupId) {
		delete("userGroup.deleteUserGroupMenu", userGroupId);
	}
}