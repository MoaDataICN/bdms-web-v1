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
@Alias("userRequestVO")
public class UserRequestVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7548909224535899059L;

	private String reqId;
	private String userId;
	private String reqTp;
	private String reqStt;
	private String reqDt;
	private String reqDesc;

	/* MY */
	private String userNm;
	private String mobile;
	private String emailId;
	private String brthDt;
	private String sx;
	private String inChargeId;
	private String inChargeNm;
	private String grpId;
	private String grpNm;

	private String registDt;
	private String registId;
	private String uptDt;
	private String uptId;
}
