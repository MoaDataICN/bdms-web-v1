package com.moadata.bdms.model.vo;

import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseObject;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * DashLayout
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("dashLayoutVO")
public class DashLayoutVO extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 6851013431113070153L;
	
	private String layoutId;
	private String dashId;
	private String mainDashId;
	private String widgetId;
	private int widgetX;
	private int widgetY;
	private int widgetWidth;
	private int widgetHeight;
	private String widgetParam;
	private String widgetDesc;
	private String registId;
	private String registDt;
	private String modifyId;
	private String modifyDt;
	private WidgetVO widget;
}