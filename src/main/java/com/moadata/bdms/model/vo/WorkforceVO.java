package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

/**
 * Request
 */
@Getter
@Setter
@Alias("workforceVO")
public class WorkforceVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7548909224535899059L;

	private String userId;

	private String wrkfrcId;
	private String wrkfrcNm;
	private String wrkfrcNmbr;
	private String wrkfrcMobile;
	private String wrkfrcSx;
	private String wrkfrcBrthDt;
	private String svcTp;
	private String grpId;
	private String grpNm;
	private String memo;

	private String registDt;
	private String registId;
	private String uptDt;
	private String uptId;
}
