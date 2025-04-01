package com.moadata.bdms.model.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.moadata.bdms.common.base.vo.BaseSearchObject;

import lombok.Getter;
import lombok.Setter;

/**
 * UserGroup
 */
@Getter
@Setter
@Alias("userGroupVO")
public class UserGroupVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 2102849263823645118L;
	
	private String usergroupId;
	private String usergroupNm;
	private String usergroupEmail;
	private String usergroupPhone;
	private String usergroupBtnYn;
	private String usergroupCfgYn;
	private String usergroupDesc;
	private String registId;
	private String registDt;
	private String modifyId;
	private String modifyDt;
	
	private List<String> ids;
	private String uIds;
	private List<String> agentIds;
	private String menuIds;
	private String delMenuIds;
	private String userList;
	private int userCount;
}