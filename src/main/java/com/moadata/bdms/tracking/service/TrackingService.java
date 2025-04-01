package com.moadata.bdms.tracking.service;

import com.moadata.bdms.model.vo.HealthAlertVO;
import com.moadata.bdms.model.vo.UserRequestVO;

import java.util.List;
import java.util.Map;

/**
 * Tracking Service Interface
 */
public interface TrackingService {
    public List<UserRequestVO> selectUserRequest(UserRequestVO userRequestVO);
    public List<HealthAlertVO> selectHealthAlert(HealthAlertVO healthAlertVO);

    public List<Map<String, Object>> selectTodayUserRequestCnt(Map<String, Object> param);
    public List<Map<String, Object>> selectTodayHealthAlertCnt(Map<String, Object> param);
}
