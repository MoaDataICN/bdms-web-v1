package com.moadata.bdms.group.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("groupDao")
public class GroupDao extends BaseAbstractDao {

	public String selectMaxDepth() {
		return (String)selectOne("group.selectMaxDepth");
	}

	public List<GroupVO> selectSectionList(){
		return selectList("group.selectSectionList");
	}

	public List<GroupVO> selectChildList(String grpId) {
		return selectList("group.selectChildList", grpId);
	}

	public void deleteGroupsByIds(List<String> grpIds) {
		delete("group.deleteGroupsByIds", grpIds);
	}

	public void insertUpdateGroup(GroupVO groupVO) {
		insert("group.insertUpdateGroup", groupVO);
	}

	/** 25.03.27 */
	public List<GroupVO> selectLowLevelGroups(String grpId) {
		return selectList("group.selectLowLevelGroups", grpId);
	}

	public List<UserVO> selectLowLevelAdmins(String grpId) {
		return selectList("group.selectLowLevelAdmins", grpId);
	}
}