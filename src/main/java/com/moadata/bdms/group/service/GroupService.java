package com.moadata.bdms.group.service;

import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserVO;

import java.util.List;

public interface GroupService {
	public String selectMaxDepth();
	public List<GroupVO> selectSectionList();
	public List<GroupVO> selectChildList(String grpId);

	void deleteGroupsByIds(List<String> grpId);
	public void updateGroupList(List<GroupVO> groupList, String parentId);

	/** 25.03.27 */
	public List<GroupVO> selectLowLevelGroups(String grpId);
	public List<UserVO> selectLowLevelAdmins(String grpId);
}