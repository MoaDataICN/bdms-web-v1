package com.moadata.bdms.user.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

//import com.moadata.hsmng.common.annotation.PrivacySrch;
import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.UserVO;

/**
 * User Dao
 */
@Repository("userDao")
@SuppressWarnings("unchecked")
public class UserDao extends BaseAbstractDao {
	public List<UserVO> selectUserList(UserVO user) {
		List<UserVO> list = selectList("user.selectUserList", user);
		if(list.size() > 0) {
			list.get(0).setCnt((int)selectOne("user.selectTotalRecords"));
		}
		return list;
	}
	
	public UserVO selectUserInfo(String userId) {
		return (UserVO) selectOne("user.selectUserInfo", userId);
	}
	
	public UserVO selectUserInfoByUid(String uid) {
		return (UserVO) selectOne("user.selectUserInfoByUid", uid);
	}
	
	public int selectUserIdCnt(String userId) {
		return (int) selectOne("user.selectUserIdCnt", userId);
	}
	
	public int selectUserCntByUserGroupId(String userGroupId) {
		return (int) selectOne("user.selectUserCntByUserGroupId", userGroupId);
	}
	
	public void insertUser(UserVO user) {
		insert("user.insertUser", user);
	}
	
	public void updateUser(UserVO user) {
		update("user.updateUser", user);
	}
	
	public void updateUserGroupId(UserVO user) {
		update("user.updateUserGroupId", user);
	}
	
	public int deleteUser(String uid) {
		return delete("user.deleteUser", uid);
	}
	
	public void deleteUserList(List<String> list) {
		delete("user.deleteUserList", list);
	}

    public List<UserVO> selectUserByUseAllList() {
	    return selectList("user.selectUserByUseAllList");
    }
    //사용자 삭제 전 암호화 파일을 만드는 용도로 추가.
    //@PrivacySrch("userNm,phoneNo")
    public UserVO deleteUserInfoByUid(UserVO user) {
		return (UserVO) selectOne("user.selectUserInfoByUid", user);
	}
    
    public UserVO selectUserInfoDetail(String userId) {
    	return (UserVO) selectOne("user.selectUserInfoDetail", userId);
    }
    
    public void updateUserInfo(UserVO user) {
		update("user.updateUserInfo", user);
	}
}
