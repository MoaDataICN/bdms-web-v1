package com.moadata.bdms.group.service;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.group.repository.GroupDao;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Service(value = "groupService")
public class GroupServiceImpl implements GroupService {
	@Resource(name="groupDao")
	private GroupDao groupDao;

	public String selectMaxDepth() {
		return groupDao.selectMaxDepth();
	}

	public List<GroupVO> selectSectionList(){
		return groupDao.selectSectionList();
	}

	public List<GroupVO> selectChildList(String grpId) {
		return groupDao.selectChildList(grpId);
	}

	public void deleteGroupsByIds(List<String> grpId) {
		groupDao.deleteGroupsByIds(grpId);
	}

	public void updateGroupList(List<GroupVO> groupList, String parentId) {
		List<GroupVO> existingChildren = groupDao.selectChildList(parentId);

		List<String> existingIds = existingChildren.stream()
				.map(GroupVO::getGrpId)
				.collect(Collectors.toList());

		List<String> incomingIds = groupList.stream()
				.filter(child -> child.getGrpId() != null)
				.map(GroupVO::getGrpId)
				.collect(Collectors.toList());

		List<String> toDelete = existingIds.stream()
				.filter(id -> !incomingIds.contains(id))
				.collect(Collectors.toList());

		if (!toDelete.isEmpty()) {
			groupDao.deleteGroupsByIds(toDelete);
		}

		// 5. 추가 및 수정 처리
		for (GroupVO child : groupList) {
			if (child.getGrpId() != null) {
				groupDao.insertUpdateGroup(child);
			}
		}
	}

	@Override
	public List<GroupVO> selectLowLevelGroups(String grpId) {
		return groupDao.selectLowLevelGroups(grpId);
	}

	@Override
	public List<UserVO> selectLowLevelAdmins(String grpId) {
		List<UserVO> adminsList = groupDao.selectLowLevelAdmins(grpId);

		try {
			if(adminsList.size() > 0) {
				for(UserVO user : adminsList) {
					user.setUserNm(EncryptUtil.decryptText(user.getUserNm()));
				}
			}
			return adminsList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
