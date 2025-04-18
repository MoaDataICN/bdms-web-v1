package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.*;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("myVO")
public class MyVO extends BaseObject {
    private String userId;
    private String userNm;

    private String recvCnclId;
    private String trgtId;
    private String trgtNm;
    private String recvCnclYn;

    private String attchMngId;
    private String attchId;
    private String binaryImage;

    private String email;
    private String brthDt;
    private String birthYear;
    private String age;

    private String mobile;
    private String mkUseYn;

    private String gunhyupYn;			// 건협 관리자
    private String adminYn;				// 일반 관리자

    private String sx;
    private String wdYn;

    private String checkupKey;			// 건강분석 암호화 Key

    private String theme;				// 화면 모드 (25.03.19 추가)
}
