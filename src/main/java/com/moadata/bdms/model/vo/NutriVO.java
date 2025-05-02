package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("nutriVO")
public class NutriVO extends BaseObject {
	private String userId;
	private String rcvDt;
	private String badVal;
	private String baaVal;
	private String caaVal;
	private String paaVal;
	private String reaVal;
	private String heaVal;
	private String weekVal;

	private String registId;
	private String registDt;
	private String uptId;
	private String uptDt;
}

