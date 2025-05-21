package com.moadata.bdms.model.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("ReportItemVO")
public class ReportItemVO extends BaseObject {
	private String metaDataCode;  // 검사 항목 코드
    private String metaDataGroupCode;  // 검사 항목 그룹 코드
    private String metaDataKoName;  // 검사 항목 제목명
    private String metaDataEngName;  // 검사 항목 영문명
    private String metaDataUnit;  // 검사 항목 단위
    private String metaDataDescription;  // 검사 항목 한국어 설명
    private String metaDataEngDescription;  // 검사 항목 영어 설명
    private String value;  // 검진 결과 값
    private String text;  // 종합 소견
    private String maleMin; // 남성 - 최소 수치
    private String maleMax; // 남성 - 최대 수치
    private String femaleMin; // 여성 - 최소 수치
    private String femaleMax; // 여성 - 최대 수치
    private String validMin;
    private String validMax;
    // 미만(00), 초과(01), 이하(10), 이상(11), 사이(22),
    // 음성/양성(33), 정상/이상(44), 종합소견 텍스트 경계 코드(99)
    private String judgeCode;
}