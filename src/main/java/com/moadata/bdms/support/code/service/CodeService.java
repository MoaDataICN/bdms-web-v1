package com.moadata.bdms.support.code.service;

import java.util.List;

import com.moadata.bdms.model.vo.CodeVO;
import com.moadata.bdms.model.vo.DashVO;

/**
 * Code Service Interface
 */
public interface CodeService {
	/**
	 * 상세 코드 항목 조회
	 * 
	 * @param pCode
	 * @return
	 */
	public List<CodeVO> selectCodeList(String pCode);
	
	/**
	 * 그룹 권한 있는 대시보드 코드 조회
	 * 
	 * @param usergroupId
	 * @return
	 */
	public List<CodeVO> selectDashboardCodeList(DashVO dash);
}