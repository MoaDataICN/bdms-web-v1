package com.moadata.bdms.common.grpc.service;

import java.util.List;
import java.util.Map;

import api.Fromage;
import com.moadata.bdms.model.vo.HealthInfoVO;
import com.moadata.bdms.model.vo.UserInfoVO;
import com.moadata.bdms.model.vo.ReportVO;

public interface GrpcService {
    // 사용자 등록
    public void registerPatient(UserInfoVO user);
    // 검진 데이터 등록
	public void registerCheckupData(ReportVO latestReport, List<HealthInfoVO> healthInfoList, UserInfoVO userInfo);
	public boolean fetchAndProcessAnalysisAge(UserInfoVO userInfo, boolean isStartFlag);
	public boolean fetchAndProcessAnalysisAgeByUserId30(String userId, boolean isStartFlag);
	public Map<String, Object> grpcAnalysisAge(UserInfoVO userInfo, ReportVO latestReport, boolean isStartFlag);
}
