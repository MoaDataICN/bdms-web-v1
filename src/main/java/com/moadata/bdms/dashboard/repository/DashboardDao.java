package com.moadata.bdms.dashboard.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("dashboardDao")
public class DashboardDao extends BaseAbstractDao{
    public List<Map<String, Object>> selectTodayStatus(Map<String, Object> param) {
        return selectList("dashboard.selectTodayStatus", param);
    }
}
