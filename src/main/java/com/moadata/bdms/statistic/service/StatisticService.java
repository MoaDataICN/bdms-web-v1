package com.moadata.bdms.statistic.service;

import com.moadata.bdms.model.vo.StatisticVO;

import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.Map;

/**
 * Statistic Service Interface
 */
public interface StatisticService {

	public String selectTotalUserAmount(Map<String, Object> param);
	public List<StatisticVO> selectUserAmountSummary(Map<String, Object> param);
	public List<StatisticVO> selectServiceRequestSummary(Map<String, Object> param);
	public List<StatisticVO> selectHealthAlertSummary(Map<String, Object> param);

	public ByteArrayOutputStream generateExcel(Map<String, Object> param);
}
