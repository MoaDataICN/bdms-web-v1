package com.moadata.bdms.user.repository;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moadata.bdms.model.dto.MyResetPwDTO;
import com.moadata.bdms.model.dto.UserDtlGeneralVO;
import com.moadata.bdms.model.dto.UserSearchDTO;
import com.moadata.bdms.model.dto.UserUpdateDTO;
import com.moadata.bdms.model.vo.CheckupVO;
import org.springframework.stereotype.Repository;

//import com.moadata.hsmng.common.annotation.PrivacySrch;
import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.UserVO;

import static java.lang.Math.pow;

/**
 * User Dao
 */
@Repository("userDao")
@SuppressWarnings("unchecked")
public class UserDao extends BaseAbstractDao {
	public List<UserSearchDTO> selectUserSearch(UserSearchDTO userSearchDTO) {
		List<UserSearchDTO> list = selectList("user.selectUserSearch", userSearchDTO);

		if(list.size() > 0) {
			list.get(0).setCnt((Integer)selectOne("user.selectUserSearchCnt", userSearchDTO));
		}

		return list;
	}

	public List<UserVO> selectUserList(UserVO user) {
		List<UserVO> list = selectList("user.selectUserList", user);
		if(list.size() > 0) {
			list.get(0).setCnt((int)selectOne("user.selectTotalRecords"));
		}
		return list;
	}

    public UserDtlGeneralVO selectUserDtlGeneral(String reqId) {
		return (UserDtlGeneralVO) selectOne("user.selectUserDtlGeneral", reqId);
    }

	public int updateUserResetPwByAdmin(MyResetPwDTO myResetPwDTO) {
		return update("user.updateUserResetPwByAdmin", myResetPwDTO);
	}


	public int updateUserGeneral(UserUpdateDTO userUpdateDTO) {
		return update("user.updateUserGeneral", userUpdateDTO);
	}

	public List<UserSearchDTO> selectAllInChargeNm() {
		return selectList("user.selectAllInChargeNm");
	}

//	public List<String> selectHigherInChargeNm(String grpLv) {
//		return selectList("user.selectHigherInChargeNm", grpLv);
//	}

	public int updateUserInChargeIdByNm(UserUpdateDTO userUpdateDTO) {
		return update("user.updateUserInChargeIdByNm", userUpdateDTO);
	}

	public int insertUserBody(UserUpdateDTO userUpdateDTO) {
		return insert("user.insertUserBody", userUpdateDTO);
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

	public void insertCheckUp(CheckupVO checkupVO){
		List<Map> checkUpList = new ArrayList<>();
		String reportId = "";

		Map<String, Object> tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "11000000"); //1
		tmpmap.put("msmt", checkupVO.getHght());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "12000000"); //2
		tmpmap.put("msmt", checkupVO.getWght());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "13000000"); //3
		tmpmap.put("msmt", checkupVO.getWst());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "17100000"); //4
		tmpmap.put("msmt", checkupVO.getSbp());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "17200000");  //5
		tmpmap.put("msmt", checkupVO.getDbp());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "52000000");  //6
		tmpmap.put("msmt", checkupVO.getFbs());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "53000000");  //7
		tmpmap.put("msmt", checkupVO.getHba1c());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "41000000");  //8
		tmpmap.put("msmt", checkupVO.getTc());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "42000000");  //9
		tmpmap.put("msmt", checkupVO.getHdl());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "43000000");  //10
		tmpmap.put("msmt", checkupVO.getLdl());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "44000000");  //11
		tmpmap.put("msmt", checkupVO.getTrgly());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "22000000");  //12
		tmpmap.put("msmt", checkupVO.getSc());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "23000000");  //13
		tmpmap.put("msmt", checkupVO.getGfr());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "24000000");  //14
		tmpmap.put("msmt", checkupVO.getUrAcd());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "25000000");  //15
		tmpmap.put("msmt", checkupVO.getBun());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "32000000");  //16
		tmpmap.put("msmt", checkupVO.getAlt());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "31000000");  //17
		tmpmap.put("msmt", checkupVO.getAst());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "33000000");  //18
		tmpmap.put("msmt", checkupVO.getGtp());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "34000000");  //19
		tmpmap.put("msmt", checkupVO.getTprtn());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "35000000");  //20
		tmpmap.put("msmt", checkupVO.getBlrbn());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "36000000");  //21
		tmpmap.put("msmt", checkupVO.getAlp());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "91000000");  //checkup result
		tmpmap.put("msmt", checkupVO.getChckResult());
		checkUpList.add(tmpmap);

		tmpmap = new HashMap<>();
		tmpmap.put("metaDataCode", "92000000");  //Comment
		tmpmap.put("msmt", checkupVO.getComment());
		checkUpList.add(tmpmap);

		if (checkupVO.getWght() != null && checkupVO.getHght() != null && isNumberic(checkupVO.getWght()) && isNumberic(checkupVO.getHght())) {
			tmpmap = new HashMap<>();
			tmpmap.put("metaDataCode", "14000000"); //BMI 지수
			tmpmap.put("msmt", Double.toString(Integer.parseInt(checkupVO.getWght()) / pow((Integer.parseInt(checkupVO.getHght()) / 100), 2)));
			checkUpList.add(tmpmap);
		}

		reportId = (String)selectOne("user.selectMaxSeqReportItem");
		for(int i=0; i < checkUpList.size(); i++) {
			checkUpList.get(i).put("reportId", reportId);
			checkUpList.get(i).put("cmmt", "");
			checkUpList.get(i).put("usrId", checkupVO.getUserId());
		}

		checkupVO.setReportId(reportId);
		// 입력창 필드 해결 이후 추가 예정
//		update("user.updateWlkMy", checkupVO);
		insert("user.insertChckReport", checkupVO);
		insert("user.insertCheckUp", checkUpList);
		insert("user.insertMyBody", checkupVO);
	}

	public List<Map> selectValidMinMax(){
		return selectList("user.selectValidMinMax");
	}

	public boolean isNumberic(String str) {
		try {
			Double.parseDouble(str);
		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}
}