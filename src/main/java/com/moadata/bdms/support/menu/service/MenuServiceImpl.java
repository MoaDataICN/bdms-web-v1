package com.moadata.bdms.support.menu.service;

import com.moadata.bdms.model.vo.MenuVO;
import com.moadata.bdms.support.menu.repository.MenuDao;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;
import java.util.Map;

/**
 * Menu Service 구현
 */
@Service(value = "menuService")
public class MenuServiceImpl implements MenuService {
	@Resource(name="menuDao")
	private MenuDao menuDao;
	
	//selectMenuListPermission 함수 추가 22.08.22
	@Override
	public List<MenuVO> selectMenuListPermission(String groupId) {
		return menuDao.selectMenuListPermission(groupId);
	}
	
	@Override
	public List<MenuVO> selectMenuList(Boolean displayAll) {
		return menuDao.selectMenuList(displayAll);
	}
	
	@Override
	public List<MenuVO> selectMenuListByGroup(String groupId) {
		return menuDao.selectMenuListByGroup(groupId);
	}
	
	@Override
	public String selectMenuStartUrl(String groupId) {
		return menuDao.selectMenuStartUrl(groupId);
	}

	@Override
	public List<MenuVO> selectMenuListByPath(Map<String, Object> map) {
		return menuDao.selectMenuListByPath(map);
	}
	
	@Override
	public int selectMenuIdCnt(Map<String, Object> map) {
		return menuDao.selectMenuIdCnt(map);
	}

	@Override
	public List<MenuVO> selectMenuIdByGroup(String usergroupId) {
		return menuDao.selectMenuIdByGroup(usergroupId);
	}

	@Override
	public void updateUserGroupMenu(Map<String, Object> map) {
		menuDao.updateUserGroupMenu(map);
	}

	@Override
	public void deleteUserGroupMenu(Map<String, Object> map) {
		menuDao.deleteUserGroupMenu(map);
	}
	
	@Override
	public void deleteUserGroupMenuAll(Map<String, Object> map) {
		menuDao.deleteUserGroupMenuAll(map);
	}	
	// 권한에 의한 메뉴존재 확인 추가 22.09.0
	@Override
	public int selectMenuIdCntByAuth(Map<String, Object> map) {
		return menuDao.selectMenuIdCntByAuth(map);
	}	
	
}
