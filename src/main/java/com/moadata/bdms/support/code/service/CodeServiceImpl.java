package com.moadata.bdms.support.code.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.moadata.bdms.model.vo.CodeVO;
import com.moadata.bdms.model.vo.DashVO;
import com.moadata.bdms.support.code.repository.CodeDao;

/**
 * Code Service 구현
 */
@Service(value = "codeService")
public class CodeServiceImpl implements CodeService {
	@Resource(name="codeDao")
	private CodeDao codeDao;
	
	
	@Override
	public List<CodeVO> selectCodeList(String pCode) {
		return codeDao.selectCodeList(pCode);
	}


	@Override
	public List<CodeVO> selectDashboardCodeList(DashVO dash) {
		return codeDao.selectDashboardCodeList(dash);
	}
}
