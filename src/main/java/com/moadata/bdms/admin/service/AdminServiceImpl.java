package com.moadata.bdms.admin.service;

import com.moadata.bdms.admin.repository.AdminDao;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.moadata.bdms.support.idgen.service.IdGenService;
import java.util.UUID;

@Service(value = "adminService")
public class AdminServiceImpl implements AdminService {
	@Resource(name="adminDao")
	private AdminDao adminDao;

	@Resource(name = "userIdGenService")
	private IdGenService userIdGenService;

	private String managerId="admin";

	@Override
	public List<UserVO> selectAdminList(UserVO userVO) {
		return adminDao.selectAdminList(userVO);
	}

	@Override
	public void insertAdmin(UserVO user) throws Exception {
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
		//user.setUid(userIdGenService.getNextStringId());
		user.setUid(UUID.randomUUID().toString());

		// INSERT USER
		adminDao.insertAdmin(user);
	}

	@Override
	public int selectAdminIdCnt(String userId) {
		return adminDao.selectAdminIdCnt(userId);
	}

	@Override
	public List<Map> selectManagerGroupList(String grpId){
		return adminDao.selectManagerGroupList(grpId);
	}

	@Override
	public void updateAdmin(UserVO user) {
		if(user.getModifyId() == null) {
			user.setModifyId(user.getUserId());
		}
		adminDao.updateAdmin(user);
	}

	@Override
	public void adminDelete(UserVO user){
		adminDao.adminDelete(user.getParamList());
	}
}
