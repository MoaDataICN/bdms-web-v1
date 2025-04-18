package com.moadata.bdms.my.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.MyVO;
import org.springframework.stereotype.Repository;

@Repository("myDao")
public class MyDao extends BaseAbstractDao {
    public MyVO selectUserInfo(String userId) {
        return (MyVO)selectOne("my.selectUserInfo", userId);
    }
}
