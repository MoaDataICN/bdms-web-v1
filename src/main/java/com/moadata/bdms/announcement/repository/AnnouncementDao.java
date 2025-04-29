package com.moadata.bdms.announcement.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.AnnouncementVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    public List<AnnouncementVO> selectUserMessage(String userId) {
        return selectList("announcement.selectUserMessage", userId);
    }

	public AnnouncementVO selectAnnouncementByAnnId(String annId) {
		return (AnnouncementVO)selectOne("announcement.selectAnnouncementByAnnId", annId);
	}

	public void updateAnnouncementSt(Map<String, Object> param) {
		update("announcement.updateAnnouncementSt", param);
	}

	public int selectUnreadAnnCnt(String userId) {
		return (int)selectOne("announcement.selectUnreadAnnCnt", userId);
	}
}
