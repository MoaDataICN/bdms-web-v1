package com.moadata.bdms.dashboard.service;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.dashboard.repository.DashboardDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("dashboardService")
public class DashboardServiceImpl implements DashboardService {

    @Resource(name="dashboardDao")
    private DashboardDao dashboardDao;

    public List<Map<String, Object>> selectTodayStatus(Map<String, Object> param) {
        try {
            List<Map<String, Object>> list = dashboardDao.selectTodayStatus(param);

            if (list.size() > 0) {
                for (Map<String, Object> item : list) {
                    item.put("USER_NM", EncryptUtil.decryptText((String) item.get("USER_NM")));
                }
            }

            return list;
        } catch(Exception e) {
            e.printStackTrace();

            return null;
        }
    }
}
