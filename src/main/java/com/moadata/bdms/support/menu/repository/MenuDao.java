package com.moadata.bdms.support.menu.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.MenuVO;

/**
 * Menu Dao
 */
@Repository("menuDao")
@SuppressWarnings("unchecked")
public class MenuDao extends BaseAbstractDao {
	//selectMenuListPermission 함수 추가 22.08.22
	public List<MenuVO> selectMenuListPermission(String groupId) {
		return selectList("menu.selectMenuListPermission", groupId);
	}
	
	public List<MenuVO> selectMenuList(Boolean displayAll) {
		return selectList("menu.selectMenuList", displayAll);
	}
	
	public List<MenuVO> selectMenuListByGroup(String groupId) {
		return selectList("menu.selectMenuListByGroup", groupId);
	}
	
	public String selectMenuStartUrl(String groupId) {
		return (String) selectOne("menu.selectMenuStartUrl", groupId);
	}
	
	public List<MenuVO> selectMenuListByPath(Map<String, Object> map) {
		return selectList("menu.selectMenuListByPath", map);
	}
	
	public int selectMenuIdCnt(Map<String, Object> map) {
		return (int) selectOne("menu.selectMenuIdCnt", map);
	}
	
	public List<MenuVO> selectMenuIdByGroup(String usergroupId) {
		return selectList("menu.selectMenuIdByGroup", usergroupId);
	}
	
	public void updateUserGroupMenu(Map<String, Object> map) {
		update("menu.updateUserGroupMenu", map);
	}
	
	public void deleteUserGroupMenu(Map<String, Object> map) {
		delete("menu.deleteUserGroupMenu", map);
	}
	
	public void deleteUserGroupMenuAll(Map<String, Object> map) {
		delete("menu.deleteUserGroupMenuAll", map);
	}	
	// 권한에 의한 메뉴존재 확인 추가 22.09.01
	public int selectMenuIdCntByAuth(Map<String, Object> map) {
		return (int) selectOne("menu.selectMenuIdCntByAuth", map);
	}
}