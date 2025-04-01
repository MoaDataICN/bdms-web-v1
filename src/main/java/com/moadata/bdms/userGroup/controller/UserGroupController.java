package com.moadata.bdms.userGroup.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.common.exception.ProcessException;
//import com.moadata.hsmng.common.intercepter.Auth;
import com.moadata.bdms.model.vo.MenuVO;
import com.moadata.bdms.model.vo.UserGroupVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.service.UserService;
import com.moadata.bdms.userGroup.service.UserGroupService;

/**
 * UserGroup
 */
@Controller
@RequestMapping(value = "/userGroup")
public class UserGroupController extends BaseController {
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "userGroupService")
	private UserGroupService userGroupService;
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
	/**
	 * UserGroup 페이지이동
	 * 
	 * @return
	 */
	//@Auth
	@RequestMapping(value = "/userGroup")
	public String userGroupList() {
		return "userGroup/userGroupList";
	}
	
	/**
	 * UserGroup 목록 
	 * 
	 * @return
	 */
	@RequestMapping(value = "/userGroupList")
	public @ResponseBody Map<String, Object> userGroupList(@ModelAttribute("userGroup") UserGroupVO userGroup) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isError = false;
		
		try {
			userGroup.setPageIndex(Integer.parseInt(userGroup.getPage())-1);
			userGroup.setRowNo(userGroup.getPageIndex() * userGroup.getRows());
			userGroup.setSortColumn(userGroup.getSidx());//StringUtil.camelToSnakeConvert(userGroup.getSidx())
			List<UserGroupVO> userGroupList = userGroupService.selectUserGroupList(userGroup);
			
			int records = userGroupList.size() == 0 ? 0 : userGroupList.get(0).getCnt();
			map.put("page", userGroup.getPageIndex() + 1); 
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userGroup.getRows()));
			map.put("rows",  userGroupList);
			
		} catch(Exception e) {
			LOGGER.error(e.toString());
			isError =  true;
			map.put("message", e.getMessage());
		}
		
		map.put("isError", isError);
		return map; 
	}
	
	/**
	 * UserGroup 등록 사용자 목록 
	 * 
	 * @return
	 */
	@RequestMapping(value = "/userGroupUserList")
	public @ResponseBody Map<String, Object> userGroupUserList(@ModelAttribute("user") UserVO user) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isError = false;
		
		try {
			user.setPageIndex(Integer.parseInt(user.getPage())-1);
			user.setRowNo(user.getPageIndex() * user.getRows());
			user.setSortColumn(user.getSidx());//StringUtil.camelToSnakeConvert(userGroup.getSidx())
			List<UserVO> userList = userGroupService.selectUserListByUserGroupId(user);
			
			int records = userList.size() == 0 ? 0 : userList.get(0).getCnt();
			map.put("page", user.getPageIndex() + 1); 
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) user.getRows()));
			map.put("rows",  userList);
			
		} catch(Exception e) {
			LOGGER.error(e.toString());
			isError =  true;
			map.put("message", e.getMessage());
		}
		
		map.put("isError", isError);
		return map; 
	}
	
	/**
	 * UserGroup 미등록 사용자 목록 
	 * 
	 * @return
	 */
	@RequestMapping(value = "/userGroupUnUserList")
	public @ResponseBody Map<String, Object> userGroupUnUserList(@ModelAttribute("user") UserVO user) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isError = false;
		
		try {
			user.setPageIndex(Integer.parseInt(user.getPage())-1);
			user.setRowNo(user.getPageIndex() * user.getRows());
			user.setSortColumn(user.getSidx());//StringUtil.camelToSnakeConvert(userGroup.getSidx())
			List<UserVO> userGroupUnUserList = userGroupService.selectUserListByUnUserGroup(user);
			
			int records = userGroupUnUserList.size() == 0 ? 0 : userGroupUnUserList.get(0).getCnt();
			map.put("page", user.getPageIndex() + 1); 
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) user.getRows()));
			map.put("rows",  userGroupUnUserList);
			
		} catch(Exception e) {
			LOGGER.error(e.toString());
			isError =  true;
			map.put("message", e.getMessage());
		}
		
		map.put("isError", isError);
		return map; 
	}
	
	/**
	 * UserGroup 등록
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/userGroupAdd", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupAdd(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return map;
	}
	
	/**
	 * UserGroup 수정
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupUpdate(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		boolean isError = false;
		
		try {
			
			UserGroupVO vo = (UserGroupVO) getRequestAttribute("usergroup");
			if("Y".equalsIgnoreCase(vo.getUsergroupBtnYn()))
			{
				if(userGroup.getUsergroupId().equals("UGP_000000000000")) {
					throw new ProcessException("슈퍼그룹은 편집할수 없습니다.");
				}
				
				UserVO user = (UserVO) getRequestAttribute("user");
				userGroup.setModifyId(user.getUserId());
				
				userGroupService.updateUserGroup(userGroup);
				
				if(userGroup.getUsergroupId().equals(vo.getUsergroupId())) {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

					// Session 정보
					HttpSession session = request.getSession(true);
					// 변경된 사용자 그룹 정보  
					UserGroupVO usergroup = userGroupService.selectUserGroupInfo(user.getUsergroupId());
					session.setAttribute("usergroup", usergroup);
				}
				message = "편집되었습니다.";
			}
			else
			{
				message = "권한이 없습니다.";
			}
		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
	
	/**
	 * UserGroup 삭제
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userGroupDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupDelete(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String message = "";
		boolean isError = false;
		
		try {
			UserGroupVO vo = (UserGroupVO) getRequestAttribute("usergroup");
			if("Y".equalsIgnoreCase(vo.getUsergroupBtnYn()))
			{
				UserVO user = (UserVO) getRequestAttribute("user");
				userGroup.setModifyId(user.getUserId());
				for(String uid : userGroup.getUIds().split(",")) {
					if(uid.equals("UGP_000000000000")) {
						throw new ProcessException("슈퍼그룹은 삭제할수 없습니다.");
					}
				}
				userGroupService.deleteUserGroupList(userGroup);
				message = "삭제되었습니다.";
			}
			else
			{
				message = "권한이 없습니다.";
			}
		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
	
	/**
	 * UserGroup 구성원 수정
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userGroupUserUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupUserUpdate(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		boolean isError = false;
		
		try {
			UserGroupVO vo = (UserGroupVO) getRequestAttribute("usergroup");
			if("Y".equalsIgnoreCase(vo.getUsergroupBtnYn()))
			{
				UserVO user = (UserVO) getRequestAttribute("user");
				userGroup.setModifyId(user.getUserId());
				userGroupService.userGroupUserUpdate(userGroup);
				message = "저장 되었습니다.";
			}
			else
			{
				message = "권한이 없습니다.";
			}
		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
	
	/**
	 * UserGroup 에이전트 그룹 수정
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping(value = "/userGroupAgentUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupAgentUpdate(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		boolean isError = false;
		
		try {
			UserGroupVO vo = (UserGroupVO) getRequestAttribute("usergroup");
			if("Y".equalsIgnoreCase(vo.getUsergroupBtnYn()))
			{
				UserVO user = (UserVO) getRequestAttribute("user");
				userGroup.setModifyId(user.getUserId());
				
				userGroupService.userGroupAgentGroupUpdate(userGroup);
				
				message = "편집 되었습니다.";
			}
			else
			{
				message = "권한이 없습니다.";
			}
		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}*/
	
	/**
	 * menu 정보(json)
	 * 
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/tree.json", method=RequestMethod.GET)
	public String tree(@RequestParam(value="type")String type, ModelMap model) {
		
		if(type.equals("menu")) {
			List<MenuVO> menuTreeList = menuService.selectMenuList(false);
			model.addAttribute("menuTreeList", menuTreeList);
		}
		return "/tree/tree";
	}
	
	/**
	 * UserGroup 메뉴 권한 리스트
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userGroupMenuList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupMenuList(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		boolean isError = false;
		
		try {
			List<MenuVO> userGroupMenuList = menuService.selectMenuIdByGroup(userGroup.getUsergroupId());
			map.put("userGroupMenuList", userGroupMenuList);
		}catch(Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
	
	/**
	 * UserGroup 메뉴 수정
	 * 
	 * @param userGroup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userGroupMenuUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupMenuUpdate(@ModelAttribute("userGroup") UserGroupVO userGroup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		boolean isError = false;
		
		try {
			UserGroupVO vo = (UserGroupVO) getRequestAttribute("usergroup");
			if("Y".equalsIgnoreCase(vo.getUsergroupBtnYn()))
			{
				UserVO user = (UserVO) getRequestAttribute("user");
				userGroup.setRegistId(user.getUserId());
				
				if(userGroup.getUsergroupId().equals("UGP_000000000000")) {
					throw new ProcessException("슈퍼그룹은 편집 할 수 없습니다.");
				}
				
				userGroupService.userGroupMenuUpdate(userGroup);
				message = "편집 되었습니다.";
			}
			else
			{
				message = "권한이 없습니다.";
			}
		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}
		
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
}
