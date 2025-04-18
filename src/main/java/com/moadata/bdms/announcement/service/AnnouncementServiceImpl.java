package com.moadata.bdms.announcement.service;

import com.moadata.bdms.admin.service.AdminService;
import com.moadata.bdms.alarm.service.AlarmService;
import com.moadata.bdms.announcement.repository.AnnouncementDao;
import com.moadata.bdms.dashboard.repository.DashboardDao;
import com.moadata.bdms.model.vo.AlarmVO;
import com.moadata.bdms.model.vo.AnnouncementVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("announcementService")
public class AnnouncementServiceImpl implements AnnouncementService {

    @Resource(name="announcementDao")
    private AnnouncementDao announcementDao;

    @Resource(name="adminService")
    private AdminService adminService;

    @Resource(name="alarmService")
    private AlarmService alarmService;

    @Override
    public void insertAnnouncement(AnnouncementVO announcement) {
        // Ann 테이블에 삽입
        String annId = announcementDao.selectMaxAnnId();
        announcement.setAnnId(annId);
        announcementDao.insertAnnouncement(announcement);

        List<AnnouncementVO> announcementList = new ArrayList<>();
        switch(announcement.getTgTp()) {
            // Ann St 테이블에 리스트 형태로 삽입 (웹인 경우)
            case "0" :
                // 1. 관리자 대상 -> 전체 관리자 조회, Ann St 테이블에 삽입
                List<UserVO> adminList = adminService.selectAdminList(null);

                for(UserVO admin : adminList) {
                    AnnouncementVO ann = new AnnouncementVO();
                    ann.setUserId(admin.getUserId());
                    ann.setAnnId(annId);
                    announcementList.add(ann);
                }

                announcementDao.insertAnnReadStatus(announcementList);
                break;
            case "1" :
                // 2. 사용자 대상 -> 앱쪽 알람 스케쥴러 테이블(t_wlk_cmm_alrm_sche)에 삽입
                List<String> tokenList = alarmService.selectAllUsersToken(null);

                AlarmVO alarm = new AlarmVO();
                alarm.setAlrmPushId(alarmService.selectMaxAlrmScheId());
                alarm.setTokenList(tokenList);
                alarm.setTitle(announcement.getTitle());
                alarm.setCont(announcement.getCont());
                alarm.setAlrmUrl("https://bdms.moadata.ai:8088/mediwalk/login.mdo");

                alarmService.insertAlarmSche(alarm);
                break;
            case "2" :
                // 3. 관리자 + 사용자 대상 -> 1 + 2 로 적용
                /* (1) 관리자 */
                List<UserVO> adminsList = adminService.selectAdminList(null);

                for(UserVO admin : adminsList) {
                    AnnouncementVO ann = new AnnouncementVO();
                    ann.setUserId(admin.getUserId());
                    ann.setAnnId(annId);
                    announcementList.add(ann);
                }
                announcementDao.insertAnnReadStatus(announcementList);

                /* (2) 사용자 */
                List<String> tokensList = alarmService.selectAllUsersToken(null);

                AlarmVO alarms = new AlarmVO();
                alarms.setAlrmPushId(alarmService.selectMaxAlrmScheId());
                alarms.setTokenList(tokensList);
                alarms.setTitle(announcement.getTitle());
                alarms.setCont(announcement.getCont());
                alarms.setAlrmUrl("https://bdms.moadata.ai:8088/mediwalk/login.mdo");

                alarmService.insertAlarmSche(alarms);
                break;
            case "3" :
                // 4. 특정 사용자 대상 -> 특정 사용자의 ID List를 바탕으로,
                // 관리자리스트는 Ann St 테이블에 삽입, 사용자리스트는 앱쪽 알람 스케쥴러 테이블(t_wlk_cmm_alrm_sche)에 삽입

                /* (1) 특정 관리자 대상 */
                if(announcement.getAdminList() != null && announcement.getAdminList().size() > 0) {
                    for(String ids : announcement.getAdminList()) {
                        AnnouncementVO ann = new AnnouncementVO();
                        ann.setUserId(ids);
                        ann.setAnnId(annId);

                        announcementList.add(ann);
                    }
                    announcementDao.insertAnnReadStatus(announcementList);
                }

                /* (1) 특정 사용자 대상 */
                if(announcement.getUserList() != null && announcement.getUserList().size() > 0) {
                    List<String> userTokens = new ArrayList<>();
                    for(String ids : announcement.getUserList()) {
                        AlarmVO alarmVO = alarmService.selectAlrmSetting(ids);
                        userTokens.add(alarmVO.getTokenId());
                    }

                    AlarmVO usersAlarm = new AlarmVO();
                    usersAlarm.setAlrmPushId(alarmService.selectMaxAlrmScheId());
                    usersAlarm.setTokenList(userTokens);
                    usersAlarm.setTitle(announcement.getTitle());
                    usersAlarm.setCont(announcement.getCont());
                    usersAlarm.setAlrmUrl("https://bdms.moadata.ai:8088/mediwalk/login.mdo");

                    alarmService.insertAlarmSche(usersAlarm);
                }
                break;
        }
    }

    @Override
    public List<AnnouncementVO> selectAnnouncementList(AnnouncementVO announcementVO) {

        return announcementDao.selectAnnouncementList(announcementVO);
    }
}
