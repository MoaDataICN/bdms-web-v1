package com.moadata.bdms.model.dto;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("UserDtlServiceRequestsDTO")
public class UserDtlServiceRequestsDTO extends BaseSearchObject {
    private String reqId;  // my.REQ_ID
    private String userId;  // my.USER_ID
    private String reqDt;  // req.DCT_DT
    private String reqTp;  // req.ALT_TP
    private String grpTp;  // my.GRP_TP
    private String inChargeNm;  // admin.USER_NM
    private String inChargeId;  // admin.USER_ID
    private String inChargeIds;
    private String reqStt;  // req.ALT_STT
}
