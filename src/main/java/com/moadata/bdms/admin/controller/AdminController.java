package com.moadata.bdms.admin.controller;

import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.admin.service.AdminService;
import com.moadata.bdms.model.vo.CheckupVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.common.util.StringUtil;

/**
 * Admin
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminController extends BaseController {

	@Resource(name = "adminService")
	private AdminService adminService;

	@RequestMapping(value = "/setting", method = RequestMethod.GET)
	public String setting(HttpServletRequest request, ModelMap model) {

		String grpId = "G0010";
		List<Map> groupList = adminService.selectManagerGroupList(grpId);
		model.addAttribute("groupList", groupList);

		return "admin/setting";
	}

	@ResponseBody
	@RequestMapping(value = "/settingList", method = RequestMethod.POST)
	public Map<String, Object> settingList(@ModelAttribute UserVO userVO) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;
		List<UserVO> resultList;

		try {
			userVO.setSortColumn(userVO.getSidx());
			userVO.setPageIndex(Integer.parseInt(userVO.getPage()) - 1);
			userVO.setRowNo(userVO.getPageIndex() * userVO.getRows());

			resultList = adminService.selectAdminList(userVO);
			int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();
			map.put("page", userVO.getPageIndex() + 1);
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userVO.getRows()));
			map.put("rows", resultList);
		} catch (Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	/**
	 * Admin 등록
	 *
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminAdd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userAdd(@ModelAttribute("user") UserVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		boolean isError = false;
		String message = "";
		UserVO vo = (UserVO) getRequestAttribute("user");
		try {
			//usergroup 제거 22.08.23
			// 중복 체크
			int checkUser = adminService.selectAdminIdCnt(user.getUserId());

			if (checkUser > 0) {
				isError = true;
				message = "This ID has already been registered.";
			} else {
				if (StringUtil.isEmpty(user.getUserType())) {
					user.setUserType("UT03"); //운영자
				}
				user.setRegistId(vo.getUserId());
				user.setModifyId(vo.getUserId());

				String encryptPassword = EncryptUtil.encryptSha(user.getUserPw());
				user.setUserPw(encryptPassword);
				user.setJobType("C");
				user.setUseYn("Y");

				adminService.insertAdmin(user);

				//이력 추가.
				Map<String, String> param = new HashMap<String, String>();
				param.put("hisType", "HT16");
				param.put("batchId", "");
				param.put("prssType", "HS06");
				param.put("hisEndDt", "");
				param.put("prssUsrId", vo.getUserId());
				String tempMsg = "Administrator " + user.getUserId() + " - " + "{0}" + " was a success";
				param.put("msgEtc", tempMsg);

				//historyInfoService.commInsertHistory(param,"");

				message = "Added.";
			}

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			map.put("message", e.getMessage());
			//이력 추가.
			Map<String, String> param = new HashMap<String, String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS06");
			param.put("hisEndDt", "");
			param.put("prssUsrId", vo.getUserId());
			String tempMsg = "Administrator " + user.getUserId() + " - " + "{0}" + " failed.";
			param.put("msgEtc", tempMsg);
			//historyInfoService.commInsertHistory(param,"");
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	/**
	 * Admin 수정 - 관리자 수정
	 *
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> adminUpdate(@ModelAttribute("user") UserVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		String message = "";
		boolean isError = false;
		UserVO vo = (UserVO) getRequestAttribute("user");
		try {
			user.setModifyId(vo.getUserId());
			adminService.updateAdmin(user);

			//이력 추가.
			Map<String, String> param = new HashMap<String, String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS08");
			param.put("hisEndDt", "");
			param.put("prssUsrId", vo.getUserId());
			String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 성공 하였습니다.";
			param.put("msgEtc", tempMsg);

			//historyInfoService.commInsertHistory(param,"");

			message = "Edited.";

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();

			//이력 추가.
			Map<String, String> param = new HashMap<String, String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS08");
			param.put("hisEndDt", "");
			param.put("prssUsrId", vo.getUserId());
			String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 실패 하였습니다.";
			param.put("msgEtc", tempMsg);

			//historyInfoService.commInsertHistory(param,"");
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}
}
