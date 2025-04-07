package com.moadata.bdms.model.vo;

import org.apache.ibatis.type.Alias;
import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.Getter;
import lombok.Setter;

/**
 * Login
 */
@Getter
@Setter
@Alias("loginVO")
public class LoginVO extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 1824190010566122432L;
	
	private String userId;
	private String userPw;
	private String loginYn;
	private String lockYn;
	private String useYn;
	private int pwFailCnt; //22.08.23 추가
	private String pwModifyDt; //22.08.23 추가
	private String loginDt; //22.08.23 추가
	private String today;
	private String currentPw; //비밀번호 변경 popup 화면의 현재 비밀번호 22.08.29
	
	private String connectIp1;
	private String connectIp2;
	private String connectIp3;
}