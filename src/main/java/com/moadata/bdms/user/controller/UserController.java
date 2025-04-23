package com.moadata.bdms.user.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.common.util.StringUtil;
import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.dto.MyResetPwDTO;
import com.moadata.bdms.model.dto.UserDtlGeneralVO;
import com.moadata.bdms.model.dto.UserSearchDTO;
import com.moadata.bdms.model.dto.UserUpdateDTO;
import com.moadata.bdms.model.vo.*;
import com.moadata.bdms.tracking.service.TrackingService;
import org.springframework.beans.factory.annotation.Value;
import com.moadata.bdms.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.common.exception.ProcessException;
//import com.moadata.hsmng.common.intercepter.Auth;
//import com.moadata.hsmng.history.service.HistoryInfoService;
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

    // 임시 조회
	@Resource(name = "trackingService")
	private TrackingService trackingService;



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

    // 확인 필요
//	@Value("${admin.grpId}")
//	private String grpId;
//
//	@Value("${admin.grpLv}")
//	private String grpLv;

	@Value("${admin.userId}")
	private String userId;

    @Value("${file.save.dir.linux}")
    private String linuxPreOpenFilePath;

    @Value("${file.save.dir.windows}")
    private String windowPreOpenFilePath;

	@GetMapping("/userSearch")
	public String userSearch(ModelMap model, HttpServletRequest request) {
		// 세션에 저장 된, 사용자의 정보를 바탕으로 조회를 수행
		// GRP_ID, GRP_LV 를 세션에 저장하며, 이를 바탕으로 조회 조건 및 레벨이 달라짐

		HttpSession session = request.getSession(false);
		UserVO user = (UserVO) session.getAttribute("user");

		String grpId = user.getGrpId();
		String grpLv = user.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);

		if(grpLv != null && grpLv.equals("1")) {
			// 최상위 관리자인 경우
			List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
//			List<UserVO> inChargeList = groupService.selectLowLevelAdmins(grpId);  // grp.GRP_NM -> my.GRP_TP

			List<UserSearchDTO> inChargeNmList = userService.selectAllInChargeNm();

			if (inChargeNmList != null && !inChargeNmList.isEmpty()) {
				for (UserSearchDTO inChargeNm : inChargeNmList) {
					System.out.println("IN_CHARGE_ID : " + inChargeNm.getInChargeId());
					System.out.println("IN_CHARGE_NM : " + inChargeNm.getInChargeNm());
				}
			}

			model.addAttribute("inChargeNmList", inChargeNmList);
			model.addAttribute("grpLv", grpLv);  // 원래 코드

			model.addAttribute("groupList", groupList);
//			model.addAttribute("inChargeList", inChargeList);

		} else if(grpLv != null && grpLv.equals("2")) {
			model.addAttribute("inChargeId", userId);
		}

		return "user/userSearch";
	}

	@ResponseBody
	@RequestMapping(value = "/selectUserSearch", method = RequestMethod.POST)
	public Map<String, Object> selectUserSearch(@ModelAttribute UserSearchDTO userSearchDTO) {
		Map<String, Object> map = new HashMap<>();

		System.out.println("==============================");
		System.out.println(userSearchDTO.getInChargeId());
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

	@RequestMapping(value = "/detail/{tab}", method = RequestMethod.POST)
	public String getUserDetail(@PathVariable String tab, @RequestParam String reqId, Model model, HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		UserVO user = (UserVO) session.getAttribute("user");

		String grpId = user.getGrpId();
		String grpLv = user.getGrpLv();

		System.out.println("grpId : " + grpId);
		System.out.println("grpLv : " + grpLv);
		System.out.println("reqId : " + reqId);
		UserDtlGeneralVO userDtlGeneralVO = userService.selectUserDtlGeneral(reqId);
		System.out.println(userService.selectUserDtlGeneral(reqId).toString());

		model.addAttribute("reqId", reqId);
		model.addAttribute("userDtlGeneral", userDtlGeneralVO);

		switch (tab) {
            case "general":
                System.out.println("tab : general");

				/**
				String adminGrpLv = grpLv;  // 로그인한 관리자 grpLv
				String userGrpLv = userDtlGeneralVO.getGrpLv();  // 대상 사용자 grpLv

				List<String> inChargeNmList = null;

				if (Integer.parseInt(userGrpLv) > Integer.parseInt(adminGrpLv)) {
					// 대상 사용자의 grpLv가 관리자 grpLv보다 낮을 때 → 대상 사용자보다 높은 grpLv의 담당자만 조회
					inChargeNmList = userService.selectHigherInChargeNm(userGrpLv);

					if (inChargeNmList != null && !inChargeNmList.isEmpty()) {
                        for (String inChargeNm : inChargeNmList) {
                            System.out.println("IN_CHARGE_NM : " + inChargeNm);
                        }
                    } else {
                        System.out.println("해당 이름으로 찾은 IN_CHARGE_NM가 없습니다.");
                    }
				}

				model.addAttribute("inChargeNmList", inChargeNmList);
				model.addAttribute("grpLv", grpLv);
				**/

				// GRP_LV가 '1'인 경우만 전체 담당자명 조회
                List<UserSearchDTO> inChargeNmList = null;

				System.out.println();
				System.out.println("grpLv : " + grpLv);
				System.out.println();

				// 최상위 관리자인 경우
				if(grpLv != null && grpLv.equals("1")) {  // 테스트용
					inChargeNmList = userService.selectAllInChargeNm(); // 테스트용

                    if (inChargeNmList != null && !inChargeNmList.isEmpty()) {
						for (UserSearchDTO inChargeNm : inChargeNmList) {
//							System.out.println("IN_CHARGE_ID : " + inChargeNm.getInChargeId());
							System.out.println("IN_CHARGE_NM : " + inChargeNm.getInChargeNm());
						}
					}
                }

                model.addAttribute("inChargeNmList", inChargeNmList);
				model.addAttribute("grpLv", grpLv);  // 원래 코드
//				model.addAttribute("grpLv", "2");  // 테스트용

                return "user/userDtlGeneral";
            case "health-alerts":
                System.out.println("tab : health-alerts");

				Map<String, Object> param1 = new HashMap<>();
//				param1.put("today", LocalDate.now().toString());  // 오늘 날짜 (필요 시 yyyy-MM-dd 포맷으로 맞춰줘)
				param1.put("today", "2025-03-24");

				if (grpLv != null && grpLv.equals("1")) {
					param1.put("grpId", grpId);
				} else {
					param1.put("inChargeId", userId);
				}

				// health alerts count
				List<Map<String, Object>> healthAlertCntList1 = trackingService.selectTodayHealthAlertCnt(param1);
				Map<String, Long> healthAlertCntMap1 = new HashMap<>();
				for(Map<String, Object> row : healthAlertCntList1) {
					String altTp = (String)row.get("ALT_TP");
					Long altCount = ((Number)row.get("ALT_COUNT")).longValue();
					healthAlertCntMap1.put(altTp, altCount);
				}

				// user request count (Ambulance, Nurse 등)
				List<Map<String, Object>> userRequestCntList = trackingService.selectTodayUserRequestCnt(param1);
				Map<String, Map<String, Long>> userRequestCntMap1 = new HashMap<>();
				for(Map<String, Object> row : userRequestCntList) {
					String reqTp = (String)row.get("REQ_TP");
					String reqStt = (String)row.get("REQ_STT");
					Long reqCount = ((Number)row.get("REQ_COUNT")).longValue();

					userRequestCntMap1.putIfAbsent(reqTp, new HashMap<>());
					userRequestCntMap1.get(reqTp).put(reqStt, reqCount);
				}

				model.addAttribute("healthAlertCntMap", healthAlertCntMap1);
				model.addAttribute("userRequestCntMap", userRequestCntMap1);

				return "user/userDtlHealthAlerts";
			case "service-requests":
				System.out.println("tab : service-requests");

				Map<String, Object> param2 = new HashMap<>();
//				param2.put("today", LocalDate.now().toString());  // 오늘 날짜 (필요 시 yyyy-MM-dd 포맷으로 맞춰줘)
				param2.put("today", "2025-03-24");

				if (grpLv != null && grpLv.equals("1")) {
					param2.put("grpId", grpId);
				} else {
					param2.put("inChargeId", userId);
				}

				// health alerts count
				List<Map<String, Object>> healthAlertCntList2 = trackingService.selectTodayHealthAlertCnt(param2);
				Map<String, Long> healthAlertCntMap2 = new HashMap<>();
				for(Map<String, Object> row : healthAlertCntList2) {
					String altTp = (String)row.get("ALT_TP");
					Long altCount = ((Number)row.get("ALT_COUNT")).longValue();
					healthAlertCntMap2.put(altTp, altCount);
				}

				// user request count (Ambulance, Nurse 등)
				List<Map<String, Object>> userRequestCntList2 = trackingService.selectTodayUserRequestCnt(param2);
				Map<String, Map<String, Long>> userRequestCntMap2 = new HashMap<>();
				for(Map<String, Object> row : userRequestCntList2) {
					String reqTp = (String)row.get("REQ_TP");
					String reqStt = (String)row.get("REQ_STT");
					Long reqCount = ((Number)row.get("REQ_COUNT")).longValue();

					userRequestCntMap2.putIfAbsent(reqTp, new HashMap<>());
					userRequestCntMap2.get(reqTp).put(reqStt, reqCount);
				}

				model.addAttribute("healthAlertCntMap", healthAlertCntMap2);
				model.addAttribute("userRequestCntMap", userRequestCntMap2);

				return "user/userDtlServiceRequests";
			case "input-checkup-data":
				System.out.println("tab : input-checkup-data");

				return "user/userDtlInputCheckupData";
            default:
                System.out.println("tab : general");

				return "user/userDtlGeneral";
        }
	}

	// 개발 중
	@ResponseBody
	@RequestMapping(value = "/selectHealthAlert", method = RequestMethod.POST)
	public Map<String, Object> selectHealthAlert(
			@RequestParam(required = false) String searchBgnDe,
			@RequestParam(required = false) String searchEndDe,
			@RequestParam(required = false) String altTp,
			@RequestParam(required = false) String inChargeId,
			@RequestParam(required = false) String inChargeIds,
			@RequestParam(required = false) String reqId,
			@RequestParam(required = false) Integer page,
			@RequestParam(required = false) Integer size
	) {
		System.out.println("searchBgnDe : " + searchBgnDe);
		System.out.println("searchEndDe : " + searchEndDe);
		System.out.println("altTp : " + altTp);
		System.out.println("inChargeId : " + inChargeId);
		System.out.println("inChargeIds : " + inChargeIds);
		System.out.println("reqId : " + reqId);
		System.out.println("page : " + page);
		System.out.println("size : " + size);

		Map<String, Object> result = new HashMap<>();
		result.put("page", 1);           // 페이지 번호
		result.put("total", 1);          // 전체 페이지 수
		result.put("records", 0);        // 전체 레코드 수
		result.put("rows", new ArrayList<>());  // 비어 있는 리스트라도 줘야 jqGrid 오류 안 남

		return result;
	}

	/**
	 * 관리자에 의한 사용자 비밀번호 초기화
	 */
	@ResponseBody
	@RequestMapping(value = "/resetPwByAdmin", method = RequestMethod.POST)
	public Map<String, Object> resetPwByAdmin(@RequestParam("userId") String userId,
											  @RequestParam("newPw") String newPw) {
		Map<String, Object> response = new HashMap<>();
		boolean isError = false;
		String message = "";

		try {
			// 현재 로그인한 관리자 정보
			UserVO adminVO = (UserVO) getRequestAttribute("user");

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
	public Map<String, Object> updateGeneral(@ModelAttribute UserUpdateDTO userUpdateDTO) {
		Map<String, Object> response = new HashMap<>();

		String message = "";
		boolean isError = false;

		if (userUpdateDTO.getUserId() == null || userUpdateDTO.getUserId().isEmpty()) {
			response.put("success", false);
			response.put("message", "userId는 필수입니다.");

			return response;
		}

		try {
			userUpdateDTO.setUptId(userId);  // 현재 접속한 uid를 넣어야 함

			// 1. 사용자 일반 정보 UPDATE
			boolean generalUpdated = userService.updateUserGeneral(userUpdateDTO);

			if (!generalUpdated) {
				response.put("success", false);
				response.put("message", "사용자 기본 정보 수정 실패");
				return response;
			}

			// 2. 담당자명 UPDATE
			boolean inChargeIdInserted = userService.updateUserInChargeIdByNm(userUpdateDTO);

			if (!inChargeIdInserted) {
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


	@RequestMapping(value = "/resetPwStartPopup", method = RequestMethod.GET)
	public String resetPwStartPopup(Model model) {
//		UserVO user = (UserVO) getRequestAttribute("user");
//		UserVO userInfo = userService.selectUserInfoDetail(user.getUserId());
//
//		model.addAttribute("userinfo", userInfo);

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
}