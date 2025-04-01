package com.moadata.bdms.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
//import com.moadata.hsmng.common.annotation.PrivacySrch;
//import com.moadata.hsmng.dash.repository.DashDao;
//import com.moadata.hsmng.history.service.HistoryInfoService;
import com.moadata.bdms.model.vo.MenuVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.support.idgen.service.IdGenService;
import com.moadata.bdms.support.menu.service.MenuService;
import com.moadata.bdms.user.repository.UserDao;

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
}
