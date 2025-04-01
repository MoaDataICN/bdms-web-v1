package com.moadata.bdms.group.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.vo.*;
import com.moadata.bdms.support.code.service.CodeService;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.service.UserService;
import com.moadata.bdms.userGroup.service.UserGroupService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User
 */
@Controller
@RequestMapping(value = "/group")
public class GroupController extends BaseController {
//	@Value("#{config['product.option']}")
//	private String productOption;
	@Resource(name = "groupService")
	private GroupService groupService;


	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "codeService")
	private CodeService codeService;
	
	@Resource(name = "userGroupService")
	private UserGroupService userGroupService;
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
//	@Resource(name = "historyInfoService")
//	private HistoryInfoService historyInfoService;
	
	/**
	 * User list 페이지이동
	 * 
	 * @return
	 */
	//@Auth
	@RequestMapping(value = "/groupManage", method = RequestMethod.GET)
	public String mvUser(HttpServletRequest request,ModelMap model) throws JsonProcessingException {

		List<GroupVO> sectionList = groupService.selectChildList("G0001");
		List<GroupVO> allGroupList = groupService.selectSectionList();

		ObjectMapper objectMapper = new ObjectMapper();
		String dataListJson = objectMapper.writeValueAsString(sectionList);

		model.addAttribute("allList", objectMapper.writeValueAsString(allGroupList));
		model.addAttribute("sectionListJson", dataListJson);
		model.addAttribute("depth", groupService.selectMaxDepth());

		return "group/groupManage";
	}

	@RequestMapping(value="/findChild", method = RequestMethod.GET)
	@ResponseBody
	public String findChildGroup(@RequestParam Map<String, Object> param) throws JsonProcessingException {
		System.out.println(param);

		String grpId = (String)param.get("grpId");
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("id", grpId);
		resultMap.put("name", param.get("grpName"));

		resultMap.put("children", groupService.selectChildList(grpId));

		ObjectMapper objectMapper = new ObjectMapper();
		String dataListJson = objectMapper.writeValueAsString(resultMap);

		return dataListJson;
	}

	@RequestMapping(value="/updateGroup", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateGroup(@RequestBody Map<String, Object> param) throws JsonProcessingException {
		Map<String, Object> result = new HashMap<>();
		boolean isError = false;
		String message = "";
		try {
			List<Map<String, String>> list = (List<Map<String, String>>) param.get("list");
			String parentId = (String) param.get("parentId");

			// GroupVO 리스트로 변환
			List<GroupVO> groupVOList = new ArrayList<>();
			for (Map<String, String> item : list) {
				GroupVO groupVO = new GroupVO();
				groupVO.setGrpId(item.get("grpId"));
				groupVO.setPgrpId(parentId);
				groupVO.setGrpNm(item.get("grpNm"));
				groupVOList.add(groupVO);
			}

			groupService.updateGroupList(groupVOList, parentId);

		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		result.put("isError", isError);
		result.put("message", message);

		return result;
	}
}
