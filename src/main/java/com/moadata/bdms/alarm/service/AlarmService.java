package com.moadata.bdms.alarm.service;

import com.moadata.bdms.model.vo.AlarmVO;

import java.util.List;

public interface AlarmService {
    public String selectMaxAlrmId();
    public String selectMaxAlrmScheId();
    public AlarmVO selectAlrmSetting(String userId);
    public List<String> selectAllUsersToken(String param);
    public void insertAlarmSche(AlarmVO alarm);
}
