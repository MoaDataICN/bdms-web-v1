package com.moadata.bdms.model.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseSearchObject;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Dash
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("dashVO")
public class DashVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = -1629242589035477830L;
	
	private String dashId;
	private String dashNm;
	private String uid;
	private String usergroupId;
	private String dashType;
	private String defaultYn;
	private String useYn;
	private String mainYn;
	private String mainDashId;
	private String registId;
	private String registDt;
	private String modifyId;
	private String modifyDt;
	private List<DashLayoutVO> dashLayoutList;
	private String dashIds;
	
	@Getter
	public enum DashType {
		NETWORK("network", "DA01"),
		SERVER("server", "DA02"),
		APPLICATION("application", "DA03"),
		// AI("ai", "DA04"),
		RECEIVE("receive", "DA04"),
		CUSTOM("custom", "DA05"),
		LOG("log", "DA06"),
		STACK("stack", "DA07"),
		TOPOLOGY("topology", "DA08"),
		DETAILNETWORK("detailNetwork", "DA09"),
		DETAILSERVER("detailServer", "DA10"),
		DETAILAI("detailAI", "DA11"),
		MONITORING("monitoring", "DA12");
		
		private String name;
		private String code;
		
		DashType(String name, String code) {
			this.name = name;
			this.code = code;
		}
		
		public static String getCodeByName(String name) {
			for(DashType dash : DashType.values()) {
				if(dash.getName().equalsIgnoreCase(name)) {
					return dash.getCode();
				}
			}
			return null;
		}
	}
}