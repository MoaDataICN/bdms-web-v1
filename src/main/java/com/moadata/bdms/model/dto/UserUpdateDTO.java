package com.moadata.bdms.model.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("UserUpdateDTO")
public class UserUpdateDTO {
    private String mobile;  // 전화번호
    private String sx;  // 성별
    private String inChargeNm;  // 담당자명
    private String brthDt;  // 생년월일
    private String grpTp;  // 그룹 유형
    private String height;  // 키
    private String weight;  // 몸무게
    private String addr;  // 주소
    private String wdDt;  // 탈퇴일
    private String wdYn;  // 탈퇴 여부
    private String mmo;  // 메모
    private String uptDt;  // 최근 수정일
    private String uptId;  // 최근 수정 담당자 UID
    private String userId;  // UID
}