package com.moadata.bdms.model.vo;

import java.util.List;
import java.util.Map;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import org.apache.ibatis.type.Alias;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * User
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("userVO")
public class UserVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 5908162720412609036L;
	
	private String uid;
	private String userId;
	private String userNm;
	private String userPw;
	private String userPrePw;
	private String emailAddr;
	private String phoneNo;
	private String loginDt;
	private String loginYn;
	private String deptNm;
	private String usergroupId;
	private String userGroupNm;
	private String lockYn;
	private String useYn;
	private String userType;
	private String userDesc;
	private String registId;
	private String registDt;
	private String modifyId;
	private String modifyDt;
	private String wrkTp;
	private String wrkNm;
	
	private String uIds;
	private String userIds;
	
	private String menuIds;
	private String delMenuIds;
	
	private String oldLockYn;
	private String loginId;
	private List<Map> delDataMap;
	
	private String connectIp1;
	private String connectIp2;
	private String connectIp3;
	
	private String jobType; //JOB TYPE (C : 생성, R : 조회, U : 변경, D : 삭제, X : 내보내기)
	
	private String exportFileNm; //엑셀 파일 이름
	private String exportHeader; //엑셀 헤더
	private String exportTotalHeader; //엑셀 헤더 (집계용)
	private String pwd;
	private String checkPwd;
	private String lstLoginDt;
	private String tpNm;

	/* Group, 권한 관련 */
	private String grpId;
	private String grpLv;
	private String grpNm;

	private String showType;
}