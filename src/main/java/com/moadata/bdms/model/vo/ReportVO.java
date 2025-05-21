package com.moadata.bdms.model.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
@Alias("reportVO")
public class ReportVO extends BaseObject {
    private String reportId;
    private String userId;
    private String chckDate;
    private String reportItemGroup;
    private String chckKind;  // 검진 종류
    private String chckHspt;  // 검진 기관
    private String chckJudge;  // 결과 판정
    private String registDt;
    private String registId;
    private String uptDt;
    private String uptId;
    private List<ReportItemVO> items;
    
	@Override
	public String toString() {
		return "ReportVO [reportId=" + reportId + ", userId=" + userId + ", chckDate=" + chckDate + ", reportItemGroup="
				+ reportItemGroup + ", chckKind=" + chckKind + ", chckHspt=" + chckHspt + ", chckJudge=" + chckJudge
				+ ", registDt=" + registDt + ", registId=" + registId + ", uptDt=" + uptDt + ", uptId=" + uptId
				+ ", items=" + items + "]";
	}
}