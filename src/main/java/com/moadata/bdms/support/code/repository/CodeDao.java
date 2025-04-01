package com.moadata.bdms.support.code.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.CodeVO;
import com.moadata.bdms.model.vo.DashVO;

/**
 * Code Dao
 */
@Repository("codeDao")
@SuppressWarnings("unchecked")
public class CodeDao extends BaseAbstractDao {
	public List<CodeVO> selectCodeList(String pCode) {
		return selectList("code.selectCodeList", pCode);
	}
	
	public List<CodeVO> selectDashboardCodeList(DashVO dash) {
		return selectList("code.selectDashboardCodeList", dash);
	}
}