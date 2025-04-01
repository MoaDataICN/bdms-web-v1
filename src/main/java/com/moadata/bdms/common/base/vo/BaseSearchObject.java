package com.moadata.bdms.common.base.vo;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 검색 모델 객체
 */
@JsonIgnoreProperties({ "_search", "searchBgnDe", "searchEndDe", "searchField", "searchOper", "searchString", "sidx", "sortColumn", "sord", "searchType", 
	"pageIndex", "page", "pageUnit", "pageSize", "firstIndex", "lastIndex", "perPage", "rowNo", "cnt" })
public class BaseSearchObject extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 1525196914945863752L;

	/*jqgrid test parameter*/
	private boolean _search = false;
	
	/** 검색시작일 */
	private String searchBgnDe = "";
	
	/** 검색종료일 */
	private String searchEndDe = "";
	
	/** 검색필드 */
	private String searchField = "";
	
	/** 검색타입 */
	private String searchOper = "";
	
	/** 검색단어 */
	private String searchString = "";
	
	/** 정렬컬럼  camel*/
	private String sidx = "";;
	
	/** 정렬컬럼  snake*/
	private String sortColumn = "";
	
	/** 정렬순서(DESC,ASC) */
	private String sord = "";
	
	/** 검색분류(카테고리,유형, 조건(=,like)) */
	private String searchType = "";
	
	/** 다중 검색 */
	private String filters;
	
	/** 다중 검색 */
	private Map<String,Object> filtersMap;
	
	/** 현재페이지 */
	private int pageIndex = 0;
	
	private String page = "0";
	
	/** 페이지갯수 */
	private int pageUnit = 10;
	
	/** 페이지사이즈 */
	private int rows = 10;
	
	/** 첫페이지 인덱스 */
	private int firstIndex = 1;
	
	/** 마지막페이지 인덱스 */
	private int lastIndex = 1;
	
	/** 페이지당 레코드 개수 */
	private int perPage = 10;
	
	/** 레코드 번호 */
	private int rowNo = 0;
	
	/** 레코드 총 갯수 */
	private int cnt = 0;
	
	
	public boolean is_search() {
		return _search;
	}
	public void set_search(boolean _search) {
		this._search = _search;
	}
	public String getSearchBgnDe() {
		return searchBgnDe;
	}
	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}
	public String getSearchEndDe() {
		return searchEndDe;
	}
	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}
	public String getSearchField() {
		return searchField;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public String getSearchOper() {
		return searchOper;
	}
	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSortColumn() {
		return sortColumn;
	}
	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}
	public String getSord() {
		return sord;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getFilters() {
		return filters;
	}
	public void setFilters(String filters) {
		this.filters = filters;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getRowNo() {
		return rowNo;
	}
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public Map<String,Object> getFiltersMap() {
		return filtersMap;
	}
	public void setFiltersMap(Map<String,Object> filtersMap) {
		this.filtersMap = filtersMap;
	}
}