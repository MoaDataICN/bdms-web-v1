package com.moadata.bdms.model.dto;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("MyResetPwDTO")
public class MyResetPwDTO {
    private String userId;
    private String pw;
    private String uptId;
}
