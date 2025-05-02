package com.moadata.bdms.nutri.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.NutriVO;
import org.springframework.stereotype.Repository;

@Repository("nutriDao")
public class NutriDao extends BaseAbstractDao {
	public void insertNutriAnly(NutriVO nutri) {


		insert("nutri.insertNutriAnly", nutri);
	}
}
