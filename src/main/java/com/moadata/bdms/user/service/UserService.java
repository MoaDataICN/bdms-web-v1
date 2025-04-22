package com.moadata.bdms.user.service;

import java.util.List;
import java.util.Map;

import com.moadata.bdms.model.dto.MyResetPwDTO;
import com.moadata.bdms.model.dto.UserDtlGeneralVO;
import com.moadata.bdms.model.dto.UserSearchDTO;
import com.moadata.bdms.model.dto.UserUpdateDTO;
import com.moadata.bdms.model.vo.CheckupVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.web.multipart.MultipartFile;

/**
 * User Service Interface
 */
public interface UserService {
	public List<UserSearchDTO> selectUserSearch(UserSearchDTO userSearchDTO);

	/**
	 * 사용자 목록
	 * 
	 * @param user
	 * @return
	 */
	public List<UserVO> selectUserList(UserVO user);

	public UserDtlGeneralVO selectUserDtlGeneral(String reqId);

	boolean updateUserResetPwByAdmin(MyResetPwDTO myResetPwDTO);

	boolean updateUserGeneral(UserUpdateDTO userUpdateDTO);

	public List<UserSearchDTO> selectAllInChargeNm();
//	public List<String> selectHigherInChargeNm(String grpLv);

	boolean updateUserInChargeIdByNm(UserUpdateDTO userUpdateDTO);

	boolean insertUserBody(UserUpdateDTO userUpdateDTO);




	/**
	 * 사용자 상세
	 * 
	 * @param userId
	 * @return
	 */
	public UserVO selectUserInfo(String userId);
	
	/**
	 * 사용자 상세
	 * 
	 * @param uid
	 * @return
	 */
	public UserVO selectUserInfoByUid(String uid);
	
	/**
	 * 사용자 확인
	 * 
	 * @param userId
	 * @return
	 */
	int selectUserIdCnt(String userId);
	
	/**
	 * 사용자 확인 - 사용자 그룹 아이디
	 * 
	 * @param userGroupId
	 * @return
	 */
	int selectUserCntByUserGroupId(String userGroupId);
	
	/**
	 * 사용자 등록
	 * 
	 * @param user
	 */
	public void insertUser(UserVO user) throws Exception;
	
	/**
	 * 사용자 수정
	 * 
	 * @param user
	 */
	public void updateUser(UserVO user);
	
	/**
	 * 사용자 그룹 수정
	 * 
	 * @param user
	 */
	public void updateUserGroupId(UserVO user);
	
	/**
	 * 사용자 삭제
	 * 
	 * @param uid
	 */
	public void deleteUser(String uid);
	
	/**
	 * 사용자 삭제
	 * 
	 * @param list
	 */
	public void deleteUserList(UserVO user);

    /**
     * 사용자 전체 목록 조회
     *
     * @return
     */
    List<UserVO> selectUserByUseAllList();
    
    //사용자 메뉴 수정 추가 22.08.22
    /**
	 * 사용자 메뉴 수정
	 * 
	 * @param user
	 */
	public void userMenuUpdate(UserVO user);
	
	/**
	 * 로그인한 사용자 개인 정보 조회
	 * 
	 * @param userId
	*/
	public UserVO selectUserInfoDetail(String userId);
	
	/**
	 * 로그인한 사용자 개인 정보 수정
	 * 
	 * @param user
	 */
	public void updateUserInfo(UserVO user);

	public Map<String, Object> getImportMapForBDMS(MultipartFile file, String loginId);

	public void insertCheckUp(CheckupVO checkupVO) throws Exception;
}
