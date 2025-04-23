package com.moadata.bdms.model.dto;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("UserDtlHealthAlertsDTO")
public class UserDtlHealthAlertsDTO extends BaseSearchObject {
    private String trkId;  // alt.TRK_ID
    private String userId;  // alt.USER_ID
    private String dctDt;  // alt.DCT_DT
    private String altTp;  // alt.ALT_TP
    private String altRmrk;  // alt.ALT_RMRK
    private String grpTp;  // my.GRP_TP
    private String inChargeNm;  // admin.USER_NM
    private String inChargeId;  // admin.USER_ID
    private String inChargeIds;
    private String altStt;  // alt.ALT_STT
}
