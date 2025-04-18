package com.moadata.bdms.alarm.service;

import com.moadata.bdms.alarm.repository.AlarmDao;
import com.moadata.bdms.model.vo.AlarmVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Service("alarmService")
public class AlarmServiceImpl implements AlarmService {

    @Resource(name="alarmDao")
    private AlarmDao alarmDao;

    @Override
    public String selectMaxAlrmId() {
        return alarmDao.selectMaxAlrmId();
    }

    @Override
    public String selectMaxAlrmScheId() {
        return alarmDao.selectMaxAlrmScheId();
    }

    @Override
    public AlarmVO selectAlrmSetting(String userId) {
        return alarmDao.selectAlrmSetting(userId);
    }

    @Override
    public List<String> selectAllUsersToken(String param) {
        return alarmDao.selectAllUsersToken(param);
    }

    @Override
    public void insertAlarmSche(AlarmVO alarm) {
        alarmDao.insertAlarmSche(alarm);
    }
}
