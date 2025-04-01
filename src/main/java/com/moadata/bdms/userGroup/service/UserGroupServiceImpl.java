package com.moadata.bdms.userGroup.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
//import com.moadata.hsmng.dash.service.DashService;
import com.moadata.bdms.model.vo.MenuVO;
import com.moadata.bdms.model.vo.UserGroupVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.service.UserService;
import com.moadata.bdms.userGroup.repository.UserGroupDao;

/**
 * UserGroup Service 구현
 */
@Service(value = "userGroupService")
public class UserGroupServiceImpl implements UserGroupService {
	@Resource(name="userGroupDao")
	private UserGroupDao userGroupDao;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
//	@Resource(name = "dashService")
//	private DashService dashService;

	@Override
	public List<UserGroupVO> selectUserGroupCodeList() {
		return userGroupDao.selectUserGroupCodeList();
	}
	
	@Override
	public List<UserGroupVO> selectUserGroupList(UserGroupVO userGroup) {
		String filtersString = userGroup.getFilters();
		if(!StringUtils.isEmpty(filtersString)) {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> variables = new HashMap<String, Object>();
			
			try {
				variables = mapper.readValue(filtersString, new TypeReference<Map<String, Object>>(){});
				userGroup.setFiltersMap(variables);
			} catch (JsonParseException e) {
				Assert.isTrue(false, e.toString());
			} catch (JsonMappingException e) {
				Assert.isTrue(false, e.toString());
			} catch (IOException e) {
				Assert.isTrue(false, e.toString());
			}
			
			if(variables.size() == 0) {
				Assert.isTrue(false, "Invalid Data Query");
			}
		}
		return userGroupDao.selectUserGroupList(userGroup);
	}
	
	@Override
	public List<UserVO> selectUserListByUserGroupId(UserVO user) {
		String filtersString = user.getFilters();
		if(!StringUtils.isEmpty(filtersString)) {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> variables = new HashMap<String, Object>();
			
			try {
				variables = mapper.readValue(filtersString, new TypeReference<Map<String, Object>>(){});
				user.setFiltersMap(variables);
			} catch (JsonParseException e) {
				Assert.isTrue(false, e.toString());
			} catch (JsonMappingException e) {
				Assert.isTrue(false, e.toString());
			} catch (IOException e) {
				Assert.isTrue(false, e.toString());
			}
			
			if(variables.size() == 0) {
				Assert.isTrue(false, "Invalid Data Query");
			}
		}
		return userGroupDao.selectUserListByUserGroupId(user);
	}
	
	@Override
	public List<UserVO> selectUserListByUnUserGroup(UserVO user) {
		String filtersString = user.getFilters();
		if(!StringUtils.isEmpty(filtersString)) {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> variables = new HashMap<String, Object>();
			
			try {
				variables = mapper.readValue(filtersString, new TypeReference<Map<String, Object>>(){});
				user.setFiltersMap(variables);
			} catch (JsonParseException e) {
				Assert.isTrue(false, e.toString());
			} catch (JsonMappingException e) {
				Assert.isTrue(false, e.toString());
			} catch (IOException e) {
				Assert.isTrue(false, e.toString());
			}
			
			if(variables.size() == 0) {
				Assert.isTrue(false, "Invalid Data Query");
			}
		}
		return userGroupDao.selectUserListByUnUserGroup(user);
	}
	
	@Override
	public UserGroupVO selectUserGroupInfo(String userGroupId) {
		return userGroupDao.selectUserGroupInfo(userGroupId);
	}
	
	@Override
	public void insertUserGroup(UserGroupVO userGroup) throws Exception {
		int groupIdCnt = userGroupDao.selectUserGroupIdCnt(userGroup.getUsergroupNm());
		Assert.isTrue(groupIdCnt == 0, "사용자 그룹 이름이 이미 존재합니다.");
		
		// INSERT USERGROUP
		userGroupDao.insertUserGroup(userGroup);
		
		// INSERT DASH
		//dashService.insertDashByUserGroup(userGroup.getRegistId(), userGroup.getUsergroupId());
	}
	
	@Override
	public void updateUserGroup(UserGroupVO userGroup) {
		UserGroupVO userGroupInfo = userGroupDao.selectUserGroupInfo(userGroup.getUsergroupId());
		Assert.notNull(userGroupInfo, "사용자 그룹 정보가 존재하지 않습니다.");
		
		/*int groupIdCnt = userGroupDao.selectUserGroupIdCnt(userGroup.getGroupId());
		Assert.isTrue(groupIdCnt == 0, "사용자 그룹 아이디가 이미 존재합니다.");*/
		
		// UPDATE USERGROUP
		userGroupDao.updateUserGroup(userGroup);
	}
	
	@Override
	public void userGroupUserUpdate(UserGroupVO userGroup) {
		String updateList = userGroup.getUserList();
		Assert.notNull(updateList, "업데이트 정보가 존재하지 않습니다.");
		
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			UserVO[] list = mapper.readValue(userGroup.getUserList(), UserVO[].class);
			for(UserVO user : list) {
				// UPDATE USERGROUP
				user.setModifyId(userGroup.getModifyId());
				if(!user.getUid().equals("USR_000000000000")) {
					userService.updateUserGroupId(user);
				}
				//Assert.isTrue(user.getUid().equals("USR_000000000000"), "슈퍼사용자는 편집  할 수 없습니다.");
				
			}
		} catch (JsonParseException e) {
			e.printStackTrace();
			Assert.isTrue(false, e.toString());
		} catch (JsonMappingException e) {
			e.printStackTrace();
			Assert.isTrue(false, e.toString());
		} catch (IOException e) {
			e.printStackTrace();
			Assert.isTrue(false, e.toString());
		}
	}
	
	//2차
	@Override
	public void userGroupAgentGroupUpdate(UserGroupVO userGroup) {
		UserGroupVO userGroupInfo = userGroupDao.selectUserGroupInfo(userGroup.getUsergroupId());
		Assert.notNull(userGroupInfo, "사용자 그룹 정보가 존재하지 않습니다.");
	}
	
	@Override
	public void userGroupMenuUpdate(UserGroupVO userGroup) {
		UserGroupVO userGroupInfo = userGroupDao.selectUserGroupInfo(userGroup.getUsergroupId());
		Assert.notNull(userGroupInfo, "사용자 그룹 정보가 존재하지 않습니다.");
		
		Map<String, Object> map;
		try {

			List<MenuVO> userGroupMenuList = menuService.selectMenuIdByGroup(userGroup.getUsergroupId());

			//MENU 권한 삭제
			for(String delMenuId : userGroup.getDelMenuIds().split(",")) {
				for(MenuVO vo: userGroupMenuList) {
					if(vo.getMenuId().equals(delMenuId)) {
						map = new HashMap<String, Object>(); 
						map.put("usergroupId", userGroupInfo.getUsergroupId());
						map.put("menuId", delMenuId);
						
						menuService.deleteUserGroupMenu(map);
					}
				}
			}
			
			//MENU 권한 등록 및 수정
			for(String menuId : userGroup.getMenuIds().split(",")) {
				map = new HashMap<String, Object>(); 
				map.put("usergroupId", userGroupInfo.getUsergroupId());
				map.put("menuId", menuId);
				map.put("registId", userGroup.getRegistId());
				
				menuService.updateUserGroupMenu(map);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void deleteUserGroupList(UserGroupVO userGroup) {
		for(String userGroupId : userGroup.getUIds().split(",")) {
			UserGroupVO userGroupInfo = userGroupDao.selectUserGroupInfo(userGroupId);
			Assert.notNull(userGroupInfo, "사용자 그룹 정보가 존재하지 않습니다.");
			
			int userCnt = userService.selectUserCntByUserGroupId(userGroupId);
			Assert.isTrue(userCnt == 0, "[" + userGroupInfo.getUsergroupNm() + "]" +" - 구성원이 존재하는 사용자 그룹은 삭제할 수 없습니다. 먼저 구성원을 이동하십시오.");
			
			// DELETE USERGROUP MENU
			userGroupDao.deleteUserGroupMenu(userGroupId);
			
			// DELETE DASHBOARD
			//dashService.deleteDashByUserGroupId(userGroupId);
			
			// DELETE USERGROUP
			userGroupDao.deleteUserGroup(userGroupId);
		}
	}
}
