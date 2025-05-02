package com.moadata.bdms.my.service;

import com.moadata.bdms.model.vo.MyVO;

import java.util.List;
import java.util.Map;

public interface MyService {
    public MyVO selectUserInfo(String userId);

	public List<Map<String, Object>> selectUserCnt(Map<String, Object> param);

	public Map<String, Object> selectUserCntGrp();

	public void updateCheckupKey(String userId);
}
