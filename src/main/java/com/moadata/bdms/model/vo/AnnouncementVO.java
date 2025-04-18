package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.util.List;

/**
 * Request
 */
@Getter
@Setter
@Alias("announcementVO")
public class AnnouncementVO extends BaseSearchObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7548909224535899059L;

	private String annId;
	private String sndDt;
	private String tgTp;
	private String grpNm;
	private String rcpt;
	private String title;
	private String cont;
	private String sndId;
	private String userId;
	private String readSt;

	private List<String> adminList;
	private List<String> userList;

	private String registDt;
	private String registId;
	private String uptDt;
	private String uptId;
}
