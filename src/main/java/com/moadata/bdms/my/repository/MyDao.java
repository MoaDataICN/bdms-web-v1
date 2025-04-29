package com.moadata.bdms.my.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.MyVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("myDao")
public class MyDao extends BaseAbstractDao {
    public MyVO selectUserInfo(String userId) {
        return (MyVO)selectOne("my.selectUserInfo", userId);
    }

	public List<Map<String, Object>> selectUserCnt(Map<String, Object> param) {
		return selectList("my.selectUserCnt", param);
	}

	public Map<String, Object> selectUserCntGrp() {
		return (Map<String, Object>)selectOne("my.selectUserCntGrp");
	}
}
