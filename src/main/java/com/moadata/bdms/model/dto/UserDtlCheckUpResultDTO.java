package com.moadata.bdms.model.dto;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("UserDtlCheckUpResultDTO")
public class UserDtlCheckUpResultDTO extends BaseSearchObject {
    private String chckDate;
    private String chckKind;
    private String chckJudge;
    private String chckHspt;
    private String chckDoctor;
    private String reportId;
    private String userId;
    private String UptDt;
    private String badVal;
    private String searchBgnDe;
    private String searchEndDe;
    private String reportItemGroup;
    private String checkupKey;
}