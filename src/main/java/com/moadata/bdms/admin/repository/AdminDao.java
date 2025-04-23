package com.moadata.bdms.admin.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("adminDao")
public class AdminDao extends BaseAbstractDao {

	public List<UserVO> selectAdminList(UserVO userVO) {
		List <UserVO> resultList = new ArrayList<UserVO>();
		resultList = selectList("admin.selectAdminList", userVO);
		if(resultList.size() > 0) {
			resultList.get(0).setCnt((int)selectOne("admin.selectTotalRecords"));
		}
		return resultList;
	}

	public void insertAdmin(UserVO user) {
		insert("admin.insertAdmin", user);
	}

	public int selectAdminIdCnt(String userId) {
		return (int) selectOne("admin.selectAdminIdCnt", userId);
	}

	public List<Map> selectManagerGroupList(String grpId){
		return selectList("admin.selectManagerGroupList", grpId);
	}

	public void updateAdmin(UserVO user) {
		update("admin.updateAdminInfo", user);
	}
}