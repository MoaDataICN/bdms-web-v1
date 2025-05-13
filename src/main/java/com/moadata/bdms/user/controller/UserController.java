package com.moadata.bdms.user.controller;

import java.time.LocalDate;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.common.util.StringUtil;
import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.dto.*;
import com.moadata.bdms.model.vo.*;
import com.moadata.bdms.nutri.service.NutriService;
import org.springframework.beans.factory.annotation.Value;
import com.moadata.bdms.model.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.common.exception.ProcessException;
import com.moadata.bdms.support.code.service.CodeService;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.service.UserService;
import com.moadata.bdms.userGroup.service.UserGroupService;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * User
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {
//	@Value("#{config['product.option']}")
//	private String productOption;

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "codeService")
	private CodeService codeService;

	@Resource(name = "userGroupService")
	private UserGroupService userGroupService;

	@Resource(name = "menuService")
	private MenuService menuService;

	@Resource(name = "groupService")
	private GroupService groupService;

	@Resource(name = "nutriService")
	private NutriService nutriService;

    @Value("${file.save.dir.linux}")
    private String linuxPreOpenFilePath;

    @Value("${file.save.dir.windows}")
    private String windowPreOpenFilePath;

	@RequestMapping(value = "/userSearch", method = RequestMethod.GET)
	public String userSearch(ModelMap model, HttpServletRequest request) {
		// 세션에 저장 된, 사용자의 정보를 바탕으로 조회를 수행
		// GRP_ID, GRP_LV 를 세션에 저장하며, 이를 바탕으로 조회 조건 및 레벨이 달라짐

		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();
		String grpLv = adminVO.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		if (grpLv != null && grpLv.equals("1")) {
			// 최상위 관리자인 경우
			List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
			List<UserSearchDTO> inChargeNmList = userService.selectLowLevelAdmins(grpId);

			if (inChargeNmList != null && !inChargeNmList.isEmpty()) {
				for (UserSearchDTO inChargeNm : inChargeNmList) {
					System.out.println("IN_CHARGE_ID : " + inChargeNm.getInChargeId());
					System.out.println("IN_CHARGE_NM : " + inChargeNm.getInChargeNm());
				}
			}

			model.addAttribute("grpLv", grpLv);  // 원래 코드
			model.addAttribute("inChargeNmList", inChargeNmList);
			model.addAttribute("groupList", groupList);
		}
		return "user/userSearch";
	}

	@ResponseBody
	@RequestMapping(value = "/selectUserSearch", method = RequestMethod.POST)
	public Map<String, Object> selectUserSearch(@ModelAttribute UserSearchDTO userSearchDTO) {
		Map<String, Object> map = new HashMap<>();

		System.out.println("==============================");
		System.out.println(userSearchDTO.getInChargeNm());
		System.out.println(userSearchDTO.getInChargeNm());
		System.out.println("==============================");

		String message = "";
		boolean isError = false;
		List<UserSearchDTO> resultList;

		try {
			userSearchDTO.setSortColumn(userSearchDTO.getSidx());
			userSearchDTO.setPageIndex(Integer.parseInt(userSearchDTO.getPage()) -1);
			userSearchDTO.setRowNo(userSearchDTO.getPageIndex() * userSearchDTO.getRows());

			resultList = userService.selectUserSearch(userSearchDTO);

			int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();

			map.put("page", userSearchDTO.getPageIndex() + 1);
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userSearchDTO.getRows()));
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

	@ResponseBody
	@RequestMapping(value = "/selectUserDtlHealthAlerts", method = RequestMethod.POST)
	public Map<String, Object> selectUserDtlHealthAlerts(@ModelAttribute UserDtlHealthAlertsDTO userDtlHealthAlertsDTO) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;
		List<UserDtlHealthAlertsDTO> resultList;

		try {
			userDtlHealthAlertsDTO.setSortColumn(userDtlHealthAlertsDTO.getSidx());
			userDtlHealthAlertsDTO.setPageIndex(Integer.parseInt(userDtlHealthAlertsDTO.getPage()) -1);
			userDtlHealthAlertsDTO.setRowNo(userDtlHealthAlertsDTO.getPageIndex() * userDtlHealthAlertsDTO.getRows());

			resultList = userService.selectUserDtlHealthAlerts(userDtlHealthAlertsDTO);

			int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();

			map.put("page", userDtlHealthAlertsDTO.getPageIndex() + 1);
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userDtlHealthAlertsDTO.getRows()));
			map.put("rows", resultList);
		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/selectCheckUpResult", method = RequestMethod.POST)
	public Map<String, Object> selectCheckUpResult(@ModelAttribute UserDtlCheckUpResultDTO userDtlCheckUpResultDTO) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;
		List<UserDtlCheckUpResultDTO> resultList;

		try {
			userDtlCheckUpResultDTO.setSortColumn(userDtlCheckUpResultDTO.getSidx());
			userDtlCheckUpResultDTO.setPageIndex(Integer.parseInt(userDtlCheckUpResultDTO.getPage()) -1);
			userDtlCheckUpResultDTO.setRowNo(userDtlCheckUpResultDTO.getPageIndex() * userDtlCheckUpResultDTO.getRows());

			resultList = userService.selectUserDtlCheckUpResults(userDtlCheckUpResultDTO);

			int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();

			map.put("page", userDtlCheckUpResultDTO.getPageIndex() + 1);
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userDtlCheckUpResultDTO.getRows()));
			map.put("rows", resultList);
		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/healthAlertsCnt/all", method = RequestMethod.POST)
	public Map<String, Object> getAllHealthAlertsCnt(@RequestParam("userId") String userId,
													HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();
		String grpLv = adminVO.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		Map<String, Object> response = new HashMap<>();
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("grpLv", grpLv);

			List<Map<String, Object>> cntList = userService.selectAllHealthAlertsCnt(param);

			Map<String, Long> healthAlertsCntList = new HashMap<>();
			String[] expectedAltTypes = {"A", "F", "H", "SL", "B", "T", "ST"};
			for (String altTp : expectedAltTypes) {
				healthAlertsCntList.put(altTp, 0L);
			}

			for (Map<String, Object> row : cntList) {
				String altTp = (String) row.get("ALT_TP");
				Long altCount = ((Number) row.get("ALT_COUNT")).longValue();
				healthAlertsCntList.put(altTp, altCount);
			}

			response.put("success", true);
			response.put("healthAlertsCntMap", healthAlertsCntList);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/healthAlertsCnt/last24h", method = RequestMethod.POST)
	public Map<String, Object> getLast24hHealthAlertsCnt(@RequestParam("userId") String userId,
														HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		UserVO user = (UserVO) session.getAttribute("user");

		String grpId = user.getGrpId();
		String grpLv = user.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		Map<String, Object> response = new HashMap<>();
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("grpLv", grpLv);
			param.put("today", LocalDate.now().toString());

			List<Map<String, Object>> cntList = userService.selectLast24hHealthAlertsCnt(param);

			Map<String, Long> healthAlertsCntList = new HashMap<>();
			String[] expectedAltTypes = {"A", "F", "H", "SL", "B", "T", "ST"};
			for (String altTp : expectedAltTypes) {
				healthAlertsCntList.put(altTp, 0L);
			}

			for (Map<String, Object> row : cntList) {
				String altTp = (String) row.get("ALT_TP");
				Long altCount = ((Number) row.get("ALT_COUNT")).longValue();
				healthAlertsCntList.put(altTp, altCount);
			}

			response.put("success", true);
			response.put("healthAlertsCntMap", healthAlertsCntList);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/updateAltStt", method = RequestMethod.POST)
	public Map<String, Object> updateAltStt(@RequestParam String trkId, @RequestParam("newAltStt") String altStt) {
		Map<String, Object> response = new HashMap<>();

		try {
			Map<String, Object> param = new HashMap<>();
			param.put("trkId", trkId);
			param.put("altStt", altStt);

			boolean altSttUpdated = userService.updateAltStt(param);

			if (!altSttUpdated) {
				response.put("success", false);
				response.put("message", "알림 상태 수정 실패");
				return response;
			} else {
				response.put("success", true);
				response.put("message", "알림 상태가 성공적으로 수정되었습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", e.getMessage());
		}
		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/selectUserDtlServiceRequests", method = RequestMethod.POST)
	public Map<String, Object> selectUserDtlServiceRequests(@ModelAttribute UserDtlServiceRequestsDTO userDtlServiceRequestsDTO) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;
		List<UserDtlServiceRequestsDTO> resultList;

		try {
			userDtlServiceRequestsDTO.setSortColumn(userDtlServiceRequestsDTO.getSidx());
			userDtlServiceRequestsDTO.setPageIndex(Integer.parseInt(userDtlServiceRequestsDTO.getPage()) -1);
			userDtlServiceRequestsDTO.setRowNo(userDtlServiceRequestsDTO.getPageIndex() * userDtlServiceRequestsDTO.getRows());

			resultList = userService.selectUserDtlServiceRequests(userDtlServiceRequestsDTO);

			int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();

			map.put("page", userDtlServiceRequestsDTO.getPageIndex() + 1);
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userDtlServiceRequestsDTO.getRows()));
			map.put("rows", resultList);
		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/serviceRequestsCnt/all", method = RequestMethod.POST)
	public Map<String, Object> getAllServiceRequestsCnt(@RequestParam("userId") String userId,
													HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();
		String grpLv = adminVO.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		Map<String, Object> response = new HashMap<>();
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("grpLv", grpLv);

			List<Map<String, Object>> cntList = userService.selectAllServiceRequestsCnt(param);

			Map<String, Long> serviceRequestsCntList = new HashMap<>();
			String[] expectedReqTypes = {"N", "A", "T"};
			for (String reqTp : expectedReqTypes) {
				serviceRequestsCntList.put(reqTp, 0L);
			}

			for (Map<String, Object> row : cntList) {
				String reqTp = (String) row.get("REQ_TP");
				Long reqCount = ((Number) row.get("REQ_COUNT")).longValue();
				serviceRequestsCntList.put(reqTp, reqCount);
			}

			response.put("success", true);
			response.put("serviceRequestsCntMap", serviceRequestsCntList);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/serviceRequestsCnt/last24h", method = RequestMethod.POST)
	public Map<String, Object> getLast24hServiceRequestsCnt(@RequestParam("userId") String userId,
														HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		UserVO user = (UserVO) session.getAttribute("user");

		String grpId = user.getGrpId();
		String grpLv = user.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		Map<String, Object> response = new HashMap<>();
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("grpLv", grpLv);
			param.put("today", LocalDate.now().toString());

			List<Map<String, Object>> cntList = userService.selectLast24hServiceRequestsCnt(param);

			Map<String, Long> serviceRequestsCntList = new HashMap<>();
			String[] expectedReqTypes = {"N", "A", "T"};
			for (String reqTp : expectedReqTypes) {
				serviceRequestsCntList.put(reqTp, 0L);
			}

			for (Map<String, Object> row : cntList) {
				String reqTp = (String) row.get("REQ_TP");
				Long reqCount = ((Number) row.get("REQ_COUNT")).longValue();
				serviceRequestsCntList.put(reqTp, reqCount);
			}

			response.put("success", true);
			response.put("serviceRequestsCntMap", serviceRequestsCntList);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/updateReqStt", method = RequestMethod.POST)
	public Map<String, Object> updateReqStt(@RequestParam String reqId, @RequestParam("newReqStt") String reqStt) {
		Map<String, Object> response = new HashMap<>();

		try {
			Map<String, Object> param = new HashMap<>();
			param.put("reqId", reqId);
			param.put("reqStt", reqStt);

			boolean reqSttUpdated = userService.updateReqStt(param);

			if (!reqSttUpdated) {
				response.put("success", false);
				response.put("message", "알림 상태 수정 실패");
				return response;
			} else {
				response.put("success", true);
				response.put("message", "알림 상태가 성공적으로 수정되었습니다.");
			}

			response.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", e.getMessage());
		}
		return response;
	}

	@RequestMapping(value = "/detail/{tab}", method = RequestMethod.POST)
	public String getUserDetail(@PathVariable String tab, @RequestParam String userId,
								UserDtlHealthAlertsDTO userDtlHealthAlertsDTO,
								UserDtlServiceRequestsDTO userDtlServiceRequestsDTO,
								UserDtlCheckUpResultDTO userDtlCheckUpResultDTO,
								Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();
		String grpLv = adminVO.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		UserDtlGeneralDTO userDtlGeneralDTO = userService.selectUserDtlGeneral(userId);  // 사용자 조회
		System.out.println(userDtlGeneralDTO.getUserId());

//		model.addAttribute("grpLv", "2");  // 테스트용
		model.addAttribute("grpLv", grpLv);  // 원래 코드
//		model.addAttribute("userId", userId);
		model.addAttribute("userDtlGeneral", userDtlGeneralDTO);

		switch (tab) {
            case "general":
                System.out.println("tab : general");

                return "user/userDtlGeneral";
            case "health-alerts":
                System.out.println("tab : health-alerts");

				return "user/userDtlHealthAlerts";
			case "service-requests":
				System.out.println("tab : service-requests");

				return "user/userDtlServiceRequests";
			case "input-checkup-data":
				System.out.println("tab : input-checkup-data");

				return "user/userDtlInputCheckupData";
			case "checkup-result":
				System.out.println("tab : checkup-result");

				return "user/userDtlCheckUpResult";
            default:
                System.out.println("tab : general");

				return "user/userDtlGeneral";
        }
	}

	/**
	 * 관리자에 의한 사용자 비밀번호 초기화
	 */
	@ResponseBody
	@RequestMapping(value = "/resetPwByAdmin", method = RequestMethod.POST)
	public Map<String, Object> resetPwByAdmin(@RequestParam("userId") String userId,
											  @RequestParam("newPw") String newPw,
											  HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		boolean isError = false;
		String message = "";

		try {
			// 현재 로그인한 관리자 정보
			HttpSession session = request.getSession(false);
			UserVO adminVO = (UserVO) session.getAttribute("user");

			// 새 비밀번호 암호화
			String encryptedNewPw = EncryptUtil.encryptSha(newPw);

			MyResetPwDTO myResetPwDTO = new MyResetPwDTO();
			myResetPwDTO.setUserId(userId);
			myResetPwDTO.setPw(encryptedNewPw);
			myResetPwDTO.setUptId(adminVO.getUserId());   // 관리자 ID

			userService.updateUserResetPwByAdmin(myResetPwDTO);

			response.put("success", true);
			response.put("message", "비밀번호가 성공적으로 초기화되었습니다.");
		} catch (Exception e) {
			LOGGER.error("관리자 비밀번호 초기화 중 오류 발생", e);
			isError = true;
			message = "비밀번호 초기화 중 오류가 발생했습니다.";
			response.put("success", false);
			response.put("message", message);
		}

		response.put("isError", isError);
		return response;
	}

	/**
	 *  GRP_LV 1, 2의 비밀번호 확인
	 */
	@ResponseBody
	@RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
	public Map<String, Object> checkPassword(@RequestParam("checkPassword") String checkPassword) {
		Map<String, Object> response = new HashMap<>();
		boolean isMatch = false;

		try {
			UserVO userVO = (UserVO) getRequestAttribute("user");

			// 입력값 암호화
			String encryptedInput = EncryptUtil.encryptSha(checkPassword);
			String actualPassword = userVO.getUserPw();

			if (encryptedInput.equals(actualPassword)) {
				isMatch = true;
				response.put("message", "비밀번호가 맞았습니다.");
			} else {
				response.put("status", "fail");
				response.put("message", "비밀번호가 틀렸습니다.");
			}

			response.put("status", isMatch ? "success" : "fail");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "서버 오류가 발생했습니다.");
		}

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/updateGeneral", method = RequestMethod.POST)
	public Map<String, Object> updateGeneral(@ModelAttribute UserUpdateDTO userUpdateDTO, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();

		String message = "";
		boolean isError = false;

		if (userUpdateDTO.getUserId() == null || userUpdateDTO.getUserId().isEmpty()) {
			response.put("success", false);
			response.put("message", "userId는 필수입니다.");

			return response;
		}

		try {
			HttpSession session = request.getSession(false);
			UserVO adminVO = (UserVO) session.getAttribute("user");

			userUpdateDTO.setUptId(adminVO.getUserId());  // 현재 접속한 uid를 넣어야 함

			// 1. 사용자 일반 정보 UPDATE
			boolean generalUpdated = userService.updateUserGeneral(userUpdateDTO);

			if (!generalUpdated) {
				response.put("success", false);
				response.put("message", "사용자 기본 정보 수정 실패");
				return response;
			}

			// 2. 담당자명 UPDATE
			boolean inChargeUpdated = userService.updateUserInChargeIdByNm(userUpdateDTO);

			if (!inChargeUpdated) {
				response.put("success", false);
				response.put("message", "담당자명 수정 실패");
				return response;
			}

			// 3. 키/몸무게 INSERT
			boolean bodyInserted = userService.insertUserBody(userUpdateDTO);

			if (!bodyInserted) {
				response.put("success", false);
				response.put("message", "사용자 신체 정보 등록 실패");
				return response;
			}

			response.put("success", true);
			response.put("message", "사용자 정보가 성공적으로 수정되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		response.put("isError", isError);
		response.put("message", message);

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "/selectInChargeNmList", method = RequestMethod.POST)
	public List<UserSearchDTO> selectInChargeNmList(@RequestParam(value = "inChargeNm") String inChargeNm, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();

		System.out.println("grpId : " + grpId);

		if (inChargeNm != null && !inChargeNm.trim().isEmpty()) {
			Map<String, Object> param = new HashMap<>();
			param.put("grpId", grpId);
			param.put("inChargeNm", inChargeNm);

			return userService.selectInChargeNmList(param);
		} else {
			return Collections.emptyList();
		}
	}

	@RequestMapping(value = "/chargeSearchPopup", method = RequestMethod.GET)
	public String chargeSearchPopup(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();

		System.out.println("grpId : " + grpId);

		List<UserSearchDTO> inChargeNmList = userService.selectLowLevelAdmins(grpId);

		if (inChargeNmList != null && !inChargeNmList.isEmpty()) {
			for (UserSearchDTO inChargeNm : inChargeNmList) {
				System.out.println("IN_CHARGE_ID : " + inChargeNm.getInChargeId());
				System.out.println("IN_CHARGE_NM : " + inChargeNm.getInChargeNm());
			}
		}

		model.addAttribute("inChargeNmList", inChargeNmList);

		return "user/chargeSearchPopup";
	}

	@RequestMapping(value = "/chargeSearchOnSlidePopup", method = RequestMethod.GET)
	public String chargeSearchOnSlidePopup(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		UserVO adminVO = (UserVO) session.getAttribute("user");

		String grpId = adminVO.getGrpId();

		System.out.println("grpId : " + grpId);

		List<UserSearchDTO> inChargeNmList = userService.selectLowLevelAdmins(grpId);

		if (inChargeNmList != null && !inChargeNmList.isEmpty()) {
			for (UserSearchDTO inChargeNm : inChargeNmList) {
				System.out.println("IN_CHARGE_ID : " + inChargeNm.getInChargeId());
				System.out.println("IN_CHARGE_NM : " + inChargeNm.getInChargeNm());
			}
		}

		model.addAttribute("inChargeNmList", inChargeNmList);

		return "user/chargeSearchOnSlidePopup";
	}

	@RequestMapping(value = "/resetPwStartPopup", method = RequestMethod.GET)
	public String resetPwStartPopup(Model model) {
		return "user/resetPwStartPopup";
	}

	@RequestMapping(value = "/resetPwConfirmPopup", method = RequestMethod.GET)
	public String resetPwConfirmPopup(Model model) {
		return "user/resetPwConfirmPopup";
	}

	@RequestMapping(value = "/checkPwStartPopup", method = RequestMethod.GET)
	public String checkPwStartPopup(Model model) {
		return "user/checkPwStartPopup";
	}

	@RequestMapping(value = "/checkPwConfirmPopup", method = RequestMethod.GET)
	public String checkPwConfirmPopup(Model model) {
		return "user/checkPwConfirmPopup";
	}

	/**
	 * User list 페이지이동
	 *
	 * @return
	 */
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String mvUser(HttpServletRequest request,ModelMap model) {

		// USER TYPE
		List<CodeVO> userTypeList = codeService.selectCodeList("UT00");
		model.addAttribute("userType", userTypeList);
		// USERGROUP TYPE
		/* 사용자 등록 또는 수정시 그룹 항목이 제거 되어 아래 소스 주석 처리함 22.08.19 */
		List<UserGroupVO> userGroupList = userGroupService.selectUserGroupCodeList();
		model.addAttribute("userGroupType", userGroupList);

	    /* // DEPT TYPE
		List<DeptVO> deptList = deptService.selectDeptCodeList();
		model.addAttribute("deptType", deptList); */
		//사용자 메뉴 권한 추가 22.08.25
		model.addAttribute("AuthCnt", request.getAttribute("AuthCnt"));

		//근무형태 추가 (일근, 교대 등 근무형태)
		List<CodeVO> workTypeList = codeService.selectCodeList("WK00");
		model.addAttribute("workTypeList", workTypeList);
		return "user/userList";
	}

	/**
	 * UserGroup 목록
	 *
	 * @return
	 */
	@RequestMapping(value = "/userList")
	public @ResponseBody Map<String, Object> userGroupList(@ModelAttribute("user") UserVO user) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isError = false;

		try {
			user.setPageIndex(Integer.parseInt(user.getPage())-1);
			user.setRowNo(user.getPageIndex() * user.getRows());
			user.setSortColumn(user.getSidx());
			user.setJobType("R");

			//이름이 암호화 되어 있을때 검색조건을 암호화해서 검색한다.
			if(null != user.getSearchString() && !"".equals(user.getSearchString() )){

                //사용자명은 암호화 되어있기 떄문에 암호화해서 검색
                String userNm = EncryptUtil.encryptText(user.getSearchString());
                user.setUserNm(userNm);
            }
			user.setUserNm(user.getSearchString());
			List<UserVO> userGroupList = userService.selectUserList(user);
			for (UserVO usrvo : userGroupList) {
				usrvo.setPhoneNo(EncryptUtil.decryptText(usrvo.getPhoneNo()));
				usrvo.setUserNm(EncryptUtil.decryptText(usrvo.getUserNm()));
				usrvo.setEmailAddr(EncryptUtil.decryptText(usrvo.getEmailAddr()));
			}

			int records = userGroupList.size() == 0 ? 0 : userGroupList.get(0).getCnt();
			map.put("page", user.getPageIndex() + 1);
			map.put("records", records);
			map.put("total", records == 0 ? 1 : Math.ceil(records / (double) user.getRows()));
			map.put("rows",  userGroupList);

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError =  true;
			map.put("message", e.getMessage());
		}

		map.put("isError", isError);
		return map;
	}

	/**
	 * UserGroup 목록
	 *
	 * @return
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> exportUserList(@ModelAttribute("user") UserVO user,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<String, Object>();
		boolean isError = false;
		String message = "";

		try {
			String fileName = user.getExportFileNm();
			String headers = user.getExportHeader();
			user.setSortColumn(user.getSidx());

			user.setPageIndex(Integer.parseInt(user.getPage())-1);
			user.setRowNo(user.getPageIndex() * user.getRows());
			user.setJobType("R");

			if(null != user.getSearchString() && !"".equals(user.getSearchString() )){

                //사용자명은 암호화 되어있기 떄문에 암호화해서 검색
                String userNm = EncryptUtil.encryptText(user.getSearchString());
                user.setUserNm(userNm);
            }

			user.setSortColumn("userNm");
			user.setRowNo(0);
			user.setRows(10000);
			List<UserVO> userGroupList = userService.selectUserList(user);

			for (UserVO usrvo : userGroupList) {
				usrvo.setPhoneNo(EncryptUtil.decryptText(usrvo.getPhoneNo()));
				usrvo.setUserNm(EncryptUtil.decryptText(usrvo.getUserNm()));
				usrvo.setEmailAddr(EncryptUtil.decryptText(usrvo.getEmailAddr()));
			}

			/*
			for (int k = 0; k < userGroupList.size(); k++) {
				if(userGroupList.get(k).getWrkTp().equals("WK01")) {
					userGroupList.get(k).setWrkTp("일근");
				} else if (userGroupList.get(k).getWrkTp().equals("WK02")) {
					userGroupList.get(k).setWrkTp("교대");
				}
			}
			*/

			//ExcelUtil.exportToExcel(userGroupList, response, fileName, headers);

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError =  true;
			map.put("message", e.getMessage());
		}
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	/**
	 * User 등록
	 *
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/userAdd", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> userAdd(@ModelAttribute("user")UserVO user)throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();

		boolean isError = false;
		String message = "";
		UserVO vo = (UserVO) getRequestAttribute("user");
		try {
			//usergroup 제거 22.08.23
			// 중복 체크
			int checkUser = userService.selectUserIdCnt(user.getUserId());

			if(checkUser > 0) {
				isError = true;
				message = "이미 등록된 아이디입니다.";
			} else {

				if(StringUtil.isEmpty(user.getUserType())) {
					user.setUserType("UT03"); //운영자
				}
				user.setRegistId(vo.getUserId());
				user.setModifyId(vo.getUserId());

				String encryptPassword = EncryptUtil.encryptSha(user.getUserPw());
				user.setUserPw(encryptPassword);

				//사용자 이름, 핸드폰번호 암호와
				String userNm = EncryptUtil.encryptText(user.getUserNm());
				String phoneNo = "";
				String emailAddr = "";
				if (!user.getPhoneNo().equals("")) {
					phoneNo = EncryptUtil.encryptText(user.getPhoneNo());
				}
				if (!user.getEmailAddr().equals("")) {
				    emailAddr = EncryptUtil.encryptText(user.getEmailAddr());
				}
				user.setUserNm(userNm);
				user.setPhoneNo(phoneNo);
				user.setEmailAddr(emailAddr);
				user.setJobType("C");

				userService.insertUser(user);

				//이력 추가.
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT16");
				param.put("batchId", "");
				param.put("prssType", "HS06");
				param.put("hisEndDt", "");
				param.put("prssUsrId", vo.getUserId());
				String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 성공 하였습니다.";
				param.put("msgEtc", tempMsg);

				//historyInfoService.commInsertHistory(param,"");

				message = "추가되었습니다.";
			}

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			map.put("message", e.getMessage());
			//이력 추가.
			Map<String,String> param = new HashMap<String,String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS06");
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

	/**
	 * User 수정 - 관리자 수정
	 *
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userUpdate(@ModelAttribute("user") UserVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		String message = "";
		boolean isError = false;
		UserVO vo = (UserVO) getRequestAttribute("user");
		try {
			user.setModifyId(vo.getUserId());
			userService.updateUser(user);

			//이력 추가.
			Map<String,String> param = new HashMap<String,String>();
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
			Map<String,String> param = new HashMap<String,String>();
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

	/**
	 * User 삭제
	 *
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userDelete(@ModelAttribute("user") UserVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		String message = "";
		boolean isError = false;
		UserVO vo = (UserVO) getRequestAttribute("user");

		try {

			user.setModifyId(vo.getUserId());
			message = "Deleted.";

			//로그인 계정 저장
			user.setLoginId(vo.getUserId());
			//삭제 전에
			user.setJobType("D");
			userService.deleteUserList(user);

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();

			for(String userId : user.getUserIds().split(",")) {
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT16");
				param.put("batchId", "");
				param.put("prssType", "HS07");
				param.put("hisEndDt", "");
				param.put("prssUsrId", vo.getUserId());
				String tempMsg = "사용자 " + userId + " - " + "{0}" + " 실패 하였습니다.";
				param.put("msgEtc", tempMsg);

				//historyInfoService.commInsertHistory(param,"");
			}
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	//menu 정보 추가 22.08.22
	/**
	 * menu 정보(json)
	 *
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/tree.json", method=RequestMethod.GET)
	public String tree(@RequestParam(value="type")String type, @RequestParam(value="groupId", required = false)String groupId, ModelMap model) {

		if(type.equals("menu")) {
			List<MenuVO> menuTreeList = null;
			if(StringUtil.isEmpty(groupId)) {
				menuTreeList = menuService.selectMenuList(false);
			}else {
				menuTreeList = menuService.selectMenuListPermission(groupId);
			}

			model.addAttribute("menuTreeList", menuTreeList);
		}
		return "/tree/tree";
	}

	//user 메뉴 권한 리스트 추가 22.08.22
	/**
	 * UserGroup 메뉴 권한 리스트
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userMenuList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupMenuList(@ModelAttribute("user") UserVO userVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();

		String message = "";
		boolean isError = false;

		try {
			//List<MenuVO> userGroupMenuList = menuService.selectMenuIdByGroup(userVO.getUserId());
			List<MenuVO> userGroupMenuList = menuService.selectMenuIdByGroup(userVO.getUid());
			map.put("userGroupMenuList", userGroupMenuList);
		} catch(Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}


	//user 메뉴 수정 추가 22.08.22
	/**
	 * User 메뉴 수정
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	//@Auth(role=Role.ADMIN)
	@RequestMapping(value = "/userMenuUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userGroupMenuUpdate(@ModelAttribute("user") UserVO userVO) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		String message = "";
		boolean isError = false;

		try {
			UserVO user = (UserVO) getRequestAttribute("user");
			userVO.setRegistId(user.getUserId());

			userService.userMenuUpdate(userVO);
			message = "편집 되었습니다.";
		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	//개인정보 수정 Popup화면
	@RequestMapping(value = "/popup/UserInfo_form", method = RequestMethod.GET)
	public  String Userinfo(ModelMap model) throws Exception {

		UserVO user = (UserVO) getRequestAttribute("user");
		UserVO userInfo =  userService.selectUserInfoDetail(user.getUserId());

		model.addAttribute("userinfo",userInfo);

		return "user/userinfo_form";
	}

	/**
	 * User 수정 - 개인정보 수정
	 *
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userInfoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userInfoUpdate(@ModelAttribute("user") UserVO user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		String message = "";
		boolean isError = false;
		UserVO vo = (UserVO) getRequestAttribute("user");
		try {
			user.setModifyId(vo.getUserId());

			if(!StringUtil.isEmpty(user.getUserPrePw()) && !StringUtil.isEmpty(user.getUserPw())) {
				String encryptPrePassword = EncryptUtil.encryptSha(user.getUserPrePw());
				if (encryptPrePassword.equals(vo.getUserPw())) {
					String encryptPassword = EncryptUtil.encryptSha(user.getUserPw());
					user.setUserPw(encryptPassword);
					//비밀번호 변경시 비밀번호 변경 날짜 업데이트 해야됨 22.08.23

					//사용자 이름, 핸드폰번호 암호와
					String userNm = "";
					String phoneNo = "";
					String emailAddr = "";

					userNm = EncryptUtil.encryptText(user.getUserNm());

					if (!user.getPhoneNo().equals("")) {
						phoneNo = EncryptUtil.encryptText(user.getPhoneNo());
					}
					if (!user.getEmailAddr().equals("")) {
					    emailAddr = EncryptUtil.encryptText(user.getEmailAddr());
					}

					user.setUserNm(userNm);
					user.setPhoneNo(phoneNo);
					user.setEmailAddr(emailAddr);

					userService.updateUserInfo(user);

					//이력 추가.
					Map<String,String> param = new HashMap<String,String>();
					param.put("hisType", "HT16");
					param.put("batchId", "");
					param.put("prssType", "HS08");
					param.put("hisEndDt", "");
					param.put("prssUsrId", vo.getUserId());
					String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 성공 하였습니다.";
					param.put("msgEtc", tempMsg);
					//historyInfoService.commInsertHistory(param,"");
					message = "정상적으로 처리하였습니다.";

					vo.setUserPw(encryptPassword);
					setRequestAttribute("user", (UserVO)vo);
				} else {  //이전패스워드와 다른 경우
					isError = true;
					message = "이전 패스워드가 일치하지 않습니다.";
				}
			}

		} catch (Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			message = e.getMessage();

			//이력 추가.
			Map<String,String> param = new HashMap<String,String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS08");
			param.put("hisEndDt", "");
			param.put("prssUsrId", vo.getUserId());
			String tempMsg = "사용자 " + user.getUserId() + " - " + "{0}" + " 실패 하였습니다.";
			param.put("msgEtc", tempMsg);

			//historyInfoService.commInsertHistory(param,"");

			message = "정보 변경에 실패 하였습니다.";
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	/**
	 * Check Up Excel Import
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getChckUpExcelImport", method = RequestMethod.POST)
	public  Map<String, Object> getChckUpExcelImport(MultipartHttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<>();
		MultipartFile mf = request.getFile("file[0]");
		UserVO vo = (UserVO) getRequestAttribute("user");
		map = userService.getImportMapForBDMS(mf, vo.getUserId());
		return map;
	}

	@RequestMapping(value="/checkUp", method = RequestMethod.GET)
	public String checkUp(HttpServletRequest request, ModelMap model) {
		return "user/checkUp";
	}

	/**
	 * CheckUp data 등록
	 *
	 * @param checkup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/checkupAdd", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkupAdd(@ModelAttribute("checkup") CheckupVO checkup) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		boolean isError = false;
		String message = "";
		UserVO vo = (UserVO) getRequestAttribute("user");
		try {
			checkup.setAdminId(vo.getUserId());
			userService.insertCheckUp(checkup);

			nutriService.insertNutriAnly(checkup.getUserId());

			//이력 추가.
			Map<String,String> param = new HashMap<String,String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS06");
			param.put("hisEndDt", "");
			param.put("prssUsrId", vo.getUserId());
			String tempMsg = "Administrator " + vo.getUserId() + " - " + "{0}" + " was a success";
			param.put("msgEtc", tempMsg);

			//historyInfoService.commInsertHistory(param,"");
			message = "Added.";

		} catch(Exception e) {
			LOGGER.error(e.toString());
			isError = true;
			map.put("message", e.getMessage());
			//이력 추가.
			Map<String,String> param = new HashMap<String,String>();
			param.put("hisType", "HT16");
			param.put("batchId", "");
			param.put("prssType", "HS06");
			param.put("hisEndDt", "");
			param.put("prssUsrId", vo.getUserId());
			String tempMsg = "Administrator " + vo.getUserId() + " - " + "{0}" + " failed.";
			param.put("msgEtc", tempMsg);
			//historyInfoService.commInsertHistory(param,"");
		}

		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	/**
	 * downform Data Make
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/downform", produces="application/json;charset=UTF-8")
	public void downform(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			String os = System.getProperty("os.name").toLowerCase();
			String path = "";

			System.out.println("###################################");
			System.out.println("###################### downform OS : " + os);
			System.out.println("###################################");

			if (os.contains("window")) {
				path = windowPreOpenFilePath;
			}else{
				path = linuxPreOpenFilePath;
			}

			File dFile = new File(path, "twalk_downData.csv");
			int fSize = (int)dFile.length();

			if (fSize > 0) {
				String encodedFilename = URLEncoder.encode("twalk_downData.csv", "UTF-8");
				response.setContentType("text/csv; charset=utf-8");
				response.setHeader("filename", encodedFilename);
				response.setContentLength(fSize);

				BufferedInputStream in = null;
				BufferedOutputStream out = null;

				in  = new BufferedInputStream(new FileInputStream(dFile));
				out = new BufferedOutputStream(response.getOutputStream());

				try {
					byte[] buffer = new byte[4096];
					int bytesRead = 0;

					while ((bytesRead = in.read(buffer)) != -1) {
						out.write(buffer, 0, bytesRead);
					}
					out.flush();
				} finally {
					in.close();
					out.close();
				}
			} else {
				throw new FileNotFoundException("파일이 없습니다.");
			}
		} catch (Exception e) {
			LOGGER.info(e.getMessage());
		}
	}

	@ResponseBody
	@RequestMapping(value = "/selectAdminById", method = RequestMethod.POST)
	public Map<String, Object> selectAdminById(@ModelAttribute("checkup") CheckupVO checkup) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;
		UserVO resultUserVO = new UserVO();
		String userId = checkup.getUserId();

		try {
			resultUserVO = userService.selectUserInfoDetail(userId);
			//String pwd = resultUserVO.getPwd();
			map.put("row", resultUserVO);
		} catch (Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/selectValidMinMax", method = RequestMethod.POST)
	public Map<String, Object> selectValidMinMax() {
		Map<String, Object> map = new HashMap<>();
		List<Map> minmaxList = new ArrayList<>();

		String message = "";
		boolean isError = false;

		try {
			minmaxList = userService.selectValidMinMax();
			map.put("row", minmaxList);
		} catch (Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}
		map.put("isError", isError);
		map.put("message", message);
		return map;
	}

	@RequestMapping(value="/checkUpResult", method = RequestMethod.GET)
	public String checkUpResult(HttpServletRequest request, ModelMap model) {
		return "userDtlCheckUpResult";
	}

}