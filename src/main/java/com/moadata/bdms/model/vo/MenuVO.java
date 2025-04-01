package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

/**
 * Menu
 */
@Getter
@Setter
@Alias("menuVO")
public class MenuVO extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7548909224535899059L;
	
	private String menuId;		// 메뉴 아이디
	private String parMenuId;		// 상위 메뉴 아이디
	private String menuNm;		// 메뉴 이름
	private String menuUrl;		// 메뉴 URL
	private String menuIconNm;	// 메뉴 아이콘 이름
	private int orderNo;		// 메뉴 정렬순서
	private String menuDesc;	// 메뉴 설명
	private String useYn;		// 메뉴 사용여부
	private String permission;	// 권한 (10: DISPLAY, 11: DISPLAY + URL)
	private String accessYn;	// 접근권한  
	private String registDt;
	private String mngMenuId;	//관리용 메뉴ID
	
	//level 추가
	private long menuLevel;
}
