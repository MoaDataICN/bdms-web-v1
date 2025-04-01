package com.moadata.bdms.support.idgen.repository;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;

/**
 * ID GEN DAO
 */
@Repository("idgenDao")
public class IdgenDao extends BaseAbstractDao {
	public String selectNextId(Map<String, Object> map) {
		return (String) selectOne("idgen.selectNextId", map);
	}
	
	public void insertDefaultData(Map<String, Object> map) {
		insert("idgen.insertDefaultData", map);
	}
	
	public void updateNextId(Map<String, Object> map) {
		update("idgen.updateNextId", map);
	}
}