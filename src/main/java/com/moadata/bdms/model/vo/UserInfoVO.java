package com.moadata.bdms.model.vo;


import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseObject;
import org.springframework.web.multipart.MultipartFile;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Options
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("userInfoVO")
public class UserInfoVO extends BaseObject {
	private String userId;
	private String userNm;
	
	private String recvCnclId;
	private String trgtId;
	private String trgtNm;
	private String recvCnclYn;
	
	private String attchMngId;
	private String attchId;
	private String binaryImage;
	
	private String email;
	private String brthDt;
	private String birthYear;
	private String age;
	
	private String mobile;
	private String mkUseYn;
	
	private String gunhyupYn;			// 건협 관리자
	private String adminYn;				// 일반 관리자
	
	private String sx;
	private String wdYn;
	
	private String checkupKey;			// 건강분석 암호화 Key
	
	private String theme;				// 화면 모드 (25.03.19 추가)
}
