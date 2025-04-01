package com.moadata.bdms.model.vo;

import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseObject;

import lombok.Getter;
import lombok.Setter;

/**
 * Code
 */
@Getter
@Setter
@Alias("codeVO")
public class CodeVO extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = -4979675148858002532L;
	
	private String code;		// 코드
	private String pCode;		// 상위코드
	private String codeName;	// 코드명
	private String codeDesc;	// 코드설명
	private int orderNo;		// 코드정렬순서
}
