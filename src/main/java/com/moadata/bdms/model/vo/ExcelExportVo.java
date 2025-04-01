package com.moadata.bdms.model.vo;

import java.util.List;
import java.util.Locale;

import org.apache.poi.xssf.usermodel.XSSFSheet;

public class ExcelExportVo {
	private Locale locale;
	private XSSFSheet sheet;
	private List<?> list; //데이터 리스트
	private String[] dataKeys; //데이터 키 배열
	private String[] dataTypes; //데이터 타입 배열 (String, Number)
	private String[] sumTargetKeys; //합산 할 키 배열
	private String sumKey; //합산 기준 키
	
	public Locale getLocale() {
		return locale;
	}
	public void setLocale(Locale locale) {
		this.locale = locale;
	}
	public XSSFSheet getSheet() {
		return sheet;
	}
	public void setSheet(XSSFSheet sheet) {
		this.sheet = sheet;
	}
	public List<?> getList() {
		return list;
	}
	public void setList(List<?> list) {
		this.list = list;
	}
	public String[] getDataKeys() {
		return dataKeys;
	}
	public void setDataKeys(String[] dataKeys) {
		this.dataKeys = dataKeys;
	}
	public String[] getDataTypes() {
		return dataTypes;
	}
	public void setDataTypes(String[] dataTypes) {
		this.dataTypes = dataTypes;
	}
	public String[] getSumTargetKeys() {
		return sumTargetKeys;
	}
	public void setSumTargetKeys(String[] sumTargetKeys) {
		this.sumTargetKeys = sumTargetKeys;
	}
	public String getSumKey() {
		return sumKey;
	}
	public void setSumKey(String sumKey) {
		this.sumKey = sumKey;
	}
}
