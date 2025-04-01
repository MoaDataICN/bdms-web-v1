package com.moadata.bdms.tracking.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.HealthAlertVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("trackingDao")
public class TrackingDao extends BaseAbstractDao {

    public String selectMaxReqId(){
        return (String)selectOne("tracking.selectMaxReqId");
    }

    public String selectMaxTrkId() {
        return (String)selectOne("tracking.selectMaxTrkId");
    }

    public void insertUserRequest(UserRequestVO userRequestVO) {
        insert("tracking.insertUserRequest", userRequestVO);
    }

    public void insertHealthAlert(HealthAlertVO healthAlertVO) {
        insert("tracking.insertHealthAlert", healthAlertVO);
    }

    public List<UserRequestVO> selectUserRequest(UserRequestVO userRequestVO) {
        List<UserRequestVO> list = selectList("tracking.selectUserRequest", userRequestVO);

        if(list.size() > 0) {
            list.get(0).setCnt((Integer)selectOne("tracking.selectUserRequestCnt", userRequestVO));
        }

        return list;
    }

    public List<HealthAlertVO> selectHealthAlert(HealthAlertVO healthAlertVO) {
        List<HealthAlertVO> list = selectList("tracking.selectHealthAlert", healthAlertVO);
        if(list.size() > 0) {
            list.get(0).setCnt((Integer)selectOne("tracking.selectHealthAlertCnt", healthAlertVO));
        }

        return list;
    }

    public List<Map<String, Object>> selectTodayUserRequestCnt(Map<String, Object> param) {
        return selectList("tracking.selectTodayUserRequestCnt", param);
    }

    public List<Map<String, Object>> selectTodayHealthAlertCnt(Map<String, Object> param) {
        return selectList("tracking.selectTodayHealthAlertCnt", param);
    }
}
