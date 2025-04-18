package com.moadata.bdms.user.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.*;
import javax.annotation.Resource;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.dto.MyResetPwDTO;
import com.moadata.bdms.model.dto.UserDtlGeneralVO;
import com.moadata.bdms.model.dto.UserSearchDTO;
import com.moadata.bdms.model.dto.UserUpdateDTO;
import com.moadata.bdms.model.vo.*;

import com.moadata.bdms.model.vo.CheckupVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
//import com.moadata.hsmng.common.annotation.PrivacySrch;
//import com.moadata.hsmng.dash.repository.DashDao;
//import com.moadata.hsmng.history.service.HistoryInfoService;
import com.moadata.bdms.support.idgen.service.IdGenService;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.repository.UserDao;
import org.springframework.web.multipart.MultipartFile;

/**
 * User Service 구현
 */
@Service(value = "userService")
public class UserServiceImpl implements UserService {
	@Resource(name="userDao")
	private UserDao userDao;
	
//	@Resource(name="dashDao")
//	private DashDao dashDao;
	
//	@Value("#{config['product.option']}")
//	private String productOption;
	
	@Value("${manager.id}")
	private String managerId;
	
//	@Value("#{config['dash.default.dashNm']}")
//	private String defaultDashNm;
	
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

//			if(userSearchDTO.getInChargeNm() != null && !userSearchDTO.getInChargeNm().isEmpty()) {
//				userSearchDTO.setInChargeNm(EncryptUtil.encryptText(userSearchDTO.getInChargeNm()));
//			}

			List<UserSearchDTO> userSearchList = userDao.selectUserSearch(userSearchDTO);

			if(userSearchList.size() > 0) {
				for(UserSearchDTO userSearch : userSearchList) {
					userSearch.setUserNm(EncryptUtil.decryptText(userSearch.getUserNm()));
					userSearch.setBrthDt(EncryptUtil.decryptText(userSearch.getBrthDt()));
					userSearch.setMobile(EncryptUtil.decryptText(userSearch.getMobile()));
//					userSearch.setInChargeNm(EncryptUtil.decryptText(userSearch.getInChargeNm()));
				}
			}

			return userSearchList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public UserDtlGeneralVO selectUserDtlGeneral(String reqId) {
		try {
			UserDtlGeneralVO userDtl = userDao.selectUserDtlGeneral(reqId);

			if (userDtl.getUserNm() != null && !userDtl.getUserNm().isEmpty()) {
				userDtl.setUserNm(EncryptUtil.decryptText(userDtl.getUserNm()));
			}

			if (userDtl.getMobile() != null && !userDtl.getMobile().isEmpty()) {
				userDtl.setMobile(EncryptUtil.decryptText(userDtl.getMobile()));
			}

//			if (userDtl.getInChargeNm() != null && !userDtl.getInChargeNm().isEmpty()) {
//				userDtl.setInChargeNm(EncryptUtil.decryptText(userDtl.getInChargeNm()));
//			}

			if (userDtl.getBrthDt() != null && !userDtl.getBrthDt().isEmpty()) {
				userDtl.setBrthDt(EncryptUtil.decryptText(userDtl.getBrthDt()));
			}

			System.out.println("가입일(registDt): " + userDtl.getRegistDt());
			System.out.println("최근접속일(lastAccess): " + userDtl.getLastAccess());

			return userDtl;

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

//			if (userUpdateDTO.getInChargeNm() != null && !userUpdateDTO.getInChargeNm().isEmpty()) {
//				userUpdateDTO.setInChargeNm(EncryptUtil.encryptText(userUpdateDTO.getInChargeNm()));
//			}

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
	public List<UserSearchDTO> selectAllInChargeNm() {
		try {
			List<UserSearchDTO> inChargeList = userDao.selectAllInChargeNm();
			return inChargeList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
    }

//	@Override
//	public List<String> selectHigherInChargeNm(String grpLv) {
//		try {
//			if (grpLv != null && !grpLv.isEmpty()) {
//				return userDao.selectHigherInChargeNm(grpLv);
//			} else {
//				return Collections.emptyList();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null;
//	}

	@Override
	public boolean updateUserInChargeIdByNm(UserUpdateDTO userUpdateDTO) {
		try {
//			if (userUpdateDTO.getInChargeNm() != null && !userUpdateDTO.getInChargeNm().isEmpty()) {
//				userUpdateDTO.setInChargeNm(EncryptUtil.encryptText(userUpdateDTO.getInChargeNm()));
//			}
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
		/*
		if("solar".equals(productOption)) {
			List<DashVO> dashList = (List<DashVO>) dashDao.selectDashListByUser(uid);
			
			for(DashVO dash : dashList) {
				// DELETE DASH LAYOUT
				dashDao.deleteDashLayoutByDash(dash.getDashId());
				// DELETE DASH
				dashDao.deleteDash(dash.getDashId());
			}
		}
		*/
		// DELETE USER
		userDao.deleteUser(uid);
	}
	
	@Override
	public void deleteUserList(UserVO user) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		int tempVal = 0;
		List<Map> delDataMap = user.getDelDataMap();
		String userId = "";
		for(String uid : user.getUIds().split(",")) {
			/*
			if("solar".equals(productOption)) {
				List<DashVO> dashList = (List<DashVO>) dashDao.selectDashListByUser(uid);
				
				for(DashVO dash : dashList) {
					// DELETE DASH LAYOUT
					dashDao.deleteDashLayoutByDash(dash.getDashId());
					// DELETE DASH
					dashDao.deleteDash(dash.getDashId());
				}
			}*/
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
		if(checkupVO.getBrthDt() != null && !checkupVO.getBrthDt().isEmpty()) {
			checkupVO.setBrthDt(EncryptUtil.encryptText(checkupVO.getBrthDt()));
		}

		userDao.insertCheckUp(checkupVO);
	}
}
