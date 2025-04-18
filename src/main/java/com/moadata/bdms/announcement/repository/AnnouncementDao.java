package com.moadata.bdms.announcement.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.AnnouncementVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("announcementDao")
public class AnnouncementDao extends BaseAbstractDao {

    public String selectMaxAnnId() {
        return (String)selectOne("announcement.selectMaxAnnId");
    }

    public void insertAnnouncement(AnnouncementVO announcementVO) {
        insert("announcement.insertAnnouncement", announcementVO);
    }

    public void insertAnnReadStatus(List<AnnouncementVO> list) {
        insert("announcement.insertAnnReadStatus", list);
    }

    public List<AnnouncementVO> selectAnnouncementList(AnnouncementVO announcementVO) {
        List<AnnouncementVO> list = selectList("announcement.selectAnnouncementList", announcementVO);

        if(list != null && list.size() > 0) {
            list.get(0).setCnt((Integer)selectOne("announcement.selectAnnouncementListCnt", announcementVO));
        }

        return list;
    }
}
