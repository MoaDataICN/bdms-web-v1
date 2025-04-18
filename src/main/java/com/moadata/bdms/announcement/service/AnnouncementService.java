package com.moadata.bdms.announcement.service;

import com.moadata.bdms.model.vo.AnnouncementVO;

import java.util.List;

public interface AnnouncementService {
    public void insertAnnouncement(AnnouncementVO announcement);

    public List<AnnouncementVO> selectAnnouncementList(AnnouncementVO announcementVO);
}
