package com.moadata.bdms.model.dto;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("UserDtlServiceRequestsDTO")
public class UserDtlServiceRequestsDTO extends BaseSearchObject {
    private String reqId;
    private String userId;
    private String reqDt;
    private String reqTp;
    private String grpTp;
    private String inChargeNm;
    private String inChargeId;
    private String inChargeIds;
    private String reqStt;
}
