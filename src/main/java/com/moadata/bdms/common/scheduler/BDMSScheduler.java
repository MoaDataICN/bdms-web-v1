package com.moadata.bdms.common.scheduler;

import com.moadata.bdms.common.grpc.service.GrpcService;
import com.moadata.bdms.model.vo.HealthInfoVO;
import com.moadata.bdms.model.vo.ReportVO;
import com.moadata.bdms.model.vo.UserInfoVO;
import com.moadata.bdms.user.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Slf4j
@Component
public class BDMSScheduler {

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "grpcService")
	private GrpcService grpcService;

	// GRPC 연동 및 반영시간을 고려, 한 건당 10초의 텀을 잡음
	@Scheduled(fixedDelay = 10000)
	public void reportSchedule() {
		try {
			/** 1. T_WLK_REPORT 테이블 조회, GRPC 연동상태가 false 인 항목을 가져옴(limit 1) */
			ReportVO report = userService.selectOneLatestReport();

			if (report != null) {
				String userId = report.getUserId();

				/** 2. 조회 된 report에 대한 USER_ID를 바탕으로 회원정보를 조회하여 GRPC '환자등록' 수행 */
				UserInfoVO userInfo = userService.selectUserInfoForGrpc(userId);
				if (userInfo == null) {
					throw new Exception("User information not found for userId: " + report.getUserId());
				} else {
					grpcService.registerPatient(userInfo);
				}

				String reportId = report.getReportId();
				List<HealthInfoVO> healthInfoList = userService.getHealthInfoByReportId(reportId);
				try {
					/** 3. 조회 된 검진데이터를 바탕으로 GRPC '결과분석' 서비스로 연동 */
					grpcService.registerCheckupData(report, healthInfoList, userInfo);
				}catch(Exception e) {
					e.printStackTrace();
				}

				// checkupkey 발급 / 저장
				String generateCheckupKeyUrl = "https://bdms.moadata.ai:8912/api/external/user-url";
				String userNm = userInfo.getUserNm();
				userId = report.getUserId().length() > 30 ? userInfo.getUserId().substring(0, 30) : report.getUserId();
				String urlWithParams = generateCheckupKeyUrl + "?userNo=" + userId + "&userNm=" + URLEncoder.encode(userNm, StandardCharsets.UTF_8.toString());

				RestTemplate restTemplate = new RestTemplate();
				ResponseEntity<String> response = restTemplate.exchange(urlWithParams, HttpMethod.GET, null, String.class);

				// API 응답 처리
				boolean checkupError = false;
				if (response.getStatusCode() == HttpStatus.OK) {
					String checkupKey = response.getBody();
					userInfo.setCheckupKey(checkupKey);
					userService.updateCheckupKey(userInfo);
				} else {
					checkupError = true;
				}

				// 검진결과 GRPC 등록 후, 분석에 소요되는 시간을 고려
				// 분석 완료 후 분석나이를 가져오고 저장하는 로직
				Thread.sleep(5000);
				// 분석 나이 API 호출
				boolean analysisError = grpcService.fetchAndProcessAnalysisAge(userInfo,true);

				/**  4. 정상 완료 시, T_WLK_REPORT에 해당 reportId를 바탕으로 연동상태 true 로 변경 */
				if(!analysisError && !checkupError) {
					userService.updateGRPCFlag(reportId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
