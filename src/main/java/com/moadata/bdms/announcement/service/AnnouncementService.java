package com.moadata.bdms.announcement.service;

import com.moadata.bdms.model.vo.AnnouncementVO;

import java.util.List;
import java.util.Map;

public interface AnnouncementService {
    public void insertAnnouncement(AnnouncementVO announcement);

    public List<AnnouncementVO> selectAnnouncementList(AnnouncementVO announcementVO);
    public List<AnnouncementVO> selectUserMessage(String userId);

	public AnnouncementVO selectAnnouncementByAnnId(String annId);
	public void updateAnnouncementSt(Map<String, Object> param);
	public int selectUnreadAnnCnt(String userId);
}
