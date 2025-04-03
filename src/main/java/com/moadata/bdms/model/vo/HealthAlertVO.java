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
@Alias("healthAlertVO")
public class HealthAlertVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7548909224535899059L;

	private String trkId;
	private String userId;
	private String userNm;
	private String attchId;
	private String altTp;
	private String mobile;
	private String brthDt;
	private String emailId;
	private String sx;

	private String grpId;
	private String grpNm;

	private String inChargeIds;
	private String inChargeId;
	private String inChargeNm;

	private String dctDt;
	private String altRmrk;

	private String registDt;
	private String registId;
	private String uptDt;
	private String uptId;
}
