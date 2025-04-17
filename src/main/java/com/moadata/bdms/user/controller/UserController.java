package com.moadata.bdms.user.controller;

import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.common.util.StringUtil;
import com.moadata.bdms.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "codeService")
	private CodeService codeService;
	
	@Resource(name = "userGroupService")
	private UserGroupService userGroupService;
	
	@Resource(name = "menuService")
	private MenuService menuService;

	@Value("${file.save.dir.linux}")
	private String linuxPreOpenFilePath;

	@Value("${file.save.dir.windows}")
	private String windowPreOpenFilePath;

	@RequestMapping(value="/userSearch", method = RequestMethod.GET)
	public String userSearch(HttpServletRequest request, ModelMap model) {

		return "user/userSearch";
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
			
		} catch(Exception e) {
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
			
		} catch(Exception e) {
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
			//usergroup 제거 22.08.23
			//슈퍼 권한은 추후 수정 22.08.23
			if(user.getUid().equals("USR_000000000000")) {
				throw new ProcessException("슈퍼사용자는 편집할수 없습니다.");
			}
		
			user.setModifyId(vo.getUserId());

			if(user.getUserPw()!= null) {
				String encryptPassword = EncryptUtil.encryptSha(user.getUserPw());
				user.setUserPw(encryptPassword);
				//비밀번호 변경시 비밀번호 변경 날짜 업데이트 해야됨 22.08.23
			}
			
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
			user.setJobType("U");
			
			if(!user.getOldLockYn().equals(user.getLockYn()) && user.getLockYn().equals("N")) {
				//잠긴 계정을 풀었을 경우  oldLockYn 값을 C로 설정하여 로그인 시간을 현재시간으로 업데이트 한다.
				user.setOldLockYn("C");
			}
			
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
			
			message = "편집되었습니다.";
			
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
			message = "삭제되었습니다.";
			/*
			for(String uid : user.getUIds().split(",")) {
				if(uid.equals("USR_000000000000")) {
					throw new ProcessException("슈퍼 사용자는 삭제할 수 없습니다");
				}
			}*/
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
		}catch(Exception e) {
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
			//UserGroupVO vo = (UserGroupVO) getRequestAttribute("usergroup");
			//if("Y".equalsIgnoreCase(vo.getUsergroupBtnYn()))
			//{
				UserVO user = (UserVO) getRequestAttribute("user");
				userVO.setRegistId(user.getUserId());
				/* 그룹이 제거되어 아래 구문 주석 처리 22.08.22
				if(userVO.getUsergroupId().equals("UGP_000000000000")) {
					throw new ProcessException("슈퍼그룹은 편집 할 수 없습니다.");
				}*/
				
				userService.userMenuUpdate(userVO);
				message = "편집 되었습니다.";
			//}
			//else
			//{
			//	message = "권한이 없습니다.";
			//}
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
	 * 비밀번호 변경 페이지이동
	 * 
	 * @return
	
	@Auth
	@RequestMapping(value = "/userPwChange", method = RequestMethod.GET)
	public String userPwChange(HttpServletRequest request,ModelMap model) {
		
	
		return "user/userPwChange";
	}
	 */
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
	public @ResponseBody Map<String, Object> checkupAdd(@ModelAttribute("checkup") CheckupVO checkup)throws Exception{
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
}