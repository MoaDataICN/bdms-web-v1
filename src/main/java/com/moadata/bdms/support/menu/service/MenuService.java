package com.moadata.bdms.support.menu.service;

import java.util.List;
import java.util.Map;

import com.moadata.bdms.model.vo.MenuVO;

/**
 * Menu Service Interface
 */
public interface MenuService {
	
	/** 
	 * Menu 목록 및 그룹권한 - 관리페이지 추가 22.08.22
	 * 
	 * @param groupId
	 * @return
	 */
	List<MenuVO> selectMenuListPermission(String groupId);
	
	/**
	 * Menu 목록
	 * 
	 * @param displayAll - 최상위 관리 메뉴 출력 여부
	 * @return
	 */
	public List<MenuVO> selectMenuList(Boolean displayAll);
	
	/**
	 * Menu 목록 - 운영자
	 * 
	 * @param groupId
	 * @return
	 */
	public List<MenuVO> selectMenuListByGroup(String groupId);
	
	/**
	 * Menu Start Url - 운영자
	 * 
	 * @param groupId
	 * @return
	 */
	public String selectMenuStartUrl(String groupId);
	
	/**
	 * Menu 목록 - 현재위치
	 * 
	 * @param url, usergroupId
	 * @return
	 */
	public List<MenuVO> selectMenuListByPath(Map<String, Object> map);
	
	/**
	 * Menu 권한 확인
	 * 
	 * @param map
	 * @return
	 */
	public int selectMenuIdCnt(Map<String, Object> map);
	
	/**
	 * 유저그룹별 Menu 권한 확인
	 * 
	 * @param userGroupId
	 * @return
	 */
	public List<MenuVO> selectMenuIdByGroup(String usergroupId);
	
	/**
	 * 유저그룹별 Menu 권한 등록 및 수정
	 * 
	 * @param map
	 * @return
	 */
	public void updateUserGroupMenu(Map<String, Object> map);
	
	/**
	 * 유저그룹별 Menu 권한 삭제
	 * 
	 * @param map
	 * @return
	 */
	public void deleteUserGroupMenu(Map<String, Object> map);
	
	/**
	 * 유저그룹별 Menu 권한 모두 삭제 추가 22.08.23
	 * 
	 * @param map
	 * @return
	 */
	public void deleteUserGroupMenuAll(Map<String, Object> map);
	
	/**
	 * 권한에 의한 메뉴존재 확인 추가 22.09.01
	 * 
	 * @param map
	 * @return
	 */	
	public int selectMenuIdCntByAuth(Map<String, Object> map);
	
}
