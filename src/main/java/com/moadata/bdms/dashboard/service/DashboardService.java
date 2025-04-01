package com.moadata.bdms.dashboard.service;

import java.util.List;
import java.util.Map;

public interface DashboardService {
    public List<Map<String, Object>> selectTodayStatus(Map<String, Object> param);
}
