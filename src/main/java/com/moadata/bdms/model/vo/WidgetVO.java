package com.moadata.bdms.model.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseSearchObject;

import lombok.Getter;
import lombok.Setter;

/**
 * Widget
 */
@Getter
@Setter
@Alias("widgetVO")
public class WidgetVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 327409068103965687L;
	
	private String widgetId;
	private List<String> ids;
	private String widgetNm;
	private String widgetTitle;
	private String widgetSubTitle;
	private String widgetDesc;
	private String widgetFileNm;
	private String widgetImg;
	private String widgetType;
	private String widgetChartType;
	private int widgetMinWidth;
	private int widgetMinHeight;
	private int widgetInterval;
	private String widgetGlobalOptionPerm;
	private String widgetOption;
	private String widgetTheme;
	private String widgetDataQuery;
	private String widgetDataSet;
	private String widgetDataSql;
	private String registId;
	private String registDt;
	private String modifyId;
	private String modifyDt;
	
}