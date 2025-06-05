package com.moadata.bdms.user.service;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.dto.*;
import com.moadata.bdms.model.vo.*;
import com.moadata.bdms.support.idgen.service.IdGenService;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.repository.UserDao;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.*;

/**
 * User Service 구현
 */
@Service(value = "userService")
public class UserServiceImpl implements UserService {
	@Resource(name="userDao")
	private UserDao userDao;

	@Value("${manager.id}")
	private String managerId;

	@Resource(name = "userIdGenService")
	private IdGenService userIdGenService;
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
//	@Resource(name = "historyInfoService")
//	private HistoryInfoService historyInfoService;

	public List<UserSearchDTO> selectUserSearch(UserSearchDTO userSearchDTO) {
		try {
			if(userSearchDTO.getMobile() != null && !userSearchDTO.getMobile().isEmpty()) {
				userSearchDTO.setMobile(EncryptUtil.encryptText(userSearchDTO.getMobile()));
			}

			if(userSearchDTO.getBrthDt() != null && !userSearchDTO.getBrthDt().isEmpty()) {
				userSearchDTO.setBrthDt(EncryptUtil.encryptText(userSearchDTO.getBrthDt()));
			}

			if(userSearchDTO.getUserNm() != null && !userSearchDTO.getUserNm().isEmpty()) {
				userSearchDTO.setUserNm(EncryptUtil.encryptText(userSearchDTO.getUserNm()));
			}

			List<UserSearchDTO> userSearchList = userDao.selectUserSearch(userSearchDTO);

			if(userSearchList.size() > 0) {
				for(UserSearchDTO userSearch : userSearchList) {
					userSearch.setUserNm(EncryptUtil.decryptText(userSearch.getUserNm()));
					userSearch.setBrthDt(EncryptUtil.decryptText(userSearch.getBrthDt()));
					userSearch.setMobile(EncryptUtil.decryptText(userSearch.getMobile()));
				}
			}

			return userSearchList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public UserDtlGeneralDTO selectUserDtlGeneral(String userId) {
		try {
			UserDtlGeneralDTO userDtlGeneralDTO = userDao.selectUserDtlGeneral(userId);

			if (userDtlGeneralDTO.getUserNm() != null && !userDtlGeneralDTO.getUserNm().isEmpty()) {
				userDtlGeneralDTO.setUserNm(EncryptUtil.decryptText(userDtlGeneralDTO.getUserNm()));
			}

			if (userDtlGeneralDTO.getMobile() != null && !userDtlGeneralDTO.getMobile().isEmpty()) {
				userDtlGeneralDTO.setMobile(EncryptUtil.decryptText(userDtlGeneralDTO.getMobile()));
			}

			if (userDtlGeneralDTO.getBrthDt() != null && !userDtlGeneralDTO.getBrthDt().isEmpty()) {
				userDtlGeneralDTO.setBrthDt(EncryptUtil.decryptText(userDtlGeneralDTO.getBrthDt()));
			}

			return userDtlGeneralDTO;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public boolean updateUserResetPwByAdmin(MyResetPwDTO myResetPwDTO) {
		int updatedRows = userDao.updateUserResetPwByAdmin(myResetPwDTO);
		return updatedRows > 0;
	}

	@Override
	public boolean updateUserGeneral(UserUpdateDTO userUpdateDTO) {
		try {
			// 암호화
			if (userUpdateDTO.getMobile() != null && !userUpdateDTO.getMobile().isEmpty()) {
				userUpdateDTO.setMobile(EncryptUtil.encryptText(userUpdateDTO.getMobile()));
			}

			if (userUpdateDTO.getBrthDt() != null && !userUpdateDTO.getBrthDt().isEmpty()) {
				userUpdateDTO.setBrthDt(EncryptUtil.encryptText(userUpdateDTO.getBrthDt()));
			}

			// UPT_ID도 암호화 추가할 것
			System.out.println(userUpdateDTO.getGrpTp());
			System.out.println(userUpdateDTO.getGrpTp());
			System.out.println(userUpdateDTO.getGrpTp());
			System.out.println(userUpdateDTO.getGrpTp());

			int updatedRows = userDao.updateUserGeneral(userUpdateDTO);
			return updatedRows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<UserSearchDTO> selectInChargeNmList(Map<String, Object> param) {
		try {
			List<UserSearchDTO> inChargeList = userDao.selectInChargeNmList(param);
			return inChargeList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<UserSearchDTO> selectAllInChargeNm() {
		try {
			List<UserSearchDTO> inChargeList = userDao.selectAllInChargeNm();
			return inChargeList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<UserSearchDTO> selectLowLevelAdmins(String grpId) {
		return userDao.selectLowLevelAdmins(grpId);
	}

	@Override
	public boolean updateUserInChargeIdByNm(UserUpdateDTO userUpdateDTO) {
		try {
			int updatedRows = userDao.updateUserInChargeIdByNm(userUpdateDTO);
			return updatedRows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean insertUserBody(UserUpdateDTO userUpdateDTO) {
		try {
			int insertedRows = userDao.insertUserBody(userUpdateDTO);
			return insertedRows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<UserDtlHealthAlertsDTO> selectUserDtlHealthAlerts(UserDtlHealthAlertsDTO userDtlHealthAlertsDTO) {
		return userDao.selectUserDtlHealthAlerts(userDtlHealthAlertsDTO);
	}

	@Override
	public List<Map<String, Object>> selectAllHealthAlertsCnt(Map<String, Object> param) {
		return userDao.selectAllHealthAlertsCnt(param);
	}

	@Override
	public List<Map<String, Object>> selectLast24hHealthAlertsCnt(Map<String, Object> param) {
		return userDao.selectLast24hHealthAlertsCnt(param);
	}

	@Override
	public boolean updateAltStt(Map<String, Object> param) {
		try {
			int updatedRows = userDao.updateAltStt(param);
			return updatedRows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<UserDtlServiceRequestsDTO> selectUserDtlServiceRequests(UserDtlServiceRequestsDTO userDtlServiceRequestsDTO) {
		return userDao.selectUserDtlServiceRequests(userDtlServiceRequestsDTO);
	}

	@Override
	public List<Map<String, Object>> selectAllServiceRequestsCnt(Map<String, Object> param) {
		return userDao.selectAllServiceRequestsCnt(param);
	}

	@Override
	public List<Map<String, Object>> selectLast24hServiceRequestsCnt(Map<String, Object> param) {
		return userDao.selectLast24hServiceRequestsCnt(param);
	}
	@Override
	public boolean updateReqStt(Map<String, Object> param) {
		try {
			int updatedRows = userDao.updateReqStt(param);
			return updatedRows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    }

	@Override
	//@PrivacySrch("userNm,phoneNo")
	public List<UserVO> selectUserList(UserVO user) {
		return userDao.selectUserList(user);
	}
	
	@Override
	//@PrivacySrch("userNm,phoneNo")
	public UserVO selectUserInfo(String userId) {
		return userDao.selectUserInfo(userId);
	}

	@Override
	public UserInfoVO selectUserInfoForGrpc(String userId) throws Exception {
		if (userId != null && !userId.isEmpty()) { // null 체크 및 비어있는지 확인
			try {
				UserInfoVO user = userDao.SelectUserInfoForGrpc(userId); // 메서드명 수정
				if (user != null) { // null 체크로 변경
					// user가 비어있는지 확인할 수 있는 메서드가 없으면 삭제
					user.setBrthDt(EncryptUtil.decryptText(user.getBrthDt()));
					user.setUserNm(EncryptUtil.decryptText(user.getUserNm()));
					user.setMobile(EncryptUtil.decryptText(user.getMobile()));
					return user;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override	
	public UserVO selectUserInfoByUid(String uid) {
		return userDao.selectUserInfoByUid(uid);
	}
	
	@Override
	public int selectUserIdCnt(String userId) {
		return userDao.selectUserIdCnt(userId);
	}
	
	@Override
	public int selectUserCntByUserGroupId(String userGroupId) {
		return userDao.selectUserCntByUserGroupId(userGroupId);
	}
	
	@Override
	//@PrivacySrch("userNm,phoneNo")
	public void insertUser(UserVO user) throws Exception {
		boolean isAdmin = user.getUserId().equals(managerId);
		if(!isAdmin) {
			if(user.getUseYn() == null) {
				user.setUseYn("N");
				// 운영자
				user.setUserType("UT03");
			}
		} else {
			user.setUseYn("Y");
			// 최상위 관리자
			user.setUserType("UT01");
		}
		
		//uid 생성 추가 22.08.19ㄴ
		user.setUid(userIdGenService.getNextStringId());
		
		// INSERT USER
		userDao.insertUser(user);
	}
	
	@Override
	//@PrivacySrch("userNm,phoneNo")
	public void updateUser(UserVO user) {
		if(user.getModifyId() == null) {
			user.setModifyId(user.getUserId());
		}
		userDao.updateUser(user);
	}
	
	@Override
	public void updateUserGroupId(UserVO user) {
		user.setModifyId(user.getUserId());
		userDao.updateUserGroupId(user);
	}
	
	@Override
	public void deleteUser(String uid) {
		userDao.deleteUser(uid);
	}
	
	@Override
	public void deleteUserList(UserVO user) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		int tempVal = 0;
		List<Map> delDataMap = user.getDelDataMap();
		String userId = "";
		for(String uid : user.getUIds().split(",")) {
			//사용자 삭제 전 상세조회를 하기 위해 임시 UserVO를 생성 후 조회하여 암호화 파일을 생성한다.
			UserVO temp = new UserVO();
			temp.setJobType("D");
			temp.setUid(uid);		
			userDao.deleteUserInfoByUid(temp);
			// DELETE USER
			tempVal = userDao.deleteUser(uid);
			for(int i=0; i< delDataMap.size(); i++) {
				if(delDataMap.get(i).get("uid").equals(uid)) {
					userId = delDataMap.get(i).get("userId").toString();
				}
			}
			
			if(tempVal > 0) {				
				//성공
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT16");
				param.put("batchId", "");
				param.put("prssType", "HS07");
				param.put("hisEndDt", "");
				param.put("prssUsrId", user.getLoginId());				
				String tempMsg = "사용자 " + userId + " - " + "{0}" + " 성공 하였습니다.";
				param.put("msgEtc", tempMsg);
				//historyInfoService.commInsertHistory(param,"");
			}else {
				//실패
				Map<String,String> param = new HashMap<String,String>();
				param.put("hisType", "HT16");
				param.put("batchId", "");
				param.put("prssType", "HS07");
				param.put("hisEndDt", "");
				param.put("prssUsrId", user.getLoginId());				
				String tempMsg = "사용자 " + userId + " - " + "{0}" + " 실패 하였습니다.";
				param.put("msgEtc", tempMsg);
				//historyInfoService.commInsertHistory(param,"");
			}
			
			//메뉴 권한 삭제		
			paramMap = new HashMap<String, Object>(); 
			paramMap.put("usergroupId", uid);			
			menuService.deleteUserGroupMenuAll(paramMap);
		}
	}

    @Override
    public List<UserVO> selectUserByUseAllList() {
        return userDao.selectUserByUseAllList();
    }
    
    //사용자 메뉴 수정 추가 22.08.22
	@Override
	public void userMenuUpdate(UserVO user) {
		//UserVO userInfo = userDao.selectUserInfo(user.getUserId());
		UserVO userInfo = userDao.selectUserInfoByUid(user.getUid()); //사용자 아이디에서 uid로 변경.		
	
		Assert.notNull(userInfo, "사용자 정보가 존재하지 않습니다.");
		
		Map<String, Object> map;
		try {

			//List<MenuVO> userGroupMenuList = menuService.selectMenuIdByGroup(user.getUserId());
			List<MenuVO> userGroupMenuList = menuService.selectMenuIdByGroup(userInfo.getUid()); //사용자 아이디에서 uid로 변경.
			//MENU 권한 삭제
			for(String delMenuId : user.getDelMenuIds().split(",")) {
				for(MenuVO vo: userGroupMenuList) {
					if(vo.getMenuId().equals(delMenuId)) {
						map = new HashMap<String, Object>(); 
						//map.put("usergroupId", userInfo.getUserId());
						map.put("usergroupId", userInfo.getUid());
						map.put("menuId", delMenuId);
						
						menuService.deleteUserGroupMenu(map);
					}
				}
			}
			
			//MENU 권한 등록 및 수정
			for(String menuId : user.getMenuIds().split(",")) {
				map = new HashMap<String, Object>(); 
				String[] valArr = menuId.split("=");				
			//	map.put("usergroupId", userInfo.getUserId());
				map.put("usergroupId", userInfo.getUid());
				map.put("menuId", valArr[0]);
				map.put("permission", valArr[1]);
				map.put("registId", user.getRegistId());
				
				menuService.updateUserGroupMenu(map);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	//@PrivacySrch("userNm,phoneNo")
	public UserVO selectUserInfoDetail(String userId) {
		return userDao.selectUserInfoDetail(userId);
	}
	
	@Override	
	//@PrivacySrch("userNm,phoneNo")
	public void updateUserInfo(UserVO user) {
		if(user.getModifyId() == null) {
			user.setModifyId(user.getUserId());
		}
		userDao.updateUserInfo(user);
	}

	@Override
	public Map<String, Object> getImportMapForBDMS(MultipartFile file, String loginId){

		Map<String, Object> map = new HashMap<>();
		boolean isError = false;
		String errorMessage = null;

		List<List<String>> csvList = new ArrayList<List<String>>();

		try {
			File nFile = new File(file.getOriginalFilename());
			//file.transferTo(nFile);
			nFile.createNewFile();
			FileOutputStream fos = new FileOutputStream(nFile);
			fos.write(file.getBytes());
			fos.close();

			BufferedReader br = new BufferedReader(new FileReader(nFile));
			String line;
			while ((line = br.readLine())!= null) {
				List<String> aLine = new ArrayList<String>();
				String[] lineArr = line.split(",");
				aLine = Arrays.asList(lineArr);
				csvList.add(aLine);
			}
			map.put("isError", isError);
			map.put("resultList", csvList);
			map.put("errorMessage", errorMessage);
			return map;
		}catch(Exception e) {
			e.printStackTrace();
			isError = true;
			map.put("isError", isError);
			map.put("resultList", null);
			map.put("errorMessage", "Excel Import failed。");
			return map;
		}
	}

	@Override
	public void insertCheckUp(CheckupVO checkupVO) throws Exception {
		userDao.insertCheckUp(checkupVO);
	}

	@Override
	public List<Map> selectValidMinMax(){
		return userDao.selectValidMinMax();
	}

	@Override
	public List<UserDtlCheckUpResultDTO> selectUserDtlCheckUpResults(UserDtlCheckUpResultDTO userDtlCheckUpResultDTO){
		return userDao.selectUserDtlCheckUpResults(userDtlCheckUpResultDTO);
	}

	@Override
	public ReportVO getOneLatestReportByUserId(String userId) {
		return userDao.selectOneLatestReportByUserId(userId);
	}

	@Override
	public ReportVO selectOneLatestReport() {
		return userDao.selectOneLatestReport();
	}

	@Override
	public List<HealthInfoVO> getHealthInfoByReportId(String reportId) {
		return userDao.selectHealthInfoByReportId(reportId);
	}

	/** 건강분석 인증키 업데이트 */
	public void updateCheckupKey(UserInfoVO userInfo) {
		userDao.updateCheckupKey(userInfo);
	}

	/** 생체나이 저장 S */
	@Override
	public void insertAnlyData(HealthInfoVO healthInfo) {
		userDao.insertAnlyData(healthInfo);
	}

	@Override
	public void updateGRPCFlag(String reportId) {
		userDao.updateGRPCFlag(reportId);
	}

	@Override
	/** Checkup Management - Upload Status */
	public List<CheckupVO> selectCheckUpStatus(CheckupVO checkup) {
		try {
			if(checkup.getUserNm() != null && !checkup.getUserNm().isEmpty()) {
				checkup.setUserNm(EncryptUtil.encryptText(checkup.getUserNm()));
			}

			if(checkup.getBrthDt() != null && !checkup.getBrthDt().isEmpty()) {
				checkup.setBrthDt(EncryptUtil.encryptText(checkup.getBrthDt()));
			}

			List<CheckupVO> list = userDao.selectCheckUpStatus(checkup);

			return list;
		} catch(Exception e){
			e.printStackTrace();
		}

		return null;
	}
}
