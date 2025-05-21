package com.moadata.bdms.model.vo;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseObject;
import com.moadata.bdms.model.vo.ReportVO;
import com.moadata.bdms.model.vo.ReportItemVO;
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
@Alias("healthInfoVO")
public class HealthInfoVO extends BaseObject {
	private String userId;
	private String reportId;
	private String chckDate;
	private String brthDt;
	private String age;
	private String sx;
	private String metaDataCode;
	private String value;
	private String text;
	
	private String reportItemGroup;
	private String chckKind;
	private String chckHspt;
	private String chckJudge;
	
	/** 생체나이 */
	private String badVal;
	private String baaVal;
	private String caaVal;
	private String paaVal;
	private String reaVal;
	private String heaVal;
	
	private String rcvDt;
	private String weekVal;
	private String uptYn;
	
	private String registDt;
	private String registId;
	private String uptDt;
	private String uptId;
	private Map<String, String> reportItemMap;	// key = metaDataCode, value = 값
}
