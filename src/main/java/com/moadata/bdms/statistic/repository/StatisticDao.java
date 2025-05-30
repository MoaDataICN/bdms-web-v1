package com.moadata.bdms.statistic.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.StatisticVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("statisticDao")
public class StatisticDao  extends BaseAbstractDao {

	public String selectTotalUserAmount(Map<String, Object> param) {
		return (String)selectOne("statistic.selectTotalUserAmount", param);
	}

	public List<StatisticVO> selectUserAmountSummary(Map<String, Object> param) {
		return selectList("statistic.selectUserAmountSummary", param);
	}

	public List<StatisticVO> selectServiceRequestSummary(Map<String, Object> param) {
		return selectList("statistic.selectServiceRequestSummary", param);
	}

	public List<StatisticVO> selectHealthAlertSummary(Map<String, Object> param) {
		return selectList("statistic.selectHealthAlertSummary", param);
	}
}
