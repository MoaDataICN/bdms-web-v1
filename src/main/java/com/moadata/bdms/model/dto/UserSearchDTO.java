package com.moadata.bdms.model.dto;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("UserSearchDTO")
public class UserSearchDTO extends BaseSearchObject {
    private String userId;         // UID
    private String registDt;       // 등록일
    private String userNm;         // 이름
    private String mobile;         // 전화번호
    private String sx;             // 성별
    private String emailId;        // 이메일
    private String brthDt;         // 생년월일
    private String grpTp;          // 그룹 유형
    private String inChargeNm;     // 담당자명
    private String inChargeId;     // 담당자 ID
    private String inChargeIds;
    private String reqId;
    private String reqTp;
    private String altTp;
}
