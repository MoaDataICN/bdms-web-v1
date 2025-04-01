package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

/**
 * Code
 */
@Getter
@Setter
@Alias("groupVO")
public class GroupVO extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = -4979675148858002532L;
	
	private String grpId;
	private String pgrpId;
	private String grpNm;
	private String registDt;
	private String registId;
	private String uptDt;
	private String uptId;

}
