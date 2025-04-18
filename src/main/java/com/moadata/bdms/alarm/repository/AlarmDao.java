package com.moadata.bdms.alarm.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.AlarmVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("alarmDao")
public class AlarmDao extends BaseAbstractDao {

    public String selectMaxAlrmId() {
        return (String)selectOne("alarm.selectMaxAlrmId");
    }

    public String selectMaxAlrmScheId() {
        return (String)selectOne("alarm.selectMaxAlrmScheId");
    }

    public AlarmVO selectAlrmSetting(String userId) {
        return (AlarmVO)selectOne("alarm.selectAlrmSetting", userId);
    }

    public List<String> selectAllUsersToken(String param) {
        return (List<String>)selectList("alarm.selectAllUsersToken", param);
    }

    public void insertAlarmSche(AlarmVO alarm) {
        insert("alarm.insertAlarmSche", alarm);
    }

}
